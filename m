Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7DD70836
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782589497; cv=pass; b=a3wA0dNHXUA4Tk6NkVWDy1YVaRxFJQlqkGlg4hwv2ooIyzCHR5TJxLFx3mHdawNlYpm1wudfDXd6+2ej9dWsyhBDnjmO0zXmPwPpJOVOS6sA9eL3FyiBzrtT4FF0vQ7gZLqk7yzTEaZh8KbQqesLTIxiA+JAKl6BgHnj/oDfS5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782589497; c=relaxed/simple;
	bh=QxW3DUARyKhxEywbMNMTx97ZyFoe/k23FCKQXVxQgRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjGaido6GdVzKeneUt+/RxVbHRfB+RdLqfh2CwAD+4FJE4OXYwDLl42OYGAsa7QkBQXrBICdBMd3IWInE2dF3gkgXMx89gawstTe3xpNLaBqCkF6n/Dq5zERcOqCNBXEBT29WPH+sKK8xcdgRntcmMbYUnuNNWTlRXm7p19JD/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBARrSqZ; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBARrSqZ"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664ae993e4bso1587745d50.0
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 12:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782589493; cv=none;
        d=google.com; s=arc-20260327;
        b=p34EzUNsmOT/uVE456xptira6d64U7TTUTNrST9I0z+j4CSWpI1b0NIYkSKpbZKGHI
         8HbhDX8UNu0fVHZgkmOOuE83qUOqEBkDm/uKeB+varXaqO/0SGYqjnJG3gmBKG9HCf6+
         ep9/sR2bJrTdX7daLkml9J7vuln0ze+I/kpHdI0YKa4jplFYClcqNPFQDqQCYpptHu3o
         yD4S0VlcKvxfuV2W4NL8a21F7K31JTvVdEvSE8Yd9f7A3TX7FsNT0h3NzyZ973+WSP6N
         FnjiICxmcJiXHF9qbA93SivUIkrmi1jZYkb+4ZBKOxzvXXOUpvLP/JWtemVbJfTBGIIB
         WYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xJcfRlLLZBAMAQHrxBOkE5+JPfCty0lqJkVDmj9Rlkc=;
        fh=/GYIkWUL0/cZdPWKPxjGPaxhlblf9G+nT0qbecce3n4=;
        b=QIF2cnxAGasGr9P8QhetjONODe+eJLgaz7N3wAftf7wohaghw89QudCzL0XJHtJZN4
         5l7CsHcFerRtFYgMuWhEbE6admdQi8LwbHg/YV0cvUh+Sp7qsc279aWgiPS1+WL1hD5e
         bLrBGtWJ8r6QaPJJufGFVOXn+MPD6gBT2/+z51zYqs4zI816POzFnsRYEaQsRh3/wES+
         HDDqHiyw60c2L1dgxpDfsL3P8fZxGSijZnDXF4so8bKyLirohd8vcSJe0KDKp84yFZA4
         uxmiVOE2M/ukLRU4CK3a24tA4OCVAtwQomVemPt5TgNY1QUN4AvZnl+IrVrx2PIPeh8T
         tCzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782589493; x=1783194293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJcfRlLLZBAMAQHrxBOkE5+JPfCty0lqJkVDmj9Rlkc=;
        b=mBARrSqZfnUth81vqQddYatTYZWD19DzsofuN9nIfS1w0npG5nyEizV++dvgrnPo5Q
         h0S71KeAEp5Xi+pn2xOPyVF0Sjh7cJyAkye2r/or9zuX+54Tl9CvnGOxP3QANt84xR63
         +Rwg1/vkTeFCdMVwpldcjsUDjtIK8OX8LKpx+ursgehDV9oG8ZfbeylPz+V2A4WMpR/V
         oW1+D7RqS2d+f4CEuB/pgNbT9Aj8LKMoXy+c9HuYhri8CB/J9xupcBXzXeFgEkssYROz
         YSZfx6C0qjpaTiD8wc00z4NhkNlpukguEFbw+f6xHvPP96S7V3Qo10mShATRvAz8WKaA
         G0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782589493; x=1783194293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xJcfRlLLZBAMAQHrxBOkE5+JPfCty0lqJkVDmj9Rlkc=;
        b=bZl85ms9ac6EsB2+O1qf1FwSHnJc765olUzfJY6DjKS6fdobgqhoSUDKsuVq86jZ/Y
         ioYI1tCto2RIE1RF3jMwg0yqB0j7fKBfGhjSOM2nOpl5HEzQbeCAVzUi5+jOHb6VX/ei
         MdXSwH+c6o00PXfRgjCEtp1fGOrE7uFvCx2TpaCygru87i7GIqsQoVNa43+prbSNxRMF
         4UM6/cLhMLfeI9Nk1l+A6uQORhA7SytDbJ0ox3X1Fw6rOUKP8j3PpJ7FxYbB1DK9M3ZJ
         ueY+EyV45uXkSM68W39AUlSBoFqNOv+9Q2L6lT3H2EqfqpAhU/LX6N62t7liL6tBd0HF
         jtWA==
