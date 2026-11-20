Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197280;
	b=0m1tOdDKSN7zH2uWU0vVVv6kYL7mS7BeI/G2vam78goHt1Z7bYQPEnCEdeAzglqyHrTz
	 GUnElZ4qxcCcgyYFEBEN7dF4LqJ7EDVO7KLM47zwoVkwOrTrY8wjgMXYkHRzSA/eZxB6E
	 eaA9mbmpAcuP/pG1UP8CdM57+I7vCZ44IFxv/957O1Saq2jFbaaZ+a61CCtLKZkMivtDP
	 0Sgekwf4rff4yCHnJKKHZvreHizqNo+nOljgVBdatxsiJbSCqTifoc93bGwytu23ND2Gp
	 XMG8ThzaiPW7k5wWO1oJz689O1tffDZUnWnswNYmg8yvnZCZPRI/bBPBj8PIXxjp8sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=MzqCFUeulzPUE8XllfqL2qN677IXq9OdqBD7lLlt8gM=;
	b=RGgGdwjroMSM6ysbeNjrpE/VtkLb5/eyghznHkkLn/xSjKDGRYJSwK2G/maWgekjsHEs
	 3Wt6YrC0zeNX0wR0H0+gPE2vrD4YPshsWc4+RqXaBv280XxBxm5v5JzvXhd4N9Pxkmnx3
	 ibrf1z3LFdJ9vvP6x3tBB3zncoUdr9xFovnUlhJj9fjvbWrXC/YUMxX4VXkOPIDdAlnc+
	 FOjEqb8PyINgXJ2iQP2OfbnE9BiegA3trj5OBEo/1W3QKTvNnwDiSaYV6EkOPAl/U1m4D
	 ApyDR4ncKJrybiQM9e0O6+Kq/nCRmqukm9ys2k/r4aVK0YHYfDdv4Eb0itULwP4jPBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZJ/TZ0Dz";
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C42760A5BCE
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 17:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C42760A5BCE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZJ/TZ0Dz
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67921b515a7so1393834d50.2
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 09:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795197275; x=1795802075; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MzqCFUeulzPUE8XllfqL2qN677IXq9OdqBD7lLlt8gM=;
        b=ZJ/TZ0Dz9bfzniqLgTUxCV+tRCiNaVgktgy8tUjLsEH00Al1rdluS+9Q4j7zG1O3ng
         9cJ+ctlVF/kwpwMf+gMqzLxW65akFw+8lWVKJnwIUHCm5tz/85Sgy5N7vWKHT5WghvJU
         cihTNArc4DFTcEyUNKRgitiXYqBRsBEqgB3M3dQ1Szo6Udu8iK/p6YdZhJOygstgaw64
         z/MnnIUbdsEbZsH8E9GFtZxJS5EiMBuo+HLgFFnZUABbzIPj25xTv9idnjqXXSS/1wfV
         Er7kIKnuZv+Bot0h90wZxUa3a2dX/PJS58nofw6lwhn3rHzKkHFubMy29tq/77xgHXAZ
         5hTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795197275; x=1795802075;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MzqCFUeulzPUE8XllfqL2qN677IXq9OdqBD7lLlt8gM=;
        b=Ep1XnNiWpP4KIlt99SjWBeM5+zmTDqHg5Dn2q5QrZBL429G7uVzuwnBf0zqVek0/rO
         LLPH/Swry8ZVv61rVrKgnkoyX8WX72Vui4ruojWEAS1c3XB6an29RskKjYn+lMjUqrEJ
         ZYWNHFYu5T7jdkPNDqQC7e8voaUsQf+mrHKKOb/24OmIVXYmOoJJp+fcZ0QIhToTkvXN
         NR/BA3Xopo4JTNog5OQ6IAKia1zzSvQZRaUfP1qOOIA4QO2kWTD8F3PMS0AeHCscVsYz
         /JAq17bcCvGPAMiuoMNbLNWjkoOOafPK00cKvVV/eJT6HdVMnyEM9qykxUxIEJXMcefd
         QGbA==
X-Gm-Message-State: APuU4Z8FeetRHV0BGzO3qModtOsrvnHfrVp8T653uVEBLUxKzHFDC6Dz
	CClJAw5+UGZUtClWxGFH50Khi6kxAoOS/9KpvridY/UMLV+Nl9XSFpmg
