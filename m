Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFF7C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 15:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A25E20857
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 15:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SeXEZI7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388917AbgLAPmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 10:42:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56006 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389376AbgLAPmB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 10:42:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5CBF9E333;
        Tue,  1 Dec 2020 10:41:17 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=w/QX4ZmSjLOVm
        XChU0/Ip5DLw2U=; b=SeXEZI7Je14ULRO1p/XS54QjIQV9/aiybxkNXCFXx2jJu
        Uc832dK1kXF2VRcbnhVDYFFwRlbetrEQZnrsOvqzZ87TcRCe8HLGiKj6+7SOwsGn
        NBkwd4kWqre75+k/3hK0Z8lA3b4T4I6ZhstXNvgWH7yAbHiX4wAeR4hODU//00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=HqRzscz
        HM1lVtWnKxrz4dv4V4wIeFLsvR93hglMOo5SwoleCziW5wS5QK2cjR65vf9mK6LR
        Gs63WKAAAhzlSzh3jhHJM3qAxn6y9KwHKE6YeiH0QwpxaBk8Gdo7TxVNQ2P39FkM
        XyjzYN5GDby1ik8leY3xsTogDNGwFIY8tcdg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAE419E332;
        Tue,  1 Dec 2020 10:41:17 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.178.181])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D3BB9E331;
        Tue,  1 Dec 2020 10:41:17 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Tue, 1 Dec 2020 10:41:15 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Arnout Engelen <arnout@bzzt.net>
Cc:     git@vger.kernel.org,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] doc: make HTML manual reproducible
Message-ID: <20201201154115.GP748@pobox.com>
References: <20201201095037.20715-1-arnout@bzzt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20201201095037.20715-1-arnout@bzzt.net>
X-Pobox-Relay-ID: A6CDD888-33EB-11EB-90DD-D152C8D8090B-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Arnout,

[cc: brian, Martin, and peff, for their collective wisdom in
the area of docs and involvement in the last discussion of
docbook-xsl requirements.]

Arnout Engelen wrote:
> This makes sure the generated id's inside the html version of the
> documentation use the same id's when the same version of the
> manual is generated twice.
>=20
> Signed-off-by: Arnout Engelen <arnout@bzzt.net>
> ---
>  Documentation/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 80d1908a44..4d1fd5e31f 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -380,7 +380,7 @@ SubmittingPatches.txt: SubmittingPatches
>  	$(QUIET_GEN) cp $< $@
> =20
>  XSLT =3D docbook.xsl
> -XSLTOPTS =3D --xinclude --stringparam html.stylesheet docbook-xsl.css
> +XSLTOPTS =3D --xinclude --stringparam html.stylesheet docbook-xsl.css =
--stringparam generate.consistent.ids 1
> =20
>  user-manual.html: user-manual.xml $(XSLT)
>  	$(QUIET_XSLTPROC)$(RM) $@+ $@ && \

I think this would raise the minimum supported version of
docbook-xsl to 1.77.1.  That might be fine, but we'd
probably want to make sure it doesn't negatively impact
OS/distributions which build the docs as a likely group who
care about reproducible builds.  And we'd want to update the
requirement in INSTALL, of course.

The minimum docbook-xsl version was raised from 1.73 to
1.74, in 5a80d85bbe (INSTALL: drop support for docbook-xsl
before 1.74, 2020-03-29).  That change was discussed in
<cover.1585486103.git.martin.agren@gmail.com>=B9.

AFAICT, the generate.consistent.ids param was added in
docbook-xsl-1.77.1 which was released in June 2012.  The
commit which added it is 74735098e (New param to support
replacing generate-id() with xsl:number for more consistent
id values., 2011-10-24).

In any case, a minimum of 1.77.1 is present in the supported
releases of CentOS/RHEL and Debian/Ubuntu, at least (most
have 1.79.x).  Those are certainly not the only systems Git
cares about; they're simply the systems with which I am at
least mildly familiar.

=B9 https://lore.kernel.org/git/cover.1585486103.git.martin.agren@gmail.c=
om/

--=20
Todd
