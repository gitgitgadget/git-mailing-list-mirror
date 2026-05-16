Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE97145B11
	for <git@vger.kernel.org>; Sat, 16 May 2026 02:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778900152; cv=none; b=Dv6GWHoYl0m87Kx1B7cfrdo27JIc+Yp0zrySPN7UgIr9zi/2Vjhjuqmw4S69V/l3zZJ+erV+37BP+1c30Xyms7aIOAWkUG0YDNG9bIC7F6m78MF0T2y+pS6l8P5vbQfMA8u+Jsy75SdxuqZ62AHjIL9qsDlnzVde4mSQXNQlYH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778900152; c=relaxed/simple;
	bh=0tVOFMny9jBjaMrvN3S6BPXlAF0UUrtma+pNHyRyoQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vgs07CGjb7sJMZkwHSJFnAms9OUH2cvyxxC0gBWmdfxmFBnJ1nCvpXQTZKBm/X/im61AOktTZeoar7t55CayWhkBeDrZ2inlW/RJwc3RDUSdTawYvx362GHw0lC83uFNlJ127Mmiz8qukxPq7HHjVUF4f0KrtbXTsdUAA0rkAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0/4J2i2; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0/4J2i2"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b5de17382cso5290406d6.1
        for <git@vger.kernel.org>; Fri, 15 May 2026 19:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778900150; x=1779504950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0WjJN8U0lMjENKFcQph7jjmNgAx81DvjFnSYLqMSMZo=;
        b=B0/4J2i23mmH5RZ/6+ziotkEKUTILZv0fC9an1NFW+9dmW2Ctwz57VDmiKCHCnruch
         QBsL2RRLFGyZBHUqubH9N+gvdeh1DKiYqlz9fy7Crzr5qqkQok6lrnrK8LZ8Ow0nmXAT
         zHQEurBFzub1ShX17s3v0OsdHUDGOQA2w7GCMu/Y58lEPsVvcFdbDjTGdqFrBROpAnmQ
         OMbewhp2YTuWuMT5qaqo6ndkQuAqbCizGYORIUGtLWJy2j5zh9m3PQpKR8plkYBB+oNB
         mB264rJsgVU9m9S0QhrjOSFK4Ej23F2hZu1LDnGquvdB3XyaDBCcAEaLUdWVyWeN8b0d
         USiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778900150; x=1779504950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WjJN8U0lMjENKFcQph7jjmNgAx81DvjFnSYLqMSMZo=;
        b=EkR0u+6LBOizvY6CS6zUKTmZfVub6QMh4R7soYBJJEIhQdaSTYyWPWbA1VgaBYZpW+
         UjF8dvNMe9xM9XomQOiGpBGml17ZdjVi+kLeipXFupJlknem3Xserqums3fV4pUUuuI7
         OFym47O1sXvmMDAgPGQNzNBw4TqBCkXTQTD/U1lVAnu4nkdWtakMtVUKpjL3WJzcZ4gM
         g8v5JLBX2sXqZgDF7U6EfpsDBm9we0iOHSCrcsotWHjEWgKuv+5PkfvK8pNUbvRmemHM
         gp6mWcVj6/ZfJy9Rxpev/FRF6c2/kQJczUbwsBz2oysDiRjSc6jGoUvgplNsfe539DVe
         MJ5A==
X-Gm-Message-State: AOJu0Yxg0232jjXWJLTfIBJAwdOSO7ASv5ytiSZbNoxfYIRrc6xFROdQ
	N0dMhYz0VI56lxkoq/oT37vpTRPtUZwinkglpVAqjFTReZ9AI0Fzjlzj
X-Gm-Gg: Acq92OHXLfoNafkl1uXPHGfrw6ZUck1vPBo38zgJmHpFgRDmWub+VozRtw8KtYAPult
	2YM/kfyHhC0gvgxPmSx9Yjp2xyZDe0HsZtq4eLspDKK4rk34MaOAUMo6F0BKSegf63/H22IuEQa
	KLtCBlFzWTBS1QpWd/MpH7gDP5U8nfm3MBHnSyto7XkaAjoWEpKb32/rqj1+K41/JPSlJ2TAIIB
	+J9HVzx1EEagFZHgg8wPMO32Xn+U57+9OuZr5FiA2vo2dxW+EX9vaxU02qwq4zzFShcKw9fqroX
	J26ilmERnxvXvQYCwsg9JEkSR0RaVvJWyWzh3nRi+GX+/Qy95fAWTos/g1okx9Y6EyU0DkIIhpx
	gE1VMwW10SS5r/OUaVBkg9PetPd88YXLsSI1waRv/pv+I5gJRP1Y4R2W6lATwGvWNYOaGRK8dIY
	j5qIFjXZaIipf8J4wBoWNNioOKUmBC0OU74n+hll3MuWtxkQ2+EPCnt1uV/ZsKLto1/hMMpxjaV
	sMJ/697G+PvbvJKjzTctSOdUSwoGqfCHEXejh54/2J7HPgtsig=
X-Received: by 2002:a05:6214:810c:b0:8ca:1ecb:a167 with SMTP id 6a1803df08f44-8ca1ecbc34amr42214236d6.38.1778900150550;
        Fri, 15 May 2026 19:55:50 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:e033:f3ca:f5b3:2d9c? ([2605:a601:9b88:8300:e033:f3ca:f5b3:2d9c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90874e490sm71800606d6.1.2026.05.15.19.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 19:55:50 -0700 (PDT)
Message-ID: <256d83f3-dd0b-4a86-954a-de78ec65be6a@gmail.com>
Date: Fri, 15 May 2026 22:55:49 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UBSan failing on expensive test(s)
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <871pfcdyt0.fsf@gitster.g>
 <20260516021343.GA174647@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260516021343.GA174647@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/26 10:13 PM, Jeff King wrote:
> On Sat, May 16, 2026 at 08:43:07AM +0900, Junio C Hamano wrote:
> 
>> This started happening on 'next' that runs EXPENSIVE tests thanks to
>> Dscho's recent updates to enable them in CI.
>>
>> https://github.com/git/git/actions/runs/25896439353/job/76110441841#step:10:2172
>>
>> It claims that """
>>
>>      commit.c:1574:6: runtime error: signed integer overflow:
>>      -2147483648 - 1 cannot be represented in type 'int'
>>
>> """.
>>
>> Another is related in the sense that it used to be hidden behind
>> EXPENSIVE prerequisite, but is probably unrelated.
>>
>> https://github.com/git/git/actions/runs/25896439353/job/76110441842#step:10:156
> 
> These patches should fix both.
> 
>    [1/2]: apply: plug leak on "patch too large" error
>    [2/2]: commit: handle large commit messages in utf8 verification
Thanks for the fast fixes. I agree with you that 2GB commit
messages are silly, but the methods you change could be used
for other things so having better types is good. We can
consider blocking large commits as a feature another time.

-Stolee

