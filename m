Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795726612;
	b=wv2/u/l68elAPUHy9GeCPFWuLSL8YDrm3vGwpbDiv+S41gM5BpGWQe7vhmeO1M0WgO7O
	 7YZksz9LmL1STqTX+DeIKibPVvpHPjXIepqEQ3An5illo3vk8s4UeWfE9PhwuDfgiqrvg
	 0r6OhYx1V48mkyhmbWzViFY2WU7YD3AMdndPFSt32SJ7j/MXZRdZLOkvQ/QeIu6NTIOpS
	 4v9VINKdfkpfCgkfRl68N1ObjVgOTYj3u8zwTQi3vp5H2AYQTD3we4N9orJfGThiQ78bp
	 raWqrrTnPKB+uSXrM5Au9jzZnr8nz2r72fR/rFllgp9jEakdd6xQ2ybHLE1IccfaWjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795726612;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=N0Y6Qqqz2Sh8DPKtScH7MCzsNZxUAyR4jo0PkavP2sc=;
	b=jIve8R6EH7nKkfkqzaHRKGyDm4l32xZm4JWSe5VTXDsv/418quYnYQys6RcxHnAeODP0
	 UKZQomSadv6hxWFA9WCA4mimU83EOaO3qiAcB61d4GEWN7vl4phAg8FfOdz2r9QQk1hXM
	 GHmYS2ZaVYZ9mys4F52bus7Lo0CbxJs51lCGm0xlhJYzSesPDSEPlT//JO8VYSLCFfsPH
	 81vPc1Q5P6cv/mDlrQSti2oV+d0DaJYMLD+/LLB/JonZhsW99/XyQ6YYpSH7MAeH68tks
	 UYWocsYgUrxg9ti5FQaj+daD/pkYDzSmu9GKG+iNhNfPtbLjOxRpbROxTbYmvZJxC3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=FclIkhlY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hVLw+xqX;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360C2606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 20:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 360C2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=FclIkhlY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hVLw+xqX
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 51F381D00347
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 15:56:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 26 Nov 2026 15:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795726611; x=1795813011; bh=N0Y6Qqqz2S
	h8DPKtScH7MCzsNZxUAyR4jo0PkavP2sc=; b=FclIkhlYhIcfy0fVvO8BywTLsL
	pv3wZ0T7XrE49U8+yCiDtbweif9Vftns3Mk9tAeg5l84aVnMo3uXSkc9PqD7dXOY
	rvp6JrgcMkkZ8B6g59MviE+KcuxqML/FlNtpVd4pY4Nofkqzt2Kp3GyBFqa2FIhS
	PgA0qmd1fYcXmww2bkgncXTXycDIuiyWAIMDCj+EMQZLIN2BEMwAph9uUmtqZpAs
	6AmMqvY6wwZaxhKmWznwU0P8jHyMvYixLhy+1gSmYcdVOwO8p5nm48K1mQ5I2ELq
	PE/PTUit7PFQZ1kZS6BGgtuo1i2ivOjVREj+R6BOVFFgPpHfX4IhB1mYAs3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795726611; x=1795813011; bh=N0Y6Qqqz2Sh8DPKtScH7MCzsNZxUAyR4jo0
	PkavP2sc=; b=hVLw+xqXMOYeOtj6lEEFhG8pg4ptGzrIkHFNOsaTWx3ep5cuciy
	e4cdFVNygfoqZPiCffzpHMD01kf5fzkbDkG+fH4ItSaeQ3v0SnHAgM/sBX2PJbBN
	nai5NuHfm980cuUX6EQhZZUIpVfEgNM8D+g2M4Z3cvzYFc1lqye05WnLSD6vDxmc
	LcZrbOHZh7rTKQnH9WJNOzM7vA6bPEOv23dm99nLB6TdN2wVhx9I1ywGwV+0zdOX
	JG2C/gDAkaXlnB0xif307kJ4d4nAA4VkE2GtyBWKLdyX2H9bM2TyISN6v9YxsGJT
	PRMAH3542+8VWkvhu7lz/iDfVGy5bDBn9Lw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795726611; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hoM0rozO8WM5w/rTarDuRAHJbN5j9Hj0YP6FBI+CgsBxznN
	dsyM1tBPMDC3o3+IwCGoLBP2l559S1PvgQBj7k6NACq55wCQvNT0FcvfOZ+0NcCY
	cOf8zDh99eEHkv1B3O/n9HmWmEEgBAJcz1sVTlCfmHuJ+/sH9WKNvgtkP8sWYv+O
	0/SVrqZWwCW4/6b6CxplX48riGDxDPEe8Hw8ipV3+XnQp9zSgLvuvkkDBjYSYT3d
	UmHW1D712FRwjvJ0DgXMZwk/Nev/chs3i2EUJv2ZK4hzkreM8n9sAYV2oDG73bI+
	xeg5nnON+51afRXtYJE1zqsaWmj97mWpYdQOwpg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:64s2PVOD0sb4C/F/5oplXe2Qex1oC7QqTslFjpDEZUQ=:9paNbmMjseXqGykdtq4QapAVccn9t4yFjSkhzitnaPk=;
