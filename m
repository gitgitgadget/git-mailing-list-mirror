Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E1D4685
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 02:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721183920; cv=none; b=fQfYNsoFocoObNHSA80apns//yl9W+QXA9No+ljJ4awd/N9sT966LHfSm9VibLhA+o2bnOycvUvReuGl5S5yNpYjZUDiXkDDDnrsgGioWRDSCgoASsfWuIRiatwjbe6a5oEElMDBAqi3VaA/t3UFgnkcqswDkhMCeDx7+lbDAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721183920; c=relaxed/simple;
	bh=gaRhF4KQAD6fdsyXA0w1CPAqVK+LgH+Udy7DjbBsUTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufpROGk+GOAzn0VY4t7T9Z688goY7B8HvlCg5fizp/k3eYLsCakcVuwoTg2cgyPxPeYg3cqJ7W+ef59IEEc/lexVLJzhKjdDdUeF9IWQXF7n3Giht/h4l+FykwfZ/79m8YRjkDhb2nNySxrzC/4Vds922fYIkve2PUXv7HSZXOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYUtf8Nl; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYUtf8Nl"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso6499565276.0
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 19:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721183916; x=1721788716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNhgquJVDcWcYdTN40oPGydJqEWrZKSvhE3hTd3Y0o8=;
        b=nYUtf8NlM+quSL6/01Sw/9KyTHx5lCOGnepVUfECqncBI8HOPvJK6rBUzi8JogwRTR
         sxYUWNnaLWOEmmkVoWsX75DyCXq52unFub6FDO9fhQDuMptGuIQO9bgK0MuP22zPSdgi
         7MS22ysJdhObjlQUKXIUSWRK1DKb40oMxxvKUQUfyzuvLHhgNauU1K7Zn7LZspZzNnNj
         z/Cr4aO2sJKQ2D4lDAs2aYHXv/CKH5MeMj4eIn9FHpngL5X2EmJXRuGWMAeeHQDkVT3Q
         XfLHfCisP7U1joDnpolwj8gjzkyNQCoywl4We+7an3qD1pWey/BmP2adFPFJu2WtFXKb
         VDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721183916; x=1721788716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNhgquJVDcWcYdTN40oPGydJqEWrZKSvhE3hTd3Y0o8=;
        b=VPIs4Ohd9uoWFJp7QBIg8OUws3YGB0gCW1Xwe1GDDaYDOubodXlHhhCAn/W/ybAhMz
         2/C3cEXoOInRcjLAvD4zCvY57DXcsC9KCcZA3CFxVXpxehXvor/O5b4YsppIw3Yei/mD
         NQwpLb44BhQTSMiLJO9ozKDP/VjcSqe4Vmv7DEoh1QKeOTQIAx4JM9gp0JFKZDdk4LNX
         XBcvUcGU6TwfGeGkxdTwD8AAOHhtOPb/hdzP+5lIOMGcvc7JvjzmnW3PyMzzFXM+6vUV
         stLIqKf+06DzeB0X1vsJjiBuVaGkDIejdTUPFNfEPsNnK+tPGK3HIYULVFeR9WAbrBb6
         GDHw==
X-Forwarded-Encrypted: i=1; AJvYcCW3HvVo/W9aDIPxQF1mdA525sYHizxyxzUnj2vlgL5Fs0OLP735P0sL2glBZ5loMB1n3fw570cIgezBasebG9ctMdu6
X-Gm-Message-State: AOJu0Ywy1A7tNRo/Q/nxOCHsjuNQiL8m4kWUi9D2S5R2duDpRfM/iHRL
	IkaISOZuSrcX7JWS61Qpe8ZOMj+H0hH2Agh2t1o8Mn4mvIWYJ0Ui6iaf6l0DwIowZpRwrm3Q+WJ
	9Gda6N2SHelIT3fNquVvxoA80lQk=
X-Google-Smtp-Source: AGHT+IHSqlXsNUbJE+tdakLMwN7zvFgKl52Y6VUR1gZ3t51P+k92kayJoJt6eRqA2NseaAU2Dvj/+DneSOpuTgRLxxM=
X-Received: by 2002:a05:6902:2401:b0:e03:5f4e:3265 with SMTP id
 3f1490d57ef6-e05ed819a39mr472659276.51.1721183915948; Tue, 16 Jul 2024
 19:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240628190503.67389-7-eric.peijian@gmail.com> <CAOLa=ZRL8ByTi3+8ej1Ugh75CU5Rx2grGpNx5ESKOJCrEYg2XA@mail.gmail.com>
