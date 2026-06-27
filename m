Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5735D14F112
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 00:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782519769; cv=pass; b=SVGXzNbicsEiqUcu7cjsl1sUJMauOnYkBMOm+NqI0ZOHxSgUUCB4uK+rhLjfnP16w48anQcVYnMci6CHOW1ED8Po9N1ITpp2fQ0iGJQdAGo1EqRYfSZbNuTzTBCkpYo8k3sHv54nMJeK9yIezvPMbcsG2aCVw54tsu2AlUioK1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782519769; c=relaxed/simple;
	bh=tZTVDf0yyehtSOwZnua2rUPgooMqIxCwvH8vSNtRch0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TW9kQKw+6kgD/znYY6YwRSVxEFJFkjCaFUSpVlzmfB1em5izyOXB5XKny0VoWSGfWTIXkTT1gwbbhsm+/QhuN4zo/JMEThmnEr2sDH51YN0ezYWbFQ2jJ1ZbkAYICMA5c6sFkxsfQoCrqj51cKOvvRzo4M5bDabsnhDcGdAZHA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+McfxOi; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+McfxOi"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso689031e0c.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 17:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782519766; cv=none;
        d=google.com; s=arc-20260327;
        b=aPrRsEEq4c88+yY+4cinQBYhEw6x11SiWhIFwpPoZRKGTbKnF716bQ/mLDb9RvVhhW
         pXgUcDlSGGwJp24b9jttDT+Qo177ohsiZRdWVdhdkws0OiGdR5po6FdnR+qgybs6mlwm
         6gKLQrnaZu8kj33HtTuVqYVytIAQPAqyzca3rBon6NUHXpBFNxTtqthK6S0L/DH4Xjrt
         mpMxhPMvG7RNs2xcTPGeydQ3xmw+vA484f4kRXmvBJWdMKqRf7rZ+YcAPD840U4OzbXg
         ZPoRHalC7TXVmLUAWiFRZEjui2uVqrW0Rf6NAKnBLfkjSIbCJC1WqsNeffRF64b9DTnS
         lAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=2Af9SwTzcRhnJjTKVKYQVk8Qj10p5EGep8Mf+ckGC/k=;
        fh=nmVBMjIKElipjsRLuOX1BVq0joK9praOt14nDgoCG1Q=;
        b=KJ7+j0NcXXBXQDOdIrL5zzRzAzz7p9kpAI8yL83egFjFyi7PbfdChszmV7VL9k7dLY
         hILF6YeHjd13tpBCw91j/Xl0/jXjO9TvFcjIS5HdXCW+hl0KbSVWksmY0lEbtj/d908p
         1r6ZJ5kI69qgl0SMoep+8QkGLNotFyYO3Umysynpr7LtdxMF6V3V94T7Ftz0cR29BbtZ
         xg7tbSGo4EUR6WoN8Q+rasJfT2g63ZBd6uxKPlcRolWhFfe/dTtdN/oFx2O+zvC7T1Cd
         iak+rBSNCjCFzFQRrS61DUF2vgg2W0VtxvtvX0VkhTxcPcJKbLwgaa2jR5TdbCNnzUsO
         ol8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782519766; x=1783124566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Af9SwTzcRhnJjTKVKYQVk8Qj10p5EGep8Mf+ckGC/k=;
        b=E+McfxOixDAIHxjYb98BmLoVoNCGQO/ukRI3MDfvm9z/w+yTZRaUo6nHraKm7Cg5Cr
         5L25eCrkWHtMvJObWyJF0xly5lIaMg1HieKgYMl3MOhK3Gw68bp4nIWkg+xzz1o8dUYD
         8sRTxLeGOkPHDta3qNegJ+5rDu3ab9j1ga2iQOAclHrZm4FpP3kYCYJ4p+bf6NFtGaR+
         ZMP9srj+4Uz33xNOg8VVJbBfaeQeNaemYBZXIopQ9gsFdijWCgkTedkznTwKYJpczqjQ
         nxQU+YfWIItnfY0534E3Dw0ZSr7+LNktxp7s/8iPLX+CdJ8UKRJc/5qgzj0uZLHBaIWF
         Qccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782519766; x=1783124566;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Af9SwTzcRhnJjTKVKYQVk8Qj10p5EGep8Mf+ckGC/k=;
        b=JhndzZN5qXJ9fWNiAZ/lt9StW539QYpMGQG4z9GISIha+4IE/KbbZ03GZ4HDMc4l0t
         SljAU0iunqnA2cYiHduemf9eYYm7bGUmxnm9ybA1TcJazfOjkH1+LEyF5hZZ4hdrWANM
         NMO4em3fF/ZjDv80DM964i17JViN8vwuh270n+pnY0AfelWu3ZEwsfywcFdBwJph1kFo
         9vcw5WkryA/vLw/Tr5Xr1iQvJ0YHs3tyaK2T+OsjZEx5N7giE/IXYa8HK5tggAZGYD59
         Tnj+a8c7r4qHNqi9JME0IQO8vRQnIOFAMOWecPRa/NSpyOQ2/1I5sYZ0n7Nm6B+oI+Mu
         KY+A==
