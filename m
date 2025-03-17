Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863CF17A2EA
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231021; cv=none; b=j3X92wGm8CvOMLMSIaf7DNOJDSUMYLpU9J6YZTAY+FkAiFk056U/OJtLN9jOFXMEM64jKUOb9g0rEY0D8LskYHGxZU4DRNC68UySvMDL2e0yIB2sxJFkfQRjtY0LHdUKuJArspMH9G8OfTlFrs1lmxdyfQSkc6tyx4HqvoOY0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231021; c=relaxed/simple;
	bh=YeGL4eH33vT9f/5DRzfep/leo/4nIkd2ovyY/wFuO3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tOtox1/wtcMyC5QRCbqPOG9og8M6Cb8nactPE14Hs4O2DLIrYlyfzGMHuxWORsNJ0eDz5BqOKV9lBwVDUC4+0400yPKUbdm64bjkIyORev+sxMyu8gBYbGOOo4rcqPVqPRtpyyGByd2yEi3S2dns6ILtDVFohkwqV/OKeHW8uEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zplMabRz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sN5w7vfi; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zplMabRz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sN5w7vfi"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 973A1114008A;
	Mon, 17 Mar 2025 13:03:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 17 Mar 2025 13:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742231018; x=1742317418; bh=gxgzi/L/0R
	YESlot86ZbYYIX1UU3rM49Y+gMr5midvA=; b=zplMabRzSDQRWTjpTTM+hwIn/v
	sPXX2jZFizBFqUMzeJsyAmrazZkWdf9KOADjqKZmUOwhvbaNYzvynWqShg9zv/Pt
	xhwKvB6zZD1vI++KwT/KzvS2P1VsC5nBjsnIgmnFzMIhE577jjd6Xc4blbbU+mwr
	tuH0NHwPpD3jVguGfVMH+RCBa2UmYV7XZUGgyHfJsvdGONAn3Qz3GFsCwl3i47G2
	OT6ykNnjcvzMULl3i8pjXNkGkseS3dAWoYzn8xju+MoJ/Owa2YUqu2FurAa8dg0Q
	b37CMM9mVVloHI06qMAh17GgwlQ8OI33meNUhLjNvVA/o90i9YDSyZzUCYrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742231018; x=1742317418; bh=gxgzi/L/0RYESlot86ZbYYIX1UU3rM49Y+g
	Mr5midvA=; b=sN5w7vfiT5tiPAR2j3yP2v7f6ptvDFmcYhT2VQ53nCR0aAIZVrB
	TJSV6zh3mm3XRRvFW7n5svEMDS2wSE1skNBle1gSTreelWh+fEK6fIwQTcl/Q8oH
	MiXgo7k9dO9ZXX4Bo7wOb+VDRdo5GDf1XSUBSm7bknccECVpRaYytZrPCunhMI/E
	vGMYwbXSRXwBhpjc9oSbFCo8VYw50frxmKbiqJdkdUDIX/pGE/lthQztZ/Tq+BMc
	NCCuzWtZis5w8DYjP9ZxJOuf4JaPZMRdsZVgxgh6MYPFFQyGg4uvEsLiKTgPFBuP
	945VGFjHC+BWmEsvg4D4YYDauBGSjo3ajww==
X-ME-Sender: <xms:6lXYZ4_6tKhiJKPZuLAO2iXJ22BcBPqAxef44dcCnI-bS6_rysUVYg>
    <xme:6lXYZwtF9bP4C1LpMdII6Mu1C7_LaVnCH6fQG1khz8PHRnhccLMvWiuW9PSET8O01
    5QQDuMBxPw6lAn_4g>
X-ME-Received: <xmr:6lXYZ-Cf-iJ9m5ZogM-yBF-NIHUcI5enJDaNFwDERRx8aLf9Xk2k8RcqtLodOEq5taTVnsUiEcXfCUEQQs2W0Ysx7ZQSxQ54R-2BnJI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedttdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepkeeuffdukeejvefhgeeuhfeiueeggfek
    uefhffekuedugfettdekleeludffueejnecuffhomhgrihhnpehgihhtfhhorhifihhnug
    hofihsrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggv
    lhhinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtqdhprggtkhgrghgvrhhssehgohhoghhlvghgrhhouhhp
    shdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6lXYZ4e-vPc9ufYSOgJc8hW0VqjUqFQdhFU0B-ynNwzWHqz7eUfv-A>
    <xmx:6lXYZ9MtQgExmsS_9Yq27Vdcppi3tp2sGDcbLcj53ZtijRT-P3wMDA>
    <xmx:6lXYZymxw7cu_xfdTPLePlmm7YxPAxZqG9zUv44AjMRo0YhHpu2Hcw>
    <xmx:6lXYZ_vV5mHYpJdxUlib5lI6dATZzhkiS17sqddrQc9zKE6TRmrN_w>
    <xmx:6lXYZyoJ4STYMuwXRo_sJ_7zvZ-VMP4xtW29_UEOWRJmltSJoGzz5vJQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 13:03:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git@vger.kernel.org,  git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.49.0
