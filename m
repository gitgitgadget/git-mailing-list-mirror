Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795293305;
	b=xWNwTQPFyFi+UMYoD/5bqNw07l6jIS9MIABee18iHkIighEn+TTzhhWn/aF/tNjjQmbo
	 5R4o8Pa2KnPo/f0tR3/MhZzXYF4PrMLWP6BBe4HeEjGkg7ThsRrTc8aEgFIm+SR/piR+l
	 inPRe7ArCoF0wbhu2bT8gg9KlU3Y/jsTzsqCnKLzm59jkAOIVPWzlQvEIO0H4QD3Ww71a
	 1Wnikoh+9TehCaTnZjAJsv43fBN+6LVPTNEeGPp8DjUUCeTBccBHhKeOqiTfu12AdPKGl
	 zNFLGoETijI702Lp6dy4+CZQH9D6m0CxMFscb6QtlHINT3s6yIGIH4uzqzPeFaPaPsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Yq/mu2HUJSMAQl+SVao+F+2AVjA0qzPN8FK7zxhw7N4=;
	b=IOzaOUura13YgnjYZmhPG9546+7a5gJ4kj2m1dYk9e378trSfGeWzNWyiZPmiYNhtmfA
	 +9rBoQnhejBtHAdtb3grJYAFkMk+mJUW+IqczYDcqbT2zGFUR+Ssbb7/VrOoriyhe4MRe
	 6zHit/cRak9RIucfIx6kPK3GTaYK8pOJ1Pv0ENRi4nvJ5cITYEu1rIz9LjZHCu2zonPoh
	 AwFOU/coQdPW/QyqgfVxCLYUz0b1xJtFeB56bIWEYOk11zs/SFSMsQiShpNCGGnx0d0ot
	 810gOB8ZCLnHO1P2c02WStuu9zHEG1ztuGqa4uewape/PxRCcp/CtmZQSPPZpx5X61g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F1yyFtf5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B14606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 20:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8B14606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F1yyFtf5
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b8b20b2538so2363920a12.3
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 12:35:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795293303; cv=none;
        d=google.com; s=arc-20260327;
        b=UfTfpCoWu+goIqsyFZ+vJlnorDe5SZG6HMhGBtTXPNvfxEGy0vjqGTLfJs3Ts9uc/3
         yDwGR85DATVPuUAfMciA5dj4lrdqlfu4ztPSgRDkP3nbgGNGYLNg79gnkxn+vC0+80xT
         24INynbBQ7qQogawwBltAQFQVjadX6Wo9suu3jnAMKm4xS0HNHA/QJ92AIENFtHZXFC4
         /8d5KQ8qxm9eRTKyj6A6yh8LiHGI1t0iZaaDCEan8ccPnbUXZDDZGPn/5nRK00S1aHvD
         lm3+A06hWorBo9U0BrgAECPl4er3vDUyDZJj6BtaHIi2BiABC+/NFTHG1xfwDqVt76yX
         pHzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Yq/mu2HUJSMAQl+SVao+F+2AVjA0qzPN8FK7zxhw7N4=;
        fh=lbe2gf2Ce9lSPZixEYkH4bA9eC1g4nosWcndoVjwwi4=;
        b=Vy24I7jE0N3SxbuGKJMQ1HBAX33LDYerfFq6BQT8YS4Gf6h5XO+/l1H0VGf/XURMk2
         oyoJ/AKtcw1EPeH0DvOeAgaZlYJPUiIEl22phL3mDfzK7f1IiSMH2nRk+nU/sxlhfUXY
         TSNeZIMvnDpRL1T9VksUdlQo/A0Gj/rhUcYPzXDNFR+bAUcXS6vfqa4ePKJ+6YS/IN6E
         /qdDKqQAWAlGc9fhq2n3VW2bWXrAt7/yyow+3gNvNwojcXxN5qX9+CKoHBAq/828Dt6S
         1jmhevxwYMrBm3O56wfyXz15qJlk+ef7VpzVUUNWaW5rZ8rMnqfX0sDDCEMV1GRIdOS3
         6VEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795293303; x=1795898103; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yq/mu2HUJSMAQl+SVao+F+2AVjA0qzPN8FK7zxhw7N4=;
        b=F1yyFtf55rlKYudDusoHzFk38Voz56MW1BswabH/Nz6Sw23V21tpKuPTRelVH0i3nC
         IHI3wBP/jI7ROof3Uh4RmZVEb+shP/htSPbooes1OfLe8ObWrbQEboYpEhlO37PSht4y
         IjclqOpZPesvFHTg4/hX83JiKSYQi/iXM9Tpba/aaeP5cjho9AemcEvUA+gAflWTNYpB
         kVHGYSo906S3/b8lNrjoM7Mu5EEqrOkUfPALUGfrkTqBtKLcc3Dh6ve4Vbo8qf1ml2j7
         O8vcZpniCLnBIGdI2HfIRM/mVx1pwrMk5dpltx55dRCFOq9eTK/fxxTsPy/S1SNotloh
         Kh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795293303; x=1795898103;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Yq/mu2HUJSMAQl+SVao+F+2AVjA0qzPN8FK7zxhw7N4=;
        b=2UlvbvwEgzKtWUX68VqXrAxsLsZd0byN5nDBGCbePDPCGvzllosyniKRaIkKdpNeq/
         8nbgU5Tna31Rz6G89l5aKzlKMrwj5EHOejoPGq6jndqCjtA7Ei2EQtFQK/Ji7h26vzPm
         4uG4rxLJTeu84i+b4ZXANT41MTZ+xo4KGcFvtdJm4pYzXIsE+sYAlcYF9KTfChKEozG0
         kLlYZK9JAII4YRcv6SLdYuuq035bLMLqdBBU3ljJuVsazEbUTIXx/Hb7vlbuR4KYlPHw
         xGrdyZiCtIqqheOdfRCnyidkjJGVZ0ZOQ/1VX3uHzJWZ7kKXsnwQWlSHL5bepdL8VkEH
         rSmg==
