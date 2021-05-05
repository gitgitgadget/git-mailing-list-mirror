Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF6EC433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 04:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCB5613D6
	for <git@archiver.kernel.org>; Wed,  5 May 2021 04:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhEEENN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 00:13:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60448 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhEEENM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 00:13:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AEBAE127D99;
        Wed,  5 May 2021 00:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yJu1IliVSnWp
        LmbO1feCkBN9IiQMWnKjTIJx+n9Q8R4=; b=cUgGztWLTm5buNL8l4Z3KiIp0dPu
        a62lztZmo2AWnm1EQB2traoGDANHs7TiKoFVEum18CvLPr0FKm83VviCLU6E36Ll
        6H4WxgfTmAbRYTYAiYWqusvySqMpTeDsdHkjYV2VinGvu4fRuRgf1hBfcLmDXvYx
        lY8ntFZI8tyKjrI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A89B1127D97;
        Wed,  5 May 2021 00:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E101C127D96;
        Wed,  5 May 2021 00:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 3/5] mailinfo: skip quoted CR on user's wish
References: <20210421013404.17383-1-congdanhqx@gmail.com>
        <cover.1620148732.git.congdanhqx@gmail.com>
        <3215ea95cf869c8495d95cfd774973c330c14d1d.1620148732.git.congdanhqx@gmail.com>
Date:   Wed, 05 May 2021 13:12:12 +0900
In-Reply-To: <3215ea95cf869c8495d95cfd774973c330c14d1d.1620148732.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Wed, 5 May
 2021 00:20:00 +0700")
Message-ID: <xmqqeeel4y5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1238D56A-AD58-11EB-A46C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Subject: Re: [PATCH v2 3/5] mailinfo: skip quoted CR on user's wish

Nothing wrong per-se, but "on user's wish" feel somewhat bizarre.
Perhaps

    mailinfo: allow skipping quoted CR

or something along that line?

> In previous change, we've turned on warning for quoted CR in base64
> encoded email. Despite those warnings are usually helpful for our users=
,
> they may expect quoted CR in their emails.
>
> Let's give them an option to turn off the warning completely.
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---
>  Documentation/git-mailinfo.txt | 18 +++++++++++++++++-
>  builtin/mailinfo.c             |  8 ++++++--
>  mailinfo.c                     | 21 ++++++++++++++++++++-
>  mailinfo.h                     |  8 ++++++++
>  t/t5100-mailinfo.sh            |  6 ++++--
>  5 files changed, 55 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinf=
o.txt
> index d343f040f5..c776b27515 100644
> --- a/Documentation/git-mailinfo.txt
> +++ b/Documentation/git-mailinfo.txt
> @@ -9,7 +9,7 @@ git-mailinfo - Extracts patch and authorship from a sin=
gle e-mail message
>  SYNOPSIS
>  --------
>  [verse]
> -'git mailinfo' [-k|-b] [-u | --encoding=3D<encoding> | -n] [--[no-]sci=
ssors] <msg> <patch>
> +'git mailinfo' [-k|-b] [-u | --encoding=3D<encoding> | -n] [--[no-]sci=
ssors] [--quoted-cr=3D<action>] <msg> <patch>

This line is getting really crowded.  Perhaps it is time to do

	'git mailinfo' [<options>] <msg> <patch>

like other Git subcommands with too many options?  Certainly it can
be done after the dust settles from this entire series as a follow up
clean-up patch.

> @@ -89,6 +89,22 @@ This can be enabled by default with the configuratio=
n option mailinfo.scissors.
>  --no-scissors::
>  	Ignore scissors lines. Useful for overriding mailinfo.scissors settin=
gs.
> =20
> +--quoted-cr=3D<action>::
> +	Action when processes email messages sent with base64 or
> +	quoted-printable encoding, and the decoded lines end with CR-LF

s/with CR-LF/with a CRLF/

> +	instead of a simple LF.
> ++
> +The valid actions are:
> ++
> +--
> +*	`nowarn`: Git will do nothing with this action.

s/with this action./when such a CRLF is seen./ perhaps?

