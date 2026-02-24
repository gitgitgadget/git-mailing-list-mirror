Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1948E187346
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 06:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771914989; cv=pass; b=FseVT7I6nPYsq50E93YBmhwAXgqNNgbG70azjZUvxV+vc8A51pdtZoiBN6Wcwo4PqgeWgS4ANeVZdDW+RSMEDzt1lWwmhz9wJhbJ6/PSOLg24UBKc1pBwh+O+SHiUgu4F1Vf0jBzxq32rMnjarUbjmybcDXeSmoBpMtAxQ9eBys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771914989; c=relaxed/simple;
	bh=nmhTnoXRMmg/I0fU/KgnYLW1jg2Upe1+glE8LUwMzsI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hyFnmNxdtbPLj3Ec40uJoZw4xhtEOqBgwByjsHLvK6VXIi7s9EwKGb1dndsBULo3HAw/s7lSwfOpBnbTjRBBop7EEBtdivHGfaxHzbSG0rjUfUfjkvj+AZikoafugfIbDja2E5eYbxRy6lC6MCpHRO9pjuU2fniVE+MXEmGC/Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=VcuQOa4J; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="VcuQOa4J"
ARC-Seal: i=1; a=rsa-sha256; t=1771914976; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WQEnWBdqTguJPqcLlpl43ec4pYMRob7Fr/F6HkYDdWdsarbCkjBdDYDZPuxorYzNDN8n1xQVrS17iGjBUWg3Hfe22AmX3lONgtxpNdYeFlwKNKZtvELwhK5ULrlPP2bsnVKcX7fDQB/lIXVRJdVWw3Xt7Dq+ay5opWrCGS0JgM0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771914976; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FzS9xW4yiiVHn1fFV12jF3tF1veGzwmzYwll1RisOSg=; 
	b=m1prLnWy14cB1orBVeXmKRvxqlJfOGaHnygGogDh/uHasXVshvvYxIA92c7hcrwnahVDPUp1vaE/aS6oUoKhFcNjbgsgcgROcwQ6SMnFgkgn50/1chCmbj6atEWf74X8npm0sqjLVRt00JchAziy9R8Z7lR20tyOrwv2vhaRE0E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771914976;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FzS9xW4yiiVHn1fFV12jF3tF1veGzwmzYwll1RisOSg=;
	b=VcuQOa4Jvfv0+RbkMgZlq4Kk0pJJEUdxkRZCz7SPwDLarJ3Bm7yiEioJsm+JCKan
	kmQpesGa8V9d6r1VwK65eWk/dSp+lE3K6KsLzrCn0FeUDkqGB3Sdwp7dGeaMNF/n7Np
	Wq71zviHUeKCLKt95J5ANVympmKXC/Oju/HjW9JQ=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1771914973719449.0248939079995; Mon, 23 Feb 2026 22:36:13 -0800 (PST)
Date: Tue, 24 Feb 2026 14:36:13 +0800
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>
Cc: "git" <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-ID: <19c8e5cd208.389d71793180723.4083726630202768168@linux.beauty>
In-Reply-To: <ef12ada7-13ae-4df0-a823-6f428c797223@gmail.com>
References: <20251105142944.73061-1-me@linux.beauty>
 <20251105142944.73061-4-me@linux.beauty> <ef12ada7-13ae-4df0-a823-6f428c797223@gmail.com>
Subject: Re: [PATCH v6 3/4] trailer: append trailers in-process and drop the
 fork to `interpret-trailers`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Phillip,

 ---- On Tue, 11 Nov 2025 00:38:55 +0800  Phillip Wood <phillip.wood123@gma=
il.com> wrote ---=20
 > Hi Li
 >=20
 > On 05/11/2025 14:29, Li Chen wrote:
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >=20
 > > diff --git a/builtin/commit.c b/builtin/commit.c
 > > index 0243f17d53..67070d6a54 100644
 > > --- a/builtin/commit.c
 > > +++ b/builtin/commit.c
 > > @@ -1719,7 +1719,7 @@ int cmd_commit(int argc,
 > >           OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]=
commit"), N_("use autosquash formatted message to fixup or amend/reword spe=
cified commit")),
 > >           OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("u=
se autosquash formatted message to squash specified commit")),
 > >           OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commi=
t is authored by me now (used with -C/-c/--amend)")),
 > > -        OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"),=
 N_("add custom trailer(s)"), PARSE_OPT_NONEG),
 >=20
 > We have OPT_STRVEC to handle this. The commit message should explain why=
=20
 > we're doing this (because we only want to pass the value to=20
 > amend_file_with_trailers()). Alternatively we could use skip_prefix() in=
=20
 > amend_file_with_trailers() to skip the "--trailer=3D" prefix in this pat=
ch=20
 > and then clean it in a separate patch.
 >=20
 > > +        OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_=
("add custom trailer(s)"), PARSE_OPT_NONEG, parse_opt_strvec),
 > >           OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by t=
railer")),
 > >           OPT_FILENAME('t', "template", &template_file, N_("use specif=
ied template file")),
 > >           OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")=
),
 > > diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers=
.c
 > > index bce2e791d6..268a43372b 100644
 > > --- a/builtin/interpret-trailers.c
 > > +++ b/builtin/interpret-trailers.c
 > >=20
 > > @@ -142,21 +110,15 @@ static void interpret_trailers(const struct proc=
ess_trailer_options *opts,
 > >   {
 > >       struct strbuf sb =3D STRBUF_INIT;
 > >       struct strbuf out =3D STRBUF_INIT;
 > > -    FILE *outfile =3D stdout;
 > > -
 > > -    trailer_config_init();
 >=20
 > Why is this being moved?

In v7 I'll initialize trailer config once in
cmd_interpret_trailers() (after option parsing), and keep
interpret_trailers() focused on read input / call helper / emit output.

 > >       read_input_file(&sb, file);
 > >  =20
 > > -    if (opts->in_place)
 > > -        outfile =3D create_in_place_tempfile(file);
 > > -
 > >       process_trailers(opts, new_trailer_head, &sb, &out);
 > >  =20
 > > -    fwrite(out.buf, out.len, 1, outfile);
 > >       if (opts->in_place)
 > > -        if (rename_tempfile(&trailers_tempfile, file))
 > > -            die_errno(_("could not rename temporary file to %s"), fil=
e);
 > > +        write_file_buf(file, out.buf, out.len);
 >=20
 > This truncates the existing file which means that if there is a error=20
 > while writing the new version the user is now left with garbage rather=
=20
 > than the original file which does not seem like a good idea.

Great catch! v7 will keep --in-place writing via tempfile+rename (no
truncate+write), matching the previous behavior.

> ...

Regards,
Li=E2=80=8B

