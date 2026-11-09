Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233657;
	b=lbS2krEFvpybx6xIbmmS3HEloHg/UR6DL8Ps07qmX9aof6qsGkin4q+K5xwikkmV/hxs
	 ZD3N+N3SZxpakSmZeYGl9P6sflhQ6QftFYAP51pbt6CakNtfgmt3xg0DXjF9a+WuPnfWW
	 8Mx8uva3OS/AjNhi4mSN/6sqkngHsn9OPeLbM/cWq06G0RHQ5SwUO3f/nJGGdt7UZwmxR
	 dGGNozZqv5f+6MQsY5ifYH33yc3pc+0+b3To12n7avjJ4h+i/ueE9UKJDrrVwubDV2YfO
	 lA6Ur6ETM1fsghQwCc7ru3f+eWUrNfWmp//MSdMGVjTrXH8sMoh6tJkYNvhbxjMPBgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=rt/m+abRTbx7MRuL+RSQdcYro6tpWgYCx5sIaogqtrk=;
	b=iFt1PhwxVvA+o7m4ipLhiqNpIUxq5mO5eoYh1lxsAj7zEhBIh1A5P0Zry1Sl3UnUD6hQ
	 YlV0SODcldYUNNVSJB3ydjNG9N/6s80fU9ssmMTTybD/EZ4CSCGDLqzDi/bySaUxmyREE
	 9rR/Cy/c4K1ADguP6p64aI0s36H87a6RiIs5LKsDP1enukYxRCUpbEdhZhmbFwWe74C18
	 ckUER74kWPhAHGFqaLwzzS5O8KrrlLJdTYkdiP9E2coiR/r8gE0C4VoyIqlu/3aA39G9P
	 TQuNFr2QlK14nwPaQ6Ou/UeK+ftziwOd8zkqKAjR5cnS+Ve8s3ns4eb1qSdnm/SzyOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yP9IfIA3;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A69D606A322
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 14:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A69D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yP9IfIA3
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so9651825e9.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 06:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794233656; x=1794838456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rt/m+abRTbx7MRuL+RSQdcYro6tpWgYCx5sIaogqtrk=;
        b=yP9IfIA3dBfwAK2BKRZM+24fxz8xavXY/Ho+qaOE0nQ3XTorg87QAS+zrwr9oiegZC
         8Vi8PLn3q28sQscpmZwj84sq6OOM77f5ywFtCDUW5GBxXND82pEpsEe6mpRVx3XKNmXZ
         HdzU3xT5a60y6TteITBbPt/VhJD1X3ut2ssZNZcyNHqfeW3xgirvYw6n7H6fRI6KXzAd
         GjQ61svvYS5eFpTFBRJJ3Ms/DtkK+jhulwj/mx58qeb80p2u2vPSKpXInRfimpiI6ny8
         H4xc2OXFqTY4ZD89p12xp958ZMHfwODtxQW7p2j3Qditkhm8HuQPjKwQTaVgR+TE4TPp
         ITow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794233656; x=1794838456;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rt/m+abRTbx7MRuL+RSQdcYro6tpWgYCx5sIaogqtrk=;
        b=hSu99/DGktJy3zRzqQM9xn5a2Wob17OjSHKDIaQqXCqNhJHa3u0Y3H6uuQDCdSnroE
         1NKYWRzYHc2cjEBwsy22Kit4Fjpmq+pCr7l44oaWNbcCY57DqT8EdmKsoe7xqqGlfXeo
         hibKfgdCchJT1V1vxw+4T7sJsDb8Sq/x4q97Vp5be/WyUsjcNE6qlvHHwNNftyuuEe2I
         5tnL44XXF7D8TzaC17B96oMwdVud5XldBBuPnoIkoeAHZT1K4F48394sQR1gS1BF/4e2
         UcXl/V2UbowKFTm0gbC9FjqT2/HmtqHZl3DqAvpY0dFB5oU73uer0fwE3n4JCThlBbBp
         qHTA==
X-Forwarded-Encrypted: i=1; AL+hErEDjJC5ZkDIDgLQFyDwjUph8EV1wZ7Xgh5iNocgFCSBEB6RgYvjoMKxsQ5TyfpK2EHcyoc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nRSMOvZrbGzYQNnxXK5wQUBOMpwNDbWs3WcT7Stdnlyn7pbeQ
	8wHJMdUFMuqD4PqJ2hdsrcaBn3D4qffr2CjOYNrqcdjMrmoUc7PHwxr2
