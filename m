Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA7B2D46C0
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739489; cv=pass; b=CzZB5TX+ppI2TAVM+lie30iDxac21Ckpmo7T48SziF6OAJhpp6kEHbXNN4PHDlohh5eJfhWHct7NngZsY6x8HDjbjy81AxPmjB8JOu+EwksbgtnTcQL3fgYrD1oNR39KR1eJR2xwbv29hm+F7ksFNJ8tCa3646arpt9m8cGsRBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739489; c=relaxed/simple;
	bh=21GIwrrss73xjkXXjE/sPphqo72CfRXHShaCHT4CPtM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=L8MxYKbuSNWHw+cGpJmRuKb010UNC0hyFbIr8Q+Sx9dZVvDLI9DZWMYu2I9P1vR87tgp1eMr1YnvnILH6mXadgvEY1YHnRtG3ytNILTNMpL0Ox82x/3FUy3FRTZoj67OQ/wCv+ZoA7LMBP2RMu77ZyB+AAnl0yLVdEFerYYGTnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaJovDCR; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaJovDCR"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56a9076813bso441381e0c.3
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 05:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775739487; cv=none;
        d=google.com; s=arc-20240605;
        b=jjD561OMvjI67tb0AyGq3RsAJBX3dFqhxZv4cUNYOLN2qT9o6ky2/hcL+Bp3+S+G6B
         4E5V+nMNqIr6ZJKUWkNrsMAOUpJol/HML3olTYQ3vk2A7IjpVn908TChThIrhEnNoBn4
         S2jC1L+uwWZxwjYNfuo61thsGQCRTaC0R9SziZnLO2GAzkkVDXqkbbgXLYkxI96wl42H
         0T3oEhjdJ4hQl/WaIRRumBwTW4iDTasYeeT3WwuOG5mOGCBDuBaXI878zvsT6w0NOOKz
         NlhP3iFA483Ko0UhWEbQheu+WalmWjyL6cHM/uC5j7D1eRQCP76YQNlMztlvPrNEg9l/
         K6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=21GIwrrss73xjkXXjE/sPphqo72CfRXHShaCHT4CPtM=;
        fh=5xVFw2I/zuc6GTqlqauEVmGl5t7YHAX+j1vRw8fBc0E=;
        b=fkFPjlBkq+266wPp0zdPGck9p+b3XMiG8km2wy/fBLj98ALCIXT+lv7oCgzO/JEvhN
         PJuwF+kUxRJMS3tajE6V3NTWg6BXydFPHpIEU+8xkQJ3mtrL5ubbBt2E/Jrtsz0uYUT/
         HyfNEw5vzLbqeLxP1tiHSTvry6r+L9lWF6FiZ6kyBQjcKr0ndbh6/AqoL0X8yOAY9N1w
         6vqPOzOtG9oAfVYemn2jpApGvAJN62HkyyvWswAFLORAg0HcL4v8Y8w/STXL7NxlHFFU
         nLnuxvV9AJxwH/HyHIo2Gs2eJ6kqesOwOOPdSkjXQm5skbexG/mv2w1ZGcn9Yv5Iw2BO
         ygHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775739487; x=1776344287; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21GIwrrss73xjkXXjE/sPphqo72CfRXHShaCHT4CPtM=;
        b=SaJovDCRsuuULIkt453eNcIOE0AEkIr3byXDC1Bs2vIGuC3q0okpQ+kbVpkpaOGePG
         7uW5e7K7Zmep74qR9uoXOeOVUARAK6+kOFUn+VcgN0q3nd7dBZJYd4bRthH2NQBNeaXu
         Bj8f+zZTXRB1xgK7uh4xd4xmqp0rLh/3GgUqwRIPtRVseipgkbJFY3O7gGgynkK+a2nX
         K8Mj6OECN3R/YPm3e+IdCeYl93JUiTNQmjQPHEE5qQRuKxnWUWrFKeAcje21CLfuZnCv
         LhxjHSOQBjJ0/1FjmKBP0lGe2ZQWys/t5Obp+djZIW2vzA1WiroherS7LA3EXFVUHm2j
         /v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775739487; x=1776344287;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21GIwrrss73xjkXXjE/sPphqo72CfRXHShaCHT4CPtM=;
        b=RYASxIGkja/kGMN5rncsvkRCMceDFxuBkZhwD9By3GRaPC+0pL7Y0stEebZUQUVWoa
         3VmWAM+S7tFzcShXlUTLc0++ayFf7wLnS9CrGE6DibKy/9TPoDJMfRBTn4FBjSlnRVCt
         BTmGIXCPReq5kOBA5aYNp5N5qD5lh/TsgyXdjVzrb2FWHpw4JdlRwwnsJO92HxwDVdO5
         1CMMdaNdm6dvVD4yoaAmZ4lMANDr/i4J88F7H6VOQnrMqKj/YScrE8T3ZiiUH4t3oog0
         k3unHhw+YHzRyTo6mcWVNJfVXYjx7KNLrs8uEyoU7L//WETbs/yT9bgT+XyA+eknlIuI
         q+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAzlu0DaoWMzQku5aXeTCZBxlEIYf7Lo+XIT6bZNCZa1Z2qtu4pS4UZGG8Kq7K2of4Lu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw642hxcj59MSeapSjyY4aXY2Q6pElt913oTxX0S6UDRa/UO9RA
	X6EdNuUKIWxvqymWFoNXmeLtECO6Wf6qF7++tVPThE86/efdY8OGWSUaaKlLlaf+TRrjHYerYH4
	6rdyrakWRGDm+TMdvgpnj1aHZwk7vYq0WyA==
