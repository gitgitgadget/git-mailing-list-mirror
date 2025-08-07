Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3AD1B87C9
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 02:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534716; cv=pass; b=WsVXAiD/m38W13Mw6TdEnqnDIUcNq0Q3ayQIdpm1kGbwgxDQQCkDIiEBpkWkiXvkfTUAvI4EHYbxdpAdYHxn6AbEYSkMYLBcnanHjAkEFG/zQBGbkQDOE7oGVxmsho4BizgAsa2FZybMXeCBw+3CLQEH7knURaylHR+a2XhU2oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534716; c=relaxed/simple;
	bh=3MusXICJ5W61pOTlaTdFBf1fEdd4ToX+LoPyHn3Ivdw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=iRbe32/MyIyA2md/e+DXqRsan8yvKzi7Sl4Euzlue3hiUd3TCeHFGyEt1dlLM1f2w32S3ghHvVbNFpp/s/RdFZsnAap6qm1sCb7SUOi7DC0RvRbM1JszHqEzT5LQ91zrDDBTp1DXAWpquRFehDMgLUNiXfHkO/1S/F7PYouVlEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=cV17jOIx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="cV17jOIx"
ARC-Seal: i=1; a=rsa-sha256; t=1754534706; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WFmRl4u6kF8Hg3l2Fko9dd5gvUzl5lDKUOhtaKWi4iedstxsWCewMJ/ofdM/3ZzXx6KGAdkn10QAsr+nKA/eGXxm2X74LGpT0BgiR2Q8R3ISBGf0a1hceabdS1OxYAfikF8dOJjpwuh8Hs/yzqCyjFD7pz36JHPoid/9FeiW21Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754534706; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4cZfIRHgPlz7Vn5p8+iNpC9o9yWZ1P2w75pSxssRnO0=; 
	b=UhMfxTT2bNo/eyxv3g9WEVwLu8J/Ge2QyTg8EwL4EeEiwHSXLZt2lSt36cvLbrrVnB9gxY4pk/I13RM5wtjKrPFu7EX63PPinVMYekkVJMQrwgHhe0BDvwKYsqdA7unVQqR1rWnnPkgQUKS4TpjayDMFTGIoUoNStuE0I8VMDHI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754534706;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4cZfIRHgPlz7Vn5p8+iNpC9o9yWZ1P2w75pSxssRnO0=;
	b=cV17jOIxIzH7/J8kmo2PyGbF8S4CDEoeG8XAILRVTqFVJxfTMQakXowRsgKkLPyY
	ydPVaG5xFnlPceQyK9E7M9tcS7qpCQ9aj94JZziOEjq+6Tc4cQ8WBYJ0BcT9h5wuAhX
	OLGnbmcM7qhFuFLTzkk3pWRko5tNjIqb1JuLlgBs=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1754534704522900.9649332745518; Wed, 6 Aug 2025 19:45:04 -0700 (PDT)
Date: Thu, 07 Aug 2025 10:45:04 +0800
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>
Cc: "git" <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
Message-ID: <198826af571.62b85cb31711042.2415806544948206668@linux.beauty>
In-Reply-To: <d4c9f082-52be-48d9-b817-fcb8a72e1bd7@gmail.com>
References: <20250803150059.402017-1-me@linux.beauty>
 <20250803150059.402017-2-me@linux.beauty> <d4c9f082-52be-48d9-b817-fcb8a72e1bd7@gmail.com>
Subject: Re: [PATCH v3 1/2] trailer: append trailers in-process and drop the
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

 ---- On Tue, 05 Aug 2025 21:17:01 +0800  Phillip Wood <phillip.wood123@gma=
il.com> wrote ---=20
 > Hi Li
 >=20
 > On 03/08/2025 16:00, Li Chen wrote:
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >=20
 > > All trailer insertion now funnels through trailer_process():
 > >=20
 > > * builtin/interpret-trailers.c is reduced to file I/O + a single call.
 > > * amend_file_with_trailers() shares the same path; the old
 > >    amend_strbuf_with_trailers() helper is dropped.
 > > * New helpers parse_trailer_args()/free_new_trailer_list() convert
 > >    --trailer=3D... strings to new_trailer_item lists.
 > >=20
 > > Behaviour is unchanged; the full test-suite still passes, and the
 > > fork/exec is gone.
 >=20
 > Normally commit messages should be written in prose rather than a bullet=
