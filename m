Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F9C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 22:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345379AbiBJW6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:58:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345378AbiBJW6x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 17:58:53 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612B6115D
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 14:58:53 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id v17-20020a4ac911000000b002eac41bb3f4so8199002ooq.10
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 14:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XoG+7ANQoPOTShFE3GUHfb7WN2gadFDCKKws9kFd0Hs=;
        b=jr8CGI7yVEtOTvf0dRgwbOwAzyMfFNTFmjHh55DtKgxtsxlPxP+w7tVCf+NJpVyrq8
         q++bIBYJ19KzfvJCQ048/jlBIYd5E1OMtbTzJGPHQzU3wIGXwDIeeShgg2u4zX7ntsKW
         yU6ceua87WrHK89hEKSkTUE93QwdWGPiWVxjRbZ4N2QAxlqowXA96co1UXMOk5ideOFS
         AA5J+Pe0U1ohj5HbaMA4BMySV4a5vnYLdKT+y6ytpq24W9kmrhx0gYRCgSj/wbuW/Ufr
         nEedWbSZpTdsSjJB5yYG3LhCc8hKNWsSYo0UeJnW8wyn2EDYVvrRAo+Bi9tXrvpnEvYO
         kFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=XoG+7ANQoPOTShFE3GUHfb7WN2gadFDCKKws9kFd0Hs=;
        b=oFSq5dIoyoCELDqBE2MQD4STqfZRaEmF0IyVXc+bXPyW3/buoZ+n4BYAra8UmwNws4
         U1Z+4psT6jV1t9vmH/XRFlPlH3gWQyL2s/Y4LqInw78OgCGDVtICTWzVWsZ7Vw8nPnQS
         fuzqFQEy/WaWIKRxUfkru3RrEezJfYmdyI7yez45gC98pQN5tcyA7gn5dbgso1cKaGwN
         E52wvpMufvzKRLkU7rJdSrvXYpgkela2GizAjqpbP2Ve3EME/c4FdMMqmvGFRjuNVZyQ
         3Jcbknq6m2Dw2gCSvnxN9aekyG/G8/nkU3BCkWpYhaZpbSWOMuhy/2+5qPtzqFNY/30X
         hQwA==
X-Gm-Message-State: AOAM531wb9ZCgEQ/sbu5VjdqTMKcrWCSnZSBx5fXETFrWqjSMB+urfTx
        8tTkoJTGR/qX4CFlI8EPVCq0AI4bKxBphJdtm5da0Q==
X-Google-Smtp-Source: ABdhPJy/NDlFL6AjcAoM01S8CbKE4CIlHqExeuxtHada0iKKqQ9/LSRpYElC2j1kEeAKm8oPc6aCffPIQGDcCemvGPg=
X-Received: by 2002:a05:6870:c690:: with SMTP id cv16mr284118oab.118.1644533930961;
 Thu, 10 Feb 2022 14:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20220208235631.732466-1-calvinwan@google.com> <20220209204153.481122-1-jonathantanmy@google.com>
In-Reply-To: <20220209204153.481122-1-jonathantanmy@google.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 10 Feb 2022 14:58:40 -0800
Message-ID: <CAFySSZAyyEOLMXhJNMmJTV1AJRdnc9AER1n20PhYaLZs1BZPdg@mail.gmail.com>
Subject: Re: [PATCH v2] fetch object-info-format: client option for object-info
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If you generally agree with my review comments
Everything you've said makes sense. Thanks for taking an in depth look
at this! I'll make the changes you suggested and then start working on
the next steps.

On Wed, Feb 9, 2022 at 12:42 PM Jonathan Tan <jonathantanmy@google.com> wro=
te:
>
> Calvin Wan <calvinwan@google.com> writes:
> > Add =E2=80=98=E2=80=94object-info-format=E2=80=99 option to fetch. This=
 option allows
