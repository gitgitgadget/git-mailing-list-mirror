Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E582D8DC4
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766518107; cv=pass; b=XDEbMcslfPZLWSeDE0Z9gE7WOm/+ntm8I7Q/ZwVGo0LD10jugyLOxNCv86yfISO/fa2QLIXz+i1qevyGu05u3/0B0sMUBPZ5flo+ZkH5RlHll0u//Ttf546gEcyNF1sCpp6Irs4TovEj0UfPoG9poPK4yOOaSe3Za9LGoy+daLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766518107; c=relaxed/simple;
	bh=nqUeuZVf/m28hKSgvhTNzQhBXcri0aNgGQd6hGVfYXc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=q7D+yo2YYe5KcEtJWj7B6p+mC8uQCunLBY2RywBgj6p2Vb7Z3BzfFtZ+m+U5JIGzzopvuuHPCAoy/NTD7xcsRM/28N4ESrjMhJ0tvbkgW7ruF3rYJNRSBdZpicaw5gEyK2x1Z31n8AsLmVPUCeoAC1ckBOdK2ibKoH7eKM/zjQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G51WMCIe; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G51WMCIe"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b9a2e3c4afcso254068a12.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 11:28:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766518105; cv=none;
        d=google.com; s=arc-20240605;
        b=j77IwfLWlFjuLkz257kub2Vyqg2Zh9gbK4pcx95za7OXODM5F0Ewb8V79hRs9xQpL+
         dyb6SK1CLhvEvahqHpMfUggpQCEbuSe5oSvZEM3LYtfBvcyAEuMn3okrS8cQtbDAcsTN
         fx3dgXZJ2SRlCrO+jbf4bk4EjEkPSlLjEO+qj+RtmXs42NxBxqBrJQD8NH35lzZPgPu0
         2J9/h6Nq1lLcrMBWy6ViCfeZIBLbsMpiak5Puvpwqx5J+rK3qK8Em3J9wsBnz5DinmM3
         1/OCLn0XzBSVdDHEB8Xk/G9iizBxtcCII4WEn5gDlP4ZWjpH+JlrusWGW1v4BbJv72Jg
         ZRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=F8t5SIyLWKxPOvVdCn3gpUyPqk6CCv4iZcQuByb9/RM=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=abYZPexXRUqHKgndLyV7s4i2ZBwJdkHVjSomuqOS1DUUokHefa1UWYk6EC81f+xTBZ
         GjqIxj1Xr9ZlrNIqzlglfZdnyT8M4rGhTbf+V+vDboRsP+FG0NWwaQY64QMchtUCRqTT
         3gLtPVhECnSw6nfoJNsZ9uRVL5Fxyy5VhYOkloID8qFHCvhbLhGlvmSJ0rBptp4LJ2uk
         JZuRrjCaX5y6O9y6RREB6U+566QewnUd5U0mn45eUst3qO6wcVqdAaiRa+Xy1jSUPtqC
         l8jk00uT3xvqKnVrcjqhtgvaT59RaGf0/A0kXDtEEilbEFv3Czcf/lUOo0HWTZo2qi/l
         yN+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766518105; x=1767122905; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F8t5SIyLWKxPOvVdCn3gpUyPqk6CCv4iZcQuByb9/RM=;
        b=G51WMCIeN0UQ8EzJgxF/hnECrvKmiZJUz+E8D8SaSi0joRWN37sqLv10U05Kmu39lc
         HWHNOXebAFkd4l/83HZEkbiD64XfrCrkk6afmxChk9iMeAtzKmq2CjAI6pJvolWQ5Q5j
         EUQfYKn+o+5KKFzJd7CeXkRDgYMoKHco5QRvlnXrYpta4c+l1AKw0E1U5oLpiKi5Ulxp
         v02ydMA/9mDwt+gH8Ga+ruGIU9ZPTu8+74Qmb2XV4ZY9bsb73soQ0DCZ4qZf7xmj6VWy
         rC7MdVCqGMtd0yf7MBthY+krDvhmCdgKFL+Bfc2ypVLxFhoaK0krSGSrucMEHs+rqZaS
         UVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766518105; x=1767122905;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8t5SIyLWKxPOvVdCn3gpUyPqk6CCv4iZcQuByb9/RM=;
        b=OdIuqTPEigTz1ioFCnJz5PSt5DsbWljkEvim6XaeR0PPbge23UIR3SbFcFO4LNtBrs
         82xKB6me0kPM3/57pnS14oTMpvNsFUaIxeipxA13zyEwx/jrau8YOmvmCXWVKUSpqDR/
         qv7Y7wFgndcjAlOt5svZFyAQK0XP/E5gNtbUowYjQ2AMl8fmoje/La13eQnVCKCaOmYn
         El1Z/SFM7+IJLGyNlb+lsYjPYZVWr+4dikYwaHQhyAsrzA1H5bIMSQT2UvEcc3BOcneE
         RepYL7sirjjCXHQxGGHwKH2Xr1efGOji0Oq3UvRQaEYfXT/cOjBEpccJHExKJ18gp/Zj
         MXmg==