X-Gm-Message-State: AOJu0Yxk6gmTCSpjh5TJaFTiFW2mQF8Xrg5rFpdKMqxwLEMQfs23j4jT
	Bcagrc3Weujo96AJa5SzdzwjxTuj4XBHYHZu9Q7nl8LuWFTfCLlmpAsECiJx0g1DkMVDEZrgqfy
	/+ZHpUBC2+8G83hss6pGeWepIiJZzvas=
X-Gm-Gg: AfdE7ck9Qfw61qX2q40QHGWVyp80OWdQXcCFPYNGnr7L8dkjyIyvTj1rClYbKgVqTwX
	FqBTLA82DT67c9dQCZbzvre40H8VQ1/wB8ysmrW+vKp+Z5w/JPU2me/p8qyjOMu9SZXF4oiqJiU
	krI4lP+lbmWOoUse4YbRQkEYu3ymZ2OqE+YWaHPUK6Ie5+n4zRWBIZmx9tTjGtlyY03o+O1PLEa
	RZismk4wsnWoD6aK9xyKaMU2P/pTQoCgCI19OaLgmnNLpMQiZJzTYY5b+uad4VRZCB99umQTmR8
	vsHiRHUSPWaTzNUYohByX3496LfXV9auQoK4GDH8QTX8JKGI27inVIBtiyKoi07pp6UdCxnkv23
	5N8kK4MCTPdl45e8ckrJrUFkSQ1LLb07F0k57KcdiG571oygLERUj78JK3+/hJbEzcLiYqA==
X-Received: by 2002:a05:690e:1349:b0:662:d25f:dabb with SMTP id
 956f58d0204a3-66487603f79mr10163924d50.11.1782589493358; Sat, 27 Jun 2026
 12:44:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260625-ps-eric-work-rebase-v14-10-09f7ffe21a53@gmail.com> <CAOLa=ZT8u32YUqhnq-pMCCK8Qzx+7k-3E-+yAoM_miJ7BQjxTA@mail.gmail.com>
