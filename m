Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127732;
	b=rYT3Aw8WfKlZYWxDW975QRa1ftS/fVZJysN3XceVqK6pNmSMFckmzot5P59t6nx+GUwr
	 0SHX4TARFUDVDuON4RV9tE6K9ehwnehlIVKPxywt75zRG8RPF6FpfuU/gpLeou4GC1ys/
	 LKrqh1fJiwDCtSrx2xfkUHdO2MfEBZYsmLT7jDRAF109Ey0nzf5csQ7U2gIY8oL8VZYmk
	 t+Tg2toQ9Amy7wnXcHDVXtrGOhIPBn+tDhUdi+RYIlbaNm0TxAToxLn4exJFMdz4XuuY+
	 B7nTrVZkcqTo9lQ36l9wEPd9svnKx1fHLeajKlrvPTA4Veqg9TdK57I2HeLHmEne2ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127732;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=9539E3e0D0SuviuG1tc1/+sa9m6wQHMLRS/3m61v2pk=;
	b=Od8VF2ZBqwnI3YYsxsM9CLmylZCchBvvy0CO/CgvHCzoiPY9RO1hfzXkt5gKq9u287Cg
	 Mcy2Dk/GwwuZ4suFh3JaBcYkzuV5rXV9UuzFkhjOh/T8DBP5leHQVugs7hfa6iXeBCqGD
	 tiTQPHR3XkMKZrJxxencj3rE4PR+pexMQ/orInNeDtKHTmJtj1VIM41G2XEfjYmiOFO/9
	 gThRSETfmmPqdUsj+TfnklIK728aYymAtosyBmXT8sg4Ace9w5NTDVJtKYihcfCLTk1AU
	 6FChKOofdJ6V0maw+E1yXMpXZHSKVc2UBomKAuIlUxOLDnWDKqTWaMa256M5XNv7suQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DT0Kop7+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IrpLw+T5;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5978606A31E
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 19:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5978606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DT0Kop7+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IrpLw+T5
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9E5C97A0146
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 15:02:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 15:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793127730; x=1793214130; bh=9539E3e0D0
	SuviuG1tc1/+sa9m6wQHMLRS/3m61v2pk=; b=DT0Kop7+PeT8EF5+XjeXlTII4B
	V7AUbYO6JEz1BcXCbFdI1zNTUNHs3kJnSHVxVoFMSXG4Xf2TGA6WJo5/8X/IrHrz
	VHMtqF1esRlnKyvwMFeGJ+0zoddHJctaGsduBGDgui21PE1+aexYSaFL91PMbuEg
	p4fT/OeqyI0usvl2IeZX1jks8TJ4XfQvVPnxQAgUXKeVmUKWYOlAp+eM9pTw9+GY
	2/13N3STIxLB86gy+2hXtpFS5+Va+52SOxSbYNXbKBUsTVgnFin4/Vhxr0SuvugH
	idrbt9sPtvHeyQZl1Hrfv3D4PGclBWPqKCYvLczah+m9OxJZw06WtQW0UQAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793127730; x=1793214130; bh=9539E3e0D0SuviuG1tc1/+sa9m6wQHMLRS/
	3m61v2pk=; b=IrpLw+T5Cf29em9V1U+JLb7p3J5IRQQ3P7QKHzNJEFzEvcRvnI1
	vBQM592KNTl/vzt1jATwkHqzFbyDATtUzbPfT0q2J48+o5J7p79jJA88tZWnXlti
	1E/GpiYdjEcPtTEXc55Zh8FcOGbrTNQJUhI/VdnWDvMKR1Y3sA/yqUSXXb85gMb0
	9N4kQObYT1pX3+nL1bMalwzmhr5KfvVUYBToaHwpknBQdfyIKEn9YuDrrtLsA85r
	Qa4P0a32NQz1t0ZJVE4whaDznqKS6OyLtyJvREZkJW/YUwR048b68PU5wu5vw2oQ
	qUryzIcuCVhgquIA7VGcgRRqw71h1PuI5cw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793127730; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:mARmXEYlzYPSKvyDNQLIfr+kqpzIY5B+I6o5QGv1bzQFDcy
	GNq2cdemwXu+qN95W45FMkIEAQBOcvKai9srMxFcAefCa7aKp+CTm+POVJmT6UN8
	K2YlPVeGNGLx8uhsC/0htalqAsKlgMQ/EPfZEiDywTCvkTO9McwpdfQKdh3gpB+X
	UwNNNdZ6mFOim4ITpUcfIWaIvAE6Fsps7kGgC2PwEVn9BVn6HVU0CcB9fXVhyT++
	k/tp8RstfCk6EX88vfuIVJ/XFwUOqRW1NZ4+XasP78dKb+Oy9L3pJs+9pNZZkapz
	xD6A+QsplJJKsvQkQHM0gFDe1IQJNkkDiiU70Jw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:nl0OqXfhUA+/jVQJhg+7FXW21h8vGA93LgOi+pxDr2M=:LQy4ZusIQWoI+dT+YE+lSv7n1CYY4z5bBJuHN1IxQww=;
