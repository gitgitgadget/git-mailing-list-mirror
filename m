Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.253
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017196;
	b=1w6v2hy4Ll5USgRbYOOhikThbhP7zDzGKrWo2FP3FS9BPmyiwHtFm9E5qMOlw610Plow
	 hzHLZFROaL18u3dg09myrvE5ipLWzaWr4ZqdxSkQjGiF6uhiqU0MXh04fB3JlBRicl5DX
	 hEEg7UDbrTJq/bYdcVXgjBGX3hl2fc6o85HIHVXC4DNJgrCw3wLePRc6mvkUaaksrvVQ0
	 ywJQSFLP+IQbHMJzUvozUNN0sVrCsx5czAlKUhuIDdrAkbLIusQX4VFgAK4voZ29rmUII
	 VROjS/e6pNbEtSxEW0wc4KMS8k9TTFcnHFzLKUEuYY/mqaX+RzCNGCQWjIeBdB/FjZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017196;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ApK0j0bPdb1ESi9sCla7LJKzV59Bzgc9P29+KhdbVI0=;
	b=XXVpdzJAmTs2AjvaWmm7qdWDL13ZebC1GgeDCZ+eJexhlPxbsd+EnoHCflC5hp8a3HBZ
	 ukwv985xJJY/s3i3cdzMarWQ4+Mph+spNZw4/kvxuako4khDL7C+uxqNjU6/ErrzqFIPP
	 v1/eL78PZnZAdKq7bPWBCUnTSGZOs//GaHq9WlamRO9qoQyzpHe16F/HYbO3eCEqWcO20
	 paxBKZPb6iymP/GTFTZ2FImNypKbPOnLQQAWqkBnxZgbkqJBqLFq93e6nmUOdD0dUnq2r
	 rz+t0siltY2s3NGHJ3BslsMvU0klI45LWOJeokFQiHwPxQa5jsNd6s4Gi1IJMfcm11g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=2HJDAJBV;
	arc=none smtp.remote-ip=95.215.58.253
Received: from mta1.migadu.com (out-253.mta1.migadu.com [95.215.58.253])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADD1606A336
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 15:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CADD1606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=2HJDAJBV
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VN1hVlHfLH54EYlZI2fsWfI9m4Jj6EGYRNzZyaIoTCA=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795017193; v=1; x=1795621993;
 b=2HJDAJBV/3TvxXAm2Pf1AMMgNQ3BjMe9SgdAP3V03bgE6Y42YcknqeqpcxRJjoAYwNf/WO+1
 NILjvnBpQTk3Cr/x2x1PoQ8/mRkqQKpeCJUKV7ZAmPGHDDk0gy4jdapRYe6honB59rFtLKCt1Nj
 RjtX67FElPNOWGv+yzQG+8iQ=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 1e14ca8539f5a291;
	Wed, 18 Nov 2026 15:53:13 +0000
X-Mizu-Trace-ID: 1e14ca8539f5a291
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] builtin/maintenance: only consider
 `gc.reflogExpire` for "--auto"
In-Reply-To: <20261118-pks-reflog-expire-performance-v1-3-10b9263566a8@pks.im>
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
 <20261118-pks-reflog-expire-performance-v1-3-10b9263566a8@pks.im>
Date: Wed, 18 Nov 2026 16:52:45 +0100
Message-ID: <87h5hejfw2.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> The "reflog-expire" maintenance task is responsible for expiring reflog
> entries that are older than either "gc.reflogExpire" for entries that
> are still reachable, or "gc.reflogExpireUnreachable" for those that are
> not reachable.
>
> When executed with "--auto", the condition that we use to trigger this
> task verifies whether the number of reflog entries that we would prune
> is larger than "maintenance.reflog-expire.auto". This is evaluated by
> walking the "HEAD" reflog, where we then check every entry by calling
> `should_expire_reflog_ent()`. That function will then check whether the
> reflog entry refers to a commit that is reachable or not, and depending
> on the outcome compares against either "gc.reflogExpire", or against
> both "gc.reflogExpire" and "gc.reflogExpireUnreachable".
>
> To decide reachability the caller has to call `reflog_expiry_prepare()`,
> which amongst other things also performs a reachability walk for a given
> refname. But we don't do that in the "reflog-expire" maintenance task,
> and hence every single reflog entry will be considered unreachable and
> thus we'd consider many reachable entries prunable even though they
> won't be pruned. So we overcount the number of prunable entries quite a
> bit and will thus trigger `git reflog expire` even though it won't do
> anything.
>
> Now we could easiliy fix that by calling `reflog_expiry_prepare()`.

Do you mean "not calling"?

Anyhow, from reading the diff and the surrounding code, it's not clear
to me where this is/was called?

The fix itself though makes sense. You basically pull out the first
condition from should_expire_reflog_ent() and skip the reachability
check.=20

> But in the case of auto-maintenance it has the big downside that we now h=
ave
> to perform a reachability walk in the foreground, and that may be quite
> expensive. The whole point of those auto-conditions is to use heuristics
> that are fast to evaluate though so that the time we have to block is
> reduced as much as possible.
>
> Instead, adapt the heuristic to only evaluate reflog entries against
> "gc.reflogExpire". This of course means that we're now undercounting the
> number of prunable entries. But as part of background maintenance that
> feels like a reasonable tradeoff, and a user that really wants to prune
> unreachable reflog entries can either execute git-maintenance(1) without
> "--auto", or they can run `git reflog expire` directly.

Yeah, makes sense to me to undercount.

> In any case, the consequence is that we only spawn git-reflog(1) now in
> those cases where it would indeed prune entries. And in my own working
> copy of "git.git" that I use daily that results in quite a performance
> improvement:
>
>   Benchmark 1: git maintenance run --auto (commit =3D HEAD~) (10 runs)
>                   mean     =C2=B1       =CF=83          min     =E2=80=A6=
     max
>     Wall Time    385.2 ms  =C2=B1     1.9 ms     382.7 ms  =E2=80=A6   38=
8.6 ms
>     Memory       116.8 MiB =C2=B1     0.1 MiB    116.7 MiB =E2=80=A6   11=
7.0 MiB
>
>   Benchmark 2: git maintenance run --auto (commit =3D HEAD) (10 runs)
>                   mean     =C2=B1       =CF=83          min     =E2=80=A6=
     max
>     Wall Time     17.9 ms  =C2=B1     0.7 ms      17.2 ms  =E2=80=A6    1=
9.6 ms           -95.4%  (21.5x faster)
>     Memory        81.0 MiB =C2=B1     0.1 MiB     80.7 MiB =E2=80=A6    8=
1.2 MiB          -30.7%  (1.4x less)
>
> Note that this improvement can be observed after every single command
> that triggers auto-maintenance, so this is overall quite an important
> optimization.

Seems to me the tradeoff is worthwhile.

--=20
Laters,
Toon
