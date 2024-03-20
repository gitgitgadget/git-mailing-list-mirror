Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DD3374C3
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924361; cv=none; b=o6LQTx+FhpUs3UuFaoE+P1ElLS5AHAk8uGG1kDZeEKg8cXRP1aOkG+SJV2mFXRPLri5I+ooA6zFmK1WJwGrQ2gv2jhja918w58bZts5eWnr5UNhM5MLYMo+UIDvu0j5bn4P36l3uxyBwqTW8hwlAtPzThYskpEw/tU1SEUQwnRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924361; c=relaxed/simple;
	bh=kj9NqKychGZiKHF4iRMolA4NIvqzh7+PAFSjPcFj8uU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=m+zwhOD6fHVqLFQhHpW6X02maiglrFhHf6trkM0/R/irfY7/EvIXw4TAfmHlYuN8W2lDTNvDDAUEyCFtdndLl+WeyEahVaLW750TwqeO50G70ud4hDg5/CIA2fzDdUCkCo10/Adf7ncQlvsqy/4uDOMAaICqJBSwRruzfyYoylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=eqOd4IW5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YWqdIx14; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="eqOd4IW5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YWqdIx14"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 359B41800102;
	Wed, 20 Mar 2024 04:45:58 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 20 Mar 2024 04:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1710924357; x=1711010757; bh=OWnY/laowDSVc0IzcTgH/Mtgn1F3KSLJ
	F/DeH7gvh28=; b=eqOd4IW5/4GrSdncekf/I1ZPxOQZNMqyc+Nt5ahNcN7aRx0b
	c7G2pTIlVMlJgHJUjP3xY2ZApJ3S6peosT0cULUXkaPo2epoXZSsIO8xQkBej146
	7czPkvAD/284F5NYhag/ccV4MMEBrW1sIYKZVun8HSG9e57Q5ocMBCsT0oPw5P9p
	XGY/oNpTxp3di3n+tNMInLI0Ygxk6hqBi85vExq9qpk8Q/GFtvGN9HNc1lKw5AS+
	/LNyFL4sW5BU06Lde7Abv9i2Wy4fwwUoRY6/7yR4IQkGkP3AvBkwIMkdEGHAn6ut
	b98OlNtJEpsAeX/KKzyXfdfUojYZ34yFTBitLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710924357; x=
	1711010757; bh=OWnY/laowDSVc0IzcTgH/Mtgn1F3KSLJF/DeH7gvh28=; b=Y
	WqdIx14HLJ9FhS84cu6Nhy0VLBH5Q3mhP+r6eGpjDezIIkviBe6+Nz2qbcea63VE
	ijcgXRKlHT35BoDv27YMop26UY8+M4lYNcxtX5KIqVo2D3VzBrJ7kY/uAVMn4Z8O
	cj9E2ATcEk3KouNhir5/c7Kd8XdVQKeujMWSflMk5F9J65oeVvc7CnNxTLLYCEb3
	CjaqHVNiYV4zNWc4uMo/pbd5LqnKx+VYqV8XjqL6zx5wza3dNGKrmFn0+4yYoISj
	NeJ/TRJNtbcadSKJwAU8jf3agMHTFSUCm8C1oQffY8q/qnVlSb7pi3qrpHN0tEUE
	cVJpYvedCg13PjvKe5slw==
X-ME-Sender: <xms:RaL6ZQX40SPrELJMn4ucHaYyUdg6AJnpplqo7K7hJ2li2kaP6B8mQsM>
    <xme:RaL6ZUk0zSdDMUvbv2zJK5_l95Solhzy1AE0_dN5kNGveVVg4ZfjZafKK7Z9Ma9_y
    8-jHyEY2oR3qXeAUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleefgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgfesth
    hqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    ekledthfekfeetkedugfejtdeluedugeekueegieevfeelleevleekvefhgeehhfenucff
    ohhmrghinhepghhithhlrggsrdgtohhmpddutddruddurdduhedruddtnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhg
    shgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:RaL6ZUYxBciktxfEpGqHb0CeSXdVxmLfcnkpJRLCliKL84MKWwpfGg>
    <xmx:RaL6ZfVK5jkVMwMVrrtJThOgYA9mZLGIILYoflT0ur-TTHh--wl5vw>
    <xmx:RaL6ZanMhVoS77M63QGxpEZ49p4Lhm7RXTCrjTydpNQCF9wee47Tmw>
    <xmx:RaL6ZUeWinujU_43m_O9BHE58Vr4HRH7-xof2-zVjgSfMXt8lCl90Q>
    <xmx:RaL6ZfxllA204CYgtvZ8hwB3jPX_Ewq0JSN-2YTFb3N18lu6xaahCR0tghY>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3ADE015A0092; Wed, 20 Mar 2024 04:45:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6f4d8a42-341b-40e0-97f4-157d053c0ff2@app.fastmail.com>
In-Reply-To: <65fa8d7a469967.62182104.7cc8fd91@m1.mail.sina.com.cn>
References: <65fa8d7a469967.62182104.7cc8fd91@m1.mail.sina.com.cn>
Date: Wed, 20 Mar 2024 09:45:32 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: jjb8256@sina.com
Cc: git@vger.kernel.org
Subject: Re: git push error
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024, at 08:17, jjb8256@sina.com wrote:
> Hi=EF=BC=9A
>     git push =E6=97=B6=E5=8F=91=E7=8E=B0=E5=A6=82=E4=B8=8B=E6=8A=A5=E9=
=94=99=EF=BC=8C=E5=B0=9D=E8=AF=95=E6=97=A0=E6=B3=95=E4=BF=AE=E6=94=B9=EF=
=BC=8C=E8=AF=B7=E5=B8=AE=E5=BF=99=EF=BC=8C=E8=B0=A2=E8=B0=A2=EF=BC=81
>
> $ git push
> Enumerating objects: 9, done.
> Counting objects: 100% (8/8), done.
> Delta compression using up to 8 threads
> Compressing objects: 100% (5/5), done.
> Writing objects: 100% (5/5), 701 bytes | 233.00 KiB/s, done.
> Total 5 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
> remote: The gitlab-shell hooks have been migrated to Gitaly, see
> https://gitlab.com/gitlab-org/gitaly/issues/1226
> To http://10.11.15.10/ks-rd-fw/git-train-2022.git
>  ! [remote rejected] develop -> develop (pre-receive hook declined)
> error: failed to push some refs to
> 'http://10.11.15.10/ks-rd-fw/git-train-2022.git'

The pre-receive hook on the server failed. That means that whatever you
pushed is wrong according to that script.

See `man githooks`.

--
Kristoffer