X-ME-Sender: <xms:Ep0Ia5cqjyA2-EVI_r0EUgPGS74zdBoQDSYs2kZ8Da7_8Kn94RHpyQ>
    <xme:Ep0Ia-Gymc3k5nnQRpiVgMsZWxIRD_7Z1aQrxRSTexRo10L75KWvIANgqJxjbj48z
    3jZ-CQgmJR01pLawWf8c-aW7MmlFSzkI5lsWo1TwSgPLoMNXPtpXA>
X-ME-Received: <xmr:Ep0Ia63ipUkK07wzzkUjefsiZYC-ccftjIzVyi1FxUutXANkr9QcAyNihl1XBLh_trv-imbeFlJij0oxlvL5dthCoMNC9q2Kj3XDO5o>
X-ME-Proxy-Cause: dmFkZTGwzr4NcqPAGqDS0z57h181qU8tpuJzfFvEGytWX3dBi3FMnCocCsP7GO6ElFT5k8
    jW4etrt9dZAq9Wt0tn2sqqJ4j4T0WPfiLeckc9D1ZJL2XWmpQvJrVBk6wEKTg2qmO2DTOP
    pVqDNictyVnip0mWNlIxroDTVvSY75l6SLqTJSkxJKcw7haQNaEBh0MKl/NVhXVZmIbm92
    hkyCcvOLtD45iYyUi0GcNPTLDNmWvcrpFnkCToWSF2kTSS7+UHFA/ZqXmCxQeiuNjPi/cT
    orLAJoSlus0bFYo8wNB9Q+8L8ggf3+M9RGsYiV9gsmxNu5MaOdfF2BOK+I4FS0CP2Y0WJK
    QRYCFeGzDSBcajekfZK8bFrR+25NwyFYjqS4W1gZ9yVLmLq1wpX8DZwVDv9sB6s9RoLZ1D
    s0soM2kCajyrf4i/ooOBw3epxzIdZX0Lvm0suGhinDYUVcgYtPlThX0lOlCKmoTQJ7y8A8
    CZ55DUVFwN1LJ7rfZp603HzHOC4HfdgVawy/udD05rA7dYCKxFBqfEPYeXdHTryGkoxkF9
    pf5o4IUwJJ/q7AGKvh9W3Fif9lw2+SwNvwWY6KLidlw/QePQtATalovGhMeClhqZnF3u8H
    lkgbfT/n2lzYu2+rJgeOiRLenpmSgU8gM4h3s/9XTt4ZnXYFXjDNGTuWIB7A
