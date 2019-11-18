Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083F41F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 14:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfKROwQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 09:52:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46683 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfKROwP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 09:52:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id b3so19826466wrs.13
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 06:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tthrzn8mYYYkEiA4OuJ/Yvy0XQTl/eg8upU8R0wxKsk=;
        b=TG5k5RgMzzskNIx+k58pLENVWzUPrTHGBqEcye1bUz1kxZCrQfSVIi7HbU2H9IR6x2
         S5gh9ci+Pt8J81TYnYLwQzUVwtr/+gHMc04V3l5+k6ywjCYZytHiPCbLij3bax1yLedq
         T560yFvLaNPPhVWDH9CEdySPyG3DNA300KJQgEIL6kVPkj1JL3+vv6mYUCgjFTG3OJk6
         PG2Of/4oAqdYyDPUFRAHpC//peNlC/g3LboluupOfm8GNssoMReY7qoybfuW7qxD8rQV
         /Ba+3QpYchJcN15rHcdnsmFkEwpMsDZJPETQNAXsGz8wFa6C4Z5fLFdvdKxoZE9l8o2P
         bNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tthrzn8mYYYkEiA4OuJ/Yvy0XQTl/eg8upU8R0wxKsk=;
        b=dnmeI1+MLASqBSgLIpHzON1WMlH4FXk98S5BzDFuqOAneBPj/DMwy3ZkNRrPBskRk5
         OVsxOmAni+ob/VbgA6gCaC6orixF7pY5/rNcHlwMlVCrc2nB4kHT29PYC9eL1mFtXKhv
         CH/fDZs3frDMPLcEKug4bxK2SGihZTm53Aa6Cw82IP9+0ESWwkgmx/jtHuii+RvMZ/nP
         vzrFo2qMnDqk8a6WnDFQGmh+RsBV1Luu0GJg2APIQDFBbngq5HKzWRlbRfUw57FevKXw
         Hhpq9MwgX1H6lTTVJBKW+hRAl86llbRH1Tns1l4WNvcMFKvTPW4LTMAKcKpOXs/tQd/L
         9wTw==
X-Gm-Message-State: APjAAAWNd7oL72AGBDq2SS/bxPeW8LsH/wkMzynD4GQ7wpOel0EcHVrm
        D05dlC+xwq1SOGBs1NfnRl+m1wW/d0E=
X-Google-Smtp-Source: APXvYqyefXAo7w3frw+EeBAkx63BoC7L4AOPsBFfzJ5QPYMWUnlvv10zZ8ugYHG9VrWUP89Qan4mvA==
X-Received: by 2002:adf:e78c:: with SMTP id n12mr28449105wrm.94.1574088733381;
        Mon, 18 Nov 2019 06:52:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4sm23198249wrq.22.2019.11.18.06.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 06:52:12 -0800 (PST)
Message-Id: <pull.451.v4.git.1574088732.gitgitgadget@gmail.com>
In-Reply-To: <pull.451.v3.git.1573069152.gitgitgadget@gmail.com>
References: <pull.451.v3.git.1573069152.gitgitgadget@gmail.com>
From:   "erik chen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Nov 2019 14:52:11 +0000
Subject: [PATCH v4 0/1] fetch: add trace2 instrumentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add trace2 regions to fetch-pack.c to better track time spent in the various
phases of a fetch:

* matching common remote and local refs
* marking local refs as complete (part of the matching process)

Both of these stages can be slow for repositories with many refs.

Signed-off-by: Erik Chen erikchen@chromium.org [erikchen@chromium.org]

Erik Chen (1):
  fetch: add trace2 instrumentation

 fetch-pack.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-451%2Ferikchen%2Ftest12-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-451/erikchen/test12-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/451

Range-diff vs v3:

 1:  364c526a5d ! 1:  508d07a3eb fetch: add trace2 instrumentation
     @@ -6,7 +6,9 @@
          phases of a fetch:
      
              * matching common remote and local refs
     -        * marking local refs as complete (part of the matching process)
     +        * parsing remote refs and finding a cutoff
     +        * marking local refs as complete
     +        * marking complete remote refs as common
      
          Both of these stages can be slow for repositories with many refs.
      
     @@ -21,14 +23,28 @@
       
      +	trace2_region_enter("fetch-pack", "mark_complete_and_common_ref", NULL);
      +
     ++	trace2_region_enter("fetch-pack", "parse_remote_refs_and_find_cutoff", NULL);
       	for (ref = *refs; ref; ref = ref->next) {
       		struct object *o;
       
      @@
     + 		if (!o)
     + 			continue;
     + 
     +-		/* We already have it -- which may mean that we were
     ++		/*
     ++		 * We already have it -- which may mean that we were
     + 		 * in sync with the other side at some time after
     + 		 * that (it is OK if we guess wrong here).
     + 		 */
     +@@
     + 				cutoff = commit->date;
       		}
       	}
     ++	trace2_region_leave("fetch-pack", "parse_remote_refs_and_find_cutoff", NULL);
       
     -+	/* This block marks all local refs as COMPLETE, and then recursively marks all
     ++	/*
     ++	 * This block marks all local refs as COMPLETE, and then recursively marks all
      +	 * parents of those refs as COMPLETE.
      +	 */
      +	trace2_region_enter("fetch-pack", "mark_complete_local_refs", NULL);
     @@ -43,8 +59,17 @@
       
       	/*
       	 * Mark all complete remote refs as common refs.
     + 	 * Don't mark them common yet; the server has to be told so first.
     + 	 */
     ++	trace2_region_enter("fetch-pack", "mark_common_remote_refs", NULL);
     + 	for (ref = *refs; ref; ref = ref->next) {
     + 		struct object *o = deref_tag(the_repository,
     + 					     lookup_object(the_repository,
      @@
     + 		negotiator->known_common(negotiator,
     + 					 (struct commit *)o);
       	}
     ++	trace2_region_leave("fetch-pack", "mark_common_remote_refs", NULL);
       
       	save_commit_buffer = old_save_commit_buffer;
      +	trace2_region_leave("fetch-pack", "mark_complete_and_common_ref", NULL);

-- 
gitgitgadget
