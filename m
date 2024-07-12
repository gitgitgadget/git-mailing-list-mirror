Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060343AA9
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720806100; cv=none; b=rSOOQh1KmJSSB2nAx6b+VAbRz5Flx9dAeQx9NzVya2jg9plzpgmyqDGWRe+dEh7fzfkXaBPa9bfPFldmfx8am9wwoJE58IB6UwhmXiDFoQsPvURIWVTsQLUDWhFQ2L0wmTo23dV10rTP3pvqnha9hVP1VZ8KEdZIgt/NHNMkY/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720806100; c=relaxed/simple;
	bh=Z246bjSBiEsNqkmJBlHpcobhcx5+Mo6dfKW54niONxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5eYwIvbJtb5/ukqV+tmPHBsdWzvmNefUnPZ0vYGGMgTw/cF8RGlorkUP4O92Y8lW0UIWQMrZ21+bJG81SC8cnvVEViklEwTf9PWwALCU28CFwImwnKTLq/LXvNYaQ+drbzHCloKTvXiZ5isQKO4GSjo5ktuEFaIGNLTV0cHakU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jK/2IcyD; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK/2IcyD"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-655fa53c64cso24338027b3.3
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720806097; x=1721410897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6oJ1XrcSAaEnDmhpInm1jcjWUkm99FpJs4UY5Cb2GM=;
        b=jK/2IcyDgtc8u7zXhSQblT8COV8DpFTtYBmRNep+cvVH59baITChgUn80yc5eyz8gD
         isZIEQyMCSrzxvqRjhgAHU+qK5ZXR3qh5vmv7z1bfnTshmn+Fj0kM8eWAkBGuEIYdt2v
         PJnG9n8eWUeeXACi6epJirWK1AlhChmlAwv0pOTjEMQeRlZn8Fy99nsEUCTAQm6H+gBO
         AZoTNLALO+rgMSAwA7AuJSQeOODTVSothIJCFAXS4/PyOOBrvRVs3nj3AnoTKO9kAtWK
         sK5Fwltu5W6G3fVa9NaUlfgPhVcOOzy2b5kxXs+ZJozt1nA/gsbBDFxiQD7hCLhDjMZT
         Yusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720806097; x=1721410897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6oJ1XrcSAaEnDmhpInm1jcjWUkm99FpJs4UY5Cb2GM=;
        b=ZemQfYzOjoVdpo7j67+R4e7SLZJYKOlpNaAXsmauaYqVLxUf7QDdX0tnajstew1vyM
         MYrTHGRwcRgsX7dvJUVdUown1EjWKGAQROU9CTaUb1jb+mXb1lcCOV8b9kOsRx/7GC3a
         hKZ/Rtj2TBKVaHNnpNgK+hKrISPlMEs3i26aLEiCuISzxNqS8Yp6vCo9gXlrPcnEOTsY
         VovmwaUQve2GNhLBK5luHLaQL4MDUsgL8hrwvVubSKAFaqGLjn+nygkEwXpXqOERRe/Z
         HxOstNR3l7RO1eLxzG7vMwXb2XvPAtq5wZk5WDVxNkB6tlVeX8KBq7jbyacqMICRwhxJ
         +XpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVepMX6ko5ev8+Dyhyyt7vllxgfva0ykDI47FMjXV40wuL/aGGEwxwPJ2aRp5/Xf0Dw7lcbbCOYJcjELS00FgKPABo5
X-Gm-Message-State: AOJu0Yxv6DAahbl4idzOnldZMi2qGg+Xd/fVtUn4vXKD+wKDP6kPuonY
	9KtztrdhCop05WLY958CVTmv51Gx5gQi4cml16wL0wjmtieQmxCAOcfX5/d9TodhPe3zymf11wz
	JrryqQ/ZbKgvKgyo9CzfkVPyW5Xg=
X-Google-Smtp-Source: AGHT+IEmnvrnWO0VI+jjiyWf1nlXhFX7uyDjva2hSxvhsfzkDTAm+gF1CQS+UmCNUhv9pbgMc8s1udqn1SAyFHuk8Ac=
X-Received: by 2002:a05:690c:6684:b0:64b:f86:b7a8 with SMTP id
 00721157ae682-658ee6998f4mr166676967b3.10.1720806096455; Fri, 12 Jul 2024
 10:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240628190503.67389-7-eric.peijian@gmail.com> <7lc6m7627sojdzabmz6pvaulbrcods6tqf7bnf3vxqsxzievjl@ixbispu2b3ch>
