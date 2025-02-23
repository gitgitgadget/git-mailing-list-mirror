Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE223CEF0
	for <git@vger.kernel.org>; Sun, 23 Feb 2025 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740342621; cv=none; b=N1GPznaYUzwt1Ex16dYwA9601b8pcxq2w0jRowpAP7vU8I2Q4FZAevlRoKv1MqHwTNvhCUbRBsxevslxk0ipKR4EkZ+ssWvEJ7cA1jQL9OeLaBiybgUOj0UdMs4FUgpcK2UaTjqUHZtB3Ip+0BbZAiITVHG7QDeYkjTFZrXyvtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740342621; c=relaxed/simple;
	bh=hxH+De7V01Zs2JQvxK0/ajbg1aA3PRSGqJLX5/NWqK4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgiVamSYXmFfQ88+ZyFd18WTVc+pBJ6xuOovfYElHcz/MhPTLJ5nSiwlaOYQxz45Z4t1kED8PaGzdOzCMyaAcu4ooyoXZbrQZSYYRzFYpqApEq/G4k2iDBtTziL9666s4WFcCJI+Sbskere6+S6cXa/y1RkG7tOQGSH6BmYNg+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JX1ol4bD; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX1ol4bD"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86112ab1ad4so1035731241.1
        for <git@vger.kernel.org>; Sun, 23 Feb 2025 12:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740342618; x=1740947418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zDlZeviGH5zMhVeiVZPGiF4U58bKX9J+euXqfny1Xzs=;
        b=JX1ol4bDusrEJ0JHCcS6jqPiwPlmdPe5cXWO0QPOa0Ha0wcebyowLc4DLJXoYYSb1H
         2nW9ZWDth5D+ACUcnNMQ90QQmLaOc5TFjrOeCdUHd07jIG4WGnPdb6/aXtHssqrj79Dp
         RCB7uY1t2zZMJKxz+yIwpZo1NWxgi1kfPyOVpHlK88TeEnCLURegLSuTndrhjgpwORR2
         HAaZDw+ae9Q6irEBa4srF1NiDYxFNKLbesSSjg9s8nUHeitMlxBH3FgOVeQHaN5mgUMN
         5V7AQ1QrJqyPk3fIyRfwHCZI+63PihZVi7oE+JsqNpNBaQ93Rde0UP70j1iK8arMNMrh
         Ub2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740342618; x=1740947418;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDlZeviGH5zMhVeiVZPGiF4U58bKX9J+euXqfny1Xzs=;
        b=CIrS8dciwzk5b2I9k6rm/dQgDIhnC5ssk3O4pLcx6gKnILPq8QNFGb+1SGwaOZaDg/
         4DhwZI7LX1Wf3+TDOuVPPNkiDpfq56fxyIMy84Eqt5ZfxwgB9u9wLZkYVMIqBPfP+Obm
         iCjxMkzmHWou92Ql3qDqrruCMjsS+4KsShOPt4ntwRU0EQ1zmC9CDp4xur5Hk+t3U/3r
         xf4/tLSc5CI4pqulauv5a+/Xdw69XK5FXFPymEcjtfxnoLSqEP2aCGgqgKqN6YwBg4T2
         OfLYEHS0sY8HW8q+fMhIn+JDcOZFlh0N2zApxLL0lDLtN67+GcFURhl6vAxQn1whbW6j
         RYSg==
X-Gm-Message-State: AOJu0Yyc6i8TQrBD4ZoZNvbATlJbgf/fUGKIXPZ8qils+j3tI9oh1kxS
	QPuZbudoLiPbN6a7urwtQa39Eu8qEHJ0bp/wodmX8Cizv2/oHr26si4gS+UkzkC5q6XS4/qJWE9
	wyAEUXd+9q/Nd4turw0brtpPyY3TxvAac
X-Gm-Gg: ASbGncv0G1SzD/A8RBgNctp3aeEAbrlzVno9kw8jG8e3LmEUiSAv/sdaPJnmX3ZLqz4
	0n/qLu2Yza2v2rYZhf1UJz5+dj35Kt4eqyvalZlkJQyQYCzjRhzxpG9QiSbMYRUSbNQx+P71i7x
	oNuCGPkPMgWLD3RYw5msWbX7/rQyYMv1osm7OBGkk38Q==
X-Google-Smtp-Source: AGHT+IFeXdli58bxI7ORPG1aywwrSDmSRU52N0vgMo9+tyhh2FgnjpxDhnHOXGqyhXW8VdyfIq4dTFWYHi8michvgq8=
X-Received: by 2002:a05:6102:e13:b0:4ba:95f1:cc83 with SMTP id
 ada2fe7eead31-4bfc0192077mr5311865137.16.1740342618610; Sun, 23 Feb 2025
 12:30:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 23 Feb 2025 12:30:17 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq8qpzb2vb.fsf@gitster.g>
