Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66838274B39
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 02:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771985744; cv=none; b=uEOYM37hoeCy8T7KQrv/Sb7Ac2uI4+joWBJ8pZR4Monto607i7bpJC8wgKJRp0BVL/INz/LNlARfMpD06HD/LWi2Tlp0+2SxlfQ9Zj3et18JAYzobuwyE2mSDgLOp3ZEdk61RXk79PRpuYgCpBNInvxT3jrj9Qayj7o2Th151vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771985744; c=relaxed/simple;
	bh=zDeDP+6UNbZ3PMslK5goenZeud3pFIG8Rwf6SPy1edw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjsbsPkmw0HLtGZxcS3RkEnsOxSjkRG/JYOd9E4/3JmRad2MOAvkS3DUnPvpHSLuDlu/c2YHijKeoUbsTFVbjfWLsxYOP6N2ef9CZU0tuvLIhlp6b1LX2SGbkg2vCwjRDEEQky5c+Q9soEpLB9kOV/UuD5e2H3jyYRh+J//Y1uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=b1Iz/LYs; arc=none smtp.client-ip=79.135.106.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="b1Iz/LYs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1771985734; x=1772244934;
	bh=WK+M5Z1ScwhL5PFdN2Sm6/Blmb9naBz7FzdJEYqDfXI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=b1Iz/LYs2/BwKxD8bfIvjH1vy6yNhQXlGSzsYkjnKCdMrWZ08rWG+EFaglylNyx29
	 ElgcqZdzSzNX27fkxULrwcwbf+zbb6ttDmR3dJZIXJ/mBdo65GdEEf/2Tbz9ah7os7
	 tQ2CECPx2hn8IKjTakWXsdEA2P5DXPfbU3ojbFPOH+zFzORNytXLs/49VvhTv7/+mD
	 sVpHG+W8KDDvMTZe7Jei2vdP2Li6Kep+Qtkrnd2tgF0oRUQzOAB3EkzjjslnuJLlM6
	 oqdV+OIcC70IWFG3fGaUPEjpf5othsLpIppMXSVk90BXU8AwkArqpzEx94NrF0c3UE
	 iZEPZr4YT14TA==
Date: Wed, 25 Feb 2026 02:15:31 +0000
To: git@vger.kernel.org
From: Chandra <Chandrakr@pm.me>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] add: support pre-add hook
Message-ID: <TjRZg9NlROW7rOZkb70ZxSqGHVSP91O5kV9uWyXR9Z41GyCSYDbY1xPBTEowgHkx5xZYVSR35eLxTdpkHRP0DxmtkZoJt1CoUjBzv9bQdCI=@pm.me>
In-Reply-To: <oxAq83GHpc_Iuijrz10UxkyWknKQ0E3AilBFvKqNJg1OpO4ldNr5NUIsit3gSMjjO8dqG_t0FB4uAgYyrmLN4VGyx_ZeZOWh5qogrAiDWVc=@pm.me>
References: <pull.2045.git.1770737573475.gitgitgadget@gmail.com> <pull.2045.v2.git.1770822312474.gitgitgadget@gmail.com> <xmqqseb7rre9.fsf@gitster.g> <2kX5wTQeOz3VPzUT6QiH_KyB9RMMtf8L3I8N6WtVWHaVQ1ZguBTaqAqFcFgOGpCqv-RJyALKlsENx-g7E3DMx3TzCfZoaRtPEpoDyx6d9kg=@pm.me> <xmqqfr77rn1t.fsf@gitster.g> <oxAq83GHpc_Iuijrz10UxkyWknKQ0E3AilBFvKqNJg1OpO4ldNr5NUIsit3gSMjjO8dqG_t0FB4uAgYyrmLN4VGyx_ZeZOWh5qogrAiDWVc=@pm.me>
Feedback-ID: 10057713:user:proton
X-Pm-Message-ID: 52f396189ac10771c757dbbc42359e15b4b119c6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks again for the review. I prepared v3 with the lockfile argument model=
, a mixed-result gating fix, a 'post-index-change' contract fix, and docs u=
pdates.


Chandra Kethi-Reddy
@archonphronesis:matrix.org

Sent from Proton Mail for iOS.

-------- Original Message --------
On Thursday, 02/12/26 at 03:25 Chandra <Chandrakr@pm.me> wrote:
In the git-commit documentation, pre-commit is always verbatim. For consist=
ency, pre-add typeset as verbatim makes sense.


Chandra Kethi-Reddy

Sent from Proton Mail for iOS.

-------- Original Message --------
On Thursday, 02/12/26 at 02:56 Junio C Hamano <gitster@pobox.com> wrote:
Chandra <Chandrakr@pm.me> writes:

>> the word pre-add ... would not look good
>
> Originally, I wanted to call these pre-staging hooks.

I was not talking about the choice of words.  If pre-commit
interferes before a commit is made in 'git commit', pre-add is a
natural phrase to use to interfere 'git add'.

It was a comment only on how it is typeset in the documentation,
e.g., should it be `pre-add` (for verbatim), 'pre-add', _pre_add_,
etc.




