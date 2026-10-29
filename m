Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793298347;
	b=TL7z+RXoFFvkxogij/SRijqXcPDGqNb0oQaB+nTJUWaRvBPb+2ujp55UTKGeis07/QZf
	 ylU+2tq7sRXv3kN9WqhvGaNxzM1mvazPXf6x25gHkar7SGaPyRKUbJgtaXwUjtjZflKDf
	 P0GOz0uKybcS22FS2H4WEX2+mN+I+0Ms1oNLbpC+Wfmenwj27aQ6yMX/TgL7KRdu+ygKO
	 3HWZLoDOJ9DKTD9zfW0rMgtBdST0i5OhXuM0vHbHA+dqjKam6lP/7HoJulPlHtLulhwWF
	 14/AXp5HERYMIRXzT6+jBWVwbJY4EeCJzVdaLCfrAQ57n1AQQTmqTR9ysIj2lWQyGig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298347;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qxVhq8zx/cDCOqaiIjSVBOCgqyf6psUgVWTQmH3Fr70=;
	b=cJMI0BjGBMls05jJLHkEb+gkQG59r/Zwv8RsqllqLEtdU+ZM9XIA1XmAS7fy1BcF84cz
	 xcG1uMn32ynWAgSYLco18RPz4gJqdrT1L0Rjklb8XPXcOUfpe33wGSGg/vR7vRROEn4hy
	 oh70jSef+ApNDkDH0NFmkKN85ikPhgMx+MrLapTtPfMbudUnt2NmlF2SFR8xd+F8jdDUz
	 G2qAsq4IAegtJtEmPLfNcX2xev3FC8Ypm/hEaYzQHA6WUojDJWRtpRZJ+JbQXdo8fno7a
	 tm9WKO7UYDUM2b+ddh2tPvFAAdMBwUo94QP/K1suXjfTcGl1iSE3GLnEjribzdovSnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=b+frrAoB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qUBMfBWp;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC3606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 18:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96AC3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=b+frrAoB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qUBMfBWp
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA5ED7A0159
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:25:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 29 Oct 2026 14:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793298345;
	 x=1793384745; bh=qxVhq8zx/cDCOqaiIjSVBOCgqyf6psUgVWTQmH3Fr70=; b=
	b+frrAoB16mb6nmzNDZGKOuRjg9EsEW4Kx18jGmBOh+cKGekmvTZoLYsCP1pYjrv
	d4giJGawUiZrClX8Zd83mhXq/EDA863ibquaGy/l/pJXWhsiu1xfGMQt+T1fiTSg
	p7kcm1TeQ5nl7/F2Hd3xKTZ5+lBR6PfeGJjUEFy0mhBBRq7+LBeL70cURQ3HPRNj
	jgvXTq1r42AJ1srGKyHf+vhfTsNc7QLsFjd63tSjnu/ItSA91Qx3n5NMqFTroorR
	wQvppvGHiCmjCirxDBj4el17uIwnANz9WW0iINc3mcsux5itzBWZM1WRSr8RjxmR
	CbLtC/dJjGtnFXVRD4UyYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793298345; x=
	1793384745; bh=qxVhq8zx/cDCOqaiIjSVBOCgqyf6psUgVWTQmH3Fr70=; b=q
	UBMfBWpA+3Iiq708wotXU9zLPXWNi9y1fBSzeGWbRlTXl99hYysfIRUMaCcNmeFB
	1lqKOE2Z67MZskAwhqBvIi/VX4uW1Cr6h/trLbZ+Y2MoHymc+wQ1rfdW8EuE0rkD
	Buge0PzIerpYFSNgs0MzzM7h80YvoyiZBDhEic4GTQgvr1VwoaSg45PK/NziaP3m
	MoHEVYDEWR1PBXHHrRdQrEJ7EL7oExUPKTzL3bSWH8mI32jM+IcK3d7LMn7cH7Gn
	ql2AuBXFECBlK8IeuxBmKH1o4hlwub1MBPVJ5KP6kvHXdhFDzXRyOivQ5rKjEvg+
	MsshGSfGkjpcCoZzANpBg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793298345; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Dn7rp71nIwQQ/yPvg+Vhe7WN2Vn0wWnKOoDXvNURimR4TAh
	E8ajtKlEZHax3n0wSprPOP9r1xW4sYmmAPjjfvBAAIAvs/0o4ccmCFBlzeLVuj9L
	7X4E3pdXUFRmLsTaqw1Y8i3lmmT/h3M0fK7UuCLl4JtF8WlS6CgoP1TKOOdyAdlU
	k6LPcFpV2c+fDKV6MY7Wz38+IdLljHPQIQN9M199GFAHlX1NChyfWky1ZbVPjrkL
	RuoyhWem3Cg0woPxxTO8xd4iQhNK/yyfQZ9Y2vdx+eOnD8jfAkYZu7MhEqDd6CM7
	Rk/HWiNuD/KYcFMiixl8MxsdnZb4AI1bD4qU01w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:k/Y4Me79Y9iTmJ2JWecImxwqAGrhB14Ci0KYKRRzPcM=:E/D2+o/3jYocuuUEilii7XI9j3dCIrSDTEh8GzcICAM=;
