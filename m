Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 613BB202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 02:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965957AbdIZCkB (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 22:40:01 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36439 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935837AbdIZCkA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 22:40:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id f84so4416132pfj.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 19:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V2USGXs+ikZxIzfv1C3lepZMkTGCWkXrseVjPq10DNk=;
        b=EQUdwFjzC/QEJXJgK6cJReYPclB0cU7CyZgO0OpHQ29wCuwBuul4AtOHpE4nFLHzJl
         uozruNj4FwGjT/kROgT9QZInv3122UZK0PajrBehb5PEaUhk9wH/dZqzlderqjvl1M6J
         soQfRcUBGI85YWUfAZC1VNL3fvcbB6fyHGrR2f3TcvXMCAkkYwwKRhTPvk8KN2yJH9Uf
         gp7GifohFYouGbz+uF2GYwCEIWT+oSuT67E6rQ3NE9SAcgj9J7mkcS7zA01eJF/pP3Hk
         P9q7RgngsM2fC9wtp8GNDywlzSBSuE8nxslVoLgoTBYNtYKmgdWVDEpsTWGKzfa94dQX
         doZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V2USGXs+ikZxIzfv1C3lepZMkTGCWkXrseVjPq10DNk=;
        b=VxZPEE4pVw7Dc0k32kfInFjTm6MoyXvWnKMN5GpSrwhPzPdjeHfJsWRmcO+XrdiGiW
         uB67DRAfiy5kP2kVZzA3wCXyGwBBqS0tDfDcRFnCqFbUVATkqu2X+PmIUBCwty5680kK
         F5TppL9/o80JsvSIlJ16Cfg71/tAwIbJrUVbQ/JDv1ssF1LedPcFpDyUi2YCSQI1A/3v
         uhJtBD1ULUzwr4suDDtvQG18jWPZOT9tR9hbNr9N6zMKH3Rvfgr2wPUbLizrjmPVYgnp
         Ut8wB7LY4vaQFYGbVIht3EuE4DzZee4AKteBNELzh1vtIT9jcqy7AB3FYTtBzwBEzPqY
         1moQ==
X-Gm-Message-State: AHPjjUj+6tsqmjHXZrjaJpVB0JC+PmKnYkyzVTXkT7y8Kl9kw87VWaXv
        q/Vla7QVLJbVzXdRbp6oKWg=
X-Google-Smtp-Source: AOwi7QDtXAZOWhTHYUp6Shomhdc+VTOleDglP0BLo1F9BRS7qmFZw4TlSpedV6iooB7vxZSXgbFlAg==
X-Received: by 10.84.143.129 with SMTP id 1mr9559830plz.304.1506393599605;
        Mon, 25 Sep 2017 19:39:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8cad:f525:a0b8:9738])
        by smtp.gmail.com with ESMTPSA id d12sm13803869pgn.53.2017.09.25.19.39.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 19:39:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: -X theirs does not resolve symlink conflict  Was: BUG: merge -s theirs  is not in effect
References: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
        <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
        <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
        <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com>
        <20170925143040.4qgofxcdahal46r7@hopa.kiewit.dartmouth.edu>
        <xmqqing6cje7.fsf@gitster.mtv.corp.google.com>
        <xmqqefqucigh.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 26 Sep 2017 11:39:57 +0900
In-Reply-To: <xmqqefqucigh.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 26 Sep 2017 11:16:46 +0900")
Message-ID: <xmqqa81ichdu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I do not recall people talking about symbolic links but the case of
>> binary files has been on the wishlist for a long time, and I do not
>> know of anybody who is working on (or is planning to work on) it.
>
> Ah, I misremembered.
>
> We've addressed the "binary files" case back in 2012 with a944af1d
> ("merge: teach -Xours/-Xtheirs to binary ll-merge driver",
> 2012-09-08).  I do not know offhand if it is just as easy to plumb
> the MERGE_FAVOR_{OURS,THEIRS} bits thru the symbolic link codepath,
> like that patch did to the binary file codepath.

Perhaps the attached (totally untested) patch might be a good
starting point.  I do not know if you are interested in hacking on
Git, and I do not feel offended if you are not, but perhaps somebody
else might get interested in seeing if this #leftoverbits is a good
direction to go in, and finishing it with docs and tests if it is
;-)


 merge-recursive.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1d3f8f0d22..3605275ca3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1026,10 +1026,19 @@ static int merge_file_1(struct merge_options *o,
 						       &b->oid,
 						       !o->call_depth);
 		} else if (S_ISLNK(a->mode)) {
-			oidcpy(&result->oid, &a->oid);
-
-			if (!oid_eq(&a->oid, &b->oid))
-				result->clean = 0;
+			switch (o->recursive_variant) {
+			case MERGE_RECURSIVE_NORMAL:
+				oidcpy(&result->oid, &a->oid);
+				if (!oid_eq(&a->oid, &b->oid))
+					result->clean = 0;
+				break;
+			case MERGE_RECURSIVE_OURS:
+				oidcpy(&result->oid, &a->oid);
+				break;
+			case MERGE_RECURSIVE_THEIRS:
+				oidcpy(&result->oid, &b->oid);
+				break;
+			}
 		} else
 			die("BUG: unsupported object type in the tree");
 	}
