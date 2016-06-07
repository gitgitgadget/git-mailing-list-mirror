From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue, 7 Jun 2016 17:13:14 -0400
Message-ID: <20160607211313.GD24676@LykOS.localdomain>
References: <20160607195608.16643-1-santiago@nyu.edu>
 <20160607210856.GA6807@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 23:31:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAOax-00027j-Pp
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 23:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423302AbcFGVb1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 17:31:27 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33557 "EHLO
	mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933208AbcFGVb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 17:31:27 -0400
Received: by mail-qt0-f196.google.com with SMTP id 72so2149363qtb.0
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 14:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1/ZqAWxHuDIc6EiiZQQpXpOdBMXzqTmXvml1aOs97E8=;
        b=ylchJEUpZBElcRCU30nfhc3HMQb7LjfqAmDwKof2TgSn433CQzRJdGrPTWPuG5XaNP
         Jc0faki/RIrV1RTvddcKFJ7e3YZe0DTdY43ettjJA5uXcKkqZWBg7UTTPfqs/YdW72kI
         j91b3ZbsYbIgX1Eb0MKsdW4lMQlxCbnGhQ3094nlFPmeDhc3jcGQcZo6iOS+4pGbLmxy
         tEdJtxlMfcPualpo+MEi0P3TMG7Jj+ldqhBpOPVZRvDkct+Wf+ztl3ctVvlpjyHvCyiw
         Es9qOb0uNKX2RKWktuSnbT/heHID6mvmO7suHt9eEEGsI3s+vUiYc85wd/DKhxe6JuSY
         7Q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1/ZqAWxHuDIc6EiiZQQpXpOdBMXzqTmXvml1aOs97E8=;
        b=AEZgR+7nRnWAT1zmdr3U3PUL8o+Weoa5aH2K5INrgOmm7/J7e8mu8Gl4GF6LqrQR+c
         2qKheoT/w67dZHasYdxDRmuchipxwo971hUO3quTJhZGEY8YUPkU4yXv18wDjeu1cSsG
         XxbB/Qc8rEKnFSP4JOns04pXcJfRRdKbJTMDje7D0Tlm2GnYmBomLJf4xH4y/F3Hcl8I
         xER+OlMjfiBYRjy3Tqd5FKfY3Csaufd6+sWTh7ZI0rGB/5Y4EJL1cydMLF1fHYXTKpPL
         XwbZVP8OrYQuebnxCAPW8uTOdw65ymzXr0vgHMTKcWd9BMXjQjuaRS7zClJr9KSA18FJ
         Xabg==
X-Gm-Message-State: ALyK8tIsufhRolTO0z4U69Mw1bJSj/nYIGw6pn2eX2XGAOPhOCYrR8gk5EKoWfJo3A5q/BeI
X-Received: by 10.200.42.22 with SMTP id k22mr1664588qtk.24.1465333995564;
        Tue, 07 Jun 2016 14:13:15 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-EXP01.NATPOOL.NYU.EDU. [216.165.95.69])
        by smtp.gmail.com with ESMTPSA id s96sm6596966qgd.0.2016.06.07.14.13.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Jun 2016 14:13:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160607210856.GA6807@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296729>

On Tue, Jun 07, 2016 at 05:08:56PM -0400, Jeff King wrote:
> On Tue, Jun 07, 2016 at 03:56:08PM -0400, santiago@nyu.edu wrote:
>=20
> > diff --git a/tag.c b/tag.c
> > index d1dcd18..591b31e 100644
> > --- a/tag.c
> > +++ b/tag.c
> > @@ -55,6 +55,14 @@ int gpg_verify_tag(const unsigned char *sha1, co=
nst char *name_to_report,
> > =20
> >  	ret =3D run_gpg_verify(buf, size, flags);
> > =20
> > +	if (flags & TAG_VERIFY_NAME) {
> > +		struct tag tag_info;
> > +		ret +=3D parse_tag_buffer(&tag_info, buf, size);
> > +		if strncmp(tag_info.tag, name_to_report, size)
> > +			ret +=3D error("tag name doesn't match tag header!(%s)",
> > +					tag_info.tag);
> > +	}
>=20
> Er, is this C? :)

Yeah, I promise this would be a "cleaner" patch in the future :P

>=20
> I think the general idea of an option to check the tag-name is a good
> one. But there are some corner cases to think about:
>=20
>   1. What name are we comparing against? Presumably it comes from the
>      name the user gave us that resolved to the tag object. We would
>      want to shorten "refs/tags/v1.4" to just "v1.4", I would think.
>=20
>      Would a user ever want to pass a different tagname?

Yeah, I was wondering this. It might be convenient for them to call

git verify-tag --check-name [name] [ref]=20

In case the ref doesn't match the tag. I can do it either way, although
the second case would be cumbersome.

>=20
>   2. What do we do for non-annotated tags? Is it always a failure?

Right now, verify-tag fails with non-annotated tags like this:=20

    santiago at ~/.../git =E2=9C=94 ./git-verify-tag master
    error: master: cannot verify a non-tag object of type commit.

Although we could change this behavior. I would have to check how git
tag -v works as this behavior might change.

>=20
> -Peff
