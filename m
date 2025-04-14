Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11FF25A622
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621696; cv=none; b=f4P/gWxsS1xZHM0SBpnmIVYPb8IDduaCKT9ZnXg4edCrcZyfqa4GcSQnD82oekUUAHm2YALZ91Zcw396v8EJkazPnrXgMmZNN4MngcuKhtXtgeDrYBANl2Smz/RfNGxTvkOb9vTQ6Z+jydLFkwoZXsU05edJTSu4vaZ8Cx5292c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621696; c=relaxed/simple;
	bh=Mv31/CI2ARhyI6fyjy6UMtExupQo+CqE/0Y/ywmmkn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oM83ufQCNbO9tgEwciahcTbhxqLoGDRd77lNjZRS2Am2Jd+Hm9LHwL8z+PONUWVY72nAAP+3GqAGGwjpnxJRII0dnxzjhi484mWaU+HQPFhwmrHrpnROC7xAstlM0j33VYR2HRCQIT0iAqBbgz+Oc29AGJYLkE4ntCxLGeD+BB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=N95XdoNg; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="N95XdoNg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1744621687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DBrNeFiFmmBzQmVgM7YeVMx2MIa184R7Xk0UliWIBaA=;
	b=N95XdoNgOO6B+Ca3h4IPEEGXS2uzBpcnTvnCTqC6e1ozRyqxuZA3RTHRR0zoWvKKL376hn
	M9UacCsyUPln43AfhDYzuz39ogdJ7ZkGubwTNeRSRDIEgj6XXd60VSyLVCsHTnY+t30ja8
	9q3laWTk0qVYbLWdwoXksY7Kz/Q+d0Y=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] meson: wire up benchmarks
In-Reply-To: <Z_ywMpJ7PuOvQu2k@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250331-pks-meson-benchmarks-v1-4-b2ace85616a3@pks.im>
 <87r020dyvc.fsf@iotcl.com> <Z_ywMpJ7PuOvQu2k@pks.im>
Date: Mon, 14 Apr 2025 11:07:57 +0200
Message-ID: <87frib5cwi.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> You can execute with `meson test -i`, which will cause Meson to print
> the benchmark's output.

(annoyed grunt) I didn't think about using `-i` here, probably because
it wasn't used in the example in the commit message.

>> But I was wondering, instead of trying to fully integrate Meson into
>> those scripts, could we modify the scripts so they work with binaries
>> built by Meson? I mean, if we could run
>> `cd t/perf && ./run ../../build1 ../../build2 p0005*` and it would
>> simply run the benchmarks in those directories (without trying to check
>> out code and build the sources). I think this would help a lot already.
>
> This is another thing we could (and eventually should) do, but it's
> orthogonal to this patch series from my point of view.

That's true. This series already enables me to use benchmarks with Meson
and is definetely a decent step in the right direction. Let's get this
series merged and we can work on better comparative benchmarks later.

I just reviewed v2 and I approve on this series.

-- 
Toon
