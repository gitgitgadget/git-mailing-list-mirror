Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D367F1D54D1
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428114; cv=none; b=ofQvD6k9MLbQu/T8s8WP6ROF+65eyO2qrN9SZSm59koyU9vVXoEaGr5Rzfh2JjL+KsWOjTsIgIpINY+xZnoM6GjzljM7hk7WDOai51Ey9+LEXTNRdrqy9sI9oCTHFs58C5SaJ3+PyPd/xjtuOyx2sW/CK4763Jx9ne75PMJsB88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428114; c=relaxed/simple;
	bh=hEX+Nip1+f8UAhg9itQ/iXMEITCh5RpUs770S8V+SKc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvyPNSI3H7uQ1zltxkIR6LRkf17kwPdWTobVEJg5hEhoz4pOjZo4ooUFPyDaskuqctX+0z4/jgZHhamO+DxqG1Y1eMUM9+PhV1fTfoXstm2ht6d4LwJKdg63nED2/yXt3CU3gIB4QppWmEigjPbeeEgBRJ9au8hTQE8DSy7zYes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/5EK6VI; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/5EK6VI"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4affd0fb6adso1332819137.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734428111; x=1735032911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VekHBQgRxIi4ENaZYxmFFllwfwFm/1AbBPr0ME9hZxE=;
        b=F/5EK6VINixM+4g1fWzJyOgED1QB37ALd0hBoT5zMgDYGNvnRaXh6G485GtWuD6jQW
         65zVtZMVyhVaXP8aEyytuGkceZ+1VlL48qhjOnbRRWQuStywc4/KeChLVs4ljC/bogvg
         rNMTtAUpAP/CDhyR+N+8Ts4LIyj+NEPSnnwA5tzawzmQv+hpXcHMJiVk30IZoc0SvPir
         OF28qUAZRHQgNawHrDBEnb3/RL22B4qxKwx3iNFm69p+HO9frCqQ5KMShYt0pbU4FaTI
         ZDD+yueX+NInynHcpTyyx7lbzTw/9jGsiM1DudTWs/FOhZpqfQxnCdO0jRjN2mYZs0/J
         26CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734428111; x=1735032911;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VekHBQgRxIi4ENaZYxmFFllwfwFm/1AbBPr0ME9hZxE=;
        b=lkkhcUQYZsMAuwb+gTA/NxWst5TWR7W0A0YYuq3yVmaENAFIxqHC6f31yyHFdhVga1
         5Fo15dV4SdP60NKm3NnoVTN5TZYvfS33dJne52+CUBt1AcWgezvCNhgrCc3qp0/4YXTp
         FK+ch/qFWa4e5g5V6G5lmkGqxy/UOglFHrFfMGnEj5tAkc+gm4WcQaxVbBcVTGHPcbxv
         h1fjvWYKpACSxXdSkHYY8otfkXzKX2NogaAdMmjwlYpw8mkNNygTa1ynYCo/KFMSOO0m
         cDC66LhNOPJ6YAXOKjU/wm2xxWy+gbJDElNPWIn3ltqM8OZGIhpCLwMo4+3jR3wQeulH
         Zlww==
X-Gm-Message-State: AOJu0Yymia7nZCTbbCmj170EaqA8mSc1zfm+vTbVMDE9OCa6E58MoGDn
	wPat46pGAu0eL5AgixDo3bDPvSkpQ4XGOxjmsVFrbhi2swNhTwvuAdv2Bey+T/TI1Be+psBq4FS
	49TjkKtk+KB/Ngw28+M3AzA/xlcIsvu16
X-Gm-Gg: ASbGncu0f9DZ7TpLPUWlob9+pv63ihBg34sOeoKEjuOTkdpUD8wshdFXF6rM/JDdllJ
	oOGdcTuTA1P0V3YqLTXAqSia3pNRtU0jDgBrOPylkHYuk1VtmqiRhvIrC5UiA6Eoguz5OOTnh
X-Google-Smtp-Source: AGHT+IH9t8oMnGFIexajHQdq9dvAo8QgHCy4RO770oaWIbNkK0B6H/NptfhotIvgvRlVAmUy5qfitc5yo/z+mhn/suw=
X-Received: by 2002:a05:6102:3ed4:b0:4af:5972:d593 with SMTP id
 ada2fe7eead31-4b25dae9addmr15931223137.17.1734428111360; Tue, 17 Dec 2024
 01:35:11 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 01:35:10 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Z2EhZpL5V0LlhEvj@pks.im>
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
 <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com> <Z2EhZpL5V0LlhEvj@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Dec 2024 01:35:10 -0800
Message-ID: <CAOLa=ZSzGk1FqiciTktTgv4J1uH6CW6VpbxXOXdKmrXJtR6iyQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] refs: add reflog support to `git refs migrate`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000007770220629740386"

--0000000000007770220629740386
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Dec 16, 2024 at 05:44:25PM +0100, Karthik Nayak wrote:
>> Changes in v4:
>> - Fix broken tests, due to two reasons in patch 8/8:
>>   - The `index` field in `reflog_migration_data` wasn't initialized to
>>     0. This specifically doesn't break the test, but causes undefined
>>     behavior. Fix this by using designated initializers.
>>   - The strbuf within `migration_data` wasn't initialized when the flow
>>     exited early, causing memory leaks. Fix this too by using designated
>>     initializers.
>> - Thanks to Junio for reporting and Patrick for helping shed some light
>>   on these broken tests.
>> - Link to v3: https://lore.kernel.org/r/20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com
>
> The range-diff looks as expected, so this version of the series looks
> good to me. Thanks!
>
> Patrick

Thanks Patrick for your review!

--0000000000007770220629740386
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d7ce19cd94133025_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kaFJjb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK21sQy85RUg0U1BPRjNqZFFqK1kxeUh0a0VIeHd6eApwQmpPR2FLSUY3
d21STFUzVzF0a20xOUhPcXFtM1lSRTlBdzVxQkZKdFRXNnJ4ZXpLeENhYUw5T3U3SCtUNlFuCkJ2
VXgxT3ArL3NaNkRjazdRVHdRRVJSaGcyTEFMZXF5ZU1WaTNObGVWaVM4WjFaK3JMODdJb0dXcGFN
SWhZRisKQmtzZHRETE9OUktzcXFObE5GVE5HblZFUnV6Yk1pcTZBVHVIN2pJWnJBMjhGNjBhTm5P
RWY2a3FiZGVEVW5WTAorZS9JUGcyZWVnWWkvS2tIQmZTcDhnMTI4aUNUWkNrL2pRR0wyMlNQZHhK
V3FxQlhmK1hOWDN5QVk1NFhlTVVOClFxc1AzV1lHaFBtRFdBeUVTMitKRG00K2o3VTR3Mk44ejlh
Z0xYTG9aajBGbTl0Z3FHSlBvMWpuaGd2Z0ZKR0wKWkdvMHYxelh3TTV4cUJ4R1VrMkh1TFpKQ1ZX
ZlNMejlRbzBBcXJHVXlkdXY5Z0wydTc4dVBYNkVzV2R5bUtOUAphVlpiZC9tWW9weVZuWFk4MVQ4
SDhOdnE3KytRZHQzbnh4c0VYcE5FdjFiQnhXTnRmSkh5OC9IZFVZMzlqa01xCkgycVBRTkJJOFNC
aUJzcGM3RTQ2VWhGT00ybk9OOXhNMDNQM2hzWT0KPTNuQ2MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007770220629740386--
