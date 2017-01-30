Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C775A20D13
	for <e@80x24.org>; Mon, 30 Jan 2017 22:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbdA3W5S (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 17:57:18 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33487 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752722AbdA3W5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 17:57:17 -0500
Received: by mail-pf0-f195.google.com with SMTP id e4so24453640pfg.0
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 14:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rCN8cfblAHq5PhghR9FPsfFiGAWKfKtJx2T3X3ncf8E=;
        b=m6q8g49X5kkuYQJwK+Bic6n599Y97tY11XtN+HsmFLVbqKds6/v7syvLxtyN1r7dID
         H9jH0vOzsJw1EXnaEUgc2UXTO+/5qgB+HLIaATCvCH4PWq6A4cok2DiALlQI1nlx02hl
         wkQh7f3m4wMBxxXXp+9nUxel2KyZpZ4T23SvaQarZ5m+QZh2/+l1/ecdrSq8QTsNid0a
         0TWBcqoA3zk1HJ+ExqYww+fPfi8COYOAR9NGwRz0iatksshhGkiZpKzTQ293cYJTBXiq
         m8bKdKlBheDiUkBkrAvlo3tnKx20TP2Z8K3QbDFfa0AXqwXKsIskNGFtQTesyawA3QBw
         jm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rCN8cfblAHq5PhghR9FPsfFiGAWKfKtJx2T3X3ncf8E=;
        b=dGY3S0UqSdHiF1DwWmGNaR7G0qzrMS1QwKf3M4CdnHwbd31oDT8TtQX/zn9KznbZU5
         lBZMRdWwFDvprlJeZoy1zfN42wjLPGA+CzARMqvTkFulTwUz3wNGuPTPIdi3HONlcQo+
         yiW7mjcU7Jdju+bMxzxoCjhWmM/nP7yhUtWNFQs9G/4PoJTZsQeYSJTeyccmLUUnIGeq
         BITr7oYWj8c4k2PiDcnfGcMPv7OSIz076O/67oCpCdd4lHRfIdnpC2zWCsKVJP7LYa5q
         OL1qZeQ0N5EvBIXWiFnm6fKSYyb3ZG50JBfgk+eH3L56Hn0slZTrp5h4d+t695Hvy6ts
         +f3Q==
X-Gm-Message-State: AIkVDXKkrAFF5bof91O5hN1V+cotnzrnMX262nhI5ngnIrxA84s08AVehPLgsTzLntaN1Q==
X-Received: by 10.84.232.141 with SMTP id i13mr35001147plk.119.1485817037137;
        Mon, 30 Jan 2017 14:57:17 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a9ce:56f8:45fd:fc63])
        by smtp.gmail.com with ESMTPSA id 191sm35212847pgd.40.2017.01.30.14.57.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 14:57:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     cornelius.weig@tngtech.com
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] refs: add option core.logAllRefUpdates = always
References: <xmqqvat11k1i.fsf@gitster.mtv.corp.google.com>
        <20170127100948.29408-1-cornelius.weig@tngtech.com>
        <20170127100948.29408-2-cornelius.weig@tngtech.com>
        <xmqq37g0us5p.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 30 Jan 2017 14:57:15 -0800
In-Reply-To: <xmqq37g0us5p.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 30 Jan 2017 13:58:10 -0800")
Message-ID: <xmqq8tpstaus.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index bfe685c..81ea2ed 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -612,14 +612,12 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>>  	const char *old_desc, *reflog_msg;
>>  	if (opts->new_branch) {
>>  		if (opts->new_orphan_branch) {
>> -			if (opts->new_branch_log && !log_all_ref_updates) {
>> +			const char *refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
>> ...
>>  				if (ret) {
>>  					fprintf(stderr, _("Can not do reflog for '%s': %s\n"),
>>  						opts->new_orphan_branch, err.buf);
>
> Here you need to have another free(), as this block makes an early
> return and you end up leaking refname.

I am building with the attached patch squashed on top.  

The extra free(refname) is to plug the leak I pointed out, and the
type of refname is no longer const, because "const char *" cannot be
free()d without casting, and in this codepath I do not see a reason
to mark it as const.

When queued on top of 4e59582ff7 ("Seventh batch for 2.12",
2017-01-23), however, this fails t2017#9 (orphan with -l makes
reflog when core.logAllRefUpdates = false).

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 81ea2eda99..e1a60fd8ea 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -612,7 +612,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	const char *old_desc, *reflog_msg;
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
-			const char *refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
+			char *refname;
+
+			refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
 			if (opts->new_branch_log && should_autocreate_reflog(refname)) {
 				int ret;
 				struct strbuf err = STRBUF_INIT;
@@ -622,6 +624,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 					fprintf(stderr, _("Can not do reflog for '%s': %s\n"),
 						opts->new_orphan_branch, err.buf);
 					strbuf_release(&err);
+					free(refname);
 					return;
 				}
 				strbuf_release(&err);
