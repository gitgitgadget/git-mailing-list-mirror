Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B224676D
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853881; cv=pass; b=Ha2bntw6mDu90ewqSXsRv8xS+vJxenLdpErcyDC9GDfoklmcRvr19pUX3f0o7kD/UfgG1DB28qdE8dW84usflvs0fr+xkYdhHbOK2zoxOlHryvQhMs5IoC/REU41Pnmge7r0l6TPHEVPGim7FewLdr202AtLSlsaMRgpI00s3TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853881; c=relaxed/simple;
	bh=llQUeX7m0QQyZMl/jc5QQtQ/AntgdppLhDxhE6nD1Mg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuikRqoMUsPrZKrDz9q4h0wU1Nw1sdhBMpR4zK8Z0wBONeB0Jv82UqxSeJpPD9Ukdrdo4B2P4vKfDIlIgVtGe5CoIsdQXGJTewW2yq20qlZD+E1+zmNkpUSV7PinmF6a/7IO3E23QzjYXRPg3luRvHXv2vZuEuCDg7nFYOfNFtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGzIVRlf; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGzIVRlf"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5fdf6ad2517so2808407137.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 05:37:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771853879; cv=none;
        d=google.com; s=arc-20240605;
        b=fzJVYhyIVft8+ID5Z0GfYOIgYp1c6qLyx2yIIlMlqeMVrhHn+MrNXJte/umCJ6KK4C
         ZDxcBiH/IvPDNRZHXSnUSNCwNyzY61BQ1Ql/eq8WUSzThPLhanJRSXo5UURrpV/jQOgz
         i+8fZOL1k2FI1zForPDL7jGbPwvweg9fd2+zmRm1qsiPjsMyrzLC6ibtz+Qz90gNqtzF
         ZZ8OcjbOHJsrZbrOM7Oo3ufvbiX5AMp+DRGv0k+oafHxT/yBG2t0PJ0XGNnzCc4fR9bu
         Bev5GYHXlFEpupAexyjGROT0v60AYmWYexZwd2iRDkvsvId7lrTCKrmx44gv12AWb207
         9D5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=sMf+6abIqVzj55n9IrgOVmcCMVTx45/Dci4Cg80CEj8=;
        fh=CKannokU/QIGCzmRFZw2adWb+7uKitSIzDQ9xD/uq9c=;
        b=kPuRLLhYcmppcgXzuI4bE3wYCckFlRHZER1Ym/sfBludrJu8jx4j+bQ99laprJOj+p
         HfYzqxhjkZRtAalo5iCO3UI3wYhoQVr872l1Q1TXv0GrLUJQOJKlsPRZib6Fpbyc69EL
         sgAv9nvdvMKzkJWYpdyPbSDTh3RJzZEwoZ3Se7BZAnuTKGT1FembBfhAmPfxMqxBf7ur
         DB5An2DrMBd6LVJNFXFgIu+lLMTLH1Mfti4PRqkHJVXkoWYAPJrcIhYykeCmRbeWoXmR
         i3nOYqil+hoFAWiDS7fMB7irGZx6+gtWwFR0FMMNcOGQy0wQNnyar0BMZpjKl2mZX+8N
         WItg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771853879; x=1772458679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sMf+6abIqVzj55n9IrgOVmcCMVTx45/Dci4Cg80CEj8=;
        b=DGzIVRlfBezokHmtSi/ELtogzXnrSDZFMeJuf5HBPxgqo8G/4gZff4psuZZHJ9dGEK
         NV73vfmo1aj9CJt7XCqzWqGlmFwUmi3Qq8JqTIL0lCUybZttkUi5waCCwEwbuuluF7Yr
         PbBR/pzZe1DBERIJbMSKtMnZvxz3lgPAlx7H2Arr4UvkYty+1LAizoKPfe9+jY0wBIhs
         5UTBp+7GjsHLDMu8HaVNRs8Se19QwFNrJ+RRTveCCY7HL866i+tzlYh8B8BmZcSRSDZ3
         cIPKVMuTHH0PM+aREWUvnHDqqfYoSUB/Jh88BN7q3lf6mYVkiIE3efFVJ9JHa6caQCJY
         mMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771853879; x=1772458679;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMf+6abIqVzj55n9IrgOVmcCMVTx45/Dci4Cg80CEj8=;
        b=iGaGNHN5P4bcrLNYjLVmxKBXDtpIOPO8yLjggvia83sg9lGbRWOe8nevoLglzK47tz
         iaao9fjNSlrpJv1QBoUY3UzCKyqKr/nrzSctXm85TyjTY4omSJu7Rw6nfwrLR0XIQ7iM
         a24TUQbTBBrET15bKfgS3+8TrHv2O7Ej30OB6V1XVOdXoYtctDB9WcmXTbsTk3tzYPMW
         l21GNWulhSio8TJRShJMEcXXMKGkbSbv42f3xOi+c43v5O9gXTOfufNxMGukRelSFDZ1
         5/RER/+YrYyuzS4F4cUyu7d7JCbV1h4XTsaHLqs61LjzsSGl2rQ6jEgbXwlmpej/4Nd7
         16Tw==
