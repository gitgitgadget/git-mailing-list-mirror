Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A11C433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 20:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiBIUmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 15:42:02 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiBIUmC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 15:42:02 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55096DF49885
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 12:42:04 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id iy10-20020a17090b16ca00b001b8a7ed5b2cso4540418pjb.7
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 12:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Q7vZXsIc+gJRXy0z4magoKir2aPzFUKpdxbaiaAQLG4=;
        b=KX7Gp8l02RT2F0+w5pQJ6suYdAGEFCP2P6M5FhlRW4W0bPOuidlJdw+9lwQheM2Qbv
         3xNUaWrxChyrX3T+H5yG1xIZV5xID3K6JVUdmhLOIlbunjGG4XCE6zOB/+fWWEd5M38t
         ZNbGLJUlILJ9a6pgMpSBHpfM7fpU3qaurNP4DzXYijmjUbntOXQzNcO63k3ehWSxaT/8
         aOB9rCP+WaVKN7dXCPpGJWZeyypjgONShWSzjo0C+iEWwLQfKpHW37LeVUtc5/gE5+dp
         qVyxjp8/86Is+I2NWnnk24bQaCwarDcsvJv/oBxn/dJO6oa6etujVe27MJot5KY8/pPv
         JT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=Q7vZXsIc+gJRXy0z4magoKir2aPzFUKpdxbaiaAQLG4=;
        b=AzLP4owPwYipyNJ05/8ffQUhauWsPUYjeYaXx9mYoATB3sHP8FHOuDaWnOLSNkcpGp
         KMv2hu+UR/YN8VZ84s3OhgWKY4CXRs4p7IKwv21PTHRukQeJb04EKGCt7nCx+eGsAf64
         /vnQyt5kKy3UC29zdlQxxsH9R/jbcyWANPMr4xJHNGJwJxQ75y1Menw6o5w3L/9I4dA/
         +URsz/E4n7bPlZuFBjg+a2xvAlV/fmRxiqOhNTp4il4GEudo+r0dcAxbj6ruK4nesxjG
         mOY7mYy0S2DAw4JkLxejKzrwFvGW21LYc9A9FqU80eE1uYQrNzdEHQ+ClZwwI2EqX85z
         FgDA==
X-Gm-Message-State: AOAM531TAy0F8ce6FfVd9Q7zV36g4TojM/IWYrNAyqhLGMMqM+WCsV2V
        J3F/s9k6xyr05BKEDBeeE7EOOMS0ZV67228aYSEW
X-Google-Smtp-Source: ABdhPJz8s1DnGlP/6npXDVuOkBFELtsbtMbi2D7vBvjlKWgni5+rAvBYm9no/Gi+7NPYI/KyTJyUGKEpyTxzAdP9Vn7e
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:de01:: with SMTP id
 m1mr5380524pjv.215.1644439323805; Wed, 09 Feb 2022 12:42:03 -0800 (PST)
Date:   Wed,  9 Feb 2022 12:41:53 -0800
In-Reply-To: <20220208235631.732466-1-calvinwan@google.com>
Message-Id: <20220209204153.481122-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: Re: [PATCH v2] fetch object-info-format: client option for object-info
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> Add =E2=80=98=E2=80=94object-info-format=E2=80=99 option to fetch. This o=
ption allows
> the client to make an object-info [1] command request to a server
> that supports protocol v2.

