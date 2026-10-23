Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792781349;
	b=VO8Yo/+426cblHgTPCPHChkD22u2tYBNX1TUwdLVCp7/pNXxBryVfcnaQgwaUwfVHEA0
	 fRsRr2I9Vt5BelyZBTe5lWsn/DP1tYxdosYs8OtedUwldAPRyspAzYlEwBRchWV3s6rir
	 V3R8fSfjydG/dqYg9WURZ6JU4tlxNmO63doJMRXof9UyAPMWV84dwQ6gZPRzC4NoIlmXI
	 wsIYCAV5IKcUNDWa/odb/PSF9gpUdxYvhoOlnXLciUU5DJVKutZ66UlxDED36I6EHa6py
	 ei2KhxsuAeHj/6LimyXH5lmAodeGctvXYjL+vz4whPYOqiwUhk91/zdQQ3rt5nrdIAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oYpPZkbvFVRq54hoF/djzRx4r809Ew4WV/JELCIsqgI=;
	b=gFTIpY5gC/HNvQutIkjaa3qsdVhWFkIJJaXEwOLt9mOt6Mo65ojUSYHD8WzY4WZ3GtO+
	 bJndwrzfeOp9rcGuN4vkreBjmGNO6VsqNvZScot0uz9Y4DPG32YLILlovkd0EPFPp/p5z
	 F1GoZOUev+2g9AsqwbTkza+53J7mTlx/0+xRtexkngly+Q2POUWfxJ+IccfN/IvL28s37
	 qOi3CGsqbQSUN+jVEMVDs8Dazw05gvrijgZZm52SXl+vSsk+OzWs8qw1pWfOvXtHExypM
	 xnDl8s4oRs6tBk+O7URY2Xj5ijUCSUgJRyVkMDkRxcgHdYcuq1h3yV36dUlmpaYu/4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TZdTiUaP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ACA606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 18:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6ACA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TZdTiUaP
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso1635235a12.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792781347; cv=none;
        d=google.com; s=arc-20260327;
        b=PppjLNywyH6X+9zIMNF+o/8eLq4Zm79a8QFu9LbC0fYi5ImyVMQTSqdQwXn83qLouA
         23J2pbPjPmUgntpp5INuW++IrT4F/2MEtFnhllYvQDWhAY3HewcFgXhsjPILPqpKDPa6
         cprSAAreqvVne+hHJiiTb5eRJwzyOC+lAfeAMzUO6Ws+M2r7Gwwrdd1B7OqvVcGoH2AE
         Yf898IhTFiJGgCikCA6gmfCZDPCQr5T+mRDryk8NLSgsSWImhn7T2GgRZCqpNv9z0AUj
         pWr3nN0tzkUFjWT+EYI6Fa/rKxMTms3GR4IODW8DWQnmzo17z+mOznDu6aTRXfOelxfa
         I6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oYpPZkbvFVRq54hoF/djzRx4r809Ew4WV/JELCIsqgI=;
        fh=flYhiqJ9Oq+ABFTRg6Y02uZEQ7tYmC8l8GtFiID50rg=;
        b=AxG6M/1hJyXlwaen9NgA20AeOPzcT5+0JEm79POzM7FUw7RWBQHEg74sgEsqMarNUe
         ZgpSiSu6t2Zj02bKldEaVIPkcfcqF95uvzFAcyR25b+p4iWJo0MTWf9pykY33U9u677C
         8UHje1HTJhejyCaNZONzKK+OghB0L72lmmuajoUORBJcvfEiCo6y9wg12MQFXLNB0hsh
         6jGO6a3ejy/DLhcctL2+V6H8k5N6SRxR1SJsPw+lXmuyu0JTn6QeApVdsCg8PNh0Ge45
         nwp6Ppm2DNQEBif1ppRiL6hCUXnQYb/BjqpJTVnj1WMi4BapxEhQArSD8CF9XrsMbRg5
         O4bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792781347; x=1793386147; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oYpPZkbvFVRq54hoF/djzRx4r809Ew4WV/JELCIsqgI=;
        b=TZdTiUaPXaXg4eYsaYWbXNSoN+ae1n/mezfrrQsHwO0tCqSpKyVJKzdX0Af0c3uFx3
         zF+iVuvFJjwqNSUfPm+rnn/qkRO8O0xYgRG1oa0RX5fhqNbGIoA4wPS7T5b6m9aE6F2S
         7EL3ybf848macykr5yqFvgaLIqH5+6uHEHJR4y6299eDdmFBTrPVuZJZW6Zfm6qfAWai
         fvz6hBV/ZgS4+QR/SYlLDck6E8U/w6kW4sWhBspNXt7/4Id+BmNgNSJ9fXuRXQueVH2/
         KG520H29ZNPnb2sCHWYT003EYr3Z7e2r6+jiK8LvunfIMt/Y1HpVcbTpSBEdt8NpmJOo
         H0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792781347; x=1793386147;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oYpPZkbvFVRq54hoF/djzRx4r809Ew4WV/JELCIsqgI=;
        b=o+jHbO6I+00lrHIyBSOeE855kzQFnBn0MaGKLFQ/fiGiZxnXi5ufEHJHxGuTztC9qC
         JWoAfqphYu99E3tVOgnTYF5xZLWt3qc2z1Mk1Mqi5cKcIM23Pi7hX+AstOrHxRZMPJtq
         34WDZ+3C6yBNEbvcE/v/BqNEVqf//XD/YkzrWVlonkfeW4vjL30Rv6hPYYI4QAXr2jEq
         yKal2wpYrRSrnlUrQKBP71GI3sYT1lmPNfrdIDmfY60Rm8nIQznElyqHzncoDoCLpRkJ
         k+wMRtkDkMFG/RQi50CIaOubH6OAeOYBYwG1JWj4UB2DXyoSvZ2fZw/KbyNU1B8yN1za
         SzEA==
