Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500F57C9F
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417555; cv=none; b=hqaCeITR+uu0+o+4ml1wZn4bpxlZRHNEZAg5pgw/SHJvrvetdLFl79MrnepUI8TgWYNmCME4ea72tc7jRKE78+chfMkivrKcQ5dN0k6n50l5jxtULbe0a2Hhi1Vi/PvCWx5S0/VqiJp8SILmISVFJwEXm6W9HDrJnLPUf3OvbtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417555; c=relaxed/simple;
	bh=AKPxNSvcoCNE8n2sNooEiTTLzDl3dbm5Qw1ote13wGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=idRoEwsdDXlvU9ac/g0qOWNRo1IGN8yZAqXIHiQGGUNLskgEwdWQC7SOSTgrYKFKA2cKYR/q9J+6fI83zIW316TbPqQuRrWO2DiCsdrLLStC6RrgdC3NbdBCUWWwP1wX78jU659gyAr7h02t46IyUMhHzaUMkpKzbn1qhv/TkA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=uXoiwMhs; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="uXoiwMhs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1745417548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=irw7JZb3pxBvpilFc8MfABY3oFcENwuXQfMH6Ye/lTQ=;
	b=uXoiwMhsxpMWQ9y3yDVBX6DHS4q/4eSFtoKM/EMgkVY8/26vf/oMuznzMK+YgdsKMqNEV6
	H9c0NUYAAFxVs+lGsAVfTYJ7BPA/iL6hRgnvqBGNdvAHIcRlUdnNiSFuUPrI/TaEpZgcOZ
	9GkKpPxAlaSoi9JHLvRf90VGRsZ8nKI=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 0/5] meson: wire up support for benchmarks
In-Reply-To: <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
Date: Wed, 23 Apr 2025 16:12:13 +0200
Message-ID: <87a587ezlu.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this small patch series implements support for running our benchmarks in
> "t/perf" via Meson. The series does not aim to replace "t/perf/run",
> which is more fully-featured and allows running benchmarks against
> multiple different trees. Instead, this series only allows running the
> benchmarks against the current tree. Users are thus expected to continue
> using "t/perf/run" for more advanced usecases.
>
> Changes in v2:
>   - Adapt "aggregate.perl" to use a "/usr/bin/env perl" shebang.
>   - Link to v1: https://lore.kernel.org/r/20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im
>
> Changes in v3:
>   - Document how to run benchmarks in "meson.build".

Thanks for adding this.

I have no further comments. I approve.


--
Toon
