Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011297;
	b=GgAndpNSCCWT4XMLP18lj8oVUprq+EQ2hw8ez3jNFhBoyIJmkqGzTrypZbxCReG8ta/8
	 OzYJ5DTipVhSv3Hn6k+1R4opqmEg5l4UFn/XrCS36hxymRmEVDN97nudLXkIW1rEnuBoh
	 cUMuktPmMuXNmFCOzKseVTahRsTE3Osvn4AAVTngE0t4CFR4Jvvd2b3goRjaUpRG6UQob
	 rul2GdvsmNNI8m8id78ixofcwhtwpSbHrxYTQboa/g4/XX29aFAR8D6MOeKA0YF7jTJjC
	 3DKAJMB12XGe4Pa9cBN2EuZI21szyhFdlpxwVoMeZ34rrMmwgJ+Gt/kcNBZoqmsSFJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GJGB4gHqRCaM0/Irl2AjsgL25oBHuUmn6CPwuMCeNyA=;
	b=SVf9JKRu9L0PK6dBvYhuavmPzBzTBps3IrEJsP8T3FRITaxx4sS5G+ctSdCinIsZoIe3
	 cv61xRduyuF0Y83HtHMJP8l3RWNnbR2q36dkO3Jf9nUOKVoIp+iPX6B0JNrCnc2Ct4luK
	 CPaR6XxHLmS6c3zTu09ph2SY+7z/okJHBVssXrly5TH5SD+fuBEx0w4Pqchj0dCBeI+AB
	 8/cdoZmFrE/d8P2YzRdb9gCBOxByXT629W3D7riRvHeGa4bjlceBipLfpGfyAPYLEUa88
	 /ZUE1x2wdDkrCuhIuQZLpk5jJQQD/cCAnxq+V3/StxdZ2qcPrSRE3i45amWB3e+25sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Zr5Dc/rQ";
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA63606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 10:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DA63606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zr5Dc/rQ
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48b060ec084so1713467f8f.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 03:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793011296; x=1793616096; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GJGB4gHqRCaM0/Irl2AjsgL25oBHuUmn6CPwuMCeNyA=;
        b=Zr5Dc/rQSdJCDAIwzx5ObPDW+qwf7wIw3tPWp+fJOoh1HCRXgvE7o/gQMnyOIIen7j
         uYmGzJ1cKVeLCUhgJcKpNhPyOj4qgbLrlLbfBLIbKWFLd9wBNsI8cfe12bCkHd7B705U
         gAMdJXNPeWtZe6EXTK9OZ8wxZJYIPXY5k7K3q3FVxsXl1Zy4nGRfmB8Qq5UsOQ+bjbYo
         SZ8kpHdc1U0ePNHOjMHREY/6defeXqKFBTgkUNkgTVdvWZ4poKXa6gcsUzTy0YeEx2My
         6PwSGJ7EwCGcqjFEvqg0TuI21aOZkxPxgACz5zXuqoG3tvA7e5DBv3nxFFhMmwHydpHy
         scAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011296; x=1793616096;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJGB4gHqRCaM0/Irl2AjsgL25oBHuUmn6CPwuMCeNyA=;
        b=f8UT+ac3uBX4mYxQV+0+jR+Eto542QeoPZVwoNWAs2N6tcdu2LwVGbbK3ksejlT+fD
         Uy38o2h29WHa+CqBhNtpFtnvILVDTdQKMy3nmhYsa8Z64w8bRF+OAd0v4zRII9ucA6FU
         LH93SyAbhvCqkbgVKkCKeN7r3y+z51zzPP5YFeQ9HBMs1ctozZS62FEY+uvrSZ6uSxgx
         6oD+Qu0y5hARMBzufPlF/9QXtbDtzItcD7jrkO1VE1Pv07xepyfw/wLhCWWy/yFT2tCo
         t1rSwVOk8Mwa+8TDCMcRZXONEOZzZKmqEoihQTdwKqwHKCxRU+aAWV/ytLpzusPdXXPB
         n2lA==