X-Gm-Message-State: AOJu0YwSf4HE8A7wTNAO4osh6bfIzxyUY/g5yAY1NtMjUWqi6kpHH3Sw
	cyLoJ6HadfH/zFtcnPZS2vJ3ZICK3ibjjzCzQDnKsXLu2mhOiKgDBjFZlrk0YN8B78lAsZ4zFyr
	bp79GNdr9DGJl7I3QShQ3cvDSZ1QkfUSMtK1F
X-Gm-Gg: AY/fxX40kGtvK6v7Lb+Lg9pkbnLYYIbo/O8VKzA4T8Zw+Sy+OPPux4gUWxl9ogZFJx4
	5Wn+HWAkGRue5kP5HWV2ZGNcUWNaDwSi7sobtuvLuoNPYxqYdtaWP96gfIWFfmN4TA3ZMhte2Qh
	M/n8fj51X7RtkG6RT7WuRl2n/n8k2jsJsh+xICDVpAnkZ3s3u78HXGI5Q1Z5KuubYo+q9CSUOS4
	Jgsp/R2IgmHowTH3IkgDqVcht/kdQWN/NHzXsp8ih0Jcw1yeLzYaDDNJZgZz6fM2ZXL5tbMs1AG
	PKrvuPrU/nKsceoqgknJ2iZr7Nocnh8x8lu6uwM=
X-Google-Smtp-Source: AGHT+IEjMVoI2kSNAFv/qq/4UF9x0cmVqvm9IejvUeMegqd0nTP1cBxCPWiSu95jsspv6zkSVLKP+DFHUZ5grlFhCgY=
X-Received: by 2002:a05:7300:e7a9:b0:2ae:5dc2:3b14 with SMTP id
 5a478bee46e88-2b05ebf25d0mr9442125eec.2.1766518104737; Tue, 23 Dec 2025
 11:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Egor Ibragimov <juzujka@gmail.com>
Date: Tue, 23 Dec 2025 22:28:12 +0300
X-Gm-Features: AQt7F2qT0rJ6DARHGglOx9tY_DIIGB8M2JRvjAXAynr1VyuxnKcriM1r27DxEPc
Message-ID: <CABd08tVFKDoBtdBsPHaE=Zocoj6H8yuhk86Bg+99zB_H7+r2BA@mail.gmail.com>
Subject: Error in the manual
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, there is an error in the manual.

$git remote --help
or im my case I enter incorrect command
$git remote list

The help message:

usage: git remote [-v | --verbose]
...
  or: git remote set-url --add <name> <newurl>

If to type command according to help message, the error appears:

$ git remote --add gitverse https://repository.domain/MyName/MyRepository
error: unknown option `add' ...

The correct command is

$ git remote add gitverse https://repository.domain/MyName/MyRepository

And the correct help message is

   or: git remote set-url add <name> <newurl>

In the manpage the same error too.

$ git -v
git version 2.43.0

-- 
Egor Ibragimov
juzujka@gmail.com
+7-916-807-5378
