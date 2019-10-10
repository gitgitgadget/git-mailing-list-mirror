Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AACB1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 12:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733082AbfJJMAd (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 08:00:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:44079 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfJJMAd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 08:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570708831;
        bh=Br5Nb0S077NzBhxnJHIvMK1WCcjNYR9cxloXRHZ/Et0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aZRSDR6ChzQaYPlcdHHBD5EikmcyAB3UzrTFLvSC9mcLXVlqko81A7QpD7SSi7OQ/
         R1hglBaXhpWdlgMWo3bzhWUqbU5wghnr5DVNtHwZog6V2QSVV2hKqXptBv9UhZylSB
         ucrHbR7Vd8FkFowh/jYS2/33ckajYybnpq7uI3RA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQeK-1iPiOW3j2E-00Aa0P; Thu, 10
 Oct 2019 14:00:31 +0200
Date:   Thu, 10 Oct 2019 14:00:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] Makefile: respect $(V) in %.cocci.patch target
In-Reply-To: <977b19bcf3ef34395288933eb0090b6d9c58864f.1570653788.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910101359530.46@tvgsbejvaqbjf.bet>
References: <977b19bcf3ef34395288933eb0090b6d9c58864f.1570653788.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:65O9fyH3npGDew2ABxTQLOhjHHA9qR6pyMIdlTZip537GvqZZLs
 heskt3Pl8LFKN7wxvINrDHHzxqZ3iJApezd7/8CzGu3Th0E/EM71L6otZjLC36A/0UgzuDa
 xK5F5ZUzqu7Ypw2cX7v8l3OCJkQa9GTPDL7SwZtZ13ixISmalaFWRKrjGeG7p5+OJuhueQb
 7QJtwIRidknTRZEjkn7hA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JDJQmJgEOic=:JiJ94fa8W3KIcyxWrM7Pwd
 FeI92XtXMvRcyP3JDy1yxZ7dHUZjWY3vS77dhzBbwGre6TwIHOHP46EoQTTC1YQ+t/JxzigC7
 JktrTMgY2uUcwP5Sxuw5REfAhSi5sebAf0VH8hZBaTysXpVAsUrJ2Jc/3Y58qttyRacmbVyef
 ke6p8Nix454sERctdxMz5gvj9e1pRjiyZpZn6sWB8wuNmELN+BVZkVE8BX4AVnpOOPKOhazP9
 MCIu5/9ThxCthUOV/PCM+lDyjnmu8iz+C2payEDOJtHnWwCxoQ3+X0AppBLX96RJM3GZWc9Zd
 P08s4z3IamhCKgUm6mTy0G+U4FqtKjwaWVNL7m2UurDajgg4EirzqBDkLPRhX23o43OU4DV6a
 re5nFJc0ElS5hcgBq8JMH98Kcut06JfkAQLxmJEntP2924SmBtDOwWZHYkY6A8fjrOYJtua0U
 cmMvZCLz19xz1cGX5l3snOeHT9Xn7sSZ0+56jJBSSP/C1GMpk6sgjGRKB/DDFzhRFEwEP0Q6g
 G069kyEr71w73WdtaK7IBTJXLuKqD5FUA4Bvbe6xR10E0PxIoZ7LDV5o/wStnP9gZfOoRgn6N
 wiAfF5R6RsVC6jnktlfyBB6hxuzpZbNBNog6Wxob2DR1PLpIGKA4nmQdr1NkeXRCV6pNX2CkV
 sKqpzCS09pjQoU3fE1ZvBW9yhBLIyck/dYFh9mCSU4+zF8L7LXVZBnZU72eoyxqA1u15kuo8Y
 HqBAGPqmjAF+4bnoH72AwT2iQVQ4mtEYtacUHaMYt5zvMLl534xtFWEH5h+JJnw3SW8qS/t8O
 5UUm8M0S2Lm5ohtnVNbaHzQr/zqfECXKVCaL4SWhaccuBERwzd4FmNZuiOXoViIJ3x/Vj+LXF
 n+qttlqOr9+sRoId1mYRbhCl40e2HUG+u9iqxZHaR4iB+o2kVYptmqlZdbx3a2wCYtVPv1Zxt
 kuGcQw5tIXLl2nGiO4HOiSD/DENdXUbmntRBB+AU1dZy/WfV1RYnkHA1V74YbCKYc0vvcC1r/
 QSkdla0z0TZHOFc43fbi4SZuv6NwVYM4sm+Uk78OVXjai631zGVo5QMCdwXHOXheKAN/clBB+
 HG2pvRN5zDN1E5MuAJI3uf4pX3NWao9WNphGAKAzn6sohDLWjPn6olqgm2Y2vLZ5xChrqliHN
 44mYdCK8wRDohm2QGH31FWvGLEt5RFQ3UIj6pSUTFxMMaTK/BixKPQd48irjtKG2XoF/O4UVw
 vd6EjNPX4Es1rQu4yW+d01X1vKqH9qzzKmZ3gZv3ZNwIw8K6elzIER7/ERO0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Wed, 9 Oct 2019, Denton Liu wrote:

> When the %.cocci.patch target was defined in 63f0a758a0 (add coccicheck
> make target, 2016-09-15), it included a mechanism to suppress the noisy
> output, similar to the $(QUIET_<x>) family of variables.
>
> In the case where one wants to inspect the output hidden by
> $(QUIET_<x>), one could define $(V) for verbose output. In the
> %.cocci.patch target, this was not implemented.
>
> Move the output suppression into the $(QUIET_SPATCH) variable which is
> used like the other $(QUIET_<x>) variables. While we're at it, change
> the number of spaces printed from 5 to 4, like the other variables
> there.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---

Looks obviously correct to me.

Thanks,
Dscho

>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index c99361e719..ae45bfc429 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1890,6 +1890,7 @@ ifndef V
>  	QUIET_SP       =3D @echo '   ' SP $<;
>  	QUIET_HDR      =3D @echo '   ' HDR $(<:hcc=3Dh);
>  	QUIET_RC       =3D @echo '   ' RC $@;
> +	QUIET_SPATCH   =3D @echo '   ' SPATCH $<;
>  	QUIET_SUBDIR0  =3D +@subdir=3D
>  	QUIET_SUBDIR1  =3D ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
>  			 $(MAKE) $(PRINT_DIR) -C $$subdir
> @@ -2818,7 +2819,7 @@ FOUND_C_SOURCES =3D $(filter %.c,$(shell $(FIND_SO=
URCE_FILES)))
>  COCCI_SOURCES =3D $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES=
))
>
>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
> -	@echo '    ' SPATCH $<; \
> +	$(QUIET_SPATCH) \
>  	if test $(SPATCH_BATCH_SIZE) =3D 0; then \
>  		limit=3D; \
>  	else \
> --
> 2.23.0.746.g72fc0fc0b9
>
>
