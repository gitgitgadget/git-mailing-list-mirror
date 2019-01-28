Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM,URIBL_RED shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E791F453
	for <e@80x24.org>; Mon, 28 Jan 2019 18:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfA1S6W (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 13:58:22 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41411 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA1S6W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 13:58:22 -0500
Received: by mail-qk1-f196.google.com with SMTP id 189so10030368qkj.8
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 10:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ul5b2zNQrOj2kD3UgmrBLODEX5ljV+C5AHwlNaHUvro=;
        b=Kw/OqrslI9WY2R16qdBSvjWGgZqg9HB7h/XeZzh803qsUuSWiOhoAzYxhwnULV1+vG
         rH/fiZS9mymx0zp++n2z8MHqUwGSvcNbGiHkjTGK4YwBercYY2iZK1eGur2XL1dvRHuM
         eqxTutN+8CGCYdMuMZNo7DTGqT0iexRceoscEcgAJ9CcG6TlY1aHq+VunSTSZITcjPPB
         1my9Uhlh6Q69dVknrAzBNfsLYoT97vDkDmWjRqscy5FVH/+cPmNXZCPauMozSD+kRmVq
         IzKe9eBT6NQ5dbFRCZnFO2A+O8LXXDWiufoFR/MybJGADxc8X1ql8UHhaxPbmfz327LV
         AGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ul5b2zNQrOj2kD3UgmrBLODEX5ljV+C5AHwlNaHUvro=;
        b=ujYXQZzfX7SAObsKrCFM/5BJ1ODRjeuFIUofFJVJysu4um/NJGhb0oOTvD7+oRi8M9
         +z4ygQoCZqWCiFzSk1aS6E7MzMxyCwUawGTbsBfO4H8/7FGdGkAA3MC6kf6qu39g1eoG
         UksDJjmZbK5YoeEewPEAzVV96tNu12NHnLU3vE9ZaRJjWmDLVZNAWBQiGwyxFOm6mVDv
         799XyULoUWEYcuW2H4YahbZ1vVuWDIirQxM1UheUGdx8EYb7TjuxH94jINwaQqNAj8xq
         PDszh3IntBDcNw7dG/tS64zb8m4EzM2w13uB4WdwiK2vl7Cn6iAJtI85CVI6qU50e6Gg
         C6nA==
X-Gm-Message-State: AJcUukeKh5RuSdbKDU2CbpQZgLe61SUPplsTkQ5mZgKemFVhmv+qRQEv
        kYAqlCUUsIPVXKvBmDLtIDc=
X-Google-Smtp-Source: ALg8bN6aSrC0l+a6VpNgf3upzWV/bqniBkC+drS30ANHxxj5oOHrJRpDu0DYhFWQ4qpGVLbIrCBctw==
X-Received: by 2002:a37:bb82:: with SMTP id l124mr20066521qkf.188.1548701900800;
        Mon, 28 Jan 2019 10:58:20 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id d199sm64685132qkc.76.2019.01.28.10.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:58:19 -0800 (PST)
Received: (nullmailer pid 28202 invoked by uid 1000);
        Mon, 28 Jan 2019 18:58:18 -0000
Date:   Mon, 28 Jan 2019 12:58:17 -0600
From:   William Hubbs <williamh@gentoo.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, chutzpah@gentoo.org, williamh@gentoo.org
Subject: Re: [PATCH v2 1/2] config: allow giving separate author and
 committer idents
Message-ID: <20190128185817.GA28155@whubbs1.gaikai.biz>
References: <20190125215955.30032-1-williamh@gentoo.org>
 <20190125215955.30032-2-williamh@gentoo.org>
 <877ees4a65.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <877ees4a65.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 25, 2019 at 11:58:10PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Fri, Jan 25 2019, William Hubbs wrote:
>=20
> > diff --git a/Documentation/config/user.txt b/Documentation/config/user.=
txt
> > index b5b2ba1199..18e1ec3c1b 100644
> > --- a/Documentation/config/user.txt
> > +++ b/Documentation/config/user.txt
> > @@ -1,12 +1,39 @@
> > +author.email::
> > +	The email address used for the author of newly
> > +	created commits.  Defaults to the value of the
> > +	`GIT_AUTHOR_EMAIL` environment variable, or if
> > +	the environment variable is not set, the `user.email`
> > +	configuration variable.
> > +
> > +author.name::
> > +	The full name used for the author of newly created commits.
> > +	Defaults to the value of the `GIT_AUTHOR_NAME` environment variable, =
or
> > +	if the environment variable is not set,
> > +	the `user.email` configuration variable.
> > +
> > +committer.email::
> > +	The email address used for the committer of newly created commits.
> > +	Defaults to the value of the `GIT_COMMITTER_EMAIL` environment
> > +	variable, or if the environment variable is not set, the `user.email`
> > +	configuration variable.
> > +
> > +committer.name::
> > +	The full name used for the committer of newly created commits.
> > +	Defaults to the value of the `GIT_COMMITTER_NAME` environment
> > +	variable, or if the environment variable is not set, the `user.name`
> > +	configuration variable.
> > +
> >  user.email::
> >  	Your email address to be recorded in any newly created commits.
> >  	Can be overridden by the `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL`, a=
nd
> > -	`EMAIL` environment variables.  See linkgit:git-commit-tree[1].
> > +	`EMAIL` environment variables or the `author.email` or
> > +	`committer.email` settings discussed above. See linkgit:git-commit-tr=
ee[1].
> >
> >  user.name::
> >  	Your full name to be recorded in any newly created commits.
> >  	Can be overridden by the `GIT_AUTHOR_NAME` and `GIT_COMMITTER_NAME`
> > -	environment variables.  See linkgit:git-commit-tree[1].
> > +	environment variables or the `author.name` or `committer.name`
> > +	settings discussed above. See linkgit:git-commit-tree[1].
>=20
> Looks correct, although I wonder if we're at the point where it would be
> better to present this info as a table.

Maybe, but can we have someone do that in a separate patch? I ask
because the documentation is not in a markup language and that would
make setting up a table difficult for me at best with my screen reader.

> > diff --git a/builtin/am.c b/builtin/am.c
> > index 95370313b6..53fdd22c45 100644
> > --- a/builtin/am.c
> > +++ b/builtin/am.c
> > @@ -1594,7 +1594,7 @@ static void do_commit(const struct am_state *stat=
e)
> >  	}
> >
> >  	author =3D fmt_ident(state->author_name, state->author_email,
> > -			state->ignore_date ? NULL : state->author_date,
> > +			WANT_AUTHOR_IDENT, state->ignore_date ? NULL : state->author_date,
>=20
> This & a few other things in this series take the code beyond 79
> characters.

This doesn't look like it is beyond 79 characters to me, but that may be
because I use a tab stop width of 4.

Can you reply again and flag the lines that are longer than 79
characters?

Thanks,

William
