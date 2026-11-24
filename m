Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532553;
	b=Q0007QeSD37s7CEV5ihO38PSWvIACeyxgJz2KdH6JmpErG/Ark2eNaIm+dHwP7y2ql0V
	 9dtHGef5vMikxVZMFIi78j8Hkn4HE+kvqIznrAYBl+q9x2MKw4Ain86fGhuXbhKcQ/mZp
	 xaRy+6HCV1lplIf5Oon11xaSPPECKXkn/+EbqUidH3YN+Vd7Eq/GxlwQup6/Od3YXPxKc
	 vHqGgc30p33LgqlcyLsAOMrIY0h/u9ClsHIzLd/R5CToZFHYWVeai9AoXwzsZQtyY0vQR
	 nsuRBaNtItCUTS0cxNOjz482zJ93KIwRvFooG/xIT8T2uMoD4a54lTzz2mRr1EU/D/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532553;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=0KxrSyweAiDNEyaUFM+JcwvdLXtPNvAuV2vnyXixliE=;
	b=x7+0RSf8UWmtTS12elG83oNOXc8wtPLS+/5BrIo2aL1kFfN8PkZKnWsFieN5hzt+7+vb
	 bIthj7mHfFaH1BB21Oo/FSsH44m/hYF6XxRyOW+qJrUTE8a1RGQ3iCJ4ix4f3rAHdpCDy
	 cBOayUXZGXqS0hPRaJDUQXPIAtvispKqquUaPOyfTJ4JGJwcpgb2/Wn/83Ke8ZJy8PAxk
	 mStHN9Wml2qnvrQh84nVWT+8QoeMwHIXl9gzSvtur6Zin4sACsCTn6Vv4gnWEARWa2IsR
	 YJZuxfmjyfi6ExWDyIK0y3pYLlklz0dLVhwJ8oAovK2NyHONhp6iqnKUK8mLj6HgNHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=Tu3bVKdL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gM+lDjse;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B5606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E7B5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=Tu3bVKdL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gM+lDjse
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 81695EC0C28
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 10:02:31 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 24 Nov 2026 10:02:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795532549;
	 x=1795618949; bh=0KxrSyweAiDNEyaUFM+JcwvdLXtPNvAuV2vnyXixliE=; b=
	Tu3bVKdL9jIBNb5XlRGfExdUB0b/sNZcWn+OonBpif/f6x+hsBDiidx8nwIk60zo
	2tAnUm5951qAEx532li9npzSlP5xFEHUNNFr+b7w0FsFj9OFb8Nqyth4tPC7RvwE
	ICsGMSFAGJOJSjTVcUYQ1feNzHBALATz6O6TYcxYdCtlvQRTVF/fK4kl4El2I4BL
	PirVwnOUMhnOtFQWKExoEpO3Y4Aq/H1mHOI0+NAOV2Yd8lq3QjH6PTRU3dq21MoX
	ghVh+nVCG0MJg10SFk6ZpHOKU+fCko+EMPgL/KW3tbmPTbCVzP/lgXQkw0ZqrihS
	Lq+7lTG/4vYJ4v7dk2evAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795532549; x=
	1795618949; bh=0KxrSyweAiDNEyaUFM+JcwvdLXtPNvAuV2vnyXixliE=; b=g
	M+lDjsezUpwc19VuaoM3lgvcqGtnJGI7r8LB+jLuoGJVm/S3iYMtKAW7AOaTqW9r
	43DqAinxEUADMcZIuqE7uSrZAxN1IBw7voakTz910ISTmx5hoBn70msHKCDAVLL+
	4B4VhidwRCJQlP/E2lt4ThZ3se895QsfKgTKsFmp8L//pBUr9VdtH36on8MFRVpr
	pDtEQg1a2va4PAmc38yGgvwUJJ4HTcq5/Jsjw7dp2qW57dPWYoxZ94yjsD7f4Abm
	JVNKLN0Afo+bFjPutLyr11YH0bpvDVU5pbw/9hIkZog70GUomGMSgYbobsu3dyaw
	zAp27/ZPJf4tSEJDdzMZw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795532549; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Z4MpM5q7xe68pWpIVtxsCocydvwo8KfmRDa0MfYEKdYITu9
	/mCx7qOGO/bgXJfLRypJjK/USmPJODWqtGvqmblQmOuXx/7vc/mZHxdgpHxUQNCe
	McqdjzC7zOJeuXnkCfh9P0xZpkG6z4tOqxB3cx7+99siB8Yry/NMAAnPtFARFrcW
	62eUhfsN8NLlLiviNL7NAXOgCl1eFfeAOqyG7DoLic9+SRE2e8YQ4FlFxCnJmoRW
	IsRRhDkcAAEPvMNtCPMTOm1kwvyo7Gu9KcBIJsxs/UQYbEksg/Ge0ajtuHkosPw/
	cl/IS58z6QzCc0PY2G+hNItsNLp4OScv4LYlEsQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3OVmdcAKfladp8NORowl1qc0veepORxm4/k8x/O0Y9c=:12LyNwtF5B5CaM2aad/itG+SBCpxfU/j1sX2djZSpdA=;
