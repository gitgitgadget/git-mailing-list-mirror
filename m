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
	by dcvr.yhbt.net (Postfix) with ESMTP id 747681F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfKOBAh (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:00:37 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38699 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfKOBAg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:00:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id 15so4892799pgh.5
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V6QgC7/rLpGvayXAfDKeI0CEdfefXitGVlwOpzb6H1k=;
        b=NG68j9kUFOToGtfF6WMvqbajj9zHsXItCGR25eFYaNTPvfKNyyMu+Jb7O5Dm7a/NEf
         BszeLKL6B4VA8mDhaxKvknUeXP3GQSHxMdlB+lSV95dg9Y8AQmGF1YZkdIt+aLaFa5QL
         AldEe+FuD9jnl+75MBjrh51928WArAXzOQqc7pWkYiaKGXJX69k9yVodUzGVZd3/SzND
         q8O525UX79g9lMVW8pa9IM4N5yWpByQnW9Zl1+AXI8Qdp7ZBi5tzGr62NUny3485tzhP
         YKu/TlOLeIbGi316ZP03wHkRui8O5ziu8zEXtvCFmYtawJxxjavAWQ9YKamu8uYbtpjO
         Lr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V6QgC7/rLpGvayXAfDKeI0CEdfefXitGVlwOpzb6H1k=;
        b=VPeJaYJCuMxez3kWygAYc4GNscpyhVb4J3v2AwoMYl7fRA6Iw/voGCGFMS/oiGRMVo
         K4E1ifj9nMBjn4pLZOwqPdpZd6AAaV6noJfYxQfmtNhiuZllMVctpElwCfgxUyH4mWM3
         XpY0Hj9eEmqXvg1bcvERkj117sbshL3daHxIMNO76I+BpxHqF+NSqnC2f4w2XP7l+aMA
         PGBt47k+bBSWlDFXYe0POcWz9j6BYmX/4MnWMhrLIEiF0ROr3LPsyst4yan7JO+uYMzY
         yaqkCLux1rulA6RmDn3J/sQSBrp3bO4yKOd/upcmAV7jmvPWrEQHHXYjpmrG4Vxs0wts
         sH0Q==
X-Gm-Message-State: APjAAAU7P6RE0Abhc77Q0OMeSVnNJ/leE3ewH4KWq8ExBcm3c1CUGq2m
        CochyZC93KA4rFRh1CW9PVaC8r/j
X-Google-Smtp-Source: APXvYqz/uCwvGnHE/qZgDtQ4jwY+4PYegspcrn/25tJbuLYPvCmqK2zbl8TWMACN0je+uQCh3OGMPg==
X-Received: by 2002:aa7:961d:: with SMTP id q29mr13763207pfg.89.1573779635289;
        Thu, 14 Nov 2019 17:00:35 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id g3sm7521438pfo.82.2019.11.14.17.00.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:00:34 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:00:33 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 01/27] lib-bash.sh: move `then` onto its own line
Message-ID: <b4442fb408c80cf6c4d8fd05b474c0094e243126.1573779465.git.liu.denton@gmail.com>
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

The code style for tests is to have statements on their own line if
possible. Move the `then` onto its own line so that it conforms with the
test style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-bash.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/lib-bash.sh b/t/lib-bash.sh
index 2be955fafb..6a2c21cd24 100644
--- a/t/lib-bash.sh
+++ b/t/lib-bash.sh
@@ -2,7 +2,8 @@
 # to run under Bash; primarily intended for tests of the completion
 # script.
 
-if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
+if test -n "$BASH" && test -z "$POSIXLY_CORRECT"
+then
 	# we are in full-on bash mode
 	true
 elif type bash >/dev/null 2>&1; then
-- 
2.24.0.399.gf8350c9437

