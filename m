Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271940;
	b=VrSFd3nK2Gs9hfWnkOoOK1I6cGInSs+0e/Ryvf338OgZ9oEsyuC4Nq2dJqxz3y2iGr2N
	 iX4Onv+8dnaMBRMDasHC1ev9gRbzejj1pBF42K0rvDsGUi/Mry7ZD1TSQkQCJiRDzusDr
	 cA1Jv7YuzK25bO0SJUjxfWF6mU2dnheRTw2cIm5siiFextRXwUB6doSScTNKKHPtCVOH+
	 RDusXeU+LXIjO+9wn14/jgVu5zkxBkbPlNXj8zybLmCV/T3PFNmIrTQ23W1qMugaGlAcd
	 dTyJyq7TSzHUYqI/ZRmPCbgcom4v/8PPajQELUbGLqCOwPqeZycJll15+icuxQr59xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271940;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=7NhYdPeWRSGIAUa4OO487OsvQULpZ3QTZfGdipqXox4=;
	b=KGSduUVny78WMoz2O61vNTRg3OIXihE6s3VacqeWBsLDwgRhzU+ILTlZGQIoanONoggS
	 8N1QPcBR+yepVV/U4Bl0swr7bEbwHXyWC6nrvuEzvFMWPzCachtzUIv7SRfTjgAo1Mi5C
	 B9rMVd3WkOFLmp8AHZFaXJnFxuvVDQduq0Bc1HzhjqH4eBm/LbKI7P/6lAe4XRKg0d+Hl
	 bZ6oi6mEPtnTrcwwopU5q85WZiiAzr2q3GDBu1zCyeemdRcMrJ1aAgJYSQ5f2E1us1lmO
	 CIfU5trqQY6gIcGGvTTvDWISxt8AMYo88Qnhk3n8Mf5DwvnjIzlsQDDXeMAytkXqQWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=pthK02xY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tdQBtDs9;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87406606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 11:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87406606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=pthK02xY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tdQBtDs9
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 75AAC14000C1
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 07:05:38 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 29 Oct 2026 07:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793271936;
	 x=1793358336; bh=7NhYdPeWRSGIAUa4OO487OsvQULpZ3QTZfGdipqXox4=; b=
	pthK02xYahHRWb77LJt1nSRLErxYULN6j1iEseUXNzOrEzw/2Pl15Chjfmnrru4s
	REVHts4TWw7xOOzewjwfnXWsPYXD7rt6HGFAtzOjgPsgKqMZLtbQQlKJPjeFKPgp
	Z/q9fzAxG1YMpSEPQcXTRhM7aqP/l5IZf8bnm4WyhUkipleXb3VfwQHWzjTRs3fe
	TJ0ogtHli6UF8TfnMxgr5VvAbHzw4O65eXsCPfhHC58c0V5wMOPo5VLZxqFCR2rB
	136s7ocQwSsz9IKK7v6SfxOW0RZ7AqQK5q0aTtRH9BZ7c6cJ8Rlhv0rE4sivB1Yh
	K+eBMWeTSl5mgOe6sbA9jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793271936; x=
	1793358336; bh=7NhYdPeWRSGIAUa4OO487OsvQULpZ3QTZfGdipqXox4=; b=t
	dQBtDs91wHbT5j/vqcpqDYnTP7hyCQosluMvaSyISW6+pftwcGv0nVClkbHTI76Z
	swWwOUbReVC7ox4+kH2MgUgflj3ImtV2FIf/ZbtWs0YN0ImE6vvr//WQvg2+Bqsd
	XFPrROvtvcyX3sjnowX+9mXJOJmZZj6EQSm4F9a1JG0qd9bl6ij0LPcnH3aPThUw
	XlLL1fgS9Pe9B6aCDO6iAkP8r0UNJP8GAGDFGoLj8uPQhlvDU3CDi+bmp8H0gVPG
	1rRFmz/dAChtlifF94sGYii2dKTTD0TrTC9RinFtHlpEh1J6UiiSbCI4P8h+SOJ8
	eMahtjJzsgdJFN7jFTXUg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793271936; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:qjLoZQOBRorUfHi8bGaLcIrlAdvKpT1Xk8NmTExnq2ujr5O
	u3MA1A7SulYryNWjSrt5wCcrsjjADGgb7eunioZ19e2A0EY0FWbuuu0jnLFUG14x
	ak7zdeGKm7MLdKcc0KbGh+ScVyCmyR9PrTfFuqk3n+jwlvwpa9nDDMXdGk3ICtho
	e8aVRv0qqo5WskuU4F0jRSL7fTdYAwIHmV/+/avssM+LMclpFGno000TAf5UegtY
	uvDVDZtUR79gXA/ZFry+akBaH98P3H7MbySGEwSdUIlKVmuUwMHVAWiUctNFLJAS
	iqRtIWNSW6R4MgI7nplmUvkF/0KD7eXFJ1P+8Aw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:WgQQpXu/vped6Xm1GK0LainAk/hzauZ0ll/8Tz4UWlI=:S23+R3yV5rL0Nx3SdyfzdCSwbs9yPRjsMj3Mi3wGES0=;
X-ME-Sender: <xms:fSjjarY13VU1HRYEivc_I8jf0w6qa7fUSmpn-f3UkTrrfWtPhBzHH_w>
    <xme:fSjjalM2yICjliUV080_iJdfPxubaM3U2eSzNoaDsk7zWvFl40_wd4ZBRqENpibkF
    6IJ-yhrH7rvDOI0WYv5S2JPDXBpocurLhlhWpQ6cCAvKJODdoZPYgQ>
