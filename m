Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135EC8E1
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 02:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721097565; cv=none; b=i4PM5ISK/PY+SjVCMjy1tZIsw0HOgZb2ArOvP2g7FcG0TlehJubsvPMry1nLaYSCuH1ARGmwrV4gBVeOq+ns9vKauKFjJ2Wv4uxwRjc93URxcdhcz0FPmdWsWeKQ86Y6X76XK59IAXCaX5Yf8mjiF+zIyigrpb5wZJBfbVxcTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721097565; c=relaxed/simple;
	bh=XMGi/IHArtGzcnj+ulLAc7Sx/lB5dluq22xFWBdokC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcNbS/e7vVdYkWd8gc+qbHLPtbEEAtzbkf3lP5CLaDZ+rGFOpPKLLnh+eo3xPnmR8/NhhMl0drSfQLy7flQD+TcP81rDrS0RtLyW9t7N77O/9AHuA225EOxYdMP2T3FvYtROVzjzJTOnqDts7LDbJ73NVteHzx031iDeSLst7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ygy7irmi; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ygy7irmi"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-65f9e25fffaso26197257b3.3
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 19:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721097562; x=1721702362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ng4SudnzwnF9YQiySocSDF18kzMy6Zz6W2sv+bSJlGU=;
        b=Ygy7irmikxDFC5bdjs5Kp7XZz0wGYFFE+PsdU2g7x5arYA01BTvbBQ5koD/y+XkRcW
         +kLJk7JmRTNAsVkNG6vLEXCtrOWm2D4uKmcwAdgh7Uf+jbuDLWfPY93OA2e6OOQP2sRf
         WJQ7e7+OQw2RKq1qw1gnPxeF9Xl+upPNFc7qiWY1TaNoBuOSzg/d9YgCMIFbCyetyp7E
         IQqP7tRkFZy6BUfOq/pfbdvk/mgFjnjslmQ8I0Omd35THGAhoSt4D5sOKK4RAwOkgEVH
         oeDny+3S+8KcMa95ai+Pxptf7Y+j2yfdp1p6heq82AKXn+MiQColJeaBMbUFTGVMYzs3
         D2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721097562; x=1721702362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ng4SudnzwnF9YQiySocSDF18kzMy6Zz6W2sv+bSJlGU=;
        b=qo+g6UToYGdui4x/KalVdA0CJoAuzQ2vmM3aErjxwwRav62giirpuBunoayEsZ1PE8
         vus30IERy0hdcrDlHziLd+mflKxVBMG8MFDCFeR4sJgZAC15I1stDRx1MRpdg9h1nUHz
         iTMm6qC7Kzzk1luLI6tHDoenf7GknOV7QT7+hYPVMPzXPxeaDA2m8+tyFyI4fGWSiYlk
         Dz1a/FaA8o0wjsfSZa02Oa/Om9U9dZqjH2SkEe1J7g2Pl4zWxj2dQAFnYhFQqSbIRrRk
         sySziR6nlkJ2k0DsuNQAcPraDgVfahHHBbkPqI/rqehRFoWcOGryGpXY9TgJDbvIBhXr
         PF5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrOLvJxl4eS0ZdLcompNQnQ7mh1Ti6h8vwT7zkkuOBu9k0CdMzvc1q4yxkr7cVR4Sys4jyxW7T2hsGTZEuxFVc3lLH
X-Gm-Message-State: AOJu0YzZx1fcRTeuhYxVM5OaRAbafcy6ji6+/Tp/o4Kms6rZUyjtwbgo
	tcMgad3UYEPn8YuuttCv/RVwIEJYr6adf7FdQD7OmE7+mvDENZBOmxBCSMinkC9FR7Gi8eY08C7
	a+hyweQ2Lm9EUck+R+tgf6hoG9JQ=
X-Google-Smtp-Source: AGHT+IGI+oAV7hT/f+9K6GfxrKpFi2iVa69uWoX6bykjSb0dUjeDK3rbazTeH4I3Z3r/Bf9Lm3T09EHBRb71+sOzoKQ=
X-Received: by 2002:a0d:f905:0:b0:632:e098:a9e0 with SMTP id
 00721157ae682-6637ecef560mr10840997b3.9.1721097561933; Mon, 15 Jul 2024
 19:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240628190503.67389-5-eric.peijian@gmail.com> <CAOLa=ZSLoHe_xii2A_Phx1NzQLPvLwWUoFhJ2bOrihGvhD6rzg@mail.gmail.com>
