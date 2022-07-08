Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BFBC43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 14:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbiGHOux (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 10:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbiGHOux (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 10:50:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D421C7
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 07:50:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so2144929pjl.5
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 07:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0VRyxebbs8t/vpOohIl4wBe8piBJ5l6ycOHxyNBAuTg=;
        b=MQ3Lx7HMb8/WyzQ0cYP5Wsh7oJIOZdc8Kay8A5q++nG0TUtbTXszr6SSu/ETP9HYBQ
         TkcdIbcrsOAgGh0bhHmWDX/C8UNjYdW2rfD42lQJnOiTiOV+KVPg+Xeog0IffdNWFwQW
         hDN6c0AoNb8J4TWvwmvPfCyBILC5CPrw5zdU1qKPF7fu6S5S5i0jFdYALHR+uW+zv/j1
         C84Xqhtm489i2SuzT//MGgGn+QfWLLbAQBA8/KFasGHfNoKUAX1xFptCHy6IuaV8ysa7
         2w6tkmj8IuNZD/RC9DYtrjaxT7GtH9Ugc3ojOR9tbdXEk8/K3TSV4tSSqHNUwk8H6ARB
         PxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0VRyxebbs8t/vpOohIl4wBe8piBJ5l6ycOHxyNBAuTg=;
        b=OhFdGWZBCXWxiBKdqGReODuBLVuMd7VfFputegQImIURHA4kFZhRLWoVnQ/eabf9Mm
         1WSZWwCe5HE1L60EZJNJbVdN1dUP4DaYfSjU139Q9VXGOqNTaradH+voUsvykGwO/q9C
         9HPC8/Jri+vp/kDJACF5Fry7oqfnlpYRSutbpJ2/pKpDFur1B+ikIuiKpa71esl93Ahy
         CkSHDSZwIcfkw9qxYqVrgefZymdlr4yP4exYGh03n/dkaMoPyq3zKsrcuOmTqVSstyE3
         cWwhTs7+7V2uFp3KH5U5astCME5s5leOjF5FUz9stgLOOWbXd+Ab3Cmcry7KZwemk9IV
         +8ig==
X-Gm-Message-State: AJIora9BvtaV+U4MgyLncImKD6PGCy8e88M/nm+aUl0q3fEI0NCa/DqI
        3RG2PO7OC25WLYhEDhQrNxwwk0W2Mf0=
X-Google-Smtp-Source: AGRyM1sHpNbecgz7iKUFGvfbOkvr+O1gJ7+2aeYemiTy2ERHexHyVlSZCIyjrhYHrTM32SXakE23Rw==
X-Received: by 2002:a17:90b:3b8a:b0:1ef:b87d:309d with SMTP id pc10-20020a17090b3b8a00b001efb87d309dmr230504pjb.176.1657291851598;
        Fri, 08 Jul 2022 07:50:51 -0700 (PDT)
Received: from localhost ([2001:ee0:4fc8:e0b0:4ee7:6ef1:618c:a53f])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902710800b0016be195fd39sm11344957pll.57.2022.07.08.07.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:50:50 -0700 (PDT)
Date:   Fri, 8 Jul 2022 21:50:48 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/4] revision: improve commit_rewrite_person()
Message-ID: <YshESKSHfpcQf/dI@danh.dev>
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
 <20220707161554.6900-1-siddharthasthana31@gmail.com>
 <20220707161554.6900-2-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZKz6LhZjAX0UDBH0"
Content-Disposition: inline
In-Reply-To: <20220707161554.6900-2-siddharthasthana31@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZKz6LhZjAX0UDBH0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-07-07 21:45:51+0530, Siddharth Asthana <siddharthasthana31@gmail.co=
m> wrote:
> The function, commit_rewrite_person(), is designed to find and replace
> an ident string in the header part, and the way it avoids a random
> occuranace of "author A U Thor <author@example.com" in the text is by

s/occuranace/occurrence/

> insisting "author" to appear at the beginning of line by passing
> "\nauthor " as "what".
>=20
> The implementation also doesn't make any effort to limit itself to the
> commit header by locating the blank line that appears after the header
> part and stopping the search there. Also, the interface forces the
> caller to make multiple calls if it wants to rewrite idents on multiple
> headers. It shouldn't be the case.
>=20
> To support the existing caller better, update commit_rewrite_person()
> to:
> - Make a single pass in the input buffer to locate headers named
>   "author" and "committer" and replace idents on them.
> - Stop at the end of the header, ensuring that nothing in the body of
>   the commit object is modified.
>=20
> The return type of the function commit_rewrite_person() has also been
> changed from int to void. This has been done because the caller of the
> function doesn't do anything with the return value of the function.
>=20
> By simplyfying the interface of the commit_rewrite_person(), we also

s/simplyfying/simplifying/

> intend to expose it as a public function. We will also be renaming the
> function in a future commit to a different name which clearly tells that
> the function replaces idents in the header of the commit buffer.
>=20
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: John Cai <johncai86@gmail.com>
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
>  revision.c | 44 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 10 deletions(-)
>=20
> diff --git a/revision.c b/revision.c
> index 211352795c..83e68c1f97 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3755,19 +3755,17 @@ int rewrite_parents(struct rev_info *revs, struct=
 commit *commit,
>  	return 0;
>  }
> =20
> -static int commit_rewrite_person(struct strbuf *buf, const char *what, s=
truct string_list *mailmap)
> +/*
> + * Returns the difference between the new and old length of the ident li=
ne.
> + */
> +static ssize_t rewrite_ident_line(const char* person, struct strbuf *buf=
, struct string_list *mailmap)
>  {
> -	char *person, *endp;
> +	char *endp;
>  	size_t len, namelen, maillen;
>  	const char *name;
>  	const char *mail;
>  	struct ident_split ident;
> =20
> -	person =3D strstr(buf->buf, what);
> -	if (!person)
> -		return 0;
> -
> -	person +=3D strlen(what);
>  	endp =3D strchr(person, '\n');
>  	if (!endp)
>  		return 0;
> @@ -3784,6 +3782,7 @@ static int commit_rewrite_person(struct strbuf *buf=
, const char *what, struct st
> =20
>  	if (map_user(mailmap, &mail, &maillen, &name, &namelen)) {
>  		struct strbuf namemail =3D STRBUF_INIT;
> +		size_t newlen;
> =20
>  		strbuf_addf(&namemail, "%.*s <%.*s>",
>  			    (int)namelen, name, (int)maillen, mail);
> @@ -3792,14 +3791,39 @@ static int commit_rewrite_person(struct strbuf *b=
uf, const char *what, struct st
>  			      ident.mail_end - ident.name_begin + 1,
>  			      namemail.buf, namemail.len);
> =20
> +		newlen =3D namemail.len;
> +
>  		strbuf_release(&namemail);
> =20
> -		return 1;
> +		return newlen - (ident.mail_end - ident.name_begin + 1);
>  	}
> =20
>  	return 0;
>  }
> =20
> +static void commit_rewrite_person(struct strbuf *buf, const char **heade=
rs, struct string_list *mailmap)
> +{
> +	size_t buf_offset =3D 0;
> +
> +	if (!mailmap)
> +		return;
> +
> +	for (;;) {
> +		const char *person, *line =3D buf->buf + buf_offset;
> +		int i, linelen =3D strchrnul(line, '\n') - line + 1;

Would you mind to change those lines to avoid mixed of declaration and
expression. Also, I think i and linelen should be ssize_t instead.
Something like:

		const char *person, *line;
		ssize_t i, linelen;

		line =3D buf->buf + buf_offset;
		linelen =3D strchrnul(line, '\n') - line + 1;

> +
> +		if (!linelen || linelen =3D=3D 1)
> +			/* End of header */
> +			return;

And I think linelen will never be 0 or negative,
even if linelen could be 0, I think we want "linelen !=3D 0"
for integer comparision.

> +
> +		buf_offset +=3D linelen;
> +
> +		for (i =3D 0; headers[i]; i++)
> +			if (skip_prefix(line, headers[i], &person))
> +				buf_offset +=3D rewrite_ident_line(person, buf, mailmap);
> +	}
> +}
> +
>  static int commit_match(struct commit *commit, struct rev_info *opt)
>  {
>  	int retval;
> @@ -3835,8 +3859,8 @@ static int commit_match(struct commit *commit, stru=
ct rev_info *opt)
>  		if (!buf.len)
>  			strbuf_addstr(&buf, message);
> =20
> -		commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
> -		commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);
> +		const char *commit_headers[] =3D { "author ", "committer ", NULL };
> +		commit_rewrite_person(&buf, commit_headers, opt->mailmap);
>  	}
> =20
>  	/* Append "fake" message parts as needed */
> --=20
> 2.37.0.6.ga6a61a26c1.dirty
>=20

--=20
Danh

--ZKz6LhZjAX0UDBH0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQpKtdjjNYPYlBV4GKki1K/DqNHWgUCYshESAAKCRCki1K/DqNH
Wv2wAP4vZGNi8B4UFZFbDrcdonyqTkIqW6uxZJJwyvnmsh7HLgD/YbXEfyp6y3fo
RsIUBrWvIJF00SCH2DcISOYgrlXn/ww=
=DbtN
-----END PGP SIGNATURE-----

--ZKz6LhZjAX0UDBH0--
