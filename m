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
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2951F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfKOBBc (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37509 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfKOBBb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:31 -0500
Received: by mail-pg1-f196.google.com with SMTP id z24so4900922pgu.4
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Q7H3cXmcRuFkQWI3FdwJ/pbVf5wb7wm0nF8kPSimDw=;
        b=IDImvDZIiZHM608PnQ7mAk+Zzbxn+S3u5moleakLStXW0SRbigEaFAnWaXRuLPGIFF
         L9uLmVhJK2ey06qM+edo2OuewyzOI3OIx0A7KmBC269nVEQexjX74zj9rbQRoGNcBRry
         DjBOWy2OThZVoL8e0GFpAcmsxhNL3zZ3YUJZY3n3Q/GcUJPGVbtzSS3QokjF5gReUGKL
         7eZbHGThUSCei3owEyfD1m1o2LQ4HuOaZXxg7JLzFAwCSHD4zpdvAxBtbkvPcKd0Nnkr
         FTANbLTygLYyqBxWGe+52mhwa3OI5c0gt/cKuts74IXztEuEOqyIgThXKM7EOI91Z5hy
         Hc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Q7H3cXmcRuFkQWI3FdwJ/pbVf5wb7wm0nF8kPSimDw=;
        b=tAYrwiDYDcR46gmu+XtgQpA8BXm5huLVGY/iJRow5mFja++nLLNQCT9hljHl8RrPyW
         4FaShumaqIqAPf1J3bpSpxPQnevxhHJAH4a2Osf/29P16kXiQN5+uIeuj548aTpEKXm7
         4prqLBaDzxxr1e8VvWZbX0Q4aMaHVa5R0epAY9zOoTVVLY0PHIBXUqjAt74/Cma3G5fq
         EZapHHr2+nzx7nRCdflxjRfCpoA6bmnZ9EZ4DQMiSv1OXDwRnNtZv8wj6iKLKIQM20Iv
         ZUtu1WXmVyy7XskzvHYtlX3/6XK4O2i//dpZiXnz8alKOe7Qw7u1Lgj0ez5Cp47WlAcU
         Pg3g==
X-Gm-Message-State: APjAAAU8D4GaC4Q3C0umOKIVEKWq8/PXkCHStN8j6N2Pu6B/2RXi2g+v
        obxfJKGvN4rwaWf4i8SE0NFr1vcG
X-Google-Smtp-Source: APXvYqw10Eou/HPsax6E6/QPvy3saJO/prrK5Lt2VcOVjOXoW142WAIFFq68/gEjW+E0tSgzM1XZJw==
X-Received: by 2002:a17:90a:fa02:: with SMTP id cm2mr15345178pjb.141.1573779690336;
        Thu, 14 Nov 2019 17:01:30 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id z63sm7707771pgb.75.2019.11.14.17.01.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:01:29 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:01:28 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 25/27] t5703: mask failing grep status
Message-ID: <d259d55656140a3c35c8585b093afac13a49e5c6.1573779466.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch, we plan on running tests with `set -o pipefail`.
However, since grep can return failure in the case that no lines are
matched, this can trigger a failure in a pipe in the case where grep is
being used as a filter.

Use test_grep_return_success() instead of grep so that we don't fail
even if we have no matching lines.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5703-upload-pack-ref-in-want.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 9f6d837720..c4f9698398 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -19,7 +19,7 @@ get_actual_commits () {
 		}' <out | test-tool pkt-line unpack-sideband >o.pack &&
 	git index-pack o.pack &&
 	git verify-pack -v o.idx >objs &&
-	grep commit objs | cut -c-40 | sort >actual_commits
+	test_grep_return_success commit objs | cut -c-40 | sort >actual_commits
 }
 
 check_output () {
-- 
2.24.0.399.gf8350c9437

