Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 776351F404
	for <e@80x24.org>; Wed, 15 Aug 2018 16:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbeHOTp6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 15:45:58 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53354 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbeHOTp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 15:45:57 -0400
Received: by mail-it0-f68.google.com with SMTP id 72-v6so2572592itw.3
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 09:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sPaHuzUO7NQWHvo0E8wcU8T/MrRVeYqVvT0Os/UFGuA=;
        b=tEkzuZ3fwkkL+0/nEUkooCZHwppk1f8JhgobVg//kh34uYEXECsCS7VBlHEZZi5IFm
         p/mo4XhyS6lco++NjJdp8yRrFC935LuKrQ2cpbwv1hjpuLYZaJ+MzyrsJlpzOxUI+Usj
         GzExipqLLFQ5oxxWnvFrfWcW+LJHyW1Z51a5j+O3I889onJ8CpTalENMa+e8cAQxmMbm
         ELwaQEki0o+HkAypWJjXbnpokHWxsaEx7r7n9/wNxXoh/IRPV57oR9zjiyv4vWWUqCHb
         xSkJ1nWLSuk/0F+X5L7Rjpr89GQUrC4JDeTxTebR9fPsROBCecQ9jLHgelLYeSzzssBs
         Bmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sPaHuzUO7NQWHvo0E8wcU8T/MrRVeYqVvT0Os/UFGuA=;
        b=MJ8jmBtAZsXqO3lwHh/He/6gvLRxoexARlOMaprgKJkGi4wsfy4TfLPF+H+QmJyhf0
         TjWpYsrCg5pKMVsBV1YXrVcdyA3NVV4R87ZM1IEl+shyGchK4qEmhMnEI71y4WfO3uIL
         63RTfKc8Flh3y4Sb6cgP1ZBJGz0Acb6hrP3ZrjJI+gjXCJ8UMb58PiFsUQXooZQCKZYv
         uc+JE02vH7oUofNanFxbE9imxeqBjXZLWK0/gH0+3fpedgrR76YUdGNuvIiPazQcuuyh
         IXdeyknq0h4W/bKwX1AYOCW03d3gN6gmWg6A905qzRqbKTRPCnjAaEdF+/jhCRQYXYdd
         Fv0w==
X-Gm-Message-State: AOUpUlFZG7dsdadfJrTF19rzk2n9PRozgzZIRBt9Kc8vCwyt1nWZ2mk0
        2Gyxs+FBGE6zR/aF8FiSIWNivslE93Hf0cp4ayE97w==
X-Google-Smtp-Source: AA+uWPylzQYOVVXyVBC4Y2a53ORRzspiopiQMH8att6DewuRG/zc3yKoou7EYsvOIw1lCfGuGnzbetuA/1XMy4N/VxY=
X-Received: by 2002:a24:c888:: with SMTP id w130-v6mr19844088itf.78.1534351982235;
 Wed, 15 Aug 2018 09:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180815162308.17747-1-pclouds@gmail.com> <CABPp-BEC45snMzGeCre-dD1rtqGok-RKuLGbMaV=VJhwx1ceew@mail.gmail.com>
In-Reply-To: <CABPp-BEC45snMzGeCre-dD1rtqGok-RKuLGbMaV=VJhwx1ceew@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 15 Aug 2018 18:52:36 +0200
Message-ID: <CACsJy8B3ip+_sDrpvaZ32a35-6hWkY=eE6g4RObWgbHnf6g8uw@mail.gmail.com>
Subject: Re: [PATCH 1/2] branch.c: remove explicit reference to the_repository
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 6:48 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Aug 15, 2018 at 9:24 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
>
> The patch looks good, but since this touches multiple .c files, I
> think I'd s/branch.c/branch/ in the subject line.

It is about removing the_repository from branch.c though. As much as I
want to completely erase the_repository, that would take a lot more
work.
--=20
Duy
