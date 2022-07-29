Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A71EC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 15:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiG2P4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 11:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiG2P4W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 11:56:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A000A60538
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659110178;
        bh=ea67fk2q7TME7gKzYcaX1U9rYRiQCmoc6fMzHwWR4f8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cgTWplQe7A3yGH07KSG92lnjibGH4sg1HWSvS5g95rMyclAS4dXepSe5mueJMCaI2
         0Fx5WYhrIH+8gopXUm7BZSFO0T227JxCJ/4cUZIq7c3eaA7C2WQWnO3u1oVE1kVeiY
         k2kwmCE8ymp1ls1jhNuY+7Yktbiw/08Ag4OwHNxA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.244.62] ([89.1.214.237]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAwXh-1oBAoV2GOf-00BIx7; Fri, 29
 Jul 2022 17:56:18 +0200
Date:   Fri, 29 Jul 2022 17:56:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] mingw: include the Python parts in the build
In-Reply-To: <pull.1306.v2.git.1659109272.gitgitgadget@gmail.com>
Message-ID: <rq6919s9-qspp-rn6o-n704-r0400q10747r@tzk.qr>
References: <pull.1306.git.1659016906707.gitgitgadget@gmail.com> <pull.1306.v2.git.1659109272.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZotVzl8wmGVGL/Z/6cPeQLmFo218Ab4L9uDiPqqQoZgPK8dKMWh
 uNy/34hEXnSSckp6mR3BuycEgQ1XVaG9aWa3cD9UcJWUX2xwFjSdsB/zJ7gIpDJZ14iWMyc
 fmBc+qQj9HJ1ILyHX5SQ9BaVMDqbv0649lxv6w11nxp2dMw363ZAWSstxHngDn+r9IQzrM1
 7cMaSIim06amToyeLS/eA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uNpjH5WmoNc=:byRezhCWAAuTUe0EJ39dXw
 7gdBL8dIxa8M0ZzA3y4uRAg+WqBy3B/3c6LxU0Ni6eI+lJIpiCIcmvFsE16OMO3ZPasYlbIyo
 A45Y8nc56xI9F7+p96FboS0WOEHqE2x+FMw0/AhR9ZarjUefrZoqr3ShfCCpBD9848E/VaDWq
 wxYS5I0DAhKjh07EgG76/wvhCNJr+C1EuFYGM9MFZ2fgfHUGICmrnPp2FRhgxxx933bS4IDGN
 Xj9kpCDKZgRt8LIn0eB7k9c9brDtKh1VEEA6tHb9wUcBmY6ftMxP2jObNFD3tFt2i13297nEK
 CUkwHLAoD9GChenKco64M+7k8HOhy4xXElmYDpd35DXQiB7bLR7bMGM3F6HpLsn9u37ZvSVQg
 fKxUKX+hvQWMLcY1n4tznaY8JN7vZnKsj62iwBkGmOZMWyTtYRRZs8AwASkE6bt/LJ/L7Yn5u
 VzW+0pk1QL+iOS5Segzzqo5GpUEmLaJdrfFIpSHHrxqmWL3J4ocpNn80FiooeiRAs6yMmUQSl
 5YpVMtWm26hnST0qvYXrTJkkzNjEXiIQx/aC/1q/RvnK6P6vYVPjG6fr2lS6Yb7bFrBzRXaho
 BmE07poLh1CxTNpxUaJ7Ioh5uoMehjvemlRMZTSvSQ+HfdaZDlqsdIk8j5tMdue7UsiPj7Vhr
 wIQT4s1/t+X9RLMZ7YLm+0iXOlAGmcvIDU+CRsnfrkn3EdJ4LKcCkCpEMaoFKyuDxQv8cKpja
 GWAMGiZDxQ0CNqfvOkXv8fGFO4ty+zEwLe/cDH5rPcD6Ns+tNpL8cCIybB+CJHeQksVuu29+X
 nuHB/+mk4y/hplyxidXO+oTrfoXiPh3/ndSd0Tj1gRPHG7e0TAn8qJQ/UC37Rb85Xgt+eNC1q
 b/aBzF4J96yxUntq7jxD5FylM4Z5JV43OE5XYkx8ZuPmGYjS8n3FpMkoSMbZOfp91UpyzZlmH
 UJW6aY9QmgT/ZqXgABofNioO2e8ZQaWFMG8Rjk19WhtNh8vf4ZYQQI9nUAQJuU6MCyU9CIjZh
 NORb88xBXv02WVcgHzbHvwLjoZTrixFlh2FDvpnxiN0rYzlP/y3OPiSS+q/Lh0fR4/Q59vsqb
 yHyz0oLdWEzBOKiuTjHjjS52NzLn6B1vu/ZNrg8L56LHnNsr4j+IvtAqg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 29 Jul 2022, Johannes Schindelin via GitGitGadget wrote:

> Range-diff vs v1:
>
>  -:  ----------- > 1:  5d9b087625a windows: include the Python bits when=
 building Git for Windows
>  -:  ----------- > 2:  019fb837d68 mingw: remove unneeded `NO_GETTEXT` d=
irective
>  1:  a5739b9cce8 ! 3:  7dc0a1a9aa8 mingw: include the Python parts in th=
e build
>      @@ Metadata
>       Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
>        ## Commit message ##
>      -    mingw: include the Python parts in the build
>      +    mingw: remove unneeded `NO_CURL` directive
>
>      -    While Git for Windows does not _ship_ Python (in order to save=
 on
>      -    bandwidth), MSYS2 provides very fine Python interpreters that =
users can
>      -    easily take advantage of, by using Git for Windows within its =
SDK.
>      +    In df5218b4c30 (config.mak.uname: support MSys2, 2016-01-13), =
we
>      +    introduced support for building Git for Windows in the then-br=
and new
>      +    Git for Windows v2.x build environment that was based off of M=
SYS2.
>      +
>      +    To do that, we split the non-msysGit part (that targeted MSys1=
) in two,
>      +    and instead of sharing the `NO_CURL =3D YesPlease` setting wit=
h MSys1, we
>      +    overrode it for MSYS2 with the empty value because we very muc=
h want to
>      +    build Git for Windows with libcurl.
>      +
>      +    But that was unnecessary: we never set that variable beforehan=
d,
>      +    therefore there is no need to override it.
>      +
>      +    Let's just remove that unnecessary line.
>
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de=
>
>
>        ## config.mak.uname ##
>       @@ config.mak.uname: else
>      + 		HAVE_LIBCHARSET_H =3D YesPlease
>      + 		USE_GETTEXT_SCHEME =3D fallthrough
>        		USE_LIBPCRE =3D YesPlease
>      - 		NO_CURL =3D
>      +-		NO_CURL =3D
>        		USE_NED_ALLOCATOR =3D YesPlease
>      -+		NO_PYTHON =3D
>        		ifeq (/mingw64,$(subst 32,64,$(prefix)))
>        			# Move system config into top-level /etc/
>      - 			ETC_GITCONFIG =3D ../etc/gitconfig

Oh, that's funny. This is actually the first time I personally see
`range-diff` matching up a wrong patch pair (because it really looks for
the minimal diff between the diffs). It is of course nonsense to match up
the original patch with the `NO_CURL` patch.

Ciao,
Dscho
