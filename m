Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795274145;
	b=fpyR/Ywg9Ia2gMwvyHJFC41djo/6Hx7a7VgHmNZvOrO9Cr+HCAwP22wCHLeEkbhV1IFJ
	 +PFUa4V/IYm10/aXVxayuhlIZSSJoQzFHhPaVWUl27EHWlyKhClH4lMb5MY1zw7H9DEpz
	 4u6M2FpPXrPBj/2R5yycc+SGlIXNZcH8QspBdWkVrdjqDm/JoUaVuF3G221KT8MgNyV7H
	 Ptdmw86lvahmMdn7f478jzHSxED4kNxccdhJzOsWE6RrgmSYgK5hNrRQh1u8cJSMSg2iM
	 pjI9Q7ohaRaRojcbT+Va9TrqfqVRO80yUMSk2Ud6flyUOVAVWuP6wxjUXi2+huVBmpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795274145;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=RyP8D4obdrz0gz7rQLbqfbPb7cumxstXXFrC+KDurhk=;
	b=RlvQ+GG6ys/mVJSh93Aq2ide7NXE9oANKCbrmQWXHxMs4T/NBvzPGL5kJnb4Xi4Bmwdo
	 6F4XbZOmsvkKfUgroTwt06eidXQG02O6cKpJQXU0LRLJpDlI+DBluHFwVPvSnzW/Q80l6
	 gaGDixEa1iHZ8DgM+zQDIXbWha6g7fXLsBaNyzY01nQTuB2l6/eid9daVKQA4Ng9rtwDi
	 C6iYESVGTsyXwvOFsunb6uvr5mts1BNke2a8ilUQbaf2ft+NDPK8Boi83A80YFT5Q4ncJ
	 X1k54rfBup5qT12Fu3hLTQBFoIjnTQdGJsmsJ7WUTuYtjRGgfuCBBg154tbgQkRCkaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=lRqCamFw;
	arc=none smtp.remote-ip=212.227.15.4
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7DC606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 15:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE7DC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=lRqCamFw
DKIM2-Signature:  i=1; m=1; t=1795274136;
 mf=PGwucy5yQHdlYi5kZT4=;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:fsFlTcPyETyCd/YptBB3LV3DdJDi
   WpKDh3i0whug0NBR3aR9G2Oypeowbr7g/YKfWB23OlkjdEjZBCt4oBAVl5tFtd9PuQzStuTtm8f
   huqYnq7T5OcjwG7yexht0ElmXLVgwYgxaKk3M/fCNKjjEEOu1LXclL6IM2BUT0zW8aqiuFrDj+o
   8Bwv5310mRCpicDHjSOEEzZLoCKDOCmCB8bA8KsI9tPbtq/1OkwzCo47/qnMzGTsEboG+khcz7q
   Sd5huV7rGY/BNvNSTkQRH7RUCfrxCrivsTg93QJOdDrQODgs9WJ45bL7GQ4XJvmIC8S0wWnNvZY
   AGRNAJ5Kx76EQg==;
Message-Instance:  m=1;
 h=sha256:
   EAfJoMDfShLrQi/TadYMbDQanT29e8oPeBs7vpo6ukM=:
   k/8sslsEO8T03jk817M8UV++WFsP7OKZ/uoseieZMpM=,
  sha512:
   HHrJxsAiRXVVJ7QHO8JCOfVBVJoJG+xRo3h0gjjD8YpIIBGMlYXzOv97VOwamP3BIuCA7z5/M9Kza4hzVv/OVQ==:
   hYhNVGCAIGV0FSitEzeic1MkXc6MVaOJh3zmTQbyB7+IhTUA92/bf1Ijw1tPrjwHDjfkLDcZUqVFGxc74DSBiA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795274130; x=1795878930; i=l.s.r@web.de;
	bh=RyP8D4obdrz0gz7rQLbqfbPb7cumxstXXFrC+KDurhk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lRqCamFwY8wPED9yJZxSMUIuu7W769YGRpQKCVRuW37ieuJqiyoezfzLWYVV3/sd
	 AylCS1z8uiQATEWIumpvKlj/W/6VBbGWl9bSJJKiVbv3cUw5HOfNwlvciqxgYNYz4
	 quUCocOEncemD/Ky5fHMb1G8vosiqEvG2n2iBk8TH6PJE5OlhJOY30tzxfwdI2Rxn
	 Eo2hvQhZDb125u+aKlRwhTX8wEhdfjWDHDpMUtRtNl3cuq4jERS1lPaVvO2fsxMqs
	 VYILaYYwr76aQL8Rxg+BcM+v7JlSkf1V2w4vOn4GHQirwd7HaTwiPmF4kIDNIJ0aN
	 PmtxdtKNxI47ThMvhw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqZMK-1yGzfW2V16-00ctXZ; Sat, 21
 Nov 2026 16:15:30 +0100
Message-ID: <389c4ebc-7c4e-4ded-a620-b6a63e3911a3@web.de>
Date: Sat, 21 Nov 2026 16:15:29 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] archive: reject remote --add-file in callback
To: Dominik Maier <dmnk@google.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Johannes Sixt <j6t@kdbg.org>, =?UTF-8?Q?Jean-No=C3=ABl_Avila?=
 <jn.avila@free.fr>, dmnk+artist@google.com
References: <20261119192311.2685319-1-dmnk@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20261119192311.2685319-1-dmnk@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zqwjjtjQ84sChHkNl3U8VIXMTBmZnG5rb1k+N1eA5rCpeM1uoNI
 yofYgVjYAQWO/1FF8Q6vynyTpV/z12Wn71Qh3V6UlQJwbzRjF3d4YUmUcMdjByjh9wYRnN8
 SOhvo8QgYO5wA4KM1cybPYisdunPMy45jY4SdLEHguvrMmGqj98XWcuADtglLfNhnRA3wJu
 QQsgdsYDUZUWyUgupItgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wmkp4DrUfFM=;xjVq9Ivpato7R+ixH7A+qNyz6vh
 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
 ZvTmpa+2pI3AmFCkugXn9o=

