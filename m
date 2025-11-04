Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59B92E9721
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 11:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257238; cv=pass; b=Rdtxa89mLDPJXcF2UnDdaGH0/wUcotKmNtO/sMMrejLYhZToFvl8nWWSgI5P/UnSk/y4fCKJpVJxjUE/JRuS9qrmkBh8ozhjA7qP8j42MSx6tA8okkoxFaGvYdZ0zVC0/LsiTWHLy5xUVVkUanIzbzsPpxYzxQ1Cud2307PrYLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257238; c=relaxed/simple;
	bh=FX6e2Ox/ke7tUDSO4xEbWqfNGMvA6FulGh5kJ1lWyEc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JbksGYA96/NBQ97m+JP5Tw6E69FNKHq6E//HjIbZxEKZlwgXRL/YhtlIDj8TGDcYv8xy+VCBQHBGtPPRJBo2U4eTCuVJycZngphusT4wYiCzi4JmRHEACPBKwZnijXDFjkk4QSHxvsAQTaUhPZ+eyMO8BzNy7QUcrC+v0lpbGTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=GF1Wxk6k; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="GF1Wxk6k"
ARC-Seal: i=1; a=rsa-sha256; t=1762257223; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c/ieVnpkwzA+mrmSBPAykW5fY6WY7NZAvHAHKM4QWAF1QdqpfN8bA1FfF7uBsg5h+UMUARBjUsY7A0ApxTGRWZIogtR6G+CUVhobi4+w9F3y92NZIgix9blx16QQjii1ZqSu7mULK05YHJDCLoZpgIo17WmWl84X3mlfMHw2rhw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762257223; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ceAETz3bqjEAqW5CwG6oI0wc9i/oCyFGJcXXxYzlg8w=; 
	b=bMImKrkGxKgjprE1zb61w5VaQd9inAcQggNr2r23vg2xCGN0/BD0We97vSXf2p8IPCcq0ZCDuPLfRiX1AugJgqMraTsPzq6CPEOJShseKR9sac8rq/Vysxg+usHBM2UE1tkqjnkbJa1h0cP2AFyF9jqvcngl+lKSGhqzp4YD59k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762257223;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ceAETz3bqjEAqW5CwG6oI0wc9i/oCyFGJcXXxYzlg8w=;
	b=GF1Wxk6kh2U0SMb8nNNch3Y16CZQrsBuZsUo4H72s5vT5RTE8Pg9TJM6ZChMaaUi
	wXcIlg+pzi6s/H4vC8JNqM6mCDc+ZeExwoY9625YWf4v8zkt3kUGFW4o6N6mB8Zz6oq
	OkJ2/wkXBVIIHpxY9gugiz22D9Q+eA/aBwYcHFJg=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1762257222101371.54335145780954; Tue, 4 Nov 2025 03:53:42 -0800 (PST)
Date: Tue, 04 Nov 2025 19:53:42 +0800
From: Li Chen <me@linux.beauty>
To: "Phillip Wood" <phillip.wood123@gmail.com>
Cc: "phillipwood" <phillip.wood@dunelm.org.uk>, "git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-ID: <19a4eb739bb.71f7f93b817785.4090964595844940221@linux.beauty>
In-Reply-To: <7d12b046-365f-441c-af8e-8a39d61efbbd@gmail.com>
References: <20251022053951.602605-1-me@linux.beauty>
 <20251022053951.602605-2-me@linux.beauty> <7d12b046-365f-441c-af8e-8a39d61efbbd@gmail.com>
Subject: Re: [PATCH v5 01/29] trailer: append trailers in-process and drop
 the fork to `interpret-trailers`
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

 ---- On Thu, 23 Oct 2025 21:21:28 +0800  Phillip Wood <phillip.wood123@gma=
