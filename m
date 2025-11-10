Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359231EEA31
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802093; cv=pass; b=dVfpIlh3cjscQL4eC8LdGOuNxewRO34ZT0x/zSS2qMZj+yA1iVFctDoL69vwaw/Ku04NZxKUkzWF8s9v+lSGxz7xDRq2HOwtNil726TPHvwQKXlxzoEGh7hHbgeekqLVA3oF5GqlBT5xfRc9ptAHqBUABbrQqrDwc/gy3nhjyAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802093; c=relaxed/simple;
	bh=2yNX3zDjb6R7BnutsbIA1ngUV3wdyPlwKbZzQU6x7oo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GdohgFCPOLIOzA71NmTKUfNl2SZpmw4U7lsh5rkqn/j2V4csLdl9jORM79bILGGF9quHAVR6OdoIYwniXvDEpySmyNJWLUJQIct2qzYZ9D0vwXFTP/zpl3xzR2ilULxV9rNE5o/akVo3i0fJTuHSZibiCZ92niHJyN2TcRAbOkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=Hl+wEUHe; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="Hl+wEUHe"
ARC-Seal: i=1; a=rsa-sha256; t=1762802079; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FgvUcjSBYB3rdFNlXTPqte3nxuQb6ywRqsf95Ki83RWMISsdg74LWe3ITrcdKV2vLbb2V2lwpHCbJePcGTVe74JSPugwsRuStK9mQ9CemX3a25Sv3lIbhm2oNlN3Dtz5C8kA86IzT5To5Nl6zWkVHC2kTK91nSAEgVmH6J1psts=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762802079; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fI/x6JiyFpNMae4lnCJDKA1U3/RSTAeh0ahX5ATrD2Y=; 
	b=Lq+1+5RvnqBO4vbDnbrYJroUSsQbKAUykh78UTKkiLuHe/OGBJr8IRKYW7yjFBTNt3ckVpK+X7n26T7wzS9zPHmgjg2zmNox4zlE00lNwvabpXnVuI14Z7fzf8EMND3yFXUsEJuB9Hkq4tHqXPNNRdqXm9O4F7Lqgx2BuYbXus4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762802079;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fI/x6JiyFpNMae4lnCJDKA1U3/RSTAeh0ahX5ATrD2Y=;
	b=Hl+wEUHe8hCf38+16GuOQZJfMD5/vGNKlpBJ5L6VmV5mF3HMEhkmIx7ZWJu2BNs5
	TUkLe1EAuQPUy3umGYPil5cXQRX2prUc0fIKkmbRDoiQSxtRou1F0tuZDuIeYK0SCsn
	wYmtiqVg+F4jdI3xdAA4E13EQDFtzDYIJD4QRRw8=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 17628020768861.7017469708812314; Mon, 10 Nov 2025 11:14:36 -0800 (PST)
Date: Tue, 11 Nov 2025 03:14:36 +0800
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>
Cc: "git" <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-ID: <19a6f310cc5.17364397534057.8623048406766685580@linux.beauty>
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

Thanks for the reminder, I will try to split into two patches in the next r=
eversion. The first one
use skip_prefix() in amend_file_with_trailers(), and the second one switch =
to amend_file_with_trailers().

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

Since trailer_config_init only needs to run once, it's better to move it ou=
tside the cmd_interpret_trailers loop,
even though it already uses a configured global variable.

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

Thanks for catching this. I'll switch back to using a temp file for atomic.

 >=20
 >  > diff --git a/trailer.c b/trailer.c> index b735ec8a53..f5838f5699 1006=
