Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25EE21847
	for <e@80x24.org>; Wed,  2 May 2018 18:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbeEBSKb (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 14:10:31 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34717 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeEBSK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 14:10:27 -0400
Received: by mail-oi0-f65.google.com with SMTP id l1-v6so13782762oii.1
        for <git@vger.kernel.org>; Wed, 02 May 2018 11:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kh0YqwGpwlkVLvp+v6VOIoh4sJePn9svaO6fDkUUv44=;
        b=IZe2E3aWlIWd/iXqiMClTkU1Rm2FWKZmswnEC43FzugkgFQX49Yqb6/XzTjJeX8oIr
         9UJcbR3ZgFJX+hpwaAaHu9MdU78m1xS7o2poSTdcEmcEbNVVttAkFveNLIw5LlHosm3R
         +T76LATh1NFKNUXSAMk5bdCNp03VKdW9zOLjwhPD5RYsJ+P6TCxmHuNJHcrwWgZ2H27u
         6TRWqee9Ct/h04hJysC/FaVbYcs5CKjs0pkpqCuSflwf7MslD9/QF+gOsa/hsBKJv5eH
         EfTFETrDRZU1IPooOwPbxREEjwCuXpmsTBCR7NcfzI6F0MxNWM6kQCMdnlznpPUNcwm+
         xOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kh0YqwGpwlkVLvp+v6VOIoh4sJePn9svaO6fDkUUv44=;
        b=jhdI/pZLvxDXcpANtV4UCbE4bYI2f9yu/QwNzajjQNjqrRZ1KTlMOnWPcNr9bnG+Bx
         yxfKlqJYbSXwyduh2A4dKbLw4lPCADmQKSaQ32ekmLDdVlVEkRGfNsBZIBteV3QFiaUi
         TI3oWncepm2Oka6rK3l5XcW4/cb+hbsn8uHbn7gP6HXXQJPxKfQoyhiA1FhY6uDkeYO3
         YP69kfxRSo/OHK9aJZeRkkFS6KOmnzLWgKH+yuhsojLYduiJC7eq411bJe7uzTN5SHbo
         kbMsOQIivaKz2reE8A7iyTp9j8p5zbyORCypNK0+Jh31FTjYx9OTe5UyzxyXdxlx1sTb
         iC/A==
X-Gm-Message-State: ALQs6tCbRgTGIomaGmujGrgxhWTLsgu8VtwOcCrgFldd6hq7Cv5pkeqi
        2Q5t37Uayt1riJp12HNSz/M4nqrNKZGTJf62SLU=
X-Google-Smtp-Source: AB8JxZqmfqylxvlMrrEt5LMnPGP/MciFwOxzsfnD85iml3+/ry4A7d+Xq0ukBiGU5kkEmeCdWNtX2P5KtimbUG/pfLU=
X-Received: by 2002:aca:51ce:: with SMTP id f197-v6mr13093492oib.32.1525284626656;
 Wed, 02 May 2018 11:10:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 2 May 2018 11:09:56 -0700 (PDT)
In-Reply-To: <CAPig+cTZyYC-1_TxL2PrfOF6HAktUxxM+g5EXcByS5fCDMdCHg@mail.gmail.com>
References: <20180502105452.17583-1-avarab@gmail.com> <CACsJy8Ae9PP8BMbyX5mPJukGpC06jMvvbg0fMFL+fu+EUg1kPw@mail.gmail.com>
 <CAPig+cTZyYC-1_TxL2PrfOF6HAktUxxM+g5EXcByS5fCDMdCHg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 2 May 2018 20:09:56 +0200
Message-ID: <CACsJy8C9yY-uJf-j=orfPUnwZ2U=-0vVMqWEbS306P0v5_UbPw@mail.gmail.com>
Subject: Re: [PATCH] checkout & worktree: introduce a core.DWIMRemote setting
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 2, 2018 at 8:00 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> 2. Building on #1: How well is the term "DWIM" understood by non-power
> users? A term, such as "default" is more well known.

I'm going off topic but I kinda dislike this term. First time I
encountered it in the code I didn't even know what it meant. Since it
has not been leaked to user documents (I only did a grep on
Documentation/) perhaps a better term should be used, preferably not
another acronym.
--
Duy