X-ME-Sender: <xms:AqcFa2Kw6YnDDkvwjdNz9_uoWCZPLcxHcYqbFd-KxEEmSg3QPjiLdNs>
    <xme:AqcFa4_53h7srPbSZKC8vL3szQbyH0vgaN-e4plSeHMWHgwAK4rgA0LY-9O8SfF7I
    d2h4Nd5MKd8l8nP0WLkrxC-KwBGpXqL7GSD7k1HashM0nXpWXtcU8g>
X-ME-Proxy-Cause: dmFkZTGdBOEb29doESXzAG+tD5gSfPmlHlJt2JYwnYzDUEBRWsOw2UYGYSeKptgp5xBaZB
    4Yhj6c5mA8kYxL6+7M9qxWsx1JklV4aCyydcbShX4ytE4u9EUTMOx5v1QidMuWaS6UJV01
    LDfU/e9mRP0PsE/AqryvHUZXvob/v2R1uwrDEdu28wxWd0zbfkuUFLvKvp21JLg/Xq4dKw
    ojJG1+CqCrkiOVHzqS4+NnJy69/yx4O8QpY7yTYpDaZ4z/TloooGKyOxcQhwLsN0vj3uql
    4mpLjpeG6GbfZX+ShIt/fXJQlQIz1gAycYYRqTLAF7r8oL0Had2u5lwUMPyt5ZFW+6DxSp
    /oJWtrTPcA7VMa5PSEZru7IYDfw/4ijXisuDhxbk+4ahWvnage1/1ZVcMokSgG8Y2VKa0s
    hTkKlpAS880PZKt1YdWawrV4N4qYDIYqgC30vvqjJZfwEdrnPbXZFuntyZ0gEWDlnG0SfA
    Z5ymgLfGW5cVWuTRFJI5PrtYijpJD9MwOdnQD2CeJXHGRthcmvm6RGe/EsXTJwSk5MdKMq
    w0SVXiAj1rW+J1RdCYaFEk5XEBKBsgPHLV2vPTXOUasvAtk/jrw/dHZGWK+kueDdcgNfyL
    pi+73C7W5uEx5jyGoc8Efm/mbyhkvOerRNvuzv135BQEAzFlgfEvg6lFXxNg
X-ME-Proxy: <xmx:A6cFa6yQbZZpE1mph_-Z9GeUYPBxXc4A7okEpSMOj0e2w0BjqjgwdA>
    <xmx:A6cFaxtvx1GXzUIAKISMhanbe5eEQv7M_qIgmQa5NBInZCE9-k2LUg>
    <xmx:A6cFa_2ji15HKKe1PWpJK7JqAtb1v1Xq_kfKyfI5IlZwizBLo1PKIw>
    <xmx:A6cFa08HM2UzlUeYeeGyeLaQ1fpQnP9pYihTa9lWzaEnaJTWf-y7nQ>
    <xmx:BacFa7bvSQUH7-UsGLZH3phn5ysabpTohQbktiJuhsHdhc19lVz0Z4_Z>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 7131E22C009C; Tue, 24 Nov 2026 10:02:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AkCwORjixZW3
Date: Tue, 24 Nov 2026 16:02:06 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>, "Phillip Wood" <phillip.wood123@gmail.com>
Message-Id: <b8c40805-90f2-414c-ae70-e2f79a19170e@app.fastmail.com>
In-Reply-To: 
 <fa8b80af26481e0dc96fd8f80f3c7ba84f60f9d4.1795516651.git.phillip.wood@dunelm.org.uk>
