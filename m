Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49707C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 17:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D84961A81
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 17:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhJAROJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 13:14:09 -0400
Received: from mout.web.de ([212.227.15.4]:46749 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhJAROI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 13:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633108329;
        bh=tmU7Se2UXZBAIolP3kFlKLUDOCrbdJ+XJVzHCDa144o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EXbQTsd5rsxATqI8aNqNbOnosDhZspmOimTiiSgUx34i+nAelQEUzax3BlvzVPpwK
         4qk/K/vH95Je98LIgpv6Dxq8W3wFDyQIldHp/IeOToExcY7WQ/pszheu9/Uq6bRBk8
         diPuDzAS9WVON3bXyaMnZbkLVuHNxelhYekAGLxE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0Le4js-1nBFrh19yO-00pplD; Fri, 01 Oct 2021 19:12:09 +0200
Subject: Re: [PATCH v2 08/11] commit-graph: stop using optname()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
 <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
 <patch-v2-08.11-58683b3d89d-20211001T142631Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fffcb0ac-5952-c8c5-2c8f-c546ef5e3b1f@web.de>
Date:   Fri, 1 Oct 2021 19:12:08 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <patch-v2-08.11-58683b3d89d-20211001T142631Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fYqe7ilVik0/AIXF653XeFG4ayEBVDPXW/+iaDkEF/Ec/cAzDnc
 W9XhVkzNVCFSQhUQuvPcBJgzA+oby4peN6CmR5VYPb6sG8pmEteF7cEgXgEM26lAKJWCEKW
 8iNmjEVZe02fE7FlXernOQuvjUnqdQ/1awL1iLAFfIivgnVHZHLyEetpvjFLNX6AOvH/AzI
 cXY5NsdyMhRCNKawdaO7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3joLgNR+CN0=:f+oDXRJjUf8IImOAQIVYah
 uadKIFkNzH2hHYhIUSPu97vwxRaP6UMH77wcx45LIw9N5Q4FHkvJN7t0qMgh98q8RNUQaisQp
 9YjvKd7FsMxKst83OD06iZCSDaL4HiafMwe303kLSY3j+TL4JW7TqrEkUyK6jrkv6SyJcFCsl
 qj82YgWaLHr5olNV8NvChWxUHUssRLC8RZTgHHDoX5YTBNkvr7PEq83yUvAB1oGywaP9k06Qu
 4WC6jMs3j4/9jlIIgwRttrIrvrJhwHxL8EU9aT3JCuMFyfvXJ1zrtYYvp34CfGwEMIQz2mFbG
 wq3Td84ELwKcRRTU77SLenTtzfxfnibAaJ0YV2cdy+JHeAHO4NsCh15ZCQ1gsweDPWJ4poc3z
 8Q0Oe69j9elRM4CHWVXv+ch42/sADxJzwdvUDVn9fgk0MsJR0S19yV3PuV3erIaZsUHjQCtqH
 cQFVchzUQLyucKIi3IOFUmqocMEdo5wdPyZ20xrJ7zRMVz2wlacl8YmtHrSBabGd6SbvDOR7l
 pjnoDM1C1jjYL5t0Jv4vQOXs0NXbitmXBrLrqm8rfv6UbRhpJ9K4gdQcbuN79BEepudBUbKz7
 wSuUgXbPnUfRuvgFXrI1MWj4J1yGA/rpMw6jOWrojYs9AViQIRiR1Wq3KvdP9nxz1RCkBfO/M
 ssYFfpdydB2mFBeIkgwkiDVa4YjLM9M9l/HQvV+d2dcCBKSLMeN0XzkTpke1l/WAeSZp5nrug
 H22Le/ofc668WVRFObykVLlMuK8sU4CvIZajYsLrL1At+/bOIADvGuuijX91SECWLRJcwBCrt
 RlsfeN+SNOooG+ADrGeQBBxbPWHmsOSQSO1xtwa1jK00D9wpwATURCrqpz92QHKxAKifwQ1dj
 vmcuTsLfklwDEY+TlUlfhxMZ6d8VGPuFhrQzD7UhCGP6juFXl8qMIzV2Jy15Bp0XhY6mkbX0q
 HJ5CiLeVijglhtsz75q/qoNVWhi9uBt7Bwgt3piqOIOLu7fK/f6rJpZ57IE9nZgVF3A/8FmYP
 FOj7FPd3C8bl3p2fhZpKeSaHULx7K+ky3Ue/bv9h3oEWIYATXTU9HDwONG9ESGXyQ2JLTpoTw
 dcDDuvlkaSGXSk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.10.21 um 16:29 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Stop using optname() in builtin/commit-graph.c to emit an error with
> the --max-new-filters option. This changes code added in 809e0327f57
> (builtin/commit-graph.c: introduce '--max-new-filters=3D<n>',
> 2020-09-18).
>
> See 9440b831ad5 (parse-options: replace opterror() with optname(),
> 2018-11-10) for why using optname() like this is considered bad,
> i.e. it's assembling human-readable output piecemeal, and the "option
> `X'" at the start can't be translated.
>
> It didn't matter in this case, but this code was also buggy in its use
> of "opt->flags" to optname(), that function expects flags, but not
> *those* flags.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/commit-graph.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 0386f5c7755..36552db89fe 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -172,8 +172,7 @@ static int write_option_max_new_filters(const struct=
 option *opt,
>  		const char *s;
>  		*to =3D strtol(arg, (char **)&s, 10);
>  		if (*s)
> -			return error(_("%s expects a numerical value"),
> -				     optname(opt, opt->flags));
> +			return error(_("option `max-new-filters' expects a numerical value")=
);

The option name itself is untranslatable.  parse_opt_abbrev_cb() has code
like this:

			return error(_("option `%s' expects a numerical value"),
				     opt->long_name);

This would work here as well.  Advantage: One less string to translate.

>  	}
>  	return 0;
>  }
>
