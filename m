Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF4C85958
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408738; cv=none; b=Nu21B+gcddOS1ry04afrQfr2hCGAgGHorFI4twMZtcg7QjKXMA6CoCKPPl2oJtL353QrJQLHtNYcad7aD4Pjra2KBcCHZr5MIj9/FonbQCKR5EAJ/fxIokOn54OBu2TQzyJUKAo0S7wRY/rQZvZuPsf/UBQPvTHMDXys/Je/zLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408738; c=relaxed/simple;
	bh=GpVadhhVrmAtgl0lN6hIUR062X1UW4h6BDBQrGpuoV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=On8fbgNyk7S/DetvrknexLaxRxgcXd+NW1Bz8Tg5W+8Gl8Ux/Prt/3Z05HW5xYv/Vc6gUsoVGlXcGbbhDz6JNs/4XY9ni7yMlzrX5XZLfb4R9JK9Nkvkmql2rGc1rmtK3VCufKkxViaCgnZdc47fl4IoP6QGMU1v3UBVBZyYhfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deQJn2D1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deQJn2D1"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a58772187d8so570705066b.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714408735; x=1715013535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2x310831f+Uk646ZVyjomsG7hPE2uKOqmfmEi+GeEg=;
        b=deQJn2D1Oi3K3+1mRHwD9Ef1gJtcVbiCQ9GwxqG6JEa2c79Z8+SJ3ZqxX5S4AsIn7a
         zChvRR/++aYQj1PYzPdKCc5pCbuMm1yO2eqR9fgYk5T81HMf8N2SGHiWY+CqsAiCN8Xt
         xtCtDoIpTDtN+36Ktmpma61sEDzhog1eH79n9U7coHhRpaBfdT8obeJT4FhNaHCpuPYy
         Gt7q873Q1z4iFQ+VYqkRXkYsCLkjv2066cWzebVuhlnUJ5D6YaDxCaPX8VTm1v/WgoRg
         xbUEZowZ9cYguPUNhTA9vpjIf08LsdRYOjK9sidmfR6v02YoFRcLc5ldFYOCKm7is3+q
         EGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714408735; x=1715013535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2x310831f+Uk646ZVyjomsG7hPE2uKOqmfmEi+GeEg=;
        b=GpzeUBr8MeJtr/0bW6RphuevRX4gAODciwazrMlIHQK0o6Lww+SZoZpy3zKug65BSa
         BIIQ28h8q4LXzFsE5LtKtuHvUyHA5BlRDpYfhFNCBYrgHJUVm1GPGhi/YUfRXqtohYoa
         4sumF5siYej5jmKos+L5cYIhb0kgFvynlWwT2je9Irdcf4GAJImoUf9y+jtLQRULSZnS
         R1EhSexUh93E9xwnDPjqE3/+stnGIK+53hbEUgZy9hNM1eKSFypxrgPx2nlgIIYY2RKT
         mGDfodyjwjPeeL26f0thjMatXBCCu9zEySCCW8ijkixtPSlrjyKx9meUqVs0a83dAuYL
         hePg==
X-Forwarded-Encrypted: i=1; AJvYcCXYTgnBQmJEXLZsNzy/yjsNRWugZbnpqGiJM7W0vLR7HIn2pJUmI4px3maZfakN5DclRrPch88PMKi2u+Rr1o7u4VuA
X-Gm-Message-State: AOJu0YyTU8a5gR1VvEf1mAkYsVH9pXn94tFDr/UdYC0JLEnoKi4TYHp0
	xArkgWvAfTXFxi2q4y1WzbY4nMGqsvWJtpF56JAd2Hljs8msxGsiduIvpBC+oF8wSxuys8dU+Y5
	S9KE8EAyIBNGtuPDQ3j5rASC/gMY=
