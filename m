Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5BF12098B
	for <e@80x24.org>; Wed, 19 Oct 2016 17:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941446AbcJSRHi (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 13:07:38 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32948 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941415AbcJSRHh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 13:07:37 -0400
Received: by mail-qk0-f194.google.com with SMTP id f128so2456795qkb.0
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c/yfblT8hqiOkviRG49TGYulvXKnJpCvl6c9y6lDOp8=;
        b=yQeJ9oIsaKvrJb8Tdwjnbt7MEpMi/+ZZcqyZ0M/ATN60rohtLvL0X/g2G+2gDfCZGM
         J/6rvU5grLCbBSQQd+e00BELcIsG4jodMD7DbZlnxzvRTD6x8i1+UqYTSxrULbS71NIC
         f5OtteSChoVHC/3zylCXzJiKPQ6fMJRpUEsg+vs2X23clB5jbYPT72n5vJW5YYD7GVjB
         B4mtNm7dmMgdCG2nx2bpYmYYvMIL0JKOC+1S4zxMDo6/YEIg55pShk+yT7GWOZlXh9Hi
         Vw8p10E6LIW0NFzCZyw58Cqzj7qxg/FKqsSKsr5HQyX9aVpXQBmv2k/rgVf6NDufAd5P
         BwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c/yfblT8hqiOkviRG49TGYulvXKnJpCvl6c9y6lDOp8=;
        b=VdMV8uVYGJnjn2zABYHIyJxrfvatFjA0rVykXL/fNDjP6SErNgY0oiHij3AC1/kFHD
         3HBkgvHJh58BfJA6I6V58nn4+t8D1PjEoeGHCPnGVl351/Hl9eKfFAvD8OZ3aeSet/Um
         S2MkgHspsaSefCxG61zLeWq3pf/Jrvzc+cd3fBYfjCqtnMiKawcWn9WJfxunHrzoOMcg
         SditOuqlrBZGe92O2iNpSyT8M6lVBczMnqHfUfyU9rBOTt1LJGv6rNBCkRgKwBBHXzuC
         pZtrP3AOYCU+NTupOfySZGUWDgV7OBAEs2I1MwL0L6sjiml18hZeJk4mHyVROWr5qTJG
         RG3g==
X-Gm-Message-State: AA6/9RnclSqROIdPIeWMyAEp0pCfDEqGUqi2eI1Kj2h+8k/fSUm+FAYgwVKLZJXKWuDXHUxq
X-Received: by 10.55.200.27 with SMTP id c27mr2669034qkj.236.1476896855821;
        Wed, 19 Oct 2016 10:07:35 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id p58sm21289419qte.49.2016.10.19.10.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Oct 2016 10:07:35 -0700 (PDT)
Date:   Wed, 19 Oct 2016 13:07:34 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v4 2/7] ref-filter: add function to print single
 ref_array_item
Message-ID: <20161019170733.ey3d53miykn5t5cq@LykOS.localdomain>
References: <20161007210721.20437-1-santiago@nyu.edu>
 <20161007210721.20437-3-santiago@nyu.edu>
 <20161019085543.om7v7eowfaushags@sigill.intra.peff.net>
 <20161019091641.vcv3snlg5xr3yazs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="guk2jnnbgokivvz5"
Content-Disposition: inline
In-Reply-To: <20161019091641.vcv3snlg5xr3yazs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--guk2jnnbgokivvz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2016 at 05:16:42AM -0400, Jeff King wrote:
> On Wed, Oct 19, 2016 at 04:55:43AM -0400, Jeff King wrote:
>=20
> > > diff --git a/ref-filter.h b/ref-filter.h
> > > index 14d435e..3d23090 100644
> > > --- a/ref-filter.h
> > > +++ b/ref-filter.h
> > > @@ -107,4 +107,7 @@ struct ref_sorting *ref_default_sorting(void);
> > >  /*  Function to parse --merged and --no-merged options */
> > >  int parse_opt_merge_filter(const struct option *opt, const char *arg=
, int unset);
> > > =20
> > > +void pretty_print_ref(const char *name, const unsigned char *sha1,
> > > +		const char *format, unsigned kind);
> > > +
> >=20
> > What are the possible values for "kind"? I guess these should come from
> > FILTER_REFS_TAGS, BRANCHES, etc. It's probably worth documenting that.
> > Alternatively, is it possible to just determine this from the name? It
> > looks like filter_ref_kind() is how it happens for a normal ref-filter.
>=20
> I guess that may complicate things for the caller you add in this
> series, which may not have a fully-qualified refname (which is obviously
> how filter_ref_kind() figures it out). I'd argue that is a bug, though,
> as things like "%(refname)" are generally expected to print out the
> fully refname ("git tag --format=3D%(refname)" does so, and you can use
> "%(refname:short)" if you want the shorter part).

Hmm, I hadn't actually noticed that. Do you have any suggestions in how to
address this?

In general this feels like a consequence of disambiguating .git/tags/*
within builtin/tag.c rather than letting ref-filter figure it out.

Thanks,
-Santiago.

--guk2jnnbgokivvz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYB6hVAAoJEEaPEizoFiKVNksP/jdyp3YMG8jyoSs9H50cc4w/
xLz/I/HqLle9gfhZdcyHu1FD3LCTkB1otTcc1sM602SCqlCN6DzVXs0jqFLWr6Rt
hcFVq3FFbe+HvwqHHd0SiDfsbK49MFfUc8P1q91upTjWDTuHoOx4kBud81TOLJvv
RjRGDdL3wYdKoBHxNGJ3Ei+TnFBdutN+U7cHC+aL/XxPA9MaQJ/pVuOuOqGfX2oI
2q/jlTHdMYf7a0aLru7bKG8mkoQZ+V91yXCtLc9Rpd7krBdpWVpbMK1ObHm10EoU
Kg0JIxZS4d4Qiz4KyUtsic2EGCfaGCxLTPeOlQGhl8m6RbYzDOk8fVTtYf1n500y
Jl+jZektWZ3LGXwAdJeq+aQBiMMCnoyKhWRvyZGwyn1wXSApTETGcV+SnUVnQLw/
CP5CGLrEt42mLLaxZB3ytbAxqjagFgYW5Bp1q6JjqmaFkURSpyMlY/uiqj4p07we
qCu67ypAmt/uooEHrxPdCnoUCMDV0DsISPtCPRV767yZQR7QO5IkeyZ5BKIf//q6
lJvpO0M0zW4/z/AGH5oXrLPwlpoU8Z6oBlZzFBIPG/uNzDjVWPjGmSJF4ysk1S7m
H81iNrae9XiUDB1VQbzKVGwEmkJF7r8U91UNxrhf1fm8uTzA1H20tvQ3c0aYavMO
7mo/1XKsNbPBAu12K6eg
=WvMe
-----END PGP SIGNATURE-----

--guk2jnnbgokivvz5--