X-ME-Sender: <xms:qY_jaheCgM1pR0kebfzC9exFULHB9XZcw7S0bFHOk_tuVBwIdlSN6g>
    <xme:qY_jamH0-O4g1cyXtaUloWeTtJ3C1zmc9wcgCCJ88Vk7_7EiySC4_iZV5FUqjGeSX
    17DT6aHPJE8Pf68fgK_jbyEU0RqkyMugSavTvMrQr-wUhiPR8s_9Qs>
X-ME-Received: <xmr:qY_jai3GDXaR6mQ6W3-Q7bqT_QOgPaZ3I4acAAcc5kJpti5_blo7t1DfgFuKAWUrJeWr9n_durc_5qtI_8uszRz1hDqWWvE8VoKm>
X-ME-Proxy-Cause: dmFkZTE4J/FCHg4sPeHpdewQ86d1JkvtWOUepR1XDywcZmERzHdvCs1MW9/gmG4YqFsuvN
    FEm6TqEIcTQqjS50Mc/KGuoRSinU2y3AUQcwcwqg+RE2XL3giJH2OyxmUNkY0Sl9aUgJ6q
    PsyZKoTr+QnbeRhQzW1jwC7D3EKK5N+NjLgX3YU7Bnecc7lC652srrVzGLEYc2ij35Kgnp
    H3xz0eF4CVfoRWn5iUCUesU4LkMA5xtC0xCWYoiUmsRtED6KZw4tKIdnNI2FWXW6qPK8aZ
    TJ9DCaVJ/1qeP986Sfw/qzBhnOXB9TUjTpysBotTpsGctpTGRfNbj7t0DkFp8gtPa/kORa
    Roa+bnl6HOv2zDg5YsOTOk0r2KjT7OL/nR4hSWiof919e7FQefebz+VQIsxezLVbkpxbFF
    YcJA+A7WdqiOwJz1CA1b6SDMMZpLaeZt/j+Wzg1L9Z2kwNHZvJFxqJ1uKeVt+T03717ZpF
    zOQySF1AeeF9e+b5SshDSP2zD95L4jUb6LlbFAFl9N4KvdB7+fzNswRsuSd0RrZ7dexF0D
    ARUdjXBy8Xp6HvwPM+NYOrp2EqSiWHqE0/Pa5iWUjRqvwf2hzHENVh/vzW+cENCu5aAmxu
    nbpVDE8DvOUQAoghLn63O03DLZNZgGgZGeb+t4UA7qpgQk1rWBr34vP3i1RA
X-ME-Proxy: <xmx:qY_jamn5BuGQa5Sj90_ieoy4fHdSleaNt9Ul4NCJkE7o8nGHYAm5FQ>
    <xmx:qY_jaq9E7kO9FN1lvP4jgro86mtTXnxiCKu28fYSzyIC3QtxHwIAiA>
    <xmx:qY_jajrSeBX-zfYoF7z1XJPVRf_aAuZByFxU20txp7TNsAFwio3-xQ>
    <xmx:qY_jarnmAiGNGDUwL-2B_Z7sR5S6Fk1_wk4Gs9AAYumJYqLLxVKRvQ>
    <xmx:qY_jat3YCoBlXf1XF7iIXYvcJhlpRgYD8TmwcapWDkNDQcx1r5mJ2pX->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 14:25:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Farid Zakaria" <farid.m.zakaria@gmail.com>,  git@vger.kernel.org,
  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH] notes: do not drop notes written by a concurrent process
In-Reply-To: <3c4f3793-07d4-47c7-b503-13a6ae567147@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 29 Oct 2026 12:05:12 +0100")
References: <20261028-fz-notes-concurrent-write-v1-1-3d513e1fdbb7@gmail.com>
	<3c4f3793-07d4-47c7-b503-13a6ae567147@app.fastmail.com>
Date: Thu, 29 Oct 2026 11:25:43 -0700
Message-ID: <xmqqbj8c2wk8.fsf@gitster.g>
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

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Instead, maybe this would happen in an ideal world:
>
> 1. `master` and `feature1` race to commit a note
> 2. `master` wins
> 3. `feature1` notices that there is a new note commit (from `master`)
> 4. It checks whether that commit changed the commit that *it*
>    (`feature1`) wanted to update
>    • If so: fail
>    • If not: continue
> 5. `feature1` retries (go to (1))
>
> Maybe this is too much logic for a “porcelain” command (interactive
> use), but there is no plumbing Notes command.

Or possibly

 1. two races. Both remembers what commit was at the tip of the
    notes tree (call it commit #1).

 2. each creates a new note commit on top of #1.  Call them commit
    #2master and #2feature1.

 3. 'master' one wins the race.  As #2master is a fast-forward from
    #1, the notes tree gets #2master at its tip.

 4. 'feature1' loses the race.  It merges #2feature1 into, or
    rebases #2feature1 on top of, #2master and updates the notes
    tree.

;-)