X-ME-Sender: <xms:MvXgauDGm7gZpC39UgLn6WiDMvSoisdbDLSbf-ReOE2qsQ40CqFYWw>
    <xme:MvXgav_kUtdJAFxdaqaUCBYQ0NMO_MImPD2AH7hdmDg-_0hH8qDjDryht8wX2iKsf
    jYMSHltqjtHUao_wBGHkF-r8sa5Hly_IkZpQ1cLbgrBvd0pesyPoZ4>
X-ME-Received: <xmr:MvXgau-impm5YFO7E05kpF9DBbTdb5KuJj0oq7TwQ8dxwjRWIJ4zjC5JOZqry42Y9Sp60DGhBNbW_eShudWNfm08Hvroor_v7a-l>
X-ME-Proxy-Cause: dmFkZTEXjooJzN7/8Lb0ael7QiGet0u8hYpTba94++ZarbKBtBFtFiAHitUVZJxOIDEYt7
    1H45C13cJ0ZUgzv0iOLT/jeEOH8ZovSoebNsT2eXUtuDdtlpvmoPLfONe8hIFPu4fKMmy8
    GpKnDOZyua7iuenu0KFBMPpNWRbfGfKl+vsvmdIK7wxGagFgHTKHFMo1bDKarNhgKOKJ3b
    gj740/jfQzYH3VOZG3fNx5vn3YqVpKYKHnOLyAN5bx6dI6furVz7htZYiAl3QP1Rxq2Xo3
    3mc2mjYuGD4acykiJ7+8n7ArV4BWJ8wWHTiJ/YKzI5ab81Isvq+lpV0D3JHQr43cR4a7Xl
    wolCb9d6UJ5v2mAL2OxH8ouVB5MD6ILRcsBjKZ9kFJgGG1LqP1htfqnCTH3V6tPcZ81Yrb
    hVz+TtcDKpFiLw0+Pp54eqdraEyjDJyuDXbJJYZt7VHWi7GoZvmCSjrP1BmNfwL2+NNSoV
    dhhk2n0QE83G11Bq8DIHgWlT6kZYcr06fa09A2L4+BTFThqSgsQ9lEqIMG6PTGdLVdn0ZE
    oMVKUY2rIwZKfutG0Fyvi7HDzIzQQjEtmfNkwLURz/F4H0W/iXQ1ZIwXfIgc6Dq/y6ESup
    4XFvLUnx4T5cgAoQoq5Ui8tjrYYpVQ/a2NK45cUeSLbzBpKlKj6qdwKCP1gA
X-ME-Proxy: <xmx:MvXgamedWLRrj4Zllpm1i-s8baIJyzxWCH-9AuAUwz1ab_i43Fb9lQ>
    <xmx:MvXganEKez5GEPsINnB-2bkSUB9V9ce0Drp13lzZN8hCAxYGx-qrJw>
    <xmx:MvXgakd5gs7BM6COCCFEJ7tQzEeO3fmfNq_cu2KN3x4svFC-5sRy8A>
    <xmx:MvXgahF3yvMMEFDEXgm4A1x83kpOJjGOleL5bXZPXKr69xW3SFzdlg>
    <xmx:MvXgav8j0lXt8iM7Zcnyqr3BBR3ZXRRe9CEDiQS_Z4ujsSlhcH_tslQV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 15:02:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] cat-file: extract the transport ownership from
 get_remote_info()
In-Reply-To: <20261027-remote-object-info-batch-v1-1-ea7a1f0b1df1@gmail.com>
	(Pablo Sabater's message of "Tue, 27 Oct 2026 03:16:51 +0000")
References: <20261027-remote-object-info-batch-v1-0-ea7a1f0b1df1@gmail.com>
	<20261027-remote-object-info-batch-v1-1-ea7a1f0b1df1@gmail.com>
Date: Tue, 27 Oct 2026 12:02:08 -0700
Message-ID: <xmqqpkwvj7bj.fsf@gitster.g>
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

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> get_remote_info() receives the name of the remote and from there it
> builds the transport and at the end closes it.
>
> To be able to reuse the connection for multiple batches in a subsequent
> commit, it is needed to extract that responsibility from
> get_remote_info() and instead have it in its caller,
> parse_cmd_remote_object_info(), which will handle the batches.

Makes sense.

> While at it, rename the transport variable 'gtransport' to 'transport',
> as it looks like a global when it's not.

Good move.  We started (not particularly this program but the
transport layer in general) with a global instance of transport
object called gtransport, but the ones that we create on demand and
release after we are done are of course local and it is misleading
to use such a prefix.

> +	if (!transport->smart_options)
> +		die(_("smart options required"));

Is this an end-user facing error message?  I am not sure a user who
saw this message can figure out what went wrong or how to correct
it.

