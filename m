Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B357C9F
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110909; cv=none; b=SBTepvh+Su8C9DriR8WC36Fb5u22b5oXi59xWNU1p9EF9m/8xxf1ElP+9viYvq5hyA/LSNcJBcIXb43JnXrnsXca9TT9s6G5l+NsjMV424UFKKjG/sxdQzYOgwkj3MjnRY17jz982+dWGWnZsuWJPNgYiZ11cq51fg3a4VpApIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110909; c=relaxed/simple;
	bh=sGgB7y6UgjpZrI2Ev2/6EJ78+9TxOE+/OrVn1Ak5kAM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWH6eInVnf6YeHmWmKGgK/SgstvHL800YAb589TLxTSBi2omF+CkvnVRvFshf9INK4C56cUtT55LEFd87UQZmSo3z1hN31lFeRHDr+7QR+tjfImkqfYt/hGDbwaW8UOI72bdgmyuochF74GyVQ12wkWaB1o9Q4lsX3rpMjhrbvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD3+dhWt; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD3+dhWt"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-51873e55d27so942638e0c.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 09:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734110907; x=1734715707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=njwmt2lcWwhEAuydai0Eg0FzGso7uTuEi0qakwohsC4=;
        b=dD3+dhWtoaWOIew0dsTRERfNznypkNKlDc5GvETbrHy/9fdSr3XNOH3HRKTem/8bXk
         HFnvJRqcT9jiotdv8VnlSGOJ3w8rvv5jympRKFjKpk29aQJUoV+F4ridDbG4rJoeBGvy
         mlOMRqwIpaMnYEpSZ5BaXBPmy+KzEIA71ZIW5gQtxbH/Nln3OM+vJ64HPlKyJBJwVgnQ
         HBh4Gg7h90B3bO6H2cxHDP4J+iefoCMa/eutV9VHBfss37rH1TNxkeZGDDNepyeLSb6x
         IY/d1fuzJW7JIIbDTcGduV2abC2MxC3gUyN4WX2PSlKVLT/MPcNR2cr/aJPpReDRi8U0
         9qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734110907; x=1734715707;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njwmt2lcWwhEAuydai0Eg0FzGso7uTuEi0qakwohsC4=;
        b=SObZAv3FXiGvQ5TcG+OBFyNhxawrZUB84O9GHqSPYLMaoqsK9rBZZG1eD0YVuylSyw
         si8qJn9TtoF8MlBL0pj9ecbDH1DO7HkpvzrccnnvWEVA23ocmpwk3/Fg0zOdHbXJcpLh
         47dSHP2H3JBBVSSV0rtL1jYJIOqoF1o2THC6CJf5yNpXGqWwhH801oyq0fxsQEfePmRZ
         5wWczIkEAY5aJpwrkVQ/E1mHEx34Oc6TUCRq9yoty+rZB43wP5OrGe7vCVgtFupyTihM
         uaF6Uz9QjSktGgzzVoKvEadP//v9gs6Ft4r2M64adoj0SCn9MkQjwQqTquV525XbT5t8
         PTXA==
X-Gm-Message-State: AOJu0YyutTVRhqGro60Y+GI5xJseox2PnmCPjUre+0Ol4INtjxR3+GkI
	B7gYn/AQTcb8/SZFg20RpNDQyAu/s5LIf14rbWxfw1+y2v1/nxKN73GXZnnmlBxTEPIRTtG/c3N
	vfxS1udyQj0RF7QFayQz2aHVrc4TZeWU/
X-Gm-Gg: ASbGnctWOkVZYfsd7tBffPrlPhxSuGqaNQHOitcNf7TvwGszp9CJPIG0YHLs2lMawxM
	NhROk3WcHyNomretNJpQ4VogGpzuCvdjHgz6rUMbVYMQyAqtOXNG4Y//SP+PgNtTin4UfTeue
X-Google-Smtp-Source: AGHT+IFqJ2XTkgX+EPCrmmXsU3VdoiLcqdUDDhWKGaUkuMQhe8PJqIa9h+baJC53DKyTtmLT9rAq9DC2hioOYeWSmgE=
X-Received: by 2002:a05:6122:8c0d:b0:518:7bc4:fcc0 with SMTP id
 71dfb90a1353d-518cc0a9cadmr3086501e0c.2.1734110907266; Fri, 13 Dec 2024
 09:28:27 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Dec 2024 12:28:26 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq7c83ejow.fsf@gitster.g>
