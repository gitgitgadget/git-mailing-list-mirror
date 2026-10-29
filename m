Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312164;
	b=c3+vwIzLblQo9mD+55aH7sxCRfcTN5a/hS3vwWVpxSEbj0Y2O8e/VCephpQbVszy9nC7
	 0ZRN41vDdWnJrjOOF8/gprqrPpeSCbRl1yzW3JpM54zg5onj7BHs/Xe0l+Zmbo1FPpAvD
	 73yFYG4j1nT0q4wfnWjx9T08jSN+6LXaEJ8d+9HbwohN+qUODJAQYveNm+ZiWax+mZSN6
	 vi20uQmOsV5a3Y6DjCQmezON8ir52fTIg0+o+iH84ZjS+npayYtgs/K66haTh18ryYA8T
	 0N1CRAwDQ0e9BdrfII0xklg/h1ECBU8ioShXE9sCLOhFwiVatOglmLVyiYIQG0NW20g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=OCxrfBs52MnX5YRFLyyV6+uxAOO0wFCdCRxc+vqbmvE=;
	b=XJJP5E2a5rbV0Px+G0k6fJtIWf2yNL2UbS7vcH3azRuVFJLKjCCmRxXgzb4bwz51uk9R
	 INooJoSP8u8ZbP9C0nph50JdZ42XaPJ7JWQ7ebslvwNg+ko70XYrs+4DkWaV120Sw0Tad
	 d/NfrgVeg/w1BOmkwUbhSrbSgBL8oaDIryTcN9XY7azAms2gRhLgqZQfhF8RbST8wtlLM
	 /949dv+c3AKWFx4V1y0hXyXNR/RaPpvH68WzYK+jD6Wx9IBoR+UpRaAcamS9Ia6hWbA3S
	 wZ1GyrGGh0HZvJ7NtJopvYtWUqSlggqbejIYiTo4F5Il+lzMEXIiE8YLN+Gs6tX9PrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yPSyeqV3;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB9606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 22:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02EB9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yPSyeqV3
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so233166eec.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 15:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793312163; x=1793916963; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OCxrfBs52MnX5YRFLyyV6+uxAOO0wFCdCRxc+vqbmvE=;
        b=yPSyeqV3L/CHsl9lxNNsG8T7yZYR6lbhA4c+fWbRkQ8LU9m8lyiDjxGhNGLdqfDBnX
         DyFVT//MnWXgqWXJagIZ+5Z+U8BOlAXn98TwwNbTUtKcbk/cYvSSO9/UTU6vG4DQF+mW
         /Kxb6PsXq0+5p9F2zGkou+Z2uh8HcB92me2xk+I/psjRiW7xwCBKvGGtoduKGjXjnG+u
         4CxNWH9dnha2WZX39n0viJGKLlt7zIZKJnt5V1lK8hBbBgn+cEyni5Yy2ITopQI8RvxW
         aREweMuDWFWYV3CsEpSBSShy1YfbN+5eU2zucgNyTiQDOzC2hjOuZx+nk2WNNV/lT6Z5
         2w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312163; x=1793916963;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OCxrfBs52MnX5YRFLyyV6+uxAOO0wFCdCRxc+vqbmvE=;
        b=JHX5pet950Hmf0FEN9wcEneX0r7FpLgVQdiW4KQGATMos78rpG4t3YyS7WfjUl4rjl
         jLSXMpsUE5XN6sOGTBC9ECkipEbuMTcFadKXVlLdjI8Hx6TVUnK8LT/PdeFYfNhe4iea
         rE3qa/UghibwD9Cv1TKxOAPbZRBUulro6aMMy+fecJxl1nmmlBEtPU6gQ7DUTq7MaHT9
         t2QCp6tVhOlm/yikcg/Z4Qees8nC1ULYs8lY5KdibTTkiOtmQMK5+uI+/f+z7ro6+B7d
         bWNy9maCKwYnG4teZJoiwnWhhHelej0j4oZU5Pvca6wAVXaAnj7hmN2do8iPz26WqJj+
         S/Kg==