On 11/19/26 8:23 PM, Dominik Maier wrote:
> parse_archive_args() only checks "is_remote && args->extra_files.nr"
> after parse_options() returns. When git-upload-archive parses client
> arguments, add_file_cb() runs first and calls stat() on the requested
> path on the server filesystem, reporting "File not found" or "Not a
> regular file" before the "--remote" incompatibility check is reached
> (and succeeding altogether if "--no-add-file" follows).

Ugh, good find.

> Pass is_remote into add_file_cb() and reject "--add-file" and
> "--add-virtual-file" immediately before touching the filesystem.

The current code rejects the combination of --add-virtual-file and
=2D-remote, but that's arguably also a bug -- there's no reason to
disallow it, since the option's value brings file name and content
to the remote end.

> Signed-off-by: Dominik Maier <dmnk@google.com>
> ---
>  archive.c           | 31 ++++++++++++++++++++++---------
>  t/t5000-tar-tree.sh |  9 +++++++++
>  2 files changed, 31 insertions(+), 9 deletions(-)
>=20
> diff --git a/archive.c b/archive.c
> index 59790be986..b983209ce4 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -559,15 +559,27 @@ static void extra_file_info_clear(void *util, cons=
t char *str UNUSED)
>  	free(info);
>  }
> =20
> +struct add_file_data {
> +	struct archiver_args *args;
> +	const char **basep;
> +	int is_remote;
> +};
> +
>  static int add_file_cb(const struct option *opt, const char *arg, int u=
nset)
>  {
> -	struct archiver_args *args =3D opt->value;
> -	const char **basep =3D (const char **)opt->defval;
> -	const char *base =3D *basep;
> +	struct add_file_data *data =3D opt->value;
> +	struct archiver_args *args =3D data->args;
> +	const char *base =3D *data->basep;
>  	char *path;
>  	struct string_list_item *item;
>  	struct extra_file_info *info;
> =20
> +	if (data->is_remote)
> +		die(_("options '%s' and '%s' cannot be used together"),
> +		    !strcmp(opt->long_name, "add-virtual-file") ?
> +		    "--add-virtual-file" : "--add-file",
> +		    "--remote");

That also rejects --remote --add-file=3Dfoo --no-add-file, which we could
allow.

> +
>  	if (unset) {
>  		string_list_clear_func(&args->extra_files,
>  				       extra_file_info_clear);
> @@ -645,6 +657,11 @@ static int parse_archive_args(int argc, const char =
**argv,
>  	int i;
>  	int list =3D 0;
>  	int worktree_attributes =3D 0;
> +	struct add_file_data add_file_data =3D {
> +		.args =3D args,
> +		.basep =3D &base,
> +		.is_remote =3D is_remote,
> +	};
>  	struct option opts[] =3D {
>  		OPT_GROUP(""),
>  		OPT_STRING(0, "format", &format, N_("fmt"), N_("archive format")),
> @@ -653,20 +670,18 @@ static int parse_archive_args(int argc, const char=
 **argv,
>  		{
>  			.type =3D OPTION_CALLBACK,
>  			.long_name =3D "add-file",
> -			.value =3D args,
> +			.value =3D &add_file_data,
>  			.argh =3D N_("file"),
>  			.help =3D N_("add untracked file to archive"),
>  			.callback =3D add_file_cb,
> -			.defval =3D (intptr_t) &base,
>  		},
>  		{
>  			.type =3D OPTION_CALLBACK,
>  			.long_name =3D "add-virtual-file",
> -			.value =3D args,
> +			.value =3D &add_file_data,
>  			.argh =3D N_("path:content"),
>  			.help =3D N_("add untracked file to archive"),
>  			.callback =3D add_file_cb,
> -			.defval =3D (intptr_t) &base,
>  		},
>  		OPT_STRING('o', "output", &output, N_("file"),
>  			N_("write the archive to this file")),
> @@ -702,8 +717,6 @@ static int parse_archive_args(int argc, const char *=
*argv,
>  		die(_("the option '%s' requires '%s'"), "--exec", "--remote");
>  	if (output)
>  		die(_("Unexpected option --output"));
> -	if (is_remote && args->extra_files.nr)
> -		die(_("options '%s' and '%s' cannot be used together"), "--add-file",=
 "--remote");

How about moving the stat(2) call here instead?  It would still happen
before we start writing archive content, but after applying any
=2D-no-add-file.  We can refuse to do it if is_remote is set.  The files
added using --add-file have content =3D=3D NULL.

> =20
>  	if (!base)
>  		base =3D "";
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 3ad600c793..930a9fcb29 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -237,6 +237,15 @@ check_tar with_untracked2
>  check_added with_untracked2 untracked one/untracked
>  check_added with_untracked2 untracked two/untracked
> =20
> +test_expect_success 'git archive --remote rejects --add-file before sta=
t' '
> +	test_must_fail git archive --remote=3D. --add-file=3Dno-such-file HEAD=
 2>err &&
> +	test_grep "cannot be used together" err &&
> +	test_grep ! "File not found" err &&
> +	echo untracked >untracked &&
> +	test_must_fail git archive --remote=3D. --add-file=3Duntracked --no-ad=
d-file HEAD 2>err &&
> +	test_grep "cannot be used together" err
> +'
> +
>  test_expect_success 'git archive on large files' '
>  	test_config core.bigfilethreshold 1 &&
>  	git archive HEAD >b3.tar &&

