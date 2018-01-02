Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA89A1F428
	for <e@80x24.org>; Tue,  2 Jan 2018 19:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbeABTMD (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 14:12:03 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45538 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbeABTL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 14:11:59 -0500
Received: by mail-wr0-f196.google.com with SMTP id o15so17274564wrf.12
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 11:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pAXlY2aeMi1i7/eOcqBpvZENngMXlTasZCmX0hU1I0g=;
        b=f2+f6R3R4AEpKp3NceNBQzp1/h3cIyPdMR7Zg1cHNNKyE/lKMs707MF2sqgET66Bvw
         6lv1+FpLK54B0e6zfKPAHdFEN3cbIFcFpdbTUNrPvhPsEJZ2390t2VCnGLMRnJiqhhKl
         5fUW1WoQCnz46E/5SILRW8hurAMvxhV62PfCtGJQGhOR6fCI8FILhxJDsSrv7nr3qdmn
         zqO48Z2vUQiCOFaQ6GB+c7OzMsKZ7pZ9Yg9ztPbUB0iDZ1shL7aGeGOow0r1nVKu+/DR
         Am9aSSQ1SKm0M+NFLP9m2T0UJu6GSWfEq0M5QODe+EWWPf8gUzOPS6NCjrFck1f0MTZz
         Y0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pAXlY2aeMi1i7/eOcqBpvZENngMXlTasZCmX0hU1I0g=;
        b=W5ah9R1M2PZqMvfSOLXkuu1rk5tgVrPFpHl+jMGjk75giyLHfRZg4dLdLx/v0urVf0
         ZQgXHbW3BaVpSj9PNFNxXbPSC5pQgWKzkZYToKKvPdHdy+lwb5xe4T9gV/IQejMx9MPm
         eb86qT9QnV62PAtLNjCmnF3eVNnQRH86mfoKKQuonydUEMEsqdcPowYPKBSW0qQM/CeR
         ucsNUh7YJCN1j/e4B7gw3l2GbDhU81qnc2y82xLc+L4D0UlrgOOWua7rsQxlbZXu6v/k
         g/GkMopxzxPsY4u1m7ZXqsxfj2mdrag4NB3CyeB0Dc8/xAQ59QjXaN98DDUBUTy8caCi
         BOKg==
X-Gm-Message-State: AKGB3mK+XtTldhl90qfL7PKQS0DSc53RYPz+TcygqBau6ETPR8vdZEJX
        GBUtf2F3N2b5b/xh6wJnAEg=
X-Google-Smtp-Source: ACJfBouTYaDkZn3INbS1DH0dBi8MxWuAAvLG/UK3ugKJp5X2rpuZrNd2suMsjE7cGZUVF28neAKPxQ==
X-Received: by 10.223.191.2 with SMTP id p2mr31451308wrh.81.1514920318135;
        Tue, 02 Jan 2018 11:11:58 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id z62sm27656258wrb.67.2018.01.02.11.11.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 11:11:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 1/1] convert_to_git(): checksafe becomes int conv_flags
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180101215959.1460-1-tboegi@web.de>
Date:   Tue, 2 Jan 2018 20:11:51 +0100
Cc:     peff@peff.net, j6t@kdbg.org, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, patrick@luehne.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <37D4996F-CC42-4D01-B15E-6287F1F5BF83@gmail.com>
References: <96B6CD4C-0A0C-47F5-922D-B8BAFB832FD1@gmail.com> <20180101215959.1460-1-tboegi@web.de>
To:     tboegi@web.de
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 01 Jan 2018, at 22:59, tboegi@web.de wrote:
>=20
> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>=20
> When calling convert_to_git(), the checksafe parameter has been used =
to
> check if commit would give a non-roundtrip conversion of EOL.
>=20
> When checksafe was introduced, 3 values had been in use:
> SAFE_CRLF_FALSE: no warning
> SAFE_CRLF_FAIL:  reject the commit if EOL do not roundtrip
> SAFE_CRLF_WARN:  warn the user if EOL do not roundtrip
>=20
> Already today the integer value 0 is passed as the parameter checksafe
> instead of the correct enum value SAFE_CRLF_FALSE.
>=20
> Turn the whole call chain to use an integer with single bits, which
> can be extended in the next commits:
> - The global configuration variable safe_crlf is now conv_flags_eol.
> - The parameter checksafe is renamed into conv_flags.
>=20
> Helped-By: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> This is my suggestion.
> (1) The flag bits had been renamed.
> (2) The (theoretical ?) mix of WARN/FAIL is still there,
>    I am not sure if this is a real problem.
>=20
> (3) There are 2 reasons that CONV_EOL_RENORMALIZE is set.
>    Either in a renormalizing merge, or by running
>    git add --renormalize .
>    Therefor HASH_RENORMALIZE is not the same as CONV_EOL_RENORMALIZE.
>=20
> apply.c        |  6 +++---
> combine-diff.c |  2 +-
> config.c       |  7 +++++--
> convert.c      | 38 +++++++++++++++++++-------------------
> convert.h      | 17 +++++++----------
> diff.c         |  8 ++++----
> environment.c  |  2 +-
> sha1_file.c    | 12 ++++++------
> 8 files changed, 46 insertions(+), 46 deletions(-)
> ...
> -static void check_safe_crlf(const char *path, enum crlf_action =
crlf_action,
> +static void check_conv_flags_eol(const char *path, enum crlf_action =
crlf_action,
> 			    struct text_stat *old_stats, struct =
text_stat *new_stats,
> -			    enum safe_crlf checksafe)
> +			    int conv_flags)
> {
> 	if (old_stats->crlf && !new_stats->crlf ) {
> 		/*
> 		 * CRLFs would not be restored by checkout
> 		 */
> -		if (checksafe =3D=3D SAFE_CRLF_WARN)
> +		if (conv_flags & CONV_EOL_RNDTRP_DIE)
> +			die(_("CRLF would be replaced by LF in %s."), =
path);
> +		else if (conv_flags & CONV_EOL_RNDTRP_WARN)

Here we go with CONV_EOL_RNDTRP_DIE if there is garbage in conv_flags.
Garbage example: CONV_EOL_RNDTRP_DIE *and* CONV_EOL_RNDTRP_WARN are set.

Good!

> 	...
> /*****************************************************************
> diff --git a/diff.c b/diff.c
> index fb22b19f09..2470af52b2 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3524,9 +3524,9 @@ int diff_populate_filespec(struct diff_filespec =
*s, unsigned int flags)
> 	 * demote FAIL to WARN to allow inspecting the situation
> 	 * instead of refusing.
> 	 */
> -	enum safe_crlf crlf_warn =3D (safe_crlf =3D=3D SAFE_CRLF_FAIL
> -				    ? SAFE_CRLF_WARN
> -				    : safe_crlf);
> +	int conv_flags =3D (conv_flags_eol =3D=3D CONV_EOL_RNDTRP_DIE
> +				    ? CONV_EOL_RNDTRP_WARN
> +				    : conv_flags_eol);

If there is garbage in conv_flags_eol then we would not demote the DIE
flag here.

How about something like that:
int conv_flags =3D conv_flags_eol & ~CONV_EOL_RNDTRP_DIE;

---

In general I like the patch as I think the variables are a bit easier to =
understand.=20
One thing I stumbled over while reading the patch:

The global variable "conv_flags_eol". I think the Git coding guidelines
have no recommendation for naming global variables. I think a =
"global_conv_flags_eol"
or something would have helped me. I can also see how others might frown =
upon such=20
a naming scheme.

If this patch gets accepted then I will rebase my encoding series on top =
of it:
=
https://public-inbox.org/git/20171229152222.39680-1-lars.schneider@autodes=
k.com/


Thanks,
Lars