In-Reply-To: <7lc6m7627sojdzabmz6pvaulbrcods6tqf7bnf3vxqsxzievjl@ixbispu2b3ch>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Fri, 12 Jul 2024 13:41:25 -0400
Message-ID: <CAN2LT1AKqSJvUiXphH8MZ5vwOKLy=qAhBUy7=y_yFF8JfO2KuA@mail.gmail.com>
Subject: Re: [PATCH 6/6] cat-file: add remote-object-info to batch-command
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 9:51=E2=80=AFPM Justin Tobler <jltobler@gmail.com> w=
rote:
>
> On 24/06/28 03:05PM, Eric Ju wrote:
> > From: Calvin Wan <calvinwan@google.com>
> >
> > Since the `info` command in cat-file --batch-command prints object info
> > for a given object, it is natural to add another command in cat-file
> > --batch-command to print object info for a given object from a remote.
> > Add `remote-object-info` to cat-file --batch-command.
> >
> > While `info` takes object ids one at a time, this creates overhead when
> > making requests to a server so `remote-object-info` instead can take
> > multiple object ids at once.
> >
> > cat-file --batch-command is generally implemented in the following
> > manner:
> >
> >  - Receive and parse input from user
> >  - Call respective function attached to command
> >  - Set batch mode state, get object info, print object info
> >
> > In --buffer mode, this changes to:
> >
> >  - Receive and parse input from user
> >  - Store respective function attached to command in a queue
> >  - After flush, loop through commands in queue
> >     - Call respective function attached to command
> >     - Set batch mode state, get object info, print object info
>
> So the problem is that there is overhead associated with getting object
> info from the remote. Therefore, remote-object-info also supports
> batching objects together. This seems reasonable.
>

Thank you, Justin. Yes, you are right, whenever remote-object-info is
called there is an overhead. I will explain where this overhead
happens in the following reply.

> >
> > Notice how the getting and printing of object info is accomplished one
> > at a time. As described above, this creates a problem for making
> > requests to a server. Therefore, `remote-object-info` is implemented in
> > the following manner:
> >
> >  - Receive and parse input from user
> >  If command is `remote-object-info`:
> >     - Get object info from remote
> >     - Loop through object info
> >         - Call respective function attached to `info`
> >         - Set batch mode state, use passed in object info, print object
> >           info
> >  Else:
> >     - Call respective function attached to command
> >     - Parse input, get object info, print object info
> >
> > And finally for --buffer mode `remote-object-info`:
> >  - Receive and parse input from user
> >  - Store respective function attached to command in a queue
> >  - After flush, loop through commands in queue:
> >     If command is `remote-object-info`:
> >         - Get object info from remote
> >         - Loop through object info
> >             - Call respective function attached to `info`
> >             - Set batch mode state, use passed in object info, print
> >               object info
> >     Else:
> >         - Call respective function attached to command
> >         - Set batch mode state, get object info, print object info
> >
> > To summarize, `remote-object-info` gets object info from the remote and
> > then generates multiple `info` commands with the object info passed in.
> >
> > In order for remote-object-info to avoid remote communication overhead
> > in the non-buffer mode, the objects are passed in as such:
>
> Even in non-buffer mode, having separate remote-object-info commands
> would result in additional overhead correct? From my understanding each
> command is executed sequently, so multiples of remote-object-info would
> always result in additional overhead.
>

Thank you. No matter what mode it is (buffer or non-buffer), the
overhead of remote-object-info is always there. To my understanding,
there are two parts in the overhead:
1. Setting up a connection. This is happening in `connect_setup()` in
`fetch_object_info()` function.
2. Sending request buf. This includes initializing the packet reader
in `packet_reader_init()` and putting OIDs in the request buff in
`send_object_info_request()`. Both of them are called in the
`fetch_object_info()` function.

It would be more efficient to send multiple OIDs over one request
packet in one connection in the form of  remote-object-info <remote>
<oid> <oid> ... <oid>

> >
> > remote-object-info <remote> <oid> <oid> ... <oid>
> >
> > rather than
> >
> > remote-object-info <remote> <oid>
> > remote-object-info <remote> <oid>
> > ...
> > remote-object-info <remote> <oid>
> >
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
> > Helped-by: Jonathan Tan <jonathantanmy@google.com>
> > Helped-by: Christian Couder <chriscool@tuxfamily.org>
>
> I think the sign-offs are supposed to go at the bottom.
>

Thank you. I am fixing it in v2.