X-Forwarded-Encrypted: i=1; AHgh+RqjkeTTycZ6L/tZ0hBeaTRcBSXM91VMBqatrufc16tG67rlwg/SQFbuhIoBOp83yCUIVXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ1cOvoPGJ7Gp2KB9nbSHfrUGv+epEQti3wAV0JvzjJh3AUURl
	yakC3Q02t4I5r35OMOfut91GM/y2VYaaHRyKILU24uBFbM2BsUFZrRrtxjEqHIKuWshT3jZAMX8
	jAyKIHj5t4sN385Q//avluyJnSRGkQmM=
X-Gm-Gg: AfdE7ckFfg+sceGlJep2L/96j59AKfdG7gW9rskp49cdszrmCkt/x7cvcl8cRjg0Ivj
	g1NeXMerZcr4whfzN9FhM+7fENTSXcNeWWTJfS3Kiz5A2pdqUmRAm2eFW8ylk5hdNgasS9xZof3
	xdXxkH06H5Ysw35P7ozK1OuipCPmDu6+DeH86eHP541qXGabKBAev/efmAYFuGmJ0N46/S8LA8h
	aXbgB1Vk7ijI/UH/BVNcTPYgDDSJn/gSuOrp0vpCSUJ2WPq/aPq98raa57HmRTQHqydbNar4pjG
	gpUuY2Jl3ykF8gfUMCQVgKJSuwO0D0a+XM87Wi2aNntmeJqLF55xdfFNquV/
X-Received: by 2002:a05:6122:1d8e:b0:59e:b127:fc6f with SMTP id
 71dfb90a1353d-5bd69c23837mr4022755e0c.2.1782519766137; Fri, 26 Jun 2026
 17:22:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jun 2026 17:22:45 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jun 2026 17:22:45 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260625-ps-eric-work-rebase-v14-10-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com> <20260625-ps-eric-work-rebase-v14-10-09f7ffe21a53@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Jun 2026 17:22:45 -0700
X-Gm-Features: AVVi8CcXXdR7TvwzwgxbaiDkBNHMqQgLc9XNTmG_cbxN07FHnTWrWn85jwc8Gz4
Message-ID: <CAOLa=ZT8u32YUqhnq-pMCCK8Qzx+7k-3E-+yAoM_miJ7BQjxTA@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 10/13] transport: add client support for object-info
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>
Content-Type: multipart/mixed; boundary="0000000000007764040655313935"

