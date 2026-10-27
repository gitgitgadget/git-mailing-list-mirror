Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134057;
	b=LZoq58CP8iV8oZ4nJ6HVII7vyde0sKgC12Qhthp+rPeOhJjmMtk3mCTT5kWvFQJt061v
	 F+K9Rfjc4yp5bHMo+0ieytlNhns6+MmRlhM7zSa2rpCM9T3HSJZAXO0fWnuRURKc5o4qz
	 mkwQkQXvCMoc030xE0PQ1wdPV/bIy/mFYx20RI5Fh6uqHipWgwHFk1HbMLD0kKVPeBBXZ
	 9guRNcwFO8FBG9mSCBzjUiONZAuqwaVvXDAce/Zpbfsr2yz8Livzz/4ALgyohnkb3uYJK
	 eWWCFrPzW17hrITJtk9KxdWnT8kN+QQhRW1FG3MR+s3glb7O2WNWlOzXGUhmPzrBqEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:
	 To:Cc:X-Mailer:References:In-Reply-To;
	bh=Iy7ekALS2bjCrW2bPde4EyIPmVaqu1PxA8/jK7DRNkg=;
	b=sratqH4mHbcqa9JLn4IRw1HQY1aN2YOeKb2DtBtj38zHOBnY31eML7ZOAu1coh/kXN6w
	 4csMqaIlKPRec6I9ZWyYck1ISnuKl4x76f7krtVUioek2MgDfrT2888ftHbG9sDCdcKiA
	 ScaWcULV0On4KhWoS/zFIpMQrlLNxfMyp3b84e1WsVJecomZoGfQNAsy4D094GbThLEvW
	 Dm68LAP5XMqTlHcAhtjm1K2psKAZ4iiqF6ObTeZKYrleXdN5JWYS/yxUZHQXSmV7FkZVX
	 2HkLD2/gJUzW6cQvZi+dTZQDlSiACNLd19bCDvhAEBtkJO3HrXxFPHfj3ndr8BUo1yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wFVdIbfn;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484FD606A320
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 20:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 484FD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wFVdIbfn
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so2442425e9.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793134056; x=1793738856; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Iy7ekALS2bjCrW2bPde4EyIPmVaqu1PxA8/jK7DRNkg=;
        b=wFVdIbfnzFT1f73WcEhisXbHzgRz2mCMsn8h0zTUt6cEtMo7CUqGqSv/RY5wwcL3Ck
         Fki1dYSv8y6m4tF6jWRsNfZLlZKcx+Scmq03iKkEVu5Dumgxn/UeglcenKcfx1/qFfaM
         r3c3oBWexPEWOQfUfBHSd2NAgXiB2UJECKS+qcgwU2Y1jpsCBKAv2sgoxEX3wvbiQfZD
         WDJNMNDoUtvkfw4lESj4eoOR5WrnvchvLtzLysxj7Rxs5I9AqmLu7A0FShzegSyY4tKk
         FNRGr+Hrgb70EeX8xfQtVIAfOGKNck3qsE9imla28puYRWVvKA7rwSL2linE6KBNHLlq
         EguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793134056; x=1793738856;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iy7ekALS2bjCrW2bPde4EyIPmVaqu1PxA8/jK7DRNkg=;
        b=VzxLEp00lOhBiyocNd5UMCC+LPty3ZQt3AqUMHTewTJF2RDNR6w7pb/OaGefdRtcMk
         PB7FNxBmMCTmpzRVShtGJWZ4L9p95QYBdQO906ZpEH2J8mOT1Zx8yVrPab3RquxGRZjO
         ypnmBmTAtWWT1BnNhb2SnCu82zXZzmPSN3B1rCBfEeZG4ZRfdfyPkurF9DFyj9JupL4h
         6tOrVVSQnnoz5CRMnh5U3AskzzRopZpNDoFI4Szm3/Y/9tJ6OYuSOxEdZJZeDrj6CHgr
         Y2BKkf8obsiCkSBxVc+ej0J0qJErcbHHQZNMA2o0WNfb5QirRcDyVy3n7ouQAqNsYN5R
         FIMQ==
X-Gm-Message-State: AFq9FYIJa8KoemVFpIm6peA9o93KI8KBlwrJxFoIb9ymU+62czpVYM/+
	F+E7R6i0hR36HVce0gxOdaI6bq6T9R7g0KIx6pJBl5npuuh2oQuY3/Iw
