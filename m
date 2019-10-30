Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C41C51F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 18:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfJ3SGL (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 14:06:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42994 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfJ3SGL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 14:06:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id 21so2108431pfj.9
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AdQfVOuBlyc3ryryYBzBZhS+FjX6X4ONwmP9J5zkYy0=;
        b=MmpQ7UYgZwJTtc96T58cdv281wbTAkOWKHCqBBjXn3eTikR9XT6SkvCieePKqhT+wE
         OidIPKF5IZe8Nt+lSyG5T7Gga0twrsT/Xm7V6OI5jZvIkgGHmoSN4yyEYopv92y6fl2d
         Oqjo9KaLSmfsZJduCnaZUh2cHc5n2PiQsQS3nOfAATbw0lTZrCE47GhoZV2xFCYVmhRv
         zg+JY+Yr361OGZ6vUXPzCk2b1nue1i3RCd/iFf4byO2DPETL+MXY55eo/EdPehPTkkra
         Yb5Q0Qm6As4mIoXulQ0A/EfLuh/y0xrXRbryhrHXuAZjNUkAmujeRU4I3h9oyjtLT9Ey
         n0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AdQfVOuBlyc3ryryYBzBZhS+FjX6X4ONwmP9J5zkYy0=;
        b=p/rMlKwoU3lG+h1fQNJis51ZxuXloWz7v90RemvPOCoNlG6HnQ2QZs0a/+q11ltqya
         qTBPazwPoPJmE/rUq9ol+M1o3W6bfMOhKBzzV+QAd5MiG9PVzdQiouaOksKiCCfla3+W
         DELhJTtDphRSvc7uQnfcBaRrmsVTDx7YGQnxQOI6LJhSZ5oEe8B/waKm3kjd28zqs07H
         V81kUY/j89L9/UjZ7+nkmTtTd9lTY8fJsBeAct+DAeI5Fu6evoq6JcnZd/Vnbhk/yMP5
         nyRcDTpB629808+m2WJNuwi4sTeRUfiNE/a6bGgLgqZtEbKWGCj5t7pdijBqg/2NlcxE
         a25g==
X-Gm-Message-State: APjAAAWWxVMoOOSABAyQleepHfrY9eBbBJMs2mihrjSKmd3VfQZ0STzv
        OZbQ6Z/lRt9N+M8hM0ZKKLOC1OPh
X-Google-Smtp-Source: APXvYqzoYt2v1V18vh4megmqxRaqvlGWFVCFb75i/sWdS+cRNVg4eUsialpAQ9Hu1ceS5jvlPlPmdA==
X-Received: by 2002:a62:30c5:: with SMTP id w188mr633723pfw.105.1572458770166;
        Wed, 30 Oct 2019 11:06:10 -0700 (PDT)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id y24sm655334pfr.116.2019.10.30.11.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:06:08 -0700 (PDT)
Date:   Wed, 30 Oct 2019 11:06:07 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3] git-diff.txt: document return code of `--no-index`
Message-ID: <381b2ca134ffa2f370c3882631dbaf3d591530dc.1572458622.git.liu.denton@gmail.com>
References: <ed9f16c30a0f3852abaf0053d8c2b4a0ecd12f01.1572367897.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9f16c30a0f3852abaf0053d8c2b4a0ecd12f01.1572367897.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Within diff_no_index(), we have the following:

	revs->diffopt.flags.exit_with_status = 1;

	...

	/*
	 * The return code for --no-index imitates diff(1):
	 * 0 = no changes, 1 = changes, else error
	 */
	return diff_result_code(&revs->diffopt, 0);

Which means when `git diff` is run in `--no-index` mode, `--exit-code`
is implied. However, the documentation for this is missing in
git-diff.txt.

Add a note about how `--exit-code` is implied in the `--no-index`
documentation to cover this documentation blindspot.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Thanks for catching the typo, Phillip. I can't believe I missed that in
such a simple patch.

Range-diff against v2:
1:  ed9f16c30a ! 1:  381b2ca134 git-diff.txt: document return code of `--no-index`
    @@ Documentation/git-diff.txt: two blob objects, or changes between two files on di
      	at least one of the paths points outside the working tree,
      	or when running the command outside a working tree
     -	controlled by Git.
    -+	controlled by Git. This form implies `--no-exit`.
    ++	controlled by Git. This form implies `--exit-code`.
      
      'git diff' [<options>] --cached [<commit>] [--] [<path>...]::
      

 Documentation/git-diff.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 72179d993c..37781cf175 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -36,7 +36,7 @@ two blob objects, or changes between two files on disk.
 	running the command in a working tree controlled by Git and
 	at least one of the paths points outside the working tree,
 	or when running the command outside a working tree
-	controlled by Git.
+	controlled by Git. This form implies `--exit-code`.
 
 'git diff' [<options>] --cached [<commit>] [--] [<path>...]::
 
-- 
2.24.0.rc1.251.gd52a1e41a1

