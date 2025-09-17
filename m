Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF43E33AE99
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122757; cv=none; b=MBkpT8rQXkLHxmpJrBEMZeCACGpEAe4YNeduarih62wWNNwh+iveom/zVI3h0IaI7EehR8i+yRoxQhuqwXY04anQC2dKmTtq44SxCPLaYudl5CZbNQKbabyDFE2jS7p0EiupYR+LWjM8xd44NjdpaW2qrKoCWQvu1oXW68Mrjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122757; c=relaxed/simple;
	bh=3tf991vqpaic1iiW1Z6zNy7k8lk4s7AcuWUMsrCTUPc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tM3VCg2syFUMho7ZOahI33MYXwiJ40mrty6D9iCX8nNEvzENLi6pR/kDeyYsuV61Mdqe5wBLMQHf9ZgzTJTjXa0XrBvD9mlg6SD71yRmg/T+xQua0G3zL74xd8Q9fuvcypmXbFnh7W1/5fsdHwMR2Wydv05JivKXd6fsZQs1O7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cv2V5jtS; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv2V5jtS"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5570a77eabcso4119472137.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758122753; x=1758727553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JFLiyn3dJriEKbuGIA99F3ranKv3ny6sE19PoG8ey1w=;
        b=cv2V5jtSx5lKKVjSlVgQmrKuUR3Q6iUhV+i8Pkg5Lt9+V5BqL4fNaKy88URhQopt+O
         aGs81/X+asNnGCes4K3loxd1FvG2pW9IZiavdwr6rQNtoeTIFSXpujR6sciqs6r43Fwj
         06ut9iTtInGq3R41fsiqlIk6BhfyjGyrsc+fJSvab6/3vrR9Jlt1t8v2c1LCoS6ohqp5
         Cu1MB63xWIlbtyGFFJADZcLMSWxWi4D5FOoVux+K/Xq+lAGh0a7LTfKJR1Nf61YXf7pX
         KosG/Q6+yoXp2uHsjNzzT8xIUicsYqvjtouCoOhbScnIAmukRwfMqr1R91Ft4EUzkDgn
         ccFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122753; x=1758727553;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFLiyn3dJriEKbuGIA99F3ranKv3ny6sE19PoG8ey1w=;
        b=TmoILNA6pmteXE79CZrTewhmB4Z/qtzlXSqixuUBeeS6q6jvrHJv4vQqx7NM9IMGJM
         /IHaHA8ruMqR9YeBtk+meG4ccAl56r5ajQn3+Uxvzvn09joQH49b8pfVojXtTcxxA10A
         3dK8B0+qX7rfu6S6C45YzLDs4eM/jIjE40fKahdegNlPkMVWEUq7dG1cPf9mroJcUJE0
         xLPJxdfT7J7CstX+oFQREMZQKIZNgcWXPkm9hEHE+Ls3VFXHiQE5BSkndOms6QEh1ung
         X583ubfonEYRgZ91ykuCRUfppG9CmTrxCTqueeHU43TH569zLEJL4qRsN7TItOI/uftt
         hJow==
X-Gm-Message-State: AOJu0Ywouv6spny7BFdZ9b2F3l8Y771nEDTwwtUski33OeCXk6S1TuVv
	CVIwxsa0JVzBNChy5xB1jTM7bVYy9qxVYdjYEdDEpkqldEXrCD40pDREei1sTQmF1c32xigR7C3
	kYQGDmDNMrLxLKbi4OiTO22EDmXTIKqw=
X-Gm-Gg: ASbGnctCq2axrgic9HWz9/BR5viuYMlcYRdrL91RazMGf6Pp/HRiQW+googaMs//j9Z
	xHegF0XAjy9fFQEL5LPVB8AzUt2eY0p4haZAvRsX4Y5ibZJyTpSKKHhWyu3WZkAIQPJdD4p6qIP
	lyIxH7GpNehvYU52eubtOqRPVKGHMnGzre3KOXtLuz2LdBlQOXHEsSd3y6x0Lhwp06pckpKtfK6
	RfrtadV3Re/TwPjuoRxE3rnvTfT5ND2djN/ifl2mQ==
