Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D6F36729C
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241564; cv=none; b=Mj3ui5nQQY/vMEUK3Dq1/a/nj+AmqNsBc0C/jPVnMSuHYckF+GfHoEhUjLmCtpDe7K3d0rqT8Botn5tRWyRmQ3oNENbYWMD2sJ54ANg1ZIJXjWfzcw5fbOl5Z+znBQUlxsAjAepNKbMWgqEZaEyytcZifopNq9kxkaV9XRYux+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241564; c=relaxed/simple;
	bh=DMZM8nXl1rXq7W/M3px/R4FFwhVYPWxjWU75EuZxFqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qbUa8b6BJE/+hD4q3EkV2fCqeepMxTelbPoF5bPdCyQWWrfRDxTAmsKZJpdorvf3kN7moJxRRd4kjmVUDA5bhun6z9R36GbRm7MuabJADh1cO3Pblmz2C+rbxcb+luhjw2UQr0V5QBWD/gkluHhlD+VFf5PUnXqp5AfEHCYris0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nFG4PbdE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kOa6nVSY; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nFG4PbdE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kOa6nVSY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D09F1D0015B;
	Thu, 20 Aug 2026 11:59:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 20 Aug 2026 11:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787241560; x=1787327960; bh=7UQqzjXjxF
	B/5OmSqsBOT9obzR/VLNjUahbpmsOsbeI=; b=nFG4PbdEPp5G7bzdJShPs9PObt
	kKosB82mAni/KJ4n9wKUYWNaAohZTxYNCf+NEXBUFV+5IavFfIl4OUdKx/A35yk3
	zNYuGgZ06d/756tIFc5OOPcsvn5uBmEBER1tzKdeEthnhIzn4bXgWBbsNjXdRB1U
	BTZlSPyz0T4aTOQ68Q2fK1/uQn1FW8vJYJbqCoXNR26Toscw9tUBlJecefys+KU4
	SC1waFqU1z85hYcfuvDcFlvVQEs161CbBFhIeh7nbXkGvew67+nl8itHSME9jx6l
	uCKZdUEWhNaZVFgVFB6GsEG82BAr68p77cLVjl1X6oUqcldmXC7lOLXU8lGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787241560; x=1787327960; bh=7UQqzjXjxFB/5OmSqsBOT9obzR/VLNjUahb
	pmsOsbeI=; b=kOa6nVSYGzBF05tQ+9G98a6ELYXBGQlZe8Os2udN6kZKx8J0xTe
	NKkKeO4A/k70TAhBi3VeXWW7aFblESUhkKHyVJOWMh7Lzni6vC2+wkgvPtmUWfZS
	P3B1hjVBEHIUTYkmanVo7EnhNrx9SgFPDM2P6ZOdFDUbByEJHxdv7rlfi7TNk+In
	iznkgeGf1ngJqsLSlC1r1iisNmiKyEtI4TH3MyoG8S4JtKTKUKlDgk78QrWcq5uM
	MF6Gfr2ZllFHYRbMKkdso+B4lrQZbwVNIDTzASDRYLJzZ4LFGaIbz97NLi6fVJYt
	MsRav9IozsvZv68fOO0cjWq2dWo1fHL514Q==
X-ME-Sender: <xms:WCSHat6qcVxACoaofNvL6EGlhOfm-yn2jT6Cimhl_qNhgkPPPIpIpg>
    <xme:WCSHaul1AnzclBk0z6uuIE1eROW49z4XtvaaeiYChDLpVWPy5NpgIlw9JgZXMFx8I
    9jK_WYBJJza6NyVoqq0b8o8foiXZFSf6z5A1yuBBDsHKDccjO0Kebo>