--0000000000007764040655313935
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> From: Calvin Wan <calvinwan@google.com>
>
> Sometimes, it is beneficial to retrieve information about an object
> without downloading it entirely. The server-side logic for this
> functionality was implemented in commit "a2ba162cda (object-info:
> support for retrieving object info, 2021-04-20)." And the wire
> format is documented at
> https://git-scm.com/docs/protocol-v2#_object_info.
>
> This commit introduces client functions to interact with the server.
>
> Currently, the client supports requesting a list of object IDs with
> the 'size' feature from a v2 server. If the server does not advertise
> this feature (i.e., transfer.advertiseobjectinfo is set to false),
> the client will return an error and exit.
>
> Notice that the entire request is written into req_buf before being
> sent to the remote. This approach follows the pattern used in the
> `send_fetch_request()` logic within fetch-pack.c.
> Streaming the request is not addressed in this patch.
>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Helped-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Eric Ju <eric.peijian@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  Makefile            |  1 +
>  fetch-object-info.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fetch-object-info.h | 22 +++++++++++++
>  fetch-pack.c        |  3 ++
>  fetch-pack.h        |  2 ++
>  meson.build         |  1 +
>  transport-helper.c  | 11 +++++--
>  transport.c         | 28 ++++++++++++++++-
>  transport.h         | 11 +++++++
>  9 files changed, 166 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 1cec251f43..ec4df39a6b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1159,6 +1159,7 @@ LIB_OBJS += ewah/ewah_rlw.o
>  LIB_OBJS += exec-cmd.o
>  LIB_OBJS += fetch-negotiator.o
>  LIB_OBJS += fetch-pack.o
> +LIB_OBJS += fetch-object-info.o
>  LIB_OBJS += fmt-merge-msg.o
>  LIB_OBJS += fsck.o
>  LIB_OBJS += fsmonitor.o
> diff --git a/fetch-object-info.c b/fetch-object-info.c
> new file mode 100644
> index 0000000000..9c4ae9bd11
> --- /dev/null
> +++ b/fetch-object-info.c
> @@ -0,0 +1,90 @@
> +#include "git-compat-util.h"
> +#include "gettext.h"
> +#include "hex.h"
> +#include "pkt-line.h"
> +#include "connect.h"
> +#include "oid-array.h"
> +#include "odb.h"
> +#include "fetch-object-info.h"
> +#include "string-list.h"
> +
> +/* Sends git-cat-file object-info command and its arguments into the request buffer. */

This file doesn't know about git-cat-file(1), nor should it care about
it, right? Since git-cat-file(1) is simply a user of this function.
Would it make more sense to structure the document around what this
function is supposed to do?

Also the comment for `fetch_object_info` seems to be similar, perhaps
worthwhile changing both without referring to git-cat-file(1).
Theoretically there could be other users in the future too.

> +static void send_object_info_request(const int fd_out, struct object_info_args *args)
> +{
> +	struct strbuf req_buf = STRBUF_INIT;
> +
> +	write_command_and_capabilities(&req_buf, "object-info", args->server_options);
> +
> +	if (unsorted_string_list_has_string(args->object_info_options, "size"))
> +		packet_buf_write(&req_buf, "size");
> +

Okay so if the user requests 'size', we forward that to the server. But
what about the 'else' condition? Should we BUG() out?

> +	if (args->oids)
> +		for (size_t i = 0; i < args->oids->nr; i++)
> +			packet_buf_write(&req_buf, "oid %s", oid_to_hex(&args->oids->oid[i]));
> +
> +	packet_buf_flush(&req_buf);
> +	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
> +		die_errno(_("unable to write request to remote"));
> +

We write out all the oids, flush and write to the fd. Okay.

> +	strbuf_release(&req_buf);
> +}
> +
> +int fetch_object_info(const enum protocol_version version, struct object_info_args *args,
> +		      struct packet_reader *reader, struct object_info *object_info_data,
> +		      const int stateless_rpc, const int fd_out)
> +{
> +	int size_index = -1;
> +
> +	switch (version) {
> +	case protocol_v2:
> +		if (!server_supports_v2("object-info"))
> +			die(_("object-info capability is not enabled on the server"));
> +		send_object_info_request(fd_out, args);

So if the server does support 'object-info', we call
`send_object_info_request()`. Makes sense.

> +		break;
> +	case protocol_v1:
> +	case protocol_v0:
> +		die(_("unsupported protocol version. expected v2"));
> +	case protocol_unknown_version:
> +		BUG("unknown protocol version");
> +	}
> +

Now that we've sent the request, we should start parsing the response.

> +	for (size_t i = 0; i < args->object_info_options->nr; i++) {
> +		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
> +			check_stateless_delimiter(stateless_rpc, reader,
> +						  "stateless delimiter expected");
> +			return -1;
> +		}
> +
> +		if (!string_list_has_string(args->object_info_options, reader->line))
> +			return -1;
> +
> +		if (!strcmp(reader->line, "size")) {
> +			size_index = i;
> +			for (size_t j = 0; j < args->oids->nr; j++)
> +				object_info_data[j].sizep = xcalloc(1, sizeof(*object_info_data[j].sizep));
> +		}
> +	}
> +

