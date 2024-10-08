Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4567762D2
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378485; cv=none; b=cD40JPJA1kolupNPI9qQ9f1w/ExSwHwgESK/3tSj0L2jflEBD7X7aba+TocrtGFenH4GJARo7ceiY/NLmJ5Fph50E4NDT2Vqbjqf0Eo9feLKwIf4nbxM0B2DYhDdnt50DqcYWb6WrM4alnA20bVEaaW8xVJNpp6oqG0gntrUcEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378485; c=relaxed/simple;
	bh=XfV9v5hVla1Fnsp5EIF1pj750Z2e/1n4RbcyLY9rLb8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=b4n/mZKxs1ghqfPy4r9chVZA3UfMEcloIIau2p/8dSMxe/jxev/EmRG8v+JW0BjbnfTwU7R9lF4N8uak2g9FWyfd+ULZGaxPIvgUIBb6WXs2K9sdLOGlPj8wo8/cpDZ3TTNGmrOilOUpED15lRDIId5nOfNL+x+vW/V4hiu/yz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=XmrxDszx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lb7aPrVK; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="XmrxDszx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lb7aPrVK"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A59491140086;
	Tue,  8 Oct 2024 05:08:01 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 08 Oct 2024 05:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1728378481; x=1728464881; bh=HeJ0FtdY/rCsfSZf7MjNPhO7nACi7H4w
	ZKaSDqpmqD8=; b=XmrxDszxJGlKLwO3MAM27wlSG1GcbjL64W+Unv41LWgCTV3G
	oWYkBHd+4QpCFBcoPsHzUDegwcB/maXD6mVlgJhd/BHyOYWE/62C3I867vXN7qWw
	uheLe/MTAaWiBqqMhBXml0B7j3EptBnHror7K95D3eGXB/xZ0fWXbek7XY/MvJI1
	uLznkPUw/J1HlO3KLNe0rZscAY85W0mHNcs7Qi5T42ONiVo5wZ1llXkDJ+5nKp5i
	c7CBwZ2Bg6Hfbkd5Hd3Tae4378e9V0C9MR8yE1OPJUum5BKkPJL3C4W0N19AdoNd
	HfJRoIXPYSH6i4XXUm18at0lekQ7wyP0ZXvWww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728378481; x=
	1728464881; bh=HeJ0FtdY/rCsfSZf7MjNPhO7nACi7H4wZKaSDqpmqD8=; b=l
	b7aPrVKVRy428wKD+zwe9qdSitdCbWE/dSOljMDlybaFi5FQsp3+Cpt7uD2VV18V
	bA/AwK825jUj56/ibuhFp5Hqus1mkboiGWx5uq0Sl6VfXFGH9rjsG4y2qfrkIdFZ
	rabX4OoAvxgYmLFKoH2vLF2EFzKI37HQq/NoibyvDm3eS9vBBkIfHKfsh34JJ+Zq
	GehCkw0rEPGCC0Vq/86zA/WDdhwDJYy+C3I2eeJafKq6z4iJcIvn7cvnkALDaT50
	ceVNxVXzLx2an6GRv6l2W22/Qu7Ikwo+7TZZ1AhzMxBhXOjUeMnCt9ziUS8BgKSJ
	HL9KT0TwcgDJnyJ00LLWA==
X-ME-Sender: <xms:cfYEZxRJqKscnEdTn1CmUqmYEeYQU41m3y5sj0GPAhADaSzE3tarM7s>
    <xme:cfYEZ6wxtUYmAcaJoFC36irLBvqYwx7P8PEu4xQ5NC2FZKMcHzb7BJ16XwPnMCLp3
    wykoBbLSgVJ5qXV7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvg
    eskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhephfejgfehhfef
    iefhhfevhfdvlefhvdeitdfgkeekjedtheehkeejhefhvdeltdffnecuffhomhgrihhnpe
    hgihhthhhusgdrtghomhdpghhoohhglhgvshhouhhrtggvrdgtohhmpdgrkhhrrggsrght
    rdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrsghhihhjvggvthdtgedtgedtfeesgh
    hmrghilhdrtghomhdprhgtphhtthhopegrsghhihhjvggvthhsihhnghhhrdhgihhthhhu
    sgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cfYEZ20Gt8_RRh6uUMPFJLDlt3ROEj55unS1fEMjavRgsuiNOV1uLw>
    <xmx:cfYEZ5AWE5iC8bLRummiJVazvdKWGm_EIZpzmvUh6chkpSBHKuuA0g>
    <xmx:cfYEZ6i_ac_bLhrFXwD3Qp5W9AHqryj1sHgy-eaWPpWQAoMDg9mXxg>
    <xmx:cfYEZ9om_jG8tPamriSjO8tXFJ7CMvFLTPYB2ZAMKxVsEvr3EVAntg>
    <xmx:cfYEZ7vNDjX4yqi8g_zsp0SoGGI34ojQwaSy-lf-0xLDvpCjfIF0qSUP>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3AD6F780068; Tue,  8 Oct 2024 05:08:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Oct 2024 11:07:40 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Abhijeetsingh Meena" <abhijeetsingh.github@gmail.com>,
 "Abhijeetsingh Meena" <abhijeet040403@gmail.com>
Message-Id: <dc01d9b3-d5fd-451f-8ce4-411f3a9b4b22@app.fastmail.com>
In-Reply-To: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
Subject: Re: [PATCH] blame: respect .git-blame-ignore-revs automatically
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thank you for working on this.  I think an ability to respect a
conventional ignore list would be useful.

