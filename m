Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC280049
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953391; cv=none; b=HndUUYF6wytEc8pOOWSYHrJvlrEH+fU02VpLHfCRgLPvECp6NYUmP6Mh18SDImrZj7OYUvxWFaVPiTgifs6wSXvaT3RJ7F8ggDQlAI6AbpjKprBYlBg16RUcn2ogtDh2oIJyyHOuL9R97EMi9J76z2ePYyY3+kR57CajO1RXHkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953391; c=relaxed/simple;
	bh=Wq6+6jpqMTnwTPgP6aRA8dG7nrC1f07mP2VbrEWtp9w=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=tbKibccMezUx9C7Cekafhnv9hKBBqH3b9AG+QeUog/1irVcrKl1LCmasNliUn8oj0vB08W0HCTWulk4EZrPbuCW0u2EN16Wbl5o0kFumcPfupT5qXUQmIkfMv8foE/nEQBRo5r3Fp/eSBdNX+2DXi6fGQ06mCAp7Cr4SyncvuA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=USqOgbXw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DWUA6mSS; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="USqOgbXw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DWUA6mSS"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id CCD60138009B;
	Mon, 26 Feb 2024 08:16:27 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Mon, 26 Feb 2024 08:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708953387; x=1709039787; bh=Wq6+6jpqMTnwTPgP6aRA8dG7nrC1f07m
	P2VbrEWtp9w=; b=USqOgbXwAdTmgSLbOgryewUpZtVWNaUKXpk4z6o9jXMTNAjd
	LnB83cGwHm+/KcUB8RG/bnUT/0mRsesP3dQoKekVV2rdJopdsF3VIz69mz80FSkX
	ZFFEo7sO1AK/ZI2P+WW9D4vjcjDRpD4wk3vv3wz7dR/RTky5f4owFBjhwiQpjzIn
	wrFZTOF/YSdI/cVrFo6nROJoEis7LcLgSUJm1tc2Tr7zhxfVHjXdPFf6TkOMT920
	kx9aTtuQULxFKuzxRBQn9JhHeCwp135qAD/yORUbRlWbQifoIT0unuJNgaw0H1tL
	dfHLP+nnabR/SQz0h8bGGpDI0nxN1otbelMp7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708953387; x=
	1709039787; bh=Wq6+6jpqMTnwTPgP6aRA8dG7nrC1f07mP2VbrEWtp9w=; b=D
	WUA6mSSaRSVZzxnJvKxVkA9BnNoM5IlIagkaWCfdScqEODtfCFkaRJJhfj3MqsdZ
	LqP4t+CmXBtwF7QQ+tPAhYZstrylSJ8DIkqTMR1yEh3ORqur0zemRfV355XrAfIO
	FH7lmWQsnVfYcgY5Wi2qPvw6Z1vJrFju3rgMGDHf9HkjNsLJaQvg3t8qixT9mTSj
	6xHAqrFP1I60YbJ23ZAPXW3kBrvf2okzsKYX2CAE7KmSHQ/vKDs+uCJc9VjD8oje
	IKqdDXUWkqZiL9/zu6Mx0oK2OphlUE59RLKkiJCpUoycU9gDLjZpykV3qMd2Caoh
	EBDDY55fsfNv++S3w/jUw==
X-ME-Sender: <xms:K4_cZc1rClUoetIZ8maUZiVU5y-pDVzA2pzBg_shx20Ee5uWepOKvgo>
    <xme:K4_cZXEwPAGLwMndJfV1qAs58f7cuSRlIBk4SB1lmpYnT2275FW1ATkgRLooKZ9Pi
    t6shoZ8dNzdXjAN-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:K4_cZU5-sjeS-4zkE9RjDO755SQlAkNfIxDViVFpWz50HsTfePLaRA>
    <xmx:K4_cZV1HRW3QwPo8VGsGABOkEZhcDuv0u7GAYD9ASz5rEVxkbr5gEQ>
    <xmx:K4_cZfG0nHC3ZARUSzcrOJ6PZI4VhBx2iFui9qVSLvTMXlEn7pmDog>
    <xmx:K4_cZTj82zhlCjz3OGUy3ad59lP4lziK1AMii3mt8ZKD96_MDbcQ-Q>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 818B815A0092; Mon, 26 Feb 2024 08:16:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <11783b8e-472d-4b75-bb48-88138daf16ae@app.fastmail.com>
In-Reply-To: 
 <CAOLTT8SQyBSWC=aqB2SRYmp3kR6RZ+L_-9yckWQf-X9rbzeNBw@mail.gmail.com>
References: 
 <CAOLTT8SQyBSWC=aqB2SRYmp3kR6RZ+L_-9yckWQf-X9rbzeNBw@mail.gmail.com>
Date: Mon, 26 Feb 2024 14:16:06 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "ZheNing Hu" <adlternative@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Christian Couder" <christian.couder@gmail.com>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Git List" <git@vger.kernel.org>
Subject: Re: [Question] How to parse range-diff output
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024, at 08:25, ZheNing Hu wrote:
> Hi,
>
> I am currently looking to implement a service that provides a version
> range comparison based on git range-diff. I can easily parse out
> commit pair headers like "3: 0bf6289 ! 3: a076e88 dev5," but I am
> unsure how to parse the details in the subsequent diff patch body.
>
> It is not a standard diff output where one can parse out the filename
> from the diff header, It should be called a diff of diffs. We can see
> various headers with file names such as "@@ File1 (new)", "## File2
> (new) ##", or "@@ File3: function3" in different formats. This is
> confusing. How should we correctly parse a range-diff patch, and do
> you have any good suggestions?
>
> Thanks for any help.
> --
> ZheNing Hu

Hi

Note that =E2=80=9COutput Stability=E2=80=9D says that this output is no=
t meant to be
machine-readable. It=E2=80=99s for human consumption. It=E2=80=99s not t=
extually stable.

So a new version of Git might break your implementation without warning.

--=20
Kristoffer Haugsbakk
