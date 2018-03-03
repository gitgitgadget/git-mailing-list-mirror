Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FB861F576
	for <e@80x24.org>; Sat,  3 Mar 2018 09:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbeCCJeJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 04:34:09 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42473 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeCCJeI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 04:34:08 -0500
Received: by mail-qk0-f193.google.com with SMTP id b130so14977837qkg.9
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 01:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=+hDodEdR+gJ4SbdJPqAG2Im7xU/4Fq3R/FZ/NRBhrHo=;
        b=R5oRVngUG0Jch2Dg6981skkSRNbBYR5WuRIMwve8erGVGWkx78wiOm0Irq/E1N6LH4
         3eFtyeIexBPsEu17KeA8QD8mY7mxWpCVPha2FnXZBvQahNCtcVdiXE4re9snKwHHKWMQ
         ZMLkHEPYPoiMEEexwLS0Sx01QYrQexSnY73xiejAKlrt1l7/YC5YOfxH5GVagNrcv4/2
         id06hwnuMhhTKz+U6O1zb9Ml4HIFUH1Ut44rD9iWc9dxSbFr8niEMfGVLCPte2wC8tpo
         DE1gZqqHnZNp1vOZdVYsNa6ts/0S4AKMWXyq1fAOQOV67cmU/BXP6H2Rl4BVE36ZHS0J
         Fmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=+hDodEdR+gJ4SbdJPqAG2Im7xU/4Fq3R/FZ/NRBhrHo=;
        b=ar7ng02MOg18YW4893lQMb/gNXM7WP7554+2WwQPvkf0Ywg+q9zoWv+IUaD8nlsKHU
         mbnB5bDXSSAS362xVNtrtCc6i2mkexJWByYBHRKbiwnQY0P0X/Fkyw2MCArkpHWGzCIo
         JSne6fre8wY++Pv4HFkVMGOaRmIeGjtgxReUYRWOxP29BocjcyI1bW01l44Bmr5FsMFf
         LZkkX26YZKW3jClMYyxxhAUv25w1rhVfpdU4RuzfDZC/1CMZs1rYQgzybwP/rChcqPuJ
         DdQN9SIbYJmWxa6TV36syFizVQ8heZuXi+ztDUMeb3L0+AXFuqUByq/GFF0nqA2j1PJD
         3S5w==
X-Gm-Message-State: AElRT7E5F8oWt2PDVScRQCbYlHe6hp4nynkSn7gaUcs/MFa17WbI0l0d
        RQk9D3lffEVJEevJZwKVZazmtMXw9ZC2BFiGxmABkg==
X-Google-Smtp-Source: AG47ELujWcU7rbGrWs8OJlwIrspAfgwYeYXU+17Yak46zWKhDdvVpv/Mxh07oh2gBC64BoYdawkHg5tHh8jC6gWB7+k=
X-Received: by 10.55.88.7 with SMTP id m7mr12774036qkb.133.1520069647951; Sat,
 03 Mar 2018 01:34:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 3 Mar 2018 01:34:07 -0800 (PST)
In-Reply-To: <20180303092307.3796-2-pclouds@gmail.com>
References: <20180303092307.3796-1-pclouds@gmail.com> <20180303092307.3796-2-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Mar 2018 04:34:07 -0500
X-Google-Sender-Auth: 5ZqbTtP9quwnUyfP3mgXbX4mniQ
Message-ID: <CAPig+cQP1ABWJUPW1BOTUxvsJ_aO_zsinxkuCOjyWYVOTKHR0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] completion: don't set PARSE_OPT_NOCOMPLETE on --rerere-autoupdate
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 3, 2018 at 4:23 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
> There is not a strong reason to hide this option, and git-merge already
> completes this one. Let's allow to complete this for all commands (and
> let git-completion.bash do the suppressing if neede).

s/neede/needed/

> This makes --rerere-autoupdate completable for am, cherry-pick and
> revert.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