In-Reply-To: <CAOLa=ZSLoHe_xii2A_Phx1NzQLPvLwWUoFhJ2bOrihGvhD6rzg@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Mon, 15 Jul 2024 22:39:11 -0400
Message-ID: <CAN2LT1B2mzSEvMOaEPKWUJ2BX6G3ZVR8ZpJJGFAYpNnQA1oE8g@mail.gmail.com>
Subject: Re: [PATCH 4/6] transport: add client support for object-info
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 6:13=E2=80=AFAM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Eric Ju <eric.peijian@gmail.com> writes:
>
> > From: Calvin Wan <calvinwan@google.com>
> >
> > Sometimes it is useful to get information about an object without havin=
g
> > to download it completely. The server logic has already been implemente=
d
> > as =E2=80=9Ca2ba162cda (object-info: support for retrieving object info=
,
>
> Nit: s/as/in
>

Thank you. Fixed in V2.

> > 2021-04-20)=E2=80=9D.
> >
> > Add client functions to communicate with the server.
> >
> > The client currently supports requesting a list of object ids with
> > features 'size' and 'type' from a v2 server. If a server does not
>
> But do we support type? I thought we only added support for 'size'.
>

Thank you. Yes, only size is supported, I will revise it.

> > advertise either of the requested features, then the client falls back
> > to making the request through 'fetch'.
> >
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
> > Helped-by: Jonathan Tan <jonathantanmy@google.com>
> > Helped-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
> >  fetch-pack.c       |  24 +++++++++++
> >  fetch-pack.h       |  10 +++++
> >  transport-helper.c |   8 +++-
> >  transport.c        | 102 ++++++++++++++++++++++++++++++++++++++++++---
> >  transport.h        |  11 +++++
> >  5 files changed, 148 insertions(+), 7 deletions(-)
> >
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index da0de9c537..d533cac1d8 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1345,6 +1345,27 @@ static void write_command_and_capabilities(struc=
t strbuf *req_buf,
> >       packet_buf_delim(req_buf);
> >  }
> >
> > +void send_object_info_request(int fd_out, struct object_info_args *arg=
s)
> > +{
> > +     struct strbuf req_buf =3D STRBUF_INIT;
> > +
> > +     write_command_and_capabilities(&req_buf, args->server_options, "o=
bject-info");
> > +
> > +     if (unsorted_string_list_has_string(args->object_info_options, "s=
ize"))
> > +             packet_buf_write(&req_buf, "size");
> > +
> > +     if (args->oids) {
> > +             for (size_t i =3D 0; i < args->oids->nr; i++)
> > +                     packet_buf_write(&req_buf, "oid %s", oid_to_hex(&=
args->oids->oid[i]));
> > +     }
> > +
> > +     packet_buf_flush(&req_buf);
> > +     if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
> > +             die_errno(_("unable to write request to remote"));
> > +
> > +     strbuf_release(&req_buf);
> > +}
> > +
> >  static int send_fetch_request(struct fetch_negotiator *negotiator, int=
 fd_out,
> >                             struct fetch_pack_args *args,
> >                             const struct ref *wants, struct oidset *com=
mon,
> > @@ -1682,6 +1703,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_=
pack_args *args,
> >       if (args->depth > 0 || args->deepen_since || args->deepen_not)
> >               args->deepen =3D 1;
> >
> > +     if (args->object_info)
> > +             state =3D FETCH_SEND_REQUEST;
> > +
> >       while (state !=3D FETCH_DONE) {
> >               switch (state) {
> >               case FETCH_CHECK_LOCAL:
> > diff --git a/fetch-pack.h b/fetch-pack.h
> > index 6775d26517..16e4dc0824 100644
> > --- a/fetch-pack.h
> > +++ b/fetch-pack.h
> > @@ -16,6 +16,7 @@ struct fetch_pack_args {
> >       const struct string_list *deepen_not;
> >       struct list_objects_filter_options filter_options;
> >       const struct string_list *server_options;
> > +     struct object_info **object_info_data;
> >
> >       /*
> >        * If not NULL, during packfile negotiation, fetch-pack will send=
 "have"
> > @@ -42,6 +43,7 @@ struct fetch_pack_args {
> >       unsigned reject_shallow_remote:1;
> >       unsigned deepen:1;
> >       unsigned refetch:1;
> > +     unsigned object_info:1;
> >
> >       /*
> >        * Indicate that the remote of this request is a promisor remote.=
 The
> > @@ -68,6 +70,12 @@ struct fetch_pack_args {
> >       unsigned connectivity_checked:1;
> >  };
> >
> > +struct object_info_args {
> > +     struct string_list *object_info_options;
> > +     const struct string_list *server_options;
> > +     struct oid_array *oids;
> > +};
> > +
> >  /*
> >   * sought represents remote references that should be updated from.
> >   * On return, the names that were found on the remote will have been
> > @@ -101,4 +109,6 @@ void negotiate_using_fetch(const struct oid_array *=
negotiation_tips,
> >   */
> >  int report_unmatched_refs(struct ref **sought, int nr_sought);
> >
> > +void send_object_info_request(int fd_out, struct object_info_args *arg=
s);
> > +
> >  #endif
> > diff --git a/transport-helper.c b/transport-helper.c
> > index 9820947ab2..670d1e7068 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -697,13 +697,17 @@ static int fetch_refs(struct transport *transport=
,
> >
> >       /*
> >        * If we reach here, then the server, the client, and/or the tran=
sport
> > -      * helper does not support protocol v2. --negotiate-only requires
> > -      * protocol v2.
> > +      * helper does not support protocol v2. --negotiate-only and cat-=
file remote-object-info
> > +      * require protocol v2.
> >        */
> >       if (data->transport_options.acked_commits) {
> >               warning(_("--negotiate-only requires protocol v2"));
> >               return -1;
> >       }
> > +     if (transport->smart_options->object_info) {
> > +             // fail the command explicitly to avoid further commands =
input
> > +             die(_("remote-object-info requires protocol v2"));
> > +     }
> >
> >       if (!data->get_refs_list_called)
> >               get_refs_list_using_list(transport, 0);
> > diff --git a/transport.c b/transport.c
> > index 83ddea8fbc..2847aa3f3c 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -363,6 +363,73 @@ static struct ref *handshake(struct transport *tra=
nsport, int for_push,
> >       return refs;
> >  }
> >
> > +static int fetch_object_info(struct transport *transport, struct objec=
t_info **object_info_data)
> > +{
> > +     int size_index =3D -1;
> > +     struct git_transport_data *data =3D transport->data;
> > +     struct object_info_args args;
> > +     struct packet_reader reader;
> > +
> > +     memset(&args, 0, sizeof(args));
>
> Nit: we could `struct object_info_args args =3D { 0 };` above instead.

Thank you. Your suggestion has better readability and maintainability.
I am adopting it in V2.

>
> > +     args.server_options =3D transport->server_options;
> > +     args.object_info_options =3D transport->smart_options->object_inf=
o_options;
> > +     args.oids =3D transport->smart_options->object_info_oids;
> > +
> > +     connect_setup(transport, 0);
> > +     packet_reader_init(&reader, data->fd[0], NULL, 0,
> > +                     PACKET_READ_CHOMP_NEWLINE |
> > +                     PACKET_READ_GENTLE_ON_EOF |
> > +                     PACKET_READ_DIE_ON_ERR_PACKET);
> > +     data->version =3D discover_version(&reader);
> > +
> > +     transport->hash_algo =3D reader.hash_algo;
> > +
> > +     switch (data->version) {
> > +     case protocol_v2:
> > +             if (!server_supports_v2("object-info"))
> > +                     return -1;
> > +             if (unsorted_string_list_has_string(args.object_info_opti=
ons, "size")
> > +                             && !server_supports_feature("object-info"=
, "size", 0)) {
> > +                     return -1;
> > +             }
> > +             send_object_info_request(data->fd[1], &args);
> > +             break;
> > +     case protocol_v1:
> > +     case protocol_v0:
> > +             die(_("wrong protocol version. expected v2"));
> > +     case protocol_unknown_version:
> > +             BUG("unknown protocol version");
> > +     }
> > +
> > +     for (size_t i =3D 0; i < args.object_info_options->nr; i++) {
> > +             if (packet_reader_read(&reader) !=3D PACKET_READ_NORMAL) =
{
> > +                     check_stateless_delimiter(transport->stateless_rp=
c, &reader, "stateless delimiter expected");
> > +                     return -1;
> > +             }
> > +             if (unsorted_string_list_has_string(args.object_info_opti=
ons, reader.line)) {
> > +                     if (!strcmp(reader.line, "size"))
> > +                             size_index =3D i;
> > +                     continue;
> > +             }
> > +             return -1;
> > +     }
> > +
> > +     for (size_t i =3D 0; packet_reader_read(&reader) =3D=3D PACKET_RE=
AD_NORMAL && i < args.oids->nr; i++){
> > +             struct string_list object_info_values =3D STRING_LIST_INI=
T_DUP;
>
> We need to also call `string_list_clear()` at the end of this block.
>
> > +
> > +             string_list_split(&object_info_values, reader.line, ' ', =
-1);
> > +             if (0 <=3D size_index) {
> > +                     if (!strcmp(object_info_values.items[1 + size_ind=
ex].string, ""))
> > +                             die("object-info: not our ref %s",
> > +                                     object_info_values.items[0].strin=
g);
> > +                     *(*object_info_data)[i].sizep =3D strtoul(object_=
info_values.items[1 + size_index].string, NULL, 10);
>
> Perhaps `*object_info_data[i]->sizep =3D
> strtoul(object_info_values.items[1 + size_index].string, NULL, 10);`?
>
> So, this is allocated in 'cat-file' and set here? Wouldn't it be nicer
> to also do the alloc here?
>



  > > Perhaps `*object_info_data[i]->sizep =3D
  > > strtoul(object_info_values.items[1 + size_index].string, NULL, 10);`?

Thank you.

Seems that `*(*object_info_data)[i].sizep`  and
`object_info_data[i]->sizep` are not the same.

Given object_info_data is a pointer to a pointer to struct
object_info,  what `*(*object_info_data)[i].sizep` does is

1. *object_info_data dereferences object_info_data, yielding a pointer
to the first element of the array of struct object_info.
2. (*object_info_data)[i] accesses the i-th element in the array of
struct object_info that *object_info_data points to.
4, (*object_info_data)[i].sizep accesses the sizep member of the i-th
struct object_info.
5. *(*object_info_data)[i].sizep dereferences the sizep pointer,
yielding the value it points to.

So we are interested in the array of struct object_info with its first
element at *object_info_data. A more intuitive way of thinking it is
that if we think object_info_data as a 2-D array,
*(*object_info_data)[i] is accessing the  object_info_data[0][i].

For `*object_info_data[i]->sizep`:

1. object_info_data[i] accesses the i-th element in the array of
pointers to struct object_info.
2. object_info_data[i]->sizep accesses the sizep member of the i-th
struct object_info that object_info_data[i] points to.
3. *object_info_data[i]->sizep dereferences the sizep pointer,
yielding the value it points to.

*object_info_data[i]->sizep will treat object_info_data as an array of
pointers. In the mental model of 2D array, *object_info_data[i] is
like object_info_data[i][0]

Nevertheless, I do think using a pointer to a pointer is tricky and
error-prone. In V2, I am refactoring the code to use just a pointer
instead of a pointer to a pointer.  For example, in transport.h

    git_transport_options {
        ...
        struct object_info *object_info_data;
        ...
    }


  > > So, this is allocated in 'cat-file' and set here? Wouldn't it be nice=
r
  > > to also do the alloc here?

Thank you.
Yes, this makes sense, V2 is refactoring the allocation into
`fetch_object_info()` in transport.c

> > +             }
> > +     }
> > +     check_stateless_delimiter(transport->stateless_rpc, &reader, "sta=
teless delimiter expected");
> > +
> > +     return 0;
> > +}
> > +
> >  static struct ref *get_refs_via_connect(struct transport *transport, i=
nt for_push,
> >                                       struct transport_ls_refs_options =
*options)
> >  {
> > @@ -410,6 +477,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
> >       struct ref *refs =3D NULL;
> >       struct fetch_pack_args args;
> >       struct ref *refs_tmp =3D NULL;
> > +     struct ref *object_info_refs =3D xcalloc(1, sizeof (struct ref));
> >
> >       memset(&args, 0, sizeof(args));
> >       args.uploadpack =3D data->options.uploadpack;
> > @@ -436,11 +504,27 @@ static int fetch_refs_via_pack(struct transport *=
transport,
> >       args.server_options =3D transport->server_options;
> >       args.negotiation_tips =3D data->options.negotiation_tips;
> >       args.reject_shallow_remote =3D transport->smart_options->reject_s=
hallow;
> > -
> > -     if (!data->finished_handshake) {
> > -             int i;
> > +     args.object_info =3D transport->smart_options->object_info;
> > +
> > +     if (transport->smart_options && transport->smart_options->object_=
info) {
> > +             struct ref *ref =3D object_info_refs;
> > +
> > +             if (!fetch_object_info(transport, data->options.object_in=
fo_data))
> > +                     goto cleanup;
> > +             args.object_info_data =3D data->options.object_info_data;
> > +             args.quiet =3D 1;
> > +             args.no_progress =3D 1;
> > +             for (size_t i =3D 0; i < transport->smart_options->object=
_info_oids->nr; i++) {
> > +                     struct ref *temp_ref =3D xcalloc(1, sizeof (struc=
t ref));
> > +                     temp_ref->old_oid =3D *(transport->smart_options-=
>object_info_oids->oid + i);
> > +                     temp_ref->exact_oid =3D 1;
> > +                     ref->next =3D temp_ref;
> > +                     ref =3D ref->next;
> > +             }
> > +             transport->remote_refs =3D object_info_refs->next;
> > +     } else if (!data->finished_handshake) {
> >               int must_list_refs =3D 0;
> > -             for (i =3D 0; i < nr_heads; i++) {
> > +             for (int i =3D 0; i < nr_heads; i++) {
> >                       if (!to_fetch[i]->exact_oid) {
> >                               must_list_refs =3D 1;
> >                               break;
> > @@ -478,11 +562,18 @@ static int fetch_refs_via_pack(struct transport *=
transport,
> >                         &transport->pack_lockfiles, data->version);
> >
> >       data->finished_handshake =3D 0;
> > +     if (args.object_info) {
> > +             struct ref *ref_cpy_reader =3D object_info_refs->next;
> > +             for (int i =3D 0; ref_cpy_reader; i++) {
> > +                     oid_object_info_extended(the_repository, &ref_cpy=
_reader->old_oid, &(*args.object_info_data)[i], OBJECT_INFO_LOOKUP_REPLACE)=
;
> > +                     ref_cpy_reader =3D ref_cpy_reader->next;
> > +             }
> > +     }
> >       data->options.self_contained_and_connected =3D
> >               args.self_contained_and_connected;
> >       data->options.connectivity_checked =3D args.connectivity_checked;
> >
> > -     if (!refs)
> > +     if (!refs && !args.object_info)
> >               ret =3D -1;
> >       if (report_unmatched_refs(to_fetch, nr_heads))
> >               ret =3D -1;
> > @@ -498,6 +589,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
> >       free_refs(refs_tmp);
> >       free_refs(refs);
> >       list_objects_filter_release(&args.filter_options);
> > +     free_refs(object_info_refs);
>
> Shouldn't we loop through `object_info_refs->next` and free all of them ?
>

Thank you. I think free_refs() has the logic to loop through
object_info_refs->next and feel the linked list.


> >       return ret;
> >  }
> >
> > diff --git a/transport.h b/transport.h
> > index 6393cd9823..5a3cda1860 100644
> > --- a/transport.h
> > +++ b/transport.h
> > @@ -5,6 +5,7 @@
> >  #include "remote.h"
> >  #include "list-objects-filter-options.h"
> >  #include "string-list.h"
> > +#include "object-store.h"
> >
> >  struct git_transport_options {
> >       unsigned thin : 1;
> > @@ -30,6 +31,12 @@ struct git_transport_options {
> >        */
> >       unsigned connectivity_checked:1;
> >
> > +     /*
> > +      * Transport will attempt to pull only object-info. Fallbacks
> > +      * to pulling entire object if object-info is not supported.
> > +      */
> > +     unsigned object_info : 1;
> > +
> >       int depth;
> >       const char *deepen_since;
> >       const struct string_list *deepen_not;
> > @@ -53,6 +60,10 @@ struct git_transport_options {
> >        * common commits to this oidset instead of fetching any packfile=
s.
> >        */
> >       struct oidset *acked_commits;
> > +
> > +     struct oid_array *object_info_oids;
> > +     struct object_info **object_info_data;
> > +     struct string_list *object_info_options;
> >  };
> >
> >  enum transport_family {
> > --
> > 2.45.2
>
> I wondering if we can add tests at this stage.

Thank you. V2 is adding more tests to cover this.
