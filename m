Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833EBBA34
	for <git@vger.kernel.org>; Wed,  7 May 2025 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746578877; cv=none; b=X1HGh21ABpR9F2YsqvFnRHtpZfoof8tbjNZqrePLpSKUb84yx1P4VdDzJVMmVMaadVs65Sap8N1PcI9hXGOGBFMsbKVHU9H5vGH6ozRZR1jT4tql+udaVHL0k3HCIQp1Doi2YekoEqQH+L1MQMiDrKGBl4SntGCtRlIvBOsSXvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746578877; c=relaxed/simple;
	bh=qd0gWfbLZmR58SHWILsy74olBch5IcB22HMc067FLnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lLcgfBU3sJcPV5EUi9+J7l4ppyBeCWtQnD/0EcnH/6AK3rB2S504y7OSzPYHRNtiyoiG+ySL1b+kooRCf2Vt/+MgA1TXdhUujGbMOpd1zv3bOsZ4aHWGW78SHskvhdHskNQX/12OhFEnEBDYzjI/23Ekf1gJRiP+mNntvfr0U1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN6aoOwV; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN6aoOwV"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e63a159525bso5169995276.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 17:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746578874; x=1747183674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qd0gWfbLZmR58SHWILsy74olBch5IcB22HMc067FLnQ=;
        b=QN6aoOwVdjdPlOYmKIwy8zafrJibIVUhE2GYSppTfATpb/uo1+MTm6IeG/Hh7HxIVM
         gj9jl8sJ/Kotqu9MQHmpLyKbvtVE9AZGjRXCyJsmK2hIMZhdKnbdWyeUSIrq3w6rDB4S
         AucXy19IIJjh4nHnAZXnv6HUtPssjLqU/FVvGV9c/0zFeISSVkBeB+FYVHLsrwmQbTMq
         LRokzAls1uxZncU7s9FWWa/Wy58GQSBGohDMxJyBo5q4pLhGeJRpPoS92BvhIcAsm29Q
         Vlh1S+XClOONg/KYPTd/w7/tKcsc0PbQ/QcZVH6+fAbk4FQWe7KFmZYy7eA340fXp1Vb
         60Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746578874; x=1747183674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qd0gWfbLZmR58SHWILsy74olBch5IcB22HMc067FLnQ=;
        b=ZlMUs7gnxWrkufFOAGhXaseSxZS9YlornuJWmDG+C3CEbQEUHJE2BhDab044doetuv
         iYRavSBS6i7fruKgJO41kLwYuXIImgutjjfQSS1Zx0d9dfMNmFH16C2xTmiC1r9wsP2n
         LF1kf+/LMM9waD7LbT8WzE6a+ExQOHlku2amuIXNtR6C4zUW6YN4ucuQkXAARp6qgIEo
         pKtXuVyyz4c4IeQRk6pV9rUwDIScw6XMi68sXY79w7Eu5KqMrOkTg/A9ZSZnn3wkqgCB
         opoTzggDJhBWiwS4d+ZH7WwH6zIX46US6hpwy03xDdxv59tL/eGumndyRWGP58jCgfDH
         wjsg==
X-Forwarded-Encrypted: i=1; AJvYcCW88VziG9oNXKiWq9OC/mg/23xSoCmOizfrxyj1UPP9HhliTg9bIviW2RFZDoQJuvm/tQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAqpsbsOOuK7O759FSVwRf6yylf9Wn5+bR4Sh+x/PVoOhUrVE
	myEi1AFde9i0QPKXyU9l1v+8k/1BfyZSu2T15ueYfEBSylr3qT/rTYXFDQ==
X-Gm-Gg: ASbGncuG/LYX7r+8iGezBzDN9aaEN3vtXKAQzq9fwb7OFe+ZZbPLCnpQo8v0EuJy208
	6im1T3oDf7NQa/npgcXxqJdN0LWGder+jFC7YU2HDY6OJHbNZejKtaJuUmiwoCDdedA6UsH+7ZK
	l/rfEQeFsh1puaYLMLyFho9jUt1XP3vJbPS7hTple1ODdcO989jDDJFwL+ZSw7Mhh26hUbKf4xv
	k8a1kihQ2QJvBD9RXvtE31Fp3cFJ/o9AKjdxXCZnyvOPbeKbuM/nkFuSvJB9pu/EMOMi3vTrEuf
	sDiIAUOfvdHewtwr7nLs4lQiwaVGqF3ieKSWfnk8sPdGRkOAOrqRF+joaQJkgaid6B6pWUviY+F
	DYUGS+I9OV16rEB+GXcJzIGHuFYPw
X-Google-Smtp-Source: AGHT+IFAhfjKGzzXlzUxmVEKng6MB8MXwKcjFlAoF5LNcTaBvtb8hySpL9hXvbqAw2VPRqtaCHyqMA==
X-Received: by 2002:a05:6902:110f:b0:e73:2cd2:6162 with SMTP id 3f1490d57ef6-e7880fc8634mr1821188276.20.1746578874290;
        Tue, 06 May 2025 17:47:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:cc2e:477b:d336:3346? ([2600:1700:60ba:9810:cc2e:477b:d336:3346])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e755e7d9565sm2711474276.49.2025.05.06.17.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 17:47:53 -0700 (PDT)
Message-ID: <3317228e-e1c8-4b69-9f03-f344f5a6a0cb@gmail.com>
Date: Tue, 6 May 2025 20:47:53 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] object-store: rename `raw_object_store` to
 `object_database`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-1-c05b82e7b126@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-1-c05b82e7b126@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/25 7:09 AM, Patrick Steinhardt wrote:

> Instead, rename the structure to `object_database`. This term is already
> used a lot throughout our codebase, and it cannot easily be mistaken for
> "object directories", either. Furthermore, its acronym ODB is already
> well-known and works well as part of a function's name, like for example
> `odb_has_object()`.

The patch is the kind where "it's correct if and only if it compiles,"
which is good!

I just wanted to chime in to approve of the term "object database" and
using ODB for short.

Thanks,
-Stolee

