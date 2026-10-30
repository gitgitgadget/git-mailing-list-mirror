Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357259;
	b=mSYnHXB6RED9LUSl6HSK/QNM5Fun0Vp0C/PShIPb6u92vuBD8sC8YikUMoySg9HFHsAO
	 xT+KRXYtHWp/wU8Y3xKN1r7gWxNu3GQFefGqveyJJnxntxLc85BPUwlRZBZ/vNt2silha
	 od8PMQ6ab5dj9E90D60Wd3JBVxpUyX/t7Ee2AwDM6qpSKLiZGTfDvt+b9F+xmXoX/RXwd
	 Q1B7B/Py2ukeQIpa68GAmAwxkqXYn+/am2u+cOkWt+YHKuElal+9H/3+/7hiTLqZsDdwM
	 p4b5B/71te5dIn02G79ETvM8obuqh8mWb451WuQddOEUdIJNMZf25vjyHA+ivzGCBTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357259;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=cNq6dLiDLtZzF8zI57xZ17QTT8GYLPEpuScLrD1mvag=;
	b=Fd2EVDfTUgbnEjdNQb3f/9qOfnQ8gyUhLs/fhTEC+4AoEIip2v4mIjN3ZGqHfOcMd1/Q
	 0nRqgN4vesjuNZ9Va4rJgsKO3vqa4p5wBFIafhhfEWVt8yKciMFaF0+6Cke8NB2kfk35n
	 m0jcRqAzHjsphcSCTbDy3S2h8PEw3d/VM05rG1Ff028A8xLXOjz0QhZQWO0DKZIGtXZ7H
	 oT4Z/RLrjEsZaOuzFu/BxxYG8ksyzf3ovX86R/r4sUGO64fOZaAQJO1s9bOvKjLKCqiWO
	 ZHhe5VGEbh4Z0oQdRZTitccAxchRUM668r5bzmlPQnGkzFCYvmCbKUV7tLX/Y3b17lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=fZcs3K39;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E6yvPpS0;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8961D606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8961D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=fZcs3K39;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E6yvPpS0
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9CFF77A0160
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 06:47:37 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 30 Oct 2026 06:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793357254;
	 x=1793443654; bh=cNq6dLiDLtZzF8zI57xZ17QTT8GYLPEpuScLrD1mvag=; b=
	fZcs3K39ktTN4rVcuzjzIiRIb1aySzpl4/aWlW9mQ8xuV+AZ4XvpAbGtvUmEZ00I
	aKylO3ih7yBQTAL7ppfRKF44P/sSxjJ168AmgElcnZ6MCkHEobnhKPjmV3dgwoe0
	MIJEixLkTesEmNPddh3Q81AcZplMM0yPYWK+5lAdUuarvjIE4dmJ4zyCl154zls8
	mepK2lTskftHLJWCCHGC3NUsWoKBHV3Na7sWz/Ln7HJLWEOGS7mUitc/Hd98l71f
	unScVJUeY1jk4HpZZYR9aMtINcxi9DsRc3VQwd0dNkCdQDlAWaP+dNASe2/ZdBcM
	fva8TJwqB284ekl1WCr2gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793357254; x=
	1793443654; bh=cNq6dLiDLtZzF8zI57xZ17QTT8GYLPEpuScLrD1mvag=; b=E
	6yvPpS0Fao5nK6MWFvwFx5i5v4WBJLjp5uvdBVFztfJEeONZLWw3lG181Upl9wis
	S6jivyQC9wbOtV4VIxMCdAX4Wpl9oe5RBNgaYRAvJqnunWPAF9cg1TzadqJ3n9Ch
	bq4Xx2fiWMhTmqiOOBeNnr2nvSt+hVh5ZBDf7tc9PsTFixl3ZJPpBtty3d2JvAN4
	fvIHgIHLLMMhYjY4J5Hz83uX3peBgdV654qQbQx2Xc62c7dSBYP8bCYsppujQWLX
	45ks85nRTl7xPICkN+MKBfzaHqVjzmITx+qNP1bvf0ThVFcHAb827DK5G94rWSn2
	rkA7L3Yj90KlDgdmF7iCg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793357254; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UQqeoX3VWJ6nbn8WPkr+KSUz6loyB4bPlwQ4Pfqsq9nQgy1
	eP/EK5lTnVFpRZFPOoPMufWZ0ev2aQiJSurZe6f+Y5/pgQ4ZsB5M5MN6gDjNQz7E
	yjeaO5WQv4zIf72sGhxwfWX7m8xoRRfVF7mrvnyYaIajgUozv7UxEalE31qPnKK0
	UR6m+IlAl7Lnw5eMqNbl+Z4nYGuHZIewsVbUkANYkSyIe39re/N9tVd8I5MNgXUi
	zmlnTfsoBlWBFGFW70iSC42k1S4VcBc/ZH1iZ9NujGYLnRUxeHgjjKrtqHJgVkV/
	P+Ws2h1XTXQlDt89IvEm7muC2hAzrCum0ok+77Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/H44Pbf80jZB97ZtBtccCbdor2+mF6rqIZPMNBb6tT0=:O6w3eBhog4tHwYFDTKmYO4fhp6eN30MxGoeWGITAbHM=;
