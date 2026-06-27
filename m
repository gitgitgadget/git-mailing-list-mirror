Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726AE2FDC27
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782593530; cv=pass; b=rYo8pLqG0BMWEeyMSlsnxfd94ibTuoWncJVP6DXdEga6ZgqWfXwg8zRhQFH+JNwS+WfxhfzJr+KGlqWCf4zPfJbO27N/65nod8ECNlbKKHTT+GcurJyBzMG1FIIRr/6ICM4Q4lKURqSrLfXmLoQicPTYzVd6pR5/Acqh8EtaCuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782593530; c=relaxed/simple;
	bh=+fzdLT970I/AN6ZYEqWDlaBYAxwz7gnl12HvVohu9NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pA6LqRUz3b5T3rwkrrfKMhz3TDuutMmu+mG2vFsUbKTaoVoH4WBfgSH/sunL7oRfROy8Z9pAeMHdvlS8QKF/yVTGZ2F4AlJDC67bIgNzYP+n7/eEFenS2SCaTQOqn8Vo4CPRIk/48siXE9kw7gS7tTyHENusRtyY3DULMmrIa/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR5OSrHK; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR5OSrHK"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80e24970f1dso1196467b3.0
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 13:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782593524; cv=none;
        d=google.com; s=arc-20260327;
        b=i7iFKDlgDvvm4tcUdgSTJiecqKUgw23XFa3kccEzIgY12q6Zf3MxCuY+oXiSQRFVKR
         33Ryy//9AWAYd9WbmSk1BnOhEtxv8kBQUaSAR0b+oV/kq810s6MHteKt6A8P29aNSFti
         ztuivuID9ZhIN+Ei77aqUGWJLYMmE0ZHeuny/ZOog/TQkbzM/KNbUDL/Y/JFebxr2clf
         gQ2CIWSXtWp9ViQVHC+jRpawO2Br8UkgdMvsNGnddrIjStnBotv+BoFcyZMpogVQn+0n
         rxUANexzU7yVC+ZW6EM5s0TQgMpCVoTQHsTZuIEcFUdIhPVqYd+gpZZ6adC8NgdqPSvs
         3lrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FkPzuFbucFNCCalBSH/XlGR9y++mjwZsRe65qIH8vtw=;
        fh=II1xNaWpsbGGoje1lWhXs73nMC4GzAl4tRfC7+O7yrw=;
        b=WXIfRPt9MF3/mc5quwhaMxq4bpjOslgjpBgSIZjY15JUNNhsi9cdj4WPouO/DBIjJy
         +WfPLQRtRqhHTfGKNfaPMnqAE49XElP7VZMAvIkknDpYWVHVAFHJJQo/X3ZfhFz+Ns0D
         F1CATLimlyrbPlcTGIVILJvmniYk5G2NLRc14vZI2RX/5T5Wf16ZTIk1oiPKkdM655QF
         PM/p9do0G+esltR6LVGAXRmSbGqXGC29Swo8NdbBfmkodkdk+BuSRv4UPCc0QigALYqr
         ldjWbyRGkEyfr43msdYGAuPzFIWiK5e0XxBDNsnj7b+smEbIMSNHDh+LzpZTQ/AVuvRj
         j1TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782593524; x=1783198324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkPzuFbucFNCCalBSH/XlGR9y++mjwZsRe65qIH8vtw=;
        b=FR5OSrHKLKLTRphhvaqdcLq+9mVf+Ar4MfAg/S4X24fcvzT4VuaUnfRUaGwbHbkzpQ
         wFJjXvigfDU5eZgDPB3Dn0t0nZPfrpbDVLsovvEefzcNYkHUIfpx2jF4YCNmBRPPeW0Y
         Hm0ed5coTNjJKVjdNy5sx8URA7S3Lkvr9RjbjsGooY6kGyLHnQyY3IubZXa1P+nX+aaI
         d5xRwiTioAFaPXwlOHfLWOzsq+VVVq5868SsC2yLq4A7az4nJ+vSXluQROi3lsCce2kG
         sLX2tjkq4AJ59VMk71Ics42wgdhq6AGLxwWUnbv3ZaB0C9WxcjBem95Vjvwv1By+i3QA
         ydxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782593524; x=1783198324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FkPzuFbucFNCCalBSH/XlGR9y++mjwZsRe65qIH8vtw=;
        b=V/naLyh7fwmxKQnPPAbjyhCZFUtXCzDS0njF4Nak5bHbFbrp+AqJYjgTJU08UbTlcV
         DRicKw0TsMoVCPXaOoCLShl+vt9z8zLNk7zjQW16Ivkz1NHFrIxHprMMT+/sWDcujdpn
         u4qYzkA5l/wSvHsGx6BErpB1MbiqJK3kx1tdqhzmTmRiMQqQNLA4Sd2Kq7YthJvVNF1U
         rWzbswpOdu4MQ5VadCGH+6F+0wFV71I4r2VX821PBJ7zo06bSts9/GHMT9VBh1ZZrexQ
         PacutwfWIdCffpbCElK7e8jMbZ8/i7J7ZihcQs6XdBhR04Fo1ixWd/vun5OeLQ9GnsiV
         53tg==
