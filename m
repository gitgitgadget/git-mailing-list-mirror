Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B1C17993
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772867179; cv=pass; b=lFFWrpqcnjmc/KvBaLndPP2DM4RTAvQB5nWkuxorzfRucjTKCfWxgugxmhTrTLaHlxs4MqfPLabagdxFaVB4sOI0q71Mgg/yBkpNaiW2M5xvzbPJJv/Z2jLZ3jX6zl8WVZNlXEb9w7ETuW73uOa5+vHh8rvyg2JHh8J+lR/DkQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772867179; c=relaxed/simple;
	bh=10Qr4Khm5nDvpHdc+vT5Yc5xnYW7LGIJX5X7ezCvgg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4n20LqFD0GBUHwkU+uScdljSBrHCu/0JhRrypJ/sz6JD1UeUbfFJEgB9yErv1+8hyuiLbxYD5gBF/NAINeHME439eiNI0dq9xt8YuSt0K7XESLXk0GvAZ48DIDYKqzfH4s8aNTZt44ZfbHCsVpLV3NmZ+vZtUCbvUdnO4Z4UZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2be07cafe27so423956eec.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 23:06:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772867177; cv=none;
        d=google.com; s=arc-20240605;
        b=LqTs73/7YIR9hybr5du/7cox6SnenZL104J037eCr9l/1a3oddqk51LnTngPlWWWpw
         OjS3Zoxl3QhbiSE1Bh+dmH/MY18+4w3GdplE7gCRJGl/rDQWHuEglj6Gh8WBxD7Hg+Mf
         pEiBfGA3vP6tYBfUp/88O/Os+o1UMacR8CMSL+YhbiHgml99FpP+BJHxx8x4FbuRbFHH
         x7m9Kbq8YMOubNu/9msWcYUbUlRixQHaXsWeJyzV/ed/fQivva0gOcKN51fgZ399+pnb
         ubL/oWExR6vX8mTc50Ot6IEuUK8HqPGDLfbG4j6D/+9bw8SvI6PU+/UUdapem3uaCYU4
         /38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=mQyu28MIOb+jcM5uKqN4H8NFmphIJlndni3xUP/haXQ=;
        fh=psYHFFYHSKXTPxPY2sBmRg0Oym4Zo0Y/5dcRg5T3CAs=;
        b=R3BP9RdlinhWH0S2tCRwcaLlk3NNP4rOvpXxqgOPO7keUV7R7kbN16RU3sGsqb8p36
         JzYD/UNd3Pp4uyK+UVf/2IUiFHePcA7+eZPhh4Ac5V9ziCq9lC2xXMRzQZZrD4ENZpGv
         tHgHUszNqkUsFsVymE+/qUUI+xuZ4TFgTukha3GTqVec/CXLTt+cYfN3d7L9N5t3/5DK
         nXE/RWhknHaV/7cwpGA3ayNf6phKzv39hxdqE1GJbxUDw72E3mrjBQQsuDvR+KrQ7D7+
         wHupHTf+qO6arLphSHKQPEE9IlNwN3NXuF4GOXTmU+XxD0U9kpAcnq1ggjdpT5FWoq1n
         cmsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772867177; x=1773471977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mQyu28MIOb+jcM5uKqN4H8NFmphIJlndni3xUP/haXQ=;
        b=YklbIWNjZWfMKzBmjQD45swR+rdTbIEPkHX8wunLuWmeBXYAAcmgp9daKxl16tCYdH
         Dq9gSYVG8o/cVfbP+4aod5PL86Bh4gYRcTMiCHIbkjrErjM0LfiyuqdTDrid5OlKR0G9
         kV+MQQ4M7/v8jCmxmJc2Kq/RDzPZrwDPDB4BMj10wv9bAtSgzOSS0rQLo4LV/3UhKF5L
         TtV9OoCg+FERm7lX/e/TERBYdbIcnkm/9r3t+dEz2bEegl9jeKkv5r2+/bZAbuOmoSpD
         iTXLRP7b+YMpFrCkJnf+zwWGIqocjoB45vM46exJxrnyCpEoWpu6pkKkY4VFJ6KHtczq
         sSew==
X-Gm-Message-State: AOJu0YyS36ZouP7c2fPds/ut4qlSW0y8OUKFUqJlZ+Lkg6vT5e14nstp
	oGTvCXhN6gcIr/eq2zGhyUOr3FQMJBPN40GPA+CQcQa+XAaMTwzVl0tj0Bd2aZLssdzGyLc5tjk
	xfMQMNr5bObIv8mctIRdL5//p+g8eaaQ=
X-Gm-Gg: ATEYQzw+HYLX6H2HL+Yq1vakNRT9sRfV0JXmpiNr5pRt3O2nLe11en8YvtGe38ViJ9Z
	KyMW02O2ni1FcST8+MCoLzMjVpqmJmH2RTdQTLHeLIJfpz3DXEPl1tXpRvmsTlOjvsi6yuO2NS1
	qDJdGqwv7Hh6qWxdbbqiBrgAOIxMITwIkz7KHcRtT5K/Ck3DiZdH0U8eOtFOeRGJgQeobOmaRFA
	cjD3tPQ1CX9+R6BYGVEnyt91vMDNIx8GK/eWTR3M6vNohiGRoUSgRFX3NABXIvIgT10Cnz1fTaZ
	U3Ir3Ql9AZzRrFPn4AFY6SN8mi4KeVq5gtPKoljA
