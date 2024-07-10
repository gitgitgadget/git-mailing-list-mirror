Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BAC1922E3
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631466; cv=none; b=c6WTe+WF6qW1R+kzVwUw73tx8m31y5ejnxlJpqwdMVWCbVhMvxtSj42yyPschRRhQcWhrJp+iTSuXEF/3Rw0j617E7AzQ+rSpy4GoLeAFX9ZzSNjJHS+6WGILC3mr0VyLK/UZy2Gd0xv1qE7dGl/fxdo4DxEUTt0XIZjXQFcDJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631466; c=relaxed/simple;
	bh=Hgc0YdhAmmxn6dXkevsN7nzzqGGjCB6SNbDcxhhRQmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rVZDtF0hR9PPxcIpv7mppnt7f9ze0Nq7vi0ZFmeJlvyV651gDB231xWTTfU80jsgqjM1J3DFjhx1e5JFTu4BC/Pg5nEMSC1ZafdmGkJooaEjR0c9On9nYJxE6Xs4Megce9lQBu+tFQUEb9UU5Mb6Jld55YgXeFkuAP3Kf9fmFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=o19BrTvu; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o19BrTvu"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DD7AE1BE95;
	Wed, 10 Jul 2024 13:11:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Hgc0YdhAmmxn6dXkevsN7nzzqGGjCB6SNbDcxh
	hRQmQ=; b=o19BrTvuiTl582LRi1xlmyH8JSe1YiK0bsOFLX9lOf3RUsyhW01T8q
	23AdKYItAAMNMmXKBtR7TRfxwhVU8SrB6EkA2jxCevcYnvVM9hFr00k86seQsnkP
	BjTkOeNbVmhk8kL/x++yVVtaeF+b3tWuoO/p9TjUKUZoQePDNMFMM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D70261BE94;
	Wed, 10 Jul 2024 13:11:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5D1AC1BE91;
	Wed, 10 Jul 2024 13:10:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: "Schoonderwaldt, Michel" <michel.schoonderwaldt@sittard-geleen.nl>,
  "git@vger.kernel.org" <git@vger.kernel.org>,
  "git-security@googlegroups.com" <git-security@googlegroups.com>
Subject: Re: Request to Update OpenSSH Version in Git due to Security
 Vulnerabilities (CVE-2006-5051, CVE-2024-6387
In-Reply-To: <ffe00b81-5f19-a073-9a9e-ee84b7d3845b@gmx.de> (Johannes
	Schindelin's message of "Wed, 10 Jul 2024 13:26:32 +0200 (CEST)")
References: <AM9PR07MB71854BD4C1CE7E517203FFB6B1DF2@AM9PR07MB7185.eurprd07.prod.outlook.com>
	<ffe00b81-5f19-a073-9a9e-ee84b7d3845b@gmx.de>
Date: Wed, 10 Jul 2024 10:10:56 -0700
Message-ID: <xmqqa5ipxjdr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 602D25CA-3EDF-11EF-8714-C38742FD603B-77302942!pb-smtp20.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The crucial part is the `sshd` part. Git for Windows does distribute the
> `sshd.exe` binary, but it is in no way used by default, nor is there
> support how to set it up to run an SSH server.
>
> Git for Windows is therefore not affected by this vulnerability, and
> therefore it is not crucial to get a new version out as quickly as
> possible. See also my assessment at
> https://github.com/git-for-windows/git/issues/5031#issuecomment-2199722969

I think I've seen in the past another inquiry about vulnerability
in OpenSSH, which turned out to be irrelevant in the context of Git
for Windows for this exact reason (i.e. "sshd" is problematic but
"ssh" is OK).

Would it make future confusion like this less likely if you stopped
shipping the sshd and ship only the ssh client?

Thanks.
