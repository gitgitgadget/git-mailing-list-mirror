Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795220330;
	b=a9hp0i7WAxNVMatbtPBsba1+ETyo/BmMxtUSZfxSYCl67dh2fpHnp7Z0zEhaKf5Ny+br
	 XcHxvQYQGGwVis83KA2qcvOkNp6GwQt9K1K0ICwi4UOYtPpYvGi0HX6h5vpIAq5+B0dXP
	 Ycsouv+wD9wsElxO7DIsUanY5g35O8WQrNL0GfLQF0NCe4mlTRohJ0oAjUQNSFdbGuKBE
	 5rROxMO5b5BWyyuGIxPjvabLPvXwZS3SdItPNhJDYu8s4LowxelFd6ptawIrGYNz/4fmj
	 BBZ5pLwvPVb3dGO2PGEYxsGNB/DYdXS3sMS56u44W8QeM6l7EFQ2tr2oKyeUvd7/wDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795220330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=hD8bC1fcvGIpoEhcGGXFWpQQFRCTc7y3bgAG4jXITZY=;
	b=jnTqefwnoQxfVAEQL6vCVj3y9WnTc4NUQ8CBARESAiFlbK1O0nrHzngk7FIme/TlQnTj
	 ckgxDeUwxLKu0XlOtIJPMS7Llaoi0YWDsp9J/Cryzc32Q3RD0usy4Do7uioNoE+6O4Duz
	 W9t/5VBYN2k5aiiH8peHPdJGClj8s7E1aC9reLV2yQjYtHyJ99JUP0LKesH/D2qEhl57b
	 37R0UEHq/fP5WLGIsFMJYK8bB9AFFzWk6ZcoaCAK+/FBc9/w408wsg2qDKznEbkYXS1SD
	 1UnvNppuAuJ5tx4u7OKMq0tblYL0q0AWCfxt2AOSPP9X8UA2k4A4TPC3bOyOv8Z6jZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="z47c/jbt";
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1415606A6A1
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 00:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1415606A6A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z47c/jbt
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b4dbdc9592so4016887b3.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 16:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795220329; x=1795825129; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hD8bC1fcvGIpoEhcGGXFWpQQFRCTc7y3bgAG4jXITZY=;
        b=z47c/jbtIEO0cAPJuLKzmwbKpgc/kpbXgP5263gVd9y1zhBfzk+7XzY/R7yvRO8uoT
         a4lbJ+qzz60DXxORaNMIJQshCMZd0UQy29jlR8XEVMYuajKJQtrgRmmcYofiTof/yv1B
         0v7zjjzNA4dSsvdhBv9/RgOf8nSZfZhFf8i5I+hja4wP3jfzYj0GReuT1jGrhhoVohCl
         U0LGevwsnXNhlWSCBki98TQOipTZ5MuBNjqlVMtkv7fmL9SWyDynTmXC6+O0/Xon3XJ9
         LrtwrnUeLVeLUYVggsRYsEymdoSq92L6z83Bs8/yS0wEsY/4ZM5udB/RmdY5P/r6yL1+
         9B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795220329; x=1795825129;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hD8bC1fcvGIpoEhcGGXFWpQQFRCTc7y3bgAG4jXITZY=;
        b=XQ76pWW50r4uMJsyTbfXiQaX/CDABMQFUsHp11FUM1ZU0pAXvVW7bn5BWUyKuQcPT1
         pFyBYMLjtd7iVsYcBvHxLLDrDoPkyp1v3uXNZv9P9NwfCEp22K8ZKHeNImjBPpv0KUj+
         //QgiA77Pk1Wt6li44WM3NMon6TE0fpfEonMXmD5knvJdwJq39z8/25ULJTxi7pUM6Qg
         HvLmn/ETWExNwrRO+00S8kTaGsLjgS40BD8c300UWOaEZHyaFelhSKOr9MBKVHvDdwwt
         P6p4maZd+wONJYZ9agmjcyE1f338RGkSROb2MIM0rrxAzw0c1N9RCyWeL/7Xrsb5cJob
         cgjw==
X-Gm-Message-State: APuU4Z85l2Ra9M+uv7zk/7paZ1Av74TgObgXX78cjsEF5e56ztijvjR+
	4V1fkf1BmQlG2YWlsM0DC2FtGiLu1ZIQSGqU2TD1U36A8UC35gaDjkHM
