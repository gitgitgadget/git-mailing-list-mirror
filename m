Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125F9321F31
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802551; cv=pass; b=uOTOVoGNQyN0HCT2JISt/zgsKfiN4OEOjYvll+duQa67+eJdp9wEVEntKF8PK5WLSASUvm+Lc1MS3oV6wHE37MrNEkfsOsWjT3XoWFvsq2nCwRLIpCZgaHkDVtF8dq9fdkfGu4YHy7x/rxrt62LTmHI8dXhfRbRpnCz3qIvAcOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802551; c=relaxed/simple;
	bh=M24q7rhFGYW+F4QYbQ99338LqFHfh8YVgSREogtYq/M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=HjINvvJscdR6rIlmYyr494Cggle9r9k9voIPWsKRoAj/t6KY+ij152T6s4Jp2XWMcbyV/Y6kP+aV9xX8nLSDn6D4+Hg5WejCpkRRme5+x0BeG7dumvnk/ZODE7fjc7huNWyG7EeZ+geA9zkFQSl5Wye09ueKeMhrqdu8Mm78Mf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=rNXzjVfs; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="rNXzjVfs"
ARC-Seal: i=1; a=rsa-sha256; t=1762802538; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hyMUIiDHJ7FGvcOnkgXKkFmp0u9avGWU2jejOkpylE5Z1RLehbPas0xEmSZ2NJwgeZHEcU97ARCV8NQs237wmZK6eflo1QHPIr7W7LWPuSijQa9X3h7HNHUsPIkFH/7qw3OwT1ws7RYeUKFW/YGPLyGMXcfCQHptOGBIpfR4HkI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762802538; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=toK0Uew6nUyOYrKRpsL3AEYFfUhXdtz8fJptCkbqBKo=; 
	b=nA0mMeb5v9lGrv35S2lOYJOlD8l8+LuPfg8+G+La9qLDRNcw7njhBaEmqKXOlJub0tF/EgWAIYzYfdAnF45KNbayOI2rs6EYT1DXqn3j74vxmxfNZFF9Fo345VjU8f7ymDuWrHGcDc/uxKuYWpHnE9l15kJmTSEB/LBx1VvaFWA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762802538;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=toK0Uew6nUyOYrKRpsL3AEYFfUhXdtz8fJptCkbqBKo=;
	b=rNXzjVfsvYo/V4w+wD1kBB+zMEe76DTowjy/ok/8XIncIrR1j0H64qPYMsrkHInR
	uB7ez8SEZLrh0q2RCWO70K3S23gPKH27nEO1LofxerFYwQwl1qODYCkTnwqQT1ry5Jl
	eodxjLzzfeAbpwRtFgF+lWTkbYYRN5VQVPrSKkBs=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1762802537247608.5231218059948; Mon, 10 Nov 2025 11:22:17 -0800 (PST)
Date: Tue, 11 Nov 2025 03:22:17 +0800
From: Li Chen <me@linux.beauty>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "phillipwood" <phillip.wood@dunelm.org.uk>, "git" <git@vger.kernel.org>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-ID: <19a6f38130d.beb422c538849.8699301123463603361@linux.beauty>
In-Reply-To: <xmqq1pmcmn7s.fsf@gitster.g>
References: <20251105142944.73061-1-me@linux.beauty>
	<20251105142944.73061-2-me@linux.beauty> <xmqq1pmcmn7s.fsf@gitster.g>
Subject: Re: [PATCH v6 1/4] interpret-trailers: factor out buffer-based
 processing to process_trailers()
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

Hi Junio,


 ---- On Thu, 06 Nov 2025 00:57:27 +0800  Junio C Hamano <gitster@pobox.com=
> wrote ---=20
 > Li Chen <me@linux.beauty> writes:
 >=20
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >
 > > Extracted trailer processing into a helper that accumulates output in
 > > a strbuf before writing.
 > >
 > > Updated interpret_trailers() to reuse the helper, buffer output, and
 > > clean up both input and output buffers after writing.
 >=20
 > Imperative?
 >=20
 > >
 > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
 > > ---
 > >  builtin/interpret-trailers.c | 51 ++++++++++++++++++++---------------=
-
 > >  1 file changed, 29 insertions(+), 22 deletions(-)
 > >
 > > diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers=
.c
 > > index 41b0750e5a..4c90580fff 100644
 > > --- a/builtin/interpret-trailers.c
 > > +++ b/builtin/interpret-trailers.c
 > > @@ -136,32 +136,21 @@ static void read_input_file(struct strbuf *sb, c=
onst char *file)
 > >      strbuf_complete_line(sb);
 > >  }
 > > =20
 > > -static void interpret_trailers(const struct process_trailer_options *=
opts,
 > > -                   struct list_head *new_trailer_head,
 > > -                   const char *file)
 > > +static void process_trailers(const struct process_trailer_options *op=
ts,
 > > +                 struct list_head *new_trailer_head,
 > > +                 struct strbuf *sb, struct strbuf *out)
 >=20
 > So we gained *out strbuf; in the preimage below I see fwrite(),
 > fprintf(), etc. to outfile that is either stdout or tempfile, but
 > presumably the output all will be captured in the strbuf instead,
 > which makes sense.  It is a bit curious what the new paramater sb
 > is, but this is a file-scope static helper, so it does not strictly
 > require documenting.  Having a comment would still be nicer, though,
 > unlike "struct process_trailer_options" that is very limited
 > purpose, "strbuf" can be used for any string processing, so a good
 > variable name like "out" that conveys what it is used for by
 > implication is good, but "sb", which is obvious abbreviation for
 > "Str Buf", conveys no useful information.