References: 
 <fa8b80af26481e0dc96fd8f80f3c7ba84f60f9d4.1795516651.git.phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] var: add GIT_COMMENT_STRING
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026, at 11:37, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Since commit 9ccf3e9b22 (config: add core.commentString, 2024-03-27) we
> have two separate config keys that set the comment string used by git
> when creating template commit messages etc. As that commit notes, when
> core.commentString is set to a multi-byte string, it can be useful to
> keep core.commentChar set to a single chararcter for compatibilty with
> older versions of git. That makes it awkward for scripts to determine
> what the comment chararcter is because they need to do something like
>
>     {
>         echo ' #'
>         git config --get-regex '^core.comment(char|string)$'
>     } | sed -n '$s/^[^ ] //p'

Yeah that=E2=80=99s inconvenient.

>
> Add GIT_COMMENT_STRING to "git var" to make it easier for scripts to
> determine the comment character.

s/determine the comment character/determine the comment string/ ?

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> base-commit: f7de81456940dd6f3274e461149bba12965de609
> Published-As:
> https://github.com/phillipwood/git/releases/tag/pw%2Fvar-comment-strin=
g%2Fv1
> View-Changes-At:
> https://github.com/phillipwood/git/compare/f7de81456...fa8b80af2
> Fetch-It-Via: git fetch https://github.com/phillipwood/git
> pw/var-comment-string/v1
>
>  Documentation/git-var.adoc |  4 ++++
>  builtin/var.c              |  9 +++++++++
>  t/t0007-git-var.sh         | 10 ++++++++++
>  3 files changed, 23 insertions(+)
>
> diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
> index 5f240eb56e3..04aeccd7aa6 100644
> --- a/Documentation/git-var.adoc
> +++ b/Documentation/git-var.adoc
> @@ -130,6 +130,10 @@ endif::git-default-pager[]
>      The path to the global (per-user) configuration files, if any.
>      This variable can have multiple values.
>
> +`GIT_COMMENT_STRING`::
> +    The comment string used in template commit messages and rebase to=
do
> +    lists etc.

This could also mention the config variables and git-config(1)?

> +
>  `GIT_HOSTNAME`::
>      The hostname of the machine, as reported by the operating system.
>      This is the hostname matched by `includeIf "hostname:..."` (see
> diff --git a/builtin/var.c b/builtin/var.c
> index eb85a985b15..6dc8ec4ba9f 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -188,6 +188,11 @@ static char *hostname(int ident_flag UNUSED)
>  	return xstrdup(buf);
>  }
>
> +static char *comment_string(int ident_flag UNUSED)
> +{
> +	return xstrdup(comment_line_str);
> +}
> +
>  struct git_var {
>  	const char *name;
>  	char *(*read)(int);
> @@ -262,6 +267,10 @@ static struct git_var git_vars[] =3D {
>  		.name =3D "GIT_CONFIG_GLOBAL",
>  		.multiread =3D git_config_val_global,
>  	},
> +	{
> +		.name =3D "GIT_COMMENT_STRING",
> +		.read =3D comment_string,
> +	},
>  	{
>  		.name =3D "GIT_HOSTNAME",
>  		.read =3D hostname,
> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
> index 883a45399e2..f228cb5bb6f 100755
> --- a/t/t0007-git-var.sh
> +++ b/t/t0007-git-var.sh
> @@ -434,4 +434,14 @@ test_expect_success 'git var -l lists the identity
> components' '
>  	test_grep "^GIT_COMMITTER_DATE=3D" actual
>  '
>
> +test_expect_success 'GIT_COMMENT_STRING' '
> +	git var GIT_COMMENT_STRING >actual &&
> +	echo "#" >expect &&
> +	test_cmp expect actual &&

This tests the default.

> +	git -c core.commentChar=3D: -c core.commentString=3D%% \
> +		var GIT_COMMENT_STRING >actual &&
> +	echo %%>expect &&
> +	test_cmp expect actual

Then it tests that `commentString` overriding `*Char` works as it
should. That makes sense and seems to cover all testing bases.

This happens if you have an invalid comment string:

    $ bin-wrappers/git -c core.commentString=3D var GIT_COMMENT_STRING
    error: core.commentstring must have at least one character
    fatal: unable to parse 'core.commentstring' from command-line config

With non-zero exit status.

> +'
> +
>  test_done
> --
> 2.56.1.576.g0cfbda1d5c7.dirty
