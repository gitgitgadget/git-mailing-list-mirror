Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.79.88.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394223;
	b=O9gx5KlnCF0/pWqCTL+lqubKn8jVoQCszJha4zJDB+TEdpAG9l4pUc9DoDlSVXBXHFq1
	 7VqJyOxtI/dgsrnIEtARhifcvr4VdueAv88JZaOxW963mMlf5VP2XEfDhx3P+nEyIV2Ip
	 tvZPIE7XlX6056gWVRndMGrioBSLJHUzVwZFlsGb/s16rIpBECqlf3JtuBpJPWMfGILlO
	 ssRmW7M4Kp3sFe4lc9fbhCslyCIo61bTO9+GfOXy22aVa5oqhDpH7EJsrF9hE2rZx5+UW
	 BydLZ0GKcy9clci+ZF49yI6QYTfRCEgQ31+/l33/BQ1s6Cm/U6XEm5JdjQSmipISNXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394223;
	h=DMARC-Filter:DKIM-Filter:DKIM-Signature:Received:From:To:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=pWBCi/tuzEJ27iU/oAMJI8LVwZkT92kzJ2enVGTt6cM=;
	b=xus6jkDkprqcAhn3EzTp6AEAMOtL4ATf3dfzcDLwCRJO9WdMsIoDvPqTi2bgBnT7erC6
	 cwA36pKe3mGNwJ9f2k6jMdreXUyjmhDVdyz1RpY91F4DNvoDnybqszxuBSo3zV5S4YIRG
	 3YGSY8l1KpuZGRrOHpxIBqsmGjVakw7xhgehjbPUPI1UzMqx8+yKFCXxFE9F+xN3EGIft
	 6rw4EXheTbRNjvuRBWGW43huBmGP1HtnQnjL6o5IeUZ6dlPIEo9xoOW05La+7j87drgnh
	 Z6aapI/o8XoQz1XMc7oYm1FYbcTCvky1ri8fKg4l1z3EV6Liwkw41jS2HaW3AoDIzHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lwn.net;
	spf=pass smtp.mailfrom=lwn.net;
	dkim=pass header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=VEU0Uq9e;
	arc=none smtp.remote-ip=45.79.88.28
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869ED606B6D3
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 21:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 869ED606B6D3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=VEU0Uq9e
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8FF3140901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1793394216; bh=pWBCi/tuzEJ27iU/oAMJI8LVwZkT92kzJ2enVGTt6cM=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=VEU0Uq9e5dh/rF882XqQrWyCI55dzmvrrHVaXmMGnPN24nEdV+lJ8Gn4fYlMp6tuE
	 FQkCk7CxzzlBPePwxRcCM4KB4MtGF4zgxv7bXq9Cpj+XqisLQ6B0geY8mMC092V82J
	 JyXqBvQc3fCUEFcP50HQxD/hEeOCKxw09SuPeQzNnHLcnpEB04pyOy3nFfIhkWN174
	 XwSDfigZZZYY1kzioaGgMwvk73By56PhS2Syk7CjZ5SfaqdutOamyVMPmUvyXTtJGj
	 IBfgqUHzDF8gSNxKLPsw+U/mksR4t/7JZ9SnDvwJl8irAnU/zwaMucVdJYTuBMsAYL
	 y8HAhDz8yphJQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8FF3140901;
	Fri, 30 Oct 2026 21:03:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] Documentation: propose community voting process
In-Reply-To: <CAJoAoZmyADCU8VdVDrvR-OuDKybSnT2pMOKbrofRBg6YdpxZ0A@mail.gmail.com>
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZmyADCU8VdVDrvR-OuDKybSnT2pMOKbrofRBg6YdpxZ0A@mail.gmail.com>
Date: Fri, 30 Oct 2026 15:03:35 -0600
Message-ID: <871p96j3yw.fsf@trenco.lwn.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Emily Shaffer <nasamuffin@google.com> writes:

> It also appears that CIVS has a hosted service (that same
> civs2.civs.us) which means we wouldn't need to set up hosting
> ourselves. However, we could - Konstantin Ryabitsev mentioned to me
> that he thinks it would be feasible to set it up. I believe that to
> use devotee we would need to set up hosting somehow ourselves.

FWIW, I used CIVS to run a number of TAB elections during my time there.
It always seemed like a bit of a vulnerability - depending on a free
service run by an unrelated party - but we never got around to setting
up anything ourselves.  It's pretty straightforward if you want to run
an occasional poll; I don't imagine the Git community would be voting on
a lot of stuff, so setting up your own system might be overkill.

CIVS does require that people sign up there before it will notify them
of votes, so you would need to bug people to do that.

Anyway, if anybody has any questions about using CIVS for this kind of
voting, feel free to ask.

Thanks,

jon
