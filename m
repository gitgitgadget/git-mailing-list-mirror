Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B622A18FC7C
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720606438; cv=none; b=pKqhzCzBSD39a0Q0LxPILJDh+IbxJxtJ/K0peZjGs6oZQ1KXmT/9N+/VnAk1PZuxLaFqKUmU61jiZy/ahAiZ1mbRiuai0BSHWonx7GAHN6LvEZW+ReFy0hHGm04LxSXdNZQd1fwNt2M5kUGwAufac90LXv370rWEtV743+UJoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720606438; c=relaxed/simple;
	bh=WIq+hfKD/u7jRDqahoYr2/lQ+saQnt7BvVGyW3Ndo/s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hejDvQQMXEf1zFjXwsmXaa8rR5wvM23Rt3VMhfVnwQxhPj+KW4mDn5w+0XUNF9AsPzz6mGHsr4iPxbymp21LRr959doU4BRmGXhvuQM6hA0BcF4kpNdm7M4sAuWqG0rGxWxtwv2+t0cp4uP311YAcMKuldDzPHZTPiRfLZkUBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TI1V4ujR; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI1V4ujR"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b53bb4bebaso3442298eaf.0
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 03:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720606435; x=1721211235; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8dlps7Vtb/PUPcnT06Lk9lBkCHu5H70FfNz9M6H+AfU=;
        b=TI1V4ujR571djpMPf3GCwFiyd9VthO9M7NWIsFEQQLBmCXccb/rcoa+/Fl+R8/Cr4E
         Kalx6PfKnCM7zvvagKITlAfrDwoCojuYokXPFP74tly4w5eyuUsEIBuY2cMkSge3SY18
         g/8wX1Vn8U4F4HNK26r9ZbUCPTXaZ/v7kzb1FXFZJp6DpxxTjLrLA0/v/RNeIQdlhHGV
         DhYvrDiyfWJcuF39gpA8fCoShH1AK9NHwnfGG82nQZEoaIrJmCx5/V1flHRl7zTbblww
         jN8dGB7O8lk2bI9WfxpAZ0JxojgokvZSIOrR7Nrw50Pi5eOMq6paTwpmqK1V4rbtrMPY
         BosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720606435; x=1721211235;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dlps7Vtb/PUPcnT06Lk9lBkCHu5H70FfNz9M6H+AfU=;
        b=wmNxLsPUFEBDpYAbQPngPEO7evBB/71dklEYyA6Hr1o/0a4fti5HUNHPhSAWvyDvHT
         Qj6qvaFGeYYYmCbHyN+7Zb2ZswxJyjMYsIbnr8+FG6STP8N+Oe4lO67kWo/HvNgRtJcd
         +kz2F/7E4uyRcgT4GcZw+hCtE3ywmPhFs1Juh+uZXiWhMUouGmQ/7WRyQA/olBp0as/s
         BKu+rK8ZHHHpZj7bQIIlaK6y4xW8P4ULfYzX4+xh2CVwWRgTAlO6Yo4BHnuj8rNVab8d
         8g9klXkPM+/Fmjb73e3Xw2n84eiFCPX38bi7UCvjf1zl6njrimlvXSxsmyEPrEk6SogZ
         CBQw==
X-Forwarded-Encrypted: i=1; AJvYcCWzDyPd9oYPzivXS8flA0baBKCK8t4wOO0ldjcPUYgRLWHC9awn9Vt9Dl7dwXA3WnpLq/5HYvcY4DVAjZtJXdxw1Kos
X-Gm-Message-State: AOJu0YxanhPU5PAI54Yyv/TrFSk2WIdK5N0Je6zDkU4agdDK5AcKMt7n
	ru1mFClX1QuT0AsJqY/d16dSsDVcSKctr43beowcC8UKsA6r5PUwMxsGNEQCTB9IY9xAs8CJkAc
	kpYXBVtnoexlLjtKgLjzLBeyk8ag=