References: <xmqq8qslf5h1.fsf@gitster.g> <CAOLa=ZQmDyy1yajNzASUkRZeizroyCXcgsRK+fOtstatg5r=2A@mail.gmail.com>
 <xmqq7c83ejow.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Dec 2024 12:28:26 -0500
Message-ID: <CAOLa=ZSfrJ5QW==AhF_m9X_o2r1F3Q6Mq-YuseuzM51sRiq=Dw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2024, #05; Thu, 12)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a11eb806292a28d6"

--000000000000a11eb806292a28d6
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> karthik nayak <karthik.188@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> [snip]
>>
>>> * kn/reftable-writer-log-write-verify (2024-12-07) 1 commit
>>>  - reftable/writer: ensure valid range for log's update_index
>>>
>>>  source: <20241206-424-reftable-writer-add-check-for-limits-v2-1-82ca350b10be@gmail.com>
>>>
>>
>> Hey Junio, this was reviewed by Patrick and Toon. I see this was added
>> to 'seen'. Is it also scheduled for 'next'?
>
> If it does not say "Will do X", it is not scheduled for that.
>
> This applies to everybody, not specifically to you, but when you see
> an empty entry like the above in the "What's cooking" report, three
> things you can do are:
>

Thanks for listing it out.

>  (1) offer a few lines of topic summary

For this topic specifically, perhaps

  Reftable backend adds check for upper limit of log's update_index.

>  (2) point at the review message(s)

Although you've already noticed, let me do that so I remember for next
time.

Patrick's review on v1:
https://lore.kernel.org/r/Z1K-rXakmMQHN9If@pks.im
Toon's review on v2: https://lore.kernel.org/r/871pyejrfi.fsf@iotcl.com

>  (3) suggest for updated status with rationale (e.g. "let's move
>      this to 'next' by day X, as this and that reviews at URL1 and
>      URL2 seem to indicate that we have a concensus that it is ready".
>
> Patrick's comments were on the previous one, IIRC, but I do see Toon
> commented on the latest round.
>
> Thanks.

Thanks for all the work you do. In short, I was curious what the
expectation was since it is an empty entry. Your response helps!

--000000000000a11eb806292a28d6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 62bd89601171d410_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kY2JyWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0dxQy80cjRRdFY5V3padXEvSXJWRGp0VUpQaXR6SQpFV1NzSEtXRG4z
TTdtNDYrTEVvZW95YUtkZ010Nkl4N0pTWUtPa1lYbU9tc05taFhqampPT1o2TlFqMXJUREQyCkJw
bWlEM3d2ZEl6VVZrdktUVmJHMmkvSzRlWFp4VHNNdDFiNG5NWVoxb2I0U3ZhZ0drbDhOL25tUFRJ
T25jZzcKOXRjcUFtRmNZMkdkRkpubkswc2xSRmR0Q1NJNWpTa2ZtY1RBejFXZGZ1OHdoTWxMYysr
b1l5OEpCZ0p5RXhoLwpKRlFhZHhNcW91Y0xzUk5MVWo1bWVVd2plRkswRkEvYTFkUmlFdWxzMUJH
WTdFRWFtWCtpLzhleHFYZnNlYVpTCjJwQVNaemh4WjhGclE4OEphVm1UOXcvcXBQb0g2bG9YTU9l
VEFUS0hzbUx2Y0N4Uk1XOW5mMXR1V3dmV3h3dzgKdWZ2Q0lrZXRxdGN5cG0xRGQyNS9Ed29QOWNM
TGFBM2g1YzBsSXpxRmw0MjRMdHo2S0lBU05OSTZlUk1TMmhHZwo3OUxIcUNiLy9GWk9tSzlWZUdh
OW9Xa3NFVTVQRlVXSUkzVnBZV1FVWHcvbDFkeldqMHhkTFYwdlhCVjRFNGZICllodUZCSyt5OVBC
OTQ5RzJ0WDIxRnJNS1Nkei9qd0VleHlqVXVCaz0KPWFpdkYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a11eb806292a28d6--