X-ME-Proxy-Cause: dmFkZTGpj8mgmO4j33P7KX7aOsZrSDGH5twaWcy3lWW7MaAtEG0jCSyZdlmFV/8cwJJNXo
    KbSZoxs1rigXb76jxsZWDZiBkDdMMwku9Toeq2m0JqoHA9SpmzxOPniiHl0VngViZTs2iK
    O30uMg+h2Gn7Q7bJ3NF2DZhd4Gu7+yPuBfOZYs1tPhRLPhJrSc8BwAZqMa9K8g/K8SMrsU
    C6O3+K77GD2V8w2FyGsUMDD28k2MF3hQkcFoGW3vDImROtSxIyL69cn0YvNT6zBX+kL8QY
    CdFAmWMksYV2hAxBcERs/rO8UQYrGZTcA20Rc8UICDrhUGrYE4//dMnN2mRe/MV77bWct5
    5JsRVAOOllxwMxNn4cIYCXfbOFQ9or7S2u+uObDzaFGoM8KjR5pwG9mtFuaX0WW+N0N6f9
    EaEAHfHV5WeGGs02LkgjEAFYPWFETFMWOdA/mUO3+UCNlOgXR6l5mrplnfDRQVjlDN5rWb
    9VOSv+UnQBhOotq5c65AFKAo/90MymwB4aOuYbuXBX9GNfKDgsu+oiDMhsQSrQMo33YJJ7
    SB/2zXj5XxbWM4z0YjKlRVCH5lr9eWbeGYkXaFmvxKVfsw70XV9Mf4o/KPtmkEUiba457Y
    8q0W+VWHvqToQawMs4NJhOJMBJYIvvyCNHpio0QCh1U1noStGjBR49wzKfOQ
X-ME-Proxy: <xmx:fyjjagCf4EV_IDqupR4lpj7d6NtCjHcC0KvRIOdgVbPOWu9vHydpRw>
    <xmx:fyjjagXBnfy5a8z31xgPa5pSFz8EcfRMXE98JNs9wCrdnCWWfbL_cQ>
    <xmx:fyjjauDicj4N-scAcLTo_pUD7JFPXdIhH6D4Nm-IPsljG3rAiQB6rw>
    <xmx:fyjjaj8n1oNEmMKE9amqG54Fwv-cIo-nVNC1bioeOF-bTAm1KLyW_A>
    <xmx:gCjjarEO7LrCndQh3LHODexJXBFVxR61z-nuR3OZyJIIAYfTrQgN5tSe>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B9D5922C00A0; Thu, 29 Oct 2026 07:05:33 -0400 (EDT)
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
Date: Thu, 29 Oct 2026 12:05:12 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Farid Zakaria" <farid.m.zakaria@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <3c4f3793-07d4-47c7-b503-13a6ae567147@app.fastmail.com>
In-Reply-To: <20261028-fz-notes-concurrent-write-v1-1-3d513e1fdbb7@gmail.com>
References: <20261028-fz-notes-concurrent-write-v1-1-3d513e1fdbb7@gmail.com>
Subject: Re: [PATCH] notes: do not drop notes written by a concurrent process
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026, at 04:55, Farid Zakaria wrote:
> "git notes add" and the other commands that modify notes read the
> notes ref, update the notes tree in memory, and then commit it on top
> of whatever the ref points to by then. If another process updated the
> ref in the meantime, its notes are silently lost.

This looks like a really nice find.

>
> The fix is to remember the commit the notes were read from, and use
> it as both the parent of the new notes commit and the expected old
> value of the ref update. A concurrent update now makes the command
> fail with "cannot lock ref" instead.

This makes sense and is how I would have assumed `git notes add` and
similar to work. Because you have:

    git update-ref <ref> <new-oid> [<old-oid>

Exactly so that you can try to update a ref with the assumption that
nothing else intervenes, because it will fail if <old-oid> does not
become the previous OID.

So I thought that the code that git-notes(1) uses would work
the same way.

>
> Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
> ---
>[snip]

So if this change is:

=E2=80=A2 Before it silently dropped the change
=E2=80=A2 Now it loudly fails

Then that is a pure improvement.

However, thinking beyond this patch. Let=E2=80=99s say one program wants=
 to
add a note on `master`. But another one wants to add a note on
`feature1`. One will fail. But should that happen in a perfect world?
Let=E2=80=99s say that `master` wins. `feature1` is not trying to =E2=80=
=9Cclobber=E2=80=9D
anything relative to the `master` program; it wants to add a note to a
different commit. And does the `feature1` program care if the commit
corresponding to the note is a child of the commit when it first started
the process? I don=E2=80=99t think so. It does matter for two programs t=
hat want
to update a branch, but here the commit structure is a kind of
implementation detail, how Notes are implemented so that you get
snapshot of the notes as well as the whole edit history. As an example:

    commit A, commit B, commit C, commit D...

It could just be shuffled.

Instead, maybe this would happen in an ideal world:

1. `master` and `feature1` race to commit a note
2. `master` wins
3. `feature1` notices that there is a new note commit (from `master`)
4. It checks whether that commit changed the commit that *it*
   (`feature1`) wanted to update
   =E2=80=A2 If so: fail
   =E2=80=A2 If not: continue
5. `feature1` retries (go to (1))

Maybe this is too much logic for a =E2=80=9Cporcelain=E2=80=9D command (=
interactive
use), but there is no plumbing Notes command.