Thanks, I would rename the variable in next version.

 >=20
 > >  {
 > >      LIST_HEAD(head);
 > > -    struct strbuf sb =3D STRBUF_INIT;
 > > -    struct strbuf trailer_block_sb =3D STRBUF_INIT;
 >=20
 > We no longer need a separate strbuf only for trailer block; we will
 > see why before we read through this helper function, hopefully.
 >=20
 > >      struct trailer_block *trailer_block;
 > > -    FILE *outfile =3D stdout;
 > > -
 > > -    trailer_config_init();
 > > =20
 > > -    read_input_file(&sb, file);
 > > -
 > > -    if (opts->in_place)
 > > -        outfile =3D create_in_place_tempfile(file);
 >=20
 > OK, so the original code read the input (either "file", or standard
 > input) into a tempfile and prepared the output file stream.
 > Presumably it is now the responsibility of the caller of this new
 > function.  Initializing the trailer configuration is also what the
 > caller of this function is reponsible for, as well.
 >=20
 > So this answers one of the questions I had upon starting to read
 > this function, i.e. "what is sb?"  It holds the input string, which
 > is what?  Something that look like a commit message that has title,
 > body and then a trailer block?  We may want to give the parameter a
 > better name?  I dunno (as this is file-scope static, as long as it
 > is obvious to the local caller, it may be OK, but on the other hand,
 > the caller needs to differenciate two strbuf parameters to the
 > helper function, one used for input and the other output, so if you
 > are calling the latter "out", perhaps you would want to call it
 > "in", or "input", perhaps?)

Yes, in is a better name.

 >=20
 > > -    trailer_block =3D parse_trailers(opts, sb.buf, &head);
 > > +    trailer_block =3D parse_trailers(opts, sb->buf, &head);
 >=20
 > So we parse existing trailers from the input strbuf that is supplied
 > by the caller.  The rest of this hunk is rewriting FILE* I/O with
 > strbuf addition.
 >=20
 > > @@ -173,22 +162,40 @@ static void interpret_trailers(const struct proc=
ess_trailer_options *opts,
 > >      }
 > > =20
 > >      /* Print trailer block. */
 > > -    format_trailers(opts, &head, &trailer_block_sb);
 > > +    format_trailers(opts, &head, out);
 > >      free_trailers(&head);
 > > -    fwrite(trailer_block_sb.buf, 1, trailer_block_sb.len, outfile);
 > > -    strbuf_release(&trailer_block_sb);
 >=20
 > The format_trailers() helper function appends appends to the strbuf
 > that is given to it, so instead of using an extra strbuf (and then
 > appending that to the output), we just pass our output strbuf to it,
 > which is why we no longer need the trailer_block_sb strbuf anymore.
 > Makes sense.
 >=20
 > >      /* Print the lines after the trailer block as is. */
 > >      if (!opts->only_trailers)
 > > -        fwrite(sb.buf + trailer_block_end(trailer_block), 1,
 > > -               sb.len - trailer_block_end(trailer_block), outfile);
 > > +        strbuf_add(out, sb->buf + trailer_block_end(trailer_block),
 > > +               sb->len - trailer_block_end(trailer_block));
 > >      trailer_block_release(trailer_block);
 > > +}
 >=20
 > And again, FILE* I/O is replaced with appending to the output strbuf
 > in the rest of this helper function.  Good.
 >=20
 > > +static void interpret_trailers(const struct process_trailer_options *=
opts,
 > > +                   struct list_head *new_trailer_head,
 > > +                   const char *file)
 >=20
 > So the original caller of interpret_trailers() now call this outer
 > shell, which has the same name and the same function signature as
 > the original.  Our new process_trailers() helper assumes a handful
 > of preparatory steps are already done by the caller, so what we are
 > going read here will be mostly those preparation, a call to our new
 > helper, and then printing the result to "file" or standard output.
 >=20
 > > +{
 > > +    struct strbuf sb =3D STRBUF_INIT;
 > > +    struct strbuf out =3D STRBUF_INIT;
 > > +    FILE *outfile =3D stdout;
 > > +
 > > +    trailer_config_init();
 > > +
 > > +    read_input_file(&sb, file);
 > > +    if (opts->in_place)
 > > +        outfile =3D create_in_place_tempfile(file);
 >=20
 > And these are exactly the lines we lost from the new helper.
 > Looking good.
 >=20
 > > +    process_trailers(opts, new_trailer_head, &sb, &out);
 >=20
 > And our call.  "out" should have what we wanted to output to
 > outfile, so ...
 >=20
 > > +    fwrite(out.buf, out.len, 1, outfile);
 >=20
 > ... we write it out.  Good.  For a single long string that can never
 > have NUL in it, I'd personally find it more natural to call fputs(),
 > though.  Use of fwrite() makes readers unnecessarily wonder if there
 > is something unusual (like needing to be able to handle NULs in the
 > buffer).
 >=20
 > >      if (opts->in_place)
 > >          if (rename_tempfile(&trailers_tempfile, file))
 > >              die_errno(_("could not rename temporary file to %s"), fil=
e);
 > >
 > >      strbuf_release(&sb);
 > > +    strbuf_release(&out);
 >=20
 > OK.  We could release out a bit earlier, immediately after fwrite().
 >=20
 > Looking mostly good.
 >=20
 > >  }
 > > =20
 > >  int cmd_interpret_trailers(int argc,
 >=20

Regards,

Li=E2=80=8B