X-Google-Smtp-Source: AGHT+IEBTe8szGohNc6ZQ9KBm/9ZKDwkNhxl/MxflZrra+rmxMvbrIoWOh8Nfhe5sjxrlsh1C8cRWcyxCqV5ZsmNDZk=
X-Received: by 2002:a05:6102:3f49:b0:52d:110:a920 with SMTP id
 ada2fe7eead31-56d6ec71148mr892281137.33.1758122753171; Wed, 17 Sep 2025
 08:25:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 08:25:52 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 08:25:52 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq5xdhgnbk.fsf@gitster.g>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
 <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
 <xmqqh5x2m5d3.fsf@gitster.g> <CAOLa=ZRvAMq7MNm6=dBneAXdDe6OjQ=NqYA9-Vd7E+nvDWGH0w@mail.gmail.com>
 <xmqq5xdhgnbk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Sep 2025 08:25:52 -0700
X-Gm-Features: AS18NWDya6p3uyEkNjT_FPhLbjj124jCWGq6HxyHaLNCyClErS5dIOs5MmMw4N0
Message-ID: <CAOLa=ZSaOhUnXqPsWP8MW3AH1EC-rQu7cGtU0W35APZQUhKiBQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] refs/files: fix issues with git-fetch on
 case-insensitive FS
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000002cc000063f00da33"

--0000000000002cc000063f00da33
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> Changes in v3:
>>>> - Rename duplicate_reference_case_cmp() to
>>>>   transaction_has_case_conflicting_update() and add comments.
>>>> - Improve commit messages.
>>>> - Add an additional test in the 4th commit to showcase D/F conflicts in
>>>>   case-sensistive file systems.
>>>> - Link to v2: https://lore.kernel.org/r/20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com
>>>
>>> I think I like this "latest first and then historical" order in the
>>> cover letter much better than the other way around.
>>>
>>> I see that this topic is pretty much done?  There still are a few
>>> questions from Justin's reply that may want to be answered, but I
>>> have a feeling that the answer to them would not require a new
>>> iteration.
>>>
>>> Looking good.  Thanks.
>>
>> I did respond to Justin, I think there were a few small nits around
>> grammar in the commit messages and a question around error reporting.
>
> Well, if it is already locally ready, let's have a quick "small and
> final" update before merging it to 'next'.
>
> Thanks.

Surely, I've sent in v4.

Thanks,
Karthik

--0000000000002cc000063f00da33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d9b57fc3467c177b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qSzB2OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOWl3Qy85OHFrbEw4UFNOK2tpanhkV0VGSmFSOTN0UwpYNnpPZXkxUGVP
aSs1WGRsMVByU2drUlM2TWtmcEtQQlpucy96SllWS1VLQU13c1pTYzdQMk5nYWZyMWxFSld2CnEr
VnJHSGRPVmtFVmhHUk1WWFNuNTk4TUZsa3d4R1NZM3BWajRESFNTbGlYQW8xdURzc1pBUHBURmVK
c1JtRzgKeG5LZ1VERlp6RURNRW9TNGF1MThzZFYyamVybjY4dWIzMzhBL1U5cDNTZEplSXB3L2Fz
clRRWC8zK0VhRVlMZAp2eW0rVXN4bFRXb2pvTzRNMUNjdTNjVnFRaWkvUzRoc1Z6ZEdlaDZueS9T
ckYwUS9ESnVaajFUUjl0RG9lai9aCnJFZWdFOEc5aFVtT081cGhwaFRUditLalM2TEVMc3RNazNs
TDRIZGhseXVscFJwbEF5WE5mQXcxaytHWHU4ZkEKNUF5dndvaE1ZRjZWaTN1dGJRK0NqdVp4cTJo
NFZxVlcwS1lpdFpOR1p3SzJ2Q3M2OHR4ODdvZnhUN1VMQVJsbgpuck45cStzRktXekh3MmlEcVlR
QlZvdmcxU0VlTklhVVlsTHgrcWtHKzdYQ0dNNFFoNTZXNUREVFdUMTBxUVQ2CnQ0VkVWRFJzcmZw
QzlWU2FZdDBXanJjSkp4ditvSEtTVUpib1Baaz0KPXVra0oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002cc000063f00da33--
