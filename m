Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD892F3C29
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928467; cv=none; b=mLn2MA+thL0tdJ5HAQSgDpcRK7GiGHDnGct0gYRqp9S4B9MwpufeTSYnH9tqX7tYgH9iEm6q/W8LNYMXGBu1iawDn2JBGYbo4ipETF1buSOOqdm3ryRLviPguKC0ghRPB2JWlI6szUps/1HxT4lqW06oCBCP2dOfy8mvq35sydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928467; c=relaxed/simple;
	bh=02+BY/alpN+FaMz1iZVdzifyqDPp4L0FCLpj++k4fw8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDwTgJPwEH6dqsE9AW+OShfASDZuGmEd4OitwYm+iJYIDn7zFEawZgTNktSRpkOxS9xa25DtLw8htb9mqwum8hZ+6OBPAJWARUFgUGVAFdImz+41WfvT5N0e59kOzCyNRFNLSLjAHvpMOArT+fdcYLyn8fnxFQyrsstn6RStIso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVB/crSZ; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVB/crSZ"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-54a2beaa29fso520725e0c.2
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757928464; x=1758533264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mml0c5lgSfOjzLjKgFwGbblH+4zt104TJExT7EH0pUg=;
        b=IVB/crSZJCrZiQ76vMUP+uAK9rb/lEYk2S4XIlgTExD28LU9GePgx+jdGgxehCH/sd
         5PwRcBDYLugDJ2Ln61EpfjWE7Bu0BRT6PAwbo/crLIli20Nw/xqZB3mxvo0Gj7k1Gp9H
         voZqU61lsdEdNW+CbdNPlZWLOVG2Eai1AKObFtAw2Z+oi7oLIuobXICWLiFtHSUyAWBZ
         NOWjFHepgch1SEUMojGPiY+t0VBN7CBeLRzKDBrZfegs+ndaZTSJlMjuYkqgiQ/LoGta
         c2aqW3Zf98IQYkqE/HGVqQciQcZWP03FQkClXx9aQl8jLyYcVoPxyo1TFAlLV7hPwNlD
         U3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757928465; x=1758533265;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mml0c5lgSfOjzLjKgFwGbblH+4zt104TJExT7EH0pUg=;
        b=Kr4HCRd9jK6uT+Pxd+sp18WTUBoJ7W+DjtQD52aXiHRfoaPbApmj1ybv/0obJsZj8V
         sSbdcnVIUTsLojMTFwAoT8b30QW1I53xBlcqveoPYEZP56+7/1HmdnGd5EzkhMwxloS7
         JzIpqwbbjGwGkMgy/o2fTU6nrtHDNGJwwqI8CsS+J4eImL88EV029KdGnKOlsSGssbsf
         6v6XXO859jm/E9Q4ZfHguNBrUY1LtvEC8LWP7MTvTPwq5weUKjpWlw/OsYzyKnDAYDA3
         R1WbpwuX7f2qZE+GNHXDK0KRuMBjy1C4R57BoyhvULX5BCasPPVKQVa8L93Ou5t2BYI2
         knaw==
X-Gm-Message-State: AOJu0YwPo5hEW/0g4ObVejNFmohUWPFYRDPimyeYox35cVIpPnr5yCdx
	3jttxc7Kbt+oOG86yiTljiqHnLH34OKxgkdicdKpIbFubMPfgFTIfTCWvMb99l043Nh0Zip3Dqi
	LdCORbXb8EX932g/hToszHmzGsxehEiA=
X-Gm-Gg: ASbGncsbon4SoaXOgqoF09ZCyJ5meeHy+k1tiB9EFW3Nt0a3K6dQ/o5oJUwQTKvoJFk
	C7LDRiALhxUyn+0vhmyfAehwF3qfsNyG/mSI4czcyZh4UlYh42EAtyjmBprtBduRvIXJ18bO1iM
	60FT27ejWCRx4jt3difMlKxDBQe616KU6VPgDB2R2XKU6ZIyCOdNtO8yG+i6nyYPJyQNtG4FoXA
	FvDVxJF0Hjj5TEgFQyrXZ5D5gkYOBEW6owAQ4avyJXRqHvSehs3hiV4febPDUs=
