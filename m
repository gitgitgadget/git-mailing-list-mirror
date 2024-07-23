Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAED153810
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752595; cv=none; b=i8RvgdiOg5zhD/+24Aa30ZCE+CPdHFtQ9Pbw7CmAdv+cDISFy/t7WWi60BY050kgM8K9nXp39a8fPAVELtb7TC6ZdbKeVOBJHDz7iWmygiEP7s4AtuGMaX4ayRpYHPDG1ZD6eSiX54GfmPNNLEDC1J9aF9Bje5YjxUny4IlpBos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752595; c=relaxed/simple;
	bh=w346joGELjeis63Oe/cNZ9OFz9pMLMOGAWLfMELTGjE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YsQpJ+JI65LdckbzGfdcLnUgfN9pwc7dqasLXlBNklh+6pkkFzduWsrM5Ypx/vsB/q4tdpzklh8+d+yHFPkoS5ew718rLhHzKypOCK0vATA6IFC8zL76EyoK9DDGrUkgf4ueB/cphC2fH0kZBRLXl8n3QVra5ca+ax7NqS1Y7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mBSEps2J; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mBSEps2J"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721752583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gx6HE8OxI69ow2pc02mMN9pFV3fvBGTWq65LEVHiyVM=;
	b=mBSEps2JdTuTS4ewtw9GFK2N0tCUFgRJMn3ED5n/perBsNMQRKbmbSopHpmB8hQOTWPRlV
	UnxOPV2lKzBB2R5mBoRhUPYRD9PiKZ8Jgf7CAL0+ML6eyr0DNH5Pa3jJMNzg5A8CgS0itg
	QRKd4E1mm5RnhRqV5UEwTwiPejltgkeCiXgTiN29wcjwUSMQUryoOaVVB9VpeJ369WIAMx
	gDBEK0bz3TzkjQfrToPmmqG6iutORkJFIymkOUV9GbXt1f1huVT7nQRDM9kfg809NX2aFD
	DPw73Cg5jxXp16miN4sH605l8zVuhn7+B9jHYf09o8//nsRCGMYrmrv8DOFhdA==
Date: Tue, 23 Jul 2024 18:36:23 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, "Schoonderwaldt, Michel"
 <michel.schoonderwaldt@sittard-geleen.nl>, git@vger.kernel.org,
 git-security@googlegroups.com
Subject: Re: Request to Update OpenSSH Version in Git due to Security
 Vulnerabilities (CVE-2006-5051, CVE-2024-6387
In-Reply-To: <a658fd0a-59bd-c162-874c-cc5b9926acd5@gmx.de>
References: <AM9PR07MB71854BD4C1CE7E517203FFB6B1DF2@AM9PR07MB7185.eurprd07.prod.outlook.com>
 <ffe00b81-5f19-a073-9a9e-ee84b7d3845b@gmx.de> <xmqqa5ipxjdr.fsf@gitster.g>
 <25ce4ec25b054cfbf4c540663c6b6c18@manjaro.org>
 <a658fd0a-59bd-c162-874c-cc5b9926acd5@gmx.de>
Message-ID: <9b075f5b19bc6e31a0f4a829dbc623e8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Johannes,

On 2024-07-22 11:38, Johannes Schindelin wrote:
> On Wed, 10 Jul 2024, 'Dragan Simic' via Git Security wrote:
> 
>> On 2024-07-10 19:10, Junio C Hamano wrote:
>> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> >
>> > > The crucial part is the `sshd` part. Git for Windows does distribute the
>> > > `sshd.exe` binary, but it is in no way used by default, nor is there
>> > > support how to set it up to run an SSH server.
>> > >
>> > > Git for Windows is therefore not affected by this vulnerability, and
>> > > therefore it is not crucial to get a new version out as quickly as
>> > > possible. See also my assessment at
>> > > https://github.com/git-for-windows/git/issues/5031#issuecomment-2199722969
>> >
>> > I think I've seen in the past another inquiry about vulnerability
>> > in OpenSSH, which turned out to be irrelevant in the context of Git
>> > for Windows for this exact reason (i.e. "sshd" is problematic but
>> > "ssh" is OK).
>> >
>> > Would it make future confusion like this less likely if you stopped
>> > shipping the sshd and ship only the ssh client?
>> 
>> Not shipping sshd.exe would make sense regardless of the associated 
>> security
>> issues, because it would prevent accidental enabling of SSH access.
> 
> There is little accidental about starting `sshd` after generating a 
> valid
> host key.

Well, I don't know what and how Git for Windows does regarding the host
key generation, so the possibility of accidental starting the shipped
sshd.exe may actually be quite low.

> Having said that, `sshd` is not required to run Git, therefore it 
> should
> not be distributed with Git for Windows. This PR addresses that:
> https://github.com/git-for-windows/build-extra/pull/571

Interestingly, that pull request shows that some people actually use(d)
the shipped sshd.exe, which just shows that nearly every change will
inevitably break somebody's workflow.
