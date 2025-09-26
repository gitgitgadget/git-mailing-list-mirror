Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196F32750F3
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891847; cv=pass; b=LXgI16Cb30N7TA3aK5ccZlUb6OmEJScfZSXNGw7hYvhZYX4e68J+rLqh7ZK5IVArUkV8dhAfNSKeBEjTae3J+EKqQDlh/9OAvd2BoPLHJ59t2g75MpKlYvgsaAb9EyKiOV/SlVqUt8EvYDDdStsGG5eJbXvXfsNeEn24FoNbDsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891847; c=relaxed/simple;
	bh=/EsAVtYwxACmONHeiKA8IyU+2AeQlY66FZD8fSO0q/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UUdyG5FPSk2sORlJ+JC9wjtvMs5DVKTnAs1eFG8U4fmIncM0YeC1PlswZa9wRmFGdwDGhvM1eqdHzdeMu4UJVnE3CZC3w8p5TfXKmv5iOEGJWVs7LrmFToXy+Ln1mfVWwLW6Cgs3mIUmlY/KYFSHfGuW8WDThoX/BqpWtw6tPJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=T3Jdzl8o; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="T3Jdzl8o"
ARC-Seal: i=1; a=rsa-sha256; t=1758891829; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y0L3HGY3ySQi3nqCc/NjF/rfOKQVIIzj2D2lMX/ICZeFY70M1kBL1iBQPPQwY9Y3LOO/qYiy6pYXRtnvDgPrrguYpEN75kOSqWfCpUVir19QH3x12NDIS4vmMNNfiRmu5t7mzd5ifSvd7MS1sosMPO50sSPO3irn0WLl4y7OENs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758891829; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qeox/zUuGx5HkhHyiWVJvAIi7Qnjl8utU/m6JiAdz94=; 
	b=byFwwNla4YS6G2HaxTBfpdN+FTyu1RKZ5T4bgsZ0rdpvgkGA1GRy3lxRefwQ2ospLAoAiBqwcXXP1bfawAMSlLS/wuNznetsL8vEM+9ILQJmAEakQ67vdHkfbmqZ8kTYNt/Ur0emL5r0K7qOcXLLhLAtZfopoaHajvgfrZLVK6I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758891829;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qeox/zUuGx5HkhHyiWVJvAIi7Qnjl8utU/m6JiAdz94=;
	b=T3Jdzl8opCRc9CfPdoUCRvZuP303za2gkwi+fHJDsLmViHhK3iS5IDmX8bDTQqLn
	+5NbaxZDq5uxZCs01SyG90/R0n5SOB7fI3qFIWC2uWVFUn09ERwe48zOPGPX9vYeL08
	up+/Wa/iUrF2+N5MRDVfTQGrpEyStwwwfXc5vOtU=
Received: by mx.zohomail.com with SMTPS id 1758891827084357.2345056200438;
	Fri, 26 Sep 2025 06:03:47 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 05/10] reference-transaction: use hook.h to run hooks
In-Reply-To: <xmqqv7l6dx4u.fsf@gitster.g>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-6-adrian.ratiu@collabora.com>
 <xmqqv7l6dx4u.fsf@gitster.g>
Date: Fri, 26 Sep 2025 16:03:43 +0300
Message-ID: <875xd5nz68.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Thu, 25 Sep 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:=20
>=20
>> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>=
=20
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com> ---=20
>>  refs.c | 61=20
>>  ++++++++++++++++++++++++++++------------------------------ 1=20
>>  file changed, 29 insertions(+), 32 deletions(-)=20
>=20
> Please describe what is done, why, and what benefit we are=20
> reaping, just like you did for the previous few steps.=20

Ack, will do in v2.