X-Google-Smtp-Source: AGHT+IFgh4AfKvG3YFBP9DTl25guyUfOomOcqp6DG+oa48NK3oYaW7HOiubnWdxz6zw1tnPHIhZ1iFT/LMSEMMnKhR4=
X-Received: by 2002:a05:6122:3091:b0:539:3bb5:e4d6 with SMTP id
 71dfb90a1353d-54a16b7e309mr3570106e0c.1.1757928464500; Mon, 15 Sep 2025
 02:27:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Sep 2025 02:27:43 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Sep 2025 02:27:43 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aLf3NyodTZ38N8vY@pks.im>
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
 <20250902-228-reftable-introduce-consistency-checks-v2-3-4f96b3834779@gmail.com>
 <aLf3NyodTZ38N8vY@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Sep 2025 02:27:43 -0700
X-Gm-Features: AS18NWA4gZ2ffoCAv0KAsFM9tp6Z5NUPPMafZDaBQaX15gv3i9L6Vc6TqyrEQqo
Message-ID: <CAOLa=ZR9nXkdXuMik2uq8+kpxQwmB72r7XZB0rnJSvKU7mKmkw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] refs/reftable: add fsck check for number of tables
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="000000000000aaee0e063ed39d7d"

--000000000000aaee0e063ed39d7d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Sep 02, 2025 at 09:05:23AM +0200, Karthik Nayak wrote:
>> Introduce a reftable fsck check to check that the number of files in the
>> reftable directory matches the number of files listed in 'tables.list'.
>> We do this by iterating over the files in the reftable directory and
>> counting all the files present excluding the 'tables.list'. This is also
>> exposed over Git's fsck checks as a 'badReftableStackCount' error.
>
> This feels overly strict, as it can always be the case that a concurrent
> process is currently updating the stack. Furthermore, it's expected that
> on Windows systems deletion of an old table may not work because the
> file is still kept open by another process. The reftable library is
> prepared to handle this alright and will re-try deleting the table at a
> later point in time.
>

Yeah that makes sense.

> So maybe a better check would be to verify that there are no files with
> unexpected names in the directory?
>

I was hoping to add structured consistency check in a layered format

- Stack
  - For each `Table`
    - For each `Block`
      - For each `Ref`

But this wouldn't belong to that, since it isn't part of the stack. So,
I'll keep the above structure and also add this to the stack level. So
we'll have

- Stack
  - For each `Table`
    - For each `Block`
      - For each `Ref`
  - Other Stack level checks
    - Check other files in the repo

> Patrick

--000000000000aaee0e063ed39d7d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dbf4ae10d7fc9608_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qSDNBNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1memd3Qy9vQ3JiNTg5MzJPWGNCcDBaM2tpSjVabnBqWApRU0NMa0RSaHlE
NVBtVEwzdUQ3d0N6RkRRSXdqOE5RSVFJZXQxYllseXpuc1lqeU1PSFY0eVRaU2ZLS0QwWFZvCjc4
Ykg1L2Z4K3lOZE00RHZLMjF1OE5nTDFjdE9ibklXZ09MVG1zeGhUb0NyelEyLzR0MkZoRW9uV2VF
QzhZQjUKSFJTZGhYdDA5U2JLaVJRbE1HN3VIK2lvR1BEQ0N6TUJPS1JQN1F4MkZ2dHBMbXJldUlw
QnhqamdZaHlydGx6YwpKZ1VqeE5LWUFDOGhJenFES2JOd2lWUEovWWZMVnYwNHVtVkxZZi9XaVdJ
OWo3am5FM25UWVhNYU1oQ3QxNHg5CmpMdGRmbDRCOGJld1FXdGdWY1B1enNIWitPZTB2OHBVbWVw
bTNORlE0czJLejJLRnBMVGVHYyt5WW50Y1drUnIKRjg1TWlBUnZGYWs0cS81cUtyWXVlNXdiclR6
TTIvVEhCR3hWMXRoSndBRG5MVm01cTRYMHV3UGt0cmVva3NlUQoxczVsTG1Qa0doQWtFbzNFcXF3
ODl0TE1aVkxsOTRvQVowOXpaNEpoalljZFQwKytyMVZHaUF0UllWTU1sUVlHCms1K0tVUWpuWWY0
c2RKcjN0RTNpakFiRmNnNWt6eG9HY28xSVhHWT0KPU1uRmQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000aaee0e063ed39d7d--
