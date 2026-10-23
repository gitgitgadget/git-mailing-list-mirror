Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792781128;
	b=ApqbqZXtmObvqzL5jOgKC4lWn0C6hbS3SKlvDndaW8uIk0xynjajPCNTwDuC8+tcTVDt
	 JbRaXF/89IAB5g3Jse00bI4SBsCowjTMOTu6npuQFpn3E2lOE36IcjO4n0pkfIBTikZIy
	 fEU3Y9tdCbhRyrVBXBegf5fR0ZHGre0Cjgi3gIq5MjtKXXwa3wdAeaLzgjShutHjnWrmt
	 mxbZ7q4oz0U0WeyEnFZgbFhyQwjET3TCcuFpI1Wr7bm41aXWkiNlp4SQX0HcqvuHFdOVv
	 lFTz0eNmKQGrXURTUykxBC3rXq0DPOdsuL/X6HMW1WLbv4GOc2eHOddOKloWzKLHXuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781128;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Importance:Date:
	 Message-ID:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6J0Ap4JMhs6Nr/wq/KD4+4cWOUhIJPtFPtO2II2mQ4g=;
	b=xC7hV5NkCD5YEq9EcLvZioVtqbrtPhibT5YJg4xL82vnfC7mvoVoD2v/ko2wwL0HjJU6
	 GVZUjxO4uji3NerhvgHtUWrgD56cX0xcf17an7EJpg6vMErPHO3Y8Tv7HkN/zKkzRPRCi
	 bVKRKflOl5LKYwdPYIfARYqmG4Nh6AEAnxO6BACNwN/9oYqu/g/qFb5MYvPyXefS3WDfs
	 Rm2gR2gNpXbzN5hYpHWU8qwFy2Frw10kHXaTH/AFS0Y4QQV7+Pujl7m7+jm0Lj8xN7Qeq
	 3kXDQ1AQSdNGBuAfyT2psWo5nM0sJgcYLPo8Lvc/kRl3IUzhBw5YEnKE3Z8VJLUX65w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=dF0xXYBH;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kOpyS3kr;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F328C606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 18:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F328C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=dF0xXYBH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kOpyS3kr
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4434F1D000B0
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:45:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 23 Oct 2026 14:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792781126;
	 x=1792867526; bh=6J0Ap4JMhs6Nr/wq/KD4+4cWOUhIJPtFPtO2II2mQ4g=; b=
	dF0xXYBH4J0SdonYMiHKHK9pShx+RGESiB8/Bpm3UYV1nLNlq5kff960QPTL4udY
	Fn5W6qqAlS6L8s091iIoABNm4INxmOgugsed0yFxjpHL2hImD7rwRQa8V1Q3hR5V
	PT1ru3kji+8VJkhT3xt1VNyAXqipEtYrxOJnRWUjsVXzBLYBQMJg5kD0EwuF3xoT
	eW775m0L0F0mwrv8uqDm4y7X3smBUadnNL9vhg8vPUuaunqR/krsdQBF8TCmcwWO
	OTcjjGLY93vuZNSXEW8irJEuM5hOLTOsqmeEf/djGO86OABIHJApipOpJXDnxQw6
	BC7X+33QrVr1AmJl4pGS6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792781126; x=
	1792867526; bh=6J0Ap4JMhs6Nr/wq/KD4+4cWOUhIJPtFPtO2II2mQ4g=; b=k
	OpyS3kr7sayQVSIBpwsmsVPZGM8FnCYpgqHi5bzuDuQkoqleKAr1bjFp37PK+Sn4
	OjyeSTG8yZPwhrO77JkjgSoQCe8BUNsAjgZ5zgTaJBCw7hJlZCsKoHRtheEpEIJF
	uLO0NXRSlKf9ia/yEP9xzq2VHHAGAkXYbFpGNQNBls8i+c0Nj3yeUfRnbOaIc7h+
	rMlL3qb56wuzVQrvtD9iV7+3o2XN+Qs0VFzbJvXfNe35TUztpj97XAtAugFtRc7i
	7V8GhGSP3DqvBQrsrA10gz2CVITMbOMr21Xw7LmXFDZY/3HpnMfHn1jivHpi/cgW
	G0S2Rg3SL4hV+9iy+oXIw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792781126; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:PScGbxQj8pSEp9Ict4OG8q0g4WgWcoKfLNZJhfIJRziDokj
	JItrlRSjkLWZloAnRttDEsHYmP8E7XNIch8t1jCMIIuvF1zVJbN5dzp2iazivkU9
	CIvWlh1hzsUHIfgfjqLSR13XC3dKvBUGJmZHMniPN3gMVxE5j7N6JYMqiXUyN/C0
	kDnzXBbgBKgbJJWd39hWQxaq55dFC6zNavDskLeniGRR2JoF9R1Ivhd7GlIxkjPX
	gosnm5EaXgpky3uh2DYN87jOfT59es7gOok02+iijSMIxw8Np9kTbl1/7Y13FnI+
	Z7isDn+wpc4uLfWDNUSKHdsTolJn5+tBs3iQmFg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,importance,in-reply-to,message-id,mime-version,references,
	subject,to,user-agent;
