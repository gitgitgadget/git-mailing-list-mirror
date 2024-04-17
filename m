Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9882853E08
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335660; cv=none; b=gGeGtMmBB1AKZ+G0I/4vTdCx3Nk6BM6DGS6NpEKYRG6lnaROUDJWsDS/b5dugu9LErLlSzNLabZ/Y707gYGQf31SV7KyCfSfrxRqztMqiyQpOPJtUQl9h55laST9loq9T8icAnhdxl13kR7OXwLg77XIhF9itnMIB2hKgT/6uco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335660; c=relaxed/simple;
	bh=YlnGnr8fLZIayJczwrKKQRiQiAWfhTmxvrJJIAgjm+8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=knfk0rpSeb7VaJ82hH+vj9eOiFIjBHKaGt8jU7Tz2k90/TIBr2l5ELz+eUUuc6yhwzlX+YV+2RrHO65xatt3s09BgEt4dVWHQV//V8lpyDLmq6nYbXP5TQJDNq0EKoKOHjVNJ2L9JdtuY0l6MSXzi90OkA9PWU9D/oOo3MQClPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=feihJj+c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RXl4Foes; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="feihJj+c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RXl4Foes"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9D3271380249;
	Wed, 17 Apr 2024 02:34:17 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 17 Apr 2024 02:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1713335657; x=1713422057; bh=7docnQ0TU17aXbKDkLI0p/dNYttyLred
	YH2dkoUuTi8=; b=feihJj+cj/NEg1/uc+SmY4eh3JNI+qCMAJwJz+FKJ/Vgm6Ob
	wEwRS9rWCIEix7jN+85l6dJgb2VGQ2oNM8Kp1f+8W6yL4OzMttKPTvQ+8vAsPPBi
	te3dCr56mkgORSUqRRFtgrFwOZYB/F2ylUPhZnnwhJPxEeQuazadACt23B/sEo0S
	/aRoriC+6rDxJF+KXvpO2JRjKEfSXSiDUJP/gdiZs2gVZoDucKX0C+VtPVwjkwrV
	oQGwsvO0ivS3NjnLxTpJCpnwLpM9rDgiNXlNyEr8rtkOgYJTIjEIdoARqNOngBCX
	mn27CyjKgVgk4xgAcLhGTvMM6HsCEk6L5bhWEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713335657; x=
	1713422057; bh=7docnQ0TU17aXbKDkLI0p/dNYttyLredYH2dkoUuTi8=; b=R
	Xl4Foespu94wMJibGMPHrzYPkwdPxhyceVyDQchA1uKMmY5rA6u0w8y/oyOumyD8
	781CuAZ55Tl/Lyi5XF4KqaQwwboZGyBF1vabKUEGtEcz7PVAHzHgZa3XlyoATQE/
	3S+sgaiUayUvfjvZCyCzWsjZLpav3Hea04xAiE+raZeD12lOaC0GDRncXn48uzAN
	aARCKy1C8EzXZhWiIeE3hNAEglrhr6MLh9EPInwz36rRqR28sB9/ag69By2DDIqu
	wdMwGegtT04Tp8/uPmtcIcMh2IBZzFls7gwIsJr3zhzARjnbOE4k7IRCgNiSfuiA
	T132wtdg2flmlXka1081A==
X-ME-Sender: <xms:aW0fZsgcfeFszlSNrvp1hAFfZ19HlOxOIfBaRpxokfwG8Qfexq0p_W0>
    <xme:aW0fZlANd6rkeHCKGOR55R_iLTQ82YtY6kOSRF5-eA5yCoN6wzYoI36EhdjWcSqvw
    k1T4uBl4BPyCHgOZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejjedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:aW0fZkHjxie2_cM-WzQT1TkwqsCzLEWo3JJdItDvTKVbDFwEE6L5Pg>
    <xmx:aW0fZtSUqsJj4Wwg5LQqh2vDuvfU7i-Kz-HB6jXG-GucLMjgFT8P0g>
    <xmx:aW0fZpyaC2wI_6R3lXaQQjC7AZl7BNekkdrBjrXK8vOJapUSDfrOCw>
    <xmx:aW0fZr6Yj748KoxIyIb3aR8fiv8NkCMmrenxh_nwJU-0vGIb5yfCdg>
    <xmx:aW0fZqrmZ1Q6Fm7HiKa9INpFglc3WD07WhPZodK4mConhokpAGubUq6L>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 56B9D15A0092; Wed, 17 Apr 2024 02:34:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e4aa5235-c6ad-45c7-930e-de991cc375f2@app.fastmail.com>
