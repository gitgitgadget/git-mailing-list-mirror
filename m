Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E90720988
	for <e@80x24.org>; Tue, 18 Oct 2016 15:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761890AbcJRPRZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 11:17:25 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34390 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756169AbcJRPRW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 11:17:22 -0400
Received: by mail-yw0-f177.google.com with SMTP id w3so140995654ywg.1
        for <git@vger.kernel.org>; Tue, 18 Oct 2016 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=swKacc3KlnQ208FG2YU0wLNB039tA2GWw0D5df3x8/8=;
        b=jUPp2D33pda5UVnHuA4YCtB2tbdQ5DYQcM9r5LEEzIzlQqUvTXhQkgp5eh7S+cStir
         eO0moo0oAYeWJXDFZgIgCLlo1tizKKtlfO8ZR/LcyxiW61bg4K/qYvjzHdP8RyfTMep2
         ztD90AdEUySu9CXhmKrO2LDehOp2PvGu4g9YwEq+T/zm9+6q5Lb7I4DDkoatOxuEqDgN
         4kdvQvgeo+2qMvaLlyjsaVIJDH0t81JNCQBZFUqedxbiOnQy+pUsXgVOJpQk42LUVFFR
         +kzAgsc4XaIPhxnO+qloYVwkBctAmkpjF870VfYWCHPqiDKz+U4t5NBPvO8X8EH17faA
         nokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=swKacc3KlnQ208FG2YU0wLNB039tA2GWw0D5df3x8/8=;
        b=K+7Wn0RaUY5Th8TW3cY7CD4cT8BDLwJYceq/iWAxOJkxH2vnzHwPJYNG1QSU6/xJgE
         Uvo54Zzjt40KorK3p5mCZXql6LzoMEjQHSgP+QbdIghaLYPIcw2xGnCg9gFqXbMqh/rf
         R3WFDDGer49Bg//Yw563TsVPWMViwvikaSWuEjUXIbHEQ0I4TvYZneSdkAIvoIP3K1MU
         Pw+4msZHY8FkgiAUZbXJ1blLRy3TNxweNIvUjXonkHUhg5ORzjHP2/W/EDS23UwSeZeN
         3/rAN6UOHgsOjNeCR2ysZUm2VO4/CeFdBHpmg3ZtEYt+OfP/S1n9xljwijCPBNaRJ8Fx
         m+Jg==
X-Gm-Message-State: AA6/9Rk//l7jcQeqqOecVAzy5c57frM8FXdimGRi2Cd1SfwoxieEJdhHAOR9+i3dwYU7BA==
X-Received: by 10.28.187.87 with SMTP id l84mr12397951wmf.60.1476803840127;
        Tue, 18 Oct 2016 08:17:20 -0700 (PDT)
Received: from p2003005f7d2520fb75ab403d6ee92a34.dip0.t-ipconnect.de (p2003005F7D2520FB75AB403D6EE92A34.dip0.t-ipconnect.de. [2003:5f:7d25:20fb:75ab:403d:6ee9:2a34])
        by smtp.gmail.com with ESMTPSA id i10sm49456806wjw.1.2016.10.18.08.17.19
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Oct 2016 08:17:19 -0700 (PDT)
From:   Raffael Reichelt <raffael.reichelt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: git checkout crashes after server being updated to Debian X86_64
Message-Id: <6B2BE996-F696-4EB4-91CA-849D40B8802D@gmail.com>
Date:   Tue, 18 Oct 2016 17:17:18 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3226)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!=20

I have a serious problem with git, After my provider had updated to a =
X86_64 architecture git crashes with various memory-related errors. This =
is happening remote when pushing to the repository from my local machine =
as well as trying it on a shell on the server itself.

This are the error-messages:

fatal: Out of memory, realloc failed
fatal: recursion detected in die handler
fatal: recursion detected in die handler

or
fatal: unable to create threaded lstat
fatal: recursion detected in die handler
or
fatal: unable to create threaded lstat
*** Error in `git': double free or corruption (fasttop): =
0x0000000000a8ade0 ***
fatal: recursion detected in die handler
Aborted

It=E2=80=99s obviously not a problem of the repository - happens with =
all of them. I think it is also not a question of size - happens with a =
80M Repository as well as with a 500M one.

Any way: did a=20

git fsck
Pr=C3=BCfe Objekt-Verzeichnisse: 100% (256/256), Fertig.
Pr=C3=BCfe Objekte: 100% (56305/56305), Fertig.

git gc --auto --prune=3Dtoday =E2=80=94aggressive
git repack

Additionally I played around some config parameters  so my config now =
looks like:
[http]
    postbuffer =3D 524288000
[pack]
    threads =3D 1
    deltaCacheSize =3D 128m
    packSizeLimit =3D 128m
    windowMemory =3D 128m
[core]
    packedGitLimit =3D 128m
    packedGitWindowSize =3D 128m
    repositoryformatversion =3D 0
    filemode =3D true
    bare =3D true

I am running=20
git version 2.1.4
=20
on
Linux infongp-de65 3.14.0-ui16196-uiabi1-infong-amd64 #1 SMP Debian =
3.14.73-2~ui80+4 (2016-07-13) x86_64 GNU/Linux

Anyone out there to help me getting out of this trouble?

Regards,
Raffael

