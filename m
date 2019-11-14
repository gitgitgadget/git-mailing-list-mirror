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
	by dcvr.yhbt.net (Postfix) with ESMTP id F05321F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 20:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKNUrb (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 15:47:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43037 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfKNUrb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 15:47:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id 3so5087105pfb.10
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 12:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kT946VxvVnqZ2Q+xPonkqoTD2I85fZaMC9f+f87/VHk=;
        b=kUfKhd+YC++kUxQgzgoRIvWXuabg+doi60N12UTW/ohZMCtsOCPl8/6ojGlx6gisuG
         r4JyZ11jSmvAarOBg2U6lIjYMCtaxfo+QDGS9WndaU40yCSJCf7icyj60L4v8/zVkevo
         Qk0vDuzO/MWEx45Ni/rNP0Sv4PhXDjT4dBehIHC5Q9eQS1o6Ka4j6hrqoKDnkVCeSJ7s
         mR+1Msg2TxkPIwPAyMIpI1IjVONObtTpO7oCYH0j6hylUJLs9l8qoALrJup3zPy9Q4zW
         XqzRdYrGv5ALh3YnIOEBkcLGybi1jMkxvIjw/qwSBgDF9JFyuQjFu2OuoYR7/gcPFpsJ
         RTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kT946VxvVnqZ2Q+xPonkqoTD2I85fZaMC9f+f87/VHk=;
        b=Lilneb+9Z/B8/jEQlsCxvqDBd3l3tM6uuu72B32KVB8YPXyuXeHvlslAnZTwq/zLn2
         E52LkHE16Lge+UoWQtTRlPjDbh4ztVtI0SKpgxP1bXf12xzxb4iu61VIB72DsqOxsaeA
         /4eE9fGAkITpSUcRk+F2sKtvyej4lzBGRFjqIMzOxdTxEK1K3RQH6vlrAqH3+HRtBBME
         NShR72PkPJ7czNq/bKEAD0lcJtvP4s8uRRUGF5IUM1x0/bt250J5odLkfIMn9IBnoQ0j
         UP5wQByJgj94Vy+l5Y5dWil+TD024D515vJKmdi1Z5oWkxYA7cHeej8PKAyHY49kdXP7
         Xjnw==
X-Gm-Message-State: APjAAAUdDKpeAfq01Hqa0xjZqL6PT7VYYDH4bkqyNwF9okqZ8dI9VBFo
        VIYs3PkUD+XLahOTVeXW46lUqRyV
X-Google-Smtp-Source: APXvYqzftD63C38zOeSCL9hJZrn4AukCFLQqorguiJYrOxWnw2c2dkr29hj3yZD3H4+mYt/4Qz+o+A==
X-Received: by 2002:a63:4961:: with SMTP id y33mr12544452pgk.264.1573764450155;
        Thu, 14 Nov 2019 12:47:30 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id x21sm6968614pfi.122.2019.11.14.12.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:47:29 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:47:28 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 10/10] SubmittingPatches: use `--pretty=reference`
Message-ID: <5f80e4633dcd37e6559e079d7bd679bc398da3e2.1573764280.git.liu.denton@gmail.com>
References: <cover.1573241590.git.liu.denton@gmail.com>
 <cover.1573764280.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573764280.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Git was taught the `--pretty=reference` option, it is no longer
necessary to manually specify the format string to get the commit
reference. Teach users to use the new option while keeping the old
invocation around in case they have an older version of Git.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/SubmittingPatches | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 7860dd2568..4515cab519 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -153,6 +153,12 @@ The "Copy commit summary" command of gitk can be used to obtain this
 format (with the subject enclosed in a pair of double-quotes), or this
 invocation of `git show`:
 
+....
+	git show -s --pretty=reference <commit>
+....
+
+or, on an older version of Git without support for --pretty=reference:
+
 ....
 	git show -s --date=short --pretty='format:%h (%s, %ad)' <commit>
 ....
-- 
2.24.0.346.gee0de6d492