So this function seems to iterate over the list of options to only find
and store the indexes. If the server does support size we also allocate
the pointers to store the size.

Shouldn't we similarly BUG() if there is anything apart from 'size' here?

> +	for (size_t i = 0; packet_reader_read(reader) == PACKET_READ_NORMAL && i < args->oids->nr; i++) {
> +		struct string_list object_info_values = STRING_LIST_INIT_DUP;
> +
> +		string_list_split(&object_info_values, reader->line, " ", -1);
> +		if (0 <= size_index) {
> +			if (!strcmp(object_info_values.items[1 + size_index].string, "")) {
> +				FREE_AND_NULL(object_info_data[i].sizep);
> +				string_list_clear(&object_info_values, 0);
> +				continue;
> +			}
> +			if (strtoul_szt(object_info_values.items[1 + size_index].string,
> +				       10, object_info_data[i].sizep))

This is now no longer correctly aligned.

> +				die("object-info: ref %s has invalid size %s",
> +				    object_info_values.items[0].string,
> +				    object_info_values.items[1 + size_index].string);
> +		}
> +
> +		string_list_clear(&object_info_values, 0);
> +	}
> +	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
> +

We parse each line and obtain the size and parse it into
`object_info_data[i].sizep`. If the value is missing, we simply continue
the iteration.

I think we had this discussion off the list about how this means that
oids which do not have a size will not error out but rather display a
missing info value.

The argument for not error'ing out was better user experience where the
command would complete without exiting. I still think we should error
out, because:

1. Without error'ing out, we'd have to display to the user a missing
value token. There is contention around what this token should be,
as such a token shouldn't be a valid value for the info type being
displayed. Future options must be considered here.

2. What will the error code of such a situation be? Do we consider it a
success or a failure? Is there a situation where an object can have a
missing size?

