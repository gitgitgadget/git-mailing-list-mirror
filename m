Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980937;
	b=r1Bbn/zS0S+W6yydE5jHYRAmcPqFxe01SFsCk0QLQfoumF8ixxfqis/F+7hUoduN9WjH
	 b8CpT2tDCMMmyvZdQtWw4O0/+izJ2BSifXw7JMXldBZC/zi2bxL4rP0QhGsXeJWsejc6J
	 51JaTWPOob9ONoraDZ9eMQG9iGMtDM1wsal1h9XVQ4k7BOd9MWRLb6EbOAPN1xIvem5Di
	 ojNja1RqYvEoGRmKIu1WB20+4t9uvAjjXorS18HBF+p/iEtYqcjG8szhIzcev+dot5MKr
	 V8sypUPaNWWbe4/PZuytW9pA0YUANWzsc0UwG7WgHxtb62Bv7lQOTuWnGaFhf6iyUHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980937;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=TlvzgNe84s7d7j2I3Ru2WN3lIv72PXEYWfBe9qtbXAM=;
	b=z4do7r/a7ntUSPscbtH4asIZ6wNi3ucsiaCTYtGALVd/y2KagsRHJccb2Hl1FxiIlcnq
	 ne8z7cpMnqXXYQQgl//3VR4JkGMdt5vKmiVe9vIPjEPiuqNUJukwOdoOln4ZTA7rIPOgf
	 RetnAeMAKDeYXETvBcqili54mkWJjX9smGOQmPPUk5ZQxc97/S1Rcwx0LWLFuPryWKPEL
	 NUih3smIqFVTf2FqJ8pNB46gsaRt8AioLt/T3/op5y6Z97Q4Jzkdq2qsSEXUOHYWYgXPi
	 Uw0rPKHxx2dqy9bi+jPpcFoh643D6JjkwbYX3FYaYB4XZIDwqU9LrZJ5ayle9VxBeSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=KbYJg4TE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xyg2kOVZ;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C3606A329
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 16:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 016C3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=KbYJg4TE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xyg2kOVZ
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D4871D000A9
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 11:02:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 06 Nov 2026 11:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793980935; x=1794067335; bh=TlvzgNe84s
	7d7j2I3Ru2WN3lIv72PXEYWfBe9qtbXAM=; b=KbYJg4TEN4hapNG1hlN/875pb0
	dLlpAMT1X1/GlvBAAOpaWqOXZMYTE6fj0SkMijYUXvvUtQIn9Dd3/QyTIwZiC56K
	dmNId1SsyoRxJfmXESHImu6qU0ruRbttKtcUUcvwX+fUnWjRjpaHk37U9bAUr32U
	5NOMWaOQzcJ4y+PFara7YMWTKWiT86p1/ZaUrBIsdvNjRrtYdNIhQSnaBbkPRUqd
	aJWuHCkOluU63zAFDNdOR1euecBcjnkEioSVTZWxmicpfsfHKLgl8mQkPGQOIqBg
	ZQXbPq6s5v2NqUlbWVgHLb2DzUh/vWbro8FaOjkllYzDFAsaPfgaE7MNoJzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793980935; x=1794067335; bh=TlvzgNe84s7d7j2I3Ru2WN3lIv72PXEYWfB
	e9qtbXAM=; b=xyg2kOVZDgxPa6qAM3zv5+fNFgj0SNSbYFb2wM86iUvZDx0UNwk
	LklUTi5c3eRniPPgSBMBtXJSfPLu8Iz468jqkUzPJw+KfSfty5qQJGtK2c/gl9vd
	i7EKYHStPH1kjVWyOfkOl+lAt46Aa/wnd4QResGsr6Edgl220Q2zd5SDVX7mP1O3
	SSsQboJdj0twLapnJnG83YbtfXFRMXieuLKooJYOiAFr0ddsR2aZBHEnpxigzBFo
	4+MNrM+7gm8Hkjns1G8UXamKDrt3bwC3FKwI+W03MhlAuX4GkGsmr3TQxI+ixq15
	uQwA9RAqP0aPhDY5xrfFz1ZD2JNIP8PQZgg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793980935; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cbxn7i3WX8zRFG2jtlE4+GYD0A3FiuN/d8JACdfCadenpdp
	ZIqlgd0LGvLD8RdBOYut3qsV4QQ5BdQrezStKOi+rTZchAz9kAUAyNmCrxP3ig8A
	hSl8k6uZBB2D6Qlo1ehSpY05M3LuFzX2HWD89DERMwED8fuauhk2Y4xkX9HiVNLD
	79qTlo4YlJ1+vvyALYl0gjiCknNy08l0jNMjzgVruMEW9vin0KWSCLSWbOq48MJA
	sLYaAz2RwmYLVhvyZSOclWQUPBzyWA12vbC6IxL7pM20IaTqcMwDY2/xOTMmeW9k
	MpBkiFH6oVZ1byru+aXRKOZdhx30aejKxfsPjgA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Eocw60sHghp1EmXQx6gRxfeScJY+mQdU6HLzsg4kvjE=:QyFytESiJTfh6tyNHQTVV5riayM4Erx4K6/Omp9mCzQ=;
X-ME-Sender: <xms:B_rtahiZ0yf56Wt1v_ZX6RZVoHAVHP5lwCTP3nSMkL_Se4aaVoK3tw>
    <xme:B_rtas6l8B1qckrrA9i4T_d9iDS_jB-iIDmVh8VyWGJje-44Kx_InCDBR2Kqsuu6r
    -5vtXKqKIslyzhyRfs-Q2ho8dAQjTpry00rcGdaCkv15wUJyyr-JPw>