In-Reply-To: 
 <c975f961779b4a7b10c0743b4b8b3ad8c89cb617.1713324598.git.dsimic@manjaro.org>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <c975f961779b4a7b10c0743b4b8b3ad8c89cb617.1713324598.git.dsimic@manjaro.org>
Date: Wed, 17 Apr 2024 08:33:42 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Dragan Simic" <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] format-patch: fix a bug in option exclusivity and add a test
 to t4014
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

It could be useful to Cc the author of that commit since it=E2=80=99s so
recent. Like an FYI.

On Wed, Apr 17, 2024, at 05:32, Dragan Simic wrote:
> Fix a bug that allows --rfc and -k options to be specified together wh=
en
> executing "git format-patch".  This bug was introduced back in the com=
mit
> e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix sets"),
> about eight months ago, but it has remained undetected so far, presuma=
bly
> because of no associated test coverage.

I don=E2=80=99t think speculating on why the bug is still there improves=
 the
commit message.

This paragraph could perhaps be rewritten to

  =E2=80=9C Fix a bug from e0d7db7423a (format-patch: --rfc honors what
    --subject-prefix sets, 2023-08-30) that allows --rfc and -k options
    to be specified together when executing "git format-patch".

The extra sentence in the original doesn=E2=80=99t really explain anythi=
ng more
about the commit. Except the =E2=80=9Ceight months ago=E2=80=9D, but her=
e I=E2=80=99ve used the
=E2=80=9Creference=E2=80=9D style (not the Linux-style) which contains t=
he date.

> Add a new test to the t4014 that covers the mutual exclusivity of the =
--rfc
> and -k command-line options for "git format-patch", for future coverag=
e.

I.e. add a regression test. Pretty standard.

>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  builtin/log.c           | 5 ++++-
>  t/t4014-format-patch.sh | 4 ++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index c0a8bb95e983..e5a238f1cf2c 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -2050,8 +2050,11 @@ int cmd_format_patch(int argc, const char
> **argv, const char *prefix)
>  	if (cover_from_description_arg)
>  		cover_from_description_mode =3D
> parse_cover_from_description(cover_from_description_arg);
>
> -	if (rfc)
> +	/* Also mark the subject prefix as modified, for later checks */

I think the code speaks for itself in this case.

> +	if (rfc) {
>  		strbuf_insertstr(&sprefix, 0, "RFC ");
> +		subject_prefix =3D 1;
> +	}
>
>  	if (reroll_count) {
>  		strbuf_addf(&sprefix, " v%s", reroll_count);
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index e37a1411ee24..e22c4ac34e6e 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1397,6 +1397,10 @@ test_expect_success '--rfc is argument order
> independent' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success '--rfc and -k cannot be used together' '
> +	test_must_fail git format-patch -1 --stdout --rfc -k >patch

I don=E2=80=99t understand why you redirect to `patch` if you only check=
 the
exit code. (I don=E2=80=99t expect any stdout since it will fail.)

Although it would be nice with a text comparison or grep on the stderr
output to make sure that the command died for the expected reason. But I
haven=E2=80=99t read the associated code.

> +'
> +
>  test_expect_success '--from=3Dident notices bogus ident' '
>  	test_must_fail git format-patch -1 --stdout --from=3Dfoo >patch
>  '
