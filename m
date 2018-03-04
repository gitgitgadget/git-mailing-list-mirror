Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748A01F404
	for <e@80x24.org>; Sun,  4 Mar 2018 03:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbeCDDDt (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 22:03:49 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:39802 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbeCDDDs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 22:03:48 -0500
Received: by mail-qt0-f175.google.com with SMTP id n9so1728942qtk.6
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 19:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=F+Cb6cqAkA4D7cUKz5K6q7f0AXb3GK1akONaPT0sQfs=;
        b=FUmSzm6yLSOlm3gR0tsuHGIK8daeV5jJHePH2mZE87JVOaruL7e23flbodgJjwOUCz
         qgWxraO9GQ8f2JlMGqNTAj5gX5qPnJqyzNEtgHE5c66MkSJuRGgaIW4wOd7zCUoycB5m
         n9QrY4BJnmfKX+LQecl/H4iIaFJt7lF8MFZ5A3mdUhEJjJxebrVGR0xNVb/FGouEquzG
         DR0pJfqwS6IqF+PyIA1F+AnemT27jOjtRdHjQxwvDcKU75Hy7sN/0ms1TD+8TGLEE5V8
         Ga6/wJPJ2CNLNKsEJtYCKaVApRbRwIOCr4BYApuvov4VMcRLtSkLtkqpw9MRoFR27rKr
         88Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=F+Cb6cqAkA4D7cUKz5K6q7f0AXb3GK1akONaPT0sQfs=;
        b=ATM/Dn8Pzy+FO9t8geVrdRHDLJ/aiozMVs7cCGVLhAYMywtBIpMptIaw4tEV218Or1
         MM0Mr7+sptZzD/WTCBB94Ls1iS+N8Dn/HtGJEy/n3q7l6a6gPoX3PVaVJFTdGIFEz3Ok
         9U4teMEatjd9QGxz6eGJ2sn3l2aNhcSBUpXMqCV2n0Ic0FxMhbUaJ3C0u2BRE1HOeNrT
         nsyWT7j6Q1NWK54ODLajTp05sSCCiqEZI17bumeVp8xw1ESj1vMd7+e+QiydCJT0bDL8
         a2IXJFipPeXUuGk1oOpyYOTsHdFRQUpEm4BlFAlrYASbPzhUZsXKtdR8tV5mCB3D7v3F
         j9Jw==
X-Gm-Message-State: AElRT7EnfDYSqdbfGF6Vm9nr45YdPK2JALR9gr9tkKrOKrOPAoEwqJ6q
        jkxEeA14f3ZbmtBEwfT3qYlYRvUwjviFycGtSxY=
X-Google-Smtp-Source: AG47ELtuvcEpL2Z3ic+CuOpPIh2wk7GFU4acQPuVpFni6DqOy6FYhLuvKt0LAlpxUcC2bVSgzvHO9feUHsC02nkWCq4=
X-Received: by 10.200.12.198 with SMTP id o6mr15719536qti.246.1520132627687;
 Sat, 03 Mar 2018 19:03:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 3 Mar 2018 19:03:47 -0800 (PST)
In-Reply-To: <20180303113637.26518-38-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com> <20180303113637.26518-38-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Mar 2018 22:03:47 -0500
X-Google-Sender-Auth: ZSawSl1FyC0hXA98CUOaTpLgSJQ
Message-ID: <CAPig+cQEZawtD+XR9KbSfyJNynh3M1pe4KMXWCc2FeyzgycvhA@mail.gmail.com>
Subject: Re: [PATCH 37/44] packfile: add repository argument to prepare_packed_git
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 3, 2018 at 6:36 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
> Add a repository argument to allow prepare_packed_git callers to
> be more specific about which repository to handle. See c28d027a52c
> (sha1_file: add repository argument to link_alt_odb_entry, 2018-02-20)
> for an explanation of the #define trick.

Object c28d027a52c doesn't exist. Most likely it was a reference to a
change existing only in 'pu' which got replaced by a later revision of
the series.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