X-Google-Smtp-Source: AGHT+IE8IFD5vG+I4dxSBGPElgqhECV0iOkswHEc638XMG5DxH2hjrh54JhzSompRLn/MmBggvxr9lY9T4iAAZVlf38=
X-Received: by 2002:a17:906:c305:b0:a59:871:8fa8 with SMTP id
 s5-20020a170906c30500b00a5908718fa8mr2141848ejz.76.1714408734782; Mon, 29 Apr
 2024 09:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1723.git.1714365076246.gitgitgadget@gmail.com>
 <Zi9DGYwlT7VnW7oj@tanuki> <xmqqplu8yyp2.fsf@gitster.g>
In-Reply-To: <xmqqplu8yyp2.fsf@gitster.g>
From: John Passaro <john.a.passaro@gmail.com>
Date: Mon, 29 Apr 2024 12:38:16 -0400
Message-ID: <CAJdN7Kiep79YeN2GCbjdz9HhHif0nyEDUf51EKcESzR-DOBZQw@mail.gmail.com>
Subject: Re: [PATCH] builtin/tag.c: add --trailer arg
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, John Passaro via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:29=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > On Mon, Apr 29, 2024 at 04:31:15AM +0000, John Passaro via GitGitGadget=
 wrote:
> >> From: John Passaro <john.a.passaro@gmail.com>
> >>
> >> Teach git-tag to accept --trailer option to add trailers to annotated
> >> tag messages, like git-commit.
> >>
> >> Signed-off-by: John Passaro <john.a.passaro@gmail.com>
> >
> > This feels like a sensible addition to me indeed, thanks!
>
> At the surface level, I tend to agree, but I am of two minds,
> especially around the "-s" option, though.  "commit -s" is to work
> with the "Signed-off-by" trailer, but "tag -s" is not.
>
> More importantly, I doubt that many trailers we commonly see in the
> comit objects, like "Acked-by", "Reviewed-by", or even "CC", are
> applicable in the context of tags.  So I am ambivalent.

A couple of words on the motivation here. First, by way of --list
--format=3D"%(trailer)",
git-tag arguably has read-side support for trailers already; adding write
support seems pretty reasonable. Second, even though not all the trailers
broadly used for commits are an obvious fit for tags, some still are -
"Signed-off-by" for one would seem plausibly useful. In my team's usage (wh=
ich
inspired this change), tag trailers have emerged as a convenient way to pas=
s
machine-readable metadata to CICD.


