Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A5BD1F406
	for <e@80x24.org>; Mon, 25 Dec 2017 19:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbdLYTp1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 14:45:27 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33576 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbdLYTp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 14:45:26 -0500
Received: by mail-wm0-f41.google.com with SMTP id g130so33941268wme.0
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 11:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Js/apjscxcHAVvy2kdPKW4YkbQUgPwUetWPFpE6JdN4=;
        b=In1QqZlLltZu/+IxLdTWzSffZA55C5QHdNktUW9X+4FSwbO0pydIDDRSdIMHfDzRjg
         /9mjfhiCWcvmscVf5u4o9dUbp0exv2+p4Q9eLyinvfnivtkdpeEcKc8HNSPEDk65UgA8
         d8V4ZDuBpMVfXpa0BD456YVXfAjjOx4N/NgEgb15xYBBKC4wZJ/YqPYJ6TItYtBsrx+8
         CYwsl70Nsdi/kBrx/pGaysXTlMVYBTWZIb6ESHefEvs8XwF3Oz8FHukGwz03mbZXFO9/
         SMn5gLQt2Mzfx1xMA9c/K77GOdn5T2b1SHqk7+pGyv/barBsqb+19Edk5Tr5/tXCAw6J
         FB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Js/apjscxcHAVvy2kdPKW4YkbQUgPwUetWPFpE6JdN4=;
        b=JnG12riOIgf9UyLrAyY56miblN4MEk1zuHtHkR0aKBKjmZSxwg6PHzLd/Zf9Am18rn
         RrHcbLz2+RvDPgWmc1Bh26n6W92vEaF/O6iNcEw1ym56U8XJ6RzUiva8XWfExtXE9UiD
         ViNFTE72ZUMn2Eb5CDw2uOkcMKYJT/YezDcylMWM2cPUCbDGPoHU2m7I9be+KaDPNexU
         8bqu494YQXi7F2xZGPPAe0XXHkefKQxJrdJlAnCcyhChc+VtcJ2Shl7uhZ06OlrFk/Nt
         KUBeIXhRQ8Y60D0eMsRznM6TPcBbX6wurYbUBvDVhNCFlOnBqPpyOtSHo7oLk6ZR9/7R
         bXvw==
X-Gm-Message-State: AKGB3mLRP/t+bRlvbWqtgQiJvDgfhJLMXPpuCvpfzIhsJkQ/twD11yRd
        2IJL3MCh2FS7EpNKcrkI7UFT5M/W
X-Google-Smtp-Source: ACJfBouV6Ka/ZXT3Y7jvO2EKD09kux2WXjwQ/fcaFJhH++Q6Ro86YxBZjxdBAX8F9eSn0B4JRpFsJQ==
X-Received: by 10.80.181.49 with SMTP id y46mr27511756edd.29.1514231124568;
        Mon, 25 Dec 2017 11:45:24 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id b2sm28243090edd.26.2017.12.25.11.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2017 11:45:23 -0800 (PST)
Subject: Re: [PATCH] status: handle worktree renames
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     alexmv@dropbox.com, git@vger.kernel.org
References: <alpine.DEB.2.10.1712221829430.29746@alexmv-linux>
 <20171225103718.24443-1-pclouds@gmail.com>
 <b3e90960-d743-3299-ba43-150849b591d2@gmail.com>
Message-ID: <86b4d2af-18ce-36eb-4823-105757a196fc@gmail.com>
Date:   Mon, 25 Dec 2017 20:45:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <b3e90960-d743-3299-ba43-150849b591d2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/12/2017 19:26, Igor Djordjevic wrote:
> 
> But I`ve noticed that "--porcelain=v2" output might still be buggy - 
> this is what having both files staged shows:
> 
>     $ git status --porcelain=v2
>     2 R. N... 100644 100644 100644 12f00e90b6ef79117ce6e650416b8cf517099b78 12f00e90b6ef79117ce6e650416b8cf517099b78 R100 new-file	original-file
> 
> ..., where having old/deleted file unstaged, and new/created file 
> staged with `git add -N` shows this:
> 
>     $ git status --porcelain=v2
>     1 .R N... 100644 100644 100644 12f00e90b6ef79117ce6e650416b8cf517099b78 12f00e90b6ef79117ce6e650416b8cf517099b78 new-file
> 
> So even though unstaged value is correctly recognized as "R" (renamed), 
> first number is "1" (instead of "2" to signal rename/copy), and both 
> rename score and original file name are missing.

As an exercise, might be something like this as a fixup on top of 
your patch could work.

I`ve tried to follow your lead on what you did yourself, but please 
note that, besides being relatively new to Git codebase, this is my 
first C code for almost 10 years (since university), so... :)

I guess an additional test for this would be good, too.

Regards, Buga

---
 wt-status.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index f0b5b3d46..55c0ad249 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2050,7 +2050,7 @@ static void wt_porcelain_v2_print_changed_entry(
 	const char *path_head = NULL;
 	char key[3];
 	char submodule_token[5];
-	char sep_char, eol_char;
+	char sep_char, eol_char, score_char;
 
 	wt_porcelain_v2_fix_up_changed(it, s);
 	wt_porcelain_v2_submodule_state(d, submodule_token);
@@ -2059,6 +2059,8 @@ static void wt_porcelain_v2_print_changed_entry(
 	key[1] = d->worktree_status ? d->worktree_status : '.';
 	key[2] = 0;
 
+	path_head = d->head_path ? d->head_path : d->worktree_path;
+	score_char = d->index_status ? key[0] : key[1];
 	if (s->null_termination) {
 		/*
 		 * In -z mode, we DO NOT C-quote pathnames.  Current path is ALWAYS first.
@@ -2067,7 +2069,6 @@ static void wt_porcelain_v2_print_changed_entry(
 		sep_char = '\0';
 		eol_char = '\0';
 		path_index = it->string;
-		path_head = d->head_path;
 	} else {
 		/*
 		 * Path(s) are C-quoted if necessary. Current path is ALWAYS first.
@@ -2078,8 +2079,8 @@ static void wt_porcelain_v2_print_changed_entry(
 		sep_char = '\t';
 		eol_char = '\n';
 		path_index = quote_path(it->string, s->prefix, &buf_index);
-		if (d->head_path)
-			path_head = quote_path(d->head_path, s->prefix, &buf_head);
+		if (path_head)
+			path_head = quote_path(path_head, s->prefix, &buf_head);
 	}
 
 	if (path_head)
@@ -2087,7 +2088,7 @@ static void wt_porcelain_v2_print_changed_entry(
 				key, submodule_token,
 				d->mode_head, d->mode_index, d->mode_worktree,
 				oid_to_hex(&d->oid_head), oid_to_hex(&d->oid_index),
-				key[0], d->score,
+				score_char, d->score,
 				path_index, sep_char, path_head, eol_char);
 	else
 		fprintf(s->fp, "1 %s %s %06o %06o %06o %s %s %s%c",
-- 
2.15.1.windows.2
