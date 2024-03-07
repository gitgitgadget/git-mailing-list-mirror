Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA45912F361
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824758; cv=none; b=BReKgPaPRE/TQf96FMOP7vT8SSbIc1LEJ8nKu0gDJ9adMACgoaOzPhHZQAIItoc6MSk3D5H1hZCI40HYzk04bWw0nMp9bEJ4t9ZwjDTUiy03mNOw1A3u91ZMHhdq4P/GGeKtVx2Oq4pcVEi7mFGqPeDjSXkjyirYp9QdNtFHxCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824758; c=relaxed/simple;
	bh=QdrAOf1ENs3dAaow0AaBJbuKfjX4OKBqnbydVFPcBEo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HyMhmUWTlphTZ7SafBUBNJd5xBvjIfPoyBVlUir4OT8/HTFLdRInd8c3sTZO03lEWxyYZnQVIobU04GJ59kPQ+EV3FbhRaz/zm8JvwJbGX8eno27vaVL5AqkIA+5bsxzdjHF9hvHn2ONukvq4W2ipF+OjBsyKHaG7Ca22PevyVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Wc3yx0kp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dvt/ax47; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Wc3yx0kp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dvt/ax47"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id AB1F11C0007D;
	Thu,  7 Mar 2024 10:19:14 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 07 Mar 2024 10:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709824754; x=1709911154; bh=NzCGxDDQjEHrUyUifM4Aavb+oAZUTzvn
	K81Cc2yMUHQ=; b=Wc3yx0kpwRcJRUMBlni7uF9o3V1uheD+B+sgrBBEKscAAoj1
	0koWtujy0ygr8bjQ0Q/B+AetG0rch3PB2GjZjKuFm+s4bNHIDQsRvylJoFRA0hSU
	imwelrAPuOpSBxnFKg3OVoDEFa+czy3irwmgKyzAZIjrQlPswfrCEaEgGGv4BSD7
	GDdLkfzv3HjdBlImMN69XgRO4DUXbDjkv+ar0tFpeK+VeBjmHnsexuR/k693is8z
	vtgJTGDXZ12evVQ1s+b4ZJcY3DmON2J7JIcKc4Bq5Rb8VKWt1SuW0te0182lnBzd
	Hoh+M6r3Rc5GmkN8YSsBfrZDUuJ5msrdbttFDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709824754; x=
	1709911154; bh=NzCGxDDQjEHrUyUifM4Aavb+oAZUTzvnK81Cc2yMUHQ=; b=d
	vt/ax47Pbo/RMuNJrtyxZcw1lirO3j9SbB5xMPDqNkKd5kh4js/iUXyXDKQW6bJ7
	MVqaeDZmX/ShkoACGRRnTfDMNieKmYmz7J1g0tgB6UBfj1rDBfDdjoabnQ/hrrNU
	5YCMz+uD/NaXnilA+Kn+cZnb0Ms2ZULtvqojBkBpL3ouujOnlj/KDFjAWecHxfBs
	wl1LhEmfYSQXhsm5VFSE/rNgEnpSaKTXCXnxvxkZmR6BGDUtEy9oTb2BaupURl2w
	XMhgT5eAUgCkLL7iuk/F6Zc36hMUFjYaf3DCPSqvQl+vhyZbAi1qhfYkTq1VMld9
	C6WTkzG6IHm/0I6T25zfA==
X-ME-Sender: <xms:8drpZXexsmev8n1WFkRinFsg5IVYqt6TWGp9S3kIpkebcF-ulMsXzK4>
    <xme:8drpZdOVMMaYWlHqSnclFpwBQhOKK_HsvSV3cfnNCuUGMG8DUqTJUn5YkTaELMGtm
    6LYwLklz9mtKAG5cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:8trpZQi1LxnqE39rXSGpQXvftKQtaFNiEkHR_wsCXS3mdUpQEBgkGw>
    <xmx:8trpZY-wOK6WYAbWxeNSeszhyjL5D2KxMNSSmz5FpYlCu3oOJQGG0Q>
    <xmx:8trpZTtr2x5rXQZKJJ56zMz0XUCeSrKBFzrdJgWy_apgrJu5StlV2A>
    <xmx:8trpZc6ENCPFrkKPg7ym2pccHVdRpLnlSZTPhh9saJUsYuUSgFsKneUN-UA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E1A8C15A0092; Thu,  7 Mar 2024 10:19:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b2555c2c-0725-4d33-853b-e17022689977@app.fastmail.com>
In-Reply-To: <xmqqo7buuce7.fsf@gitster.g>
References: <cover.1709495964.git.code@khaugsbakk.name>
 <4140fca4f454310d215df8bdac237caeb5c38521.1709495964.git.code@khaugsbakk.name>
 <xmqqo7buuce7.fsf@gitster.g>
Date: Thu, 07 Mar 2024 16:18:52 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Phillip Wood" <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/1] rebase: teach `--exec` about `GIT_REBASE_BRANCH`
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024, at 00:24, Junio C Hamano wrote:
> Kristoffer Haugsbakk <code@khaugsbakk.name> writes:
>
>> The command fed to `--exec` might need some contextual information fr=
om
>> the branch name. But there is no convenient access to the branch name
>> that we were on before starting the rebase; rebase operates in detach=
ed
>> HEAD mode so we cannot ask for it directly. This means that we need to
>> parse something like this from the first line of `git branch --list`:
>>
>>     (no branch, rebasing <branch>)
>>
>> This is a moderate amount of effort for something that git-rebase(1) =
can
>> store for us.
>>
>> To that end, teach `--exec` about an env. variable which stores the
>> branch name for the rebase-in-progress, if applicable.
>
> You seem to be saying that `git branch --list` output already
> contains the necessary information but it is shown in a hard to use
> format.  Is the information given at least always accurate and
> reliable?
>
> Assuming it is, do you know where "git branch --list" gets that
> information when it says "(no branch, rebasing <branch>)"?
>
> git-rebase(1) is already storing information sufficient to let "git
> branch --list" to produce that information, and there are other ways
> to inspect that state ("git status" gives the same information but
> it also is in a "meant for humans" format).
>
> So, isn't it just the matter of surfacing the information that we
> are already recording and is already available in a fashion that is
> easier to use?  For example, if "git status --porcelain=3D[version]"
> does not give the information, perhaps you can add a line or two to
> it, instead of duplicating the same information in two places?
>
> It comes from wt-status.c:wt_status_check_rebase() where state->branch
> is assigned to, by reading "$GIT_DIR/rebase-{apply,merge}/head-name".

Okay, thanks for the code directions and input (both). I=E2=80=99ll try =
to get
back to a rewrite on this topic in a while.

Cheers

--=20
Kristoffer Haugsbakk