In-Reply-To: <CAOLa=ZT8u32YUqhnq-pMCCK8Qzx+7k-3E-+yAoM_miJ7BQjxTA@mail.gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 27 Jun 2026 21:44:42 +0200
X-Gm-Features: AVVi8CcTJAICKUtT2TQmZd0lNEVilsShb_bycuIxo4tSfzD6E9rWNMamDSZ8QdA
Message-ID: <CAN5EUNQaEvJa_ro+wYwHjGYttCDB+kJKMoO6ypGAH7QjdSea-w@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 10/13] transport: add client support for object-info
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El s=C3=A1b, 27 jun 2026 a las 2:22, Karthik Nayak
(<karthik.188@gmail.com>) escribi=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> > From: Calvin Wan <calvinwan@google.com>
> >
> > Sometimes, it is beneficial to retrieve information about an object
> > without downloading it entirely. The server-side logic for this
> > functionality was implemented in commit "a2ba162cda (object-info:
> > support for retrieving object info, 2021-04-20)." And the wire
> > format is documented at
> > https://git-scm.com/docs/protocol-v2#_object_info.
> >
> > This commit introduces client functions to interact with the server.
> >
> > Currently, the client supports requesting a list of object IDs with
> > the 'size' feature from a v2 server. If the server does not advertise
> > this feature (i.e., transfer.advertiseobjectinfo is set to false),
> > the client will return an error and exit.
> >
> > Notice that the entire request is written into req_buf before being
> > sent to the remote. This approach follows the pattern used in the
> > `send_fetch_request()` logic within fetch-pack.c.
> > Streaming the request is not addressed in this patch.
> >
> > Helped-by: Jonathan Tan <jonathantanmy@google.com>
> > Helped-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Eric Ju <eric.peijian@gmail.com>
> > Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> > ---
> >  Makefile            |  1 +
> >  fetch-object-info.c | 90 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  fetch-object-info.h | 22 +++++++++++++
> >  fetch-pack.c        |  3 ++
> >  fetch-pack.h        |  2 ++
> >  meson.build         |  1 +
> >  transport-helper.c  | 11 +++++--
> >  transport.c         | 28 ++++++++++++++++-
> >  transport.h         | 11 +++++++
> >  9 files changed, 166 insertions(+), 3 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 1cec251f43..ec4df39a6b 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1159,6 +1159,7 @@ LIB_OBJS +=3D ewah/ewah_rlw.o
> >  LIB_OBJS +=3D exec-cmd.o
> >  LIB_OBJS +=3D fetch-negotiator.o
> >  LIB_OBJS +=3D fetch-pack.o
> > +LIB_OBJS +=3D fetch-object-info.o
> >  LIB_OBJS +=3D fmt-merge-msg.o
> >  LIB_OBJS +=3D fsck.o
> >  LIB_OBJS +=3D fsmonitor.o
> > diff --git a/fetch-object-info.c b/fetch-object-info.c
> > new file mode 100644
> > index 0000000000..9c4ae9bd11
> > --- /dev/null
> > +++ b/fetch-object-info.c
> > @@ -0,0 +1,90 @@
> > +#include "git-compat-util.h"
> > +#include "gettext.h"
> > +#include "hex.h"
> > +#include "pkt-line.h"
> > +#include "connect.h"
> > +#include "oid-array.h"
> > +#include "odb.h"
> > +#include "fetch-object-info.h"
> > +#include "string-list.h"
> > +
> > +/* Sends git-cat-file object-info command and its arguments into the r=
equest buffer. */
>
> This file doesn't know about git-cat-file(1), nor should it care about
> it, right? Since git-cat-file(1) is simply a user of this function.
> Would it make more sense to structure the document around what this
> function is supposed to do?
>
> Also the comment for `fetch_object_info` seems to be similar, perhaps
> worthwhile changing both without referring to git-cat-file(1).
> Theoretically there could be other users in the future too.

`git cat-file` is currently the only consumer of `object-info` but you
are right, this file shouldn't know about it nor mention it in a
comment, I'll drop it.

