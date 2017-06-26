Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98EFB207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 22:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbdFZWiS (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 18:38:18 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34549 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbdFZWiR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 18:38:17 -0400
Received: by mail-pf0-f195.google.com with SMTP id d5so2056653pfe.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 15:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=K9GP/DpMVxzsfcvRWWexUkuDEV54QQfI3XLQroWvS7k=;
        b=ItyE4zwxbTba8TSQOZnePlLm7k+XnPsrURrEyEQxPY+yqBt+zD1T8PJ+k/U2rLyrG9
         +pKCnNNIFE8KKMXhp7O6YSZh2nq9OcylnTS/t0r0jNZb6I/L/gZo0M+VMZYCGLC7H/NT
         /5hX1Q7DbCnu/bP2QbBKduHhcJZqy40y8vZHT8eO6etSAMVQvXINAfqhycTrN2glAuDG
         LMF5eC6mzh8AHuQLUcr3EuIbwyg1n2kkltAOSPmj/1M8aJQz3tg2HbhpUVdvvJ+EUUjm
         zGozXLuakyF2GIYcKHIkOfs5A+GzPmV/UUctEMucm3uxhete/ig5FIfAATvjYMPre0qk
         Nr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=K9GP/DpMVxzsfcvRWWexUkuDEV54QQfI3XLQroWvS7k=;
        b=aDw0PkY6RvGxzQihHDX6/FPSroRHvsAIFatkJKBJAD8f7jhnpzCQDf2v1X4kENiN+K
         flwSU7cEd5S2vc7MS257EPjscIXfEh+xg5QffInnVSxXUhb6pfI7vJIYsw1zaUE8xX/w
         fOoF4F5rmMwh6s5W91NzRp/MTxqyz+UuRd9vPJvEJBXQBJ4GnClVHLkIu/tXP1y5FXN+
         /gV0/doYpd6qmEFMMSRc9DeqmE+q3y4oLUwvD31BIeYQmz6s8O43nPiRVamuGsT3dtgQ
         VJ9t86N2np5uDWPJEKB8vCsExyFVXx5zPdd1z5xfjIcnK1eJaUh0I8HiZmOAz+afgdLa
         6aZg==
X-Gm-Message-State: AKS2vOxKX5rwtLOYvmA2aCgzJvBHnnrFqSgjtoK6HQ7gDhnjWpiJsMpj
        Kkr3xnQ54+KMfyOp6XI=
X-Received: by 10.99.120.199 with SMTP id t190mr2252337pgc.176.1498516696751;
        Mon, 26 Jun 2017 15:38:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b537:cc1a:8e81:b9ca])
        by smtp.gmail.com with ESMTPSA id v17sm1964846pgn.4.2017.06.26.15.38.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 15:38:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v6 6/6] convert: add "status=delayed" to filter process protocol
References: <20170625182125.6741-1-larsxschneider@gmail.com>
        <20170625182125.6741-7-larsxschneider@gmail.com>
        <xmqqzicu4lnq.fsf@gitster.mtv.corp.google.com>
        <F72755BA-6296-4C37-9EFA-4D7BCE9F1082@gmail.com>
        <xmqqa84u4cuk.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 26 Jun 2017 15:38:13 -0700
In-Reply-To: <xmqqa84u4cuk.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 26 Jun 2017 15:13:07 -0700")
Message-ID: <xmqqzicu2x4a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>>> +				filter->string = "";
>>>> +				continue;
>>>> +			}
>>>> +
>>>> +			/* In dco->paths we store a list of all delayed paths.
>>>> +			   The filter just send us a list of available paths.
>>>> +			   Remove them from the list.
>>>> +			*/
>>>> +			filter_string_list(&dco->paths, 0,
>>>> +				&remove_available_paths, &available_paths);
>>> 
>>> We first remove from the outstanding request list (dco->paths) what
>>> are now ready...
>>> 
>>>> +			for_each_string_list_item(path, &available_paths) {
>>> 
>>> ...and go over those paths that are now ready.
>>> 
>>>> +				struct cache_entry* ce = index_file_exists(
>>>> +					state->istate, path->string,
>>>> +					strlen(path->string), 0);
>>>> +				assert(dco->state == CE_RETRY);
>>>> +				errs |= (ce ? checkout_entry(ce, state, NULL) : 1);
>>>> +			}
>>> 
>>> But we never checked if the contents of this available_paths list is
>>> a subset of the set of paths we originally asked the external
>>> process to filter.
>>
>> Correct.
>>
>>>  This will allow the process to overwrite any
>>> random path that is not even involved in the checkout.
>>
>> No, not "any random path". Only paths that are part of the checkout.
>
> Isn't it "any path that index_file_exists() returns a CE for".  Did
> you filter out elements in available_paths that weren't part of
> dco->paths?  I thought the filter-string-list you have are for the
> other way around (which is necessary to keep track of work to be
> done, but that filtering does not help rejecting rogue responses at
> all).

That is, something along the lines of this on top of the series.
When going over the list of delayed paths to see if any of them is
answered, in remove_available_paths(), we mark the util field of the
answered one.  Later when we go over the list of answered one, we
make sure that it was actually matched with something on dco->paths
before calling checkout_entry().

 entry.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/entry.c b/entry.c
index c6d5cc01dc..f2af67e015 100644
--- a/entry.c
+++ b/entry.c
@@ -150,7 +150,12 @@ void enable_delayed_checkout(struct checkout *state)
 static int remove_available_paths(struct string_list_item *item, void *cb_data)
 {
 	struct string_list *available_paths = cb_data;
-	return !string_list_has_string(available_paths, item->string);
+	struct string_list_item *available;
+
+	available = string_list_lookup(available_paths, item->string);
+	if (available)
+		avaiable->util = (void *)item->string;
+	return !available;
 }
 
 int finish_delayed_checkout(struct checkout *state)
@@ -192,9 +197,16 @@ int finish_delayed_checkout(struct checkout *state)
 				&remove_available_paths, &available_paths);
 
 			for_each_string_list_item(path, &available_paths) {
-				struct cache_entry* ce = index_file_exists(
-					state->istate, path->string,
-					strlen(path->string), 0);
+				struct cache_entry* ce;
+
+				if (!path->util) {
+					error("filter gave '%s' which was unasked for",
+					      path->string);
+					errs |= 1;
+					continue;
+				}
+				ce = index_file_exists(state->istate, path->string,
+						       strlen(path->string), 0);
 				assert(dco->state == CE_RETRY);
 				errs |= (ce ? checkout_entry(ce, state, NULL) : 1);
 			}