X-Forwarded-Encrypted: i=1; AL+hErHXIDXPHqv+zgbTEbSMpStRIx9mY22RlMxjwGBX22NeKn6n19I78AEz+gsvqa2gf8c6mtk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Y1ZhFinGFruSzh85CqSfq6v3two+AHzxOC8ccO3DZ+3qKgQ4t
	f2wxLX4dc6KOQRtjU8DT4CkVIZapLka5jsyYpGUBvFBXNNJhef0myH0hEXDkJG6lz/QrX0igk3X
	pAxJzLIPZObwgg4vcKf+wfxxhG7Hs8v0=
X-Gm-Gg: AZFdTZdRYdeUNSqg1zDq5gofkIl0Z6Gfrac+49dz3t5WmjSK0Kxiu3+J1TvrcQnBalX
	zUyO7iqR54iKZx9HfZavZH9UmALiVh+EJ1gCOmrLJ+dGOYq6IggUeTtZ0KJTRm/f++F7ukFLkhv
	A+dzaX/IJV7093AUYv4d4AZdFZqIpGc4tRHyVGIU8yfF5Tu6u1lyNMERAE1smp9gjXXFRqrllLj
	Bs2pYzsqK69Kl9fl8UFGNy4P89Dg8fph+/ddMxAg+9Jbon5zNVPApnSzQOIJrxpSMWeJj781cvT
	mqQRNHCQSfy8msc4p7ym5Ttm6lGjjZHvnH6dPqQUZD3kV/zaN4DuZoltL+kEZcSRbpySLYas9qv
	3RP24Xz5vYFlZ6qpNTnppNSFRvQ99E/NOccj/
X-Received: by 2002:aa7:d587:0:b0:6b7:a647:c28d with SMTP id
 4fb4d7f45d1cf-6ba37eb44b0mr3466474a12.32.1795293302920; Sat, 21 Nov 2026
 12:35:02 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com> <37ef7636e069ce528728c43cd79f678293e0d035.1795184664.git.gitgitgadget@gmail.com>
 <xmqqy0anpbzb.fsf@gitster.g> <xmqqmrr3pbdo.fsf@gitster.g>
In-Reply-To: <xmqqmrr3pbdo.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 21 Nov 2026 21:34:26 +0100
X-Gm-Features: Aa3M54pL-nvyJoEcZwfgO55NEBohGC_U5Hifb_Q2oygoJvauqQlxmytVO_xKGM8
Message-ID: <CAHwyqnVqv7XTeiWc2f1ApM1-TmVHJZtcqyPN7vQfe0RPXxGULQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] branch: move the deleteMerged opt-out check into a helper
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Jasper Mayone <me@jaspermayone.com>, 
	Tuomas Ahola <taahol@utu.fi>
Content-Type: text/plain; charset="UTF-8"

> > I am afraid that this is a somewhat selfish choice of a name that we
> > would regret later, as it assumes that "delete once it is merged
> > elsewhere" will continue to be the only destructive operation that
> > people may want to exempt some branches from.  The configuration key
> > is named very specifically for that destructive operation (i.e.,
> > setting branch.<name>.deleteMerged to false is a way to say "no,
> > even if it is merged, do not delete it"), so there is an impedance
> > mismatch.

Good point.

> >  (1) naming this function to make it clear that this is about
> >      opting out of the deleteMerged operation, or

Went with (1), it is now opted_out_of_delete_merged().



Harald