X-ME-Received: <xmr:WCSHauTkigx0SGLcJCXa90qoVP9DVr9TFm80sOVC9emeVPpwhAkGLhyiJq28v9WIXuCZabiBtdn-I6FPUrndnH7sFILWBUX8Rw>
X-ME-Proxy-Cause: dmFkZTFCqGRlbCZo3QU//8K4rrMLwD4xMQhoi/tlYkEC2qRHwx2ltUd3RrCo2p+KxcDXiy
    XinalpSS7Dn9FUtBxJpLhOg6ma6+Hcu6c8Wh/+KNmxNSUPwcAhh8z2zpVZJ1YSAXkHjT2i
    ElZQUg1YAiq2wCEEmxQQU5xg5QY5PcxLqZSzwQ5h7d2ZipQEiosB1CwJcRLSx+Tn3hoBIy
    P3V107/TKskEgeMMT1Cvn/p8PQItRq0WhDjNDaS9k8evNi2yD52HZyGen/QPveul8cc0aH
    n/QH58QO1k1VkUqtHR9KgD0bSJy8JeNZmg0CMqQ3tsdKwPOVOQJCjGqecpXuyFEw4auNJX
    XXwG/d/pXXcXu2lkhCLv+ZcUstXaldx++JayRiq6+VXdYeTxZm7rj3lqqPijHx1hQMN9ak
    s2OefmSWWnvJHG5VDwOvyo4rT2yhibf7DcDa8+RtOGzvvcPn1sJnBhPhLe8FYuJ1K/2OsA
    NkTYSU8pLncg5Bc3Nwq04ktEYjlv/jSx0lKfkp5p13HBXTqRc14xdvePJb5W6TXjxP1rUo
    1sw/WglTRH6otmK4S7qmAPtv1n/KxvOqrDGw2yhHdqckFhRvywTUXAJ04QQApH9CeEFrmA
    Jm43E7z/Re+ITYosUD8FsNE9+kpWjugernKrONZPgiZNgYyyaYgBEtGymxIA
X-ME-Proxy: <xmx:WCSHatG85b61G6fzC03h_VwuJ2u5UHXPYpufqJmR0fuPU9BNiKXgZw>
    <xmx:WCSHajH6lmRdmrLNaB_BGYBqrDrC8CXhTIY3QURgjcGGfjGXHXne-Q>
    <xmx:WCSHarSrbCuVPr2Ks3xfaLgj9H0IC2y19ADSVLWpfN48644ElfalTQ>
    <xmx:WCSHakJKgY-J1toYBuZowcYIlFRPh9vi1DsBCt5OkwOB9TrM-w9RHQ>
    <xmx:WCSHai1USLwplViYkCqGa-MM8fjE-eg7U2wAAxzlPyBh0G8lZQmgY0rz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 11:59:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Artur Bieniek via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Artur Bieniek <abieniek@antmicro.com>,  Artur
 Bieniek <ar2rekb@gmail.com>
Subject: Re: [PATCH] pull: add --hard mode
In-Reply-To: <0c2607e2-16da-4efd-879f-82ef2c2aa127@gmail.com> (Phillip Wood's
	message of "Thu, 20 Aug 2026 10:58:56 +0100")
References: <pull.2384.git.git.1787052873141.gitgitgadget@gmail.com>
	<xmqqwltn1o4e.fsf@gitster.g>
	<0c2607e2-16da-4efd-879f-82ef2c2aa127@gmail.com>
Date: Thu, 20 Aug 2026 08:59:18 -0700
Message-ID: <xmqqo6ewsrzd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think if the design was slightly different so that it errored out by 
> default if there were uncommitted changes then that would make it worth 
> while as it is safer than "git fetch; git reset --hard @{u}" and would 
> allow the user to carry over those changes with "--autostash". So to me 
> something like
>
> 	git pull --reset [--discard-changes | --autostash]
>
> would be a more convincing design.
> ...
> If it refused to reset by default when there were uncommitted changes 
> would that be safe enough? Uncommitted changes would be protected and 
> any local commits that become unreachable after the reset can still be 
> retrieved from the reflog. It's not quite the same as integrating remote 
> and local changes, but more like updating the working copy.

Yup, but git pull --ff-only serves the "No development is done in
this repository; it is merely to keep the latest sources here"
audience just fine.

What you are suggesting may be *useful* for those who agree with
this statement:

    I do value my local changes because I haven't committed them,
    but I am willing to discard these changes and replace them with
    whatever the upstream did.

but I am not sure of the use case for a repository/working tree
that is managed in such a way.
