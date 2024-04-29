Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18AE81724
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403177; cv=none; b=aTa50PnCduKryMH8zYqax3btfplMFghozwUlb5S5irX4E7sb/MHVVh3UHA9j6bIgmQ0v+1Shmzr/z5y8ypMhFlE9kn8E1Ric43BRUXiapyf3x4XBwx9UpglINkU4z03x99//+OsLh7oINUqSWxGdcUXGB292Am8OSTA0HTYGMio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403177; c=relaxed/simple;
	bh=8uI462u6JlHDVxTS7aKVH7simXxPppikaZ3HCAxFH8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKIpLnDvNjNw8exaAWr6cPn/zE76qnTL0HrX80yndNWW14ZHSf09BE2f+GwRq9qIDsIt45UXVPKxktrfHEU9X0WRGcFRvX4Hg5gZb88RMWPdKSMQRPLBeK0F4s0ARplRs2PGzOpEmBP5Aq/Z7at1WFr154hthX94Akvo4QflSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+orT4ba; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+orT4ba"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5194cebd6caso5188161e87.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714403174; x=1715007974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvSxsotecy809DAtWHQwMfCrjhFJnn029152qrftslg=;
        b=B+orT4baEAhRwPHYFjhU9iN9QG6nF1q0gXsyVOdeJoO/SPxrXgzMeD/M7YydE25oHP
         IQsrxASGPOEJvEMwJRKdsMORg2kLTUczPvhhK1lPbMZIfSCIBH7n4LXwuO8WWQqV/WGv
         nS4vrldvnrHMUgtVh8dRwWthRZ+Uh1mdYdjc1DD+bGA+bOTB/pXKdroQ8j0ibZa/u0O1
         5hGyF+Qxt/Fn2AOY6lufB55iDu+bXs2hmo0L3uepvFkx+AKR+USFFCSjGITUFe892/Mx
         u4iHcUu/gcEaS3639Wtx4aCWOysE2V9ahE5xMQIrliHWkdhZktdFeyd0jB6IzdtrrszK
         DJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403174; x=1715007974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvSxsotecy809DAtWHQwMfCrjhFJnn029152qrftslg=;
        b=BibHHa6KWLSLB0cR+uEm8H9ozWgPP8FAYtWpouwX4UFzgON5Vgoc0xIMI5SlWIGYzC
         TsMGi9vqbjJG8eQY6FWaFwKWdgd+akplmtac34rrY0hrpwhlyWtNFEe+Fviatn5UuOdl
         jpnOwaxCyu/jEp+x4EQfR0TMsYqNPwqWouP3Y/XdknuWcQUv22zS2+fJSaYHHsesrC9J
         J2WaZtMsZJOq5kq4VLvZ2LXMuVMyVuEKjUXRxWvbhDv+iUa4dYyuQpYJVqRQUA1llh4x
         g3qQUfHat31bIQTUFqD6gUcWxCJbUfHcZhDL6ZXDeGSthKV7C33PLdZyyJLrT3GoZobU
         kSEg==
X-Forwarded-Encrypted: i=1; AJvYcCWi31Xonvba8IXDMpu68ggkCrPb+GEDDvVknDMcMhjIxPv+PCwyJkBa1mpmH9K55ltWXyp7oYrhuQDCo3ywtAQ4+jAZ
X-Gm-Message-State: AOJu0YySsg4pAAs1ka9QEs8u57qNSyoqKVu1eFNg85TbEA+ml3W3vsBF
	6EEiBUKZpBvqauGHUs/HFhj5y4R5noGhDRsvRxBkNuCUvKp+ruvv7ARa9YLAYFytPWf9DojOfpt
	MAcubVtKO5aMEpgqEBLnAvEVthLCLVzBL
X-Google-Smtp-Source: AGHT+IEvVcrVSuyixgTLB5VSxyP5Pwtin32LK2pseZF6EhX+Q7+smlYANHB+2vLQpqXmgMbRyuknLRQzyBB+NLpdfEw=
X-Received: by 2002:a05:6512:5d1:b0:51b:6d63:e0e4 with SMTP id
 o17-20020a05651205d100b0051b6d63e0e4mr6438493lfo.29.1714403173274; Mon, 29
 Apr 2024 08:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1723.git.1714365076246.gitgitgadget@gmail.com> <Zi9DGYwlT7VnW7oj@tanuki>
In-Reply-To: <Zi9DGYwlT7VnW7oj@tanuki>
From: John Passaro <john.a.passaro@gmail.com>
Date: Mon, 29 Apr 2024 11:05:36 -0400
Message-ID: <CAJdN7KhCesU-j=yyM5Sk0sMj8W2Gk=LJc-Dzf8-2+gjhkgA4HQ@mail.gmail.com>
Subject: Re: [PATCH] builtin/tag.c: add --trailer arg
To: Patrick Steinhardt <ps@pks.im>
Cc: John Passaro via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

apologies for the half-cocked message before, please disregard!

