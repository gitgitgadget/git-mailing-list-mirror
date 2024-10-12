Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17CA188599
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728741507; cv=none; b=JheH7bSiiOLxpKRy1sc7aKqaLh8xQvYaPTedFMW4LduWKIr37JjLMzKrry1W74muxja9GjH50pJwLZqDfyMUoDixQiAE6RbGYZUwZHhxzEx46P5dlRZrx+GxrZ+C2VB/XbTt2qyba/THWZcBiQcf4diLy1tFSOr2zbGRaLLWOjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728741507; c=relaxed/simple;
	bh=KC+CVxVnr5t6eM3IiF+d5zbJZDKZhjL0C3PL68fYK7Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Iw0nqGP2XkWR3RgK7ifJ50SykzQuz2k//PLd4m31B+fnZx6c4Z95HT3Lhmuf6YtTzrhf3YC2lTem/knt/eXIQrod+qt48qyn6Oa/7aDfVcoIIloaY9RliYGhkyhAM96Wk7w+deoThWbkWAKvX0n0MAtWv6jwAzAJHAnFNSnp0ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=c1MT4lQE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mCZ+TFmM; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="c1MT4lQE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mCZ+TFmM"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CC18111401C7;
	Sat, 12 Oct 2024 09:58:23 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 12 Oct 2024 09:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1728741503; x=1728827903; bh=y2SGPCTPTa9HX1bCRM7LtxcILJYYAUQo
	yPYrtslLrac=; b=c1MT4lQEEFaKqnc7J7kFUh9EuVa0VaHxnpYe17xvd7gJao5D
	+6MbbNfeoLyhTplbmw10PycQ3ZMkY3ii8kUaaBnrq5QTftmiDbSjj3DM3/DWx1LO
	H0Yle83gqi4OIsC9YZNNlAHhQwnq+tK+eA2P5t5Ko6WSp8kBoF+bYsOauJYMMBQR
	VMp6KhCPUqLR+g+iEXX+fupj0Vtn6sXyo0Tsuqba5066TISB/bRiLbo92O26jTha
	ACAEpAX8D8F3IyGMcJ82cHYR/xTv5mHD2dJ2yvbE+mtERan/zAJImrAtB155/l5t
	8G12Cy1zAa0JBr4VOZbyjeNZ2fC+amhbl7OptA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728741503; x=
	1728827903; bh=y2SGPCTPTa9HX1bCRM7LtxcILJYYAUQoyPYrtslLrac=; b=m
	CZ+TFmMrF+l6ipamF2pRSYQy/WPXPeB8qUBg3CRxvtJWxxRfnxVMT5qk2RK+tguu
	Qgsb1jb0OCuQMTa//V+em4IZyLsz3vZ+sXBCEonvHkYrSbVbCKyzJOc2TJLuvskz
	80WG0M6VlzqszWaBvQzSi5mTfENrb0YVDDAcDpz5Tj1YJlrTJRE+kkolbhpIFV4O
	DcmgOHWNoUYAP3freE0aWwVxgx9XmXuM/xFlr+zPPfmUh5NvOmrRSGyorrpQ2dZo
	yDCBdrwiRlzj4S5RosOgBuagr7VVAnlp0eEWHAlcN9ng6wLBjNbeFWdj/ZzrDOQ+
	JTTidRYpshxbr0nmWl/yA==
X-ME-Sender: <xms:f4AKZ0oZpqSSOI-NuAGVz8QeTDqJ334NZvp2bcvdIjZktyPoKivMAco>
    <xme:f4AKZ6pcnxn8GBlvk3eI9kJCYDKP7-f1HX9VYyrG3US4KdSn-2Lk0AF3Ef8y_7KmV
    sneD1zQ8nZDiy_Fuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeguddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvg
    eskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepfeetgefhgeef
    veelgeduvdekteehieevffdujeelgfduffffjeelffffledukeejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgs
    rghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegrsghhihhjvggvthdtgedtgedtfeesghhmrghilhdrtghomhdprhgtphht
    thhopegrsghhihhjvggvthhsihhnghhhrdhgihhthhhusgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:f4AKZ5OIM-Y4DcKF2dYq7eFjcmQiQc-oIywO1xzMLVM_ZexD9E_gOw>
    <xmx:f4AKZ76kDPeI-nOm92z_qRGe8R0xl0U3b8CoKNBDMtICpcoNC9eObQ>
    <xmx:f4AKZz6d0GuKwFSWR25kVg3rAjA8SMVtqQ6Wvmxqd8KF__11Nx3xow>
    <xmx:f4AKZ7hDJ4-L7O7oYTHwgKRv4B3HMCNSWMeuymGzY4-MuD0R1MyEKg>
    <xmx:f4AKZ20D_84ye-ZOmk5x1tZLldBcLKDcr_VJ3HtPP-PZkYFjXIEU3CIl>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 73944780068; Sat, 12 Oct 2024 09:58:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 12 Oct 2024 15:58:03 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Phillip Wood" <phillip.wood123@gmail.com>,
 "Abhijeetsingh Meena" <abhijeetsingh.github@gmail.com>,
 "Abhijeetsingh Meena" <abhijeet040403@gmail.com>
