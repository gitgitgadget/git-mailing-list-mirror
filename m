Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936B71F428
	for <e@80x24.org>; Tue,  2 Jan 2018 19:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbeABTiF (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 14:38:05 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46767 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeABTiE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 14:38:04 -0500
Received: by mail-wm0-f66.google.com with SMTP id r78so63209931wme.5
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 11:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ABihSkbsv5HHrZjN2h1A4fIwSAhruSe3C5aiP+L+vWM=;
        b=XlhOg545mgHr/WFoUYLkXFp0GTHf/x3RxZHuYwLjjoei5z/bW3Xr2MklpPOy+LLlO+
         GrBZk3OfNgQbG+kUoqPCOZozUgFXSb9gEYUMOfpBOwfo4UXp4NML8lo1fJtZduOrBeUL
         e2QQCTG/ejKA/M6qACdWvz7b8GZ+GglCGirMKgF9Snh9balcdvmplNBp5ZMXxTVGZ4mT
         I68giR/eDQsYVv22+MTsy5HfiLZ6LMXZH3+NrSzD23sYzO7X+/e9JsICgzHC+j6WVobk
         cnaLaLc/xPvPw3x+kp1GQUtoiJnx1W6Ij9I3nVuBC1osaAnhBwYipjavqO0L8GWeSgs9
         iedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ABihSkbsv5HHrZjN2h1A4fIwSAhruSe3C5aiP+L+vWM=;
        b=cSmz/LINmU4sW9alEJ4gMhawskFNbkfocb1M21Peqj74FPxPH0ano5nrnJEUU295zu
         uncdhCut2u7bseVXUtbbbEJu8IcgzIqm5MeggSS3TNlb50qy/zwMImbnjwOGW3OP0KYx
         Vq/IZ9cFsaI7r1ZR9fkxCmCwcW5hl9mgHWgXsDpd4/dG/ej6a73BzQ3XKlHSWvfIxrlm
         wuZcp9xYG0BrTaKQdGGwTaswAPI5z4xJQPCdlPaQ3l1THKcWhHjvknFFUfGDUWoByigV
         zvV7NGWj0IrbSEvS14W1xd5wxFUjApjGjt/vw3gpBaRl/W5XyNx92MdaR7ipdnhPrbnZ
         bjag==
X-Gm-Message-State: AKGB3mJTz4pCXRo44wdG74te4o9AuRXRfRga9ff7CDig8ZsiLBSBrne5
        nZIM8gRQadG+wTDja/t4vr4=
X-Google-Smtp-Source: ACJfBosw6CKac2F3xjXKXuxWH+Xxq0+nAv31O3Qgt3tWv9olHv3FZ2L0U0q3FN/PZOPJCy0IbZgdTg==
X-Received: by 10.28.151.7 with SMTP id z7mr38926838wmd.5.1514921883217;
        Tue, 02 Jan 2018 11:38:03 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id l1sm14763654wmh.13.2018.01.02.11.38.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 11:38:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/2] travis-ci: don't store P4 and Git LFS in the working tree
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171231160206.19481-2-szeder.dev@gmail.com>
Date:   Tue, 2 Jan 2018 20:38:01 +0100
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C09CC28-A94D-4731-96D7-E8637E248B4E@gmail.com>
References: <20171231160206.19481-1-szeder.dev@gmail.com> <20171231160206.19481-2-szeder.dev@gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 31 Dec 2017, at 17:02, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> The Clang and GCC 64 bit Linux build jobs download and store the P4
> and Git LFS executables under the current directory, which is the
> working tree that we are about to build and test.  This means that Git
> commands like 'status' or 'ls-files' would list these files as
> untracked.  The next commit is about to make sure that there are no
> untracked files present after the build, and the downloaded
> executables in the working tree are interfering with those upcoming
> checks.
>=20
> Therefore, let's download P4 and Git LFS in the home directory,
> outside of the working tree.

I was concerned for a moment that the executables would not be=20
available to the 32-bit build anymore... but we don't use them
in that build anyways.

Looks good to me!

- Lars

>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
> ci/lib-travisci.sh | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
> index bade71617..1543b7959 100755
> --- a/ci/lib-travisci.sh
> +++ b/ci/lib-travisci.sh
> @@ -99,8 +99,8 @@ linux-clang|linux-gcc)
> 	export LINUX_P4_VERSION=3D"16.2"
> 	export LINUX_GIT_LFS_VERSION=3D"1.5.2"
>=20
> -	P4_PATH=3D"$(pwd)/custom/p4"
> -	GIT_LFS_PATH=3D"$(pwd)/custom/git-lfs"
> +	P4_PATH=3D"$HOME/custom/p4"
> +	GIT_LFS_PATH=3D"$HOME/custom/git-lfs"
> 	export PATH=3D"$GIT_LFS_PATH:$P4_PATH:$PATH"
> 	;;
> osx-clang|osx-gcc)
> --=20
> 2.16.0.rc0.67.g3a46dbca7
>=20

