Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21AF441607
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114733; cv=none; b=ArSjeN9R9qaiuyLk3RpqbjO9Kj4xRtBKMwGLZZH0N+VwQirfqKfcCiY5N0/2KOJDVbJE8wnzXGpa9PnmFCyYLDD3DFGulcHSepXRNTC+5sMIyIl5nUx7LiGH0WIZu+XfQ0sUAPNkTCahJIOW6iESnFOeKGsqtS+yrRli9w5ngn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114733; c=relaxed/simple;
	bh=fL8ihTe52rdEdu/3CtLqsa0ml0snVnFuaAGL7ibvtiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i59rTdspwmr2CV6sXvCEHslHdzWa8ZjmB2h+roNxRdxx0uudBKqeGsrNR5BBBq/SMsNV9vxxwsAQ3qfGrX+bjJK068HNy6bODpyptmGeb5sySTUbIpFYTGF48P5PW6mQxK+WNqmNdlhUhcCTITojeWTDRU4pJgFrQnhCoJp4caM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=k506Uyuj; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="k506Uyuj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784114723; x=1784719523; i=l.s.r@web.de;
	bh=W4Po3KFwNx91aobsVCo5gk7lrIe2xNSEMSZQpwN1IIc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k506UyujPsRJ9RoK56qSP+JHi7PXH97ALZBUH8/7eQbjq8QXdGgkEBmSJk6X08Uy
	 e1NTA4RVD/n+0eeoAS6+bQcfktIUWS9N3BtvQW0H4DA3NTHQCDX83/Ir6zTjfyR2k
	 IyLdik1tMahXVVIwc5wQbD2j4yMsR9sE2EBUqB6dYRfh81c7p81f82jij4nyycC/w
	 8DYlCm1B+amC5l3u2TpV/2pimBiwfES77iz5BKNRQbrh0eyMNSInRarRgqxtOepeO
	 KUCQeUE+lYeiRjyNx1L2N3gKlRaT8XZmuqIL+9na1BOu/Q2HFpRATMWwMn05fbqo/
	 L5+Ys58KwqMH45xMrA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MY5fb-1wXUUg0vAj-00NrxB; Wed, 15
 Jul 2026 13:25:23 +0200
Message-ID: <a84437e9-6a7d-41b9-b638-30c81eecd672@web.de>
Date: Wed, 15 Jul 2026 13:25:22 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] tempfile: add repo_create_tempfile{,_mode}()
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20260714175956.54601-1-l.s.r@web.de>
 <20260714175956.54601-2-l.s.r@web.de> <aldYTuMvN-8EMvYK@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <aldYTuMvN-8EMvYK@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fkVkpe2tbimag2dmtblhOVpGIEe9slLs7s/3Pw5+uCcM5/2C5eU
 CjD07K5T8d/RZA1W/3Scdb8Eus4AHRlUmmAvKc9c7n62Y/nJCU7ZWi3DKZld8vFTI1g4Q6n
 qIXAxFr7c4PZaIplBwkcf+SaSppzfVm3td4lU2/8XOIlI4D7/rWgAj3Zd4yE/bboguVQyR9
 bzoz0lOIsAnY/WnQy0Zqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QVsPcwD1vqo=;sHxXhaSKyfJrPMaDQ5EwIzcHxtz
 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

On 7/15/26 11:52 AM, Patrick Steinhardt wrote:
> On Tue, Jul 14, 2026 at 07:59:52PM +0200, Ren=C3=A9 Scharfe wrote:
>> Add variants of create_tempfile_mode() that handle arbitrary
>> repositories.
>=20
> One thing I was wondering is whether it really makes sense to pass in a
> full repository. All we require it for is `adjust_shared_perm()`, and it
> feels quite extreme to require a full-blown repository.
>=20
> An alternative would be to let callers pass in the setting by
> themselves, but that would likely lead to lots of duplicated code. So
> maybe this is a good first step, and we could eventually create another
> API where users can pass in the configuration instead of a repository if
> we ever gain callers that don't have a repository available.
Had the same thought.  I think it's because create_tempfile() sounds
quite generic, but is actually for creating temporary files within a
repository, not just anywhere or just for the duration of the creating
process, so shared access matters (if enabled).

I didn't find a case where a caller would not have at least
the_repository to pass in, so while a repo-less adjust_shared_perm()
or create_tempfile() might seem cleaner, we probably won't need it in
practice.  We'll find out..

Ren=C3=A9