X-Gm-Gg: AZFdTZe6SqRODRH8wKLi7nhBTlvGkeH6jDGjkwR8PC9vM+uZNFQpvqSm/CBxl3uf3J5
	CNtC5BnbcZ+LWCAuCTd4FKB+QEAvPX1P03nbxEhcJmYfzOVXjenUKmy+4tQHOJSsbW55QiCxSwc
	pNa8RNA/XZYDXBxzNxe5m9ky2Ma9DMbDeIJ0j5n7ukmS8U6oRcxn0K3yx1r8aMh2orTJ0uPiXl4
	wtf/371dnyxJR7gamAjQ0lIkdgvv9hHCiFg8pkDeYkkSZtmXtb1wc3vp7bpWyl9cuCol+zY+sHq
	arqYksn5aqgKQ6NoCvLSF3Q9wW+hjkSQVnXIEzo7rRJ63nRdR3plA4zcbUdzRnr3l5nu201gr1m
	IiOScrIPYL/VpPiQPDiaswtqi0nox9RvI/dun+lZGWYMcjJ79D/IS2hRugMuUUyqpg272tMzNTR
	sgi1oJNiHpKhwf3Wee6bVECtOk/qyuCs0Exw+5inoSGC9eT8VoEzlV5sO8J28L57CAxxU9Np457
	OjkNAMFpUCeORUigbquBhz9GI+/0TNo1jUp0/womgZtGEj0au6YOpSmfam+u4FwtIE4854CRYzu
	1QpUFOKRDAc27fWtYwqKBx6Z+q6Ll52faA9stgP0he0miyE4ZNvY/pLsU3tq/r2VRc9FKB0/N49
	BeOXB4srk9vaB9l2hoVCBxSDtVfutv+1+a8JS1xPue5/abwM4xK/QpMG4Mk3vMHm+ffpkJoYKns
	aNNw==
X-Received: by 2002:a05:690c:6e93:b0:8ac:46ff:d376 with SMTP id 00721157ae682-8b5204a183amr26620287b3.28.1795220328843;
        Fri, 20 Nov 2026 16:18:48 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:a062:d8cf:edad:b70c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52033c2d4sm19695417b3.36.2026.11.20.16.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 16:18:48 -0800 (PST)
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
Subject: Re: [PATCH v2] doc: fix AsciiDoc syntax
Date: Fri, 20 Nov 2026 19:18:37 -0500
Message-Id: <85D05F5D-111B-4A60-A923-B45FD514CADC@gmail.com>
References: <pull.2496.v2.git.git.1795199746309.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ophir Bleicher <ophirble@gmail.com>
In-Reply-To: <pull.2496.v2.git.git.1795199746309.gitgitgadget@gmail.com>
To: Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 20 nov. 2026 =C3=A0 13:37, Ophir Bleicher via GitGitGadget <gitgitgadge=
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
>=20
> Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
> ---
>    doc: fix AsciiDoc syntax
>=20
>    Difference from v1:
>=20
>     * Change link text
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2496=
%2FOphirBleicher%2Fpatch-3-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2496/Op=
hirBleicher/patch-3-v2
> Pull-Request: https://github.com/git/git/pull/2496
>=20
> Range-diff vs v1:
>=20
> 1:  748ac69283 ! 1:  cf26060e59 doc: fix AsciiDoc syntax
>     @@ Documentation/MyFirstContribution.adoc: either with the "New pull r=
equest" butto
>=20
>       The differences between using `gitgitgadget/git` and `git/git` as yo=
ur base can
>      -be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitg=
adget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)
>     -+be found https://gitgitgadget.github.io/#should-i-use-gitgitgadget-o=
n-gitgitgadgets-git-fork-or-on-gits-github-mirror[here]
>     ++be found https://gitgitgadget.github.io/#should-i-use-gitgitgadget-o=
n-gitgitgadgets-git-fork-or-on-gits-github-mirror[on GitGitGadget's official=
 documentation.]

I=E2=80=99m happy with this link text, thanks.

>       Review the PR's title and description, as they're used by GitGitGadg=
et
>       respectively as the subject and body of the cover letter for your ch=
ange. Refer
>=20
>=20
> Documentation/MyFirstContribution.adoc | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirs=
tContribution.adoc
> index c58253fd54..73dab5f7c9 100644
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
gitgadgets-git-fork-or-on-gits-github-mirror[on GitGitGadget's official docu=
mentation.]
>=20
> Review the PR's title and description, as they're used by GitGitGadget
> respectively as the subject and body of the cover letter for your change. R=
efer
>=20
> base-commit: f7de81456940dd6f3274e461149bba12965de609
> --
> gitgitgadget
>=20