X-Gm-Gg: AYBFou1A2+i4HHmhA/ZQOg5kHxnrKa6zDCYmE+4hIRGjwUxqvpT7mroT99gOl/Y8Cz9
	pwypLRdfpIoVhHoUyA7OwgPAt7ngLfrP5yZ+1UWu6BytCKTASXXF5Srtcknqbs1K1yC5vljQ+sY
	BqQRkLpJKinZYwYZw6MmF1l0V0W/elEgAyQ7OGykDXZQwKUFZ3Ngw0IEXqH4tJnSPOY05tGYa/c
	E8K5allMCG+m2g+E8Tl5mtIYklnSXWjXLrPmSuznyKWbtYl22kK9RVqUBGTw1i7gfBIUJ93dHhs
	ha1nMGih4OwNRCaMICAC0xP8hqCYFjDqKvwS4N+wPiUAZA/yzb4HMsPOpkCGD8dTGwMHjuuKo8G
	Xl3zcB46VnfFmm8NDJWyS+wYHN2cz9m3OT3rHmlw2mxCIzS8OBAS/A9j+NmIYdPh3/BRHLQuMTE
	Na8KlDgDUnhBnG7Mfl+ky2uvCOenR7mVBTX0C7j3DJt6PBkkaWBHufujcEWYtIHgvRxvIAENXSV
	hQNa6TY7Pwhj+zvyDYoPpG5klZw6seN3DdP9TNZhs2ybY7jQelnKvqjKHpGBOl3j/nLSHLxknlr
	CyVQeZ7+rnM3X73+2yyLLKnSWmFX4uUqBTzIq94ikYiFqvEKupaUvOlYoPLIOr+DJn4HzJru5tf
	vRxy8N2rjGFczeYwK9ahH3VmPTWmtqwOKuQo/R9DXv9UOxfke7rCX5sXUPfJDaz1ckdIB1gxdK4
	hHkqs=
X-Received: by 2002:a05:600c:3b24:b0:4a3:5a98:c279 with SMTP id 5b1f17b1804b1-4a966c41c8dmr1854075e9.8.1793134055444;
        Tue, 27 Oct 2026 13:47:35 -0700 (PDT)
Received: from localhost ([2001:818:c665:a700:d08f:88e:8091:3e4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92de010bcsm11528535e9.0.2026.10.27.13.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 13:47:34 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 20:47:32 +0000
Message-Id: <DMFWYZSCTM1C.ZM3OE2DGCMPC@gmail.com>
Subject: Re: [PATCH RFC 0/3] cat-file: make remote-object-info request in
 batches
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261027-remote-object-info-batch-v1-0-ea7a1f0b1df1@gmail.com>
 <xmqqld7jj6u5.fsf@gitster.g>
In-Reply-To: <xmqqld7jj6u5.fsf@gitster.g>

On Tue Oct 27, 2026 at 7:12 PM WET, Junio C Hamano wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> A noticeable difference can be seen from a 10k OID batch to a 50k batch.
>> After that the difference isn't as noticeable (the number of batches to
>> be requested isn't that big).
>>
>> I propose 50k OIDs as the default number of OIDs for the
>> remote-object-info batches. Coincidentally, git backfill's default batch
>> size is 50k as well though it's unrelated.
>
> Interesting.  We cannot share any code with backfill as we only
> retrieve info on objects while backfill does grab the objects
> themselves, but using the same number may make it easy to explain in
> the documentation.
>
>> I have barely done any benchmarking before, so I would appreciate
>> any feedback on the one in patch 2. Is there a better way to do it,
>> or other things I should take into account?
>>
>> Should the server also check for a limit on the number of OIDs it
>> accepts in a single object-info request?
>
> What I am more curious about is how this updated code interacts with
> existing code (i.e., updated "cat-file --batch" clients with deployed
> servers, and vice versa).

The code in this series only changes the client side, the server has
no OID limit. Before this series, what prevented large requests was the
client with its 10k hard limit, so the server is fine with any size
without any change.

The server will see requests of at most 10k OIDs from old clients, and
bigger ones from new clients.

The other change compared to an older client is that now multiple
requests can be received on the same connection (instead of one per
connection), but that should be fine, serve() keeps processing requests
until EOF.

With this new option there's a risk (that was already there if someone
modified their client) of setting a huge amount of OIDs in the same
request, but I'm not sure how bad that is, a 1M OID request vs smaller
ones on the same connection. Could you help me with this?

Anyway, the fix would be to add a cap on the server side. It can't be
lower than 10k, or older clients would get an error they can't do
anything about, and if it's lower than the client's batch size it
should be advertised so newer clients can adapt.

IIRC clients ignore unknown capability keys, so advertising it shouldn't
break older ones. In this case, it would be advertised on the handshake
and the client would die() if the user sets a batch size bigger than
what the server advertises. Ideally the default on the client (the
proposed 50k) would be the min cap on the server, so someone that
doesn't manually set the batch size and uses the default value doesn't
get an error.

If we don't even want to die() we could set the batch size as:
	min(user-size, advertised-size)

Sorry for the brainstorm but I just realised that any client could
modify the size and that a cap on the server side could be important.

Regards,
Pablo
