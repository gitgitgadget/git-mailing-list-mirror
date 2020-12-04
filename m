Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DF4C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60892078D
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgLDXSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:18:23 -0500
Received: from mout.gmx.net ([212.227.15.15]:41853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLDXSX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 18:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607123811;
        bh=X1Ys8cH9+vrEX+EH8J9WWVtMfj+XTMsYp/yg/6VoPI0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hluPXS7rCySZMPlKQvvm9kybST1l37dhHqdHpc9/OuPJzXl764ZEYbYa3r5B3ShyB
         K/skP+Dkibg9a+uQi7YrWr2Qal1xNt5RcYwdjOgthT8RwTYavbzq4fmQWahWeECwra
         TOKNwmpORo9fYvM0IsLHl42lu2WsmzNlG3UHItPM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.212.111]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWics-1keiap1C9Y-00X6gK; Sat, 05
 Dec 2020 00:16:51 +0100
Date:   Sat, 5 Dec 2020 00:16:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: check result of index_pack_lockfile
In-Reply-To: <20201204221457.2873935-1-samuel.thibault@ens-lyon.org>
Message-ID: <nycvar.QRO.7.76.6.2012050014280.25979@tvgsbejvaqbjf.bet>
References: <20201204221457.2873935-1-samuel.thibault@ens-lyon.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PJcvn6hWaBTlt4EWQnCsVP5YY2IF3GZSIXI9oXleAMV11w0pI9u
 qfENDqI16x6Bf8RdZjJVoqKdiAnji8xXJRhhpdZn2rdVi4FN7DMU6UbDBQFZAbn87KZAsQ/
 C6Ka9gxxVhnwpxClRmkDWS8S+2r7+hG+MW9Ab3XPerPXunFPCAaeoocu/inufzDKLax1e99
 +AM4wWnwb+yYDqxiDwkDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T3pqwih2f1o=:Q2nBiPEcz+WMbvbrHI2vT/
 7Rom3t3PIP9u3s1l8zuicYuVLLLp3sNaIeg1J2FJisn8riEymtVGes9Q5piLtndMnazu5Dwi0
 +Ei/+7gZlYUwEg+2cB+qPcrWKC2+Aw5mcL8SgLiWiKNeGRHA1lt2MOM93IODMEUtN2yJSE/+2
 1q0iF4dLjpoMttL7+L4xFpNM5lGdld47zhbJNFSBb6F75vMtd00euUMYgcHL8vArejA/Rf3Ey
 R6rTGlpaH4y5E2z8J5CctfuVj39I3yAVkl8zvm4OhqM2W1jXljK8jG5mextD47/5xdIzR91oM
 dhvG8PoqVi7ztRXarBID0K6kaWTxMqWw/6EyN/OR6zBQpy10prQqFoqXTVkMhc8DYZFY0bwmH
 QAVkCgcEturPslHD65c+5iDnwX8xFQ+CSI9jLtbj48WsdbkCn7wj5wKUjnBFV5tFM4T7+Z8DW
 sQv8SRtTK2a9J3QFeBokgx5nMd0sKmYX8lpwxzNJTkZ8juV39vXt4FMdK3BuJLVMRjaAOq6dn
 S/433xVehtqNsLHrZ+DlNXu9559iqALSeQFaF6uvV60WOFoeODABSspirPUmAWC85oJEIPhU2
 AvsSO/78s6so/SkMji5BwhAi/ss9j5MgHRs2HybiPiCPzn+vKdSME9agB3fT+4uUZT15FQ3bg
 QbMD14H6H1Et+InkeA/Jcolzts0xGueQuqrd12OgLkL41UD5c2V5G57qb+zq7Xud+2Epfkj3F
 KJzZSBzqicBj9iqIrxC/CTe06EWzNApcNvkLmBg4d3+eLkNcszReE2CTcU+JpCO9pZgbC433F
 bGm/fdSN+Ld55n80r4i+EdIRYF8+oIc07eCIFr0ZUzI5EbjJAwTtpgRdTnhwZUp+CICoSVv4f
 fDXJ9tKM8S4t4KjSLS1L/tjW2RT2V3R3FZTIvFBaM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 4 Dec 2020, Samuel Thibault wrote:

> The fetch-pack command may fail (e.g. like in test 15 - fetch into corru=
pted
> repo with index-pack), in which case index_pack_lockfile will return
> NULL. We should then avoid adding it to pack_lockfiles, since the rest o=
f
> the code assumes that it is non-NULL. Notably transport_unlock_pack() ca=
lls
> unlink_or_warn() with it, thus unlink() with it. On Linux that fortunate=
ly
> only returns EFAULT, but other systems would segfault there.

Good explanation.

> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  fetch-pack.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index b10c432315..7d31232960 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -915,8 +915,9 @@ static int get_pack(struct fetch_pack_args *args,
>  	if (start_command(&cmd))
>  		die(_("fetch-pack: unable to fork off %s"), cmd_name);
>  	if (do_keep && pack_lockfiles) {
> -		string_list_append_nodup(pack_lockfiles,
> -					 index_pack_lockfile(cmd.out));
> +		char *lockfile =3D index_pack_lockfile(cmd.out);
> +		if (lockfile)
> +			string_list_append_nodup(pack_lockfiles, lockfile);

I did stumble over this or a similar problem while glancing over the
Coverity issues recently. Thank you for addressing it.

In this instance, however, I wonder whether we want to even continue if we
cannot create the lock file?

Ciao,
Johannes

>  		close(cmd.out);
>  	}
>
> --
> 2.29.2
>
>
