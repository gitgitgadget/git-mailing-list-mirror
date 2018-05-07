Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84948200B9
	for <e@80x24.org>; Mon,  7 May 2018 19:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbeEGT6N (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 15:58:13 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41326 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeEGT6M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 15:58:12 -0400
Received: by mail-yb0-f193.google.com with SMTP id l9-v6so10356346ybm.8
        for <git@vger.kernel.org>; Mon, 07 May 2018 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MyqCuV7v1MuLw5FACVoBtekONLFxLZlFblAtAOV1YMI=;
        b=Zgo0JXK1ACPRs4P6e+20gSYtUmJ7X7tbBmqeLL0OGDrXvJEBpVtuAjNq2fpxYoLPXX
         nL3A9y257IZyjI9Uo4iEMjhhN15FCH6TZkdwRGWC5oyrXdAQHXj+D4zAIPfG1LMNQeGH
         OfjO1+4SHpO2yHuGs7FSSw3P1Vd3uFMlcKOQf+rDzaaLACEM0jlVS6rn+8DpSfI+6rkN
         nL41VzAzUQFSp/lRsnrc6A/EzROBeAl3IhRO+8DUKLC7d3x68V664wy8uv3b8h7vS0zF
         zQOVLaryuZcVQgVQcE77N+Qm4XbAvNRIFLdZIbY6eGcmcvlnp4eiDSDSPKOkymhR2bsw
         XClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MyqCuV7v1MuLw5FACVoBtekONLFxLZlFblAtAOV1YMI=;
        b=stYunVy1EMlNGChI/iHzqsWCp6x/Oa+S1q691hK7o3EQSnrPvWeDbdwKOp7Eu1G2xw
         1WgbIWkl3I7H7i2fM2prq+niPY1PKidUnOb59o9b9oCIeaUCYcqdPEy3nE/96Tis/5Ij
         m7Vz0iKArfi71SVrlZEtduuPusjmxZNjQmTmF/03vHrtx808zl5W3/TclmKV44H4EXmP
         kwTPsHObCRkUPzzkckRX/Vyf12/jRZ+UQxJAU0Onw03BiE2maAV/twNglnUrFY9UoMb6
         6qDtwoNnnn8EsfvQ3rh67sL+LKMz53Pqn8D9xooc/3ymnnN6FxBL8D0k5igRjdQIiIca
         7K1A==
X-Gm-Message-State: ALKqPwdQ/HzhB5P8Gx3jRCHwC6hHLAzOBOTobbyp8V4OoekqIL6p1Z/u
        Vi2ar/zh/5nbXIZxbDriig/kWnseTbTxNfXJjw3GuA==
X-Google-Smtp-Source: AB8JxZrE53ztJjerH2RLGVz/wyQDgV255Ft/ieQd67INTMBfSXhGdLI/hx7SwjgL5fkwLHwkt6Q7optW3toyS8YCs+U=
X-Received: by 2002:a5b:108:: with SMTP id 8-v6mr3760503ybx.292.1525723091398;
 Mon, 07 May 2018 12:58:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 7 May 2018 12:58:10 -0700 (PDT)
In-Reply-To: <CACsJy8DabOE_6BKorQmO=E9m5QBbXW2hKLswiZ21Qg9z7H++cg@mail.gmail.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <20180507075006.GD31170@sigill.intra.peff.net> <CACsJy8DabOE_6BKorQmO=E9m5QBbXW2hKLswiZ21Qg9z7H++cg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 7 May 2018 12:58:10 -0700
Message-ID: <CAGZ79kZ_M3AMO0ieaH1u3mtBCEtnHNWV8DtE219p+WM3P5L2tA@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 7, 2018 at 8:28 AM, Duy Nguyen <pclouds@gmail.com> wrote:

>>> I do hear you. Especially since I hate `git cherry` every single time that
>>> I try to tab-complete `git cherry-pick`.
>>
>> Me too. :)
>
> Just so you know I'm also not happy with that "git cherry". Since I'm
> updating git-completion.bash in this area and we got 3 "me too" votes
> (four if we count Szeder in another thread), I'm going to implementing
> something to at least let you exclude "cherry" from the completion
> list if you want.

And another "me too" here.
