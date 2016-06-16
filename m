Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70F4E1FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 07:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbcFPHrS (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 03:47:18 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:32890 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbcFPHrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 03:47:16 -0400
Received: by mail-pa0-f66.google.com with SMTP id ts6so3206336pac.0
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 00:47:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9OOsi07FkRG1RRhLhWAYgLa/jjqSYHbrBMDZF5fQfw8=;
        b=OZmU4z8E9Ei0ErKzOy0L5CYalEbVr6qNP5DsTAjxYKPDJ9czMAdeCVj2EjVjuYwen2
         O4ATpGnwTDDDc6vJlgQkKeO1l8VVCiIawYJwf8/ub3212DTmCxf6iigzbMZNvc0+Q9fc
         JF43Ay2SNCrVHKBhJISJg542GiLmG8Pt47LAwlPK4fewoavrDtaJs2NyvzSPixGLxKcM
         bnZlp5X3yCk0bzsapgs9O98OmWn/h0u9wvaqtMUxyJTKV8prEbdj96K+xN7EROOzTaub
         sHab04vMEOT7d7eJtqP/vbbKYJ7orb6stkwRQRMfugZtzEtl1clYHogR7Ojz4YFiTacj
         tztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9OOsi07FkRG1RRhLhWAYgLa/jjqSYHbrBMDZF5fQfw8=;
        b=UHIuuqEl8TlgsZJjVjWZGs8ytS+9nHnK1jyDMdVy2ZAKFRqWFML4vKy2q9BRIdXnx/
         QqDPOBvZf3lmw259MdWIWaC281y6CySi87BjNRbKvHU6dGdyBwYrB4Q9Js83oNxB2A7w
         BFlaDUUsjZGpuiqQ7XCeUw1hw+PkR4j0E70Xn0aylULt+9vGI/+yGmMdIxxvqiIEyJuV
         3aD4YgghBbNRCW/T3ERdDMJkym163FGwsFB1xNUKTqMQeOaJz0X4ONKuS09dxxzwHEnj
         8Lae5ivNmocbdgkK0oGUYdSUtMNTEqVusmUT2oM/so1Ke83JYf8uCmLuSVh64CzNCorr
         kDtQ==
X-Gm-Message-State: ALyK8tI3OOdaIpGqtgqj68c0pXaXG8L7/IffGQmwgZw8dteSaSInEFN9RWqc6jsieb2PSQ==
X-Received: by 10.66.25.8 with SMTP id y8mr3657924paf.106.1466063235123;
        Thu, 16 Jun 2016 00:47:15 -0700 (PDT)
Received: from duynguyen-vnpc.vn.dektech.internal ([14.161.14.94])
        by smtp.gmail.com with ESMTPSA id y70sm58132229pff.25.2016.06.16.00.47.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jun 2016 00:47:14 -0700 (PDT)
Date:	Thu, 16 Jun 2016 14:47:09 +0700
From:	Duy Nguyen <pclouds@gmail.com>
To:	Charles Bailey <charles@hashpling.org>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: fix grepping for "intent to add" files
Message-ID: <20160616074709.GA24412@duynguyen-vnpc.vn.dektech.internal>
References: <20160616065324.GA14967@hashpling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160616065324.GA14967@hashpling.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 07:53:24AM +0100, Charles Bailey wrote:
> From: Charles Bailey <cbailey32@bloomberg.net>
> 
> This reverts commit 4d552005323034c1d6311796ac1074e9a4b4b57e.
> 
> This commit caused 'git grep' to no longer find matches in new files in
> the working tree where the corresponding index entry had the "intent to
> add" bit set.

I don't think revert is right. It rather needs a re-fix like below.
Basically we want grep_file() to run as normal, but grep_sha1()
(i.e. git grep --cached) should ignore i-t-a entries, because empty
SHA-1 is not the right content to grep. It does not matter in positive
matching, sure, but it may in -v cache.

-- 8< --
diff --git a/builtin/grep.c b/builtin/grep.c
index 462e607..ae73831 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -386,7 +386,7 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
 
 	for (nr = 0; nr < active_nr; nr++) {
 		const struct cache_entry *ce = active_cache[nr];
-		if (!S_ISREG(ce->ce_mode) || ce_intent_to_add(ce))
+		if (!S_ISREG(ce->ce_mode))
 			continue;
 		if (!ce_path_match(ce, pathspec, NULL))
 			continue;
@@ -396,7 +396,7 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
 		 * cache version instead
 		 */
 		if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
-			if (ce_stage(ce))
+			if (ce_stage(ce) || ce_intent_to_add(ce))
 				continue;
 			hit |= grep_sha1(opt, ce->sha1, ce->name, 0, ce->name);
 		}
-- 8< --
--
Duy
