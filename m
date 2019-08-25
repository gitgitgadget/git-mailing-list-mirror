Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA0651F461
	for <e@80x24.org>; Sun, 25 Aug 2019 20:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfHYUe6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 16:34:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46550 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbfHYUe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 16:34:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so13329893wru.13
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=R5mc8WtghDnfQ4arcmWOlpi0yoNi7xWNDo87E5/OiW0=;
        b=mzUVwP6BXgC8NMKgppS04wdPUD82GGJ+GT78Sr2KDXnzJld8T5Gfra5FT5DjDI2JuP
         kkyzdALWqrzFXn3eT6pKLvs4q4MCrppx4WNydwohg2Dz0dYTd2KSpeEwkF27IKyH02aj
         m48lYhLx79zjQ24DvmfsZTQ5OqXOxs6rlvA5xvFStX3xA6R/nEBsKokiakY3dfFL/956
         6RuTa8INimI7C1efAs9eq91kUFzNdY5btKV5aiywY1BH2PzVqfs+V0Z5z9V8A0X56M4Z
         S4cWx0SBBlnEIzbHvqgCdQaIfRuIDzUGGuqmDgqRBPRxjtIyh/ONH5ViQ33qm7qLQyem
         u+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=R5mc8WtghDnfQ4arcmWOlpi0yoNi7xWNDo87E5/OiW0=;
        b=JxVxoFFg6Zx9XSZRE9hKQWjVXeIRJ9mtXy364YQeMavWfasE2N6yjiBiC/vhVpF7cr
         IG6QJ1UQPyM5lL/e1+y2BuWe4ZvSsT1S8G+E5JzlvPeOntEDhNVqS+rnT018fs9WL0Cc
         7fKqmKkjNFNwK5ZAmauExfs/C4+cijmiYV6c5M8pGUMQV/L1Nu6dsIFP8DyifY2VOKkE
         xhc7dJhfdWqluOzBUnhiPmdNLwtmpL1aJ/8yhiY+gd0AduAog921TMGQ0fsvOFegnCUy
         D5yswiVxo3vLHoChcWxwVqjL3wyLTzBEYX0EVNK83+FxZ6h/RokpHdCW3fOVu5Dhi4wr
         qtEA==
X-Gm-Message-State: APjAAAX9bg/7hJ2Zz1UxGiaUYKRg1Jes//YA4l8xv343jWxwI2HzQov3
        o2LDG4ZHbhhNP7+6qPidhszIatzA
X-Google-Smtp-Source: APXvYqxaemUhwplBgsO8/SyTYM3AZJyeU9GWdlc0XxB+QmrZ7GpvoHZFRIpoK46RPbkVfcbS3MoyVA==
X-Received: by 2002:adf:dbcd:: with SMTP id e13mr17562267wrj.314.1566765296229;
        Sun, 25 Aug 2019 13:34:56 -0700 (PDT)
Received: from szeder.dev (x4db347f6.dyn.telefonica.de. [77.179.71.246])
        by smtp.gmail.com with ESMTPSA id r16sm19114697wrc.81.2019.08.25.13.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 13:34:55 -0700 (PDT)
Date:   Sun, 25 Aug 2019 22:34:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH] t7300-clean: demonstrate deleting nested repo with an
 ignored file breakage
Message-ID: <20190825203452.GO20404@szeder.dev>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190825185918.3909-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 08:59:18PM +0200, SZEDER Gábor wrote:
> 'git clean -fd' must not delete an untracked directory if it belongs
> to a different Git repository or worktree.  Unfortunately, if a
> '.gitignore' rule in the outer repository happens to match a file in a
> nested repository or worktree, then something goes awry and 'git clean
> -fd' does delete the content of the nested repository's worktree
> except that ignored file, potentially leading to data loss.
> 
> Add a test to 't7300-clean.sh' to demonstrate this breakage.
> 
> This issue is a regression introduced in 6b1db43109 (clean: teach
> clean -d to preserve ignored paths, 2017-05-23).
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
> 
> BEWARE: Our toplevel '.gitignore' currently contains the '*.manifest'
> rule [1], which ignores the file 'compat/win32/git.manifest' [2], so
> if you use nested worktrees in your git repo, then a 'git clean -fd'
> will delete them.

OK, singling out that manifest file is just nonsense, any object file,
etc... in the nested worktree/repo can trigger the same issue just as
well.

(It just so happened that when I ran 'git clean -fd' I had a nested
worktree where I haven't build anything yet, and besides the .git file
only that 'git.manifest' file survived in the nested worktree, and then
I got misled by it.)
 