X-ME-Sender: <xms:xXXkagVcAsnNZm-QFktNVYh2jOloahYDUhrfz6gAih_CFCr14iLFSo4>
    <xme:xXXkavZ_2LpXRacP6F9GyheHCnxVIvfGIBsIMeQSyZOyZ2rt9jYbj060zVyDW3w5H
    hv6MD3mhnGuvflv4utpA4kN6CojXky-Lq4rAb0oLp_zJWw_dG_qPfE>
X-ME-Proxy-Cause: dmFkZTEunOFKlkbaRVLhA0UveL6xAdHAwInkrqnsGwxr+CT6jV9NgkrxNJonsQCXI+yMLr
    HMf7lADsGZl2sjgBvnpbFp7xSvdHd+zSrgEft4/cIJ5pLNCLAOHoBh4hSmFI1FLrJQXHDx
    4lICKv+n3nuP/PA5iAPDs4hxeqLqbTMq3t2s8WVZP5eBKopJCbGHnVoLRE3kM9ZpOOCzHi
    WkjkRKcLPtizsBcq/vGIPETi0/6+kq3byBEL0ydcdYlh8XW9vRkevPUoHh/CWjVb+HzEev
    bIC7MWMOjkmX7lkkmjnFc6detOTEMIsaNEA3y3Q4VIBp42kfI57Hu4F7ig2POWpgfSeEM/
    Bm1gK+hTk/AcarJjYLzfrpKHuvs9HJBIdCRgrfmr/f8RYGriDL2aSCioFqGlwotT0LvE7d
    l/EyD1VSV22M4VBy3HUMo5EwM8QcdtzMG3TfVXwx3XgfNNxDduXVx0S90tjZ6q6rGVa1U8
    LA0OL5feIPpbyY5/LCDa++WmDvghyTN9KyimUnwGXDP7kRR6QqChU58up+fw6wOkMOeg2m
    hG1skZwJaCss05OMY4628ZoXH1zeA/reh9tOTU/uDMM1gvaL7dh3Tn42eJdIMttPutoqkE
    ksseE3ovE6EDrjgH/JLUZXtKLkLmX4lhRROpidU6Tq2tlfR+w/QARHeg4MLw
X-ME-Proxy: <xmx:xnXkat-pnMQuEGFHgnjHEj9QswN7d0oqEL7_SylLfuDrq_LNu4SzkA>
    <xmx:xnXkavi7BkxE-Uho4qSL-8DmkG4_UXF2kG7bGlmWgoP6lipz4grCTA>
    <xmx:xnXkalcOoHEA7s7JL2_eJYygnZI2I9u-zsnNqQLA9ylAo6dmnxztkw>
    <xmx:xnXkauqS0iYAtzS15e3EsUJab7nv3M1k2ra8UrkAFxg5SpBTBeyzNQ>
    <xmx:xnXkamxNeShRkTO4pyhpUuMAZmv_9dmlhsStC0ie1SWpuCJyA8ecWwGW>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 0BF2422C009C; Fri, 30 Oct 2026 06:47:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AOwTqJ9IjbyF
Date: Fri, 30 Oct 2026 11:46:14 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Farid Zakaria" <farid.m.zakaria@gmail.com>, git@vger.kernel.org,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <08f52196-766d-45fb-a250-08a9ab4aef2a@app.fastmail.com>
In-Reply-To: <xmqqbj8c2wk8.fsf@gitster.g>
References: <20261028-fz-notes-concurrent-write-v1-1-3d513e1fdbb7@gmail.com>
 <3c4f3793-07d4-47c7-b503-13a6ae567147@app.fastmail.com>
 <xmqqbj8c2wk8.fsf@gitster.g>
Subject: Re: [PATCH] notes: do not drop notes written by a concurrent process
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026, at 19:25, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> Instead, maybe this would happen in an ideal world:
>>
>> 1. `master` and `feature1` race to commit a note
>> 2. `master` wins
>> 3. `feature1` notices that there is a new note commit (from `master`)
>> 4. It checks whether that commit changed the commit that *it*
>>    (`feature1`) wanted to update
>>    =E2=80=A2 If so: fail
>>    =E2=80=A2 If not: continue
>> 5. `feature1` retries (go to (1))
>>
>> Maybe this is too much logic for a =E2=80=9Cporcelain=E2=80=9D comman=
d (interactive
>> use), but there is no plumbing Notes command.
>
> Or possibly
>
>  1. two races. Both remembers what commit was at the tip of the
>     notes tree (call it commit #1).
>
>  2. each creates a new note commit on top of #1.  Call them commit
>     #2master and #2feature1.
>
>  3. 'master' one wins the race.  As #2master is a fast-forward from
>     #1, the notes tree gets #2master at its tip.
>
>  4. 'feature1' loses the race.  It merges #2feature1 into, or
>     rebases #2feature1 on top of, #2master and updates the notes
>     tree.
>
> ;-)

That would be the most elegant. But I think doing a three-way merge
would go too far. Say you have another case where two processes try to
update the note for the same commit C, but the first process edits the
start and the second one edits the end. These are far enough apart that
they merge successfully. But I think that such a race concluding with a
note merge would be wrong in general.
