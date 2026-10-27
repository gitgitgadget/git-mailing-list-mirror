Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100763;
	b=w+TSIVsVF6QjSjUkU7NJSPK6uSbMitj2a4k+mDOqVv+zq0TI1CRJXWxv8yGRa0kULwKu
	 +MIa2j3WjKLjsaBD9laJaK48R9g2n1qrBAwx5fZhyrCasll189ikxGkN+7Ix9qBUPiPpi
	 hm/UnXEnNCZpjo2EVUITbtWcu5TVUHBzagGfZ/c3jt1oKhaAUsiCTFdF+v4AIkd6vKrsJ
	 XVN4mPtm3Gs5b5mKMoGy4YwpWLynvV0/i7u/RW4Ft5qTAEpRM8mf8IjNtNmrJg9RBT83P
	 c8PL81YCqjfVno1NUfi4sn7x3qSmCEupSkP4gHKLTluQTULA/WdKSIR6M8J3E7k/frA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=N/rwJDHzp7hW4k7LVUnQ4tFI+3GvvGKM1N01unqzzIQ=;
	b=EP4pTrbS/t+cE3k9+fI7KCqmd1KXlO0zobX/o+AtOsTCp2oJtQu/Yq7wAOeIFf84V8+R
	 iSYIANTO4sfwksaW58xZ9Ae4Vdw5UCk4y6J+e1MUJH/5yzHtK9UUBYhOXPQaoI3mbdxsK
	 ABY9g0yQ3R6tWYw4690hQXtgneVKunYNi5ytu+T9KQJFU/K42I8KVcANJe6gMbxlRr7DD
	 POrevLAuMuaIsrmQpGlWnkn0O48AwJjNZp9OYsTBo1sGlf0k0cUb7qDWaUqEyZ6wmIZaO
	 bzP688KTii4YvPbdQqVAyHNeg3kCMtACT9GCuzacR7IMZJflVbhRXs/4elrgIyaGazQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kxh8Pr2p;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856D8606A33C
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 11:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 856D8606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kxh8Pr2p
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so15640185e9.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793100762; x=1793705562; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N/rwJDHzp7hW4k7LVUnQ4tFI+3GvvGKM1N01unqzzIQ=;
        b=kxh8Pr2peiQhCe3mwZy0MLC8OgUsbjgAoaONXXwDOYShvbWKKgh0OmEsr3Gn38oVxM
         18jbMJwxJt3OFhCAKUYZJESIe9kqR89JqgYkjEPsXdam/2alWDgTUP+5jhoeo3vII+tl
         J8yCFjqYiX7nZAToYrpJckcvZJevIwJNadyulsiEioX0FrZhnr9Qk3L/ArzORk3sjR8Q
         myttOdLL4PME0JkaCqCP7t4O1VB0WBBIOBWuPCbnn/kih01Qiix42ojKe8bDUD8A9wM4
         we9D0ZMwd05dq8Ygcoh5a0J4HOu6JwKlaBDDPvcgvxnwt0yrJdolYvPaNfj1YMGpP4SB
         2tUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793100762; x=1793705562;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N/rwJDHzp7hW4k7LVUnQ4tFI+3GvvGKM1N01unqzzIQ=;
        b=PGQT0R6sFsOtauAG66Ak+Tfg8AnPFnb0xtlsHGc5Q9v2ybaWM4MjBEwav9vxR4p86/
         aJ1oVobXCXAh4pJOyipMFOdMO96HTe/S9N0dG6M6N32xmjb8pmLuhSxaNf8C/wh0meS2
         fo3VAOVPNKC9n4gPJ43n/bd7URKFiMvdcsVh6DpJy/1uNC0120vf8Ybf0cxM0njl77ad
         y0ZHet6+JPTtAztxZ5NTZ24KL6OTz459AutqTbFJkPNwVtyvPECBrbgROhTNZr2ZFpOF
         Bw5kLKZPUYeu+/PderDm8VWVfCYOTu/11+bmlmF2DrfRYSn2lenLHPf8J7OvwMVNQWct
         rSQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxE/MicHk16pif5/3Fzoh6Z9+jxrk40QIlubEB9BIDX4y9ZkVRB+Fl7234o292E/uzDOqY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTJNcrZUdeV9z2uMBkrKiqulC81m4e8OuM1TmzjMYZgNbHKum7
	kbORmctFrQt9KTSstNKd3ciHZ3uwvQiqMRowvbcpXPQzsrB5IBDM8rRv