>
> > +static void send_object_info_request(const int fd_out, struct object_i=
nfo_args *args)
> > +{
> > +     struct strbuf req_buf =3D STRBUF_INIT;
> > +
> > +     write_command_and_capabilities(&req_buf, "object-info", args->ser=
ver_options);
> > +
> > +     if (unsorted_string_list_has_string(args->object_info_options, "s=
ize"))
> > +             packet_buf_write(&req_buf, "size");
> > +
>
> Okay so if the user requests 'size', we forward that to the server. But
> what about the 'else' condition? Should we BUG() out?

In patch [13/13] the options are built dynamically  and filtered
against what the server advertises, so by the time we reach here only
valid options remain. For this commit there is no client support yet
so there is no way of this to fail and in the next commit [11/13]:

get_remote_info()
[snip]
        string_list_append(&object_info_options, "size");

        if (object_info_options.nr > 0) {
                gtransport->smart_options->object_info_options =3D
&object_info_options;
                gtransport->smart_options->object_info_data =3D
*remote_object_info;
                retval =3D transport_fetch_refs(gtransport, NULL);
        }
[snip]

get_remote_info() appends "size" always to object_info_options and
this is changed in commit [12/13] with the allow-list where only asked
object-info is appended. I could move that check to this commit as if
size always gets appended the `if` below will always be true.

Also because size is always appended there can't be an else condition
to BUG() out.
>
> > +     if (args->oids)
> > +             for (size_t i =3D 0; i < args->oids->nr; i++)
> > +                     packet_buf_write(&req_buf, "oid %s", oid_to_hex(&=
args->oids->oid[i]));
> > +
> > +     packet_buf_flush(&req_buf);
> > +     if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
> > +             die_errno(_("unable to write request to remote"));
> > +
>
> We write out all the oids, flush and write to the fd. Okay.
>
> > +     strbuf_release(&req_buf);
> > +}
> > +
> > +int fetch_object_info(const enum protocol_version version, struct obje=
ct_info_args *args,
> > +                   struct packet_reader *reader, struct object_info *o=
bject_info_data,
> > +                   const int stateless_rpc, const int fd_out)
> > +{
> > +     int size_index =3D -1;
> > +
> > +     switch (version) {
> > +     case protocol_v2:
> > +             if (!server_supports_v2("object-info"))
> > +                     die(_("object-info capability is not enabled on t=
he server"));
> > +             send_object_info_request(fd_out, args);
>
> So if the server does support 'object-info', we call
> `send_object_info_request()`. Makes sense.
>
> > +             break;
> > +     case protocol_v1:
> > +     case protocol_v0:
> > +             die(_("unsupported protocol version. expected v2"));
> > +     case protocol_unknown_version:
> > +             BUG("unknown protocol version");
> > +     }
> > +
>
> Now that we've sent the request, we should start parsing the response.
>
> > +     for (size_t i =3D 0; i < args->object_info_options->nr; i++) {
> > +             if (packet_reader_read(reader) !=3D PACKET_READ_NORMAL) {
> > +                     check_stateless_delimiter(stateless_rpc, reader,
> > +                                               "stateless delimiter ex=
pected");
> > +                     return -1;
> > +             }
> > +
> > +             if (!string_list_has_string(args->object_info_options, re=
ader->line))
> > +                     return -1;
> > +
> > +             if (!strcmp(reader->line, "size")) {
> > +                     size_index =3D i;
> > +                     for (size_t j =3D 0; j < args->oids->nr; j++)
> > +                             object_info_data[j].sizep =3D xcalloc(1, =
sizeof(*object_info_data[j].sizep));
> > +             }
> > +     }
> > +
>
> So this function seems to iterate over the list of options to only find
> and store the indexes. If the server does support size we also allocate
> the pointers to store the size.
>
> Shouldn't we similarly BUG() if there is anything apart from 'size' here?

Because only size is appended and the server size support comes with
the series, there shouldn't be a scenario where anything else appears.

1. Full response with size.

2. OID unrecognized by the server.

We can quickly check this because the server response when the OID is
unrecognized is `OID SP` if there's nothing after the SP the object is
unrecognized.

>
> > +     for (size_t i =3D 0; packet_reader_read(reader) =3D=3D PACKET_REA=
D_NORMAL && i < args->oids->nr; i++) {
> > +             struct string_list object_info_values =3D STRING_LIST_INI=
T_DUP;
> > +
> > +             string_list_split(&object_info_values, reader->line, " ",=
 -1);
> > +             if (0 <=3D size_index) {
> > +                     if (!strcmp(object_info_values.items[1 + size_ind=
ex].string, "")) {
> > +                             FREE_AND_NULL(object_info_data[i].sizep);
> > +                             string_list_clear(&object_info_values, 0)=
;
> > +                             continue;
> > +                     }
> > +                     if (strtoul_szt(object_info_values.items[1 + size=
_index].string,
> > +                                    10, object_info_data[i].sizep))
>
> This is now no longer correctly aligned.

I will fix it.

>
> > +                             die("object-info: ref %s has invalid size=
 %s",
> > +                                 object_info_values.items[0].string,
> > +                                 object_info_values.items[1 + size_ind=
ex].string);
> > +             }
> > +
> > +             string_list_clear(&object_info_values, 0);
> > +     }
> > +     check_stateless_delimiter(stateless_rpc, reader, "stateless delim=
iter expected");
> > +
>
> We parse each line and obtain the size and parse it into
> `object_info_data[i].sizep`. If the value is missing, we simply continue
> the iteration.

Related to that above, if `size` is missing we FREE_AND_NULL so later
on `parse_cmd_remote_object_info()` can detect that and print
"missing" for that oid. This "missing" behavior follows what the local
option `info` does for unrecognized OIDs.

parse_cmd_remote_object_info()
[snip]
        for (size_t i =3D 0; i < object_info_oids.nr; i++) {
        data->oid =3D object_info_oids.oid[i];
        if (remote_object_info[i].sizep) {
                /*
                * When reaching here, it means remote-object-info can retri=
eve
                * information from server without downloading them.
                */
                data->size =3D *remote_object_info[i].sizep;
                opt->batch_mode =3D BATCH_MODE_INFO;
                batch_object_write(argv[i + 1], output, opt, data, NULL, 0)=
;
                } else {
                        report_object_status(opt,
oid_to_hex(&data->oid), &data->oid, "missing");
                }
        }
[snip]


>
> I think we had this discussion off the list about how this means that
> oids which do not have a size will not error out but rather display a
> missing info value.

The following commit [11/13] that uses the functions introduced in
this commit, will print "oid missing" in case of the object being
unrecognized by the server, the no error out (empty string) would be
in the scenario where the object is recognized by the server but the
capability is not. Because this same series introduces the capability
advertisement at [9/13] commit we can be sure that size will always be
supported.
Subsequent commits with the allow-list aim to tackle this with the
empty-strings when a server doesn't support a capability.

>
> The argument for not error'ing out was better user experience where the
> command would complete without exiting. I still think we should error
> out, because:
>
> 1. Without error'ing out, we'd have to display to the user a missing
> value token. There is contention around what this token should be,
> as such a token shouldn't be a valid value for the info type being
> displayed. Future options must be considered here.

I believe that better user experience was my argument last time we
discussed and I still believe that. But a stronger argument is that
the local option `info` doesn't die either but rather it prints "OID
missing" and the next commit where the cmd-related functions are
implemented tries to be consistent with it for unrecognized OIDs.

>
> 2. What will the error code of such a situation be? Do we consider it a
> success or a failure? Is there a situation where an object can have a
> missing size?

There are two different scenarios to consider here:

1. OID unrecognized by the server: the server responds with `oid SP`
(no value after the space).
   In this case, the next commit [11/13] prints "<OID> missing" using
`report_object_status()`, which is consistent with how the local
`info` command handles missing objects in `--batch-command`.

2. OID recognized but a capability is not supported by the server:
subsequent commits [12/13] and [13/13] introduce an allow-list that
filters options against what the server advertises.
   Unsupported placeholders return an empty string, following how
`for-each-ref`handles known but inapplicable atoms.

For the exit code, both cases return 0. In case 1, this matches the
local `info` behavior. In case 2, we are not failing to fetch, we
simply see that the server does not support the requested capabilities
and skip the request to the server. For the missing token (your point
1), we reuse the existing "missing" token from
`report_object_status()`, which is what the local code path already
uses, so no new token is introduced.

>
> > +     return 0;
> > +}
> > diff --git a/fetch-object-info.h b/fetch-object-info.h
> > new file mode 100644
> > index 0000000000..d35284bd6b
> > --- /dev/null
> > +++ b/fetch-object-info.h
> > @@ -0,0 +1,22 @@
> > +#ifndef FETCH_OBJECT_INFO_H
> > +#define FETCH_OBJECT_INFO_H
> > +
> > +#include "pkt-line.h"
> > +#include "protocol.h"
> > +#include "odb.h"
> > +
> > +struct object_info_args {
> > +     struct string_list *object_info_options;
> > +     const struct string_list *server_options;
> > +     struct oid_array *oids;
> > +};
> > +
> > +/*
> > + * Sends git-cat-file object-info command into the request buf and rea=
d the
> > + * results from packets.
> > + */
> > +int fetch_object_info(enum protocol_version version, struct object_inf=
o_args *args,
> > +                   struct packet_reader *reader, struct object_info *o=
bject_info_data,
> > +                   int stateless_rpc, int fd_out);
> > +
> > +#endif /* FETCH_OBJECT_INFO_H */
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index cdebd3476f..a86c93fc52 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1742,6 +1742,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_=
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
> > index 6d0dec7f41..5a428f11ed 100644
> > --- a/fetch-pack.h
> > +++ b/fetch-pack.h
> > @@ -16,6 +16,7 @@ struct fetch_pack_args {
> >       const struct string_list *deepen_not;
> >       struct list_objects_filter_options filter_options;
> >       const struct string_list *server_options;
> > +     struct object_info *object_info_data;
> >
> >       /*
> >        * If not NULL, during packfile negotiation, fetch-pack will send=
 "have"
> > @@ -43,6 +44,7 @@ struct fetch_pack_args {
> >       unsigned reject_shallow_remote:1;
> >       unsigned deepen:1;
> >       unsigned refetch:1;
> > +     unsigned object_info:1;
> >
> >       /*
> >        * Indicate that the remote of this request is a promisor remote.=
 The
> > diff --git a/meson.build b/meson.build
> > index 3247697f74..145c6882eb 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -347,6 +347,7 @@ libgit_sources =3D [
> >    'exec-cmd.c',
> >    'fetch-negotiator.c',
> >    'fetch-pack.c',
> > +  'fetch-object-info.c',
> >    'fmt-merge-msg.c',
> >    'fsck.c',
> >    'fsmonitor.c',
> > diff --git a/transport-helper.c b/transport-helper.c
> > index f195070788..c77599f6fb 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -727,8 +727,8 @@ static int fetch_refs(struct transport *transport,
> >
> >       /*
> >        * If we reach here, then the server, the client, and/or the tran=
sport
> > -      * helper does not support protocol v2. --negotiate-only requires
> > -      * protocol v2.
> > +      * helper does not support protocol v2. --negotiate-only and cat-=
file
> > +      * remote-object-info require protocol v2.
>
> This is not really true as of this commit. This only comes into effect
> in the next commit. So shouldn't this be added there? That said, I would
> modify this to only talk about object-info requiring v2 and drop the
> reference to cat-file.

Agreed, I will do that, thanks.

>
> >        */
> >       if (data->transport_options.acked_commits) {
> >               warning(_("--negotiate-only requires protocol v2"));
> > @@ -744,6 +744,13 @@ static int fetch_refs(struct transport *transport,
> >               free_refs(dummy);
> >       }
> >
> > +     /* fail the command explicitly to avoid further commands input. *=
/
> > +     if (transport->smart_options->object_info)
> > +             die(_("remote-object-info requires protocol v2"));
> > +
> > +     if (!data->get_refs_list_called)
> > +             get_refs_list_using_list(transport, 0);
> > +
>
> Don't we already do this right above? Why is this needed again?

True, I'll drop the second `if`.

>
> >       count =3D 0;
> >       for (i =3D 0; i < nr_heads; i++)
> >               if (!(to_fetch[i]->status & REF_STATUS_UPTODATE))
> > diff --git a/transport.c b/transport.c
> > index 0f5ec30247..7d3246e12b 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -9,6 +9,7 @@
> >  #include "hook.h"
> >  #include "pkt-line.h"
> >  #include "fetch-pack.h"
> > +#include "fetch-object-info.h"
> >  #include "remote.h"
> >  #include "connect.h"
> >  #include "send-pack.h"
> > @@ -467,8 +468,33 @@ static int fetch_refs_via_pack(struct transport *t=
ransport,
> >       args.negotiation_restrict_tips =3D data->options.negotiation_rest=
rict_tips;
> >       args.negotiation_include_tips =3D data->options.negotiation_inclu=
de_tips;
> >       args.reject_shallow_remote =3D transport->smart_options->reject_s=
hallow;
> > +     args.object_info =3D transport->smart_options->object_info;
> > +
>
> Hmm, so we piggy-back on top of the `fetch_refs_via_pack()` function...
>
> > +     if (transport->smart_options->object_info
> > +         && transport->smart_options->object_info_oids->nr > 0) {
> > +             struct packet_reader reader;
> > +             struct object_info_args obj_info_args =3D { 0 };
> > +
> > +             obj_info_args.server_options =3D transport->server_option=
s;
> > +             obj_info_args.oids =3D transport->smart_options->object_i=
nfo_oids;
> > +             obj_info_args.object_info_options =3D transport->smart_op=
tions->object_info_options;
> > +             string_list_sort(obj_info_args.object_info_options);
> > +
> > +             connect_setup(transport, 0);
> > +             packet_reader_init(&reader, data->fd[0], NULL, 0,
> > +                             PACKET_READ_CHOMP_NEWLINE |
> > +                             PACKET_READ_GENTLE_ON_EOF |
> > +                             PACKET_READ_DIE_ON_ERR_PACKET);
> > +
> > +             data->version =3D discover_version(&reader);
> > +             transport->hash_algo =3D reader.hash_algo;
> > +
> > +             ret =3D fetch_object_info(data->version, &obj_info_args, =
&reader,
> > +                                     data->options.object_info_data, t=
ransport->stateless_rpc,
> > +                                     data->fd[1]);
> > +             goto cleanup;
> >
>
> ... and we jump to exit when we only want object info information. This
> skips the call to fetch_pack(). I'm a bit uneasy with this. Ideally we
> should be adding a new function to the vtable to only fetch object info.
> While this works, this doesn't fit the contract of what this function is
> supposed to do. See the comment around `fetch_refs` in `struct
> transport_vtable`. Shouldn't we update that documentation at the very
> least?

Now that you point that out, piggy-backing doesn't look very good,
while it works, updating the documentation leaves this in a bad
situation, so I will move it to a new function and add it to the
vtable for the next version. Thanks for noticing it.

>
> > -     if (!data->finished_handshake) {
> > +     } else if (!data->finished_handshake) {
> >               int i;
> >               int must_list_refs =3D 0;
> >               for (i =3D 0; i < nr_heads; i++) {
> > diff --git a/transport.h b/transport.h
> > index 7e5867cffa..bd60b10af4 100644
> > --- a/transport.h
> > +++ b/transport.h
> > @@ -6,6 +6,7 @@
> >  #include "list-objects-filter-options.h"
> >  #include "string-list.h"
> >  #include "connect.h"
> > +#include "odb.h"
> >
> >  struct git_transport_options {
> >       unsigned thin : 1;
> > @@ -31,6 +32,12 @@ struct git_transport_options {
> >        */
> >       unsigned connectivity_checked:1;
> >
> > +     /*
> > +      * Transport will attempt to retrieve only object-info.
> > +      * If object-info is not supported, the operation will error and =
exit.
> > +      */
> > +     unsigned object_info : 1;
> > +
>
> According to our style, this should be `unsigned object_info:1`.

I'll fix it to properly follow the style, I kept it like this because
other bit fields on these files seem to be outdated in that style.

>
> >       int depth;
> >       const char *deepen_since;
> >       const struct string_list *deepen_not;
> > @@ -55,6 +62,10 @@ struct git_transport_options {
> >        * common commits to this oidset instead of fetching any packfile=
s.
> >        */
> >       struct oidset *acked_commits;
> > +
> > +     struct oid_array *object_info_oids;
> > +     struct object_info *object_info_data;
> > +     struct string_list *object_info_options;
> >  };
> >
> >  enum transport_family {
> >
> > --
> > 2.54.0
>
> Nit: I do think the commit message doesn't sufficiently capture the
> entirety of this patch. We do not talk about:
>
> 1. How we piggy-back on top of `fetch_refs_via_pack()` and don't
> introduce our own pointer in the vtable.
> 2. The changes made to 'transport-helper.c' and why that is required.
> 3. How we don't error out when there is no size value provided for an
> OID and what the implication of this is.

I will extend the commit message to include all 3 points (I'll change
the piggy-backing to have its own function).

Thanks for the review,
Pablo.