X-ME-Proxy: <xmx:Ep0Ia-kbZuhcwrmUYSfzJS6q-Jps6MUpnAIiP4HOe4HbloCjXk5rng>
    <xmx:Ep0Iay_1bq7Ajrau7CrVFEJJdR5X-ir4QgkLXE7G71mlN8PwjkT9VQ>
    <xmx:Ep0Ia7r41sJTp0amdPrXgzeEWnzokJtV2TPaioIQO8pHIbTfB2AF1A>
    <xmx:Ep0IazlLsAbXzUEQ3gxztbOavJfv4U9XC7ZOMVspMug2Js6NkDnPJQ>
    <xmx:E50Ia1GPTMo_hvL6YWTqcMfl-ZINNH_SJmt6brLTyoMEFqbvQKrbJsaq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 15:56:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>
Subject: Re: [PATCH v2] var: add GIT_COMMENT_STRING
In-Reply-To: <6e310e0af58cf693819a8d7384c1560e2e342d4b.1795710343.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 26 Nov 2026 16:25:52 +0000")
References: <fa8b80af26481e0dc96fd8f80f3c7ba84f60f9d4.1795516651.git.phillip.wood@dunelm.org.uk>
	<6e310e0af58cf693819a8d7384c1560e2e342d4b.1795710343.git.phillip.wood@dunelm.org.uk>
Date: Thu, 26 Nov 2026 12:56:49 -0800
Message-ID: <xmqq5wxjia5q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Since commit 9ccf3e9b22 (config: add core.commentString, 2024-03-27)
> we have two separate config keys that set the comment string used by git
> when creating template commit messages etc. As that commit notes, when
> core.commentString is set to a multi-byte string, it can be useful to
> keep core.commentChar set to a single character for compatibility with
> older versions of git. That makes it awkward for scripts to determine
> what the comment string is because they need to do something like
>
>     {
>         echo ' #'
>         git config --get-regex '^core.comment(char|string)$'
>     } | sed -n '$s/^[^ ] //p'

Did you mean 

	sed -n '$s/^[^ ]* //p'

to catch both " #" (the fallback) and "core.commentstring //"?

> diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
> index bdc74d291cc..e348d8895d1 100644
> --- a/Documentation/config/core.adoc
> +++ b/Documentation/config/core.adoc
> @@ -549,7 +549,8 @@ core.commentString::
>  	Commands such as `commit` and `tag` that let you edit
>  	messages consider a line that begins with this character
>  	commented, and removes them after the editor returns
> -	(default '#').
> +	(default '#'). Scripts can query the comment string with
> +	"`git var GIT_COMMENT_STRING`".

Elsewhere in the documentation (such as Documentation/config.adoc and
Documentation/git-var.adoc), 'git var' invocations in backticks are
written without surrounding double quotes, so dropping the outer quotes
here would match the surrounding style.

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

OK, like other .read() functions like committer(), we return a copy to
the caller to be consumed by list_vars(), which will free() it
afterwards.

> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
> index 883a45399e2..f228cb5bb6f 100755
> --- a/t/t0007-git-var.sh
> +++ b/t/t0007-git-var.sh
> @@ -434,4 +434,14 @@ test_expect_success 'git var -l lists the identity components' '
>  	test_grep "^GIT_COMMITTER_DATE=" actual
>  '
>  
> +test_expect_success 'GIT_COMMENT_STRING' '
> +	git var GIT_COMMENT_STRING >actual &&
> +	echo "#" >expect &&
> +	test_cmp expect actual &&
> +	git -c core.commentChar=: -c core.commentString=%% \
> +		var GIT_COMMENT_STRING >actual &&
> +	echo %%>expect &&
> +	test_cmp expect actual
> +'
> +

Checking the default and core.commentString overriding core.commentChar
looks good.  If you happen to reroll for anything else, testing the
reverse order (core.commentString followed by core.commentChar) would
exercise last-one-wins in both directions, though it is certainly not
necessary on its own.

Looking very good.  Will queue.

Thanks.