I was a bit concerned that there doesn=E2=80=99t seem to be something to=
 turn
off ignore lists.  The man page says that the discussed option exists
but not some `--no` variant.  But then I tested this:

```
git blame --ignore-revs-file=3DREADME.md \
    --no-ignore-revs-file README.md
```

And that works without giving errors.  So it=E2=80=99s there.  Just appa=
rently
undocumented?

My assumption then is that, with this change, I could use
`--no-ignore-revs-file` to turn off the default file.

(One can also use the config `blame.ignoreRevsFile` set to the
empty string)

On Tue, Oct 8, 2024, at 09:01, Abhijeetsingh Meena via GitGitGadget wrot=
e:
> From: Abhijeetsingh Meena <abhijeet040403@gmail.com>
>
> Modify `git blame` to automatically respect a `.git-blame-ignore-revs`
> file if it exists in the repository. This file is used by many projects
> to ignore non-functional changes, such as reformatting or large-scale
> refactoring, when generating blame information.

Nice.

> Before this change, users had to manually specify the file with the
> `--ignore-revs-file` option. This update streamlines the process by
> automatically detecting the `.git-blame-ignore-revs` file, reducing
> manual effort.

(They can also use the `blame.ignoreRevsFile` config in order to not
have to give the option every time)

The project convention is to use the present tense for describing the
current behavior (without this patch).  Like:

    Users that have a standard list of commits to ignore have to use
    `--ignore-revs-file`.

This style often lends itself to this structure:

- (optionally introduce the wider topic)
- Describe the current behavior and why that is a problem
- Say how we=E2=80=99re changing the code (which you already did a good =
job of in
  your first paragraph).

It might end up something like this:

    git-blame(1) can ignore a list of commits with `--ignore-revs-file`.
    This is useful for marking uninteresting commits like formatting
    changes, refactors and whatever else should not be =E2=80=9Cblamed=E2=
=80=9D.  Some
    projects even version control this file so that all contributors can
    use it; the conventional name is `.git-blame-ignore-revs`.

    But each user still has to opt-in to the standard ignore list,
    either with this option or with the config `blame.ignoreRevsFile`.
    Let=E2=80=99s teach git-blame(1) to respect this conventional file i=
n order
    to streamline the process.

> This change aligns with the standardized practice in many repositories
> and simplifies the workflow for users.
>
> Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> ---
>     blame: respect .git-blame-ignore-revs automatically
>
>
>     Introduction
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>     Hi, I'm Abhijeet (Ethan0456), and this is my first contribution to=
 the
>     Git project. I currently work as an ML Engineer at an early-stage
>     startup, and I=E2=80=99m excited to contribute to this open-source=
 project.
>
>
>     Why the Change?
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>     I came across this enhancement request on the bug tracker and foun=
d it
>     beginner-friendly, making it a great opportunity for me to get fam=
iliar
>     with the Git codebase. The ability for git blame to automatically
>     respect the .git-blame-ignore-revs file is something that can stre=
amline
>     workflows for many users, and I felt it would be a valuable additi=
on.

The issue that is referred:

https://github.com/gitgitgadget/git/issues/1494

That issue tracker is unofficial by the way.

>
>
>     Feedback
>     =3D=3D=3D=3D=3D=3D=3D=3D
>
>     While I=E2=80=99m confident in the changes made to builtin/blame.c=
 and the new
>     test case in t/t8015-blame-ignore-revs.sh, I welcome any feedback =
or
>     suggestions to improve both my code and approach. I=E2=80=99m eage=
r to learn
>     from the community and improve where needed.
>
>
>     Community Need
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>     There is precedent for this functionality in other projects:
>
>      * Chromium
>
> [https://chromium.googlesource.com/chromium/src.git/+/f0596779e57f46fc=
cb115a0fd65f0305894e3031/.git-blame-ignore-revs],
>        which powers many popular browsers, uses .git-blame-ignore-revs
> to
>        simplify the blame process by ignoring non-functional changes.
>      * Rob Allen's blog post
>        [https://akrabat.com/ignoring-revisions-with-git-blame/]
> discusses
>        the need for ignoring revisions with git blame, and a commenter
>        specifically suggests that it would be helpful if Git
> automatically
>        respected .git-blame-ignore-revs.
>
>     I hope this change aligns with community needs and improves the git
>     blame experience for users.

It=E2=80=99s nice that you mention specific projects that use this conve=
ntion.
Sometimes people just say =E2=80=9Cthis is used by many people/projects=E2=
=80=9D.  But
not what projects.  (Then perhaps it is eventually revealed that =E2=80=9C=
we use
it so therefore it is important=E2=80=9D ;) )

> Published-As:
> https://github.com/gitgitgadget/git/releases/tag/pr-1809%2FEthan0456%2=
Fblame-auto-ignore-revs-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
> pr-1809/Ethan0456/blame-auto-ignore-revs-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1809
>
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
>  	init_scoreboard(&sb);
>  	sb.revs =3D &revs;
>  	sb.contents_from =3D contents_from;
> diff --git a/t/t8015-blame-default-ignore-revs.sh
> b/t/t8015-blame-default-ignore-revs.sh
> new file mode 100755
> index 00000000000..84e1a9e87e6
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
> \ No newline at end of file

There should be a final newline. ;)

>
> base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
> --
> gitgitgadget