X-Google-Smtp-Source: AGHT+IHMgYM9tJrcDZNtJ+aaGGv+COW8OVw8Xci1d0ol66oaEeUoj4+j53Zb5VQKU0N4Xz0JhEMiiLnlFQ6WvmOcO6Y=
X-Received: by 2002:a05:6870:71c7:b0:25e:1532:fa93 with SMTP id
 586e51a60fabf-25eae7ca96dmr3862791fac.15.1720606435406; Wed, 10 Jul 2024
 03:13:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jul 2024 03:13:53 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240628190503.67389-5-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com> <20240628190503.67389-5-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jul 2024 03:13:53 -0700
Message-ID: <CAOLa=ZSLoHe_xii2A_Phx1NzQLPvLwWUoFhJ2bOrihGvhD6rzg@mail.gmail.com>
Subject: Re: [PATCH 4/6] transport: add client support for object-info
To: Eric Ju <eric.peijian@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, John Cai <johncai86@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000619290061ce1e7f2"

--000000000000619290061ce1e7f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Ju <eric.peijian@gmail.com> writes:

> From: Calvin Wan <calvinwan@google.com>
>
> Sometimes it is useful to get information about an object without having
> to download it completely. The server logic has already been implemented
> as =E2=80=9Ca2ba162cda (object-info: support for retrieving object info,

Nit: s/as/in

> 2021-04-20)=E2=80=9D.
>
> Add client functions to communicate with the server.
>
> The client currently supports requesting a list of object ids with
> features 'size' and 'type' from a v2 server. If a server does not

But do we support type? I thought we only added support for 'size'.

