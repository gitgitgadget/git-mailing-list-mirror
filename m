Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EACBC433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07CCE20716
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AoX9sD8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgHMOZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:25:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:57751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgHMOZA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 10:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597328687;
        bh=+z9Pq0pbAIaEibAB+N15r/UUWcNd8fpzaeSyNjcPz4Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AoX9sD8UP5vypwKq++A3K+TnDWYsi3flgdYYY19DsKMdJ4M5C+dTaybUZ9UWaaLH/
         +4Y5xhnjcOWJLdxxiEhRo/wtqmVT44QiL/NIXheMvXelwKPybxQ0FzFe9fmzptQmgb
         uBmGbcS9p1VYRPMWN3ojcnfpjMYOt5EEQlhjp/Iw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.231.116] ([89.1.213.40]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1juRVo0YNb-00HKvD; Thu, 13
 Aug 2020 16:24:47 +0200
Date:   Thu, 13 Aug 2020 16:24:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v7 0/5] cleanup ra/rebase-i-more-options
In-Reply-To: <20200716173221.103295-1-phillip.wood123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2008131608240.54@tvgsbejvaqbjf.bet>
References: <20200407141125.30872-1-phillip.wood123@gmail.com> <20200716173221.103295-1-phillip.wood123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gZc9EWBGmM6K532pB/iSESZs3X3t9wfrltb92UmB1IFakVBzULT
 BnpUvmUOIxZ52u/p9KUI5iMrXbOMZ1T85b1gYG/bo7/6Ochpu/4UPNrTeA9I+2deVGFZkXW
 LjBLY4Vx5NQzKqiJgjTypNBHSrP55SspKpqU6FqyHc7ym5tZxAhMV95SDvRvnu5CQNOOh4+
 Y+TJZfi40mpWq2ykjsSqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CzVF/krU5AM=:0wKiNLOXSQ1bOT7C9ntDnX
 qcW5JCcGvfIxf0kumHJpewjWseOCT+AhAmvnu85pbcLYxbuNKcTTSf+KNsJYq2f42NBEMey8L
 fwAcNK9DEr4arjcl/lxi6DbnYEk6gh9fm9uvEwopuWvjQ2uUv26bdbefQr809Nn6CXUheWrKk
 EiuXU1RiRdcblk8m1NgAi01TZvw8Tbj74iZgnwe05x9eZoeXamXyPBsp5CqY82vVVBgJrgDzO
 LWiPYCbwX7q812shxlAWhNy104zrMyvaa9o5bZKcyhoCQ3YoAmXtNN3CuB63/nIoCvTszInLG
 7xQdbM5ovWt/1SgiLfEUNscANgKakSe3vI3uL0Ei4jMtc+ARX1E2XZPUUyeeOw59zwNM1ve/s
 HAHEwMsA35TaCJdZaCZQwIEeYQZnbhjX3kDakHUoRGjIe7gfx+nGwU8dqvgVChiJaQgxBSwaN
 DTY0+nl3w4ULLMs/YQFYjVCkc9Ht0IbVwp4svZWVJFIgQTfzibCg/iocQOaIII2t5ifls3s+j
 +eBwBjMHcbHdyFWZd0mwsopE2PuqkQQz+VJuQzx6MgzWNdWhW2+g3CRpZXp3gkVjuFJqfqznC
 OfGWpxU1DGjV0g99e16LDE+/Qhmi/QJ0YhYugZv+4DI02CqVxN8GeopHtGR6tvjKaFjzVw6tv
 OxLpaIP7kV55IagCQh2IyTF3U9uv9ZhgNhDEi2VJCqSTPmlhlYjsrRYamws1Lrm0VBY3nbgdv
 ZwD4GY8npApCMP0FCxTgk7hdB83SHXhCcyttEgQ2hzGeLDJoML14DWDJkfunob/DvSf1YYabE
 GQqOnJt86lM28yE1vUJIs8T1qPEBOo9v9S0YV4ZmEU4Wi/yh1s1mtjY51RiuGslZQR8u+s3Pn
 oKWKMWI2InMhYg8357Ieb5sCA/JRq5siyIu79LTHli+UqTnU+DeGxL72SVJVKKptiWd3tmTaX
 DoVqQQxXJyuFDCh9mu4Q0XiC5uLmwbLS6+1Gi+b2IwPvqB7sjJrCXfRahLyEmizxqZGWAmNDu
 r/Y9ARpdvI86Tck8cqBswVwThARwvWPi2NGgVkPGLsRLiChiGgfyNqhoWe6LfCKd870gbp3nk
 KLd/1vViXrBZzlhnHxu/TCz90sS/U05igaGkEwY5xWyZevcTx0fdCFREdnqnAKgMg5HwMsVPV
 nQW26bRlt3UNeWh5PsRHE3iUnLH8MwsZ5ggA9zRGaH9yimCxgGAicaHmSndCx6ZzGRUFLzAjP
 5ucArT2X5WCypZmhhNAGYxbCTQzOloWL6m2HIgA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 16 Jul 2020, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Danh pointed out that the word "ident" gets misinterpreted by
> translators as "indentation" leading to incorrect translations so I've
> reworded an error message.
>
> format-patch and am could do with having their similar messages
> updated in the future

Thank you for this patch series!

To be honest, my hope was that I would get support for `git rebase -i
=2D-whitespace=3Dfix` out of that GSoC project... but I take what I can ge=
t,
and this patch series is in a pretty good shape.

I offered three small suggestions how I think it could be improved, still,
but I would be pretty happy with seeing the patches moving to `next`
as-are.

Thank you,
Dscho

>
> Phillip Wood (2):
>   rebase -i: support --committer-date-is-author-date
>   rebase -i: support --ignore-date
>
> Rohit Ashiwal (3):
>   rebase -i: add --ignore-whitespace flag
>   sequencer: rename amend_author to author_to_free
>   rebase: add --reset-author-date
>
>  Documentation/git-rebase.txt           |  33 ++++-
>  builtin/rebase.c                       |  47 +++++--
>  sequencer.c                            | 112 ++++++++++++++-
>  sequencer.h                            |   2 +
>  t/t3422-rebase-incompatible-options.sh |   2 -
>  t/t3436-rebase-more-options.sh         | 180 +++++++++++++++++++++++++
>  6 files changed, 353 insertions(+), 23 deletions(-)
>  create mode 100755 t/t3436-rebase-more-options.sh
>
> Range-diff against v6:
> 1:  0fc90eaff1 ! 1:  3865fdf461 rebase -i: support --ignore-date
>     @@ sequencer.c: static const char *author_date_from_env_array(const =
struct argv_arr
>      +	struct strbuf new_author =3D STRBUF_INIT;
>      +
>      +	if (split_ident_line(&ident, author, strlen(author)) < 0) {
>     -+		error(_("malformed ident line '%s'"), author);
>     ++		error(_("invalid author identity: %s"), author);
>      +		return NULL;
>      +	}
>      +
> 2:  21cf5e5512 =3D 2:  0b6b19cb68 rebase: add --reset-author-date
> --
> 2.27.0
>
>
