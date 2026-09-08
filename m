Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032339B978
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859332; cv=pass; b=OeJV7DCDh1KV8XlicglYomiL94ZP73jZl5Z6EEx2d357KvXt6+IBtHPdH2pRyOzy8JCCUNGGEMQ2JhLs5mELaPpl9hMWpTSVdkfUMAfFTc2sf2aLd4rfT91kOmQ4XfBQtEYCQE5EuqxqQ7DHyM6jxQIXrzXz6pi/TIF4CBZg/1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859332; c=relaxed/simple;
	bh=L9E4FjDY0mUkvOYwL64i53k/pee3J3gIqhQXT8Gthc0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEMmbbUksnIZNFD7jqk30SdbKBCrggtx6V311KIWwJhb7VhyJYAks9di7uXlJFtzO3o4iaObPhqUrDGx3WVWx1a8QaLVYt7UCHr7hkWkW/Mw0o1O/EP/pnx+pZC8A/iijILmGXUnY/3tgSosyrOBwLcZ0V1H4tYc+GGR4pqoEps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmeBqaP0; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmeBqaP0"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5c6670fd413so4227573e0c.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 02:22:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788859329; cv=none;
        d=google.com; s=arc-20260327;
        b=ddsvqHwR5mzqqNkWojee7FuhnwhXt9W7yxCCc8Faoo/PrxsMtVwEWHj0v6uoYSWbS9
         MzdpinrLt8udZSlK8ydkRn9pxWazQznfwsxmIKXqyodN5IgGYUDPZnF2obW0EnloyRcY
         5xH3kmfxoRUvrhn39R3FXonBU/NliMqckTpthaLg4p+pA7dvOoEatdcHX6YS27JVRyWN
         bOoUgKjHsubDQ4sHDx70WMzhil2RaM+hxb82i6m2fksbQJ+dLpt55CZxT86K7d18/iqR
         MPLaxWtfj1EYoxs780E54PUJSIs0DusDVQBoM1uV7GRN00ZM5xaLPJUCAMTD/JlLMKdF
         HAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=BcXp9BA3Qv8nmWf4aFepWlYDEnpn1nNV/J6BwNWu5Ks=;
        fh=D4uDqIpMAU76UF3y7kLhifPMaIKyWsi4/hRzYZ8Ccvc=;
        b=Y6U+2p9UKisnlNE7tHcqku6+eb4LBjsgOg3nKnaY5hgSyAN5XmK+nGcaQNmug9vaoF
         E7UhWzHoitC4yMKnPDVU6B7wNzoemWHdfCFv8MfLv8UAHaIAWdsBq2x0CYLXO2SCgICy
         rouX/6nmk75vo2YYrzhdpCVY8q2HPE57eHoIJaKGaT6+BQHGNfnXQWgqMARsB+s2ZObm
         e7x1IJ1U4i2/m/OEiMR3izgi6MlhojP20625B1vW2AvTAPVdlGI+TSWnRn5T+pLPdKpM
         ZkYzC0qaG0VLlCUOfdOLd+mvZS2GUIMTF2O8k9JTzzxXKzDVaaspTgd4XQxuX2dV99iH
         5Q1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788859329; x=1789464129; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BcXp9BA3Qv8nmWf4aFepWlYDEnpn1nNV/J6BwNWu5Ks=;
        b=fmeBqaP0q/D/j+St6RmtQJ7p77Na5BP/aSqfiX6VxQKxaCT2XD09ICCpczaqn2oKjm
         ktIwVDpUV7dqaDFXX850gDl3KKTcpvTM70mqyYcGy0uzZvu9oQd37jVmYKLZQr2kMZLP
         mZGiRHs9REhsM1/YKvA1i+81c/ogesS04KCf1MkfPODJWXrVtdYBT4u9okfPH6gONg6H
         aS7dI2qj3C11b0ALCF9ASuR4RVMzd80qxAnGpfVy17YDMMobsitNZwA58Wz5vxr+hias
         S67KIhMcHKe+rVceBOkhnXvyBXWTCB5Tb8EiaxiJAn13Xv+7yZb3ZmOYeUt+KkYD/dLv
         0n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788859329; x=1789464129;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BcXp9BA3Qv8nmWf4aFepWlYDEnpn1nNV/J6BwNWu5Ks=;
        b=NMp42OOMSwenaNqu3xpgoTdsJlRnQfyNjG6HvQcuqTXUhAHl5IOUvlTUPD8N7CCKck
         xGgolmnWtQ2ZJoMGQRaIZ+wmQb57zGojQeAgZSFSYFuMAlOM1sZ+wOLMGev5gj9STJwu
         0W7cZV9uQZ7RU9X9sOyLqr2+F9pLCaV0bHc2LtfO7Fsgc3QBINYKB1Od0KUZXNy/bmDo
         FwFt7Hgt1XRgyHfCKyq1/0+g90kjXrIkp5TAdF5+UDxd3ErgeVFB+2h+/9ttNOJwis8s
         m8ufYLtG6dG231I9k7J0qNa6ahCSWVL0Dp2z8YGA3qoo5c7B/ANt+4hQqQplDLRktB1F
         oWeg==