In-Reply-To: <CAOLa=ZRL8ByTi3+8ej1Ugh75CU5Rx2grGpNx5ESKOJCrEYg2XA@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Tue, 16 Jul 2024 22:38:24 -0400
Message-ID: <CAN2LT1BK=FzmxDv81v89dxCYxMMhsGt4T-kBRRdeh2x0pns_Lw@mail.gmail.com>
Subject: Re: [PATCH 6/6] cat-file: add remote-object-info to batch-command
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 8:08=E2=80=AFAM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Eric Ju <eric.peijian@gmail.com> writes:
>
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
>
> So this refers input delimited by newline or '\0'.
>

Thank you. The input should take both newline and '\0' into
consideration. We are missing some test coverage on '\0' delimited
input though. I am adding them in V2

> >  - Call respective function attached to command
> >  - Set batch mode state, get object info, print object info
> >
>
> Doesn't the batch mode get set before the input parsing begins?
>

Thank you. Yes, I am also unsure what Calvin "Set batch mode state"
means here. This batch mode is determined when the cat-file command is
called.  But I do see  `opt->batch_mode =3D BATCH_MODE_INFO;` in
`parse_cmd_info and()` and
`opt->batch_mode =3D BATCH_MODE_CONTENTS;` in `parse_cmd_contents()` I
guess that is what Calvin refers to

Anyway, I am removing "Set batch mode state" in V2 to avoid confusion,
It seems too detailed.

> > In --buffer mode, this changes to:
> >
> >  - Receive and parse input from user
> >  - Store respective function attached to command in a queue
> >  - After flush, loop through commands in queue
> >     - Call respective function attached to command
> >     - Set batch mode state, get object info, print object info
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
>
> So this is because we want 'remote-object-info' to also use
> 'parse_cmd_info' similar to 'info'. But I'm not understanding why,
> especially since 'parse_cmd_info' calls 'batch_one_object', and we skip
> most of that code for 'remote-object-info'.
>
> Wouldn't it be cleaner to just define our own 'batch_remote_object' and
> create 'parse_cmd_remote_info' ?
>

Thank you. That makes sense. Actually, I am pushing it a bit further in V2:
1. The interface of parse_remote_info() is changed to parse_cmd_fn_t,
and its name is changed to `parse_cmd_remote_info()`.
2. In `static const struct parse_cmd{...} commands[]`, the
"remote-object-info" is attached with parse_cmd_remote_info() directly
3. In side parse_cmd_remote_info, we don't need
`batch_remote_object()`, all we need is just `batch_object_write()` to
print the object info out. That will simply the code a lot.

