Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946B5C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 00:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C9F64E54
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 00:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhBIAUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 19:20:53 -0500
Received: from mail.archlinux.org ([95.216.189.61]:53432 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBIAUv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 19:20:51 -0500
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1612830008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+/tMslJWUQqkMQFXCb/aoLT3IDMBEKyWq+n7y4rRhOQ=;
        b=IP9w1RucxwjJgg4Tsuowfrt+hLh750lVmjVO7oqp9LvYCrNhuUXKg9V7AKhp0wJDnce/AM
        N7rwzPtXVzNwGevKTL+AqcR6QjSfGd2x3aiqQsyj/bYDQKXz7uz29yeYTxyFIdg/jwaVBB
        lcd4REC1bZG/zkcMHwu/gj9hlELhqWGgklboPqjjP2ORxp1n0CPNnk1sCP1WSzfSVIxZH+
        UZTGPcNUlXB4XHMY6ge6mxj1C0eUEwBFv7dbhZB3mh72W3oL0aBYEWx4UK5rtNPTShdU/+
        Ld78PSbepuKO8lRkCiit6UF8KAbMtAECmBY1gz/CM3ZmruG2XnNcHWQiJVFUC4jgUX98bt
        qAfBu/d/DqWwy2Kto9UuWC+EBO6Xiqq9eJvMXJnN/dWME72sGP2yO7wCnkRPX3+BhErqML
        k0fawmrhhkCifpCsp8YiueW6jjVxuSivBv5thESAAwSMEpFHv7qq7QHF4owTovRd5lwYYg
        Vs55yP5kFsf8YNCiaMXX/XZEkbL2OkQPF/5xGGrW8f2m+zOt/9av8NdTqWnED7I2xj8mQw
        ojXBWp2BCw6RPZW2ZJk6XXoTqN2pwCbC2L2U7jZbrK7BntyxFpZ6Atr/oQO6zKERtllTDi
        KJb0EFlQp/WOhZm31TcPLkXOy1U0bji9m3YUeKdPxWX6SG3B4Yoo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1612830008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+/tMslJWUQqkMQFXCb/aoLT3IDMBEKyWq+n7y4rRhOQ=;
        b=4bK195B8Nx9l0G+D9b54Rhj9FCHv2MDyvbXFniL4nrImiLWjZSgQairFbaP62Nww5rKemW
        cHGjDAp42i2LiWBg==
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <ac1288b8-5cdf-8e1e-702a-815c5fbc2da3@web.de>
From:   Eli Schwartz <eschwartz@archlinux.org>
Subject: Re: gitattributes export-subst and software versioning
X-Clacks-Overhead:  GNU Terry Pratchett
Message-ID: <4f65f02c-1d16-aa2c-3e7b-28d807b9ebe9@archlinux.org>
Date:   Mon, 8 Feb 2021 19:19:59 -0500
MIME-Version: 1.0
In-Reply-To: <ac1288b8-5cdf-8e1e-702a-815c5fbc2da3@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1HhEHLOlyGCCXZ9xN1lpHvY3xQzHR2Ubq"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1HhEHLOlyGCCXZ9xN1lpHvY3xQzHR2Ubq
Content-Type: multipart/mixed; boundary="0LqOZhCVydUpUsv101x31qWWZWPZHVvl3";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Message-ID: <4f65f02c-1d16-aa2c-3e7b-28d807b9ebe9@archlinux.org>
Subject: Re: gitattributes export-subst and software versioning
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <ac1288b8-5cdf-8e1e-702a-815c5fbc2da3@web.de>
In-Reply-To: <ac1288b8-5cdf-8e1e-702a-815c5fbc2da3@web.de>

--0LqOZhCVydUpUsv101x31qWWZWPZHVvl3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable

On 2/8/21 2:46 PM, Ren=C3=A9 Scharfe wrote:
> git archive uses the pretty format code for export-subst.  It is used b=
y
> git log and others as well.  git describe uses all object flags to find=

> the best description.  Simply plugging it into the pretty format code
> would clash with the object flag use of git log.

Yeah, I was afraid there might be bad interactions with a pretty
archive-centric placeholder and something that isn't git-archive.

On the other hand, with my zero knowledge of the code but having read
lots of man pages... %S documents that it "only works with git log", so
maybe it is possible to add an option that is documented to only work
for git archive?

e.g. if you do use it,

$ cat VERSION
$Format:%d$
$Format:%S$

$ git archive HEAD | bsdtar -xOf - VERSION
 (HEAD -> master, tag: 1.0)
%S

It's apparently completely ignored and treated as raw characters. The
same restriction could theoretically be added in the other direction for
a new placeholder.

This would neatly resolve Junio's concern about the resource-intensive
nature of "describe" not being a good fit for "log".

> And replacing the flags with a commit slab doesn't seem to be enough,
> either -- I get good results lots of commits, but for some git log with=

> the new placeholder would just show some nonsensical output, as it
> seems to get the depth calculation wrong for them somehow.

You mean git describe <commit> produces wrong results for those?

> Anyway, we can of course do something like in the patch below.  It
> works, it's easy, it's fast enough for git archive, and it's quite
> hideous.  Hopefully it's bad enough to motivate someone to come up with=

> a cleaner, faster solution.

:D :D an important part of the resolution process, to be sure.

> ---
>  pretty.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/pretty.c b/pretty.c
> index 3922f6f9f2..bbfb5ca3e7 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -12,6 +12,7 @@
>  #include "reflog-walk.h"
>  #include "gpg-interface.h"
>  #include "trailer.h"
> +#include "run-command.h"
>=20
>  static char *user_format;
>  static struct cmt_fmt_map {
> @@ -1213,6 +1214,21 @@ static size_t format_commit_one(struct strbuf *s=
b, /* in UTF-8 */
>  		return parse_padding_placeholder(placeholder, c);
>  	}
>=20
> +	if (skip_prefix(placeholder, "(describe)", &arg)) {
> +		struct child_process cmd =3D CHILD_PROCESS_INIT;
> +		struct strbuf out =3D STRBUF_INIT;
> +
> +		cmd.git_cmd =3D 1;
> +		strvec_push(&cmd.args, "describe");
> +		strvec_push(&cmd.args, "--always");
> +		strvec_push(&cmd.args, oid_to_hex(&commit->object.oid));
> +		pipe_command(&cmd, NULL, 0, &out, 0, NULL, 0);
> +		strbuf_rtrim(&out);
> +		strbuf_addbuf(sb, &out);
> +		strbuf_release(&out);
> +		return arg - placeholder;
> +	}
> +
>  	/* these depend on the commit */
>  	if (!commit->object.parsed)
>  		parse_object(the_repository, &commit->object.oid);
> --
> 2.30.0
>=20


--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User


--0LqOZhCVydUpUsv101x31qWWZWPZHVvl3--

--1HhEHLOlyGCCXZ9xN1lpHvY3xQzHR2Ubq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmAh1S8ACgkQzrFn77Vy
K9ag/RAA4Iui9ftiSEUgRM4R876zhJxVjshEKNRo+u/F7QBZAS+f0VasmnCCryNZ
wi1ynyiO4T1i32akqMeEoNFNp/YvQieQqrWwY9cScwSci+iWnkIh0GhbD1TVdmGJ
9WfrvRR+E1HChds7l87VSh4Kz0bIN95eQCnLgWdDOEdOgp9eQXfz28L8MaNYpc/L
atywWhZ37p9+uECMb9i6oVNPzZkhnK/sPpVWo9+ZnHYFpgWWo8/iFaq05uCkCJCE
OlkZdUXAuixAFUzk2tBe+iFQiIj06N19y8+mayRnAnCgXjWwPmf4v4FS4WJb5Gwx
9VBov4usGkanTzfaDKxk3gO0unLGbZH8v8peRWfayzUM9etdVa7Ik0JzhV+I3Q7m
gNgra07ut6ul0xSFlHBXRnhdjZJw8f0PQBYdxEsORmaUTyGd5FWqeewtvwqRe7sX
VgFFRt3/WPte1EMR4s/neCy+nJy2gVvY3NKUnwfgQjaZqsOPv+YZWYS0Idjr9m5c
HZ6ASVOQDRv9Jvqo2/NfDqjYBkSmEcd+WOpjArmUim0YGxNJVlXaaVfFkdUvYAQ9
fmEGUITSwS9NQNL7Qlt7XXnawO02ZE+36KFakbHQ+/orzN0p9gdUgcrN3VvJKhhL
OGerFUnQ8ElHv78kxxxdZ1KyJUROBcVjgaW8dw1Fnu+/zASqfeQ=
=Yn0F
-----END PGP SIGNATURE-----

--1HhEHLOlyGCCXZ9xN1lpHvY3xQzHR2Ubq--
