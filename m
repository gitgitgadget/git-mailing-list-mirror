Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C8165F1A
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937572; cv=none; b=nOt3NXBrLIpW3mxTfqcqtXZTwZ9+mPTg7FoJG9eY8qzLt9hejpGieNlOEF59I0h6j/Se8nTgzmR7YNRpEoLZj8UBCzGeyfapbrYCkWl+uZREIzIsfuRvCae74KLnK+8JS0F4gz2N3DF6LgYCSi1Q9TKe843K+18p6/2FFFSo8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937572; c=relaxed/simple;
	bh=WZFQu9l0rk65tMbcrRF8nMOwLmQbazOx41WBAnU/KhA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8lBW9jAqcIY37wkiWb8BNmQdWPw46ipKwH+G2C1O0r+EHg0vQc1p+yPTFlcJ8CWFv2ZrItPQMNbfSqCHez9VIEvhtcRogfuWXMR5F9iweySh5vJh2GKe7LmZsg0nABhUxRrGDp/tcypTSoGCX2a7sR9aWvktO3yRD72sEU2vOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m678tfdU; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m678tfdU"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5dbe6304b79so251873137.3
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 00:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762937569; x=1763542369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zP3kBl38YkirJETIPOWtDIkmwqPFrr1vMq/CyisCqkI=;
        b=m678tfdUyKmDwP/lHn2GYUDx0h71j0rn5s0f9UTY/pOkYgR5puC/u738X1EjY+EjOc
         Xjofi7+xLbUKJUAUmq52IWLlbUS5So4F8Jpe2H8QkNhui1nsftOsrRn2ROsZKL/6bAFY
         pMowa1mlqGJTMl5mtAJdtWh6bHNSDrjki3jdBh2kozF8GqadYOdHT7Wog4f7gB79BerA
         KzDYWnMlFdub3sCRIG+gwr5c/5LkPbSLbqkvhcQ2eBJUZRXHRCPS7tiKre9G74SNXfAV
         ApCm3MYIyCHKvRMMW+pA5XUZeIvqEXeW3TF6iNJJXsuRadOWljMjmpXi38/lfssf0vT0
         GFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937569; x=1763542369;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zP3kBl38YkirJETIPOWtDIkmwqPFrr1vMq/CyisCqkI=;
        b=SFX2KEc7PrcjnbOmCYDp8ZnhIHOD6G2l6hzXmICoLjxyE+tMu7ITuD6B2FRWgoJp5Z
         nTGfgkks//JIJhw0Yh9j8ugvlDbI7ittN4ObBNcHYjJ4WJ/nQBdSAUW/TCoY+Kjh7rHN
         IbcuXt97MqjbmA0PVRTdVDlVAv8hZ95DWL67C97wiiwpLnr7igcKPWKCbcegLUeaipjH
         MeMEtoy2wrRayeOBfc87G7f8ncEYBnYOH0Kekn5+hXf3ZhB7tZXkav2edkOiYCpAdIiv
         qLxFwKlw6339ls1vepGePvOORS8i+C4T0y+t4dLt/nSw0cPxVR1RqT83HgrdGDe77nqA
         hCRQ==
X-Gm-Message-State: AOJu0YySeHrKka0LlIHBltpYLrTeYscFTRZ9KEmeKpbEIdOajaCd2ELF
	OJvEq7po+Gv7Cu1b2uoRkdV3Y0/zmiRlzdx4WM7h02R2jHPRlL0gsW4Oh4rfgIN3+9103pDBPIG
	ZbB0hCFqnQtgsVO5KzZUYeOQ+EqBzcRQ=
X-Gm-Gg: ASbGnctKsRMc8USeNCzFQBg/ThXYYZtp+MTdGKtjNrskUTlQb9MLpfBFkkCx0dnTD81
	xBNwvr+c6At5E0j/7zNtqvG5ukt7FUP6pCa7DWD+eT8zpAGmEYfgneigomL8m3Qb1gXSxycTl9+
	9uZwu1G9RiqGAfV8X/iSoEZiHPM4QHfrbJaE0Tyjtw8DJI6phzYQj5gq7KihDDyN4AVVBRs3Fwg
	8ndhvNa0KPJ1fCKSjL0GFU6GrWSp9DyUM8MEvzc73vUvCZri4ejnhnWrGI=
