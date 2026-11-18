Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016071;
	b=sIbrwDyDtjn3puRG/DAUriEEo+mThh6bzpPhts7wxuji3C8+cf6ru6kvjPD8yrzFyIhy
	 uHpszQomEUkxTZeXC5bMOOIGxhtIKOlqxNxnY5xBZ30KTYr93Uf35GX8vJK0YSMKkwGTQ
	 sj+M32F3iLMoRZrScYsPOzR2ni5/LxgXjB3qJP/hCcWUhi/WzlDCXhOjGAPP+6WYj79oH
	 Xyv3rw0WJH6Cdx2tWPgNTC7wyfXh/THWSSydpE9NwqsebESiVWE2+jIl9AsUSCxIS9HJ/
	 RYR1tlbfoVqbbOgNkCSyi7TOYGmnnXIXmRpESPV5n0nIs9B/U5owamRREaTnQNH3TEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016071;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wKrzVBdXSaduxd0+Iz9y/xvZswMIITp1y5iK0rMAe1Y=;
	b=tSdVmVGmJa6jUJwjD5LVcpID6QUCTU7+uhhvLJ5Icc3UTv5nylY4M+dNEIq188/HGP5B
	 uE8esDdclVwfobaqvzXPScXeGMeWUQzpvgrOfKWiY9YGutXlgRBaM1umzUPRzTh6sLUJD
	 UAh77HIngJkaOBiAJ6SUNBo6jSi/1IJZplHeHvWrDhzU/RgjlXhfj+DzM/pVkW75sQzbN
	 buClE+WOWAPcDMSqUy2yGPXBVIzC8JcmBxoll8y8W5cAMfDNFVUR11Daf+uiCp8BQl1fI
	 fvOo/uCVIuIIf8S3MHkPAJD+PovQIPwTYKXYcMX5EY4u2Xa8L2oaEpknfO641iHvqWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=KKPihBjy;
	arc=none smtp.remote-ip=95.215.58.138
Received: from mta1.migadu.com (out-138.mta1.migadu.com [95.215.58.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E85606A330
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 15:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6E85606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=KKPihBjy
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Tgt1KQzmQxA3ABTZbiOUPwf0yfijUWtWsNJdi3OaX4Q=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795016067; v=1; x=1795620867;
 b=KKPihBjycTjVkE3cZTzEwpOwsZk0cJo1kYdgshlVqVnYwDrTxiyj5Zte4XjNHf6i/xhJgFQn
 yW1yVid/rLyUl8HG5rUzfrg8cgZ4ydKpaCD445PmLXjzGIHzmFtPUVByudsSiKw/Dqrom4Czf7v
 /we4euH9q2sRetdaNL8u10cA=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 744bf09dca42ae82;
	Wed, 18 Nov 2026 15:34:27 +0000
X-Mizu-Trace-ID: 744bf09dca42ae82
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] refs/reftable: don't write new table when expire is
 a no-op
In-Reply-To: <20261118-pks-reflog-expire-performance-v1-2-10b9263566a8@pks.im>
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
 <20261118-pks-reflog-expire-performance-v1-2-10b9263566a8@pks.im>
Date: Wed, 18 Nov 2026 16:34:15 +0100
Message-ID: <87jymajgqw.fsf@dev.null.iotcl.com.invalid>
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

> When executing `git reflog expire` we may of course end up not expiring
> any reflog entries because none of them are older than "gc.reflogExpire"
> or "gc.reflogExpireUnreachable". But even so, the reftable backend would
> end up writing a new table to disk anyway that contains basically an
> exact copy of the current reflog. And with the "--all" flag, that would
> happen once per existing reflog. This doesn't result in any correctness
> issues, but it is of course a lot of pointless busywork.
>
> Skip writing and committing the new reftable in the case where there
> aren't any changes, which results in a nice speedup:
>
>   Benchmark 1: git reflog expire --all (commit =3D HEAD~) (10 runs)
>                   mean     =C2=B1       =CF=83          min     =E2=80=A6=
     max
>     Wall Time    736.0 ms  =C2=B1    11.7 ms     720.0 ms  =E2=80=A6   75=
2.3 ms
>     Memory       117.2 MiB =C2=B1     0.1 MiB    117.1 MiB =E2=80=A6   11=
7.3 MiB
>
>   Benchmark 2: git reflog expire --all (commit =3D HEAD) (10 runs)
>                   mean     =C2=B1       =CF=83          min     =E2=80=A6=
     max
>     Wall Time    370.3 ms  =C2=B1     3.7 ms     363.4 ms  =E2=80=A6   37=
5.6 ms           -49.7%  (2.0x faster)
>     Memory       116.8 MiB =C2=B1     0.2 MiB    116.5 MiB =E2=80=A6   11=
7.1 MiB           -0.3%
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c    | 15 ++++++++++++---
>  t/t0610-reftable-basics.sh | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 4216a18684d..e2027bb9c02 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -2607,6 +2607,7 @@ static int reftable_be_reflog_expire(struct ref_sto=
re *ref_store,
>  	struct strbuf referent =3D STRBUF_INIT;
>  	uint8_t *last_hash =3D NULL;
>  	size_t logs_nr =3D 0, logs_alloc =3D 0, i;
> +	bool has_changes =3D false;
>  	unsigned int type =3D 0;
>  	int ret;
>=20=20
> @@ -2696,17 +2697,25 @@ static int reftable_be_reflog_expire(struct ref_s=
tore *ref_store,
>  				    logs[i].value.update.message,
>  				    policy_cb_data)) {
>  			dest->value_type =3D REFTABLE_LOG_DELETION;
> +			has_changes =3D true;
>  		} else {
> -			if ((flags & EXPIRE_REFLOGS_REWRITE) && last_hash)
> +			if ((flags & EXPIRE_REFLOGS_REWRITE) && last_hash &&
> +			    memcmp(dest->value.update.old_hash, last_hash,
> +				   ref_store->repo->hash_algo->rawsz)) {
>  				memcpy(dest->value.update.old_hash, last_hash, GIT_MAX_RAWSZ);

I cannot help being bothered by using GIT_MAX_RAWSZ here, and
ref_store->repo->hash_algo->rawsz the line above. Would it make sense to
be consistent?

--=20
Laters,
Toon
