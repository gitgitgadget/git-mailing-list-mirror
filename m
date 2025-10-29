Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D9B30499B
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745646; cv=pass; b=D4ehf7ZlCB1OYSFnICez9f22qjSaF/6W+vljVnEtqyWY/Jd1lmiVsl1taAgCIy28RQAERoPspr9gFXnU7N5Ilad0cRT7SOI997lZ2XziekR17KIGFTel+FnNE3AtvRlLtP4wU3Yo9QWsODB7gi5ECsLW7hMFmLYUWPWb0h60LQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745646; c=relaxed/simple;
	bh=8k2Px79vAeeRlB8zBWac6Iwx/If4eCAxT0ioK6kgQyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WUIzAozCDiYfy1HgZzASgdYIQLG5L55TVh9dyinhp/H5HxCUbjcgi8unUNyAvDtxGmVCSRILgibjvHRfl/EedW4EDUTu/s76y46DHxVpT0dk9IjDxuixIbWR+3niiR6dUhoUKyh6gXSFH8FJq0s/YHfqdyh5o8aiU7B03k7kA+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=cArR8xTM; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="cArR8xTM"
ARC-Seal: i=1; a=rsa-sha256; t=1761745631; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AU3j9nQkhNF8e9KC9eDu0l8/NzIEstENvy/snSKevXsDdX+6ss57rHAHYZZeJF3zBwaCtPmbqB2EMRG4zhfrbYyeP4f24ytEO/mu8GywBpB+F8xAo4FfKcp14rFaV7usW+b1aufsP8d+AdGi9kcmrv5JMtodpRckEqGeqL5VX2E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761745631; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8k2Px79vAeeRlB8zBWac6Iwx/If4eCAxT0ioK6kgQyw=; 
	b=jZHrM7/5rxqZ8hpFwv/MC7xtITRNTMG+OJxJ+Sx8E8qmULTZ5DRGaxAuKsaXisHgenUxtI4RxkOg9gebi6SZDZQ4IyDDz0RY9u5Mahd0uFb0NZXRCyo8NMHljUssW796PFqoh7df7dsHxk4hdyjpaSHADPMlNphHCG7rEussKjA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761745631;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8k2Px79vAeeRlB8zBWac6Iwx/If4eCAxT0ioK6kgQyw=;
	b=cArR8xTMfpjllsuyHVKTp1p0KW68pKd/flj076kTgMcxdsY6QmpaGEIQGvBNAbZj
	v+xqzTMzX49O/O03D+FLJEehXWNMSCjAe+ngQAH2CH5Za0CvHF2J+zOyLJmCxf9O9FP
	2DpMrQELwaip3uO/WbmjA/B5cVWjGBKmviG0erCc=
Received: by mx.zohomail.com with SMTPS id 1761745626103346.747879365809;
	Wed, 29 Oct 2025 06:47:06 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>, Rodrigo Damazio Bovendorp
 <rdamazio@google.com>, Junio C Hamano <gitster@pobox.com>, Patrick
 Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, "D. Ben
 Knoble" <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
 =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 10/10] receive-pack: convert receive hooks to hook API
In-Reply-To: <b03a96a8-af42-427a-8cf1-4d195be6a7c7@app.fastmail.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-11-adrian.ratiu@collabora.com>
 <b03a96a8-af42-427a-8cf1-4d195be6a7c7@app.fastmail.com>
Date: Wed, 29 Oct 2025 15:46:58 +0200
Message-ID: <87bjlp7rcd.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Tue, 28 Oct 2025, "Kristoffer Haugsbakk"=20
<kristofferhaugsbakk@fastmail.com> wrote:
> On Fri, Oct 17, 2025, at 16:15, Adrian Ratiu wrote:=20
>> From: Emily Shaffer <emilyshaffer@google.com>=20
>>=20
>> This converts the last remaining hooks to the new hook API, for=20
>> the same benefits as the previous conversions (no need to=20
>> toggle signals, manage custom struct child_process, call=20
>> find_hook(), prepares for specifyinig hooks via configs, etc.).=20
>>=20
>> I noticed a performance degradation when processing large=20
>> amounts of hook input with just 1 line per callback, due to=20
>> run-command's ppoll loop, therefore I batched 500 lines per=20
>> callback, to ensure=20
>=20
> I don=E2=80=99t see `ppoll` in `run-command.c`.=20

Good point, it's poll not ppoll. :)

(The while(1) loop in run_processes_parallel() from run-command.c=20
calls pp_buffer_stderr() then poll with an output_timeout of 100).

I will fix this together with the other typos you pointed out in=20
v3.

Thank you,
Adrian
