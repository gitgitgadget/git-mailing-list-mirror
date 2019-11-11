Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E16E1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 08:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKKIrV (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 03:47:21 -0500
Received: from mout.gmx.net ([212.227.15.15]:58927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKIrV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 03:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573462036;
        bh=MJS2lDWPy2ZOY/f4Q6zWW1lGf38t0T6CUmEUlYcBvc8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hgJme/nH6B7R5GQn6Teq6MwJ3In89C98lRDqAodMYRxjLkKPlTFUyONvZyVHSRnME
         nyHxYmtP05LF/Xnem9V2W6EuhX4yRkFhD3LIv+rwB+ZJnmAHrjisoOR/dMaiGctVfK
         FS4eOhIpHjsvKZg0B0pUHoPiRcE1NRkjz0HCMK9E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgeoI-1hyM6C2ZCu-00h7XM; Mon, 11
 Nov 2019 09:47:16 +0100
Date:   Mon, 11 Nov 2019 09:46:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Robin H. Johnson" <robbat2@gentoo.org>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] bundle: framework for options before bundle
 file
In-Reply-To: <20191110204126.30553-1-robbat2@gentoo.org>
Message-ID: <nycvar.QRO.7.76.6.1911110943240.46@tvgsbejvaqbjf.bet>
References: <1f7f0aa1e8fae54bf967ae83a160be2b30db634f.1573248640.git.gitgitgadget@gmail.com> <20191110204126.30553-1-robbat2@gentoo.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lamfj7yQ/WqERxqVgNmq8IzTEj4r/d2EAQshyatjuPc1mkUxIry
 s5dZlF3WcSwJBxQ383bIVhIebheZ7k4M53k9zW5wWuBnDcwpD2sJfAn5Ne/JqII9UA3Ft2p
 lxshOJ0oLZfbSnT6fNagQfjU9onRriCOcT1lZ4W4eTBzSdmnKxbte93iVeYIFb4CTIS8JDg
 W+3VtnHnjrTNg6KKEy4UA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S9hYGoTQB0I=:FgAYmv650r6v8LoXMWOwkk
 cyGeI0QLu86+2UElmeZK0XU+jO5HDR9yl4CSRWKbe6PF9FX14HFEyyKyA4irJqnRE9JrEZA2j
 lQcvlTOVB/Htdr1/HDY8qqR94KcpkKT87ZkUJtTboICCeOwcflcTAphLBg9yg9Oulc4deXc/p
 U19hDlkNx+QhiQELmuhtJKZpokZtDNHLWEYbDTg2lLB5HIC9iHLEQOZmlhq7b4p/ApUx2+FV/
 Adza1zFPs/Ni7qa9tj3Qxsvp3skKzJXTVKsYqCoOQ6HOMk/7OBjNqDj+OKq9Sm6/ADBYVTnOV
 as2diXtXla+VvEKNEYk1KA6X1O7nbGwbEk9qMzVA/UdUIj3S5xDwrsKJ3bQUVwPkgpudlCyAq
 6gSwoQKru9Yhw9xDWLKEDbNY+nGoeAs9kx4nSRWjROcuizmDXPsEh6isypKWT70DExL7scXGP
 Bqlir773+PvcVV3vVTNNLTZq+mECc4Rv3wb5qA0xrN2sJzq0xw8vwpl6uZ3AmUc+fM2CQJI34
 Vbr+1wWUJPSovM73fNfg7HruH5+9TVByd10QIvOwdlHhCjZpLM5qk93fZygOom+imQbq/8NCe
 zlW1qtrG0BGFeGZjDdPmgiv4H+nKLlVqPbxehsUkmmCnBZKMTJG85CjCYn4DB5jG2EmTfzNWL
 L/0XOpaMUuuQWwGZLsDpN+DiSjHq6norHWNFZnMQX40wllebPmELl1PWuTgfH+Q0saxcjFCgy
 JFfO7PsWqlcHymq9GsXws926re7GnpU41AozA10FIiq5cHAKOQHiFG1BvXkT3Dhb0+Z6Co2Ou
 P5jbycZ/HE4jX3Ljb2DwTkGpNdGpVCAoGAMP+KNK0lBddabNERXsgv6O9cKWcw3mHuRlMXccL
 8v0Rj+QnxGJmqA+3xPqv3K6iN50n94PkBMTgahwKUmCnt3KtvVFSI8kmk+/WRjAIinmlEHZWg
 TsAc0u5kx572hLfPV9QIWcFzg+piJiP0DG8IAULBOvJV15xyJ/naIylxlHjvItATDZqJfkMWK
 IhR4yQLFXxP11q7Qx+50U+/68x5H5ECp20wwZ0P0OdfhKp1LoYLeGoMTNmqRzCbRBWIGra2ft
 ClQzpwVZ5cU3wzQ2Q4JFqayGDfLR2GoHTmuuJ0CeYR3nOaoMCj5hTxgGcY2P3X+uvuH4NN6wo
 PORceOLE+pWYuFo03v8aIyQPt65Tllc42N/EG0/qnERjWx1sq5Zz4SA9/WlpzdKqfgGiflvFH
 WQOqaNSf0KgIjz+MAjMXxVQc7DvfxLbsHHt6Y4zyk8heoeqH2YKt3vDfyS5o=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robin,

On Sun, 10 Nov 2019, Robin H. Johnson wrote:

> Make it possible for any of the git-bundle subcommands to include
> options:
> - before the sub-command
> - after the sub-command, before the bundle filename
>
> There is an immediate gain in support for help with all of the
> sub-commands, where 'git bundle list-heads -h' previously returned an
> error.
>
> Downside here is an increase in code duplication that cannot be
> trivially avoided short of shared global static options.
>
> Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
> ---
>  builtin/bundle.c | 190 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 145 insertions(+), 45 deletions(-)
>
> I tried doing this via GitGitGadget initially as a test of that process,
> as well as the CI integration side; however as noted in #git-devel and
> elsewhere on the list, vger seems to swallow the mail to /dev/null

I am very sorry for the woes, and I have to admit that I _still_ have no
clue what is going wrong there.

The mail was sent correctly by GMail, at least it reports that, and the
mbox of the cover letter reads like this (maybe anybody else has a clue
why vger thinks it okay to just drop the mail without further notice?):

=2D- snipsnap --
Return-Path: <gitgitgadget@gmail.com>
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm9512770wrn.81.2019.11.08.13.=
30.41
        (version=3DTLS1_2 cipher=3DECDHE-RSA-AES128-GCM-SHA256 bits=3D128/=
128);
        Fri, 08 Nov 2019 13:30:41 -0800 (PST)
Message-Id: <pull.435.v2.git.1573248640.gitgitgadget@gmail.com>
In-Reply-To: <pull.435.git.1573067879.gitgitgadget@gmail.com>
References: <pull.435.git.1573067879.gitgitgadget@gmail.com>
From: ""Robin H. Johnson" via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Nov 2019 21:30:37 +0000
Subject: [PATCH v2 0/3] git-bundle --quiet support
Fcc: Sent
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Robin H. Johnson" <robbat2@orbis-terrarum.net>,
    Junio C Hamano <gitster@pobox.com>

Implement --quiet support for some git-bundle subcommands: create and veri=
fy

Reference: https://www.mail-archive.com/git@vger.kernel.org/msg182844.html
Signed-off-by: Robin H. Johnson robbat2@gentoo.org [robbat2@gentoo.org]

Robin H. Johnson (3):
  bundle: framework for options before bundle file
  bundle-create: progress output control
  bundle-verify: add --quiet

 Documentation/git-bundle.txt |  35 +++++-
 builtin/bundle.c             | 217 +++++++++++++++++++++++++++--------
 bundle.c                     |   9 +-
 bundle.h                     |   3 +-
 4 files changed, 211 insertions(+), 53 deletions(-)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-435%2Fro=
bbat2%2Fsilent-bundle-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-435/robbat2=
/silent-bundle-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/435

Range-diff vs v1:

 1:  c48ff9adbb =3D 1:  1f7f0aa1e8 bundle: framework for options before bu=
ndle file
 2:  5678de06f3 ! 2:  468922581b bundle-create: progress output control
     @@ -6,9 +6,7 @@
          create subcommand. Most notably, this provides --quiet as reques=
ted on
          the git mailing list per [1]

     -    [1] <robbat2-20190806T191156-796782357Z@orbis-terrarum.net>
     -
     -    Reference: https://www.mail-archive.com/git@vger.kernel.org/msg1=
82844.html
     +    Reference: https://www.mail-archive.com/git@vger.kernel.org/msg1=
82844.html <robbat2-20190806T191156-796782357Z@orbis-terrarum.net>
          Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>

       diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundl=
e.txt
 3:  01317800c5 ! 3:  26c7b28309 bundle-verify: add --quiet
     @@ -2,11 +2,9 @@

          bundle-verify: add --quiet

     -    Add --quiet to git-bundle verify as proposed per [1]
     +    Add --quiet to git-bundle verify as proposed on the mailing list=
 [1].

     -    [1] <robbat2-20190806T191156-796782357Z@orbis-terrarum.net>
     -
     -    Reference: https://www.mail-archive.com/git@vger.kernel.org/msg1=
82844.html
     +    Reference: https://www.mail-archive.com/git@vger.kernel.org/msg1=
82844.html <robbat2-20190806T191156-796782357Z@orbis-terrarum.net>
          Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>

       diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundl=
e.txt

=2D-
gitgitgadget