=20
 > list and the message should explain the reason for the change.
 >=20
 > This patch has much less code duplication than the last iteration which=
=20
 > is most welcome. Whenever you are moving and refactoring code you should=
=20
 > split the move into its own commit followed by the refactoring. That=20
 > makes it much easier to review as the reviewer can clearly see the=20
 > refactoring rather than having to manually compare the added code in one=
=20
 > file to the deleted code in another.
=20
I apologize for this, and I will add new commits to resolve all issues in t=
he next versions.
=20
 > > @@ -84,6 +83,7 @@ static int parse_opt_parse(const struct option *opt,=
 const char *arg,
 > >                  int unset)
 > >   {
 > >       struct process_trailer_options *v =3D opt->value;
 > > +
 >=20
 > Let's not clutter this patch with unrelated changes.
 >=20
 > >       v->only_trailers =3D 1;
 > >       v->only_input =3D 1;
 > >       v->unfold =3D 1;
 > > @@ -92,37 +92,6 @@ static int parse_opt_parse(const struct option *opt=
, const char *arg,
 > >       return 0;
 > >   }
 > >  =20
 > > -static FILE *create_in_place_tempfile(const char *file)
 > > -{
 > > [...]
 > > -}
 >=20
 > We don't need to create a temporary file anymore so this can be deleted=
=20
 > - good.
 >=20
 > > -static void interpret_trailers(const struct process_trailer_options *=
opts,
 > > -                   struct list_head *new_trailer_head,
 > > -                   const char *file)
 > > -{
 > > -    LIST_HEAD(head);
 > > -    struct strbuf sb =3D STRBUF_INIT;
 > > -    struct strbuf trailer_block_sb =3D STRBUF_INIT;
 > > -    struct trailer_block *trailer_block;
 > > -    FILE *outfile =3D stdout;
 > > -
 > > -    trailer_config_init();
 > > -
 > > -    read_input_file(&sb, file);
 > > -
 > > -    if (opts->in_place)
 > > -        outfile =3D create_in_place_tempfile(file);
 > > -
 > > -    trailer_block =3D parse_trailers(opts, sb.buf, &head);
 > > -
 > > -    /* Print the lines before the trailer block */
 > > -    if (!opts->only_trailers)
 > > -        fwrite(sb.buf, 1, trailer_block_start(trailer_block), outfile=
);
 > > -
 > > -    if (!opts->only_trailers && !blank_line_before_trailer_block(trai=
ler_block))
 > > -        fprintf(outfile, "\n");
 > > -
 > > -
 > > -    if (!opts->only_input) {
 > > -        LIST_HEAD(config_head);
 > > -        LIST_HEAD(arg_head);
 > > -        parse_trailers_from_config(&config_head);
 > > -        parse_trailers_from_command_line_args(&arg_head, new_trailer_=
head);
 > > -        list_splice(&config_head, &arg_head);
 > > -        process_trailers_lists(&head, &arg_head);
 > > -    }
 > > -
 > > -    /* Print trailer block. */
 > > -    format_trailers(opts, &head, &trailer_block_sb);
 > > -    free_trailers(&head);
 > > -    fwrite(trailer_block_sb.buf, 1, trailer_block_sb.len, outfile);
 > > -    strbuf_release(&trailer_block_sb);
 > > -
 > > -    /* Print the lines after the trailer block as is. */
 > > -    if (!opts->only_trailers)
 > > -        fwrite(sb.buf + trailer_block_end(trailer_block), 1,
 > > -               sb.len - trailer_block_end(trailer_block), outfile);
 > > -    trailer_block_release(trailer_block);
 > > -
 > > -    if (opts->in_place)
 > > -        if (rename_tempfile(&trailers_tempfile, file))
 > > -            die_errno(_("could not rename temporary file to %s"), fil=
e);
 > > -
 > > -    strbuf_release(&sb);
 > > -}
 >=20
 > This code is moved to trailer.c which is good but it is heavily=20
 > refactored at the same time which makes it hard to review. Completely=20
 > removing this function leads to some duplication in=20
 > cmd_interpret_trailers() which could be avoided by making=20
 > interpret_trailers() a wrapper around process_trailers()
 >=20
 > >   int cmd_interpret_trailers(int argc,
 > >                  const char **argv,
 > >                  const char *prefix,
 > > @@ -231,14 +145,37 @@ int cmd_interpret_trailers(int argc,
 > >               git_interpret_trailers_usage,
 > >               options);
 > >  =20
 > > +    trailer_config_init();
 > > +
 > >       if (argc) {
 > >           int i;
 > > -        for (i =3D 0; i < argc; i++)
 > > -            interpret_trailers(&opts, &trailers, argv[i]);
 > > +        for (i =3D 0; i < argc; i++) {
 > > +            struct strbuf in_buf =3D STRBUF_INIT;
 > > +            struct strbuf out_buf =3D STRBUF_INIT;
 > > +
 > > +            read_input_file(&in_buf, argv[i]);
 > > +            if (trailer_process(&opts, in_buf.buf, &trailers, &out_bu=
f) < 0)
 > > +                die(_("failed to process trailers for %s"), argv[i]);
 > > +            if (opts.in_place)
 > > +                write_file_buf(argv[i], out_buf.buf, out_buf.len);
 > > +            else
 > > +                fwrite(out_buf.buf, 1, out_buf.len, stdout);
 > > +            strbuf_release(&in_buf);
 > > +            strbuf_release(&out_buf);
 > > +        }
 > >       } else {
 > > +        struct strbuf in_buf =3D STRBUF_INIT;
 > > +        struct strbuf out_buf =3D STRBUF_INIT;
 > > +
 > >           if (opts.in_place)
 > >               die(_("no input file given for in-place editing"));
 > > -        interpret_trailers(&opts, &trailers, NULL);
 > > +
 > > +        read_input_file(&in_buf, NULL);
 > > +        if (trailer_process(&opts, in_buf.buf, &trailers, &out_buf) <=
 0)
 > > +            die(_("failed to process trailers"));
 > > +        fwrite(out_buf.buf, 1, out_buf.len, stdout);
 > > +        strbuf_release(&in_buf);
 > > +        strbuf_release(&out_buf);
 > >       }
 >=20
 > There is quite a bit of duplication here that could be avoided if you=20
 > modified interpret_trailers() to call trailer_process() rather than=20
 > deleting it entirely.
 >=20
 > >       new_trailers_clear(&trailers);
 > > diff --git a/trailer.c b/trailer.c
 > > index 310cf582dc..03814443c3 100644
 > > --- a/trailer.c
 > > +++ b/trailer.c
 > > @@ -1224,14 +1224,121 @@ void trailer_iterator_release(struct trailer_=
iterator *iter)
 > >       strbuf_release(&iter->key);
 > >   }
 > >  =20
 > > -int amend_file_with_trailers(const char *path, const struct strvec *t=
railer_args)
 > > +static int amend_strbuf_with_trailers(struct strbuf *buf,
 > > +                   const struct strvec *trailer_args)
 >=20
 > Function argument declarations should be aligned
 >=20
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
 > > +        const char *arg =3D trailer_args->v[i];
 > > +        const char *text;
 > > +        struct new_trailer_item *item;
 >=20
 > There should be a blank line after the variable declarations at the=20
 > start of each block of code.
 >=20
 > > +        if (!skip_prefix(arg, "--trailer=3D", &text))
 >=20
 > Why do we need this? It would be much cleaner if we required the caller=
=20
 > to pass a list of trailers without any optional prefix.
 >=20
 > > +            text =3D arg;
 > > +        if (!*text)
 > > +            continue;
 > > +        item =3D xcalloc(1, sizeof(*item));
 > > +        INIT_LIST_HEAD(&item->list);
 > > +        item->text =3D text;
 > > +        list_add_tail(&item->list, &new_trailer_head);
 > > +    }
 > > +    if (trailer_process(&opts, buf->buf, &new_trailer_head, &out) < 0=
)
 > > +        die("failed to process trailers");
 >=20
 > As this is library code lets return an error here rather than dying.
 >=20
 > > +    strbuf_swap(buf, &out);
 > > +    strbuf_release(&out);
 > > +    while (!list_empty(&new_trailer_head)) {
 > > +        struct new_trailer_item *item =3D
 > > +            list_first_entry(&new_trailer_head, struct new_trailer_it=
em, list);
 > > +        list_del(&item->list);
 > > +        free(item);
 > > +    }
 > > +    return 0;
 > >   }
 > > +
 > > +int trailer_process(const struct process_trailer_options *opts,
 > > +                   const char *msg,
 > > +                   struct list_head *new_trailer_head,
 > > +                   struct strbuf *out)
 >=20
 > Argument alignment again
 >=20
 > > +{
 > > +        struct trailer_block *blk;
 >=20
 > This is trailer_block in the original but has been re-ordered with=20
 > respect to the other variable declarations making the patch harder to=20
 > review.
 >=20
 > > +        LIST_HEAD(orig_head);
 >=20
 > This is head in the original but moved relative to the other variable=20
 > declarations
 >=20
 > > +        LIST_HEAD(config_head);
 > > +        LIST_HEAD(ar1g_head);
 >=20
 > These two have been moved from inside the if (!opts->only_input) below.=
=20
 > They are only referenced there so do not need to be declared here.=20
 > Moving them makes this patch harder to review.
 >=20
 > > +        struct strbuf trailers_sb =3D STRBUF_INIT;
 >=20
 > This is from the original but moved relative to the other variable=20
 > declarations.
 >=20
 > > +        int had_trailer_before;
 >=20
 > This is new - lets see how it is used. We've just started using bool for=
=20
 > boolean variables in the last few weeks so this could be a bool now.
 >=20
 >  From here to
 >=20
 > > +        blk =3D parse_trailers(opts, msg, &orig_head);
 > > +        had_trailer_before =3D !list_empty(&orig_head);
 > > +        if (!opts->only_input) {
 > > +            parse_trailers_from_config(&config_head);
 > > +            parse_trailers_from_command_line_args(&arg_head, new_trai=
ler_head);
 > > +            list_splice(&config_head, &arg_head);
 > > +            process_trailers_lists(&orig_head, &arg_head);
 > > +        }
 > > +        format_trailers(opts, &orig_head, &trailers_sb);
 >=20
 > here is copied from the original minus the code that copied the commit=
=20
 > message to the output file. Rather than deleting the code that copied=20
 > the commit message we could have replaced the calls to fwrite() and=20
 > fprintf() with strbuf_add() and strbuf_addf() which would make it=20
 > obvious that the behavior is not changed. The original then frees=20
 > orig_head but that is done later here.
 >=20
 > > +        if (!opts->only_trailers && !opts->only_input && !opts->unfol=
d &&
 > > +            !opts->trim_empty && list_empty(&orig_head) &&
 > > +            (list_empty(new_trailer_head) || opts->only_input)) {
 >=20
 > I'm not sure what is happening here. By this point the original has=20
 > copied the original commit message and is ready to append the new=20
 > trailers. Instead the new version seems to have completely refactored=20
 > the logic for adding the new trailers making it harder to see if the=20
 > behavior has changed.
 >=20
 > > +            size_t split =3D trailer_block_start(blk); /* end-of-log-=
msg */
 > > +            if (!blank_line_before_trailer_block(blk)) {
 > > +                strbuf_add(out, msg, split);
 > > +                strbuf_addch(out, '\n');
 > > +                strbuf_addstr(out, msg + split);
 >=20
 > This copies the original message but adds a newline before the trailer=
=20
 > block if it is missing.
 >=20
 > > +            } else
 > > +                strbuf_addstr(out, msg);
 >=20
 > This just copies the whole message.
 >=20
 > > +            strbuf_rel2ease(&trailers_sb);
 > > +            trailer_block_release(blk);
 >=20
 >=20
 > > +            return 0;
 >=20
 > We return a copy of the original message with no new trailers added. We=
=20
 > do not free orig_head, arg_head or config_head. I'm still confused why=
=20
 > we need to special case this.
 >=20
 >=20
 > > +        }
 > > +        if (opts->only_trailers) {
 > > +            strbuf_addbuf(out, &trailers_sb);
 >=20
 > This flips the logic in the original to handle opts->only_trailers=20
 > separately making it harder to review.
 >=20
 > > +        } else if (had_trailer_before) {
 > > +            strbuf_add(out, msg, trailer_block_start(blk));
 > > +            if (!blank_line_before_trailer_block(blk))
 > > +                strbuf_addch(out, '\n');
 > > +            strbuf_addbuf(out, &trailers_sb);
 > > +            strbuf_add(out, msg + trailer_block_end(blk),
 > > +                        strlen(msg) - trailer_block_end(blk));
 >=20
 > This handles the case where we're replacing the headers in the original=
=20
 > message
 >=20
 > > +        }
 > > +        else {
 >=20
 > Style - this should be "} else {"
 >=20
 > > +            size_t cpos =3D trailer_block_start(blk);
 > > +            strbuf_add(out, msg, cpos);
 > > +            if (cpos =3D=3D 0)                     /* empty body =E2=
=86=92 just one \n */
 > > +                strbuf_addch(out, '\n');
 > > +            else if (!blank_line_before_trailer_block(blk))
 > > +                strbuf_addch(out, '\n');   /* body without trailing b=
lank */
 > > +
 > > +            strbuf_addbuf(out, &trailers_sb);
 > > +            strbuf_add(out, msg + cpos, strlen(msg) - cpos);
 > > +       }
 >=20
 > I'm confused why we need a separate case for when the original did not=
=20
 > have any trailers - was the original code broken? If it was we should=20
 > separate out the bug fix from the refactoring. If not what's the point=
=20
 > of this change?
 >=20
 > > +        strbuf_release(&trailers_sb);
 > > +        free_trailers(&orig_head);
 > > +        trailer_block_release(blk);
 > > +        return 0;
 > > +}
 > > +
 > > +int amend_file_with_trailers(const char *path,
 > > +                             const struct strvec *trailer_args)
 >=20
 > Alignment again
 >=20
 > > +{
 > > +    struct strbuf buf =3D STRBUF_INIT;
 > > +
 > > +    if (!trailer_args || !trailer_args->nr)
 > > +        return 0;
 > > +
 > > +    if (strbuf_read_file(&buf, path, 0) < 0)
 > > +        return error_errno("could not read '%s'", path);
 > > +
 > > +    if (amend_strbuf_with_trailers(&buf, trailer_args))
 > > +        die("failed to append trailers");
 >=20
 > Why return an error() above but die() here? This is library code so lets=
=20
 > return an error.
 >=20
 > > +
 > > +    /* `write_file_buf()` aborts on error internally */
 > > +    write_file_buf(path, buf.buf, buf.len);
 >=20
 > Dying here is a change in behavior which callers might not be expecting.=
=20
 > The original code always returned a error because it forked a=20
 > sub-process to do the trailer processing. Ideally, in a separate commit,=
=20
 > we'd update any existing callers that have the message in an strbuf so=
=20
 > they don't have to write it to a file just to add some trailers to it.
 >=20
 > > +    strbuf_release(&buf);
 > > +    return 0;
 > > + }
 >=20
 > As I said above reusing the existing code as you have done here is a=20
 > much better approach. However it would be much easier to review if the=
