Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793653270;
	b=OBdvgMTeFRAUbBzzfXCSkeJli3VTWb1AwFNbfrbdcClLBV907kKcw+t4MACN2PWE79/7
	 2q4dOUjgM71ZTBXzYbLtcseajSoObweS8REphhtvigCvSwA3Phuf9qVudNM9zsj4ZIwnS
	 bGRLqgoKbymhf2xyTw8VjWvrDuKTHJ06V9WFw0lbFTgoDrGvNTHsHv1GcDKnNPRGOm8Mo
	 s+QgCIZUXz+5Vw8hV5kMS+tfiSb7/6hDbn5UGwKVmljElUJrCA6uNYboTxIDUh9j5H7/H
	 cCt4VhyFiyTc5tNckNYGN9pZ9ieRb14YbU0CdGlxfMQ6/RE8B68z0xFplourixcf3cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653270;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=WUViWgRmiomJvOEn1g7fZkbhRQZaY+T7btcMlXmiPAY=;
	b=SLEDhWTxKVPOoDyH3DgmVHz7Ihy0w1pK5sdFNiXRTGYwEWx+ANVri2uzjHFRTd0MAf7r
	 AAtwozZNJrfTSz0/q3xwxuzTMPXB5Zq/FZC+IGwtlCzFBvc6duAUfRw6TYHUkWPUnG+10
	 T7nDnh5MMRyXX1jJd9uL1X992Gq6q5Qb1gTKCc1ljeAHOcirgG+D8bbY5/HEhfdxYH/zZ
	 L1FzTEg447yk5gpeUhow1zkCPB/OwEi32ibPVUwQoCoVNasvP0WSarOJsUboVJOz7/NQn
	 0rgVuG0gzI918nReI9POwSSspW57/MgQCxoD6XhnmMqDDQjTjeIYDXh79K12r3XOAyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=JVgik0AW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ggBUuKdN;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ACB606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 21:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4ACB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=JVgik0AW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ggBUuKdN
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D4E41D0013C
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 16:01:09 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 02 Nov 2026 16:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793653268;
	 x=1793739668; bh=WUViWgRmiomJvOEn1g7fZkbhRQZaY+T7btcMlXmiPAY=; b=
	JVgik0AW8AkLvZWmBoiLwInbf74Ss16H+tJunqxeahmBiMzGlzGGI0Sm9Mkgl+0l
	+p6+UVPUyRzWOagirxZIaXNXGQqZk/3amqeelKQSbqEjWL8oWXkubZS6S4G/4bPr
	KPzXz1Fe5L0QIeB9hxNZ0/rmCy7DDlBTMxKH8p1lPy+/gxBnSwV3PeseS2ZGtSAt
	JbANxRMhco7/L9LHIwqJltS7isdK3vRGtkbUTkWDeobOY3fcJIAm1bWRb8yBuMAS
	JgfUcp4yfQOwRgxNKXrvmf2EoH5UAkfuFoWX75CHbiwEqmDxg1CalS8enmimbH2N
	Ax5WzvUExCKpZdT66Q1H5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793653268; x=
	1793739668; bh=WUViWgRmiomJvOEn1g7fZkbhRQZaY+T7btcMlXmiPAY=; b=g
	gBUuKdN9SmxQr8SCCbOiRlxx2yZFQMQ010HKVkcVkpjc/6NmnFFS/YfZxHD9irxW
	H9tFU32wyTFPeD2r4Hl7OJsEg+HrnMM4iebmMy8WbqmBx9N0SyVO0Gm2AMzVKhjR
	bGvLBQzgdrF5A1NHnPLJOjV6M9dCcIE5MzaysGPXMCUo2YG5WY8gCs5fDzsCROKT
	8UOI2YUPAJEAFJBiiM0cu1mALzuSyjfRhWfLCMFYp+rq2y/yK9WxeKjd5GNMHp00
	Hj7GB9Ff3X4OrcnZIcVK+tYQljSGhuJR2brOy496U8KN3DFrq7rHoUVERBVEl0Vm
	VfMyawssqHmrDJo3PpCYg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793653268; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dV0L9BOkiZWLlqt7oe1ND6//kTEmuLS5vrLbozqlcvmSqUj
	2yNDLj2mowhZVPm6Azh3M3qIG/lS4/OQW6AOn1ms7kg+RUD/1OI9yqgazC4bPBHI
	aq7SFpVXrqH3xP1lrSZXuuotlYl84ZTGP9ra+be2JmfkznaCxNOLSYar6AXTum/v
	veB9F+hztgk7P5aqrixWmAeXurrT1IEJhsVYb2R4lC/tCFaLYq9sGrNfl8quT/RI
	vWUrWu2YDNEORbltKEYVjhIeUz2kZWHo44ae+yxfuQrRQvjuI/0qkjaGoq+8TWd8
	gQGFbRpQAHLgNPvHdrBfxP8AhogAxIcFKc2KVMg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Sr5vMyuZAddXhX5lvAJD2vZyIMANLhFNKr1gRtb1cno=:TyC/eAUVqjxOVq7NtagesX9uSzKdySp38ATcBddBSdI=;
X-ME-Sender: <xms:FProasumqp20xtTt3YrqpK-SauG-8fBk0WrjzOQlHfwD6heJioLN8w>
    <xme:FProakQ6Nhz9gVrBtLE5zUidFaPre5wz9HVx5TNUdVrCKctfjVy7KgM80AbsN-Evf
    W7EZo9bVD6lznWNMrYKnNGI4PfyDpw5O6u43WbADWJRxJaE7rajr16ARw>