X-Gm-Gg: AeBDieuJ6M+fcke/Db+JsnpbPmgFudDcc1Iss5++NmzFGuS9RuedUEeI8zDWCkk4c2T
	PhLG+L6P4KmmAMPTmfNPw4ZwyuoBMQbGjF5oe/eGE6SwQ9+iYX9hdBRZ1tbnkCAeVEO8ihtmklT
	yIMDEx+BAYUd43KgnqUEav3YmRZfrIb6snLdEE3CtYN6ZJ/1vNM/VuVFnpua8rrwo3O1TLcOCeU
	iOl8AFm+8KYJKBPaiLjsIG1mzeF7hnstTXHinTWx3GRCWJtHpsTOt5Y4GTkRKR8IjiCn5Q41X97
	qmAohMI76F6T6i9PzUSzylqy1hetdIs9k3mc+r32mw==
X-Received: by 2002:a05:6122:3701:b0:56c:db8b:504e with SMTP id
 71dfb90a1353d-56daba11cbamr10577061e0c.13.1775739487323; Thu, 09 Apr 2026
 05:58:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 08:58:03 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 08:58:03 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-3-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im> <20260330-pks-setup-wo-the-repository-v1-3-0d2e822837aa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Apr 2026 08:58:03 -0400
X-Gm-Features: AQROBzATxNeiooV76F70F48Y8Jmwu6b3grXvvJRqvxs4wCp2dp3eDNmKD9OBXKk
Message-ID: <CAOLa=ZS-bHiG0wyjwfzSbX4TgC_Jfpk2NXHAf=dUm6CvVxx80Q@mail.gmail.com>
Subject: Re: [PATCH 03/18] setup: stop using `the_repository` in `is_inside_git_dir()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005b2f44064f06918a"

--0000000000005b2f44064f06918a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Similar as with the preceding commit, `is_inside_git_dir()` determines
> whether the current working directory is located inside the gitdir of
> `the_repository`. Perform the same refactoring by dropping the caching
> mechanism and injecting the repository that shall be checked.
>

The patch looks good. I do wonder if these functions need a new home,
'setup.c' is fine, but it is also bloated.

--0000000000005b2f44064f06918a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f13465dcb84d01_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uWG9sZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMUU3REFDV3RSNmNkUE95RWRjTjhGaWw0ZGhQUDZkWQpmcEY0dW83SzNo
UlEwMzBFK2lnZnUzU3d4WVVPQUpyWWg3QmlwWGJqajZPdzlrNWk5M0haR20xU2xBZjE2Vm9qCmVG
RDJKamxaOFZpaldqd1RSV3dqWURGNG1xc0tBWlhxRGFFWFlqYW01NzloM1lHdUJVQ2V1K3dNdjk4
TnZlTHkKOEdKR0lWOEtmU1FDT1Vua2s3bGpIcmk0UnFmQ1c3eHF6b25SZ2tPZ2lnNWlROGpZT0Jh
cmJxbXNYR2VJNXhrZApJZlFrM0lMaERUczhPVkxqaS8yZzdhemZkVURZMC93TlRjU3EwQVR6WXhF
MTVyVUlYVEJyR3lOTGx1anY4dmFSClNSUGtUNGl6WXYzRGpZWXN3YS9NNzJtckUvaTd0dFVWWDVR
VmE2WGg2dENHMzEyQU9LWllaaXlVVDlrZHI4WTgKOHQ3K1BBRHpwU2o3UnhlaThPek42ZStXRFdw
cDZST3JDUGp2RS9xeitiMk42RTVuY2svMVZEancyci9QdTVmdwpCMVk4N1V0QUNMd29aRHRZM1d0
WkdQSzl6SDNKbFFTaGJJWTBmaVp1ZUsrdEp1aW1kQ1lhVklFVWRDRlBrQUMxCmk2WnNacUNyWXNj
RkMvSGdGQTBrVkhjQjhBcmN6Y0Vyd1RoQlJSOD0KPUlrRXcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005b2f44064f06918a--