X-Gm-Message-State: AOJu0Yz0djtdCPBWAlEKbfJpz1/Ey4lJQOR59Q+AJcWkmVZcAWffxugx
	rAQCpMdngBPNNxfKyJbZnjyLcb0ERhyRHF0WP85iDolw8nDLnaa03l7rdQjPO+awRkV21q40fhL
	+N6h/zA6KrQN8vknc7xYXUbjRwleUQ9I=
X-Gm-Gg: AZuq6aKyZDNKuPDjYR8kt4Aa+AIsUcx0C1bC5GLBAkL0nPk3dU6lMkTHX1KJF3EqaJR
	NUxRYbHOqSxCwtag551aeOBeRPlkuplV4MBL5OVfHptjtPbxvRLWiLVz6QP3zQnGrl4u4SXKRuV
	EbUGxkYxJZUEArPMEcKiQED32tW4d2+bciXrtdNAY1KMzCXbg19AiuUFy+9yFRmOkci/rxeaGQ9
	hDbioyLlsJg/zj/4cylrI+g6iFLomyO6HB49mqGxD+ci8TbrYXYFoEakOEEex9NbnPNVbDGxnhK
	+RZO6SqqBcMEBUMWkUFm+FJrYiOJM3hRnWqZPurk0w==
X-Received: by 2002:a05:6102:50a7:b0:5ef:248b:d533 with SMTP id
 ada2fe7eead31-5feb30c9ce5mr4553319137.31.1771853878698; Mon, 23 Feb 2026
 05:37:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 05:37:57 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 05:37:57 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aZwx6F-ZeQ-LZv1M@pks.im>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com> <aZwx6F-ZeQ-LZv1M@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Feb 2026 05:37:57 -0800
X-Gm-Features: AaiRm501KJofSan9wDF20t2y_CV4BhQmsj09p5ZVN00ffO89lV-uhrOFeiIzjwA
Message-ID: <CAOLa=ZQ2qaSbxaEfK-ngZUfM-WwPhiFF6wYRK68=0QJ9P-5BnA@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] refs: allow setting the reference directory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, toon@iotcl.com, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: multipart/mixed; boundary="00000000000008c1d1064b7de1aa"

--00000000000008c1d1064b7de1aa
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Feb 23, 2026 at 09:01:35AM +0100, Karthik Nayak wrote:
>> Changes in v8:
>> - Fix a typo/grammar in commit 4.
>> - In the final commits tests, avoid creating a file for text
>>   comparison.
>> - Link to v7: https://patch.msgid.link/20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com
>
> Thanks, I'm happy now with the current version based on the range-diff.
>
> Patrick

Thanks for the reviews.

--00000000000008c1d1064b7de1aa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 682f11088b4143a9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tY1dETVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMHpuREFDSnZzYmdGTGYwUnhHK3RUL28ySkhMM1AyNwpscnFIanZNazhO
UWs0OSsrWUtiL3dmdDlRV2hONFd0ZDlWUDhqN2xVY0t2WlgxakxwQ2NFUUNoT2J2QzVFYy9lCmpM
a3U3V0doSDNtYnMrOU9IZlFkVmZOTGk5SElNMDdMK0o5bmpjUUx6SEg0ekg5WEwwZStZSFIvR3px
akdkaHIKSXRTYjJQdy8zUnNWRnFRa3BxcWRBaWNwdzFSS1FvcElZSXJuV2hDbjRHdXIwb0dvdjA3
OXZkZzZ1d2lNU1plKwpvUHdqQVdTY0J0eDd6Y2xITTc4dXR5UjFHamptTTEyQTF4M2xWUlkxeVVG
TVNYWmNlaHBXQnZXbUZkamhuV2gxCjVtcWNENVk4a3BQWjZFcHpwNHJSU2hsNUlYUHRYMDUwbU5i
emtmbk9ERlA0Vm5UWHpvYzErL1hqM1BhZDJSUWQKSi9qUVFrRW5NRDdveTBWdVJnSGZEYWJ4NHN2
aDRxWVo0Qkt6b3dkRUR2QmcrdFRkQ1pFRjJrUk9lMnpnVU9EeApkQVhuMEpzY3RtU3E1M0xRWm80
TXdjUGtaK091ejF3L1h6VGxlUGpjaWpydklSRHNoenZ1YnBNODVMKzVUZ20rClRORHRLanAydzFV
N0FtdEhrSUdDVWxlN0F4MnpaODVRaDZOSDE0dz0KPXlib1kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000008c1d1064b7de1aa--