> [snip]
> > @@ -526,51 +533,118 @@ static void batch_one_object(const char *obj_nam=
e,
> >               (opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0);
> >       enum get_oid_result result;
> >
> > -     result =3D get_oid_with_context(the_repository, obj_name,
> > -                                   flags, &data->oid, &ctx);
> > -     if (result !=3D FOUND) {
> > -             switch (result) {
> > -             case MISSING_OBJECT:
> > -                     printf("%s missing%c", obj_name, opt->output_deli=
m);
> > -                     break;
> > -             case SHORT_NAME_AMBIGUOUS:
> > -                     printf("%s ambiguous%c", obj_name, opt->output_de=
lim);
> > -                     break;
> > -             case DANGLING_SYMLINK:
> > -                     printf("dangling %"PRIuMAX"%c%s%c",
> > -                            (uintmax_t)strlen(obj_name),
> > -                            opt->output_delim, obj_name, opt->output_d=
elim);
> > -                     break;
> > -             case SYMLINK_LOOP:
> > -                     printf("loop %"PRIuMAX"%c%s%c",
> > -                            (uintmax_t)strlen(obj_name),
> > -                            opt->output_delim, obj_name, opt->output_d=
elim);
> > -                     break;
> > -             case NOT_DIR:
> > -                     printf("notdir %"PRIuMAX"%c%s%c",
> > -                            (uintmax_t)strlen(obj_name),
> > -                            opt->output_delim, obj_name, opt->output_d=
elim);
> > -                     break;
> > -             default:
> > -                     BUG("unknown get_sha1_with_context result %d\n",
> > -                            result);
> > -                     break;
> > +     if (!opt->use_remote_info) {
>
> When using the remote-object-info command, the object in question is
> supposed to be on the remote and may not exist locally. Therefore we
> skip over `get_oid_with_context()`.
>

Thank you. Yes, that is the reason. I reworded your comment and added
it to the code in v2 to make it easier to follow.

> > +             result =3D get_oid_with_context(the_repository, obj_name,
> > +                                             flags, &data->oid, &ctx);
> > +             if (result !=3D FOUND) {
> > +                     switch (result) {
> > +                     case MISSING_OBJECT:
> > +                             printf("%s missing%c", obj_name, opt->out=
put_delim);
> > +                             break;
> > +                     case SHORT_NAME_AMBIGUOUS:
> > +                             printf("%s ambiguous%c", obj_name, opt->o=
utput_delim);
> > +                             break;
> > +                     case DANGLING_SYMLINK:
> > +                             printf("dangling %"PRIuMAX"%c%s%c",
> > +                                     (uintmax_t)strlen(obj_name),
> > +                                     opt->output_delim, obj_name, opt-=
>output_delim);
> > +                             break;
> > +                     case SYMLINK_LOOP:
> > +                             printf("loop %"PRIuMAX"%c%s%c",
> > +                                     (uintmax_t)strlen(obj_name),
> > +                                     opt->output_delim, obj_name, opt-=
>output_delim);
> > +                             break;
> > +                     case NOT_DIR:
> > +                             printf("notdir %"PRIuMAX"%c%s%c",
> > +                                     (uintmax_t)strlen(obj_name),
> > +                                     opt->output_delim, obj_name, opt-=
>output_delim);
> > +                             break;
> > +                     default:
> > +                             BUG("unknown get_sha1_with_context result=
 %d\n",
> > +                                     result);
> > +                             break;
> > +                     }
> > +                     fflush(stdout);
> > +                     return;
> >               }
> > -             fflush(stdout);
> > -             return;
> > -     }
> >
> > -     if (ctx.mode =3D=3D 0) {
> > -             printf("symlink %"PRIuMAX"%c%s%c",
> > -                    (uintmax_t)ctx.symlink_path.len,
> > -                    opt->output_delim, ctx.symlink_path.buf, opt->outp=
ut_delim);
> > -             fflush(stdout);
> > -             return;
> > +             if (ctx.mode =3D=3D 0) {
> > +                     printf("symlink %"PRIuMAX"%c%s%c",
> > +                             (uintmax_t)ctx.symlink_path.len,
> > +                             opt->output_delim, ctx.symlink_path.buf, =
opt->output_delim);
> > +                     fflush(stdout);
> > +                     return;
> > +             }
> >       }
> >
> >       batch_object_write(obj_name, scratch, opt, data, NULL, 0);
> >  }
> >
> > +static int get_remote_info(struct batch_options *opt, int argc, const =
char **argv)
> > +{
> > +     int retval =3D 0;
> > +     struct remote *remote =3D NULL;
> > +     struct object_id oid;
> > +     struct string_list object_info_options =3D STRING_LIST_INIT_NODUP=
;
> > +     static struct transport *gtransport;
> > +
> > +     /*
> > +      * Change the format to "%(objectname) %(objectsize)" when
> > +      * remote-object-info command is used. Once we start supporting o=
bjecttype
> > +      * the default format should change to DEFAULT_FORMAT
> > +     */
> > +     if (!opt->format) {
> > +             opt->format =3D "%(objectname) %(objectsize)";
> > +     }
>
> We should omit the parenthesis for single line if statements.
>

Thank you. Fixed in V2.

> > +
> > +     remote =3D remote_get(argv[0]);
> > +     if (!remote)
> > +             die(_("must supply valid remote when using remote-object-=
info"));
> > +     oid_array_clear(&object_info_oids);
> > +     for (size_t i =3D 1; i < argc; i++) {
> > +             if (get_oid_hex(argv[i], &oid))
> > +                     die(_("Not a valid object name %s"), argv[i]);
> > +             oid_array_append(&object_info_oids, &oid);
> > +     }
> > +
> > +     gtransport =3D transport_get(remote, NULL);
> > +     if (gtransport->smart_options) {
> > +             int include_size =3D 0;
> > +
> > +             CALLOC_ARRAY(remote_object_info, object_info_oids.nr);
> > +             gtransport->smart_options->object_info =3D 1;
> > +             gtransport->smart_options->object_info_oids =3D &object_i=
nfo_oids;
> > +             /*
> > +              * 'size' is the only option currently supported.
> > +              * Other options that are passed in the format will exit =
with error.
> > +              */
> > +             if (strstr(opt->format, "%(objectsize)")) {
> > +                     string_list_append(&object_info_options, "size");
> > +                     include_size =3D 1;
> > +             }
> > +             if (strstr(opt->format, "%(objecttype)")) {
> > +                     die(_("objecttype is currently not supported with=
 remote-object-info"));
> > +             }
>
> Another single line if statement above that should omit the parenthesis.
>

Thank you. Fixed in V2.

> > +             if (strstr(opt->format, "%(objectsize:disk)"))
> > +                     die(_("objectsize:disk is currently not supported=
 with remote-object-info"));
> > +             if (strstr(opt->format, "%(deltabase)"))
> > +                     die(_("deltabase is currently not supported with =
remote-object-info"));
> > +             if (object_info_options.nr > 0) {
> > +                     gtransport->smart_options->object_info_options =
=3D &object_info_options;
> > +                     for (size_t i =3D 0; i < object_info_oids.nr; i++=
) {
> > +                             if (include_size)
> > +                                     remote_object_info[i].sizep =3D x=
calloc(1, sizeof(long));
> > +                     }
> > +                     gtransport->smart_options->object_info_data =3D &=
remote_object_info;
> > +                     retval =3D transport_fetch_refs(gtransport, NULL)=
;
> > +             }
> > +     } else {
> > +             retval =3D -1;
> > +     }
> > +
> > +     return retval;
> > +}
> > +
> >  struct object_cb_data {
> >       struct batch_options *opt;
> >       struct expand_data *expand;
> > @@ -642,6 +716,7 @@ typedef void (*parse_cmd_fn_t)(struct batch_options=
 *, const char *,
> >  struct queued_cmd {
> >       parse_cmd_fn_t fn;
> >       char *line;
> > +     const char *name;
>
> Since special handling is needed for the remote-object-info command, we
> record the queued command names to check against later.
>

Yes. We need to compare the function name to do special handling
later. But I think we can have a better solution here instead of doing
a name comparison. Please see my reply below.

> >  };
> >
> >  static void parse_cmd_contents(struct batch_options *opt,
> > @@ -662,6 +737,55 @@ static void parse_cmd_info(struct batch_options *o=
pt,
> >       batch_one_object(line, output, opt, data);
> >  }
> >
> > +static const struct parse_cmd {
> > +     const char *name;
> > +     parse_cmd_fn_t fn;
> > +     unsigned takes_args;
> > +} commands[] =3D {
> > +     { "contents", parse_cmd_contents, 1 },
> > +     { "info", parse_cmd_info, 1 },
> > +     { "remote-object-info", parse_cmd_info, 1 },
> > +     { "flush", NULL, 0 },
> > +};
> > +
> > +static void parse_remote_info(struct batch_options *opt,
> > +                        char *line,
> > +                        struct strbuf *output,
> > +                        struct expand_data *data,
> > +                        const struct parse_cmd *p_cmd,
> > +                        struct queued_cmd *q_cmd)
>
> It seems a little confusing to me that `parse_remote_info()` accepts
> both a `parse_cmd` and `queued_cmd`, but only expects to use one or the
> other. It looks like this is done because `dispatch_calls()` already
> accepts `queued_cmd`, but now needs to call `parse_remote_info()`.
>
> Since it is only the underlying command function that is needed by
> `parse_remote_info()`
>

Thank you. I agree. I did some refactoring. Please see me reply below.


> > +{
> > +     int count;
> > +     const char **argv;
> > +
> > +     count =3D split_cmdline(line, &argv);
> > +     if (get_remote_info(opt, count, argv))
> > +             goto cleanup;
> > +     opt->use_remote_info =3D 1;
> > +     data->skip_object_info =3D 1;
> > +     data->mark_query =3D 0;
> > +     for (size_t i =3D 0; i < object_info_oids.nr; i++) {
> > +             if (remote_object_info[i].sizep)
> > +                     data->size =3D *remote_object_info[i].sizep;
> > +             if (remote_object_info[i].typep)
> > +                     data->type =3D *remote_object_info[i].typep;
> > +
> > +             data->oid =3D object_info_oids.oid[i];
> > +             if (p_cmd)
> > +                     p_cmd->fn(opt, argv[i+1], output, data);
> > +             else
> > +                     q_cmd->fn(opt, argv[i+1], output, data);
> > +     }
> > +     opt->use_remote_info =3D 0;
> > +     data->skip_object_info =3D 0;
> > +     data->mark_query =3D 1;
> > +
> > +cleanup:
> > +     for (size_t i =3D 0; i < object_info_oids.nr; i++)
> > +             free_object_info_contents(&remote_object_info[i]);
> > +     free(remote_object_info);
> > +}
> > +
> >  static void dispatch_calls(struct batch_options *opt,
> >               struct strbuf *output,
> >               struct expand_data *data,
> > @@ -671,8 +795,12 @@ static void dispatch_calls(struct batch_options *o=
pt,
> >       if (!opt->buffer_output)
> >               die(_("flush is only for --buffer mode"));
> >
> > -     for (int i =3D 0; i < nr; i++)
> > -             cmd[i].fn(opt, cmd[i].line, output, data);
> > +     for (int i =3D 0; i < nr; i++) {
> > +             if (!strcmp(cmd[i].name, "remote-object-info"))
> > +                     parse_remote_info(opt, cmd[i].line, output, data,=
 NULL, &cmd[i]);
>
> If we adapt `parse_remote_info()` to accept the command function we
> could pass cmd->fn here instead.
>

Thank you. I think I can push it a bit further.

Under the hood, parse_remote_info will use parse_cmd_info to print the
retrieved information to the client. That is why it had this line
originally:
  ...
   { "remote-object-info", parse_cmd_info, 1 },
  ...

Inspired by your comment, I am thinking if I can adapt
parse_remote_info() 's signature to the same as parse_cmd_info(). It
would make the code cleaner. To be specific. I can

1. get rid of name cooperation in
   ...
   if (!strcmp(cmd[i].name, "remote-object-info"))
       parse_remote_info(opt, cmd[i].line, output, data, NULL, &cmd[I]);
   else
       cmd[i].fn(opt, cmd[i].line, output, data);
   ...
   and I can just use `cmd[i].fn(opt, cmd[i].line, output, data)`

2. get rid of
   ...
   if (p_cmd)
        p_cmd->fn(opt, argv[i+1], output, data);
   else
        q_cmd->fn(opt, argv[i+1], output, data);
   ...

I will make this change in V2.

> > +             else
> > +                     cmd[i].fn(opt, cmd[i].line, output, data);
> > +     }
> >
> >       fflush(stdout);
> >  }
> > @@ -685,17 +813,6 @@ static void free_cmds(struct queued_cmd *cmd, size=
_t *nr)
> >       *nr =3D 0;
> >  }
> >
> > -
> > -static const struct parse_cmd {
> > -     const char *name;
> > -     parse_cmd_fn_t fn;
> > -     unsigned takes_args;
> > -} commands[] =3D {
> > -     { "contents", parse_cmd_contents, 1},
> > -     { "info", parse_cmd_info, 1},
> > -     { "flush", NULL, 0},
> > -};
> > -
> >  static void batch_objects_command(struct batch_options *opt,
> >                                   struct strbuf *output,
> >                                   struct expand_data *data)
> > @@ -740,11 +857,17 @@ static void batch_objects_command(struct batch_op=
tions *opt,
> >                       dispatch_calls(opt, output, data, queued_cmd, nr)=
;
> >                       free_cmds(queued_cmd, &nr);
> >               } else if (!opt->buffer_output) {
> > -                     cmd->fn(opt, p, output, data);
> > +                     if (!strcmp(cmd->name, "remote-object-info")) {
> > +                             char *line =3D xstrdup_or_null(p);
> > +                             parse_remote_info(opt, line, output, data=
, cmd, NULL);
>
> Same here, if we adapt `parse_remote_info()` to accept the command
> function we could pass cmd->fn here instead.

Thank you. Please see my reply above.

> > +                     } else {
> > +                             cmd->fn(opt, p, output, data);
> > +                     }
> >               } else {
> >                       ALLOC_GROW(queued_cmd, nr + 1, alloc);
> >                       call.fn =3D cmd->fn;
> >                       call.line =3D xstrdup_or_null(p);
> > +                     call.name =3D cmd->name;
> >                       queued_cmd[nr++] =3D call;
> >               }
> >       }
> > @@ -761,8 +884,6 @@ static void batch_objects_command(struct batch_opti=
ons *opt,
> >       strbuf_release(&input);
> >  }
> >
> > -#define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
> > -
> >  static int batch_objects(struct batch_options *opt)
> >  {
> >       struct strbuf input =3D STRBUF_INIT;
> [snip]

On Mon, Jul 8, 2024 at 9:51=E2=80=AFPM Justin Tobler <jltobler@gmail.com> w=
rote:
>
> On 24/06/28 03:05PM, Eric Ju wrote:
> > From: Calvin Wan <calvinwan@google.com>
> >
> > Since the `info` command in cat-file --batch-command prints object info
> > for a given object, it is natural to add another command in cat-file
> > --batch-command to print object info for a given object from a remote.
> > Add `remote-object-info` to cat-file --batch-command.
> >
> > While `info` takes object ids one at a time, this creates overhead when
> > making requests to a server so `remote-object-info` instead can take
> > multiple object ids at once.
> >
> > cat-file --batch-command is generally implemented in the following
> > manner:
> >
> >  - Receive and parse input from user
> >  - Call respective function attached to command
> >  - Set batch mode state, get object info, print object info
> >
> > In --buffer mode, this changes to:
> >
> >  - Receive and parse input from user
> >  - Store respective function attached to command in a queue
> >  - After flush, loop through commands in queue
> >     - Call respective function attached to command
> >     - Set batch mode state, get object info, print object info
>
> So the problem is that there is overhead associated with getting object
> info from the remote. Therefore, remote-object-info also supports
> batching objects together. This seems reasonable.
>
> >
> > Notice how the getting and printing of object info is accomplished one
> > at a time. As described above, this creates a problem for making
> > requests to a server. Therefore, `remote-object-info` is implemented in
> > the following manner:
> >
> >  - Receive and parse input from user
> >  If command is `remote-object-info`:
> >     - Get object info from remote
> >     - Loop through object info
> >         - Call respective function attached to `info`
> >         - Set batch mode state, use passed in object info, print object
> >           info
> >  Else:
> >     - Call respective function attached to command
> >     - Parse input, get object info, print object info
> >
> > And finally for --buffer mode `remote-object-info`:
> >  - Receive and parse input from user
> >  - Store respective function attached to command in a queue
> >  - After flush, loop through commands in queue:
> >     If command is `remote-object-info`:
> >         - Get object info from remote
> >         - Loop through object info
> >             - Call respective function attached to `info`
> >             - Set batch mode state, use passed in object info, print
> >               object info
> >     Else:
> >         - Call respective function attached to command
> >         - Set batch mode state, get object info, print object info
> >
> > To summarize, `remote-object-info` gets object info from the remote and
> > then generates multiple `info` commands with the object info passed in.
> >
> > In order for remote-object-info to avoid remote communication overhead
> > in the non-buffer mode, the objects are passed in as such:
>
> Even in non-buffer mode, having separate remote-object-info commands
> would result in additional overhead correct? From my understanding each
> command is executed sequently, so multiples of remote-object-info would
> always result in additional overhead.
>
> >
> > remote-object-info <remote> <oid> <oid> ... <oid>
> >
> > rather than
> >
> > remote-object-info <remote> <oid>
> > remote-object-info <remote> <oid>
> > ...
> > remote-object-info <remote> <oid>
> >
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
> > Helped-by: Jonathan Tan <jonathantanmy@google.com>
> > Helped-by: Christian Couder <chriscool@tuxfamily.org>
>
> I think the sign-offs are supposed to go at the bottom.
>
> [snip]
> > @@ -526,51 +533,118 @@ static void batch_one_object(const char *obj_nam=
e,
> >               (opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0);
> >       enum get_oid_result result;
> >
> > -     result =3D get_oid_with_context(the_repository, obj_name,
> > -                                   flags, &data->oid, &ctx);
> > -     if (result !=3D FOUND) {
> > -             switch (result) {
> > -             case MISSING_OBJECT:
> > -                     printf("%s missing%c", obj_name, opt->output_deli=
m);
> > -                     break;
> > -             case SHORT_NAME_AMBIGUOUS:
> > -                     printf("%s ambiguous%c", obj_name, opt->output_de=
lim);
> > -                     break;
> > -             case DANGLING_SYMLINK:
> > -                     printf("dangling %"PRIuMAX"%c%s%c",
> > -                            (uintmax_t)strlen(obj_name),
> > -                            opt->output_delim, obj_name, opt->output_d=
elim);
> > -                     break;
> > -             case SYMLINK_LOOP:
> > -                     printf("loop %"PRIuMAX"%c%s%c",
> > -                            (uintmax_t)strlen(obj_name),
> > -                            opt->output_delim, obj_name, opt->output_d=
elim);
> > -                     break;
> > -             case NOT_DIR:
> > -                     printf("notdir %"PRIuMAX"%c%s%c",
> > -                            (uintmax_t)strlen(obj_name),
> > -                            opt->output_delim, obj_name, opt->output_d=
elim);
> > -                     break;
> > -             default:
> > -                     BUG("unknown get_sha1_with_context result %d\n",
> > -                            result);
> > -                     break;
> > +     if (!opt->use_remote_info) {
>
> When using the remote-object-info command, the object in question is
> supposed to be on the remote and may not exist locally. Therefore we
> skip over `get_oid_with_context()`.
>
> > +             result =3D get_oid_with_context(the_repository, obj_name,
> > +                                             flags, &data->oid, &ctx);
> > +             if (result !=3D FOUND) {
> > +                     switch (result) {
> > +                     case MISSING_OBJECT:
> > +                             printf("%s missing%c", obj_name, opt->out=
put_delim);
> > +                             break;
> > +                     case SHORT_NAME_AMBIGUOUS:
> > +                             printf("%s ambiguous%c", obj_name, opt->o=
utput_delim);
> > +                             break;
> > +                     case DANGLING_SYMLINK:
> > +                             printf("dangling %"PRIuMAX"%c%s%c",
> > +                                     (uintmax_t)strlen(obj_name),
> > +                                     opt->output_delim, obj_name, opt-=
>output_delim);
> > +                             break;
> > +                     case SYMLINK_LOOP:
> > +                             printf("loop %"PRIuMAX"%c%s%c",
> > +                                     (uintmax_t)strlen(obj_name),
> > +                                     opt->output_delim, obj_name, opt-=
>output_delim);
> > +                             break;
> > +                     case NOT_DIR:
> > +                             printf("notdir %"PRIuMAX"%c%s%c",
> > +                                     (uintmax_t)strlen(obj_name),
> > +                                     opt->output_delim, obj_name, opt-=
>output_delim);
> > +                             break;
> > +                     default:
> > +                             BUG("unknown get_sha1_with_context result=
 %d\n",
> > +                                     result);
> > +                             break;
> > +                     }
> > +                     fflush(stdout);
> > +                     return;
> >               }
> > -             fflush(stdout);
> > -             return;
> > -     }
> >
> > -     if (ctx.mode =3D=3D 0) {
> > -             printf("symlink %"PRIuMAX"%c%s%c",
> > -                    (uintmax_t)ctx.symlink_path.len,
> > -                    opt->output_delim, ctx.symlink_path.buf, opt->outp=
ut_delim);
> > -             fflush(stdout);
> > -             return;
> > +             if (ctx.mode =3D=3D 0) {
> > +                     printf("symlink %"PRIuMAX"%c%s%c",
> > +                             (uintmax_t)ctx.symlink_path.len,
> > +                             opt->output_delim, ctx.symlink_path.buf, =
opt->output_delim);
> > +                     fflush(stdout);
> > +                     return;
> > +             }
> >       }
> >
> >       batch_object_write(obj_name, scratch, opt, data, NULL, 0);
> >  }
> >
> > +static int get_remote_info(struct batch_options *opt, int argc, const =
char **argv)
> > +{
> > +     int retval =3D 0;
> > +     struct remote *remote =3D NULL;
> > +     struct object_id oid;
> > +     struct string_list object_info_options =3D STRING_LIST_INIT_NODUP=
;
> > +     static struct transport *gtransport;
> > +
> > +     /*
> > +      * Change the format to "%(objectname) %(objectsize)" when
> > +      * remote-object-info command is used. Once we start supporting o=
bjecttype
> > +      * the default format should change to DEFAULT_FORMAT
> > +     */
> > +     if (!opt->format) {
> > +             opt->format =3D "%(objectname) %(objectsize)";
> > +     }
>
> We should omit the parenthesis for single line if statements.
>
> > +
> > +     remote =3D remote_get(argv[0]);
> > +     if (!remote)
> > +             die(_("must supply valid remote when using remote-object-=
info"));
> > +     oid_array_clear(&object_info_oids);
> > +     for (size_t i =3D 1; i < argc; i++) {
> > +             if (get_oid_hex(argv[i], &oid))
> > +                     die(_("Not a valid object name %s"), argv[i]);
> > +             oid_array_append(&object_info_oids, &oid);
> > +     }
> > +
> > +     gtransport =3D transport_get(remote, NULL);
> > +     if (gtransport->smart_options) {
> > +             int include_size =3D 0;
> > +
> > +             CALLOC_ARRAY(remote_object_info, object_info_oids.nr);
> > +             gtransport->smart_options->object_info =3D 1;
> > +             gtransport->smart_options->object_info_oids =3D &object_i=
nfo_oids;
> > +             /*
> > +              * 'size' is the only option currently supported.
> > +              * Other options that are passed in the format will exit =
with error.
> > +              */
> > +             if (strstr(opt->format, "%(objectsize)")) {
> > +                     string_list_append(&object_info_options, "size");
> > +                     include_size =3D 1;
> > +             }
> > +             if (strstr(opt->format, "%(objecttype)")) {
> > +                     die(_("objecttype is currently not supported with=
 remote-object-info"));
> > +             }
>
> Another single line if statement above that should omit the parenthesis.
>
> > +             if (strstr(opt->format, "%(objectsize:disk)"))
> > +                     die(_("objectsize:disk is currently not supported=
 with remote-object-info"));
> > +             if (strstr(opt->format, "%(deltabase)"))
> > +                     die(_("deltabase is currently not supported with =
remote-object-info"));
> > +             if (object_info_options.nr > 0) {
> > +                     gtransport->smart_options->object_info_options =
=3D &object_info_options;
> > +                     for (size_t i =3D 0; i < object_info_oids.nr; i++=
) {
> > +                             if (include_size)
> > +                                     remote_object_info[i].sizep =3D x=
calloc(1, sizeof(long));
> > +                     }
> > +                     gtransport->smart_options->object_info_data =3D &=
remote_object_info;
> > +                     retval =3D transport_fetch_refs(gtransport, NULL)=
;
> > +             }
> > +     } else {
> > +             retval =3D -1;
> > +     }
> > +
> > +     return retval;
> > +}
> > +
> >  struct object_cb_data {
> >       struct batch_options *opt;
> >       struct expand_data *expand;
> > @@ -642,6 +716,7 @@ typedef void (*parse_cmd_fn_t)(struct batch_options=
 *, const char *,
> >  struct queued_cmd {
> >       parse_cmd_fn_t fn;
> >       char *line;
> > +     const char *name;
>
> Since special handling is needed for the remote-object-info command, we
> record the queued command names to check against later.
>
> >  };
> >
> >  static void parse_cmd_contents(struct batch_options *opt,
> > @@ -662,6 +737,55 @@ static void parse_cmd_info(struct batch_options *o=
pt,
> >       batch_one_object(line, output, opt, data);
> >  }
> >
> > +static const struct parse_cmd {
> > +     const char *name;
> > +     parse_cmd_fn_t fn;
> > +     unsigned takes_args;
> > +} commands[] =3D {
> > +     { "contents", parse_cmd_contents, 1 },
> > +     { "info", parse_cmd_info, 1 },
> > +     { "remote-object-info", parse_cmd_info, 1 },
> > +     { "flush", NULL, 0 },
> > +};
> > +
> > +static void parse_remote_info(struct batch_options *opt,
> > +                        char *line,
> > +                        struct strbuf *output,
> > +                        struct expand_data *data,
> > +                        const struct parse_cmd *p_cmd,
> > +                        struct queued_cmd *q_cmd)
>
> It seems a little confusing to me that `parse_remote_info()` accepts
> both a `parse_cmd` and `queued_cmd`, but only expects to use one or the
> other. It looks like this is done because `dispatch_calls()` already
> accepts `queued_cmd`, but now needs to call `parse_remote_info()`.
>
> Since it is only the underlying command function that is needed by
> `parse_remote_info()`
>
> > +{
> > +     int count;
> > +     const char **argv;
> > +
> > +     count =3D split_cmdline(line, &argv);
> > +     if (get_remote_info(opt, count, argv))
> > +             goto cleanup;
> > +     opt->use_remote_info =3D 1;
> > +     data->skip_object_info =3D 1;
> > +     data->mark_query =3D 0;
> > +     for (size_t i =3D 0; i < object_info_oids.nr; i++) {
> > +             if (remote_object_info[i].sizep)
> > +                     data->size =3D *remote_object_info[i].sizep;
> > +             if (remote_object_info[i].typep)
> > +                     data->type =3D *remote_object_info[i].typep;
> > +
> > +             data->oid =3D object_info_oids.oid[i];
> > +             if (p_cmd)
> > +                     p_cmd->fn(opt, argv[i+1], output, data);
> > +             else
> > +                     q_cmd->fn(opt, argv[i+1], output, data);
> > +     }
> > +     opt->use_remote_info =3D 0;
> > +     data->skip_object_info =3D 0;
> > +     data->mark_query =3D 1;
> > +
> > +cleanup:
> > +     for (size_t i =3D 0; i < object_info_oids.nr; i++)
> > +             free_object_info_contents(&remote_object_info[i]);
> > +     free(remote_object_info);
> > +}
> > +
> >  static void dispatch_calls(struct batch_options *opt,
> >               struct strbuf *output,
> >               struct expand_data *data,
> > @@ -671,8 +795,12 @@ static void dispatch_calls(struct batch_options *o=
pt,
> >       if (!opt->buffer_output)
> >               die(_("flush is only for --buffer mode"));
> >
> > -     for (int i =3D 0; i < nr; i++)
> > -             cmd[i].fn(opt, cmd[i].line, output, data);
> > +     for (int i =3D 0; i < nr; i++) {
> > +             if (!strcmp(cmd[i].name, "remote-object-info"))
> > +                     parse_remote_info(opt, cmd[i].line, output, data,=
 NULL, &cmd[i]);
>
> If we adapt `parse_remote_info()` to accept the command function we
> could pass cmd->fn here instead.
>
> > +             else
> > +                     cmd[i].fn(opt, cmd[i].line, output, data);
> > +     }
> >
> >       fflush(stdout);
> >  }
> > @@ -685,17 +813,6 @@ static void free_cmds(struct queued_cmd *cmd, size=
_t *nr)
> >       *nr =3D 0;
> >  }
> >
> > -
> > -static const struct parse_cmd {
> > -     const char *name;
> > -     parse_cmd_fn_t fn;
> > -     unsigned takes_args;
> > -} commands[] =3D {
> > -     { "contents", parse_cmd_contents, 1},
> > -     { "info", parse_cmd_info, 1},
> > -     { "flush", NULL, 0},
> > -};
> > -
> >  static void batch_objects_command(struct batch_options *opt,
> >                                   struct strbuf *output,
> >                                   struct expand_data *data)
> > @@ -740,11 +857,17 @@ static void batch_objects_command(struct batch_op=
tions *opt,
> >                       dispatch_calls(opt, output, data, queued_cmd, nr)=
;
> >                       free_cmds(queued_cmd, &nr);
> >               } else if (!opt->buffer_output) {
> > -                     cmd->fn(opt, p, output, data);
> > +                     if (!strcmp(cmd->name, "remote-object-info")) {
> > +                             char *line =3D xstrdup_or_null(p);
> > +                             parse_remote_info(opt, line, output, data=
, cmd, NULL);
>
> Same here, if we adapt `parse_remote_info()` to accept the command
> function we could pass cmd->fn here instead.
>
> > +                     } else {
> > +                             cmd->fn(opt, p, output, data);
> > +                     }
> >               } else {
> >                       ALLOC_GROW(queued_cmd, nr + 1, alloc);
> >                       call.fn =3D cmd->fn;
> >                       call.line =3D xstrdup_or_null(p);
> > +                     call.name =3D cmd->name;
> >                       queued_cmd[nr++] =3D call;
> >               }
> >       }
> > @@ -761,8 +884,6 @@ static void batch_objects_command(struct batch_opti=
ons *opt,
> >       strbuf_release(&input);
> >  }
> >
> > -#define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
> > -
> >  static int batch_objects(struct batch_options *opt)
> >  {
> >       struct strbuf input =3D STRBUF_INIT;
> [snip]
