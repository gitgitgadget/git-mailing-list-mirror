Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A676047
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496115; cv=none; b=rd4rqpPri7/orhq26nQz2cnHeITUOTrrcnF1EZi+r3tJq6Th9xQmB3zJ8OLnbr565GHonMoRIHtCfOlrsw8MuF9WbdutcQHlwaeEMc38m8kCaEy154S8trK4C7QZ8db3YagMFeklD/vxoLSoJbBPo1dYoLVtCb64gDfO3depWhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496115; c=relaxed/simple;
	bh=1jhhAVg6Mc6HsDhhhUiQBtwTFSR2r8IM8SldoBE3BXM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=FxaBa8z73M3RdWGXpkhICISGaAaRGUMmSvJ92e4ub2E+eahsiQYTOyopBn9Dr4ZVcwqhDXgdham7voBZwgHdu9/ze7ibrfFc41JlvaXWZeCROsReeYcsdnWTzGyUlrt+XerOARN5aEMDa9kck6S503CQpQCiHUKdUNBHgVluqjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Vsqp3kXj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pDAzTGuw; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Vsqp3kXj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pDAzTGuw"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 59FDF3200A10;
	Fri,  9 Feb 2024 11:28:32 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 09 Feb 2024 11:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707496111; x=1707582511; bh=1jhhAVg6Mc6HsDhhhUiQBtwTFSR2r8IM
	8SldoBE3BXM=; b=Vsqp3kXjvhyEfc4LHc7TDr/Yj3vT7U9i8Ou0WF9X3/bTsFHw
	Ltaa3x4ABB8ib7FH5l0ZCEmOssDk3L6S+XvozvGwqsPIkhCi9IQaXWNQDRmENrdm
	Lpx7f3en3GXxTeJ9SnXgFnewREEOqEkUFR4+OLa+pSQ+f50NTSZnQKmlDr26/cxS
	F+b1/9UVDdr4Zg6XYWWjU0Fa1hI5tVbWgFpD5ifh6feBSYsv2jttZRnQPKtP9eQV
	bsZXR23rokO2PrXWLKQLNLwdS05UhFiqxfjIHosSwwggEV/aOBUUQJNgs6/at3LQ
	eLOseFpngMGL3Nm/hXk1SRRD02j7Jfax4YDTeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707496111; x=
	1707582511; bh=1jhhAVg6Mc6HsDhhhUiQBtwTFSR2r8IM8SldoBE3BXM=; b=p
	DAzTGuwpTa0XSPIQk86eZS/3z3oHDhWZFt38uiSIDEMTt3jlk9zBR3vXzgiIzriF
	NK3EA8azhm5BVzdCAOcvK7KnVgfVC5znQSOjJOjXMFt0niZU5+SJLo2m0P2VZZIo
	kQvMnRf1iUBg5aVPn4eBPeT1TMDxJJdUE/59fNbDpAzlywc59B8qbP8qPZ5QhXWx
	oPqZBwtN3MvYu95K1RcZa4fqCc6VgysV3cp0tcUB3fkM4FKOXQCVwuDdrkjg75tD
	4eajQTdCJGVIYtjgGo3wm/F8P8XxbpiKIZ38PQpbxj2dn5DC1+pQhpuxEg9LysJD
	f1hxGHitiCWPbzqXG+Tug==
X-ME-Sender: <xms:r1LGZcy3QW74OGNtlp-HiUgP_rUmq37ZRKd4IfkjG9ZpNPyrBNTwdOE>
    <xme:r1LGZQSmIp3nr5pG2k1km54TG97WYELuefcuEFhBEzL3KO9pJWDai5cL8cBhnIQx7
    LcsNqtMuXYbt-1IwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:r1LGZeWf-INlmyEcJrxBplxvC4I0LqhaHX0_x6AQBuZdzblDuI0ACw>
    <xmx:r1LGZag-g9LZzdVavsupyfkoGDXUusZp9dVU9oVThi0zmUeKa_vv2Q>
    <xmx:r1LGZeBhUDtvSq2yOq5IyehtpqwYbYhrfOYhUWFLUC6lhxzbS05exw>
    <xmx:r1LGZZr0we3CLlcSPB7rLeUP9XSRcTIKYNo4tloPFVyfU7Dnyn3Rkg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AEA4D15A0092; Fri,  9 Feb 2024 11:28:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <571fb353-af1d-4cc9-a2c2-197296685623@app.fastmail.com>
In-Reply-To: 
 <AS8P189MB21977ACC4866D9836DA29082BC4B2@AS8P189MB2197.EURP189.PROD.OUTLOOK.COM>
References: 
 <AS8P189MB21977ACC4866D9836DA29082BC4B2@AS8P189MB2197.EURP189.PROD.OUTLOOK.COM>
Date: Fri, 09 Feb 2024 17:27:59 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Tiago Pascoal" <tiago@pascoal.net>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git column fails (or crashes) if padding is negative
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

I wasn=E2=80=99t able to reproduce quite what you got but kind of the sa=
me.

```
$ seq 1 24 | git column --mode=3Dcolumn --padding=3D-1
12345678910<binary?><numbers>
$ seq 1 24 | git column --mode=3Dcolumn --padding=3D-3
fatal: Data too large to fit into virtual memory space.
$ seq 1 24 | git column --mode=3Dcolumn --padding=3D-5
fatal: Out of memory, malloc failed (tried to allocate 18446744073709551=
614 bytes)
```

This is an =E2=80=9CInternal helper command=E2=80=9D under the =E2=80=9C=
plumbing=E2=80=9D suite. And I
get the impression that sometimes these fallthroughs are treated as
=E2=80=9Cdon=E2=80=99t do that=E2=80=9D. But I don=E2=80=99t know.

On the other hand it failing inside malloc looks weird. Why not catch
this before the malloc call is made?

[System Info]
git version:
git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.5.0-17-generic #17~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue=
 Jan 16 14:32:32 UTC 2 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]


--=20
Kristoffer Haugsbakk
