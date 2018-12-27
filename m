Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D23C211BC
	for <e@80x24.org>; Thu, 27 Dec 2018 20:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbeL0UhH convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 27 Dec 2018 15:37:07 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36870 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbeL0UhH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 15:37:07 -0500
Received: by mail-qk1-f196.google.com with SMTP id g125so11510922qke.4
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 12:37:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ucOzfsN0ySX3sTbHhOLiYyIDcjS3VjUTAI/HlRKfM3Q=;
        b=HeGH27XasFsOWA2Sd6HGotT6ks+K1WgDyXXKlr44FSDJFlpcgdDXJfZRDVVIuzVSU8
         2vW2bbOQyyrvUIz+GfPdnNHAwZ8+rf07X/sSR3j3EOz0nRdm89mCqns/OaappdF4th5X
         SDjamkMGjEiH/mw7F1243SUeBVj2MlaeNGrByMg68DudvQCyYhD5pJYz4FOCtSCd7yw/
         /6kYP0x2rPzNJHWIDULqWLczDqoMJfH01itBSmBuRBmykEf5qOwiRuEtYT+YK1+YDGtq
         OQkC/d5tvnI2uIyqT0MJ3/38/Ip7Pb753P634XipxmkhETij9koXTP8Zsyccmv6+aa5I
         +mGw==
X-Gm-Message-State: AJcUukfsEYyDsorSnERGo0IF3bAQ44fZJCcXJL44oBvURZpjFeIfJKdg
        cn0kxPdhMDrip2jHS2SILmvinbTF5DRvvemht+A=
X-Google-Smtp-Source: ALg8bN52Sc0FvZAwNH61vhTcn3LutTJrdVEEG/T0W9L+aCZlhfpg4QOtoWbziYho+8xYliaoHZ7S/OWxJ1Kp21pTrjg=
X-Received: by 2002:a37:9584:: with SMTP id x126mr22765109qkd.36.1545943026505;
 Thu, 27 Dec 2018 12:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20181227155611.10585-1-pclouds@gmail.com> <20181227155611.10585-3-pclouds@gmail.com>
In-Reply-To: <20181227155611.10585-3-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Dec 2018 15:36:55 -0500
Message-ID: <CAPig+cTGH3d8h2kQU1OxwBM+n-rH19x3qZnOeRFqfL0AiRRm5g@mail.gmail.com>
Subject: Re: [PATCH 2/6] worktree.c: add get_worktree_config()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 27, 2018 at 10:56 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> "git config --worktree" can write to the write file whether

s/write file/right file/

> extensions.worktreeConfig is enabled or not. In order to do the same
> using config API, we need to determine the right file to write to. Add
> this function for that purpose. This is the basis for the coming
> repo_config_set_worktree()
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