X-ME-Received: <xmr:B_rtapY_aBU6HCmG8BTOAJ5tFJ4viv4DxLHBPItkE5ipwtGMeKRFeSz_6HikNfdmhlnDJlCptuHLIoQgaKWEfkeyfi6PrhXit7gT>
X-ME-Proxy-Cause: dmFkZTFTTQJn/E04IC9wOQEdPzdta7jawiMDB8tjSTVAFIv5qqiQ9WkP7Q5GNknDYNqnM3
    GDXKLwx/FA2s7r9qynlGBd1sBQ/CWk0JFpUYD3ART+gDM5at0pD461rOTUXQqJcKshzkgX
    bh/c93CiQskSJmbHpW5xKomrBCkWq0tV7UUkLVNwQaILEdByuivbJ/rnx2L+hpYLcq1FZC
    YgQVTfLQcvr24pp2M2mp4E0ZpKoxhv29z458CFXdQpcsmCbWuM3fnDBvFFkOjHIeiRhQcx
    k0+lfovIjTrDehUA6RRrxYyoCmAUcDnVpJdHHCLN2dKGR/QBZrVzC9rH5AdxFXfKftIusI
    +zQaUPzZ1pP9PLX0ORIXw8OlRrC/4nhR+YTQxj9CsLIii9eUPQ/ZXEMsX/bHnOSFXv/ti2
    lfOXbN4eeqcixwuCAVidcMAfTXdvT5ZY9rtHijPQWUQ33d1qiTK9p0FVeAO/soIJ6GUnlm
    r34KOz9gn/zjVei2NWiLHdFRBXUYDag7f8NtdYWvVd6xpajvnLlsxuYjRWEtG5sJSAZS+f
    YdgMSDWi9Bq9tyCHE7PAx7kHlo8yZxrW63A4/q1LB8WZ8k6cyeixppWDZlVBm68T/fgs/G
    iDJzQdsSospY08qjRoCWu0cXrvbVvrvmK6mo+D7JxNmCXiZq9RyJYqBUkKZg
X-ME-Proxy: <xmx:B_rtah4Bbf7B_1JbM9qkAUPxQTV5s_8HQkv6lLtRUKmlHV9gTbpltQ>
    <xmx:B_rtasAqKIQ6-ff-oJQ5ahowkJ3a6srENgt2IqzACKypUwvmnGWAfg>
    <xmx:B_rtancNf0hFpbt_JRx8QVG0dj_7gb_fHAiOfqFXZ2m_irCYbiVaEA>
    <xmx:B_rtarLtHvY1lOCziyZEqwrbDF6SplpQe9O4pycmXHg8dNdqF118Yw>
    <xmx:B_rtavXSOS65N1wBh4fYILYyqfxG1wAzMQg--395o3DND3Auedsi8iBc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 11:02:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Patrick Ohly
 <patrick.ohly@intel.com>
Subject: Re: [PATCH 2/2] odb/source-loose: fix existence checks for newly
 written objects
In-Reply-To: <au23Hvzp09yrym9s@pks.im> (Patrick Steinhardt's message of "Fri,
	6 Nov 2026 12:16:46 +0100")
References: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
	<20261104-pks-odb-loose-stale-cache-v1-2-a00d5cdb5e7d@pks.im>
	<20261105194314.GB2898829@coredump.intra.peff.net>
	<au23Hvzp09yrym9s@pks.im>
Date: Fri, 06 Nov 2026 08:02:13 -0800
Message-ID: <xmqq5wyalzi2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Nov 05, 2026 at 02:43:14PM -0500, Jeff King wrote:
>> On Wed, Nov 04, 2026 at 01:16:35PM +0100, Patrick Steinhardt wrote:
>> ...
>> So I kind of wonder if prefetch_cache_entries(), along with any caller
>> doing an OBJECT_INFO_FOR_PREFETCH check, ought to omit the QUICK flag.
>> It would mean that the normal case of having missing partial objects
>> (about to be fetched) would cause us to re-scan the local pack list, but
>> that's not _that_ expensive, especially compared to the fetch we're
>> about to do.
>
> Yeah, that's a valid point. Honestly, by now I'm almost urged to just
> drop the QUICK flag altogther. It's a source of bugs, and the longer we
> look at it the more cases we find where the existing users thereof are
> buggy in specific edge cases. We just recently removed one user of
> QUICK, and this here is another dubious case. I wouldn't be surprised if
> we could find edge cases for the other, remaining users, as well.
> ...
>> > We could in theory fix this by flushing all the loose object caches
>> > again, like we used to do before 5946a564cdd. But that wouldn't address
>> > the root cause: the cache would still be stale unless somebody does a
>> > non-QUICK read for a missing object. Instead, fix the bug by updating
>> > the cache whenever we write a new loose object.

OK.  At least this change hides this specific failure mode.  Can we
include some documentation that we may want to rethink the "QUICK"
thing and audit its current uses (if we decide to keep it, that is)
and move on with this change?


 odb.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git c/odb.h w/odb.h
index dd85b880a7..61ff443d46 100644
--- c/odb.h
+++ w/odb.h
@@ -386,6 +386,9 @@ enum object_info_flags {
 	/*
 	 * This is meant for bulk prefetching of missing blobs in a partial
 	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK.
+	 *
+	 * NEEDSWORK: rethink if QUICK is desired in this context.
+	 * cf. <au23Hvzp09yrym9s@pks.im>
 	 */
 	OBJECT_INFO_FOR_PREFETCH = (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK),
 };