References: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
 <20250221100423.91075-1-karthik.188@gmail.com> <xmqq8qpzb2vb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Feb 2025 12:30:17 -0800
X-Gm-Features: AWEUYZluYMrarToY4y7IwjcyI355ISOTOs8LVaQxZ_VkqvSv_e0gefCKXlz2Epw
Message-ID: <CAOLa=ZTTMZVq-2xWJtHXOcro7vd68SV7kHYXvChxFgDs1SL34Q@mail.gmail.com>
Subject: Re: [PATCH v5] builtin/refs: add '--no-reflog' flag to drop reflogs
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, toon@iotcl.com
Content-Type: multipart/mixed; boundary="000000000000920a89062ed51784"

--000000000000920a89062ed51784
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The "git refs migrate" subcommand converts the backend used for ref
>> storage. It always migrates reflog data as well as refs. Introduce an
>> option to exclude reflogs from migration, allowing them to be discarded
>> when they are unnecessary.
>>
>> This is particularly useful in server-side repositories, where reflogs
>> are typically not expected. However, some repositories may still have
>> them due to historical reasons, such as bugs, misconfigurations, or
>> administrative decisions to enable reflogs for debugging. In such
>> repositories, it would be optimal to drop reflogs during the migration.
>>
>> To address this, introduce the '--no-reflog' flag, which prevents reflog
>> migration. When this flag is used, reflogs from the original reference
>> backend are migrated. Since only the new reference backend remains in
>> the repository, all previous reflogs are permanently discarded.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Helped-by: Patrick Steinhardt <ps@pks.im>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  Documentation/git-refs.txt | 11 ++++++++---
>>  builtin/refs.c             |  3 +++
>>  refs.c                     |  8 +++++---
>>  refs.h                     |  5 ++++-
>>  t/t1460-refs-migrate.sh    | 28 ++++++++++++++++++++++++----
>>  5 files changed, 44 insertions(+), 11 deletions(-)
>>
>> Changes in v5:
>> - Add missing documentation and cleanup the commit message.
>> - I also see that 'git-refs.txt' in master has been renamed to 'git-refs.adoc',
>>   but I'm going to avoid rebasing on latest master, since the resolution is
>>   quite simple here. Happy to do it if needed.
>
> It is a good rule of thumb to refrain from rebasing when in doubt.
>
> Shall we declare victory and mark the topic for 'next' by now?
>
> Thanks.

That would be nice!

Thanks

--000000000000920a89062ed51784
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e4b45be548e5fad_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lN2hWUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMTltQy85Q2lheFZ3UlVGZG9vTWpHaHExQVQyNHBtRApaK2ZUMTRlSjdW
cUhIUUZ3Q2p1djZkYzZvNkhuQ2NtaWFaQ0MzVWlJNXppSTJ2UlE5em9vUkJRempuOVQzNmx0CmdH
YW5BckM2a0JWQkNTS3MyUVA5VzgxNHlWSzBiQkpjL09VTFlQSmxaV2dRUnBRUU1vS1VubUdMQkZX
QnU2SEIKcFJ0ZDR2Q09xNkpTTWpvUWQyWjFoaDlVZXJxb0FOdHUvYkFnSzVQUEwvKzNsdGxMQXhm
VkdycmFaWCthN0IxZwpHWHFZdDZ4eFpiWEdKbEdTM2N3eW1iaVc5U1hrdG1BZVZaeFBMQmoySXkz
UFJqSXBXYjR4M0R6SUhjMSswTVBRCit5NmhLUkpVOTJEK2pTb29EVzlFN3lRNnRqN2RSSVN6WU9o
L1JyVmszS2J5YzVPVStQRmNQWVE0dWhHeE04UnUKMzBibUh0UWJ3QVIvOHllQlZQY05qMnNTblpE
SlZCaHZqeG8venU1b1BQOG9aUnFpUWNrZ3VuTG1RbG56WDIyNQozdVg5VjRmM2RJZDZlTlpLQXdr
V080YS8zRktqMFJPL3I3d1BwU3p0b1JoSHE3SU4zd2s3RW5IcTBiNUZ4RzNVCkxzM3Voa3VwK3BZ
WVUyOVBya29raks2anZYRkpEaWQyNWdjZHY1az0KPUp6cXUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000920a89062ed51784--