Message-Id: <4f835282-d921-4cd3-9680-d8522bef7b39@app.fastmail.com>
In-Reply-To: 
 <4ed930cab1b7f5e9738e73c7b9374d927a8acd94.1728707867.git.gitgitgadget@gmail.com>
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>
 <4ed930cab1b7f5e9738e73c7b9374d927a8acd94.1728707867.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 1/2] blame: respect .git-blame-ignore-revs automatically
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhijeetsingh

For what it=E2=80=99s worth here=E2=80=99s how I imagine this feature co=
uld work
conceptually:

Before this feature/change, the effective config for Git use looks like =
this:

```
[blame]
```

No `blame.ignoreRevsFile`.

But with/after it:

```
[blame]
	ignoreRevsFile=3D.git-blame-ignore-revs
```

This is the effective config.  Not what the user has typed out.

If the user types out this:

```
[blame]
	ignoreRevsFile=3D.git-blame-more-revs
```

Then this becomes their effective config:

```
[blame]
	ignoreRevsFile=3D.git-blame-ignore-revs
	ignoreRevsFile=3D.git-blame-more-revs
```

Now there are two files: the default one and the user-supplied one (this
config variable is documented as being multi-valued: =E2=80=9CThis optio=
n may be
repeated multiple times.=E2=80=9D).

=C2=A7 How to ignore this new default =C2=A7=C2=A7=C2=A7

Considering users who do not want this new default:

```
[blame]
	ignoreRevsFile=3D
```

This is the change they would have to make.  Because a blank/empty
resets/empties the list of files.

On Sat, Oct 12, 2024, at 06:37, Abhijeetsingh Meena via GitGitGadget wro=
te:
> From: Abhijeetsingh Meena <abhijeet040403@gmail.com>
>
> git-blame(1) can ignore a list of commits with `--ignore-revs-file`.
> This is useful for marking uninteresting commits like formatting
> changes, refactors and whatever else should not be =E2=80=9Cblamed=E2=80=
=9D.  Some
> projects even version control this file so that all contributors can
> use it; the conventional name is `.git-blame-ignore-revs`.
>
> But each user still has to opt-in to the standard ignore list,
> either with this option or with the config `blame.ignoreRevsFile`.
> Let=E2=80=99s teach git-blame(1) to respect this conventional file in =
order
> to streamline the process.
>
> Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> ---
>  builtin/blame.c                      |  8 ++++++++
>  t/t8015-blame-default-ignore-revs.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100755 t/t8015-blame-default-ignore-revs.sh
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index e407a22da3b..1eddabaf60f 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1105,6 +1105,14 @@ parse_done:
>  		add_pending_object(&revs, &head_commit->object, "HEAD");
>  	}
>
> +	/*
> +	* By default, add .git-blame-ignore-revs to the list of files
> +	* containing revisions to ignore if it exists.
> +	*/
> +	if (access(".git-blame-ignore-revs", F_OK) =3D=3D 0) {
> +		string_list_append(&ignore_revs_file_list, ".git-blame-ignore-revs"=
);
> +	}
> +

I have not tested these patches.  But I see why you check for file acces=
s/existence.  Because with this config:

```
[blame]
	ignoreRevsFile=3D.git-blame-ignore-revs
```

I get this warning in repositories that don=E2=80=99t have the file:

```
fatal: could not open object name list: .git-blame-ignore-revs
```

Which is just noise.

I get the same thing with Git Notes namespace configurations.  I need to
configure them for certain repositories (like `amlog` in this project),
but then I get warnings about them when using the relevant commands in a
project that does not have them.

Maybe this is totally off-topic but I think it would make more sense if
`blame.ignoreRevsFile` just didn=E2=80=99t say anything if it didn=E2=80=
=99t find the
file.  Because the point of the config might be to opt-in to this file
for those projects that does have it.

>  	init_scoreboard(&sb);
>  	sb.revs =3D &revs;
>  	sb.contents_from =3D contents_from;
> diff --git a/t/t8015-blame-default-ignore-revs.sh
> b/t/t8015-blame-default-ignore-revs.sh
> new file mode 100755
> index 00000000000..d4ab686f14d
> --- /dev/null
> +++ b/t/t8015-blame-default-ignore-revs.sh
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +
> +test_description=3D'default revisions to ignore when blaming'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> +. ./test-lib.sh
> +
> +test_expect_success 'blame: default-ignore-revs-file' '
> +    test_commit first-commit hello.txt hello &&
> +
> +    echo world >>hello.txt &&
> +    test_commit second-commit hello.txt &&
> +
> +    sed "1s/hello/hi/" <hello.txt > hello.txt.tmp &&
> +    mv hello.txt.tmp hello.txt &&
> +    test_commit third-commit hello.txt &&
> +
> +    git rev-parse HEAD >ignored-file &&
> +    git blame --ignore-revs-file=3Dignored-file hello.txt >expect &&
> +    git rev-parse HEAD >.git-blame-ignore-revs &&
> +    git blame hello.txt >actual &&
> +
> +    test_cmp expect actual
> +'
> +
> +test_done
> --
> gitgitgadget

--=20
Kristoffer