X-Gm-Gg: AZFdTZfFWEQdLVUhc1tu3/KZ5Flrh4gAAmRd8rY/ls/ScpLfF1OgsGuvoUTcmQWHF0I
	XbPXxrpC2DfmoJCO3BwGf5TEjFdxgFpGFzqeD+1kKTXVnbdYHU3FJJz14+aktaiaqHPIDp8k1l7
	T+heobfTaXu4QAcrzWcMUKUd4m46XwCx9YXHGd1I9uAe/1H0JgFOmXd6S1hebI8+qsW2UOBsLwv
	m07yFWiGAlKNGV1qjxzZdx2nDbLEn4/foWpgM/Dv6r5cw9CAMDJZI03ba6kAj/vAhJHmdT6rxVS
	AQQQCWxBfNWwAnOaOOlNtbU4jzxG6ywxmgk+S7IU7xD9Z7E6EwjFquKVKlIoZ3acL4ny8LbO2dA
	s95F04bYLHcJQKKCIFCYSoXw6zaTABtvPXt4TSYoNAeedLy97H9S3RSmpuOH0xYbXPim5F6+RmW
	D23nysVI4KNUAo27Eet+o5u5BGPOQt47HR54cY+0/8ayOMc/SrFgb7j4t5kxkD00/8Iyyqu5O6q
	IP61K58MWUbaAKiyuc1etf26uhgAb94x03E0rNGUBIeJF2rH1xswC/2X9RcQS3ELZ2P1Cg7/Djx
	x2xqsSKbglFCiXfpcFYmV+IGTkENm7J56ci+7Vp9mRDLa71bl1EEtJMSi/YdIHi5MSESYqbeiUa
	aR3iz6RQVl2AxuqeUIVrc7Jn4x4bujiUNzuVtwk/Mis24dViwY12g7yU9AB5cTdcuvvZhT6PMym
	KO0lE=
X-Received: by 2002:a05:690e:484f:b0:67c:2396:325b with SMTP id 956f58d0204a3-67df441fbe2mr1185329d50.59.1795197275525;
        Fri, 20 Nov 2026 09:54:35 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:41d1:dc7e:670b:ca07])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df3353258sm2002677d50.9.2026.11.20.09.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:54:35 -0800 (PST)
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
Subject: Re: [PATCH] doc: fix AsciiDoc syntax
Date: Fri, 20 Nov 2026 12:54:24 -0500
Message-Id: <93127462-BCFD-4086-B19D-4B640F515140@gmail.com>
References: <pull.2496.git.git.1795194752259.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ophir Bleicher <ophirble@gmail.com>
In-Reply-To: <pull.2496.git.git.1795194752259.gitgitgadget@gmail.com>
To: Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 20 nov. 2026 =C3=A0 12:31, Ophir Bleicher via GitGitGadget <gitgitgadge=
t@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: Ophir Bleicher <ophirble@gmail.com>
>=20
> The Documentation/MyFirstContribution.adoc file accidentally used
> Markdown syntax for a link:
>=20
> [here](https://gitgitgadget.github.io/#...)
>=20
> Fixed it to use AsciiDoc:
>=20
> https://gitgitgadget.github.io/#...[here]

Good catch.

While we=E2=80=99re at it, =C2=AB here =C2=BB is generally discouraged as li=
nk text.
It=E2=80=99s not particularly accessible for screen-readers, for example.

> Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
> ---
>    doc: fix AsciiDoc syntax
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2496=
%2FOphirBleicher%2Fpatch-3-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2496/Op=
hirBleicher/patch-3-v1
> Pull-Request: https://github.com/git/git/pull/2496
>=20
> Documentation/MyFirstContribution.adoc | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirs=
tContribution.adoc
> index c58253fd54..3b531b24fa 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -931,7 +931,7 @@ either with the "New pull request" button or the conve=
nient "Compare & pull
> request" button that may appear with the name of your newly pushed branch.=

>=20
> The differences between using `gitgitgadget/git` and `git/git` as your bas=
e can
> -be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget=
-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)
> +be found https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-git=
gitgadgets-git-fork-or-on-gits-github-mirror[here]

So perhaps we could reword this to something like

    Further [differences between =E2=80=A6] are described online.

with the brackets marking the link text?

> Review the PR's title and description, as they're used by GitGitGadget
> respectively as the subject and body of the cover letter for your change. R=
efer
>=20
> base-commit: f7de81456940dd6f3274e461149bba12965de609
> --
> gitgitgadget
>=20
