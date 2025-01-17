Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF2B1F754C
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737103666; cv=none; b=Oaq9q++ppSixIYw2jgW7yyQQDi2+3SMNDkRMBqjh9MQ0eiMTEqb9pk2l4b9D8ZEEzsLoJK0uBlFVJmw+Wa+g3fyYBOxvg8HJEPxOH9Joq4D2YliBwDl8Oy/gmVxRK69CbQjLSk6++3MvFg4qmjtDa0rWY4N/GtmcNp+o19RzpFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737103666; c=relaxed/simple;
	bh=HWv3KPmG4hj/4itbQTt2apEyl5Etq/EuEflPNhF2DXk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGROer56LadiH2JjvgQTZH1de+Qw35ygblzy3Foj7KOcEZnmexqXh8cbzbhFNpoYSS8pwKp8sMAsynNX94mWsECi+/4uHQhvxLshu/vZwy5rLraz3M6fPukvw2sRH+06eF8isx/dczOJAPVQgy43vxs49wmMAgqn/MlcNCsiMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNE9oeBA; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNE9oeBA"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-51cccafb073so632832e0c.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 00:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737103663; x=1737708463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWv3KPmG4hj/4itbQTt2apEyl5Etq/EuEflPNhF2DXk=;
        b=UNE9oeBA9G3tpnvsVa82zuKtHZNnRX+BJlYSyuaTQqAQfYlxE0yrGGqhBo0vz/wKMG
         /HVnW+zVt0Gw4dEYfVImHfTv6UInVQNyMlt5d9B2P5V4txZrlismMUTi2AcTnCGsbXVh
         WQFuhWdS/S2JFm2TjkqIxRMV+JTaUsPVEqRCfMmEmJIIK01RzQi4Iba8fP4Sg9zVkbg2
         WF4DCL+jGXyGK3m95LHrhHHkgwsGetEt9ftjKRMejBu/W+chdUsVeJdqGwd9K7j58utT
         pTkP5GjN7xbKEg0nDGDQQN3a1/F/yOKu/E5eBRtoW39rldBKMOfEbMtpd8TzmU5+JUid
         7W4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737103663; x=1737708463;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWv3KPmG4hj/4itbQTt2apEyl5Etq/EuEflPNhF2DXk=;
        b=xGAuoPRJkXPOcg72WF2LkQG+b4udoVBpzeqoJn4j2fNOKGCk9gtR0tCLNJugfTkz6i
         ZWEYuz/agwkMWG4o6LqetOvPG8iIceUwMco4p3ct6RxGEROSW8VDy6D6biWDmYSj1TfE
         NkRAjeWhByny9IZ8V3HW3+JgG1hRpSDOmGy9b2XfFMpJFNDpedWl2r6LEIgtwmxT00ON
         /DBcMV0l/sSVMTWy24zaaYW8gXSkNIjAYyV2KcDN4D85jr2LONvcQg0ezcTVOg5yRZkd
         c3yXIkdLZCORfiES1UnsIUInFaF9cZiOpq/r+vLslbCrdW0nMXE7ckt7Ug0UCEbES8tD
         3NTQ==
X-Gm-Message-State: AOJu0YxNYofqUFienmdrGJ+0n2eASDHxQkWeyMZH8pw56bgQ7+NyE1bL
	DrrRPW2Zd1C9uBRtT8eF1H9NZOruv2VA+svwPEaXiQhCrIqXQ63Fbx4EFUKNtZgUrzazlUEki5u
	pSHtgsnYNr3nYyUSCFANu1+2O53E=
X-Gm-Gg: ASbGncsLEqG4dU17+d73sceydXGkxDqJhlrdz07Z3BwRv125iKupFPsOwjQ+J+b7XBZ
	6DRKMJm7KIR6+xIpVlM3dXUldipkcdW1WLoToFPE=
X-Google-Smtp-Source: AGHT+IGy/eKfZHaOOBkBNvlf3egPOy2Y4nWKQjK/IMOiDweAZeg7dcSz6aGD3Ob5+VGvXbCXq6fu48DsmwCCAhT14kM=
X-Received: by 2002:a05:6122:d87:b0:516:2d4e:4493 with SMTP id
 71dfb90a1353d-51d51b77f17mr912797e0c.1.1737103663364; Fri, 17 Jan 2025
 00:47:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jan 2025 08:47:42 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo706r34s.fsf@gitster.g>
References: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
 <20250116-kn-the-repo-cleanup-v1-2-a2f4c8e1c4c3@gmail.com> <xmqqo706r34s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 Jan 2025 08:47:42 +0000
X-Gm-Features: AbW1kvaZqJLcCX6muiz9YRAuJaIDNOGQyHLV6kOTJPEDvNWrGIY2c3RIhgPAONQ
Message-ID: <CAOLa=ZTF_2Gq9sFZqwu3Sw2dcQficBW3FOVeJnBDuwc5n4e-gg@mail.gmail.com>
Subject: Re: [PATCH 2/5] pack-write: pass repository to `index_pack_lockfile()`
To: Junio C Hamano <gitster@pobox.com>, 
	Karthik Nayak via B4 Relay <devnull+karthik.188.gmail.com@kernel.org>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000cb23e6062be2f622"

--000000000000cb23e6062be2f622
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak via B4 Relay
> <devnull+karthik.188.gmail.com@kernel.org> writes:
>
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> The `index_pack_lockfile()` function uses the global `the_repository`
>> variable to access the repository. To avoid global variable usage, pass
>> the repository from the layers above.
>>
>> Altough the layers above could have access to the hash function
>
> I do not think the choice of the hash algorithm has much to do with
> this change, though ;-)
>

Oops, copy-paste error. Thanks for pointing out, will fix.

[snip]

--000000000000cb23e6062be2f622
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 92fc6970a9773a7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lS0dTa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMkRBQy80cTJUbFR0OXNqemROV3lBQ1kycDVVL1hINQo3MkRVSUhsayta
UXp0dnNjVVhpSEh4YjhEN0xIaGd4M1F3UFRBeklnUTNFOWNVQjFMMlA5N3AwclBRU0xITXBDCmh3
UnUzb1owZkVwbGxEYk1WUFRsd1NXdTdSaTYySlZkc3h4NkhnOGJvV05TbW5VdFY2dnlPOXdob1Zr
YkhQTHkKZGxXUHNTcy9ZQ1IxSXRUREFCRkk1eU1uMDhNZFhYL05VZ1RYOHFVYm0veGZDQXNYYWEx
bTRHTWVjbFlsYkxVNgpteURpRkJHQWFEeVd3QmNUWVgreTlXd2FBR0lSbjFPakw5aTZ5OTY2U3Mx
SHAwQVlRT1lCZm9kOU55MTlKd3dECnZtMzV3ZEFCbnhseFcvdnpuUmgxRGMvWlJaanJxNVh2cFdK
b1NqZGh3TXl0UHgxSlcxYjVGVFZXQWQyQ3VWQUUKUUJtcDljNGQyZmdsVEVzNWQxTDBNZFpjLy9w
SnM2a1VRaUlzaGpDaUs3bDlTRjVqK256MHZmMUlGV3V2em1tUgpya2M3MlljdTZZSWFOM256MUow
bWtxaUZxdzZMa1BSbnFQRGg5eXFFQ2J1czFBb1ZQM2oxUWQ0UmFHWWVOVlJUCkVUMVQ5ckJKamtr
VnRQT3NzS1loS2h6WXhtOStMbThpcHl1bzQ2WT0KPVRXeUcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000cb23e6062be2f622--