44
 > > --- a/trailer.c
 > > +++ b/trailer.c
 > >=20
 > > @@ -1224,18 +1226,66 @@ void trailer_iterator_release(struct trailer_i=
terator *iter)
 > >       strbuf_release(&iter->key);
 > >   }
 > >  =20
 > > -int amend_file_with_trailers(const char *path, const struct strvec *t=
railer_args)
 > > +static int amend_strbuf_with_trailers(struct strbuf *buf,
 > > +                      const struct strvec *trailer_args)
 > >   {
 > > -    struct child_process run_trailer =3D CHILD_PROCESS_INIT;
 > > -
 > > -    run_trailer.git_cmd =3D 1;
 > > -    strvec_pushl(&run_trailer.args, "interpret-trailers",
 > > -             "--in-place", "--no-divider",
 > > -             path, NULL);
 > > -    strvec_pushv(&run_trailer.args, trailer_args->v);
 > > -    return run_command(&run_trailer);
 > > +    struct process_trailer_options opts =3D PROCESS_TRAILER_OPTIONS_I=
NIT;
 > > +    LIST_HEAD(new_trailer_head);
 > > +    struct strbuf out =3D STRBUF_INIT;
 > > +    size_t i;
 > > +
 > > +    opts.no_divider =3D 1;
 > > +
 > > +    for (i =3D 0; i < trailer_args->nr; i++) {
 > > +        const char *text =3D trailer_args->v[i];
 > > +        struct new_trailer_item *item;
 > > +
 > > +        if (!*text)
 > > +            continue;
 >=20
 > Isn't it an error to pass an empty argument to "--trailer"?
=20
Nice catch, I would refactor amend_strbuf_with_trailers to return error(_("=
empty --trailer argument"));
here and handle resource cleanup then make amend_file_with_trailers return =
this error.

 > > +        item =3D xcalloc(1, sizeof(*item));
 > > +        INIT_LIST_HEAD(&item->list);
 >=20
 > I don't think we need this as "item->prev" and "item->next" are set by=
=20
 > list_add_tail() below.
=20
ok, I would remove this.

 > We initialize "where", "if_exists" and "if_missing" to zero which=20
 > matches what builtin/interpret-trailers.c does if the user does not=20
 > specify any of those options - good.
 >=20
 > > +        item->text =3D text;
 > > +        list_add_tail(&item->list, &new_trailer_head);
 > > +    }
 > > +
 > > +    process_trailers(&opts, &new_trailer_head, buf, &out);
 > > +
 > > +    strbuf_swap(buf, &out);
 > > +    strbuf_release(&out);
 > > +    while (!list_empty(&new_trailer_head)) {
 > > +        struct new_trailer_item *item =3D
 > > +            list_first_entry(&new_trailer_head, struct new_trailer_it=
em, list);
 > > +        list_del(&item->list);
 > > +        free(item);
 >=20
 > We have free_trailers() to do this for us.
=20
I would replace them with free_trailers.

 > > +    }
 > > +    return 0;
 > >   }
 > >  =20
 > > +int amend_file_with_trailers(const char *path,
 > > +                 const struct strvec *trailer_args)
 > > +{
 > > +    struct strbuf buf =3D STRBUF_INIT;
 > > +
 > > +    if (!trailer_args || !trailer_args->nr)
 > > +        return 0;
 >=20
 > Isn't it a bug to pass a NULL trailer_args?
=20
Sounds right, I would let it return an error msg.

 > > +    if (strbuf_read_file(&buf, path, 0) < 0)
 > > +        return error_errno("could not read '%s'", path);
 > > +
 > > +    if (amend_strbuf_with_trailers(&buf, trailer_args)) {
 > > +        strbuf_release(&buf);
 > > +        return error("failed to append trailers");
 > > +    }
 > > +
 > > +    if (write_file_buf_gently(path, buf.buf, buf.len)) {
 > > +        strbuf_release(&buf);
 > > +        return -1;
 > > +    }
 > > +
 > > +    strbuf_release(&buf);
 > > +    return 0;
 > > + }
 >=20
 > This looks like a faithful conversion of the original with the caveat=20
 > that it expects to be passed an array of trailer arguments without the=
=20
 > "--trailer=3D" prefix. Good

Okay, thanks. Junio notes that write_file_buf_gently is only used in this c=
ontext and
 doesn't need wrok as a helper function. I'll replace it with an in-place o=
peration.

 > I'll take a look at patch 4 tomorrow but so far these version is looking=
=20
 > much nicer than the last round.

Thanks a lot.

Regards,

Li=E2=80=8B

