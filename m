Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3433F1
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707669821; cv=none; b=dHPOIQn62Q6Co02WzC3ixgRYre5355HWg7R+jmobFxB3EnqhC9zqsW4mjRzYFws/UmIoi/JGdV/W8/UDwHjUI6zhCvASt2ZetcWhoiWX4q8Fe+cwF4BNlENcppF9oHy/yBLRWRhVDD28g2GTMKdMgGO51rqgPu6GUGr3JPBfHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707669821; c=relaxed/simple;
	bh=jbRRarGfgXJ6FNv8QGsIFnBPU365JPUEs0hem0KXHoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W3eKrMqSWx6y4+31W7KgTc0seSir3t5Y9ISZpbO6jjzJHJ0sICNZlt7RNIysFy91kcEeZlxa0AYbKRxlJoopryOxcHN+GHh/cQt9TnocSxgg0H4rT1cs/jwqfF+53KVAWOMCNyCAlKn46eAIpvKbPwmod/tl4ewU0Xr1Rmzaejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=D2AkPcNJ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D2AkPcNJ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DCDF289E6;
	Sun, 11 Feb 2024 11:43:39 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jbRRarGfgXJ6
	FNv8QGsIFnBPU365JPUEs0hem0KXHoI=; b=D2AkPcNJcSRMh1rCWdxcSib9doGZ
	BKE970jS6PtEPUjv2zGgv8Ie+Gf8ZHrl7jN0XzOUbppYf7PXU7EyAKquDOtO6Zg6
	wMygA2NFgGBX9WJvuVAIOb+N+ag5Ey1XLhHm4XOHeI8FLEaO99K/ElMeYeZ/1gW+
	JPmkpTCCA9CrbUo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 25FA4289E5;
	Sun, 11 Feb 2024 11:43:39 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4AFFB289E4;
	Sun, 11 Feb 2024 11:43:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  K_V
 <zinen2@gmail.com>,  git@vger.kernel.org
Subject: Re: git gc changes ownerships of files linux
In-Reply-To: <20240211154345.GA28699@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Sun, 11 Feb 2024 16:43:45 +0100")
References: <CABkRduQNdgdF8WhZadP5hyYvpEWgP_AE8=qzxNiRNA71bdJcYQ@mail.gmail.com>
	<20240211151455.GA27103@tb-raspi4>
	<ZcjnuSAZiNHvA5h1@tapette.crustytoothpaste.net>
	<20240211154345.GA28699@tb-raspi4>
Date: Sun, 11 Feb 2024 08:43:33 -0800
Message-ID: <xmqqcyt39cju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 B2DD26D4-C8FC-11EE-91A9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Briam, Hm, I wonder what this function (in path.c) does:
>
> int adjust_shared_perm(const char *path)
>
> According to my understanding, it was included into the Git codebase
> to work around the missing "setgid" feature in Linux (and probably cygw=
in).

No.  "g+s on directory" is required and depended upon for getting
the correct group ownership.  We do not do anything to chown(2) a
filesystem entry to force what group it is owned by there.

What adjust_shared_perm() does is to counter what the screwed-up
umask settings the user may have causes.  If you are a member of a
group and working in a directory owned by the group with other
members, you want to make sure others in the group can access the
files and the directories in the project.  Their umask should be
loosened to at least 027 and preferrably to 007 to give group
members the same access as you do.  Yet people do not loosen their
umask when starting work in such a group owned directory that is
supposed to be shared, as it would be extremely cumbersome to do
[*].  These users end up creating files with overly tight permission
bits, e.g. 0644 or 0700, and we go in with adjust_shared_perm() to
fix these modes.

You definitely must set up your initial directory with g+s if you
are usihng the group-writable shared directory model (which I would
actually be surprised to see in 2020---is a shared machine with more
than one user-account still a thing???); adjust_shared_perm() will
not help you there.


[Footnote]

* Unless, of course, you use some sort of "hook" in the shell to
  notice you switched to a certain directory and run command
  there---some people achieve this by aliasing their "cd", "pushd",
  and "popd".