X-Forwarded-Encrypted: i=1; AKwUvBxp52dc8/erwe1vINq74N92ENMDRYsN7dFng/Be4LYfw6Pk5rFb7vVkgcGxxs0W2pMnXIU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZLxo9WddlUlvXj8anBXK186ly8a12ka+YdukFAvtmosxcztIO
	pcjz3VuOrdZH7uRv3QIUfsqU7B6s0edDztHG5MTnv1G4/4fX1RXmhM6i
X-Gm-Gg: AYBFou1BGBWDlFI852BLG5wqkxtLa3uJi0r/FA8xCZmLRvk3l/bBXdc0kyfzYzxzxwE
	vyavC1sE1Gx60Y/blTr9HPO7F+x/G1sE4uGFI1+9sUCWYiGYNOKGIEGEa2DRfxf50Fz3g/85K+G
	LzW5SeBMKVZeIOvecU5lOe64ptuy5A2U9mihKYe2wt+JSNc3B/c0tSEjP84JYBKGtDu8DcK+1T+
	RGFqXok22f9r/nHFC3OGeqHxorYTxMErNvSeRljgnPW7gMsFg5RzNpzN65Tlzxq8+6ca4QyDR5M
	6a4ZubV7vEkj/E71bUZ/gAqtRnCzeRT22h9f85cBxIOkVHf4NzP6jnGLd7NoKZHtFkQQGIR/3Ad
	apLwT6CnduzEa9ay+x0xGwNCeU49OXAbOYlzGmhV0C8/2EqZNEQ6NMzwH7CUk62JDq2dJYzKQLB
	8eSzatFkXLkBUvHsIOGVuTKQ5a88sw8UqVKBeG68qN6kw7mwYb5cMXiWvyNEINzlFPnVD2wQ+gy
	e0MGojRDf9PxsPhAA0p+3V36HAm+JOovGwYAFWfI64BKvtB+0psOYu0sllGY2INFBOJr1clXhS8
	AjWBkXk9fFcM8XBxbIYtrtQEdDPYc8sonAt/hnh4isFGqU1jV0SDkNheg0gfYixrMFMVMumT7m6
	E3lsfFtE=
X-Received: by 2002:a05:6000:4549:b0:48c:7306:18e9 with SMTP id ffacd0b85a97d-48e3eba0c36mr6918144f8f.43.1793011295188;
        Mon, 26 Oct 2026 03:41:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd39a9sm15940118f8f.46.2026.10.26.03.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 03:41:34 -0700 (PDT)
Message-ID: <daa3d794-8a0a-4577-a916-51820575bc6b@gmail.com>
Date: Mon, 26 Oct 2026 10:41:32 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] Documentation: propose community voting process
To: Jeff King <peff@peff.net>, Tuomas Ahola <taahol@utu.fi>
Cc: Junio C Hamano <gitster@pobox.com>, Emily Shaffer
 <nasamuffin@google.com>, git@vger.kernel.org,
 Justin Tobler <jltobler@gmail.com>
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com> <xmqq4iedc99a.fsf@gitster.g>
 <20261024111856.8s8qu%taahol@utu.fi>
 <20261026011731.GA3575069@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20261026011731.GA3575069@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/10/2026 01:17, Jeff King wrote:
> 
> I saw proposals elsewhere to cut it by time. I think "N commits in the
> last M years" is awkward, because there are people who have been around
> for a long time with steady but slow participation steady-but-slow
> participation.

I think it depends on N, with the low values that were in the proposal 
most long term contributors would have that number of commits in the 
last couple of years, but I agree that if we're going to raise the bar 
on the number of contributions then N commits over all time with at 
least one recent one makes sense.

Thanks

Phillip

> But if you just intersect "N commits over all time" and
> "has _any_ commits in the last M years", then you can get a table like:
> 
> total    | Active in the last N years
> commits  |  N=1    N=2    N=3    N=5
> ----------------------------------------------------
>      200  |   17     22     24     30
>       50  |   34     47     56     67
>       10  |   71    104    124    155
>        1  |  239    357    457    628
> 
> Those aren't necessarily perfect metrics, but if we consider them good
> enough and just want to tune the parameters, we could probably pick a
> spot in the table that has about the number of votes we'd want to deal
> with.
> 
> -Peff