=20
 > code movement was separated from the refactoring. I'm also struggling to=
=20
 > see the benefit of a lot of the refactoring - I was expecting the=20
 > conversion to use an strubf would essentially look like fwrite() being=
=20
 > replaced with strbuf_add() and fprintf() being replaced with=20
 > strbuf_addf() etc. rather than reworking the logic.
 >=20
 > Thanks
 >=20
 >=20
 > Phillip
 >=20
 > > diff --git a/trailer.h b/trailer.h
 > > index 4740549586..01f711fb13 100644
 > > --- a/trailer.h
 > > +++ b/trailer.h
 > > @@ -196,10 +196,22 @@ int trailer_iterator_advance(struct trailer_iter=
ator *iter);
 > >   void trailer_iterator_release(struct trailer_iterator *iter);
 > >  =20
 > >   /*
 > > - * Augment a file to add trailers to it by running git-interpret-trai=
lers.
 > > - * This calls run_command() and its return value is the same (i.e. 0 =
for
 > > - * success, various non-zero for other errors). See run-command.h.
 > > + * Augment a file to add trailers to it (similar to 'git interpret-tr=
ailers').
 > > + * Returns 0 on success or a non-zero error code on failure.
 > >    */
 > >   int amend_file_with_trailers(const char *path, const struct strvec *=
trailer_args);
 > >  =20
 > > +/*
 > > + * Process trailer lines for a commit message in-memory.
 > > + * @opts: trailer processing options (e.g. from parse-options)
 > > + * @msg: the input message string
 > > + * @new_trailer_head: list of new trailers to add (struct new_trailer=
_item)
 > > + * @out: strbuf to store the resulting message (must be initialized)
 > > + *
 > > + * Returns 0 on success, <0 on error.
 > > + */
 > > +int trailer_process(const struct process_trailer_options *opts,
 > > +            const char *msg,
 > > +            struct list_head *new_trailer_head,
 > > +            struct strbuf *out);
 > >   #endif /* TRAILER_H */
 >=20
 >=20
Regards,

Li=E2=80=8B