il.com> wrote ---=20
 > Hi Li
 >=20
 > On 22/10/2025 06:39, Li Chen wrote:
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >=20
 > > Route all trailer insertion through trailer_process() and make
 > > builtin/interpret-trailers just do file I/O before calling into it.
 > > amend_file_with_trailers() now shares the same code path.
 > >=20
 > > This removes the fork/exec and tempfile juggling, cutting overhead and
 > > simplifying error handling. No functional change. It also
 > > centralizes logic to prepare for follow-up rebase --trailer patch.
 > >=20
 > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
 >=20
 > When I review v3 of this series I said
 >=20
 > >> As I said above reusing the existing code as you have done here is a
 > >> much better approach. However it would be much easier to review if
 > >> the code movement was separated from the refactoring. I'm also
 > >> struggling to see the benefit of a lot of the refactoring - I was
 > >> expecting the conversion to use an strubf would essentially look like
 > >> fwrite() being replaced with strbuf_add() and fprintf() being
 > >> replaced with strbuf_addf() etc. rather than reworking the logic.
 >=20
 > Unfortunately this version has the same code changes as v3 that make it
 > are virtually impossible to verify if the behavior is changed or not.
 > The diff below shows what I was hoping to see as the first step. It
 > refactors interpret_trailers() in place to factor out the code that
 > processes the trailers into a separate function. That makes it easy to
 > see that fwrite() is replaced with strbuf_add() etc. and so verify that
 > the behavior is unchanged. If you view the diff with "--color-moved"
 > you'll see that virtually all of the code in the new
 > interpret_trailers() function is moved from the old one which in turn
 > makes it easy to verify that there is no change in behavior. I would
 > expect the next patch in the series to move the new function for
 > processing trailers into trailer.c and the patch after that to refactor
 > amend_file_with_trailers() to add and use amend_strbuf_with_trailers()
 > and stop forking "git interpret-trailers". Then builtin/rebase.c can be
 > modified to add support for trailers using amend_strbuf_with_trailers().
 >=20
 > Thanks
 >=20
 > Phillip
 >=20
 > ---- 8< ----
 > diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
 > index 41b0750e5af..4c90580ffff 100644
 > --- a/builtin/interpret-trailers.c
 > +++ b/builtin/interpret-trailers.c
 > @@ -136,32 +136,21 @@ static void read_input_file(struct strbuf *sb, con=
st char *file)
 >       strbuf_complete_line(sb);
 >   }
 >  =20
 > -static void interpret_trailers(const struct process_trailer_options *op=
ts,
 > -                   struct list_head *new_trailer_head,
 > -                   const char *file)
 > +static void process_trailers(const struct process_trailer_options *opts=
,
 > +                 struct list_head *new_trailer_head,
 > +                 struct strbuf *sb, struct strbuf *out)
 >   {
 >       LIST_HEAD(head);
 > -    struct strbuf sb =3D STRBUF_INIT;
 > -    struct strbuf trailer_block_sb =3D STRBUF_INIT;
 >       struct trailer_block *trailer_block;
 > -    FILE *outfile =3D stdout;
 > -
 > -    trailer_config_init();
 > -
 > -    read_input_file(&sb, file);
 > -
 > -    if (opts->in_place)
 > -        outfile =3D create_in_place_tempfile(file);
 > -
 > -    trailer_block =3D parse_trailers(opts, sb.buf, &head);
 > +
 > +    trailer_block =3D parse_trailers(opts, sb->buf, &head);
 >  =20
 >       /* Print the lines before the trailer block */
 >       if (!opts->only_trailers)
 > -        fwrite(sb.buf, 1, trailer_block_start(trailer_block), outfile);
 > +        strbuf_add(out, sb->buf, trailer_block_start(trailer_block));
 >  =20
 >       if (!opts->only_trailers && !blank_line_before_trailer_block(trail=
er_block))
 > -        fprintf(outfile, "\n");
 > -
 > +        strbuf_addch(out, '\n');
 >  =20
 >       if (!opts->only_input) {
 >           LIST_HEAD(config_head);
 > @@ -173,22 +162,40 @@ static void interpret_trailers(const struct proces=
s_trailer_options *opts,
 >       }
 >  =20
 >       /* Print trailer block. */
 > -    format_trailers(opts, &head, &trailer_block_sb);
 > +    format_trailers(opts, &head, out);
 >       free_trailers(&head);
 > -    fwrite(trailer_block_sb.buf, 1, trailer_block_sb.len, outfile);
 > -    strbuf_release(&trailer_block_sb);
 >  =20
 >       /* Print the lines after the trailer block as is. */
 >       if (!opts->only_trailers)
 > -        fwrite(sb.buf + trailer_block_end(trailer_block), 1,
 > -               sb.len - trailer_block_end(trailer_block), outfile);
 > +        strbuf_add(out, sb->buf + trailer_block_end(trailer_block),
 > +               sb->len - trailer_block_end(trailer_block));
 >       trailer_block_release(trailer_block);
 > -
 > +}
 > +
 > +static void interpret_trailers(const struct process_trailer_options *op=
ts,
 > +                   struct list_head *new_trailer_head,
 > +                   const char *file)
 > +{
 > +    struct strbuf sb =3D STRBUF_INIT;
 > +    struct strbuf out =3D STRBUF_INIT;
 > +    FILE *outfile =3D stdout;
 > +
 > +    trailer_config_init();
 > +
 > +    read_input_file(&sb, file);
 > +
 > +    if (opts->in_place)
 > +        outfile =3D create_in_place_tempfile(file);
 > +
 > +    process_trailers(opts, new_trailer_head, &sb, &out);
 > +
 > +    fwrite(out.buf, out.len, 1, outfile);
 >       if (opts->in_place)
 >           if (rename_tempfile(&trailers_tempfile, file))
 >               die_errno(_("could not rename temporary file to %s"), file=
);
 >  =20
 >       strbuf_release(&sb);
 > +    strbuf_release(&out);
 >   }
 >  =20
 >   int cmd_interpret_trailers(int argc,
 >=20

Thank you for your suggestion and kindness. I will re-implement the first p=
atch based on your change and
avoid the die in interpret_trailers (as suggested in v3) and replacing the =
fwrite with strbuf_write (also suggested in v3).

And then add patches as you said above.

Regards,

Li=E2=80=8B

