Received: from sender4-pp-e107.zoho.com (sender4-pp-e107.zoho.com [136.143.188.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67E241C8C
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768761061; cv=pass; b=o+isNZwGd5srXkBQSTTWgJ2mx7B/hW9xhYZvyMyQy5VoWeJ+mDAQW0VZyTr/w1TvzBlGNQlsnmpupVsXFbC0UdrXa2/G2zkDGlxMYWM6mNLfsjb1Qia1qeoBGS327KO4E6T5oecNSpqrhSDCz00OCPaNyk8utEPkO9s9tLqckCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768761061; c=relaxed/simple;
	bh=or42+4zTjP6BUqKYjbP6ovdatsJgRddNFVVAx68XZ/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jJnnc4ctyqt5WN1dt9thULY0wlX3xR6vCkpP5/BYOtj1ayjjAN+HggxnsTjmCxKyGEUvT7tu1VBOl8XWycwEtBAIoeSzT0D48zhMgMeuncIN3cqHAWEb0QyW4O07HadurspQxIF+hGTjRDd3+cISMHKnAO0mW9ei4KuWoLyxUNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=RHlbwBrB; arc=pass smtp.client-ip=136.143.188.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="RHlbwBrB"
ARC-Seal: i=1; a=rsa-sha256; t=1768761046; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Va99wjTvuawH6TEsVegGJYuypM0uCA/JstRXlmtxwuRr4XVHFPQhuySv+ceCbc+FMIBAzofY4wc2E4F0iC/Dw6HmgQlmEv+AYxtAsBbq2ow0xshc2MH/IbREe5P2TrkZcJQe+3Zd38Hf0xImcMn+gXLDRbJKNkiyqug/b2joLwM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768761046; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=or42+4zTjP6BUqKYjbP6ovdatsJgRddNFVVAx68XZ/w=; 
	b=BYCkklD1M5TM6psKbfLTU/HCXzl6k0ZHi2Uy0ac256rpe5LJjtDi4ffy3/1VtRoN7zdz894uNS+VMSWkzEh3u/3K+gKupLZr/aSanOA52L33YRau01VsOz0lgnIkylbLSf16ttd05eDAOC4tAkhcTy7O/SukLS8nFQQaE3VHMN8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768761046;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=or42+4zTjP6BUqKYjbP6ovdatsJgRddNFVVAx68XZ/w=;
	b=RHlbwBrBrVeshr9lgBo1HX7tQv5iZ2n9kuHzT5acs19cq2TRzEx+ph6Wb4QV19aC
	H9KT4DGU1d40bvX1NYKVfN5y8puOzfrOjkAa0K9b5z/hHatN6tQkVOJPmkd0RDBL1Im
	59NaONW3GUAP6M3Q4DQgyJoEDWHoA4oH91++mAo4=
Received: by mx.zohomail.com with SMTPS id 1768761043664504.29388460881046;
	Sun, 18 Jan 2026 10:30:43 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Junio C Hamano
 <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
 <phillip.wood123@gmail.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Emily Shaffer <nasamuffin@google.com>,
 =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 06/11] reference-transaction: use hook API instead of
 run-command
In-Reply-To: <aWzQtsZCXNPeJ5vw@szeder.dev>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251226122334.16687-1-adrian.ratiu@collabora.com>
 <20251226122334.16687-7-adrian.ratiu@collabora.com>
 <aWzQtsZCXNPeJ5vw@szeder.dev>
Date: Sun, 18 Jan 2026 20:30:38 +0200
Message-ID: <875x8yydrl.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Sun, 18 Jan 2026, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote:
> On Fri, Dec 26, 2025 at 02:23:29PM +0200, Adrian Ratiu wrote:
>> Convert the reference-transaction hook to the new hook API,
>> so it doesn't need to set up a struct child_process, call
>> find_hook or toggle the pipe signals.
>
> With these changes 'refs.c' doesn't use anything from 'run-command.h'
> and 'sigchain.h' anymore, so their #includes should be removed as
> well.
>
> https://public-inbox.org/git/20260116-633-regression-lost-diagnostic-mess=
age-when-pushing-non-commit-objects-to-refs-heads-v2-1-925a0e9c7f32@gmail.c=
om/

Indeed. Thank you. Will do in v7.