Message-Instance: m=1; h=sha256:A7M9Q/OTuLjqeBmh2Obuz58Rx7Jm0KBiGB+JkqCmhYs=:l7B9/B3JynAiFYKvX4WNK7cdV0Xj2BQWRR7J/1N+LrA=;
X-ME-Sender: <xms:RqvbaurPve8oElhy0kv24gr87B086BoZWSiplvszLLwE4ZeRT8LSPA>
    <xme:RqvbagUExyvcaYRKEv-qOydDBxq9lr-29_LvXAkPny1m1WA4xifvtYMh98JfWwuW0
    MPInwuFdR9hyr1Seu83kGMz6onHeFGVOB51_h7TaDkRUp8FDrVY-Q>
X-ME-Received: <xmr:RqvbatCOuMSXR7yowD06eQAFwN3Yz3frCtvs2XzqAsmsYzVEY1hSrsHMXoDmOJ6PRp9sWmGImJuN59ZZkS7dF8nqUe3WZZ4a8jcB>
X-ME-Proxy-Cause: dmFkZTGT4HHZBOJ8Sn0EToOe7KU++x17UlQ5xrzB4vLou2eHQieGy3b2Fi8lup0OOXQ5TV
    USA0GdekmvmXtIliOlZ3aK7lZHXskNq8u/gRduCUh/NsfPaTTzHDUyXq5N8evaFGTKknZl
    T8yao+kaVdMp8KltB8qP8d5ejpEISLlS/8haNaQ7tt4jUhkX+ahyk0dOltT19q94pDlHyy
    KvIRPDn/FvkfseiWDSGaY+S9DKPnTtl01yMgSB6tEz3kZ+fxSOkNORU5LC7qPQClasn3U0
    VPwYd4pp/wg11lraiZ8N6vsPiOu9xkBd8Nq4CWFlhzyA4IUAjeS9nDLf6LGAFLXaA87pR3
    GVIvHUJyN2bG1QedNbP/dAWsi/QsiIg1e8bnUTEvs+tWkUCEDgdyydVyRLZRFl3g43QJVK
    scBOMK5gl66bmtguSGUxrYe0fwrlhmgu6IhKkvjamqxEJtwPyYh3pmAX9rMnS6w9oulyo2
    jd4hum2hI1XurTgzMAxXhDLAGV67GqSqsod5SXeUYOrNKob5YSJUZrwDvKF3zh15VJm4oC
    W9ygMA9Ipwqrc0cpUVKFMOb+q0XYgFivSkng7+sIqzHIadzo8SJTCnAfWMq4MBsCKSQSBD
    ryI4QDY8wOq43miaekhTtjroDypFZq8cCM1NOmYqTKnk9h6t4zKIsPaAYopA
