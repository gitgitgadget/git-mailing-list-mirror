Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D579D36C
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731629512; cv=none; b=VFp7CV84iZEyMwYMpzpDGlVo0ZK5pecyj5w1xz1jBek0LrHdnFAWetsZ/XBD2LcZAMv4BYOKoWbcmSzXEJO2Ra38Qzs+xJVqodcdevgbpCz3b1md7WwVs2GczNK+e7JOM+TJn8dVRhyODrLUFVc/9vBuqrhCeAhq1nYRYVzdh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731629512; c=relaxed/simple;
	bh=0/Vkfma8qHI8j0tPvhBzrHpCdt4JRQOpjP5spw+AAXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VZCCCV3yZK8QSv7fvGVIjXCkUVG592hgx6+N+TZcktQrMNzVxNzR2a/kh6bFEs/OTXZ/BrmU5q/gCoOB59z1W4tI/5UguHuTd+fNN+em7P1ObVYQHhBMDp6KOpzrhjDCo5EKWBqmeuW9RqSzYGHKLfGkcJlgCPaiMVnMDx04svw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kSe/NVt2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kSe/NVt2"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD03D114013A;
	Thu, 14 Nov 2024 19:11:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 14 Nov 2024 19:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731629508; x=1731715908; bh=uHfw9FZ0v5aDVsSTu39jjeEjPN0o5WkKnUc
	BQbgxL/U=; b=kSe/NVt2IozaE5Zaak8pWoCddFfP+mmOZ3rcWshH1Qqycv2W4cl
	2GKHoEUrIgyhfXjGaC0gxWsZbuFwbjMQCi7XhqPcHoy5Ksz973VCMLdmZCRh0xgs
	bgHa6AzCTOHnRxzyRmMQ64t+IUB6xV73SUgiNBou0yFvnaTYkL37DcwOubAxAnhI
	/E57XE9T4kkWOt47ZrlHxY1zYhXxBgdalcMUATwnV3h1J5ndm8Pg+giKsGajwNhP
	4Yo+muuec5AVrAK4LXFvGYdxu6jc+ugcF+6E+APpuEkMpwz70+GZGPIGmxsukMvk
	OV+9o3ixNvlPOp13hW6x7WBwvn3oX0MsxUw==
X-ME-Sender: <xms:xJE2Z75uzqm3e00s8OIDQyn9WSjMRnVQ0UGH34ZCHzf1QjocsSz3hg>
    <xme:xJE2Zw73gefJccoyel9GYdkzMUOLaci-2nKrFjz2O4EJKPU69PXFDrDHbThAhw3J9
    rInLPpXvKJ1X-rH6Q>
X-ME-Received: <xmr:xJE2ZycdlTJkCb1NQMYdCMIssAtKipZ_z9aF-rsTuLb4DnpNuIU84nGThjyMJA2qBbpMeCnnQwC1sypdTuA_3rH31wk87ZfczDdp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghm
    ihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xJE2Z8LfhXjo4kf9tBjsqbMfnVPwbgwVm01fdNJLHOIQLk_kuwzZxg>
    <xmx:xJE2Z_JVJFc_ZXX_7VsMuGealfD-nqNFTSd0ktBmnFj-uKSCuC6eYg>
    <xmx:xJE2Z1ygrleA4F4mrTVPR68OSsaSoQJF83-8neD94adKay9Cdc9qaQ>
    <xmx:xJE2Z7KA2kiuloEeDeMayuv7_RlN6L9_fhhCE68SJqzhyx9VDjkNMA>
    <xmx:xJE2Z1jldDMRk_RC6AVNOZt4vqU7EwNqWdp7-0yebeemJZUMVapmPLWC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 19:11:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  Usman Akinyemi via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] diff: update conflict handling for whitespace to
 issue a warning
In-Reply-To: <29c81cbc-3678-4b70-9e0e-c500186d159f@gmail.com> (Phillip Wood's
	message of "Thu, 14 Nov 2024 10:06:12 +0000")
References: <pull.1828.git.git.1731347396097.gitgitgadget@gmail.com>
	<pull.1828.v2.git.git.1731524467045.gitgitgadget@gmail.com>
	<xmqq4j4a8srw.fsf@gitster.g>
	<29c81cbc-3678-4b70-9e0e-c500186d159f@gmail.com>
Date: Fri, 15 Nov 2024 09:11:46 +0900
Message-ID: <xmqqbjyh5pa5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Usman - when you're writing a commit message it is important to
> explain the reason for making the changes contained in the patch so
> others can understand why it is a good idea. In this case the idea is
> to avoid breaking "git diff" for everyone who clones a repository
> containing a .gitattributes file with bad whitespace attributes
> [1].

Hmph, it would certainly be a problem, but the right solution is not
to butcher Git, but to make it easier for the participants of such a
project to know what is broken *and* what needs to be updated, to let
them move forward, no?

> As I mentioned in [2] I think we only want to change the behavior
> when parsing whitespace attributes - we still want the other callers
> of parse_whitespace_rule() to die() so the user can fix their config
> or commandline. We can do that by adding a boolean parameter called
> "gentle" that determines whether we call warning() or die().

I doubt that such a complexity is warranted.

It depends on the size of diff you are showing, but if it is large,
then giving a small warning that gets buried in the large diff is a
conter-productive way to encourage users to correct such broken
setting.  If it is small, then the damage may not be too bad, but
still, we are showing what the user did not really request.

If we were to fix anything, it is to make sure that we die() before
producing a single line of output.  If you have a change to a path
whose "type" is without such a misconfigured attribute, that sorts
lexicographically earlier than another path with a change, with a
conflicting whitespace attribute, I suspect that with the way the
code is structured currently, we show the diff for the first path,
before realizing that the second path has an issue and then die.

If we fix it, and then make sure that the die() message shows
clearly what attribute setting we did not like, that would be
sufficient to help users to locate the problem, fix it, and quickly
move on, no?

Thanks.