X-Forwarded-Encrypted: i=1; AKwUvBxVKVrAWXbbIzeCsEl7qy+05wy8k34TActgIdYTg6xwDz4kpleLmV4gEhKF5tQVJ8CNV/E=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3ZnmK48wWipzp1tLSbtl6URLGeQ31Qh++XTZFoGQjfEwxW/Vf
	1VCE/gpeUNqzDiCi6omYQPeY60UCRwvIs3HLxad/fqhu0gdU05+uYNnm
X-Gm-Gg: AYBFou3ggOqE46nI0lnl/ANC9O3zwpaJW2aB14ELrTIvB6kuN0RlUEhqefUleoA42Ol
	pPk1Szkj42wWc0yCgBfY22kJaMgXHc7/Xn7O0JMXfs66n2OSLRUPAZaM7v8TIG9dXUq/TapAdG/
	USucgTK6yxFMVpRtPuj6PEhApdup5356oNMez5IGdllgizZbgLvMCelbXlcQL84O0AOhtjSijLO
	njhPR3+nok6FjhAvZAFFYOA+uIYzO39ZBy/6m4m5BIBLiaaaHOAdFi4v5q84Ouy8TzMmMSkMkfL
	fdJjxr8esHnzU8LmKMqWSri8vdcjDfRPbVYDuZA82eITJ3GFTl0tB9a+cIwjm6+bHcPgr5DTmQi
	PxzoH4vq+u5zuaxhdHKzFzxT7bP4p7T05hw5SF0/cWcPKjt5iFHO2wuPDrtOacj+CJnfcaPDpl2
	SP3hfniS/uqkMkN5xUAsume/hPYgPc4jjQY1gSjLoGdTBISC6zdePWin7RrwZwRUevLGzvtp28n
	dT8XFdgWh5Aqu9Dkqmcibsdl6Y51G+/1Ym2xYPNpU46nvGVPEjd2pebDI93mG+fN/GSCOidV8RO
	+Lj3f7+rcIoHTRAtat+Bl36awVNDmqv8
X-Received: by 2002:a05:7300:cf92:b0:35d:ea6f:b85e with SMTP id 5a478bee46e88-36a42225501mr986655eec.1.1793312162961;
        Thu, 29 Oct 2026 15:16:02 -0700 (PDT)
Received: from localhost ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428aed76sm1506109eec.9.2026.10.29.15.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 15:16:02 -0700 (PDT)
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
Date: Thu, 29 Oct 2026 15:16:01 -0700
Message-Id: <DMHO3TPL4QDJ.2G50G0W2R3ZGB@gmail.com>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 <git@vger.kernel.org>, "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH] notes: do not drop notes written by a concurrent
 process
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Farid Zakaria"
 <farid.m.zakaria@gmail.com>
X-Mailer: aerc 0.22.0
References: <20261028-fz-notes-concurrent-write-v1-1-3d513e1fdbb7@gmail.com>
 <3c4f3793-07d4-47c7-b503-13a6ae567147@app.fastmail.com>
 <xmqqbj8c2wk8.fsf@gitster.g> <DMHMEOZ1ZXRI.TDMEKTJ9W325@gmail.com>
 <xmqqzevwyyi1.fsf@gitster.g>
In-Reply-To: <xmqqzevwyyi1.fsf@gitster.g>

On Thu Oct 29, 2026 at 2:42 PM PDT, Junio C Hamano wrote:
> "Farid Zakaria" <farid.m.zakaria@gmail.com> writes:
>
>> I felt confident reviewing the current patch at it's current state
>> (AI-assisted) and I do concur that it's a net-positive change in the
>> interim.
>
> Sorry, but I find the above very confusing, and I cannot figure out
> who is reviewing whose patch, and who is concuring whose statement
> that said what.

It's because I bottom-posted; I thought it might be easier to read that
way -- I guess not.

I was just trying to say that I felt confident in my comprehension of
this current patch, and agreed with Kristoffer that it's a positive
change as it stands, although the algorithm could be improved to handle
cases with different branches as mentioned.

(hopefully that's a little more concise and clear)