> advertise either of the requested features, then the client falls back
> to making the request through 'fetch'.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Helped-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  fetch-pack.c       |  24 +++++++++++
>  fetch-pack.h       |  10 +++++
>  transport-helper.c |   8 +++-
>  transport.c        | 102 ++++++++++++++++++++++++++++++++++++++++++---
>  transport.h        |  11 +++++
>  5 files changed, 148 insertions(+), 7 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index da0de9c537..d533cac1d8 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1345,6 +1345,27 @@ static void write_command_and_capabilities(struct =
strbuf *req_buf,
>  	packet_buf_delim(req_buf);
>  }
>
> +void send_object_info_request(int fd_out, struct object_info_args *args)
> +{
> +	struct strbuf req_buf =3D STRBUF_INIT;
> +
> +	write_command_and_capabilities(&req_buf, args->server_options, "object-=
info");
> +
> +	if (unsorted_string_list_has_string(args->object_info_options, "size"))
> +		packet_buf_write(&req_buf, "size");
> +
> +	if (args->oids) {
> +		for (size_t i =3D 0; i < args->oids->nr; i++)
> +			packet_buf_write(&req_buf, "oid %s", oid_to_hex(&args->oids->oid[i]))=
;
> +	}
> +
> +	packet_buf_flush(&req_buf);
> +	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
> +		die_errno(_("unable to write request to remote"));
> +
> +	strbuf_release(&req_buf);
> +}
> +
>  static int send_fetch_request(struct fetch_negotiator *negotiator, int f=
d_out,
>  			      struct fetch_pack_args *args,
>  			      const struct ref *wants, struct oidset *common,
> @@ -1682,6 +1703,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pa=
ck_args *args,
>  	if (args->depth > 0 || args->deepen_since || args->deepen_not)
>  		args->deepen =3D 1;
>
> +	if (args->object_info)
> +		state =3D FETCH_SEND_REQUEST;
> +
>  	while (state !=3D FETCH_DONE) {
>  		switch (state) {
>  		case FETCH_CHECK_LOCAL:
> diff --git a/fetch-pack.h b/fetch-pack.h
> index 6775d26517..16e4dc0824 100644
> --- a/fetch-pack.h
> +++ b/fetch-pack.h
> @@ -16,6 +16,7 @@ struct fetch_pack_args {
>  	const struct string_list *deepen_not;
>  	struct list_objects_filter_options filter_options;
>  	const struct string_list *server_options;
> +	struct object_info **object_info_data;
>
>  	/*
>  	 * If not NULL, during packfile negotiation, fetch-pack will send "have=
"
> @@ -42,6 +43,7 @@ struct fetch_pack_args {
>  	unsigned reject_shallow_remote:1;
>  	unsigned deepen:1;
>  	unsigned refetch:1;
> +	unsigned object_info:1;
>
>  	/*
>  	 * Indicate that the remote of this request is a promisor remote. The
> @@ -68,6 +70,12 @@ struct fetch_pack_args {
>  	unsigned connectivity_checked:1;
>  };
>
> +struct object_info_args {
> +	struct string_list *object_info_options;
> +	const struct string_list *server_options;
> +	struct oid_array *oids;
> +};
> +
>  /*
>   * sought represents remote references that should be updated from.
>   * On return, the names that were found on the remote will have been
> @@ -101,4 +109,6 @@ void negotiate_using_fetch(const struct oid_array *ne=
gotiation_tips,
>   */
>  int report_unmatched_refs(struct ref **sought, int nr_sought);
>
> +void send_object_info_request(int fd_out, struct object_info_args *args)=
;
> +
>  #endif
> diff --git a/transport-helper.c b/transport-helper.c
> index 9820947ab2..670d1e7068 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -697,13 +697,17 @@ static int fetch_refs(struct transport *transport,
>
>  	/*
>  	 * If we reach here, then the server, the client, and/or the transport
> -	 * helper does not support protocol v2. --negotiate-only requires
> -	 * protocol v2.
> +	 * helper does not support protocol v2. --negotiate-only and cat-file r=
emote-object-info
> +	 * require protocol v2.
>  	 */
>  	if (data->transport_options.acked_commits) {
>  		warning(_("--negotiate-only requires protocol v2"));
>  		return -1;
>  	}
> +	if (transport->smart_options->object_info) {
> +		// fail the command explicitly to avoid further commands input
> +		die(_("remote-object-info requires protocol v2"));
> +	}
>
>  	if (!data->get_refs_list_called)
>  		get_refs_list_using_list(transport, 0);
> diff --git a/transport.c b/transport.c
> index 83ddea8fbc..2847aa3f3c 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -363,6 +363,73 @@ static struct ref *handshake(struct transport *trans=
port, int for_push,
>  	return refs;
>  }
>
> +static int fetch_object_info(struct transport *transport, struct object_=
info **object_info_data)
> +{
> +	int size_index =3D -1;
> +	struct git_transport_data *data =3D transport->data;
> +	struct object_info_args args;
> +	struct packet_reader reader;
> +
> +	memset(&args, 0, sizeof(args));

Nit: we could `struct object_info_args args =3D { 0 };` above instead.

> +	args.server_options =3D transport->server_options;
> +	args.object_info_options =3D transport->smart_options->object_info_opti=
ons;
> +	args.oids =3D transport->smart_options->object_info_oids;
> +
> +	connect_setup(transport, 0);
> +	packet_reader_init(&reader, data->fd[0], NULL, 0,
> +			PACKET_READ_CHOMP_NEWLINE |
> +			PACKET_READ_GENTLE_ON_EOF |
> +			PACKET_READ_DIE_ON_ERR_PACKET);
> +	data->version =3D discover_version(&reader);
> +
> +	transport->hash_algo =3D reader.hash_algo;
> +
> +	switch (data->version) {
> +	case protocol_v2:
> +		if (!server_supports_v2("object-info"))
> +			return -1;
> +		if (unsorted_string_list_has_string(args.object_info_options, "size")
> +				&& !server_supports_feature("object-info", "size", 0)) {
> +			return -1;
> +		}
> +		send_object_info_request(data->fd[1], &args);
> +		break;
> +	case protocol_v1:
> +	case protocol_v0:
> +		die(_("wrong protocol version. expected v2"));
> +	case protocol_unknown_version:
> +		BUG("unknown protocol version");
> +	}
> +
> +	for (size_t i =3D 0; i < args.object_info_options->nr; i++) {
> +		if (packet_reader_read(&reader) !=3D PACKET_READ_NORMAL) {
> +			check_stateless_delimiter(transport->stateless_rpc, &reader, "statele=
ss delimiter expected");
> +			return -1;
> +		}
> +		if (unsorted_string_list_has_string(args.object_info_options, reader.l=
ine)) {
> +			if (!strcmp(reader.line, "size"))
> +				size_index =3D i;
> +			continue;
> +		}
> +		return -1;
> +	}
> +
> +	for (size_t i =3D 0; packet_reader_read(&reader) =3D=3D PACKET_READ_NOR=
MAL && i < args.oids->nr; i++){
> +		struct string_list object_info_values =3D STRING_LIST_INIT_DUP;

We need to also call `string_list_clear()` at the end of this block.

> +
> +		string_list_split(&object_info_values, reader.line, ' ', -1);
> +		if (0 <=3D size_index) {
> +			if (!strcmp(object_info_values.items[1 + size_index].string, ""))
> +				die("object-info: not our ref %s",
> +					object_info_values.items[0].string);
> +			*(*object_info_data)[i].sizep =3D strtoul(object_info_values.items[1 =
+ size_index].string, NULL, 10);

Perhaps `*object_info_data[i]->sizep =3D
strtoul(object_info_values.items[1 + size_index].string, NULL, 10);`?

So, this is allocated in 'cat-file' and set here? Wouldn't it be nicer
to also do the alloc here?

> +		}
> +	}
> +	check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless=
 delimiter expected");
> +
> +	return 0;
> +}
> +
>  static struct ref *get_refs_via_connect(struct transport *transport, int=
 for_push,
>  					struct transport_ls_refs_options *options)
>  {
> @@ -410,6 +477,7 @@ static int fetch_refs_via_pack(struct transport *tran=
sport,
>  	struct ref *refs =3D NULL;
>  	struct fetch_pack_args args;
>  	struct ref *refs_tmp =3D NULL;
> +	struct ref *object_info_refs =3D xcalloc(1, sizeof (struct ref));
>
>  	memset(&args, 0, sizeof(args));
>  	args.uploadpack =3D data->options.uploadpack;
> @@ -436,11 +504,27 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
>  	args.server_options =3D transport->server_options;
>  	args.negotiation_tips =3D data->options.negotiation_tips;
>  	args.reject_shallow_remote =3D transport->smart_options->reject_shallow=
;
> -
> -	if (!data->finished_handshake) {
> -		int i;
> +	args.object_info =3D transport->smart_options->object_info;
> +
> +	if (transport->smart_options && transport->smart_options->object_info) =
{
> +		struct ref *ref =3D object_info_refs;
> +
> +		if (!fetch_object_info(transport, data->options.object_info_data))
> +			goto cleanup;
> +		args.object_info_data =3D data->options.object_info_data;
> +		args.quiet =3D 1;
> +		args.no_progress =3D 1;
> +		for (size_t i =3D 0; i < transport->smart_options->object_info_oids->n=
r; i++) {
> +			struct ref *temp_ref =3D xcalloc(1, sizeof (struct ref));
> +			temp_ref->old_oid =3D *(transport->smart_options->object_info_oids->o=
id + i);
> +			temp_ref->exact_oid =3D 1;
> +			ref->next =3D temp_ref;
> +			ref =3D ref->next;
> +		}
> +		transport->remote_refs =3D object_info_refs->next;
> +	} else if (!data->finished_handshake) {
>  		int must_list_refs =3D 0;
> -		for (i =3D 0; i < nr_heads; i++) {
> +		for (int i =3D 0; i < nr_heads; i++) {
>  			if (!to_fetch[i]->exact_oid) {
>  				must_list_refs =3D 1;
>  				break;
> @@ -478,11 +562,18 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
>  			  &transport->pack_lockfiles, data->version);
>
>  	data->finished_handshake =3D 0;
> +	if (args.object_info) {
> +		struct ref *ref_cpy_reader =3D object_info_refs->next;
> +		for (int i =3D 0; ref_cpy_reader; i++) {
> +			oid_object_info_extended(the_repository, &ref_cpy_reader->old_oid, &(=
*args.object_info_data)[i], OBJECT_INFO_LOOKUP_REPLACE);
> +			ref_cpy_reader =3D ref_cpy_reader->next;
> +		}
> +	}
>  	data->options.self_contained_and_connected =3D
>  		args.self_contained_and_connected;
>  	data->options.connectivity_checked =3D args.connectivity_checked;
>
> -	if (!refs)
> +	if (!refs && !args.object_info)
>  		ret =3D -1;
>  	if (report_unmatched_refs(to_fetch, nr_heads))
>  		ret =3D -1;
> @@ -498,6 +589,7 @@ static int fetch_refs_via_pack(struct transport *tran=
sport,
>  	free_refs(refs_tmp);
>  	free_refs(refs);
>  	list_objects_filter_release(&args.filter_options);
> +	free_refs(object_info_refs);

Shouldn't we loop through `object_info_refs->next` and free all of them ?

>  	return ret;
>  }
>
> diff --git a/transport.h b/transport.h
> index 6393cd9823..5a3cda1860 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -5,6 +5,7 @@
>  #include "remote.h"
>  #include "list-objects-filter-options.h"
>  #include "string-list.h"
> +#include "object-store.h"
>
>  struct git_transport_options {
>  	unsigned thin : 1;
> @@ -30,6 +31,12 @@ struct git_transport_options {
>  	 */
>  	unsigned connectivity_checked:1;
>
> +	/*
> +	 * Transport will attempt to pull only object-info. Fallbacks
> +	 * to pulling entire object if object-info is not supported.
> +	 */
> +	unsigned object_info : 1;
> +
>  	int depth;
>  	const char *deepen_since;
>  	const struct string_list *deepen_not;
> @@ -53,6 +60,10 @@ struct git_transport_options {
>  	 * common commits to this oidset instead of fetching any packfiles.
>  	 */
>  	struct oidset *acked_commits;
> +
> +	struct oid_array *object_info_oids;
> +	struct object_info **object_info_data;
> +	struct string_list *object_info_options;
>  };
>
>  enum transport_family {
> --
> 2.45.2

I wondering if we can add tests at this stage.

--000000000000619290061ce1e7f2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 62e0a9d6e13e98eb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hT1h1QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMkdrQy85eGFvVG53YlY1MWxtQWhjQ0laK3NlaW5PeAp6RzgxN09rd1Vu
eTE0Z2ZIbDVFNkNUYjhZcHdmRDIvZDNzd1JmR2lPLytCVVpWZ3J1bDZVUnQ4d2Y4OXBHRmxIClJV
Q2F4SnpnWXFERFBwdllxMDNMVFdMRWpscmxJRjRJSFMwRWFQUEhXYWNZa0RYREt0bFFNY0FwdlB0
Z0NleWcKMVNxZHFhT2RSVjc2bG85WTZUVVlJcHFIU1hHeEhOWDkvR3kzdDUrY21rd0hPcjZHc29D
aDhqM1FUeWVYVjMydwpSK0toWUtBbHQ4TGFaa0ZZNUxhMi9lc0ZQS1hnMHpGWVk0VEFxbmFQYlc2
dnZDV2ViUEF0eTlTY3d0dS8vZ2ZvCmVaRDVnWU9RTGlsaGRNV1JCN2RJY1A0YUEyaU9ya0VnSnFG
NTF6SU9SUlVxNEVrcndRSE1lc2x1TDZvVFNVeXkKQ1VNdUdGRlJPaCsxTFFQRzhTMW05QTk5YTVY
VnV4M3o5K1ZFMFpUbjhheHBXL1dLUS93UUhGdFVEUkdseDRJSAp0a3R0RGFjODF2Z0JZYndiTitm
ZUIrSFV4NmFFNDZRVW9KeFZINWxVeFN2UDlXMlk0QlZ5bXYvWEJtSmg2NHVaCmozbEMrLy9xQzVO
QmJZb3IwWTF1TmN4d0ZhNWQvam9DSFN1R2kzWT0KPXVQaEsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000619290061ce1e7f2--