> +	return 0;
> +}
> diff --git a/fetch-object-info.h b/fetch-object-info.h
> new file mode 100644
> index 0000000000..d35284bd6b
> --- /dev/null
> +++ b/fetch-object-info.h
> @@ -0,0 +1,22 @@
> +#ifndef FETCH_OBJECT_INFO_H
> +#define FETCH_OBJECT_INFO_H
> +
> +#include "pkt-line.h"
> +#include "protocol.h"
> +#include "odb.h"
> +
> +struct object_info_args {
> +	struct string_list *object_info_options;
> +	const struct string_list *server_options;
> +	struct oid_array *oids;
> +};
> +
> +/*
> + * Sends git-cat-file object-info command into the request buf and read the
> + * results from packets.
> + */
> +int fetch_object_info(enum protocol_version version, struct object_info_args *args,
> +		      struct packet_reader *reader, struct object_info *object_info_data,
> +		      int stateless_rpc, int fd_out);
> +
> +#endif /* FETCH_OBJECT_INFO_H */
> diff --git a/fetch-pack.c b/fetch-pack.c
> index cdebd3476f..a86c93fc52 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1742,6 +1742,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	if (args->depth > 0 || args->deepen_since || args->deepen_not)
>  		args->deepen = 1;
>
> +	if (args->object_info)
> +		state = FETCH_SEND_REQUEST;
> +
>  	while (state != FETCH_DONE) {
>  		switch (state) {
>  		case FETCH_CHECK_LOCAL:
> diff --git a/fetch-pack.h b/fetch-pack.h
> index 6d0dec7f41..5a428f11ed 100644
> --- a/fetch-pack.h
> +++ b/fetch-pack.h
> @@ -16,6 +16,7 @@ struct fetch_pack_args {
>  	const struct string_list *deepen_not;
>  	struct list_objects_filter_options filter_options;
>  	const struct string_list *server_options;
> +	struct object_info *object_info_data;
>
>  	/*
>  	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
> @@ -43,6 +44,7 @@ struct fetch_pack_args {
>  	unsigned reject_shallow_remote:1;
>  	unsigned deepen:1;
>  	unsigned refetch:1;
> +	unsigned object_info:1;
>
>  	/*
>  	 * Indicate that the remote of this request is a promisor remote. The
> diff --git a/meson.build b/meson.build
> index 3247697f74..145c6882eb 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -347,6 +347,7 @@ libgit_sources = [
>    'exec-cmd.c',
>    'fetch-negotiator.c',
>    'fetch-pack.c',
> +  'fetch-object-info.c',
>    'fmt-merge-msg.c',
>    'fsck.c',
>    'fsmonitor.c',
> diff --git a/transport-helper.c b/transport-helper.c
> index f195070788..c77599f6fb 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -727,8 +727,8 @@ static int fetch_refs(struct transport *transport,
>
>  	/*
>  	 * If we reach here, then the server, the client, and/or the transport
> -	 * helper does not support protocol v2. --negotiate-only requires
> -	 * protocol v2.
> +	 * helper does not support protocol v2. --negotiate-only and cat-file
> +	 * remote-object-info require protocol v2.

This is not really true as of this commit. This only comes into effect
in the next commit. So shouldn't this be added there? That said, I would
modify this to only talk about object-info requiring v2 and drop the
reference to cat-file.

>  	 */
>  	if (data->transport_options.acked_commits) {
>  		warning(_("--negotiate-only requires protocol v2"));
> @@ -744,6 +744,13 @@ static int fetch_refs(struct transport *transport,
>  		free_refs(dummy);
>  	}
>
> +	/* fail the command explicitly to avoid further commands input. */
> +	if (transport->smart_options->object_info)
> +		die(_("remote-object-info requires protocol v2"));
> +
> +	if (!data->get_refs_list_called)
> +		get_refs_list_using_list(transport, 0);
> +

Don't we already do this right above? Why is this needed again?

>  	count = 0;
>  	for (i = 0; i < nr_heads; i++)
>  		if (!(to_fetch[i]->status & REF_STATUS_UPTODATE))
> diff --git a/transport.c b/transport.c
> index 0f5ec30247..7d3246e12b 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -9,6 +9,7 @@
>  #include "hook.h"
>  #include "pkt-line.h"
>  #include "fetch-pack.h"
> +#include "fetch-object-info.h"
>  #include "remote.h"
>  #include "connect.h"
>  #include "send-pack.h"
> @@ -467,8 +468,33 @@ static int fetch_refs_via_pack(struct transport *transport,
>  	args.negotiation_restrict_tips = data->options.negotiation_restrict_tips;
>  	args.negotiation_include_tips = data->options.negotiation_include_tips;
>  	args.reject_shallow_remote = transport->smart_options->reject_shallow;
> +	args.object_info = transport->smart_options->object_info;
> +

Hmm, so we piggy-back on top of the `fetch_refs_via_pack()` function...

> +	if (transport->smart_options->object_info
> +	    && transport->smart_options->object_info_oids->nr > 0) {
> +		struct packet_reader reader;
> +		struct object_info_args obj_info_args = { 0 };
> +
> +		obj_info_args.server_options = transport->server_options;
> +		obj_info_args.oids = transport->smart_options->object_info_oids;
> +		obj_info_args.object_info_options = transport->smart_options->object_info_options;
> +		string_list_sort(obj_info_args.object_info_options);
> +
> +		connect_setup(transport, 0);
> +		packet_reader_init(&reader, data->fd[0], NULL, 0,
> +				PACKET_READ_CHOMP_NEWLINE |
> +				PACKET_READ_GENTLE_ON_EOF |
> +				PACKET_READ_DIE_ON_ERR_PACKET);
> +
> +		data->version = discover_version(&reader);
> +		transport->hash_algo = reader.hash_algo;
> +
> +		ret = fetch_object_info(data->version, &obj_info_args, &reader,
> +					data->options.object_info_data, transport->stateless_rpc,
> +					data->fd[1]);
> +		goto cleanup;
>

... and we jump to exit when we only want object info information. This
skips the call to fetch_pack(). I'm a bit uneasy with this. Ideally we
should be adding a new function to the vtable to only fetch object info.
While this works, this doesn't fit the contract of what this function is
supposed to do. See the comment around `fetch_refs` in `struct
transport_vtable`. Shouldn't we update that documentation at the very
least?

> -	if (!data->finished_handshake) {
> +	} else if (!data->finished_handshake) {
>  		int i;
>  		int must_list_refs = 0;
>  		for (i = 0; i < nr_heads; i++) {
> diff --git a/transport.h b/transport.h
> index 7e5867cffa..bd60b10af4 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -6,6 +6,7 @@
>  #include "list-objects-filter-options.h"
>  #include "string-list.h"
>  #include "connect.h"
> +#include "odb.h"
>
>  struct git_transport_options {
>  	unsigned thin : 1;
> @@ -31,6 +32,12 @@ struct git_transport_options {
>  	 */
>  	unsigned connectivity_checked:1;
>
> +	/*
> +	 * Transport will attempt to retrieve only object-info.
> +	 * If object-info is not supported, the operation will error and exit.
> +	 */
> +	unsigned object_info : 1;
> +

According to our style, this should be `unsigned object_info:1`.

>  	int depth;
>  	const char *deepen_since;
>  	const struct string_list *deepen_not;
> @@ -55,6 +62,10 @@ struct git_transport_options {
>  	 * common commits to this oidset instead of fetching any packfiles.
>  	 */
>  	struct oidset *acked_commits;
> +
> +	struct oid_array *object_info_oids;
> +	struct object_info *object_info_data;
> +	struct string_list *object_info_options;
>  };
>
>  enum transport_family {
>
> --
> 2.54.0

Nit: I do think the commit message doesn't sufficiently capture the
entirety of this patch. We do not talk about:

1. How we piggy-back on top of `fetch_refs_via_pack()` and don't
introduce our own pointer in the vtable.
2. The changes made to 'transport-helper.c' and why that is required.
3. How we don't error out when there is no size value provided for an
OID and what the implication of this is.

--0000000000007764040655313935
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 90120ca0941f170e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vL0Y5TVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meFk3Qy85V0VYMUlFdGV3bWR0WW1zbGFhb042R3VWRgpnYVY0Zk9BdzlK
dFR4MUVDK3FLdzVTcnNraHB3MlE3aFhTVzlZTXFieUp0L2xZWkh0aDFiS0Z1T2VkeE1OWlZtClNF
NzJPNjNWNjlxa2tqMmh3aVNrMU5iQk5kNE1lcHdzUzNYNDd4ME9jVTJpWXVoOTg4R0o3c0N6d0I3
dlZaU1cKSnJNWS80K3F3bHBWVUZ5MFVST2kzUGpVaVlmZTBWS1Y2alFXaUJub1hIYzdxSEErYTBT
cExOUVlSNFRTYlBtRQpJV1BxYlAwRE9ZSnJvUDJBTzl3TmdrdEVpcHJ5N05KTmcyZnhsYzI3OEh0
dnh4SmttdVQ0ZWtDK2JTOG1ZUjRtCmtIM0pPc0NBaWhCcUlFYldlaHFjYlVuaDNRZHljTDVyREx0
RlVnV0RuSFJNZ3dTckxORG9YRlhLVzk5V2tkUTYKbnh4OEZJdmpUQjl1Q2k0QnZVWGxFSlFkSld5
WlI5bXhRKzRMNVh0andRVXIvZnA1Nnl4TXo0ZGw5YVN2a1kwMQphdzVkOElzdTkwYmVsU2FtcWhR
Q0VPQXJCTlJpbXBqRE1zZmxIVFBFTExZZjc4R0NtRG1oaEhuS0JBUi9CeVZ5CjFtdlk0dHBKQzBj
Y0t4OTJ1bmhKbzRpdkJZWVg3SjN2ai9NYmE3az0KPUNYYkgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007764040655313935--