X-ME-Proxy-Cause: dmFkZTE4tdlks/5UQjjuDn7BqgKPhe6yZ9oSsDKkcfyOKAFGerX0uKoVvTNt4E0dmW4aX/
    i9HHA/hgJItqIBpZmLA6/Fz8NdaA9NTISxEfW2XfTUSsXJTQG7kQ+LTh9ywmT6Mtx0nxJs
    +Raa5IXUhFoaeTSeFLeq61qY1D+I/ygXfeLz7/3o+RO5FuLk975hnOuUZ4sJKJ8qr5mrG2
    uzj/d38iMbP2nzgdyfkT9kXm5nC4hClAgvQy1lP+Gk2GZGL+urcfd4FF2xu10wWYMntkxP
    9L1RRbOY8CUu/J1HejIbc7bW5luFHDWXyLbVrHIp8AEs3JJaftgXqK8scPD524U6T+BOle
    MQoFvmoPa18K1i8E553rDqIY+HbhxZw2sPt6F9W0zwNP0fgXfTsZSKWfRJwG5C4vergCGd
    rjuj8gHUSZshoabxO23fuUPuRoYYZhEnOE1chW3n+BthgVYXbAThND8D8W7QKGaTgGe+vT
    VBP8VC+SvG4tiS7npznJJGYqfSLLmjJYfSVQsIx+sj3z6X4Yawwkpd/ynLKafw0RZeJ4zf
    pVIctqr+LjKK9hmsoexRKX/zrVQES48x5C60l9J0FXyKNLLEknhwRMZ9EKwS7LuIOVcYAI
    dFF4OmrF4E5onw+UfSXUKbXuKXFEWXRBtA1UJl5dfGK8HQcPZuaV8dq7Nf5g
X-ME-Proxy: <xmx:FProakWfR3UJZlumTMzWtjPDhYLfbMUy144XrARB_ZR9AFN9LngNLw>
    <xmx:FProambcUsugapkmy5lgBIdBPSWyo1k6WbtTN2eKPDWjbaCq2SMgeg>
    <xmx:FProai2xlFMY7WWs-ZhY4iksS_p4HH2OeCMD2r1H1vOBk5bWACkz0g>
    <xmx:FProaggskNcChMVtYFwh__6LJf6TWB9F8uAvHej7FHx2K8PeZw2uJw>
    <xmx:FProairq61rgZFJ3fsiL8Ju18IvmUgOHBiexO5pf_KgvhIEtwZYzYxhu>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 85A7578273E; Mon,  2 Nov 2026 16:01:08 -0500 (EST)
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
Date: Mon, 02 Nov 2026 16:00:48 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Andy Koppe" <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <f194e2af-cffc-4867-9069-7070c86785da@app.fastmail.com>
In-Reply-To: 
 <CAHWeT-ZdZ0o=_rPWFPcXqCyc-WV=fzmKVRVx2LetfQzgYkKO0w@mail.gmail.com>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
 <20261101230326.3675597-1-andy.koppe@gmail.com>
 <840bc117-75e9-4d63-882e-3831156871a3@app.fastmail.com>
 <CAHWeT-ZdZ0o=_rPWFPcXqCyc-WV=fzmKVRVx2LetfQzgYkKO0w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] root refs vs pseudorefs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, Nov 2, 2026, at 2:47 PM, Andy Koppe wrote:
> On Mon, 2 Nov 2026 at 18:20, Julia Evans wrote:
>> On Sun, Nov 1, 2026, at 6:03 PM, Andy Koppe wrote:
>
>> >     ++[[root-refs]]
>> >     ++root refs::
>> >     ++    Git may also create references other than `HEAD` at the r=
oot
>> > of the
>> >     ++    hierarchy, for example `ORIG_HEAD` or `REBASE_HEAD`.
>> >     ++
>> >     ++[[pseudorefs]]
>> >     ++pseudorefs::
>> >     ++    linkgit:git-fetch[1] and linkgit:git-merge[1] create the
>> > so-called
>> >     ++    pseudorefs `FETCH_HEAD` and `MERGE_HEAD`. They are not
>> > references as
>> >     ++    such, as they are not stored in the same way, but they can
>> > nevertheless
>>
>> When I look at my .git directory during a merge conflict, I see these
>> files:
>>
>> $ ls .git | grep HEAD
>> FETCH_HEAD
>> HEAD
>> MERGE_HEAD
>> ORIG_HEAD
>>
>> From the above, it sounds like ORIG_HEAD is a "root ref" and
>> MERGE_HEAD is a "pseudoref", but naively it does look like
>> they're stored in the same way. What's the difference?
>
> Good question. The differences certainly aren't obvious, and they
> barely matter to users.
>
> Root refs:
> - Can be stored in reftables instead of files in .git.
> - Contain either a single hash or a single symbolic ref such as 'ref:
> refs/heads/main'.
> - Can be modified with 'git update-ref' (generally a bad idea for
> built-in root refs) and listed with 'git for-each-ref' and similar
> commands.
>
> Pseudorefs:
> - Are always stored as files in .git.
> - May contain multiple hashes, and in the case of FETCH_HEAD, carry
> additional information about where each hash came from.
> - Are only modified by the commands they serve (i.e. fetch, merge and
> pull) and can't be listed.
>
> The big thing they have in common, apart from the *_HEAD names, is
> that you can pass both types to commands such as 'git log', 'git diff'
> or 'git checkout' to refer to a commit or tree, just like any ref
> under refs/.

That=E2=80=99s very helpful. I think it would make sense to include
=E2=80=9Cmay contain multiple hashes=E2=80=9D at least, that on its own
makes it very clear what the difference is.

My impression is that FETCH_HEAD specifically is a
relatively popular pseudoref and folks would be interested to
know that it can contain multiple hashes.

If a pseudoref contains multiple hashes and you pass it to=20
a command, will the command use the first hash?

Also are FETCH_HEAD and MERGE_HEAD the only
pseudorefs?