X-Gm-Message-State: AOJu0YyhE0S6EJltiH56syTo/cQKVAD5M3CHSxPvtRHrO0gBiZJswOIR
	fwD6aWsFHpv9J40OoKjVYa8hm4CXx0b8wjcV6SXJDzehSye/ZGtyfx1P2GML6dIcUQkDVKwh+W5
	s5MozznKss8YAZ3IGjXrl4iCqAcES1Po=
X-Gm-Gg: AfdE7cl+OpEPApGVY+M6qNf8qC2bmUAZqfwZMBcbaUkaPh74O1o2sP7j3rj7XX9oIzf
	3f7niZ9EOfvbYnTmDRNe/A+VSmie97ldOIB0yyZmKcP/iFNDFJOF9M6UCNQlTYvpzzmAc3nHw00
	M2sFAr4ANvYbiCLnUEPaHK94jz0gH9ZttwqC0iZ3urygRc4ZfyT/C/jCamilbJrfIiLIWfYhi26
	1X7X2Th0Nam40AHrD8+6VTjMDpz8sR8EUlRq9GNFbnwS8MLcJmFPBBBlP8Pcq0nLudLiEvVm9tN
	fNECbpGXhYHFuArQhovKK9w7pfHu6QzxjyjHlZp/EDU7gGO3POIuC6FdXsnL29qjxj0MN/jDi/z
	7t3pBbhh0VdK6lPsvkVDYNAtBQQWx2b8OnLilSdGGz+UKql8qdb1dYodXGPzrLBODSUo6nw==
X-Received: by 2002:a05:690c:7207:b0:80c:85e5:8742 with SMTP id
 00721157ae682-80c85e58a26mr52929207b3.64.1782593524101; Sat, 27 Jun 2026
 13:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260625-ps-eric-work-rebase-v14-11-09f7ffe21a53@gmail.com> <CAOLa=ZSCKbwckV-j+DyUqOkDkfYcW5xSCPza562mq+OJtQc7DA@mail.gmail.com>
In-Reply-To: <CAOLa=ZSCKbwckV-j+DyUqOkDkfYcW5xSCPza562mq+OJtQc7DA@mail.gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 27 Jun 2026 22:51:51 +0200
X-Gm-Features: AVVi8Cd7shkxdWj1ew-jHQqiVlCkqnuIjG22ED69mDMWw521ozMGWKW3wzGKxEg
Message-ID: <CAN5EUNRCOHu1M1OujRzhjdt1Oc=nyNSh2t0HrzECV+MO2kbrDA@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 11/13] cat-file: add remote-object-info to batch-command
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com, Jonathan Tan <jonathantanmy@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El s=C3=A1b, 27 jun 2026 a las 15:14, Karthik Nayak
(<karthik.188@gmail.com>) escribi=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> [snip]
>
> > diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-fi=
le.adoc
> > index 86b9181599..aba20eb770 100644
> > --- a/Documentation/git-cat-file.adoc
> > +++ b/Documentation/git-cat-file.adoc
> > @@ -169,6 +169,13 @@ info <object>::
> >       Print object info for object reference `<object>`. This correspon=
ds to the
> >       output of `--batch-check`.
> >
> > +remote-object-info <remote> <object>...::
> > +     Print object info for object references `<object>` at specified
> > +     `<remote>` without downloading objects from the remote.
> > +     Raise an error when the `object-info` capability is not supported=
 by the remote.