X-Gm-Gg: AYBFou01+C5hrtf0olvCypFmE3cJJ84p3Ue+E93/UC7qjO2QqMMdKA58LhdDnms/sqp
	H/dIVJe6IhCQRtfyY7CWOAmITN3RsLQxdwK4m+ZhEpggaRZ5zr0maC+u8/WiPJvio2KVOzq68Vw
	PED2weSnYGDCX3ADH7bPMlt+b783kicKlI0+44XkO6eGoyHeRU9B4GxrfA4LM9bQgvC+k/c3An9
	e1AFsJk0/WO/swiB6kVnilNzGjY1D+CUA4EmHB9gDTRoWRYdO9HdhCdDyh//Ggzc1RZ2lazF90T
	STavltbnlqXaS+93VWgBhvd/OFS8NtfxQtik51KmANmWedUz+D64J6ZLHOdwjWa6VyctDAL1Q/J
	o3C+ezxAKiJLRsywvuZVy7v1zcnghEAmo3905tce05Gjj7eW4M7Imgt4mkpgqRjwFAdJRZZUKBz
	ZmyRCHf/H3YVtCNKoPwHDkWGGKP3Td+lTQmBt8eMxIdw9rM2Krm67yhcrByOUuC2uEVhhJAaFj8
	YNwMYQD4vYzGRfNsPPsFGzOkycqqqQJyjeMN5mvbRGSNdvnfaOoK57i5adI0WV7JeNhBJ59P2yb
	kiin9YJaQw9LtvMiEf1GYE5m8uEYKWnWR9j1AViSGYTASHnTwG6Wl5e1KoXJL/0/xZY4S0OVH22
	FexYcIA==
X-Received: by 2002:a05:600c:8712:b0:4b1:2026:6b41 with SMTP id 5b1f17b1804b1-4b963c9de56mr78269215e9.30.1794233655701;
        Mon, 09 Nov 2026 06:14:15 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b795024730sm177277855e9.4.2026.11.09.06.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 06:14:15 -0800 (PST)
Message-ID: <4b46f8f0-4acd-4101-b133-8d4ee8b0ce27@gmail.com>
Date: Mon, 9 Nov 2026 14:14:09 +0000
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
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 0/2] Support --verbose in git history
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>
Cc: Jelle van der Waa <jelle@vdwaa.nl>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Harald Nordgren <haraldnordgren@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>
References: <20261107193020.583215-1-jelle@vdwaa.nl>
 <CALnO6CBarutmydfmHDM=y5yfUCQY5SxKKcoCrd0NXCuNVkDuJQ@mail.gmail.com>
 <bf54db39-d10e-428f-8c6d-b444f37cce81@gmail.com>
 <CAOLa=ZT_U+gDjdLYkbtqRjUxwHA6q6+Uk4ssznyHgn09xcFqpw@mail.gmail.com>
 <CALnO6CCfKsd=w1kVvbJ83WtJPbsH8hGcfZUUTE9eGqWOZeA=AA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CCfKsd=w1kVvbJ83WtJPbsH8hGcfZUUTE9eGqWOZeA=AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/11/2026 12:43, D. Ben Knoble wrote:
> On Mon, Nov 9, 2026 at 7:06 AM Karthik Nayak <karthik.188@gmail.com> wrote:
>>
>> My preference would be to make this (current patch) default behavior and
>> not even have an option. I don't see a disadvantage of having the diff
>> always being shown and it definitely is a better default to have.
> 
> When the diff is extremely long, or if the user has other means of
> obtaining it and wants the editor to open quickly, it may not be
> desired. So I'd prefer to still have it optional, personally.

Another case where we might not want the diff is scripted editing as it 
is much easier if the script does not have to worry about the diff 
getting in the way of its edits. Personally I'd be happy to see this on 
by default - the history command is marked as experimental so if having 
it on by default rather than following "commit.verbose" proves to be 
problematic we can always change it in the future. If we were staring 
again I'd also make "commit.verbose" on by default as well so maybe I'm 
biased.

Thanks

Phillip