X-Forwarded-Encrypted: i=1; AKwUvBy2U27KjDabkEfXb6F6VegYdHG8PZmBSdDmpTOpwutV5KEalkN6hpS/iy5wzdl9glxj544=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGNYXCbnVu1tcH8JaVi3G1soLOqWxTgufe2dQPb8OPniQl8YyB
	o/E7fvAhoLTPysez/JQ9kErLrONuStnCyhucFnFz0F7vaSMv/QKxkoGNiux6hWVtATPbePu0dTt
	svylouBrl+FRYZHLO9CsIiF13pmxHX74=
X-Gm-Gg: AYBFou1COMbDa7bhd9t5x/RKqj42QansFdyuF671sa8lW5FLW08K6hNMG0YBdI///o9
	OJau9M5JazIRWqS4ptk0qpjiXv6oB2VfEd6k1uE7/U/ZYlTOAZIf7SEhr5chZHKgnNo1IEu8eCz
	67O9oTg15QrxFcanEi7pR8ylg+dFMml0o3ayXPH/hdYLffct+Vi/MsZMXpfm1EMzNsGpfNg0cO8
	yAg1EMeUM1JCos4CyNre89+v67kqG7yW9VpLpMJ3GisoPlc3Djt2JQJnXdcborDb/ZJhHLMgfHA
	Tzjl58vIqdbD6vpDmHNKLbCQyxqWUmEesftZUPRPRMPd78C0yBIwToY57urtyaD83cu6YlKzRCd
	X1pDZWxOiJdwJ5dZI3mVfikje1QMkMWw15JZ6
X-Received: by 2002:a05:6402:898:b0:6b1:e072:763b with SMTP id
 4fb4d7f45d1cf-6b442fb847dmr60511a12.5.1792781347191; Fri, 23 Oct 2026
 11:49:07 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
 <pull.2458.v2.git.git.1792585662669.gitgitgadget@gmail.com> <xmqqld7o71ot.fsf@gitster.g>
In-Reply-To: <xmqqld7o71ot.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 23 Oct 2026 20:48:30 +0200
X-Gm-Features: AclHuK_n62uLy45PrwPixbiKa_d6eeFaO0jkT2NR5aupz3u4kAgqOBXQvEPLgv8
Message-ID: <CAHwyqnVMgAhyHrevXOJ0sBKkaPPzSmCcCPSSeqm6dm-MRX65cQ@mail.gmail.com>
Subject: Re: [PATCH v2] status: compare against both upstream and push branch
 by default
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I do not think I follow.  Those who are just starting to push to a
> destination other than @{upstream} would have changed their
> configuration to do so, wouldn't they?  Aren't they equally well
> placed, if not more, to find the same setting?

Most users (from my experience) have their *push* branch as upstream,
stemming from the `git push -u` behavior that is recommended by
GitHub. Meaning they are already missing the info about what upstream
is doing and how it=E2=80=99s changing.

This is limiting their understanding of triangular workflows.

When using `--set-upstream-to`, now they get upstream status, a big
improvement, but this scares many users because the connection to push
branch is now seemingly lost.

This is the point behind this: To ease users into triangular thinking.
We should not assume our users are git experts, many of my them never
read the git docs.


Harald