X-Received: by 2002:a05:7300:ac81:b0:2bd:d111:cf18 with SMTP id
 5a478bee46e88-2be4e0655e2mr994639eec.8.1772867176958; Fri, 06 Mar 2026
 23:06:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
 <pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com> <6cbb950d8bc3b647d7fff72a72f938ee369b552c.1772802872.git.gitgitgadget@gmail.com>
In-Reply-To: <6cbb950d8bc3b647d7fff72a72f938ee369b552c.1772802872.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 7 Mar 2026 02:06:01 -0500
X-Gm-Features: AaiRm51TmfYjJY6qiDk8nCJcFANMwSGnq1W8t7zY9ar45mOM13VI1XIWccewn_g
Message-ID: <CAPig+cRQcA+0yWqbYMfjFXxhTsQ-tjJEqsVFudu1thuYi3AXUw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] branch: add '--name-prefix' option
To: VALERI Yoann via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Yoann Valeri <yoann.valeri@cea.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 8:15=E2=80=AFAM VALERI Yoann via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This patch adds a '--name-prefix' option to add a prefix to a newly
> created branch. It can use a regular string or a token as prefix. The
> only token currently handled is '@{current}', which is substituted for
> the current branch's name.
>
> Signed-off-by: VALERI Yoann <yoann.valeri@cea.fr>
> ---
> diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.ado=
c
> @@ -64,6 +65,10 @@ Note that this will create the new branch, but it will=
 not switch the
> +With a `--name-prefix` option, you can add a prefix to the branch to cre=
ate.
> +This can either a simple name, or a token. Currently, only '@{current}' =
is
> +managed as token, and will use the current branch name as prefix.

s/This can/& be/

> diff --git a/branch.c b/branch.c
> @@ -365,6 +365,23 @@ int read_branch_desc(struct strbuf *buf, const char =
*branch_name)
> +void add_branch_prefix(const char *name_prefix,
> +                                          const char *current_branch, st=
ruct strbuf *buf)
> +{
> +       int value =3D 0;

What is `value`? It doesn't seem to be used at all in this function.

> +       if (!name_prefix)
> +               return;
> +
> +       if (name_prefix[0] !=3D '@') {
> +               strbuf_addstr(buf, name_prefix);
> +               return;
> +       }
> +
> +       if (strcmp(name_prefix, "@{current}") =3D=3D 0)
> +               strbuf_addstr(buf, current_branch);
> +}

I would expect this function to produce some sort of diagnostic
warning when the user has given it a "@{token}" it doesn't recognize.

> diff --git a/branch.h b/branch.h
> @@ -148,6 +148,18 @@ int install_branch_config(int flag, const char *loca=
l, const char *origin, const
> +/*
> + * Store in 'buf' a prefix to the name of a branch to create by using th=
e given
> + * string 'name_prefix'. It can either be a simple string to a shorthand
> + * starting with '@'.
> + *
> + * Currently, only '@{current}' is managed, and will use 'current_branch=
' as
> + * prefix.
> + */
> +void add_branch_prefix(const char *name_prefix, const char *current_bran=
ch,
> +                                          struct strbuf *buf);

It feels unnecessarily burdensome to force the caller to compute and
pass in `current_branch`. Intuitively, one would expect
add_branch_prefix() to compute the current branch itself if it
discovers that "@{current}" has been requested.

Moveover, this approach will not scale well when support for
additional "@{tokens}" is added down the road since it burdens *all*
callers with providing the values for *all* possible tokens.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> @@ -1716,4 +1716,22 @@ test_expect_success 'errors if given a bad branch =
name' '
> +test_expect_success 'create branch with --name-prefix' '
> +       git config branch.autosetupmerge false &&

Let's use `test_config` which will ensure that this setting is
reverted at the end of the test.


> +       git branch branch-with-prefix &&
> +       git branch --name-prefix "blob" -- -with-prefix &&
> +       test_must_fail git branch --name-prefix "blob" -- -with-prefix &&
> +       git branch --name-prefix "@{current}" -- -with-prefix &&
> +       git switch blob-with-prefix &&
> +       git branch --name-prefix "@{current}" -- -with-prefix &&
> +       test_must_fail git branch --name-prefix "@{current}" -- -with-pre=
fix &&
> +       test_ref_exists refs/heads/branch-with-prefix &&
> +       test_ref_exists refs/heads/main-with-prefix &&
> +       test_ref_exists refs/heads/blob-with-prefix &&
> +       test_ref_exists refs/heads/blob-with-prefix-with-prefix &&
> +       git checkout main &&
> +       git branch -D branch-with-prefix main-with-prefix blob-with-prefi=
x &&
> +       git branch -D blob-with-prefix-with-prefix
> +'
