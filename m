Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE681C0DE0
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711803620; cv=none; b=iIAVdoxNm0Vru99nFX/Y/p7fwd/NSBZWJ9xfXl9ewU+BcMceSiAuEACYLJd3qKlpg1P5z96epr4ekrys+1tN64mIw1sGnEuFImrmNhhK+INsh2AHPMSNOkI7qjEZ2lIX16BFT4di4bXw+pq9xB5pHWudIiLoyINoskApG3YkcGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711803620; c=relaxed/simple;
	bh=w623B2umjbT9V7UZVaeC3goLXJc21YHu5e1dDZ8GEGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KECUdnwkQXiKLm5cET2KlsuV1qUybOvqK7nQ0isLCepbfiRDOIc38iJJ3Fk2BsDyIzGyvSZQYJ6p0iKTigmzDUvRR7uHnvF6aoP2bLZfMraI4ytB31TS0TVCK9oU3Xz3SwhT2AEPRNWrgIzT8O6POMOfqgCT66JWFm7A5rI6Zts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nabLusZz; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nabLusZz"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d68651e253so39425951fa.0
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 06:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711803617; x=1712408417; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnRB+NGBNvgfhFRAX9hJm9qJtkCKr6QpSjv8NifAfqI=;
        b=nabLusZzbdXFUOnKFOUBhkYeAaXALun1Cf+y9BXjEXvyQWi77/wr9ZY/Mh9pxEHuEs
         ITcNVJmBwPzD5KnCcBysn+fxKkgeXdAvtcbB+Yr/Yi1bqZwFFeOW1/2klTFHxu3kK8Ot
         NiwrwmlYflwgqgYES6iJaFcA+gdINpZGWU14hkwNtH2dd+ap7pejifliXf0xjvm9L1Cn
         f64qHbfDplfXCYgfTSaLGInMElnbgDBXRhHGfisQjZ9BhccXk7MJ35cQ94sDRW7tQOJU
         /se2dQvq+l8+4QOttPLfwtnk1dJbK/Op/q1KWAVYjkBvhML4UqhIKoEjs9VefDmxPNJ7
         5+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711803617; x=1712408417;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnRB+NGBNvgfhFRAX9hJm9qJtkCKr6QpSjv8NifAfqI=;
        b=cEjWK/+/UG1lnCp9lQxXeVz8PxSqXqcQ2ldi6QcqjfGGVYiHjtUzEJYVw3800vG1LW
         f1EFK/tCmO0EhzNrbXsvEuHaRI1mvkwAWgjtrTCyvXAnITm2qe9weReT+Ccd5NAjcQ2F
         UWBb0WgpWSIkRFuSdJVaKGy9V+8art/A4j8fppJssy2jIVnL+V26imZrIUltI55SHhX/
         dD1bK9lWa5SAcYZXiJ9NJ7T8GEmXi3TshOP5y/1lk+rri5F95oXO5C0BwABfkUHFz+dV
         Wr1ejrP2wEnpkrVyUwcB++25K7FNBuxhrEym1qPSYxPBt2v4VjEFtyuOuQSWccVGFkpf
         b4LA==
X-Forwarded-Encrypted: i=1; AJvYcCWYn27eGuf+cxLwOsR6mVz+UZ7v2t1jRZS5QlMSop9/ZSWdDJL8z/efJMiFspUMKyd/NS68B1YnrIiP7c3viNhJq2wH
X-Gm-Message-State: AOJu0YzY+GWxxGLmWwp/2HS1gPLmFKqaEA4/d/pikygs0BZWPZYXDduW
	uHioNThs9SP+E1AVNG2/rUZmvalF/gtkISZp/340tQIb3QCVDcbbmxKapGOwIomYFtaMn+hWthc
	JstN3nnxNyymJRtHFdayGyjGywZQXTkGyses=
X-Google-Smtp-Source: AGHT+IF7ktVObz2lpCe2E5wO51GZ03CtuYlyBqXMaculh+CS8gODs9TrDwLgP4V4wNXsl9CiGlDub+D/5p15rMdjftI=
X-Received: by 2002:ac2:446b:0:b0:515:a733:2e0e with SMTP id
 y11-20020ac2446b000000b00515a7332e0emr2715533lfl.25.1711803616478; Sat, 30
 Mar 2024 06:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324011301.1553072-7-sandals@crustytoothpaste.net>
 <20240325231609.284-1-mirth.hickford@gmail.com> <ZgIKqJaE79-Erzif@tapette.crustytoothpaste.net>
In-Reply-To: <ZgIKqJaE79-Erzif@tapette.crustytoothpaste.net>
From: M Hickford <mirth.hickford@gmail.com>
Date: Sat, 30 Mar 2024 13:00:00 +0000
Message-ID: <CAGJzqs=QkoAU300V-6-w7VqQgG01rY-h5N43WkTy+sJgGV5W2Q@mail.gmail.com>
Subject: Re: [PATCH 06/13] docs: indicate new credential protocol fields
To: "brian m. carlson" <sandals@crustytoothpaste.net>, M Hickford <mirth.hickford@gmail.com>, 
	git@vger.kernel.org, gitster@pobox.com, mjcheetham@outlook.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 23:37, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-03-25 at 23:16:09, M Hickford wrote:
> > > +`authtype`::
> > > +   This indicates that the authentication scheme in question should be used.
> > > +   Common values for HTTP and HTTPS include `basic`, `digest`, and `ntlm`,
> > > +   although the latter two are insecure and should not be used.  If `credential`
> > > +   is used, this may be set to an arbitrary string suitable for the protocol in
> > > +   question (usually HTTP).
> >
> > How about adding 'bearer' to this list? Popular hosts Bitbucket
> > https://bitbucket.org and Gitea/Forgejo (such as https://codeberg.org)
> > support Bearer auth with OAuth tokens.
>
> Sure, I can do that.
>
> > > ++
> > > +This value should not be sent unless the appropriate capability (see below) is
> > > +provided on input.
> > > +
> > > +`credential`::
> > > +   The pre-encoded credential, suitable for the protocol in question (usually
> > > +   HTTP).  If this key is sent, `authtype` is mandatory, and `username` and
> > > +   `password` are not used.
> >
> > A credential protocol attribute named 'credential' is confusing. How
> > about 'authorization' since it determines the HTTP Authorization
> > header? This detail is surely worth mentioning too.

Would it be accurate to add "For HTTP, Git concatenates the authtype
and credential attributes to determine the Authorization header"?

>
> I don't want this to be very specific to HTTP, so I don't think that's a
> great name.  As I mentioned in the cover letter, I might well extend
> this to IMAP and SMTP for our mail handling in the future, and that name
> wouldn't work well there.

Good point, you've dissuaded me against 'authorization'.

>
> I named it `credential` because, well, it's the credential that's used
> in the protocol.  I feel like saying that the field represents "the
> authorization" sounds unnatural.  It's not wrong, per se, but it sounds
> confusing.

We already use 'credential' to describe the whole collection of
attributes, as in "The credential is split into a set of named
attributes".

>
> I'm open to other ideas if you or others have them, but between these
> two, I think I'd prefer to stick with `credential`.

Ideas anyone?


> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA
