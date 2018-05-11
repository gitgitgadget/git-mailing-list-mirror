Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DDA21F406
	for <e@80x24.org>; Fri, 11 May 2018 16:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeEKQeQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 12:34:16 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:42264 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeEKQeP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 12:34:15 -0400
Received: by mail-ot0-f196.google.com with SMTP id l13-v6so6895809otk.9
        for <git@vger.kernel.org>; Fri, 11 May 2018 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+B9rGEZlM0/8daXdoY+DSyjXDygpnqZrDDBBG3LglaE=;
        b=MkSSokEyO+siMCfX8bszW9At7eAkMsBx1nw0XtbfcHoBgbrcL0+qm8dt9liuwSJXq+
         CcI5UPNiozRQF3Hpk6u9P4Oyfc6Xsv2oUQZE2ZZUtV7fHdVmm5494l0w44fCihYtN9zH
         kE3nDE/AlBeG1bAuJkrRxLz/Zm4/iAqdu9/8n+jrJP1IkkeFMBYQt3qzxVwiNQy2gnIN
         nGoSiK5D0YMCUfaKHaT4/pk6om7s2MsnrobY3L87yplYgWINEIc1WppnCjIzCT8kqzy/
         9myF3/o/+Dx/kfyDZHolMTguyqf55uKGGT6YemwJ0Lo6DnumUDrKlhAqkQE/U2ca+RBU
         DZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+B9rGEZlM0/8daXdoY+DSyjXDygpnqZrDDBBG3LglaE=;
        b=OqDagNeLVII5f7FF8MWT7OWlappdJQ5C+Ojn8f6DJxssenJlkLEis6Xx9C6Qb+Wlvk
         WTKkUK9zpgFzWphgCIC4KEpltIBR0bTcTyAgTSJZlh1OV1P1DOETzgMMFi62ZlIQQkDh
         TVj4kzUPQQFOMC4F1h6/LJj31pLyIWCoPaQrDx+LrnMVeUZbi2mAM37kfoHY5kHMp+kn
         awDmRfrgLnGWtWXWF39Yr2PtdYxSPU345tDb/dSgBrZ1pl0G+6s6/cJKGjjLSacWm7JL
         /4/LzVJsrJ1jySys/qsoLZAfl/jOoyXjhARnBTxOIgmO1TKkf7qdnZHpnOdNiglEOXfC
         Rqhg==
X-Gm-Message-State: ALKqPwdXOA1JXkuiThYTS5CeBcAT1+cJpq16eQLVYP4ztRfygeWuB1q+
        u4sLVb1InmfIhO13rDqKjF2kg6o9RUIrKc0+Uv1jEQ==
X-Google-Smtp-Source: AB8JxZorvRPwkseWh4BSDrJLyggq3SUojZI9zE8QNzW/vuQW3cYLFJ0yTyD4YR1uxTuTJV8ZoDCGXhbEKfkKw95kpv8=
X-Received: by 2002:a9d:e8f:: with SMTP id 15-v6mr4619269otj.14.1526056454508;
 Fri, 11 May 2018 09:34:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Fri, 11 May 2018 09:33:44 -0700 (PDT)
In-Reply-To: <CAM0VKjk3kqKpVz0ZjX58REwP8rz08kLsiVR4NWDO6-9iPGPe9g@mail.gmail.com>
References: <20180507175222.12114-1-pclouds@gmail.com> <20180510084652.25880-1-pclouds@gmail.com>
 <20180510084652.25880-8-pclouds@gmail.com> <CAM0VKjk3kqKpVz0ZjX58REwP8rz08kLsiVR4NWDO6-9iPGPe9g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 11 May 2018 18:33:44 +0200
Message-ID: <CACsJy8Dxaizn7O1cVVXA9Gzywj7nQ5K0YMzgMkB3BQbV=W6Npg@mail.gmail.com>
Subject: Re: [PATCH v7 07/13] completion: implement and use --list-cmds=main,others
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 4:06 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> On Thu, May 10, 2018 at 10:46 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy
> <pclouds@gmail.com> wrote:
>> Instead of parsing "git help -a" output, which is tricky to get right,
>> less elegant and also slow,
>
> Is it tricky?  It seems rather straightforward.

But there are traps. [1] is a reported one. And since you're parsing
what's meant for human reader, this code could easily break in the
future.

[1] https://public-inbox.org/git/CAPQz56bts8zFfUHyKJqnefQoH97L5TTA-k3be=3D5=
HsdeEbcMqOA@mail.gmail.com/

> Is it slow?  Well, there is a pipe and an egrep, sure, but thanks to
> caching it's only run once, so basically doesn't matter.

This I agree is an exaggeration. Ultimately though I am breaking down
and providing the information pieces to
__git_list_porcelain_commands() and it happens to benefit this one
too. Perhaps I should rephrase my commit to say this.
--=20
Duy