Avoid using characters above 127 in commit messages (unless, say, as part o=
f
someone's name). They make it hard to search for, and in this case, whateve=
r
dash is there is wrong (it should be "--").

> The transport implementation uses vtables [2], similar to how Git
> fetches refs,

You should be explicit that you're adding a new function to the vtable.
(Whether that is what we should do is another issue: let me look at the
patch to see.)

> to determine whether a process needs to be taken over
> before sending the object-info request.=20

The vtable is not to determine whether a process needs to be taken over,
but so that we support multiple protocols (HTTP, SSH, etc.). In any
case, this detail is probably not relevant.

> Different protocols
> require different setups for making requests.

This is true, but I don't see the relevance.

> [1] https://lore.kernel.org/git/20210420233830.2181153-1-bga@google.com/
> [2] https://lore.kernel.org/git/26f276956001a120cc9105b0071762c2fd4a45c5.=
15=3D
> 13287544.git.jonathantanmy@google.com/

For merged code, quote the commit, not the email.

> @@ -220,6 +225,8 @@ static struct option builtin_fetch_options[] =3D {
>  		 N_("write the commit-graph after fetching")),
>  	OPT_BOOL(0, "stdin", &stdin_refspecs,
>  		 N_("accept refspecs from stdin")),
> +	OPT_STRING_LIST(0, "object-info-format", &object_info_format, N_("optio=
n"),
> +		 N_("command request arguments")),

I would have expected a parameter named "format" to take a format
string, but taking a string list of the fields we need might work too.
In any case, maybe rename it to "--object-info" or similar.

> @@ -2000,6 +2007,8 @@ int cmd_fetch(int argc, const char **argv, const ch=
ar *prefix)
>  	struct remote *remote =3D NULL;
>  	int result =3D 0;
>  	int prune_tags_ok =3D 1;
> +	struct oid_array oids =3D OID_ARRAY_INIT;
> +	struct object_id oid;

The "oids" at function level needs a more descriptive name (e.g.
"oids_for_object_info"). The name of "oid" is fine, since it's just used
as a temporary variable, but since it is temporary, it should be
declared in the block where it's used. (Same for "oids", actually:
declare it in the block it's used, and in that case you can keep the
name since it's more tightly scoped.)

> @@ -2057,6 +2066,23 @@ int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
>  	if (dry_run)
>  		write_fetch_head =3D 0;
> =20
> +	if (object_info_format.nr > 0) {
> +		if (argc =3D=3D 0 || argc =3D=3D 1) {
> +			die(_("must supply remote and object ids when using --object-info-for=
mat"));
> +		} else {
> +			remote =3D remote_get(argv[0]);
> +			for (i =3D 1; i < argc; i++) {
> +				if (get_oid(argv[i], &oid))
> +					return error(_("malformed object name '%s'"), argv[i]);
> +				oid_array_append(&oids, &oid);
> +			}
> +		}
> +		gtransport =3D prepare_transport(remote, 0);
> +		gtransport->server_options =3D &object_info_format;
> +		result =3D transport_fetch_object_info(gtransport, &oids);
> +		return result;
> +	}

I was thinking that this should reuse the refspec parsing mechanism
(which also supports stdin), but upon more thought, using the refspec
parser means that we would also need to check that all refspecs are
exact OIDs (because we wouldn't know what to do with them otherwise).
OK, parsing the objects by ourselves looks reasonable.

The assignment of object_info_format to server_options is probably not a
good idea, though, since readers of server_options would expect server
options, not what you're assigning. The best place to put this
information is in smart_options. (See the negotiate_only code.)

> +static void write_object_info_command_and_capabilities(struct strbuf *re=
q_buf,
> +						 const struct string_list *server_options)
> +{

[snip contents]

This code is very similar to code in fetch-pack.c. If you stick to
crafting the request in builtin/fetch.c, you should refactor
fetch-pack.{c,h} to expose this functionality (in a preparatory commit)
and then use that function from here.

> +void send_object_info_request(int fd_out, struct object_info_args *args)
> +{
> +	struct strbuf req_buf =3D STRBUF_INIT;
> +	int i;
> +
> +	write_object_info_command_and_capabilities(&req_buf, args->server_optio=
ns);
> +
> +	if (string_list_has_string(args->server_options, "size"))
> +		packet_buf_write(&req_buf, "size");

What happens if "size" is not in the list?

> +		printf "%s %d\n" "$object_id" "$length" >expect &&

You can just write "echo $object_id $length >expect". Also, test the
following:
 - more than one OID
 - an OID that's not on the remote
 - a malformed OID
 - a server that doesn't support protocol v2
 - a server that supports protocol v2 but not object-format

(You don't have to do this for all protocols; just pick one. I prefer
HTTP, since that's the most complex.)

Other than that, the tests look good. Thanks for testing the different
protocols.

> @@ -1269,6 +1280,7 @@ static struct transport_vtable vtable =3D {
>  	.get_refs_list	=3D get_refs_list,
>  	.fetch_refs	=3D fetch_refs,
>  	.push_refs	=3D push_refs,
> +	.fetch_object_info =3D fetch_object_info,
>  	.connect	=3D connect_helper,
>  	.disconnect	=3D release_helper
>  };

Adding a function to the transport vtable is not so disruptive since we
don't have many transport vtables, but better if we can avoid this
disruption. In this case, I think it's better to reuse fetch_refs.
Mainly, the plumbing from transport_fetch_refs() to all the helper
functions in fetch-pack.c already exists, so reusing fetch_refs would
allow us to reuse that plumbing.

This also means that we don't have to expose the protocol functionality
in fetch-pack.c that you copied over to builtin/fetch.c in this patch,
which is an added bonus.

> +static int fetch_object_info(struct transport *transport, struct oid_arr=
ay *oids)
> +{

[snip contents]

And reusing the plumbing might mean that we don't need this function
too.

Taking a step back, there also needs to be a fallback mechanism for when
the server doesn't support object-info.

If you generally agree with my review comments, I would say that your
next steps are:
 - investigate if we can reuse the transport_fetch_pack -> fetch-pack.c
   machinery
 - make a fallback for when the server doesn't support object-info
   (might be easier when we use the machinery, so I would start with
   that first)