>
> If we were to adop this new feature, your review already has done a
> very good job and I see room for adding nothing more on the
> implementation.
>
> Thanks, both.
>
> > [snip]
> >> diff --git a/builtin/tag.c b/builtin/tag.c
> >> index 9a33cb50b45..0334a5d15ec 100644
> >> --- a/builtin/tag.c
> >> +++ b/builtin/tag.c
> >> @@ -28,9 +28,11 @@
> >>  #include "date.h"
> >>  #include "write-or-die.h"
> >>  #include "object-file-convert.h"
> >> +#include "run-command.h"
> >>
> >>  static const char * const git_tag_usage[] =3D {
> >>      N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [=
-e]\n"
> >> +       "        [(--trailer <token>[(=3D|:)<value>])...]\n"
> >>         "        <tagname> [<commit> | <object>]"),
> >>      N_("git tag -d <tagname>..."),
> >>      N_("git tag [-n[<num>]] -l [--contains <commit>] [--no-contains <=
commit>]\n"
> >> @@ -290,10 +292,11 @@ static const char message_advice_nested_tag[] =
=3D
> >>  static void create_tag(const struct object_id *object, const char *ob=
ject_ref,
> >>                     const char *tag,
> >>                     struct strbuf *buf, struct create_tag_options *opt=
,
> >> -                   struct object_id *prev, struct object_id *result, =
char *path)
> >> +                   struct object_id *prev, struct object_id *result, =
struct strvec *trailer_args, char *path)
> >
> > This line is overly long now, let's break it.
> >
> >>  {
> >>      enum object_type type;
> >>      struct strbuf header =3D STRBUF_INIT;
> >> +    int should_edit;
> >>
> >>      type =3D oid_object_info(the_repository, object, NULL);
> >>      if (type <=3D OBJ_NONE)
> >> @@ -313,14 +316,18 @@ static void create_tag(const struct object_id *o=
bject, const char *object_ref,
> >>                  tag,
> >>                  git_committer_info(IDENT_STRICT));
> >>
> >> -    if (!opt->message_given || opt->use_editor) {
> >> +    should_edit =3D opt->use_editor || !opt->message_given;
> >> +    if (should_edit || trailer_args->nr) {
> >>              int fd;
> >>
> >>              /* write the template message before editing: */
> >>              fd =3D xopen(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> >>
> >> -            if (opt->message_given) {
> >> +            if (opt->message_given && buf->len) {
> >>                      write_or_die(fd, buf->buf, buf->len);
> >> +                    if (trailer_args->nr && buf->buf[buf->len-1] !=3D=
 '\n') {
> >> +                            write_or_die(fd, "\n", 1);
> >> +                    }
> >
> > We avoid braces around single-line statements.
> >
> > I was also wondering whether we can simplify this to:
> >
> >     if (opt->message_given && buf->len) {
> >         strbuf_complete(buf, '\n');
> >         write_or_die(fd, buf->buf, buf->len);
> >     }
> >
> > Or does changing `buf` cause problems for us?
> >
> >>                      strbuf_reset(buf);
> >>              } else if (!is_null_oid(prev)) {
> >>                      write_tag_body(fd, prev);
> >> @@ -338,10 +345,31 @@ static void create_tag(const struct object_id *o=
bject, const char *object_ref,
> >>              }
> >>              close(fd);
> >>
> >> -            if (launch_editor(path, buf, NULL)) {
> >> -                    fprintf(stderr,
> >> -                    _("Please supply the message using either -m or -=
F option.\n"));
> >> -                    exit(1);
> >> +            if (trailer_args->nr) {
> >> +                    struct child_process run_trailer =3D CHILD_PROCES=
S_INIT;
> >> +
> >> +                    strvec_pushl(&run_trailer.args, "interpret-traile=
rs",
> >> +                                 "--in-place", "--no-divider",
> >> +                                 path, NULL);
> >> +                    strvec_pushv(&run_trailer.args, trailer_args->v);
> >> +                    run_trailer.git_cmd =3D 1;
> >> +                    if (run_command(&run_trailer))
> >> +                            die(_("unable to pass trailers to --trail=
ers"));
> >> +            }
> >
> > This part is copied from `builtin/commit.c`. Would it make sense to mov=
e
> > it into a function `amend_trailers_to_file()` or similar that we add to
> > our trailer API so that we can avoid the code duplication?
> >
> >> +            if (should_edit) {
> >> +                    if (launch_editor(path, buf, NULL)) {
> >> +                            fprintf(stderr,
> >> +                            _("Please supply the message using either=
 -m or -F option.\n"));
> >> +                            exit(1);
> >> +                    }
> >
> > I know you simply re-indented the block here, but let's also fix the
> > indentation of the second argument to fprintf(3P) while at it.
> >
> >> +            } else if (trailer_args->nr) {
> >> +                    strbuf_reset(buf);
> >> +                    if (strbuf_read_file(buf, path, 0) < 0) {
> >> +                            fprintf(stderr,
> >> +                                            _("Please supply the mess=
age using either -m or -F option.\n"));
> >> +                            exit(1);
> >> +                    }
> >>              }
> >>      }
> >>
> >> @@ -416,6 +444,14 @@ struct msg_arg {
> >>      struct strbuf buf;
> >>  };
> >>
> >> +static int opt_pass_trailer(const struct option *opt, const char *arg=
, int unset)
> >> +{
> >> +    BUG_ON_OPT_NEG(unset);
> >> +
> >> +    strvec_pushl(opt->value, "--trailer", arg, NULL);
> >> +    return 0;
> >> +}
> >> +
> >>  static int parse_msg_arg(const struct option *opt, const char *arg, i=
nt unset)
> >>  {
> >>      struct msg_arg *msg =3D opt->value;
> >> @@ -463,6 +499,7 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
> >>      struct ref_sorting *sorting;
> >>      struct string_list sorting_options =3D STRING_LIST_INIT_DUP;
> >>      struct ref_format format =3D REF_FORMAT_INIT;
> >> +    struct strvec trailer_args =3D STRVEC_INIT;
> >>      int icase =3D 0;
> >>      int edit_flag =3D 0;
> >>      struct option options[] =3D {
> >> @@ -479,6 +516,7 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
> >>              OPT_CALLBACK_F('m', "message", &msg, N_("message"),
> >>                             N_("tag message"), PARSE_OPT_NONEG, parse_=
msg_arg),
> >>              OPT_FILENAME('F', "file", &msgfile, N_("read message from=
 file")),
> >> +            OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer")=
, N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
> >>              OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag m=
essage")),
> >>              OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-si=
gned tag")),
> >>              OPT_CLEANUP(&cleanup_arg),
> >> @@ -548,7 +586,7 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
> >>              opt.sign =3D 1;
> >>              set_signing_key(keyid);
> >>      }
> >> -    create_tag_object =3D (opt.sign || annotate || msg.given || msgfi=
le);
> >> +    create_tag_object =3D (opt.sign || annotate || msg.given || msgfi=
le || edit_flag || trailer_args.nr);
> >>
> >>      if ((create_tag_object || force) && (cmdmode !=3D 0))
> >>              usage_with_options(git_tag_usage, options);
> >> @@ -635,7 +673,7 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
> >>      else if (!force)
> >>              die(_("tag '%s' already exists"), tag);
> >>
> >> -    opt.message_given =3D msg.given || msgfile;
> >> +    opt.message_given =3D msg.given || (msgfile !=3D NULL);
> >>      opt.use_editor =3D edit_flag;
> >
> > Besides being not required, this change also violates our coding style
> > where we don't explicitly check for NULL pointers.
> >
> >>      if (!cleanup_arg || !strcmp(cleanup_arg, "strip"))
> >> @@ -653,7 +691,7 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
> >>              if (force_sign_annotate && !annotate)
> >>                      opt.sign =3D 1;
> >>              path =3D git_pathdup("TAG_EDITMSG");
> >> -            create_tag(&object, object_ref, tag, &buf, &opt, &prev, &=
object,
> >> +            create_tag(&object, object_ref, tag, &buf, &opt, &prev, &=
object, &trailer_args,
> >>                         path);
> >
> > Nit: let's move `&trailer_args` to the next line to not make it overly
> > long.
> >
> >>      }
> >>
> >> @@ -686,6 +724,7 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
> >>      strbuf_release(&reflog_msg);
> >>      strbuf_release(&msg.buf);
> >>      strbuf_release(&err);
> >> +    strvec_clear(&trailer_args);
> >>      free(msgfile);
> >>      return ret;
> >>  }
> >> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> >> index 696866d7794..364db2b4685 100755
> >> --- a/t/t7004-tag.sh
> >> +++ b/t/t7004-tag.sh
> >> @@ -668,6 +668,105 @@ test_expect_success \
> >>      test_cmp expect actual
> >>  '
> >>
> >> +# trailers
> >> +
> >> +get_tag_header tag-with-inline-message-and-trailers $commit commit $t=
ime >expect
> >> +cat >>expect <<EOF
> >> +create tag with trailers
> >> +
> >> +my-trailer: here
> >> +alt-trailer: there
> >> +EOF
> >
> > You probably just follow precedent in this file, but our modern coding
> > style sets up the `expect` file inside of the test body itself. You als=
o
> > do it like that in other tests, so let's be consistent.
> >
> > The same comment applies to other tests, as well.
> >
> > Patrick
