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
	by dcvr.yhbt.net (Postfix) with ESMTP id D9AFD1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 00:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfKSAVV (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 19:21:21 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:39975 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSAVU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 19:21:20 -0500
Received: by mail-pf1-f173.google.com with SMTP id r4so11195067pfl.7
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 16:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V/Xvl0eXD4VJWM8ETZPaNNud6m6t4zcVuyNNpdOgtQM=;
        b=HITQHRydhDYTMplcrmpQoioU1rUvcc33ZokE22knMqcI2nq+qfj19whAU77HuSN6G3
         OdI5vk0xZWysDcU51YkenVm+nqSFMkHB9qItQ76he9IpPAHs+iyf5EnyasWtZK1bFw0O
         kJhOCJ0OA+Y6lv6jB2SbaB63vJ3JJ7+iUdSS+75eXgPO25SDt8Ccp4HQl6P4XVwni8Q3
         Y2JvZkE2Su1S7zc/HVkH72Tx5Bmx+1QaIBvizNsjFpf+JFqRBvygf769dOkHHqVA/bc2
         enazrTwgGftXC8NBYapLc8wau/2Od2cy2sdefzZ7KqT/JGuSVJJXV6tXMeXFhXhE7gik
         5Aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V/Xvl0eXD4VJWM8ETZPaNNud6m6t4zcVuyNNpdOgtQM=;
        b=L+y03FolSirK4DHe/8vTLm2v5cndQH5aUn8Q5fwGYj5IwR3eI8Qe+bappadNn+VzNF
         /XnKAQ3PPEwKDNYz1yQq0OGfxKvfToI1AMp/y/xdKJMXi/x6rohIwpHwNBQm/BCdxK0N
         uP/fWEYdASSCVaoRGSt9SMJqcZXVtoe0WvK3vZykrSahqquhSKLff/w/TiPbWWzAgaI6
         AtDNriQ/GG9hUYIEg8FCCFBKifg9GOQnKecZjZdwaRozGWx2t/aQFY0iVyYTYNI6DDl5
         Rv7rfwu+K+ZEBJt2al0hVsEvFjMcSbQe+xoztyGKYG2cCnjSWg6ZkN+U2fqStVtiWs9E
         kTDQ==
X-Gm-Message-State: APjAAAWHHNYD9RVs4hXz0NsV2QSGSYWR3tJTJ9+SDUyjdskPKBLy47cK
        cKtBLZ4F8Taa7pBBb/P8kDJAmJYX
X-Google-Smtp-Source: APXvYqzNCR5rDFp49nSNisLaH3HH+D7EwgFNElEswRu5fs8ccxAQ2/lySNvsopKNZ1jAuJwBIFMXUA==
X-Received: by 2002:a63:e54f:: with SMTP id z15mr2245941pgj.453.1574122879638;
        Mon, 18 Nov 2019 16:21:19 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id h13sm23959720pfr.98.2019.11.18.16.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 16:21:19 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:21:17 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v4 04/11] completion: complete `tformat:` pretty format
Message-ID: <5d9fd9d632f03afdf612d03763225f07fdf9316d.1574122784.git.liu.denton@gmail.com>
References: <cover.1573764280.git.liu.denton@gmail.com>
 <cover.1574122784.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574122784.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 00fbe6c03d..557d0373c3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1749,7 +1749,7 @@ __git_log_shortlog_options="
 	--all-match --invert-grep
 "
 
-__git_log_pretty_formats="oneline short medium full fuller email raw format: mboxrd"
+__git_log_pretty_formats="oneline short medium full fuller email raw format: tformat: mboxrd"
 __git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default raw unix format:"
 
 _git_log ()
-- 
2.24.0.420.g9ac4901264