> +*	`warn`: Git will issue a warning for each message if such CR-LF is

s/such CR-LF/such a CRLF/

> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> index b309badce5..1d600263cb 100644
> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -9,7 +9,7 @@
>  #include "mailinfo.h"
> =20
>  static const char mailinfo_usage[] =3D
> -	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=3D<encod=
ing> | -n] [--scissors | --no-scissors] <msg> <patch> < mail >info";
> +	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=3D<encod=
ing> | -n] [--scissors | --no-scissors] [--quoted-cr=3D<action>] <msg> <p=
atch> < mail >info";

It is surprising that we haven't switched this to parse_options().
It of course is outside the scope of this series, but from a cursory
look of its option parsing loop, it looks like a trivial improvement
to make.

> @@ -43,7 +43,11 @@ int cmd_mailinfo(int argc, const char **argv, const =
char *prefix)
>  			mi.use_scissors =3D 0;
>  		else if (!strcmp(argv[1], "--no-inbody-headers"))
>  			mi.use_inbody_headers =3D 0;
> -		else
> +		else if (skip_prefix(argv[1], "--quoted-cr=3D", &str)) {
> +			mi.quoted_cr =3D mailinfo_parse_quoted_cr_action(str);
> +			if (mi.quoted_cr =3D=3D quoted_cr_invalid_action)
> +				usage(mailinfo_usage);

This is not all that helpful, given that mailinfo_usage[] only says
<action> without saying what the supported values are, and the
message does not make it clear it was issued while looking at the
--quoted-cr option.

At least, something like

			if (mi.quoted_cr =3D=3D quoted_cr_invalid_action)
                        	die("--quoted-cr=3D%s: invalid action", str);

would be more palatable, but I wonder if mailinfo_parse_quoted_cr_action(=
)
should have an option to die with the list of actions it knows about
in a message.

> diff --git a/mailinfo.c b/mailinfo.c
> index 713567f84b..fe7ffd01d0 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -1040,7 +1040,8 @@ static void handle_filter_flowed(struct mailinfo =
*mi, struct strbuf *line,
> =20
>  static void summarize_quoted_cr(struct mailinfo *mi, int have_quoted_c=
r)
>  {
> -	if (have_quoted_cr)
> +	if (have_quoted_cr
> +	    && mi->quoted_cr =3D=3D quoted_cr_warn)

Existing code in this file prefers to split a multi-line statement
after sequence point like &&, ||, etc., not before.

>  		warning("quoted CR detected");
>  }
> =20
> @@ -1221,9 +1222,19 @@ int mailinfo(struct mailinfo *mi, const char *ms=
g, const char *patch)
>  	return mi->input_error;
>  }
> =20
> +enum quoted_cr_action mailinfo_parse_quoted_cr_action(const char *acti=
on)
> +{
> +	if (!strcmp(action, "nowarn"))
> +		return quoted_cr_nowarn;
> +	else if (!strcmp(action, "warn"))
> +		return quoted_cr_warn;
> +	return quoted_cr_invalid_action;
> +}

OK.

>  static int git_mailinfo_config(const char *var, const char *value, voi=
d *mi_)
>  {
>  	struct mailinfo *mi =3D mi_;
> +	const char *str;
> =20
>  	if (!starts_with(var, "mailinfo."))
>  		return git_default_config(var, value, NULL);
> @@ -1231,6 +1242,13 @@ static int git_mailinfo_config(const char *var, =
const char *value, void *mi_)
>  		mi->use_scissors =3D git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "mailinfo.quotedcr")) {
> +		git_config_string(&str, var, value);
> +		mi->quoted_cr =3D mailinfo_parse_quoted_cr_action(str);
> +		if (mi->quoted_cr =3D=3D quoted_cr_invalid_action)
> +			die(_("bad action '%s' for '%s'"), str, var);
> +		free((void *)str);
> +	}

Here, it is more reasonable.  It still does not say what actions are
accepted, but at least the user learns where our displeasure comes
from.

>  	/* perhaps others here */
>  	return 0;
>  }