X-Google-Smtp-Source: AGHT+IFtfOmCYcYiWcMUHglDK2YIBxV7tOBxY2KPFhTj2PPYIUUUBcvrcGTeBozZj8N1d8tiD+t481t61j4km9Sjpto=
X-Received: by 2002:a05:6102:630e:20b0:5dd:b317:b433 with SMTP id
 ada2fe7eead31-5de07d2225fmr366593137.9.1762937568894; Wed, 12 Nov 2025
 00:52:48 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Nov 2025 00:52:47 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Nov 2025 00:52:47 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aRQmVPe1RsFcr4hz@pks.im>
References: <20251111-fix-tags-not-fetching-v4-0-185d836ec62a@gmail.com>
 <20251111-fix-tags-not-fetching-v4-2-185d836ec62a@gmail.com> <aRQmVPe1RsFcr4hz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Nov 2025 00:52:47 -0800
X-Gm-Features: AWmQ_bnvY-2hbfR6XjLFip2EuCGCHA6A1_-lzRj299_z_c-3hE04xG7w5_YVkFU
Message-ID: <CAOLa=ZQAQ1dtstD+uqh=vzV+w5q2uWsnZkzqucHuj_W_VL931A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] fetch: fix non-conflicting tags not being committed
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, David Bohman <debohman@gmail.com>, jltobler@gmail.com, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000008e3e7f064361e3dd"

--0000000000008e3e7f064361e3dd
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Nov 11, 2025 at 02:27:08PM +0100, Karthik Nayak wrote:
>> The cleanup section is reached with `retcode` set in several scenarios:
>>
>>    - `truncate_fetch_head()` and `open_fetch_head()` both set `retcode`
>>      before the transaction is created, so no commit is attempted.
>>
>>    - `prune_refs()` sets `retcode` after creating the transaction, so
>>      the commit will now proceed. Before batched updates, `prune_refs()`
>>      created its own transaction internally with all-or-nothing
>>      semantics. This was done since all deletions were made without an
>>      old OID, which meant they were assumed to never fail. This change
>>      allows partial deletions to succeed, consistent with how other
>>      reference updates behave during fetch.
>
> Okay, so we do have a change in behaviour for `prune_refs()`. I guess
> the reasoning is sound, but I was wondering why we don't have a test for
> this.
>
> I guess the reason is that, as you said, it should in theory always
> succeed. But what if with the "files" backend one of the refs that we're
> about to prune was locked? Would that be a case where we continue with
> pruning the remaining refs now?
>

I was thinking of concurrent writes to lock the reference, and didn't
think of a nice way to do this. Your solution works and is indeed better.

I started writing the test and realized that the pruning happens before
we create the batched updates transaction. So I was _wrong_ and there is
no change for `prune_refs()` either, as the transaction is never defined
at this stage. Will amend and send in a new version.

> Thanks!
>
> Patrick

--0000000000008e3e7f064361e3dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a147cf677317adf8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rVVN0MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMElrQy80Mit3WXFLbjUzVTc5ZGVYa2FMWkN1VmZ1bQpSbWk3YzlCSFVW
Y3B1YjMxWE03Tk0zZzB5ZkVRM2kwV0tybi9mY0RxdnRKR1B5UEtlN2dOUHdVdHBzYXRDZFF6CnlZ
TVNVTnlOSUVFaTgvWmQwU2dnK2QrTSthRHEwVmhkSXBLU3p0MStkUkpvdEhkeEhVcWR5dTVvTXlZ
bEZjMzQKNXBPMXpjeUtVTk9pZm1WdVk4S1U4NDNRamRLYXEwdDlVam85d3VYb3dMVEhobDRMbERO
ZFc1cXBmeEZDWDZxdwpBbSswQjdZczhheGppYXhxZXhmRktGQUlZZ1NuSDB5eGNKK28raFFUTmxI
UCs3aDc5L0ZBUjd0dWNYbUNRY0N6CmdSWURhaUpmVGNuajlLaTVEVzZDdlA3NmE2YzZoeHc1dzNy
S2hWREFGTmw3cDZGZXF5dzZXd0xoQXd6MnlkcGUKRjFXRmFrS2F5SlFsVGVPU1IvYzlqUEE2WS9n
YUFUeCtvVTNFZnBNSHFva3FSNE42NnRuTlZ0Vm9rblBvY2pZRgpqaEdBTjJSZWJTSTZZUy95U3Nj
L2xSa1hjaXNCdERjaDRJUVBEOW1uTmo5dUN6ODBOVTlIZWtTYlh6dFl6ZmI1Clg2VTQrMlhsaFJk
VlJDYnViWUhQeXprU3ZRME5vUnpwM25BdXVqYz0KPW5RYlYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008e3e7f064361e3dd--