In-Reply-To: <1MSbxD-1tn8ja1MCn-00W0XL@mail.gmx.net> (Johannes Schindelin's
	message of "Mon, 17 Mar 2025 11:34:02 +0100 (CET)")
References: <1MSbxD-1tn8ja1MCn-00W0XL@mail.gmx.net>
Date: Mon, 17 Mar 2025 10:03:36 -0700
Message-ID: <xmqqwmcna8t3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.49.0 is available from:
>
>     https://gitforwindows.org/

Thanks.

> Changes since Git for Windows v2.48.1 (February 13th 2025)
>
> Due to persistent maintenance challenges and the community's limited
> engagement and usage, git svn support in Git for Windows will be phased
> out over the next few months.
>
> Git for Windows v2.48.1 was the last version to ship with the i686
> ("32-bit") variant of the installer, portable Git and archive. Only
> 32-bit MinGit will be built for future versions, until April 2029.


>
> New Features
>
>   * Comes with Git v2.49.0.
>   * Comes with OpenSSH v9.9.P2.
>   * Comes with PCRE2 v10.45.
>   * The previously-experimental --full-name-hash option has been
>     accepted into upstream Git as --name-hash-version=2 and is no
>     longer experimental.
>   * The git backfill command has been accepted into upstream Git; Its
>     --batch-size=<n> option has been renamed to --min-batch-size=<n>,
>     though.
>
> Bug Fixes
>
>   * A change in upstream Git v2.48.0 broke renaming symlinks, which was
>     fixed.
>   * On a recent Insider Windows version, users experienced the message:
>     "Cygwin WARNING: Couldn't compute FAST_CWD pointer", which has been
>     fixed.
>   * A bug has been fixed that, when calling git add -p from VS Code's
>     internal terminal, after using the edit command, caused the
>     internal terminal got stuck and no further command was accepted.
>   * The syntax highlighting of the nano editor was recently disabled in
>     Git for Windows by mistake, which was fixed.
>
> Git-2.49.0-64-bit.exe | 726056328967f242fe6e9afbfe7823903a928aff577dcf6f517f2fb6da6ce83c
> Git-2.49.0-arm64.exe | 490ea5c2a1cb3ca4071079e262d1cba9331252cad1b76f9df1e89f04a09e761b
> PortableGit-2.49.0-64-bit.7z.exe | bc980a64e875304ea5aa88386fda37e8a0089d0f2023616b9995b1ca75b471dd
> PortableGit-2.49.0-arm64.7z.exe | 8fa7e49b319b1109173a90a110aaeb0e9004600ff2ed44adc7dfe56ab21e4148
> MinGit-2.49.0-64-bit.zip | 971cdee7c0feaa1e41369c46da88d1000a24e79a6f50191c820100338fb7eca5
> MinGit-2.49.0-arm64.zip | 847bbe519443cd24c716f490a769056a35f42474cafb757663e1dceca159e911
> MinGit-2.49.0-32-bit.zip | 6d6439436d537624f619ffbf5dba49bcdc4ee1219c5c2756277669928fba2b74
> MinGit-2.49.0-busybox-64-bit.zip | 600d27b4ed7d86f9bc908c3e6563cfdd14f746dee1e91d5f714bfc9e7472cfb1
> MinGit-2.49.0-busybox-32-bit.zip | a6f1b25a1c910381b0886ff37baa3d77d3b662e0a54114ca19244a3f3e9381b6
> Git-2.49.0-64-bit.tar.bz2 | 6c5d66e3dd6cd44e50ba7892e9e24ace57934f277a3424c9702a400b3fedc1eb
> Git-2.49.0-arm64.tar.bz2 | 48109aaccc5387df498c6b91e5f25c27201dac80b62cae3c576d922b3129a66e
>
> Ciao,
> Johannes