On Mon, Apr 29, 2024 at 2:50=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Apr 29, 2024 at 04:31:15AM +0000, John Passaro via GitGitGadget w=
rote:
> > From: John Passaro <john.a.passaro@gmail.com>
> >
> > Teach git-tag to accept --trailer option to add trailers to annotated
> > tag messages, like git-commit.
> >
> > Signed-off-by: John Passaro <john.a.passaro@gmail.com>
>
> This feels like a sensible addition to me indeed, thanks!

Thanks, and thank you for the thoughtful feedback.
I have incorporated most of it on the github PR branch
(https://github.com/gitgitgadget/git/pull/1723).
Before submitting a new patch I had a couple of questions.

[snip]

> > @@ -313,14 +316,18 @@ static void create_tag(const struct object_id *ob=
ject, const char *object_ref,
> >                   tag,
> >                   git_committer_info(IDENT_STRICT));
> >
> > -     if (!opt->message_given || opt->use_editor) {
> > +     should_edit =3D opt->use_editor || !opt->message_given;
> > +     if (should_edit || trailer_args->nr) {
> >               int fd;
> >
> >               /* write the template message before editing: */
> >               fd =3D xopen(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> >
> > -             if (opt->message_given) {
> > +             if (opt->message_given && buf->len) {
> >                       write_or_die(fd, buf->buf, buf->len);
> > +                     if (trailer_args->nr && buf->buf[buf->len-1] !=3D=
 '\n') {
> > +                             write_or_die(fd, "\n", 1);
> > +                     }
>
> We avoid braces around single-line statements.
>
> I was also wondering whether we can simplify this to:
>
>     if (opt->message_given && buf->len) {
>         strbuf_complete(buf, '\n');
>         write_or_die(fd, buf->buf, buf->len);
>     }
>
> Or does changing `buf` cause problems for us?
>
> >                       strbuf_reset(buf);

I think altering `buf` does not cause problems precisely
because we do it on the next line here with strbuf_reset().
strbuf_complete() seems like a clearly better choice.
Two questions:
* should it be done conditionally on `trailer_args->nr` as I did
  here, or should it be unconditional?
* You left strbuf_reset() out of your snippet - i don't know for sure
  why it was there in the first place, should it stay?


> >               } else if (!is_null_oid(prev)) {
> >                       write_tag_body(fd, prev);
> > @@ -338,10 +345,31 @@ static void create_tag(const struct object_id *ob=
ject, const char *object_ref,
> >               }
> >               close(fd);
> >
> > -             if (launch_editor(path, buf, NULL)) {
> > -                     fprintf(stderr,
> > -                     _("Please supply the message using either -m or -=
F option.\n"));
> > -                     exit(1);
> > +             if (trailer_args->nr) {
> > +                     struct child_process run_trailer =3D CHILD_PROCES=
S_INIT;
> > +
> > +                     strvec_pushl(&run_trailer.args, "interpret-traile=
rs",
> > +                                  "--in-place", "--no-divider",
> > +                                  path, NULL);
> > +                     strvec_pushv(&run_trailer.args, trailer_args->v);
> > +                     run_trailer.git_cmd =3D 1;
> > +                     if (run_command(&run_trailer))
> > +                             die(_("unable to pass trailers to --trail=
ers"));
> > +             }
>
> This part is copied from `builtin/commit.c`. Would it make sense to move
> it into a function `amend_trailers_to_file()` or similar that we add to
> our trailer API so that we can avoid the code duplication?

It seems to me the duplication goes further than that.
Ideally I would love to have a unified approach to the problem of
combining `-m`, `-F`, `-e`, and `--trailer` generally. That would change
one existing nit I have in git-tag, which is that with `-m`, `-F`,
or `-fae` to replace an existing tag, it doesn't add commentary guidance
the way git-commit does.

That's a bigger change than I'm comfortable taking on and it's
arguably beyond the scope of this ticket. Question here is - first,
is such a consolidation possible in the future, and second, if it were,
would this refactor (dedicated function for augmenting a strbuf/file
with trailers) still be valuable?


> >               } else if (!is_null_oid(prev)) {
> >                       write_tag_body(fd, prev);
> > @@ -338,10 +345,31 @@ static void create_tag(const struct object_id *ob=
ject, const char *object_ref,
> >               }
> >               close(fd);
> >
> > -             if (launch_editor(path, buf, NULL)) {
> > -                     fprintf(stderr,
> > -                     _("Please supply the message using either -m or -=
F option.\n"));
> > -                     exit(1);
> > +             if (trailer_args->nr) {
> > +                     struct child_process run_trailer =3D CHILD_PROCES=
S_INIT;
> > +
> > +                     strvec_pushl(&run_trailer.args, "interpret-traile=
rs",
> > +                                  "--in-place", "--no-divider",
> > +                                  path, NULL);
> > +                     strvec_pushv(&run_trailer.args, trailer_args->v);
> > +                     run_trailer.git_cmd =3D 1;
> > +                     if (run_command(&run_trailer))
> > +                             die(_("unable to pass trailers to --trail=
ers"));
> > +             }
>
> This part is copied from `builtin/commit.c`. Would it make sense to move
> it into a function `amend_trailers_to_file()` or similar that we add to
> our trailer API so that we can avoid the code duplication?
>
> > +             if (should_edit) {
> > +                     if (launch_editor(path, buf, NULL)) {
> > +                             fprintf(stderr,
> > +                             _("Please supply the message using either=
 -m or -F option.\n"));
> > +                             exit(1);
> > +                     }
>
> I know you simply re-indented the block here, but let's also fix the
> indentation of the second argument to fprintf(3P) while at it.
>
> > +             } else if (trailer_args->nr) {
> > +                     strbuf_reset(buf);
> > +                     if (strbuf_read_file(buf, path, 0) < 0) {
> > +                             fprintf(stderr,
> > +                                             _("Please supply the mess=
age using either -m or -F option.\n"));
> > +                             exit(1);
> > +                     }
> >               }
> >       }
> >
> > @@ -416,6 +444,14 @@ struct msg_arg {
> >       struct strbuf buf;
> >  };
> >
> > +static int opt_pass_trailer(const struct option *opt, const char *arg,=
 int unset)
> > +{
> > +     BUG_ON_OPT_NEG(unset);
> > +
> > +     strvec_pushl(opt->value, "--trailer", arg, NULL);
> > +     return 0;
> > +}
> > +
> >  static int parse_msg_arg(const struct option *opt, const char *arg, in=
t unset)
> >  {
> >       struct msg_arg *msg =3D opt->value;
> > @@ -463,6 +499,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
> >       struct ref_sorting *sorting;
> >       struct string_list sorting_options =3D STRING_LIST_INIT_DUP;
> >       struct ref_format format =3D REF_FORMAT_INIT;
> > +     struct strvec trailer_args =3D STRVEC_INIT;
> >       int icase =3D 0;
> >       int edit_flag =3D 0;
> >       struct option options[] =3D {
> > @@ -479,6 +516,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
> >               OPT_CALLBACK_F('m', "message", &msg, N_("message"),
> >                              N_("tag message"), PARSE_OPT_NONEG, parse_=
msg_arg),
> >               OPT_FILENAME('F', "file", &msgfile, N_("read message from=
 file")),
> > +             OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer")=
, N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
> >               OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag m=
essage")),
> >               OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-si=
gned tag")),
> >               OPT_CLEANUP(&cleanup_arg),
> > @@ -548,7 +586,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
> >               opt.sign =3D 1;
> >               set_signing_key(keyid);
> >       }
> > -     create_tag_object =3D (opt.sign || annotate || msg.given || msgfi=
le);
> > +     create_tag_object =3D (opt.sign || annotate || msg.given || msgfi=
le || edit_flag || trailer_args.nr);
> >
> >       if ((create_tag_object || force) && (cmdmode !=3D 0))
> >               usage_with_options(git_tag_usage, options);
> > @@ -635,7 +673,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
> >       else if (!force)
> >               die(_("tag '%s' already exists"), tag);
> >
> > -     opt.message_given =3D msg.given || msgfile;
> > +     opt.message_given =3D msg.given || (msgfile !=3D NULL);
> >       opt.use_editor =3D edit_flag;
>
> Besides being not required, this change also violates our coding style
> where we don't explicitly check for NULL pointers.
>
> >       if (!cleanup_arg || !strcmp(cleanup_arg, "strip"))
> > @@ -653,7 +691,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
> >               if (force_sign_annotate && !annotate)
> >                       opt.sign =3D 1;
> >               path =3D git_pathdup("TAG_EDITMSG");
> > -             create_tag(&object, object_ref, tag, &buf, &opt, &prev, &=
object,
> > +             create_tag(&object, object_ref, tag, &buf, &opt, &prev, &=
object, &trailer_args,
> >                          path);
>
> Nit: let's move `&trailer_args` to the next line to not make it overly
> long.
>
> >       }
> >
> > @@ -686,6 +724,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
> >       strbuf_release(&reflog_msg);
> >       strbuf_release(&msg.buf);
> >       strbuf_release(&err);
> > +     strvec_clear(&trailer_args);
> >       free(msgfile);
> >       return ret;
> >  }
> > diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> > index 696866d7794..364db2b4685 100755
> > --- a/t/t7004-tag.sh
> > +++ b/t/t7004-tag.sh
> > @@ -668,6 +668,105 @@ test_expect_success \
> >       test_cmp expect actual
> >  '
> >
> > +# trailers
> > +
> > +get_tag_header tag-with-inline-message-and-trailers $commit commit $ti=
me >expect
> > +cat >>expect <<EOF
> > +create tag with trailers
> > +
> > +my-trailer: here
> > +alt-trailer: there
> > +EOF
>
> You probably just follow precedent in this file, but our modern coding
> style sets up the `expect` file inside of the test body itself. You also
> do it like that in other tests, so let's be consistent.
>
> The same comment applies to other tests, as well.
>
> Patrick