X-Gm-Gg: AYBFou3roWeaab6lSo1aHOHDwfSMDkJLQxOd1y6sYWTXE1IPpYK1YxQAaguhh4vuPmz
	Cli3efo0BKQDIIKqQhlNBieZwRos9aGVpsVVVG5hOTvv7aT7HhftBNnOiS8hqinixWY2AAY7swj
	MV7Mq4cL7ZMZMZFgyR+INfZWG8kOJDC7QvCDRDSLuXn8qH9rYqY/YtVSvS8uyb69iEkF8C/kdIx
	7Z9CJRLSovnNFygZGku23IL+mwMc2srjwiSp5VH/M1QUFpRfZ+czH6qkxDX69JSe3kwebNF0VPx
	CqCgq97dmc1alibTostV4ytj8/KSKkJs4nmomx3ehUTRZkOeVLROc2h3Fc46x5bJ4Yj466DPlqm
	6rRbLMiL8Vazi7W0RWCcW0cYMb4TZ2jSuYa2kh+9PELp3rEr7R1Z+uh/jpbWHP4xIN3x7ZNagRW
	fKvECacBM+dk+RHilYIjwF5YN4ibmpo6+EFxsFoMzZjIK3N/r1zPpMWcPv5qLyJZvzS9CQ9LHr+
	IU1uhvRRFPIGTYBa+7U3fk9+ILIretITwUZljn23hIXFcZvfaYPdyiN6mfe7XvgCT+3birU1m9T
	zKlgogn4QgHxwP44ZvDppptrcR66xEUttSXlyXnCs8T9FLy2c8QmvyQWLC5rbB1y1+WQ4DxtLhn
	Uvq6Y4WL20ieJqE4kNFkVpFRQIP//8bh+lgreY0VHzDOdTDi9R6tkVDrbBwA/pOTZbPzQWmGPBe
	dQ/Mks1Rgnb8AujmZ53QWovsJl7Q==
X-Received: by 2002:a05:600c:a00c:b0:4a3:5a98:c279 with SMTP id 5b1f17b1804b1-4a35ac7df10mr168862755e9.8.1793100761510;
        Tue, 27 Oct 2026 04:32:41 -0700 (PDT)
Received: from localhost ([2001:818:c665:a700:9b4:dea8:96dd:9a68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2d6f6fsm253251635e9.12.2026.10.27.04.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 04:32:40 -0700 (PDT)
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
Date: Tue, 27 Oct 2026 11:32:39 +0000
Message-Id: <DMFL6539NDIW.2LN0YXSJH5VT9@gmail.com>
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Srujith Poojary" <poojarysrujith@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Cc: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>,
 <git@vger.kernel.org>, "Phillip Wood" <phillip.wood123@gmail.com>, "Usman
 Akinyemi" <usmanakinyemi202@gmail.com>, "Junio C Hamano"
 <gitster@pobox.com>
Subject: Re: [PATCH v6] diff-delta: use safe integer arithmetic
X-Mailer: aerc 0.21.0
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
 <pull.2276.v6.git.1793076683043.gitgitgadget@gmail.com>
 <DMFJX3GJOXI0.1US2IH6P4LRUR@gmail.com>
 <CABh_KWhac74wQY3sTAFp7f_9CKKAmBWcE9wir4_1i7iZqsq8fw@mail.gmail.com>
In-Reply-To: <CABh_KWhac74wQY3sTAFp7f_9CKKAmBWcE9wir4_1i7iZqsq8fw@mail.gmail.com>

On Tue Oct 27, 2026 at 11:01 AM WET, Srujith Poojary wrote:
> On Tue, Oct 27, 2026 at 4:03=E2=80=AFPM Pablo Sabater <pabloosabaterr@gma=
il.com> wrote:
>>
>> On Tue Oct 27, 2026 at 4:51 AM WET, Srujith A Poojary via GitGitGadget w=
rote:
>> > From: Srujith A Poojary <poojarysrujith@gmail.com>
>> >
>> [snip]
>> >
>> > For the unpacked index allocation:
>> > - sizeof(struct unpacked_index_entry) is 12 bytes on 32-bit systems,
>> >   which may be padded to 16 bytes depending on compiler alignment rule=
s.
>>
>>         l 117-125 'diff-delta.c'
>>
>>         struct index_entry {
>>                 const unsigned char *ptr;
>>                 unsigned int val;
>>         };
>>
>>         struct unpacked_index_entry {
>>                 struct index_entry entry;
>>                 struct unpacked_index_entry *next;
>>         };
>>
>> On 32 bit systems we have 4 bytes ptr + 4 bytes uint + 4 bytes ptr. I
>> don't see how it could be padded to 16.
>>
[snip]
> Hi Pablo,
>
> Thank you for reviewing the code and catching that! You are completely
> right=E2=80=94on 32-bit systems, the fields sum up cleanly to 16 bytes wi=
thout

12 bytes, not 16.

> needing extra alignment padding.
> I have updated the commit message in v7 to reflect your exact
> breakdown. Thanks again for the thorough check!
>
> Best regards,
> Srujith

Regards,
Pablo.