X-ME-Proxy: <xmx:Rqvbak0ekX4ER56wjYIeqwsR_mGqIK4LxIBsiNEIfK_67l7L7loJVw>
    <xmx:Rqvbav3jdGD3abdBkVFZ78KMg-zaKHA10DPkiSVfrMatW1zoguKsRg>
    <xmx:RqvbapB_Bjm6mc-WKFtJpuOM4wIeoCGB9P8mHINyxSrKxRjmFtPMSQ>
    <xmx:Rqvbau4mKKUsXY8vD-0arcwH0qw3Z4t54m061kOjHHfhEf2k_3_kFA>
    <xmx:RqvbamOGpyaxRJUIJoTJWgYnJ1vwHwT109q-6SH6PUk3VF2rtqdJx0Ro>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 14:45:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Srujith Poojary <poojarysrujith@gmail.com>
Cc: phillip.wood123@gmail.com,  Usman Akinyemi <usmanakinyemi202@gmail.com>,
  Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] [Outreachy PATCH] diff-delta: use safe integer arithmetic
In-Reply-To: <CABh_KWgBzCXCSn4FUTSg+rXYj9vm6+AVZnDn3iR_4UJCsB8tjw@mail.gmail.com>
	(Srujith Poojary's message of "Fri, 23 Oct 2026 22:26:13 +0530")
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
	<xmqqld7paty9.fsf@gitster.g>
	<CABh_KWiKmXP4KTgF=k2gGdSvcZXkRipD61AVn+AS7ZgvhcjHWw@mail.gmail.com>
	<xmqqtsmca0yy.fsf@gitster.g>
	<CABh_KWgBzCXCSn4FUTSg+rXYj9vm6+AVZnDn3iR_4UJCsB8tjw@mail.gmail.com>
Importance: high
Date: Fri, 23 Oct 2026 11:45:24 -0700
Message-ID: <xmqqcxt05k8r.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Srujith Poojary <poojarysrujith@gmail.com> writes:

> On Fri, Oct 23, 2026 at 9:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Srujith Poojary <poojarysrujith@gmail.com> writes:
>>
>> > Thank you for clarifying this. You are right—st_add() and st_mult()
>> > call die() on overflow rather than returning NULL.
>> > I will update the commit message to accurately reflect this behavior
>> > and submit v2.
>>
>> Please don't, before making sure if it can overflow.  With the
>> number of entries capped like this:
>>
>>         if (bufsize >= 0xffffffffUL)
>>                 entries = 0xfffffffeU / RABIN_WINDOW;
>>
>> and then computed
>>
>>         hsize = entries / 4;
>>         for (i = 4; (1u << i) < hsize; i++);
>>         hsize = 1 << i;
>>         /* allocate lookup index */
>>         memsize = sizeof(*hash) * hsize +
>>                   sizeof(*entry) * entries;
>>
>> it may not be possible to overflow size_t even on 32-bit platforms.
>> I didn't have time to do math yet myself, though.
>>
>
> Hi Phillip and Junio,
>
> Thank you for the detailed feedback.
>
> I checked the bounds: since entries is capped by (0xffffffu /
> RABIN_WINDOW), hsize remains small, making a size_t overflow
> impossible even on 32-bit systems.

Hmph, I actually came to a different conclusion, but my math is
probably weaker X-<.

entries is capped by 1^32 / 16 = 1^28, and hsize is capped at 1^26.

sizeof(*hash) is 4 bytes on 32-bit platforms.

struct index_entry has a pointer and an unsigned, i.e. 8 bytes.
struct unpacked_index_entry has the above index_entry plus a
pointer, i.e. 8+4=12 bytes or 16 bytes (with 4-byte padding).
That is the sizeof(*entry).

If "struct unpacked_index_entry" has 4-byte padding to align at
8-byte boundary, then memsize = 4 * 1^26 + 16 * 1^28 can overflow
size_t's range that is 1^32.  If the struct does not have extra
padding, this would fit below 1^32.  We have no guarantee what the
compiler would do, so we need to assume the worst.

Of course it is entirely a different matter if malloc() would allow
such a large allocation even if math does not overflow, but the
focus of this patch is to make sure memsize is computed as a large
allocation in such a case without wrapping around.

