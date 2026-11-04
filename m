Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814766;
	b=u44Q6Mgp3oT5WMOFK0VxZNqclw6Pt6tO9UnEAb1Be1Ablipby40Q6OOAbOl1LU+6Zonb
	 jKYUxLYitZdDnlfHUDowrmDgEcTIA7tMJJYkqgvNf5voNqw1JrpPs+wYwocw+k7SAH3SZ
	 O1rY5G+SuRFDbYeyK/F4ULEKbL2z2REKbZmo3dua6RZxrOa55PpdYf8FN2gTCUNAQGV5Y
	 qakIKLJlneJU9u+p8GSluz9R/vhhbem0lBhJF4l0jCjCjLBS0E6g4E6dNCN6MB8CMmupa
	 wmsiUQ/5Dq4MPyHdBjBVpYb3nNUqazOjvWF749RBc4jXjPeUYruOarfg/DYfzmQp9fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=59DYfinUZ0XjgE8n+3sAdQAp053ffGArgYIT1xfQ1ok=;
	b=tehjIiaUcc2c5EIHrih0tOfi6aQXpwD/D63h59NJtR+QbVUBSjTd+z6eK3loWHzcr2SK
	 4ibFDVeBMnClv5kMyYMNVPoKjCmwhJDsil9m53zSz1q3s+pGOFj/GCn3LyK2/4D3i1+HU
	 xEy8gmIZm6LCNlCJnqZPWR5CJk9kMH7oSJ6a876eYMa+LT6yKkNuI9WdSwDN0jO3BtFMT
	 qjEw99zZsUQ9LozCY2vyLMBFyN4/5YJVy3F2kJVzXTXoxjjOKE2hgOeWsOyuGSXwB0RdD
	 cbsSAum0cXgIT3jFlDZfneFnMqWhKYWfR5kq//tsG+U8KL323stl9I2dwpwAZnR9OiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UFq2u25T;
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D60606A7CB
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 17:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25D60606A7CB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UFq2u25T
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-679965fb848so1215693d50.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 09:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793814765; x=1794419565; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=59DYfinUZ0XjgE8n+3sAdQAp053ffGArgYIT1xfQ1ok=;
        b=UFq2u25TY0XKEFeMlnifc6y9j4BiefcpOPbn1kpxqZVtnnfSw8BpjfXzIvUcXrRiXJ
         Ms+GVo+quj83KC+ZVFm7f5dZZ3dUZRmpOGwHgl/vS9yU808cOypb47xMAUMr4VTHcN4i
         IYMcxa6Xb9mauCP0f/vTOzyg65fQdxBVxvC8EK11n7UDb9819rlD/J2LqcLEjpFwzx01
         R16bi8ggHr9zxZX9PLKl9c3jLsSCStiUrZQaceoXGxzsbFxqeyYxKww3hI5pxvtToYyw
         XFgakuwrUPpnmbkeZpLWnmV6Hq5nOStYllmI52dkorUlbda+9dbf4Nrai4QAYaCoxzrI
         iIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793814765; x=1794419565;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=59DYfinUZ0XjgE8n+3sAdQAp053ffGArgYIT1xfQ1ok=;
        b=t0EEWM37SanzDfFU9ag5cCJTQPMPcu7K6zFToPJHB5P//xtwINsFrev9yDviAHqEXE
         kWtJHKYJw36Ghxmyqs5FLQ3sDCWcWBxUGuWHWndOh8ByqOiQACrmhyxPWjmLPi2X3whx
         CYIJGU8fbqELF9DGeUSiJpRdjuYXwv/R5BbsTu878LHTWchl+fMjYIetK05i/C/SlmfC
         5yARdzHfJtjc5+b9amG5ybY5fYuEnAGQaL3IBOUyTzOApabQ6jePJ3AbM9V68jlqYHzL
         vAL1zK6Jal9YL8bxorCG0nOG+ZS07qikW2/Y6rZeVIkEI0efb9uBybmLUSP9fLPQty/2
         RBZQ==
X-Gm-Message-State: APuU4Z+pTwxdjqRpPM64gNnfSe+5fxDweVD0pywz445SUjeABsAWURGA
	S4JTmL4s9xsRFK3KoeF2rJqyEdhwnh0uKKAL6tsGcVDj8/f7+HvwVyP1YIjABg==
