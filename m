Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC9EC433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 10:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4BC64E32
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 10:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhBJKqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 05:46:36 -0500
Received: from mout.gmx.net ([212.227.17.20]:53151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhBJKoX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 05:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612953765;
        bh=tVIPporNWqXE3/Fvk65D9Q8GwvwF2yFJI2DV5AvbT50=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bOMaBtaRL1CSgBvBwthyQ2KS4UhjdSCmdG9Wnn/KY91ZpXgRdsKNCHMjh+YoPVbdf
         00potAcfpr2pFYLg2h3nZfsUP47+Kv3VEjIzIiSsRXD3/btBbncd2cdif6i5DGw2oJ
         vCIsa48C4EHirbfx94Q4n73tPPzo3+ZqMAVmOiYU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([213.196.212.209]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKGP-1l7Fqm2nph-00Fgyk; Wed, 10
 Feb 2021 11:42:45 +0100
Date:   Wed, 10 Feb 2021 11:43:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH 07/10] grep/pcre2: use pcre2_maketables_free() function
In-Reply-To: <20210204210556.25242-8-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2102101142020.29765@tvgsbejvaqbjf.bet>
References: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com> <20210204210556.25242-8-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-395204050-1612953783=:29765"
X-Provags-ID: V03:K1:XL88yaQ1qT0Sznm2IqDwKoNV7i6eXb5fZ1VPfLXU/RG55VROutU
 XkH1xQExyfltaQaCXFuiRehRc+WQv0TqpdsvOP78JzhBBiicoDhomB+YeTPS4ktY+RIPZr4
 HZaXOLa3NNoxWjhAVB4Hl/N0HpD8dMoBvcDRYuKZZREzTT0J5b0eqghhIBPxfi7USiNLTKm
 qjE91dZDBWJb3c9kv2pVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n+nIKW/JRok=:t82xQBmN8NN8OkX1iU/RgT
 WkZOS6krWLTs83fbkMDsqcae6Alji1vmCuFJzOJdChYowPsMsyMbEmBCc9kW42pD7cJUodTW2
 9hvK5IsEQQbVv7i+0jnNk18WGRK+rhdwSnTYDtDD39sYbfyWW/yYzb4nLrpfV3SUy6OoVbUFq
 pJ/B4qyr5q7OwR+g6zEj5P4XVpIKdl4ZEztOlk2ShiktEw9HKv4bB2n1kEJg+QoUKxKfdrn/k
 4Ses9ZKSgCHwLVNZw/3kQwa080gI0lmfFYxzmpNU6HhHuWC60/XSyWBxqpdMkatA7vUG9bplQ
 Z9IEH7Wv9CdAdRv0CPiACMYmZFYKvdQ3TgbEU+Jd47GqTD9lxW5bFl+p1zmPdrU3JkEyMBCHU
 BDtlNxTItvoH42DDs1NFIZbj+1O2LcB+wxdMffOBzJwhr4ZkiJHDXwx2r7uhsWb42uRrzjI4j
 9JPEdGN2XehEovI4ySIc0/Tgn1Cghqgw+cqrzrz7GZP4yl5LmW2Hc6jBPUicRs+tTqQkwgSqy
 vMhZnYPuG//4WuzVU4CLwewuY4ZLu+pqgcpgz4fO7USFl4ISNtrjMJZgJdsnOf/NLET7uFnxl
 o4ZFj+DVD+UO7NnGvJg7TxcJAbQGc6Xm63/si5/RGxxEPZdpLHJiG2GbrX/hCGZnQefO9phJz
 zMX8JgEYg8T8lm2AXMqff9a/3VFwO8Yk8GhizZEE3lfVYfHEZGu7kGAw0lBXqcwhzmwMTZVcR
 1X9loDbsmM+l4kSuPbhEjW58qDI4wrhOYvb9LI81aFSsZpooPWLB0ziG0bGj0sCLsTtAxrQ9f
 sIDNEfnTCiHtecsy3AHwTPwjQ3c8YW5DpLMZRbamX6VR4LtLLyF2LPyrFn1ohMnv8zjtmP1VW
 E/GcVg5bMsHo740xdwlVFaZUSa8/GxtAeAyUTuR+U=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-395204050-1612953783=:29765
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 4 Feb 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Make use of the pcre2_maketables_free() function to free the memory
> allocated by pcre2_maketables(). At first sight it's strange that
> 10da030ab75 (grep: avoid leak of chartables in PCRE2, 2019-10-16)
> which added the free() call here doesn't make use of the pcre2_free()
> the author introduced in the preceding commit in 513f2b0bbd4 (grep:
> make PCRE2 aware of custom allocator, 2019-10-16).
>
> The reason is that at the time the function didn't exist. It was first
> introduced in PCREv2 version 10.34, released on 2019-11-21.

Git for Windows still uses v10.33. Thanks for the prod, I will update the
library.

Ciao,
Dscho

>
> Let's make use of it behind a macro. I don't think this matters for
> anything to do with custom allocators, but it makes our use of PCREv2
> more discoverable. At some distant point in the future we'll be able
> to drop the version guard, as nobody will be running a version older
> than 10.34.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  grep.c | 4 ++++
>  grep.h | 3 +++
>  2 files changed, 7 insertions(+)
>
> diff --git a/grep.c b/grep.c
> index e58044474d..c63dbff4b2 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -490,7 +490,11 @@ static void free_pcre2_pattern(struct grep_pat *p)
>  	pcre2_compile_context_free(p->pcre2_compile_context);
>  	pcre2_code_free(p->pcre2_pattern);
>  	pcre2_match_data_free(p->pcre2_match_data);
> +#ifdef GIT_PCRE2_VERSION_10_34_OR_HIGHER
> +	pcre2_maketables_free(pcre2_global_context, p->pcre2_tables);
> +#else
>  	free((void *)p->pcre2_tables);
> +#endif
>  }
>  #else /* !USE_LIBPCRE2 */
>  static void compile_pcre2_pattern(struct grep_pat *p, const struct grep=
_opt *opt)
> diff --git a/grep.h b/grep.h
> index 54e52042cb..64666e9204 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -7,6 +7,9 @@
>  #if (PCRE2_MAJOR >=3D 10 && PCRE2_MINOR >=3D 36) || PCRE2_MAJOR >=3D 11
>  #define GIT_PCRE2_VERSION_10_36_OR_HIGHER
>  #endif
> +#if (PCRE2_MAJOR >=3D 10 && PCRE2_MINOR >=3D 34) || PCRE2_MAJOR >=3D 11
> +#define GIT_PCRE2_VERSION_10_34_OR_HIGHER
> +#endif
>  #else
>  typedef int pcre2_code;
>  typedef int pcre2_match_data;
> --
> 2.30.0.284.gd98b1dd5eaa7
>
>

--8323328-395204050-1612953783=:29765--