We don't need to call parse_cmd_info; also, we can get rid of the name
compare logic, i.e. `if (!strcmp(cmd[i].name, "remote-object-info"))
...`


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
> > ---
> >  Documentation/git-cat-file.txt         |  22 +-
> >  builtin/cat-file.c                     | 231 ++++++++++----
> >  object-file.c                          |  11 +
> >  object-store-ll.h                      |   3 +
> >  t/t1017-cat-file-remote-object-info.sh | 412 +++++++++++++++++++++++++
> >  5 files changed, 620 insertions(+), 59 deletions(-)
> >  create mode 100755 t/t1017-cat-file-remote-object-info.sh
> >
> > diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-fil=
e.txt
> > index bd95a6c10a..ab0647bb39 100644
> > --- a/Documentation/git-cat-file.txt
> > +++ b/Documentation/git-cat-file.txt
> > @@ -149,6 +149,12 @@ info <object>::
> >       Print object info for object reference `<object>`. This correspon=
ds to the
> >       output of `--batch-check`.
> >
> > +remote-object-info <remote> <object>...::
> > +     Print object info for object references `<object>` at specified <=
remote> without
> > +     downloading object from remote.
> > +     Error when no object references is provided.
> > +     This command may be combined with `--buffer`.
> > +
> >  flush::
> >       Used with `--buffer` to execute all preceding commands that were =
issued
> >       since the beginning or since the last flush was issued. When `--b=
uffer`
> > @@ -290,7 +296,8 @@ newline. The available atoms are:
> >       The full hex representation of the object name.
> >
> >  `objecttype`::
> > -     The type of the object (the same as `cat-file -t` reports).
> > +     The type of the object (the same as `cat-file -t` reports). See
> > +     `CAVEATS` below. Not supported by `remote-object-info`.
> >
> >  `objectsize`::
> >       The size, in bytes, of the object (the same as `cat-file -s`
> > @@ -298,13 +305,14 @@ newline. The available atoms are:
> >
> >  `objectsize:disk`::
> >       The size, in bytes, that the object takes up on disk. See the
> > -     note about on-disk sizes in the `CAVEATS` section below.
> > +     note about on-disk sizes in the `CAVEATS` section below. Not
> > +     supported by `remote-object-info`.
> >
> >  `deltabase`::
> >       If the object is stored as a delta on-disk, this expands to the
> >       full hex representation of the delta base object name.
> >       Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
> > -     below.
> > +     below. Not supported by `remote-object-info`.
> >
> >  `rest`::
> >       If this atom is used in the output string, input lines are split
> > @@ -314,7 +322,9 @@ newline. The available atoms are:
> >       line) are output in place of the `%(rest)` atom.
> >
> >  If no format is specified, the default format is `%(objectname)
> > -%(objecttype) %(objectsize)`.
> > +%(objecttype) %(objectsize)`, except remote-object-info command who us=
es
> > +`%(objectname) %(objectsize)` for now because "%(objecttype)" is not s=
upported yet.
> > +When "%(objecttype)" is supported, default format should be unified.
> >
> >  If `--batch` is specified, or if `--batch-command` is used with the `c=
ontents`
> >  command, the object information is followed by the object contents (co=
nsisting
> > @@ -396,6 +406,10 @@ scripting purposes.
> >  CAVEATS
> >  -------
> >
> > +Note that since objecttype, objectsize:disk and deltabase are currentl=
y not supported by the
> > +remote-object-info, git will error and exit when they are in the forma=
t string.
> > +
> > +
> >  Note that the sizes of objects on disk are reported accurately, but ca=
re
> >  should be taken in drawing conclusions about which refs or objects are
> >  responsible for disk usage. The size of a packed non-delta object may =
be
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 72a78cdc8c..34958a1747 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -24,6 +24,9 @@
> >  #include "promisor-remote.h"
> >  #include "mailmap.h"
> >  #include "write-or-die.h"
> > +#include "alias.h"
> > +#include "remote.h"
> > +#include "transport.h"
> >
> >  enum batch_mode {
> >       BATCH_MODE_CONTENTS,
> > @@ -42,9 +45,14 @@ struct batch_options {
> >       char input_delim;
> >       char output_delim;
> >       const char *format;
> > +     int use_remote_info;
> >  };
> >
> > +#define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
> > +
> >  static const char *force_path;
> > +static struct object_info *remote_object_info;
> > +static struct oid_array object_info_oids =3D OID_ARRAY_INIT;
> >
> >  static struct string_list mailmap =3D STRING_LIST_INIT_NODUP;
> >  static int use_mailmap;
> > @@ -508,7 +516,6 @@ static void batch_object_write(const char *obj_name=
,
> >       }
> >
> >       batch_write(opt, scratch->buf, scratch->len);
> > -
>
> Nit: why remove this?
>

Adding it back. Probably caused when resolving conflicts.

> >       if (opt->batch_mode =3D=3D BATCH_MODE_CONTENTS) {
> >               print_object_or_die(opt, data);
> >               batch_write(opt, &opt->output_delim, 1);
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
>
> We need to call `remote_clear()` on this at the end.
>

Thank you. I am not sure about this.

It seems the remote is cached in a hashmap see
https://git.kernel.org/pub/scm/git/git.git/tree/remote.c#n136.
When multiple commands are sent, the remote can be reused from the
hashmap cache.

The life cycle of this hashmap cache seems managed by
"the_repository", see
https://git.kernel.org/pub/scm/git/git.git/tree/remote.c#n720 and
https://git.kernel.org/pub/scm/git/git.git/tree/repository.c#n364.

> > +     struct object_id oid;
> > +     struct string_list object_info_options =3D STRING_LIST_INIT_NODUP=
;
>
> This needs to be cleared.
>

Thank you. Fixed in V2.

> > +     static struct transport *gtransport;
>
> Shouldn't we call `transport_disconnect(transport);`?
>

Thank you. transport_disconnect(transport) is added the end of
get_remote_info() in V2.

> > +     /*
> > +      * Change the format to "%(objectname) %(objectsize)" when
> > +      * remote-object-info command is used. Once we start supporting o=
bjecttype
> > +      * the default format should change to DEFAULT_FORMAT
> > +     */
> > +     if (!opt->format) {
> > +             opt->format =3D "%(objectname) %(objectsize)";
> > +     }
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
> > +             if (strstr(opt->format, "%(objectsize:disk)"))
> > +                     die(_("objectsize:disk is currently not supported=
 with remote-object-info"));
> > +             if (strstr(opt->format, "%(deltabase)"))
> > +                     die(_("deltabase is currently not supported with =
remote-object-info"));
> >
>
> This whole block could be replaced by an else..
>
> if (strstr(opt->format, "%(objectsize)")) {
>         string_list_append(&object_info_options, "size");
>         include_size =3D 1;
> } else {
>         die(_("%s is currently not supported with remote-object-info", op=
t->format));
> }
>

Thank you. Revised in V2.

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
>
> We don't even set the type, so this shouldn't ever be possible right?
>

Thank you. Yes, that is right. Remove that in V2.

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
>
> argv needs to free'd too
>
Thank you. Added in V2.

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
>
> This needs to be free'd.
>

Thank you. This line is removed in V2, but free() is added in the new
code in `parse_cmd_remote_info()`

> > +                             parse_remote_info(opt, line, output, data=
, cmd, NULL);
>
>
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
> > diff --git a/object-file.c b/object-file.c
> > index d3cf4b8b2e..6aaa167942 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -2988,3 +2988,14 @@ int read_loose_object(const char *path,
> >               munmap(map, mapsize);
> >       return ret;
> >  }
> > +
> > +void free_object_info_contents(struct object_info *object_info)
> > +{
> > +     if (!object_info)
> > +             return;
> > +     free(object_info->typep);
> > +     free(object_info->sizep);
> > +     free(object_info->disk_sizep);
> > +     free(object_info->delta_base_oid);
> > +     free(object_info->type_name);
> > +}
> > diff --git a/object-store-ll.h b/object-store-ll.h
> > index c5f2bb2fc2..333e19cd1e 100644
> > --- a/object-store-ll.h
> > +++ b/object-store-ll.h
> > @@ -533,4 +533,7 @@ int for_each_object_in_pack(struct packed_git *p,
> >  int for_each_packed_object(each_packed_object_fn, void *,
> >                          enum for_each_object_flags flags);
> >
> > +/* Free pointers inside of object_info, but not object_info itself */
> > +void free_object_info_contents(struct object_info *object_info);
> > +
> >  #endif /* OBJECT_STORE_LL_H */
> > diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-=
remote-object-info.sh
> > new file mode 100755
> > index 0000000000..7a7bdfeb91
> > --- /dev/null
> > +++ b/t/t1017-cat-file-remote-object-info.sh
> > @@ -0,0 +1,412 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'git cat-file --batch-command with remote-object-in=
fo command'
> > +
> > +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> > +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +
> > +. ./test-lib.sh
> > +
> > +echo_without_newline () {
> > +    printf '%s' "$*"
> > +}
> > +
> > +strlen () {
> > +    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
> > +}
> > +
> > +hello_content=3D"Hello World"
> > +hello_size=3D$(strlen "$hello_content")
> > +hello_oid=3D$(echo_without_newline "$hello_content" | git hash-object =
--stdin)
> > +
> > +tree_size=3D$(($(test_oid rawsz) + 13))
> > +
> > +commit_message=3D"Initial commit"
> > +commit_size=3D$(($(test_oid hexsz) + 137))
> >
>
> Why 13 and 137?
>

Thank you. That is tricky. Originally I took them from
t/t1006-cat-file.sh. I did some research though.

13 =3D <file mode> + <a_space> + <file name> + <a_null>, where
file mode is 100644, which is 6 characters;
file name is hello, which is 5 characters
a space is 1 character and a null is 1 character

For commit message, here is the raw content

tree 6241ab2a5314798183b5c4ee8a7b0ccd12c651e6
author A U Thor <author@example.com> 1112354055 +0200
committer C O Mitter <committer@example.com> 1112354055 +0200

Initial commit

137 =3D <tree header> + <a_space> + <a newline> +
  <Author line> + <a newline> +
  <Committer line> + <a newline> +
  <a newline> +
  <commit message length>

An easier way is this by `git cat-file commit <commit hash> | wc -c`,
which gets 177, then it should be minus 40 hex away, and result in 137

I put them in the comments to avoid confusion.

> > +
> > +tag_header_without_oid=3D"type blob
> > +tag hellotag
> > +tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
> > +tag_header_without_timestamp=3D"object $hello_oid
> > +$tag_header_without_oid"
> > +tag_description=3D"This is a tag"
> > +tag_content=3D"$tag_header_without_timestamp 0 +0000
> > +
> > +$tag_description"
> > +
> > +tag_oid=3D$(echo_without_newline "$tag_content" | git hash-object -t t=
ag --stdin -w)
> > +tag_size=3D$(strlen "$tag_content")
> > +
> > +# This section tests --batch-command with remote-object-info command
> > +# Since "%(objecttype)" is currently not supported by the command remo=
te-object-info ,
> > +# the filters are set to "%(objectname) %(objectsize)".
> > +# Tests with the default filter are used to test the fallback to 'fetc=
h' command
> > +
> > +
> > +# Test --batch-command remote-object-info with 'git://' transport
> > +
> > +. "$TEST_DIRECTORY"/lib-git-daemon.sh
> > +start_git_daemon --export-all --enable=3Dreceive-pack
> > +daemon_parent=3D$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
> > +
> > +test_expect_success 'create repo to be served by git-daemon' '
> > +     git init "$daemon_parent" &&
> > +
> > +     echo_without_newline "$hello_content" > $daemon_parent/hello &&
> > +     git -C "$daemon_parent" update-index --add hello &&
> > +     git -C "$daemon_parent" config transfer.advertiseobjectinfo true
> > +'
> > +
> > +set_transport_variables () {
> > +     hello_sha1=3D$(echo_without_newline "$hello_content" | git hash-o=
bject --stdin)
> > +     tree_sha1=3D$(git -C "$1" write-tree)
> > +     commit_sha1=3D$(echo_without_newline "$commit_message" | git -C "=
$1" commit-tree $tree_sha1)
> > +     tag_sha1=3D$(echo_without_newline "$tag_content" | git -C "$1" ha=
sh-object -t tag --stdin -w)
> > +     tag_size=3D$(strlen "$tag_content")
> > +}
> > +
> > +
>
> extra newline here
>

Thank you. Fixed in V2.

> > +test_expect_success 'batch-command remote-object-info git://' '
> > +     (
> > +             set_transport_variables "$daemon_parent" &&
> > +             cd "$daemon_parent" &&
> > +
> > +             echo "$hello_sha1 $hello_size" >expect &&
> > +             echo "$tree_sha1 $tree_size" >>expect &&
> > +             echo "$commit_sha1 $commit_size" >>expect &&
> > +             echo "$tag_sha1 $tag_size" >>expect &&
> > +             git cat-file --batch-command=3D"%(objectname) %(objectsiz=
e)" >actual <<-EOF &&
> > +             remote-object-info "$GIT_DAEMON_URL/parent" $hello_sha1
> > +             remote-object-info "$GIT_DAEMON_URL/parent" $tree_sha1
> > +             remote-object-info "$GIT_DAEMON_URL/parent" $commit_sha1
> > +             remote-object-info "$GIT_DAEMON_URL/parent" $tag_sha1
> > +             EOF
> > +             test_cmp expect actual
> > +     )
> > +'
> > +
> > +test_expect_success 'batch-command remote-object-info git:// multiple =
sha1 per line' '
> > +     (
> > +             set_transport_variables "$daemon_parent" &&
> > +             cd "$daemon_parent" &&
> > +
> > +             echo "$hello_sha1 $hello_size" >expect &&
> > +             echo "$tree_sha1 $tree_size" >>expect &&
> > +             echo "$commit_sha1 $commit_size" >>expect &&
> > +             echo "$tag_sha1 $tag_size" >>expect &&
> > +             git cat-file --batch-command=3D"%(objectname) %(objectsiz=
e)" >actual <<-EOF &&
> > +             remote-object-info "$GIT_DAEMON_URL/parent" $hello_sha1 $=
tree_sha1 $commit_sha1 $tag_sha1
> > +             EOF
> > +             test_cmp expect actual
> > +     )
> > +'
> > +
> > +test_expect_success 'batch-command remote-object-info http:// default =
filter' '
> > +     (
> > +             set_transport_variables "$daemon_parent" &&
> > +             cd "$daemon_parent" &&
> > +
> > +             echo "$hello_sha1 $hello_size" >expect &&
> > +             echo "$tree_sha1 $tree_size" >>expect &&
> > +             echo "$commit_sha1 $commit_size" >>expect &&
> > +             echo "$tag_sha1 $tag_size" >>expect &&
> > +             GIT_TRACE_PACKET=3D1 git cat-file --batch-command >actual=
 <<-EOF &&
> > +             remote-object-info "$GIT_DAEMON_URL/parent" $hello_sha1 $=
tree_sha1
> > +             remote-object-info "$GIT_DAEMON_URL/parent" $commit_sha1 =
$tag_sha1
> > +             EOF
> > +             test_cmp expect actual
> > +     )
> > +'
> > +
> > +test_expect_success 'batch-command --buffer remote-object-info git://'=
 '
> > +     (
> > +             set_transport_variables "$daemon_parent" &&
> > +             cd "$daemon_parent" &&
> > +
> > +             echo "$hello_sha1 $hello_size" >expect &&
> > +             echo "$tree_sha1 $tree_size" >>expect &&
> > +             echo "$commit_sha1 $commit_size" >>expect &&
> > +             echo "$tag_sha1 $tag_size" >>expect &&
> > +             git cat-file --batch-command=3D"%(objectname) %(objectsiz=
e)" --buffer >actual <<-EOF &&
> > +             remote-object-info "$GIT_DAEMON_URL/parent" $hello_sha1 $=
tree_sha1
> > +             remote-object-info "$GIT_DAEMON_URL/parent" $commit_sha1 =
$tag_sha1
> > +             flush
> > +             EOF
> > +             test_cmp expect actual
> > +     )
> > +'
> > +
> > +stop_git_daemon
> > +
> > +# Test --batch-command remote-object-info with 'http://' transport
> > +
> > +. "$TEST_DIRECTORY"/lib-httpd.sh
> > +start_httpd
> > +
> > +test_expect_success 'create repo to be served by http:// transport' '
> > +     git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> > +     git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config http.receiv=
epack true &&
> > +     git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config transfer.ad=
vertiseobjectinfo true &&
> > +     echo_without_newline "$hello_content" > $HTTPD_DOCUMENT_ROOT_PATH=
/http_parent/hello &&
> > +     git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" update-index --add=
 hello
> > +'
> > +
> > +
> > +test_expect_success 'batch-command remote-object-info http://' '
> > +     (
> > +             set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_p=
arent" &&
> > +             cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> > +
> > +             echo "$hello_sha1 $hello_size" >expect &&
> > +             echo "$tree_sha1 $tree_size" >>expect &&
> > +             echo "$commit_sha1 $commit_size" >>expect &&
> > +             echo "$tag_sha1 $tag_size" >>expect &&
> > +             git cat-file --batch-command=3D"%(objectname) %(objectsiz=
e)" >actual <<-EOF &&
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $hello_=
sha1
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $tree_s=
ha1
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $commit=
_sha1
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $tag_sh=
a1
> > +             EOF
> > +             test_cmp expect actual
> > +     )
> > +'
> > +
> > +test_expect_success 'batch-command remote-object-info http:// one line=
' '
> > +     (
> > +             set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_p=
arent" &&
> > +             cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> > +
> > +             echo "$hello_sha1 $hello_size" >expect &&
> > +             echo "$tree_sha1 $tree_size" >>expect &&
> > +             echo "$commit_sha1 $commit_size" >>expect &&
> > +             echo "$tag_sha1 $tag_size" >>expect &&
> > +             git cat-file --batch-command=3D"%(objectname) %(objectsiz=
e)" >actual <<-EOF &&
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $hello_=
sha1 $tree_sha1 $commit_sha1 $tag_sha1
> > +             EOF
> > +             test_cmp expect actual
> > +     )
> > +'
> > +
> > +test_expect_success 'batch-command --buffer remote-object-info http://=
' '
> > +     (
> > +             set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_p=
arent" &&
> > +             cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> > +
> > +             echo "$hello_sha1 $hello_size" >expect &&
> > +             echo "$tree_sha1 $tree_size" >>expect &&
> > +             echo "$commit_sha1 $commit_size" >>expect &&
> > +             echo "$tag_sha1 $tag_size" >>expect &&
> > +
> > +             git cat-file --batch-command=3D"%(objectname) %(objectsiz=
e)" --buffer >actual <<-EOF &&
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $hello_=
sha1 $tree_sha1
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $commit=
_sha1 $tag_sha1
> > +             flush
> > +             EOF
> > +             test_cmp expect actual
> > +     )
> > +'
> > +
> > +test_expect_success 'batch-command remote-object-info http:// default =
filter' '
> > +     (
> > +             set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_p=
arent" &&
> > +             cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> > +
> > +             echo "$hello_sha1 $hello_size" >expect &&
> > +             echo "$tree_sha1 $tree_size" >>expect &&
> > +             echo "$commit_sha1 $commit_size" >>expect &&
> > +             echo "$tag_sha1 $tag_size" >>expect &&
> > +
> > +             git cat-file --batch-command >actual <<-EOF &&
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $hello_=
sha1 $tree_sha1
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $commit=
_sha1 $tag_sha1
> > +             EOF
> > +             test_cmp expect actual
> > +     )
> > +'
> > +
> > +test_expect_success 'remote-object-info fails on unspported filter opt=
ion (objectsize:disk)' '
> > +     (
> > +             set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_p=
arent" &&
> > +             cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> > +
> > +             test_must_fail git cat-file --batch-command=3D"%(objectsi=
ze:disk)" 2>err <<-EOF &&
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $hello_=
sha1
> > +             EOF
> > +             test_grep "objectsize:disk is currently not supported wit=
h remote-object-info" err
> > +     )
> > +'
> > +
> > +test_expect_success 'remote-object-info fails on unspported filter opt=
ion (deltabase)' '
> > +     (
> > +             set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_p=
arent" &&
> > +             cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> > +
> > +             test_must_fail git cat-file --batch-command=3D"%(deltabas=
e)" 2>err <<-EOF &&
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $hello_=
sha1
> > +             EOF
> > +             test_grep "deltabase is currently not supported with remo=
te-object-info" err
> > +     )
> > +'
> > +
> > +test_expect_success 'remote-object-info fails on server with legacy pr=
otocol' '
> > +     (
> > +             set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_p=
arent" &&
> > +             cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> > +
> > +             test_must_fail git -c protocol.version=3D0 cat-file --bat=
ch-command=3D"%(objectname) %(objectsize)" 2>err <<-EOF &&
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $hello_=
sha1
> > +             EOF
> > +             test_grep "remote-object-info requires protocol v2" err
> > +     )
> > +'
> > +
> > +test_expect_success 'remote-object-info fails on server with legacy pr=
otocol fallback' '
> > +     (
> > +             set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_p=
arent" &&
> > +             cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> > +
> > +             test_must_fail git -c protocol.version=3D0 cat-file --bat=
ch-command 2>err <<-EOF &&
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $hello_=
sha1
> > +             EOF
> > +             test_grep "remote-object-info requires protocol v2" err
> > +     )
> > +'
> > +
> > +test_expect_success 'remote-object-info fails on malformed OID' '
> > +     (
> > +             set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_p=
arent" &&
> > +             cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> > +             malformed_object_id=3D"this_id_is_not_valid" &&
> > +
> > +             test_must_fail git cat-file --batch-command=3D"%(objectna=
me) %(objectsize)" 2>err <<-EOF &&
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $malfor=
med_object_id
> > +             EOF
> > +             test_grep "Not a valid object name '$malformed_object_id'=
" err
> > +     )
> > +'
> > +
> > +test_expect_success 'remote-object-info fails on malformed OID fallbac=
k' '
> > +     (
> > +             set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_p=
arent" &&
> > +             cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> > +             malformed_object_id=3D"this_id_is_not_valid" &&
> > +
> > +             test_must_fail git cat-file --batch-command 2>err <<-EOF =
&&
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $malfor=
med_object_id
> > +             EOF
> > +             test_grep "Not a valid object name '$malformed_object_id'=
" err
> > +     )
> > +'
> > +
> > +test_expect_success 'remote-object-info fails on missing OID' '
> > +     set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &=
&
> > +     git clone "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" missing_oid_rep=
o &&
> > +     test_commit -C missing_oid_repo message1 c.txt &&
> > +     (
> > +             cd missing_oid_repo &&
> > +
> > +             object_id=3D$(git rev-parse message1:c.txt) &&
> > +             test_must_fail git cat-file --batch-command=3D"%(objectna=
me) %(objectsize)" 2>err <<-EOF &&
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $object=
_id
> > +             EOF
> > +             test_grep "object-info: not our ref $object_id" err
> > +     )
> > +'
> > +
> > +# shellcheck disable=3DSC2016
> > +test_expect_success 'remote-object-info fails on missing OID fallback'=
 '
> > +     (
> > +             set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_p=
arent" &&
> > +             cd missing_oid_repo &&
> > +             object_id=3D$(git rev-parse message1:c.txt) &&
> > +             test_must_fail git cat-file --batch-command 2>err <<-EOF =
&&
> > +             remote-object-info "$HTTPD_URL/smart/http_parent" $object=
_id
> > +             EOF
> > +             test_grep "fatal: object-info: not our ref $object_id" er=
r
> > +     )
> > +'
> > +
> > +# Test --batch-command remote-object-info with 'file://' transport
> > +
> > +# shellcheck disable=3DSC2016
> > +test_expect_success 'create repo to be served by file:// transport' '
> > +     git init server &&
> > +     git -C server config protocol.version 2 &&
> > +     git -C server config transfer.advertiseobjectinfo true &&
> > +     echo_without_newline "$hello_content" > server/hello &&
> > +     git -C server update-index --add hello
> > +'
> > +
> > +
> > +test_expect_success 'batch-command remote-object-info file://' '
> > +     (
> > +             set_transport_variables "server" &&
> > +             cd server &&
> > +
> > +             echo "$hello_sha1 $hello_size" >expect &&
> > +             echo "$tree_sha1 $tree_size" >>expect &&
> > +             echo "$commit_sha1 $commit_size" >>expect &&
> > +             echo "$tag_sha1 $tag_size" >>expect &&
> > +             git cat-file --batch-command=3D"%(objectname) %(objectsiz=
e)" >actual <<-EOF &&
> > +             remote-object-info "file://$(pwd)" $hello_sha1
> > +             remote-object-info "file://$(pwd)" $tree_sha1
> > +             remote-object-info "file://$(pwd)" $commit_sha1
> > +             remote-object-info "file://$(pwd)" $tag_sha1
> > +             EOF
> > +             test_cmp expect actual
> > +     )
> > +'
> > +
> > +test_expect_success 'batch-command remote-object-info file:// multiple=
 sha1 per line' '
> > +     (
> > +             set_transport_variables "server" &&
> > +             cd server &&
> > +
> > +             echo "$hello_sha1 $hello_size" >expect &&
> > +             echo "$tree_sha1 $tree_size" >>expect &&
> > +             echo "$commit_sha1 $commit_size" >>expect &&
> > +             echo "$tag_sha1 $tag_size" >>expect &&
> > +             git cat-file --batch-command=3D"%(objectname) %(objectsiz=
e)" >actual <<-EOF &&
> > +             remote-object-info "file://$(pwd)" $hello_sha1 $tree_sha1=
 $commit_sha1 $tag_sha1
> > +             EOF
> > +             test_cmp expect actual
> > +     )
> > +'
> > +
> > +test_expect_success 'batch-command --buffer remote-object-info file://=
' '
> > +     (
> > +             set_transport_variables "server" &&
> > +             cd server &&
> > +
> > +             echo "$hello_sha1 $hello_size" >expect &&
> > +             echo "$tree_sha1 $tree_size" >>expect &&
> > +             echo "$commit_sha1 $commit_size" >>expect &&
> > +             echo "$tag_sha1 $tag_size" >>expect &&
> > +             git cat-file --batch-command=3D"%(objectname) %(objectsiz=
e)" --buffer >actual <<-EOF &&
> > +             remote-object-info "file://$(pwd)" $hello_sha1 $tree_sha1
> > +             remote-object-info "file://$(pwd)" $commit_sha1 $tag_sha1
> > +             flush
> > +             EOF
> > +             test_cmp expect actual
> > +     )
> > +'
> > +
> > +test_expect_success 'batch-command remote-object-info file:// default =
filter' '
> > +     (
> > +             set_transport_variables "server" &&
> > +             cd server &&
> > +
> > +             echo "$hello_sha1 $hello_size" >expect &&
> > +             echo "$tree_sha1 $tree_size" >>expect &&
> > +             echo "$commit_sha1 $commit_size" >>expect &&
> > +             echo "$tag_sha1 $tag_size" >>expect &&
> > +
> > +             git cat-file --batch-command >actual <<-EOF &&
> > +             remote-object-info "file://$(pwd)" $hello_sha1 $tree_sha1
> > +             remote-object-info "file://$(pwd)" $commit_sha1 $tag_sha1
> > +             EOF
> > +             test_cmp expect actual
> > +     )
> > +'
> > +
> > +test_done
>
> Some more tests I'd like to see
> - Testing against the '-Z' option.
> - Testing the fallback to fetch whole object when the server doesn't
> support 'remote-object-info'.
>

Thank you. More tests are added in V2 to cover those scenarios.

> Thanks