> > the client to make an object-info [1] command request to a server
> > that supports protocol v2.
>
> Avoid using characters above 127 in commit messages (unless, say, as part=
 of
> someone's name). They make it hard to search for, and in this case, whate=
ver
> dash is there is wrong (it should be "--").
>
> > The transport implementation uses vtables [2], similar to how Git
> > fetches refs,
>
> You should be explicit that you're adding a new function to the vtable.
> (Whether that is what we should do is another issue: let me look at the
> patch to see.)
>
> > to determine whether a process needs to be taken over
> > before sending the object-info request.
>
> The vtable is not to determine whether a process needs to be taken over,
> but so that we support multiple protocols (HTTP, SSH, etc.). In any
> case, this detail is probably not relevant.
>
> > Different protocols
> > require different setups for making requests.
>
> This is true, but I don't see the relevance.
>
> > [1] https://lore.kernel.org/git/20210420233830.2181153-1-bga@google.com=
/
> > [2] https://lore.kernel.org/git/26f276956001a120cc9105b0071762c2fd4a45c=
5.15=3D
> > 13287544.git.jonathantanmy@google.com/
>
> For merged code, quote the commit, not the email.
>
> > @@ -220,6 +225,8 @@ static struct option builtin_fetch_options[] =3D {
> >                N_("write the commit-graph after fetching")),
> >       OPT_BOOL(0, "stdin", &stdin_refspecs,
> >                N_("accept refspecs from stdin")),
> > +     OPT_STRING_LIST(0, "object-info-format", &object_info_format, N_(=
"option"),
> > +              N_("command request arguments")),
>
> I would have expected a parameter named "format" to take a format
> string, but taking a string list of the fields we need might work too.
> In any case, maybe rename it to "--object-info" or similar.
>
> > @@ -2000,6 +2007,8 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
> >       struct remote *remote =3D NULL;
> >       int result =3D 0;
> >       int prune_tags_ok =3D 1;
> > +     struct oid_array oids =3D OID_ARRAY_INIT;
> > +     struct object_id oid;
>
> The "oids" at function level needs a more descriptive name (e.g.
> "oids_for_object_info"). The name of "oid" is fine, since it's just used
> as a temporary variable, but since it is temporary, it should be
> declared in the block where it's used. (Same for "oids", actually:
> declare it in the block it's used, and in that case you can keep the
> name since it's more tightly scoped.)
>
> > @@ -2057,6 +2066,23 @@ int cmd_fetch(int argc, const char **argv, const=
 char *prefix)
> >       if (dry_run)
> >               write_fetch_head =3D 0;
> >
> > +     if (object_info_format.nr > 0) {
> > +             if (argc =3D=3D 0 || argc =3D=3D 1) {
> > +                     die(_("must supply remote and object ids when usi=
ng --object-info-format"));
> > +             } else {
> > +                     remote =3D remote_get(argv[0]);
> > +                     for (i =3D 1; i < argc; i++) {
> > +                             if (get_oid(argv[i], &oid))
> > +                                     return error(_("malformed object =
name '%s'"), argv[i]);
> > +                             oid_array_append(&oids, &oid);
> > +                     }
> > +             }
> > +             gtransport =3D prepare_transport(remote, 0);
> > +             gtransport->server_options =3D &object_info_format;
> > +             result =3D transport_fetch_object_info(gtransport, &oids)=
;
> > +             return result;
> > +     }
>
> I was thinking that this should reuse the refspec parsing mechanism
> (which also supports stdin), but upon more thought, using the refspec
> parser means that we would also need to check that all refspecs are
> exact OIDs (because we wouldn't know what to do with them otherwise).
> OK, parsing the objects by ourselves looks reasonable.
>
> The assignment of object_info_format to server_options is probably not a
> good idea, though, since readers of server_options would expect server
> options, not what you're assigning. The best place to put this
> information is in smart_options. (See the negotiate_only code.)
>
> > +static void write_object_info_command_and_capabilities(struct strbuf *=
req_buf,
> > +                                              const struct string_list=
 *server_options)
> > +{
>
> [snip contents]
>
> This code is very similar to code in fetch-pack.c. If you stick to
> crafting the request in builtin/fetch.c, you should refactor
> fetch-pack.{c,h} to expose this functionality (in a preparatory commit)
> and then use that function from here.
>
> > +void send_object_info_request(int fd_out, struct object_info_args *arg=
s)
> > +{
> > +     struct strbuf req_buf =3D STRBUF_INIT;
> > +     int i;
> > +
> > +     write_object_info_command_and_capabilities(&req_buf, args->server=
_options);
> > +
> > +     if (string_list_has_string(args->server_options, "size"))
> > +             packet_buf_write(&req_buf, "size");
>
> What happens if "size" is not in the list?
>
> > +             printf "%s %d\n" "$object_id" "$length" >expect &&
>
> You can just write "echo $object_id $length >expect". Also, test the
> following:
>  - more than one OID
>  - an OID that's not on the remote
>  - a malformed OID
>  - a server that doesn't support protocol v2
>  - a server that supports protocol v2 but not object-format
>
> (You don't have to do this for all protocols; just pick one. I prefer
> HTTP, since that's the most complex.)
>
> Other than that, the tests look good. Thanks for testing the different
> protocols.
>
> > @@ -1269,6 +1280,7 @@ static struct transport_vtable vtable =3D {
> >       .get_refs_list  =3D get_refs_list,
> >       .fetch_refs     =3D fetch_refs,
> >       .push_refs      =3D push_refs,
> > +     .fetch_object_info =3D fetch_object_info,
> >       .connect        =3D connect_helper,
> >       .disconnect     =3D release_helper
> >  };
>
> Adding a function to the transport vtable is not so disruptive since we
> don't have many transport vtables, but better if we can avoid this
> disruption. In this case, I think it's better to reuse fetch_refs.
> Mainly, the plumbing from transport_fetch_refs() to all the helper
> functions in fetch-pack.c already exists, so reusing fetch_refs would
> allow us to reuse that plumbing.
>
> This also means that we don't have to expose the protocol functionality
> in fetch-pack.c that you copied over to builtin/fetch.c in this patch,
> which is an added bonus.
>
> > +static int fetch_object_info(struct transport *transport, struct oid_a=
rray *oids)
> > +{
>
> [snip contents]
>
> And reusing the plumbing might mean that we don't need this function
> too.
>
> Taking a step back, there also needs to be a fallback mechanism for when
> the server doesn't support object-info.
>
> If you generally agree with my review comments, I would say that your
> next steps are:
>  - investigate if we can reuse the transport_fetch_pack -> fetch-pack.c
>    machinery
>  - make a fallback for when the server doesn't support object-info
>    (might be easier when we use the machinery, so I would start with
>    that first)
