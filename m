Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5CDC388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 14:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E21AC22249
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 14:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FNfk18NL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442799AbgJUOQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 10:16:59 -0400
Received: from mout.gmx.net ([212.227.15.19]:50601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442716AbgJUOQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 10:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603289813;
        bh=jqOUpD6YkCnB2JXs18O+Pg5LcLBcY3GdvFQnAa2bHxA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FNfk18NLwyzp7goL4huv66k7ELTKuc4GjfHgDMzUOcfVLYl+W9P0iVYgPg0O8C/ov
         1w2XyV1797B8OVhcjtQDYzc68hU7c8FLK4QDOXKb9tW3yY0GOCVDdYvZHHPN1yYpeJ
         Xw7zrdqGX9adSK5uBYB75pwyaHdV6AxsNb6jgVpA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.235]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDc7-1kHIVM1IMv-00uWC2; Wed, 21
 Oct 2020 16:16:53 +0200
Date:   Wed, 21 Oct 2020 16:16:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Michael Forney <mforney@mforney.org>
Subject: Re: SKIP_DASHED_BUILT_INS does not install git-*-pack
In-Reply-To: <20201020025247.GF54484@nand.local>
Message-ID: <nycvar.QRO.7.76.6.2010211614300.56@tvgsbejvaqbjf.bet>
References: <CAGw6cBsEjOnh-ZqXCPfFha=NYEdy7JDddha=UzAau0Z1tBrWKg@mail.gmail.com> <xmqqtuupd5m2.fsf@gitster.c.googlers.com> <20201020025247.GF54484@nand.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cNk3V/r5rtf/RRuMl28Ekz14UNeLVaxdV/g8yz9dDInq/fGPj9L
 6Fozd1A30DEE/tMrjNWVwIgtF/sjgjmvR4c3BZXJNIJVkVbh4Ro9+KmB55VZNrKjWNr1Mf6
 eVdhs7AQw4qnnmCcM2yJzkbngNSyQhI8n8daqe8lFNnM0R837ndGt+tp6B7Fh3p5VHl+2tb
 HsYjmC4WrmTl2GzVRS6Pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PwqmZIRd4rM=:F8K+83oJY6A8YD1d3OVCVY
 Gx5TisQZZWsZy2uXkymdUkthDd1MUb6T6kDJXhu+3t8JGI/7XIH6hsLUdjOUVKw3g//kzHyEc
 heA/XaDOJlqbUcD5BhYKc4vxO+ZXedoQg3BvjEJH7ELhubvPRrHeZUYNWWZyjQAucyFm/E3P8
 AH9G13NtDUscPJv74U9p7U/8UH3AQ3dUfzI+BejrOxAQTl1Ie8WziCD8aHhDFg78nb06fxU+R
 dTFl3CnR5z+LMgz5y6XrKkRhQB+aUQp/2ouJs4NXmgs07BfLs14Y4uq+H6cYQlSj9V/frkldz
 oKK2cWlyVfitYvtg3OjT+SKkTErYk1E4SFTEdMAhMe3DiF4qT2YjeJaE2jabwRo7VqFA90aA/
 XuQHvfhcV6l6Pc3P3Xj83wCRLHhQq8SRK1N13c2tY8qVFR+qh++LVX0C1BwV5Zyb67YVKAqKG
 K1K89pgQcxCsAVECcA1CRtNOJZYxJFtDSWRxuwGL6u5F1UayoAC2we7TnpKKlf0pIAjT9t2+3
 HrL5iHIJ0Rbwi0wfomCQuMW/JeZ+VeT9kScyJF9/rO62eTwYkSQaW7OjFRPY8K3ofHIgO0Cdh
 gFi4ld86wMpbjncXUkyvMZ6I9PFKIRIi5MDG1+CXNN+C1gJ6pVnwX7WniDAR+9LKO/vioupGL
 RoytYAvrp2g/7YtOibUxK6d981fL4Lkhw1a1SQsHSPo6mAos4pKNMBmWswobrHat5AMFMmQJF
 bkaeVXi3vaQyJwiQhz43GQ6Cq/JUWlvHxAmzOBIRquAFxLZrjR67GBW8X1X10khMpkEjP48h5
 CgbRk2SdCf5nbSZ3e1KEHdXmOixpkRWNTFahEj8xRtH8c6N/prbH5qLXh/9c/xO+VrZVNZVLj
 IFyXc0NRKNz4wIce0jbu6IzNbQvcP6zQPwfhi/vj0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Mon, 19 Oct 2020, Taylor Blau wrote:

> diff --git a/Makefile b/Makefile
> index 95571ee3fc..1b2b085765 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2991,17 +2991,14 @@ endif
>  			  cp "$$bindir/git$X" "$$bindir/$$p" || exit; }; \
>  		fi \
>  	done && \
> -	for p in $(BUILT_INS); do \
> +	for p in $(ALL_COMMANDS_TO_INSTALL); do \
>  		$(RM) "$$execdir/$$p" && \
> -		if test -z "$(SKIP_DASHED_BUILT_INS)"; \
> -		then \
> -			test -n "$(INSTALL_SYMLINKS)" && \
> -			ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/git$X" "$$execdir/$$p" || \
> -			{ test -z "$(NO_INSTALL_HARDLINKS)" && \
> -			  ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
> -			  ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
> -			  cp "$$execdir/git$X" "$$execdir/$$p" || exit; }; \
> -		fi \
> +		test -n "$(INSTALL_SYMLINKS)" && \
> +		ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/git$X" "$$execdir/$$p" || \
> +		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
> +			ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
> +			ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
> +			cp "$$execdir/git$X" "$$execdir/$$p" || exit; }; \

This code talks about `execdir`; I am fairly certain that we do not need
anything specific in `libexec/git-core/`. However, for purposes of
fetching/pushing, the mentioned executables should be present in the
`bin/` directory in dashed form, no matter whether they are built-ins or
not.

In a not-so-distant future, we might even be able to teach Git to call for
the undashed form. But the problem there is that the Git doing the asking
is on the client side, while the Git possibly missing the dashed forms is
on the remote side.

Ciao,
Dscho
