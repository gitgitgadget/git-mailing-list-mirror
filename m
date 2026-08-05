Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD663EFD22
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935419; cv=none; b=Ps5VpnOL4GfrFFygRG5tSZ7DYavTjjeoS0HDFu9WaESG1Qh5opYdraB0ng4BIZqeu730XESRqF7tYCg0ZpGtaotjMug2gAJMyY5i2mSFCOTZ6usiYq9VurtkfTBRuyGsBC3YwJRcQ47TF45p77+bJ83yeMuxV6cKAd+xDvzukvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935419; c=relaxed/simple;
	bh=CGfTr5F09PwMnhXa+I2u857Uhal78tc/jPfT03mbbtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtV5VMQQWPeVpiRT/lqlPzpBVbEy8hK9SyK9KoaBR3GWJnoMR8Lwz9u0dMJbW9ygeRu2GaVy3GyUMe5QTAs+y9z4jr6h5bvzlhNLgvYKH3aCdTrdbBV4/l4/BShNtRmxfyFzZYHntAqyGVW9VlKCgnwV9r22XWyXiK2BL9MlXHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQdOgbwc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQdOgbwc"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-472326ca506so679784f8f.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785935416; x=1786540216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f0Gi0So21MJ3dc/uaj4CqiZfTwg1lsa5P78xiOa7fjo=;
        b=CQdOgbwcyFnm8nSOHJVNy81o5SWNNkxmhyvyeRaNtcCQw9K1Xi0e8CiP0mtYlQ291R
         wppLC9cEHaY+tM9w8iR3nlVZmkB4MNIEsnckIS1YHWusKiXvRZGYc4W0pqfRVbwwW5TP
         fWAYR+aoyJEjTq5hfpS+2qEFWeMRqq5YAb2rSD42FPfWsk6FL24JPd7ap15GYchC8Ybl
         qd106WfN0txN+KMTYsiTqW8eixDUM8tqsR0/ksXowC/FSH/eRhXXsxo9k+8KmWgNhRzI
         Es9ScGFvxmblcohzYPB9GfkM5Bdte81GPexzCM1U1FS4rNdEUU6oJNOg1ilFS3kUf4pH
         2bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785935416; x=1786540216;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0Gi0So21MJ3dc/uaj4CqiZfTwg1lsa5P78xiOa7fjo=;
        b=FKjcF08q8wLzVhU/B+kspzbhXTkn2yo4r46+gVyJv5kT+m4tN9D/kSoXRSHeQUbNGf
         tf/ZPdhhcx6wKrDBlilluRgOZsjKKUA0mjoQwDHluBzGQV1V2catNpinYeLH6dYtmNJ7
         uFC4WDs3AMtUBb0koYjz7Tmz+AekhDA62zcwJhlqxDZRg5Gp3a/BezxiE1A/I/vzpf6I
         85ZnyKeaIs1mNa/FSAn0I6/zfeXX1eetoddY9Urt2XTVXpA0l0zFsxqtX44KYUuhoa6l
         xtYnOU+H24kP98YG+u0nruBWfDRhKIIarN/FBMi0tqG0H0YPu4n4P0A5fw52fMrNXEYB
         urCQ==
X-Gm-Message-State: AOJu0Yzx4NoI+Q1HNpOMBqnW7acdJE5GcFU2f6xFclYYuOdOP8K3MY/u
	OHBTyOXkb6HdG/v9AJ6ZVz94M2p0FudPNS21tLs9qVCJafHXRiCx0hFL
X-Gm-Gg: AR+sD11yQAOaCzHTdWAKQ+Iyq1Y0AxWDtNgLc/wiqVv8siC/omtHE9/NEmkFp9fHeGf
	QpAsEYTJZs1qdm8hd4uW3L9+9HHn96dtG6ponUoM2E7Wtad7unNz1cbTHiEk1wHDuje7r/7uNKR
	uVSO7TO75+W8C0UNmOc8jGHsx2SaZ7VgfjdjO3C1Lga3AgRsxai8DhxTQx4jVULP5k+c7HZcKoJ
	1Ry0r+CBf2iuk+Pj+UJGP+veUxgzqUFznPPpAeVwH/qSdfK8yivMPqyDH5Mwq3StpQLh35sCLZK
	AzaD3Sjfwh1pGX0f5yw/tDSTRZE3T9pmqfu1gMF+z0Dp8ErvjEO9RABo5YFjwto5611sTSza55i
	AjVwtAW7B6FBCyiLDGwLYxWhEKs0dej+JnHCLybhNuv4fD5WC6pYa0Fpj/XIoSiOlGPJKOEq7XT
	F5XnhP0JWGTBE57l2sBBtTfwuQ50AsqXHSCopCz+0bfmrfT7jLC5kahOs/ZSBvyNPPAJlLvsP2V
	MQY8BMVl9scdmJPce1KoYxaqva8rvitioNA12C5JLw9Kohg
X-Received: by 2002:a5d:5541:0:b0:47a:b86f:3ed1 with SMTP id ffacd0b85a97d-47fec62bacamr8729151f8f.21.1785935415572;
        Wed, 05 Aug 2026 06:10:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:48d8:e54:f1b0:bd0c? ([2a0a:ef40:17bb:9901:48d8:e54:f1b0:bd0c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec24a24fsm9613521f8f.36.2026.08.05.06.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 06:10:14 -0700 (PDT)
Message-ID: <47bd0302-fc52-4df0-98a0-6fad7eb0fb05@gmail.com>
Date: Wed, 5 Aug 2026 14:10:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Jul 2026, #12)
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <xmqqfr15ruw7.fsf@gitster.g>
 <f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com> <xmqq1pclc210.fsf@gitster.g>
 <414ebe62-c7f6-4d44-bde2-b689e35accfc@gmail.com> <xmqqbjbpptzr.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqbjbpptzr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 29/07/2026 18:48, Junio C Hamano wrote:
> 
> Perhaps the sensible thing for me to do is to stop taking any new
> topics into 'seen', even if I've spotted them, until I see somebody
> give them a real review.
> 
> Otherwise, it becomes too tempting for me to jump in, give them a
> superficial read after seeing them linger in the "What's Cooking"
> draft in the "Needs review" state for too long, and, believing I've
> seen enough, mark them for 'next'.  If I don't queue a patch that
> nobody seems to have read carefully, I won't succumb to such
> temptation.

Maybe, though I do find having the patches in seen makes it easier to do 
an in-depth review as it means I don't have to apply them myself.

Thanks

Phillip