> > +     Raise an error when no object references are provided.
> > +     This command may be combined with `--buffer`.
> > +
> >  flush::
> >       Used with `--buffer` to execute all preceding commands that were =
issued
> >       since the beginning or since the last flush was issued. When `--b=
uffer`
> > @@ -312,7 +319,8 @@ newline. The available atoms are:
> >       The full hex representation of the object name.
> >
> >  `objecttype`::
> > -     The type of the object (the same as `cat-file -t` reports).
> > +     The type of the object (the same as `cat-file -t` reports). See
> > +     `CAVEATS` below. Not supported by `remote-object-info`.
> >
>
> Do we have to keep adding 'Not supported by `remote-object-info`' to
> each type? Can't we do the inverse and only add 'Supported by
> `remote-object-info`' to `objectsize`. This avoid having to add this
> line to every new type.

Yes, I will do that.

>
> >  If no format is specified, the default format is `%(objectname)
> > -%(objecttype) %(objectsize)`.
> > +%(objecttype) %(objectsize)`, except for `remote-object-info` commands=
 which use
> > +`%(objectname) %(objectsize)` for now because "%(objecttype)" is not s=
upported yet.
>
> Nit: I would drop the 'for now' here, since we don't know when the change=
s
> for 'objecttype' will land.

Okay, I'll drop it.

>
> [snip]
>
> >  enum batch_mode {
> >       BATCH_MODE_CONTENTS,
> > @@ -633,6 +649,81 @@ static void batch_one_object(const char *obj_name,
> >       object_context_release(&ctx);
> >  }
> >
> > +static int get_remote_info(struct batch_options *opt,
> > +                        int argc,
> > +                        const char **argv,
> > +                        struct object_info **remote_object_info,
> > +                        struct oid_array *object_info_oids)
> > +{
> > +     int retval =3D 0;
> > +     struct remote *remote =3D NULL;
> > +     struct object_id oid;
> > +     struct string_list object_info_options =3D STRING_LIST_INIT_NODUP=
;
> > +     struct transport *gtransport;
> > +
> > +     /*
> > +      * Change the format to "%(objectname) %(objectsize)" when
>
> Nit: perhaps prepend a "TODO"

I'll add it.

>
> > +      * remote-object-info command is used. Once we start supporting o=
bjecttype
> > +      * the default format should change to DEFAULT_FORMAT.
> > +      */
> > +     if (!opt->format)
> > +             opt->format =3D "%(objectname) %(objectsize)";
> > +
> > +     remote =3D remote_get(argv[0]);
> > +     if (!remote)
> > +             die(_("must supply valid remote when using remote-object-=
info"));
> > +
> > +     oid_array_clear(object_info_oids);
> > +     for (size_t i =3D 1; i < argc; i++) {
> > +             if (get_oid_hex(argv[i], &oid)) {
> > +                     size_t len =3D strlen(argv[i]);
> > +
> > +                     if (len < the_hash_algo->hexsz && len >=3D 4) {
> > +                             size_t j;
> > +                             for (j =3D 0; j < len; j++)
> > +                                     if (!isxdigit(argv[i][j]))
> > +                                             break;
> > +                             if (j =3D=3D len)
> > +                                     die(_("remote-object-info does no=
t support "
> > +                                           "short oids, %d characters =
required"),
> > +                                         (int)the_hash_algo->hexsz);
> > +                     }
> > +                     die(_("not a valid object name '%s'"), argv[i]);
> > +             }
> > +             oid_array_append(object_info_oids, &oid);
> > +     }
> > +
> > +     if (!object_info_oids->nr)
> > +             die(_("remote-object-info requires objects"));
> > +
> > +     gtransport =3D transport_get(remote, NULL);
> > +
> > +     if (!gtransport->smart_options) {
> > +             retval =3D -1;
> > +             goto cleanup;
> > +     }
> > +
> > +     CALLOC_ARRAY(*remote_object_info, object_info_oids->nr);
> > +     gtransport->smart_options->object_info =3D 1;
> > +     gtransport->smart_options->object_info_oids =3D object_info_oids;
> > +
> > +     /* 'objectsize' is the only option currently supported */
> > +     if (!strstr(opt->format, "%(objectsize)"))
> > +             die(_("%s is currently not supported with remote-object-i=
nfo"), opt->format);
> > +
>
> Aren't we setting the opt->format ourselves in this function? Why do we
> need to check it?

We only set `opt->format` when the user does not provide a custom format.

The `strstr` check catches cases like `%(objecttype)` alone, but is
not sufficient for mixed formats like `%(objecttype) %(objectsize)`.
This is fixed in [12/13] with the allow-list.
>
> > +     string_list_append(&object_info_options, "size");
> > +
> > +     if (object_info_options.nr > 0) {
> > +             gtransport->smart_options->object_info_options =3D &objec=
t_info_options;
> > +             gtransport->smart_options->object_info_data =3D *remote_o=
bject_info;
> > +             retval =3D transport_fetch_refs(gtransport, NULL);
> > +     }
> > +cleanup:
> > +     string_list_clear(&object_info_options, 0);
> > +     transport_disconnect(gtransport);
> > +     return retval;
> > +}
> > +
> >  struct object_cb_data {
> >       struct batch_options *opt;
> >       struct expand_data *expand;
> > @@ -714,6 +805,57 @@ static void parse_cmd_mailmap(struct batch_options=
 *opt UNUSED,
> >               load_mailmap();
> >  }
> >
> > +static void parse_cmd_remote_object_info(struct batch_options *opt,
> > +                                      const char *line, struct strbuf =
*output,
> > +                                      struct expand_data *data)
> > +{
> > +     int count;
> > +     const char **argv;
> > +     char *line_to_split;
> > +     struct object_info *remote_object_info =3D NULL;
> > +     struct oid_array object_info_oids =3D OID_ARRAY_INIT;
> > +
> > +     if (strlen(line) >=3D MAX_REMOTE_OBJ_INFO_LINE)
> > +             die(_("remote-object-info command too long"));
> > +
> > +     line_to_split =3D xstrdup(line);
> > +     count =3D split_cmdline(line_to_split, &argv);
> > +     if (count < 0)
> > +             die(_("split remote-object-info command"));
>
> We should  be using `split_cmdline_strerror()` here

Ok, I'll use it.

>
> > +     if (count - 1 > MAX_ALLOWED_OBJ_LIMIT)
> > +             die(_("remote-object-info supports at most %d objects"),
> > +                 MAX_ALLOWED_OBJ_LIMIT);
> > +
> > +     if (get_remote_info(opt, count, argv, &remote_object_info,
> > +                         &object_info_oids))
> > +             goto cleanup;
> > +
> > +     data->skip_object_info =3D 1;
> > +     for (size_t i =3D 0; i < object_info_oids.nr; i++) {
> > +             data->oid =3D object_info_oids.oid[i];
> > +             if (remote_object_info[i].sizep) {
> > +                     /*
> > +                      * When reaching here, it means remote-object-inf=
o can retrieve
> > +                      * information from server without downloading th=
em.
> > +                      */
> > +                     data->size =3D *remote_object_info[i].sizep;
> > +                     opt->batch_mode =3D BATCH_MODE_INFO;
> > +                     batch_object_write(argv[i + 1], output, opt, data=
, NULL, 0);
> > +             } else {
> > +                     report_object_status(opt, oid_to_hex(&data->oid),=
 &data->oid, "missing");
> > +             }
> > +     }
> > +     data->skip_object_info =3D 0;
> > +
> > +cleanup:
> > +     for (size_t i =3D 0; i < object_info_oids.nr; i++)
> > +             free_object_info_contents(&remote_object_info[i]);
> > +     free(line_to_split);
> > +     free(argv);
> > +     free(remote_object_info);
> > +     oid_array_clear(&object_info_oids);
> > +}
> > +
>
> [snip]
>
> > diff --git a/t/meson.build b/t/meson.build
> > index 3219264fe7..54d21111a3 100644
> > --- a/t/meson.build
> > +++ b/t/meson.build
> > @@ -170,6 +170,7 @@ integration_tests =3D [
> >    't1014-read-tree-confusing.sh',
> >    't1015-read-index-unmerged.sh',
> >    't1016-compatObjectFormat.sh',
> > +  't1017-cat-file-remote-object-info.sh',
> >    't1020-subdirectory.sh',
> >    't1022-read-tree-partial-clone.sh',
> >    't1050-large.sh',
>
> [snip]

Thanks for the feedback,
Pablo.
