Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257D4211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 13:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfANNmN (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 08:42:13 -0500
Received: from mail-yb1-f171.google.com ([209.85.219.171]:44717 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfANNmN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 08:42:13 -0500
Received: by mail-yb1-f171.google.com with SMTP id e1so8593578ybn.11
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 05:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7s0SNJkXJ59/Q65Hp8DEUm01NzgWIz6pAsazrjF7/EQ=;
        b=LnYYOi7sciT0ZKgyD/a5pbT9d49GSCYFJd1Itjuy0IynPf+4YoRzVmtg1afnx+bdAl
         MRKXIMkp7A1JUtvM1Tw7l7SrafKHFq8grWXODvNdl/gD5UpW8n9LLDm1EnlwCt6wyRAF
         W6IT5bYQInRL10jswdZc+5WaeERrtvCH+Saom2lTzR/D3QBr9q979YCH32DkFShZj6AB
         hi6ITcx5who+4gLx6syomyO7pbOyiiRazU9dYUB1u0sDYCfBCJBSfx+R9PfrUXnbMDms
         IZSGg1AIaMOgp9OhKboyHP2+IrUdndJqAiBICnYbifSV/+vlUnmEfTEaDvyDb0SfGlLV
         5bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7s0SNJkXJ59/Q65Hp8DEUm01NzgWIz6pAsazrjF7/EQ=;
        b=YvM2zVOo2UWM4nRhaaxtUvZX60/hye//q7ekd/PLR1vJZXqcI28vENxZmLxVEf9M+x
         CL2cc0EjPKEJHeexiQxo8TOOYZ5ezIHvy/3cTPMdxZsEbNfwsdTHFviYEPH/3pElYyR/
         THdjIee46SfZAbgBNign+2nJUC/PeMUSRPF2ujms9QeACT/Cr5zC1JCLgZ5yb03TVn/f
         mWxRfxJRK/1a96LSC0Eth6aL+b8jxirb4+vlfJ+uwh9recxDkpWHi7V3RjSGKDSS9rV3
         1OqvxWoJj2HzZ/1aA1iIzGa50nPXJh+47WZK4avWLUIxhbWLH9ijLcu1xsAPVwNKrZ40
         AR1w==
X-Gm-Message-State: AJcUukdmHj1CLxPoMMwe8PQvEI+ZHqJSfEYsDqS/0Efc2LNwWNXP13Pz
        snog3dUDSaY/WiBo8aR1Lf2YcQvPofO/Y2Ks0e8=
X-Google-Smtp-Source: ALg8bN5N2FJ7zv/6xLyCoHPXPKxTOMlRZ1Cpf8PdXNQC9u/xRAywn/3sxh2M8U+852qr1xdnKSGYxZgBM9tk3PRWZ24=
X-Received: by 2002:a5b:5cc:: with SMTP id w12mr7815520ybp.6.1547473332426;
 Mon, 14 Jan 2019 05:42:12 -0800 (PST)
MIME-Version: 1.0
References: <CAHMHMxXyB=1KW6Hx7cs11Ltf3X_wuaQNfaYPmcnr946y4phXsA@mail.gmail.com>
 <CACsJy8Ac_Z1jyBhH1vvYnS_d6tTv5u1j+gjpiGDFE8np-bJ3sQ@mail.gmail.com>
In-Reply-To: <CACsJy8Ac_Z1jyBhH1vvYnS_d6tTv5u1j+gjpiGDFE8np-bJ3sQ@mail.gmail.com>
From:   =?UTF-8?B?zp3PhM6tzr3PhM6/z4IgzqPPhM6xz43Pgc6/z4I=?= 
        <stdedos@gmail.com>
Date:   Mon, 14 Jan 2019 15:41:35 +0200
Message-ID: <CAHMHMxX3peBpMAn5uHkK+DsBvM10mzb8zdKE6ko6XSRTp4Gggg@mail.gmail.com>
Subject: Re: ls -files missing from git-completion-list
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the resolution.

I didn't know it was a plumbing command, hence
`--list-cmds=3Dlist-mainporcelain,others,nohelpers,alias,list-complete,conf=
ig`
didn't inspire me further

Apologies for the non-important topic.

Ntentos Stavros

On Mon, Jan 14, 2019 at 3:36 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Jan 14, 2019 at 7:19 PM =CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=
=82 =CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82 <stdedos@gmail.com> wrote:
> >
> > I have install the latest git version from the PPA:
> > $ git --version
> > git version 2.20.1
> > $ lsb_release -rd
> > Description: Ubuntu 16.04.5 LTS
> > Release: 16.04
> >
> > Running `https://github.com/git/git/blob/master/contrib/completion/git-=
completion.bash#L2898`
> > does not give ls-files
> >
> > $ git --list-cmds=3Dlist-mainporcelain,others,nohelpers,alias,list-comp=
lete,config
> > | grep ls
>
> This is expected. ls-files is a plumbing command and will not complete
> by default. You can however add it back by adjusting config variable
> completion.commands. See "git help config" for details.
>
> > $
> >
> > =CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 =CE=A3=CF=84=CE=B1=CF=8D=CF=
=81=CE=BF=CF=82
>
>
>
> --
> Duy