X-Gm-Gg: AYBFou13HbHNKUuGMYFeaekLNfuzUvqYy5djYt+dr5gYTgwp89Y+q0YTNTSOPlu7Atv
	4e9NK0rRDiAvOJvGTIIOxn36YJTuiqfpGKFvIdutjamKwJ69Zq0PHcgnVp4+HPexbcTjGIiv5Od
	Vr3+y0y0N24fNBjmxMsXU03Bv4DSVJgVzBPpb77oRdsPZ6yj4DkodQjkKtBk2e1nHmzwNUki0A+
	JkKVuJBU2xEtfGUHYxrtIg51Lf8h+DFOwXQOK682YfeMs49NK3Du+X69RvfqK+5sL+zivpFHlrq
	kJTXpAG5DnrPI9xWSh8BepeCBG3F11+/2NMtM4clh7cykQlaXZVC/Wk88vkspKDDnfK/TZLGPsL
	0vFdV3ERwDmQYE/Ainvtf2qQsKH4bdrhjMhKBDhdBFtUnJkS7aGPcsbHKZ/mRYKePS+DZyy0tR0
	yX0LgjcylBpUnA6g/a4rrO4HRuC+Ko17EKzwV95cn4PlA830K1fFon7JUgF7ffLr6N9H+JZ3u7v
	yqtJ7T40fvSvLhfX/ci8h9vw8gCuxRjGgW0Kg7QodsOPYSMmFG8tuJyVla2GlARNEoVkGpR2shG
	IoUt079Dp2+Pt0aMJOABb56tYJuS7wOET1LMTLnp2DSnY7Tr9r2pzTqG6YgGbgv4D27+v0Pnfid
	oVjencZg85N7zaF7OvW7NIc5gAkKVwLS75kMNFytQD+qShUO3JzbinP1sOp2D9+9BOz0J9vnzfM
	bMvmw=
X-Received: by 2002:a05:690e:190e:b0:67b:f39c:a4cc with SMTP id 956f58d0204a3-67bf39ca66amr1082479d50.27.1793814765006;
        Wed, 04 Nov 2026 09:52:45 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:c5d0:c9f2:df6f:9145])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67bee245f70sm1878973d50.11.2026.11.04.09.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:52:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] branch doc: consistently promote 'switch'
Date: Wed, 4 Nov 2026 12:52:34 -0500
Message-Id: <6EBBE956-4824-4398-B33D-F4E5F58040D1@gmail.com>
References: <xmqqwlqt4lwj.fsf@gitster.g>
Cc: git@vger.kernel.org
In-Reply-To: <xmqqwlqt4lwj.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 3 nov. 2026 =C3=A0 16:59, Junio C Hamano <gitster@pobox.com> a =C3=A9cr=
it :
>=20
> =EF=BB=BFWhen 328c6cb853 (doc: promote "git switch", 2019-03-29) updated a=
n
> example in git-branch documentation, it made an inconsistent change
> to turn "git checkout my2.6.14" command in an example into "git
> switch my2.6.14", without updating a comment that talks about a
> shorthand to create and checkout the newly created branch at the
> same time, which still talked about "checkout -b <new> <start>".
>=20
> Update the latter to talk about "git switch -c" for consistency.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>=20
> * An alternative would be to list both "git checkout -b" and "git
>   switch -c", as "git checkout" is not going away (for the purpose
>   of *replacing* checkout, the switch/restore were a failed
>   experiment, even though they gained enough users to stay).
>=20
> Documentation/git-branch.adoc | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git c/Documentation/git-branch.adoc w/Documentation/git-branch.adoc=

> index bfdf459329..a803c24858 100644
> --- c/Documentation/git-branch.adoc
> +++ w/Documentation/git-branch.adoc
> @@ -406,17 +406,17 @@ Start development from a known tag::
> ------------
> $ git clone git://git.kernel.org/pub/scm/.../linux-2.6 my2.6
> $ cd my2.6
> $ git branch my2.6.14 v2.6.14   <1>
> $ git switch my2.6.14
> ------------
> +
> <1> This step and the next one could be combined into a single step with
> -    "checkout -b my2.6.14 v2.6.14".
> +    "git switch -c my2.6.14 v2.6.14".
>=20
> Delete an unneeded branch::
> +
> ------------
> $ git clone git://git.kernel.org/.../git.git my.git
> $ cd my.git
> $ git branch -d -r origin/todo origin/html origin/man   <1>
> $ git branch -D test                                    <2>

All sensible to me.=20

FWIW, the more folks I teach about switch the more folks tell me they have,
ahem, switched. And prefer it!=