X-Gm-Message-State: AFuF++mEJwnwLcR9OvSygWtxy8qKH3tGauKQe/iIGAmevlRFtS4JaHrw
	Q1goVVvCnBwXbd1PvNQawhGzVAbSb4xjrWq8NC8L3Uplmj5015TmV+h8Tz1GUCqzHzZdLjwkFUV
	p7DRbjUi7/2KINCkDqj4ff+GTVelDKPU=
X-Gm-Gg: AYBFou1Pcwo95Vm+S/VCugD6Ya5OEFEsOVO8Vr8toLvJSmLhn6WVA9j+H/gLl3m2Qyz
	BqNnLE9kzaxxX4WYsczSjcQlyeDG5c2eEcxEkcCALiV4VFQpXrsbW1kiF48kFBhYSSY07m5UPHH
	MQf/uKwuI2XCevJRzTdXQMyLo/0JyYBdMKyZxAEopALrwJPFm/SPsc03N6BrFfDafRygL9Oe9Pf
	AZCWdECs1hPayWig9poPtO+RMfUaOVlf6kbBB6WjQfsMkGgNXhdewvmLpUzpLkLT28SdE2GRnOJ
	2j+r7UeRsbVbG3BUj8quhRWWEe8z8Q1nc5rvIXo0r6SkaHCEa8Ecw39uS//oiTyIeuoious9Cca
	FRg==
X-Received: by 2002:a05:6102:cb:b0:784:a925:3f0c with SMTP id
 ada2fe7eead31-78a2ea9acfcmr5989636137.0.1788859329637; Tue, 08 Sep 2026
 02:22:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 02:22:08 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 02:22:08 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqv78g22ys.fsf@gitster.g>
References: <20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com>
 <20260904-758-introduce-hook-v7-2-6c66f0a3a572@gmail.com> <xmqqv78g22ys.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Sep 2026 02:22:08 -0700
X-Gm-Features: AcwNN1XgNfpJZHEXOH6LugX2VysHfvRVbFIFRYUVayTTYl88Be8ijWGLvRh-gDo
Message-ID: <CAOLa=ZSBqQ2P60VKBcRBekbug=4NiEj2kAmfUcZKK-GDnzSPUw@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] receive-pack: drop static variables to track
 report status version
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="000000000000e58c9d065af54410"

--000000000000e58c9d065af54410
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +enum report_status_version {
>> +	REPORT_STATUS_UNKOWN = 0,
>
> Missing 'N'?

Sigh! Not the first time for me with this word. Will fix.

--000000000000e58c9d065af54410
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d505c6864ba7ade8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xZjA3NFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMHRKREFDREgvVlpqbmFDdVJIbjkzc083cUVDRUV0NwpPbFpjSUFPbVFV
ZVlsMTRtMVVHdFV5TzhvdjBneUFDbjRMNjUrNlNpWlFRN0V4cWRBU0JudU1EUTFWK0ROWSt4ClFl
VzAwbFhkSjZaaWg5MWtSS09PNkMzVXliY1lmYkQxUEhadStsVnBpeEJmMG1KTXpiZTU5U3UwNG9F
ZnlYVzgKbFNXZkVQZFpJSkFhaFliSWNpSHVtTEtDMFIzUnA5SG1VWUNydVJyc1poVWtBOU9mZ0NM
eUxETFJIYVBUQ3YybQorUzdhS0h5MDByZ2RELzh6SkNBNjBlaHB4RTlVSUN0bzdQYWhSdVJxSEc5
L0RlMnZSQi9FV3ZtY09GTnJDNlFZCjB2TWUvdDUwUDlIWTdpSE1YNzc5YzFMOXM0eiswNy9saTEw
eTd5VVloZWs4V0txbmlvNmordnlLQnluZmR3bWgKT0Z4U3IyNXJSd3ZnYndZNmVMdHJOQXJvL3h5
UTVqSGVHNVZxUjBJY0w5UFJ6UGtGTElKQ1pXd2VEMkYrK1FaWgowN3Mycms1RUFxS1ZVYmhqMHQz
ZXZadmliallCTlJyT3h3NWNMRFRNTmR4ZUl3bThSdWRUYzBvUEVUMzU0ZUFjClVMQ3M2YkRieWVn
eHRYc1lGbjZCNE81L2Y1LzRwdm9lRWJjbDQxND0KPWhUSFcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e58c9d065af54410--
