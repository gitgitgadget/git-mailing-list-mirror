Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E905A224F2
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203861; cv=none; b=kO1mTBjnC3mQ2XGJj8CAx42Sre0l2c2wPuyNzNdKUPuiBTgPJBHlqRyvlg4T/qiW+d5tXTMVF/WmdNc1Vo/Sr5GLt3agC66ljvnKuK5yDCjFEab2TRK0NQc0hgMrIzttZKe88jR9Scvb4Vdq9AFLqv4CR4RmopkqcIhk7YvXlP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203861; c=relaxed/simple;
	bh=ZEH6IM8neXsRjspO0O+CRvJfLeZGTxgEjChxcYRnkmU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2+E6B+i8/RM0qigolZ7RUZf5VWFghOv24NtFyCP5mXsNgSX33qEjb9IQQOLAqv+X1Hn8mDkYd8RQ/d3CXnkktgfHWEWrJmo9RLaM3yuNHMriFNit0Grmnhs6/ubfka1L6433OgVxIx5QANcqkJlwpvcmFpXMdAHEXLp5BYHW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgxSeM14; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgxSeM14"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25e076f79d5so883389fac.2
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 11:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720203859; x=1720808659; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEH6IM8neXsRjspO0O+CRvJfLeZGTxgEjChxcYRnkmU=;
        b=SgxSeM14Cg6zjsoF6I5TJz3XKMbpCe2yzPcQ+9LXOQvrqpuCcB/Cn3dgezrZloFycV
         7qUczqt9aWGN1aIJjqM65pNPek7si+3C4LDNS2BElTq00fEM1Jlgib8kvDmIOobegG3f
         lUSJAr1Nd/andF+uayINI63Rio1aHDBQ/ehBANU/UUXAiujTxYJT7o9Gq5M1n+8HJQyh
         Rpbo5c5O+stRrDkjux+rQiEUU84egoClA6vL1hL7Uym6cSEEexJqqh9RnolIHA/KaLx3
         FpcluAiP5Xi4sOyJWfg1JO0IG7K0hGkSMaoNSaLKKyAWSNz6x+ChXqpUy0BT/UGgdebZ
         CIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720203859; x=1720808659;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEH6IM8neXsRjspO0O+CRvJfLeZGTxgEjChxcYRnkmU=;
        b=o+AVvgJmW7yXVJW7JfVySwDKjvLcd19UcadXI/mul6vomqwxn1yvInkM4k4RTncAnd
         sOaHlXE7OiIV/BQ3QH4E30QOx9sXKPr9s/OzfwgEtFhsTjSMVhWz3wv1MVtYSa+Ba+TZ
         t1yL/yxxsdUDTMYyPKl7Mt5QqUyjRbTIr7Ka7bhPwV1w2A4wZHWPfwWaYYbyFg7KcDsZ
         rGeQcxZpAhIyx2bWC46whfw1s2lwPbMFWx9WqQNKHt1cy+PL8XSLDoSJr7KmZYHVjBFC
         kmn3AYj0MeqDSFD7EB5pgRDdYhgh76d6HlNt38SOu/FCL+cBdrmJjuDGF9SLZiXqqqvr
         VrFg==
X-Forwarded-Encrypted: i=1; AJvYcCXTFFNTJUhME+Pn/YNwPIr86xUh9j1cIacOu5CWs72ImLy8w5qURLQy6CXIECCm5HsvSzF9vvxDRKNeN4eYb+B0o2IW
X-Gm-Message-State: AOJu0YzNR2tTYqrBoMWlVSG/0F1UPMOt4MJUvD1ygDNefqkmf8t5hVxR
	fI/6f6U6L/6QHwN5w5llCG/1EL9/NSM/CdrUx20x2kRtkh2xNKqLQzUzJDuNFko8IctAki6gbEq
	Jm1ViUHghuqQJ14EFpoEyv4XAXcU=
X-Google-Smtp-Source: AGHT+IFtOtYdRCIeQz17H9FLZyiyYkXb2K95PHmMywn8oEZ5J1UIgUQvjoPuGL0Cli0wGyK1gAFOaJtBJEsGDoyDLic=
X-Received: by 2002:a05:6870:ac14:b0:25d:6464:4dc0 with SMTP id
 586e51a60fabf-25e2b8d96f8mr4406344fac.11.1720203858975; Fri, 05 Jul 2024
 11:24:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jul 2024 14:24:18 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240703171131.3929-1-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 5 Jul 2024 14:24:18 -0400
Message-ID: <CAOLa=ZT84sVZ67VQyXLeCby+YbF28d_STseME1xsFxzFXLa7_Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH 0/5] t: port reftable/merged_test.c to the unit
 testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="000000000000f4ddc7061c842b53"

--000000000000f4ddc7061c842b53
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
> testing framework written entirely in C was introduced to the Git project
> aimed at simplifying testing and reducing test run times.
> Currently, tests for the reftable refs-backend are performed by a custom
> testing framework defined by reftable/test_framework.{c, h}. Port
> reftable/merged_test.c to the unit testing framework and improve upon
> the ported test.
>
> The first patch in the series moves the test to the unit testing framework,
> and the rest of the patches improve upon the ported test.
>

I went through the commits and left some small comments. Looks great
already.

Thanks

[snip]

--000000000000f4ddc7061c842b53
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e91e9f641de896d6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hSU9sQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1NvQy85UG9rMmJtenVsWlNKbS9kRWpXVlZ3ZWowYwpGNFd5dUtTUlpK
czB6ZkdXdzQrUEt4ZVcyVWZGY1NzSXdGb09jcDgxQm4vb2VJaEFUQ21meGMzMTNRNFZCRGxRCjZH
V2J6WFdGMXhRN2x1TU8yODM5eGd6VElhcXNyd25pK1R6VHU0MDA1MVJocnd6RGJFUU9PYXFzREFD
ZTRYTXUKV0dpOXpoeEdFSEw3L2piTTdVWW9VY0luV2JiWmxsRmkybW5pTkxVUGt5Y3NxbWNvK3BK
alZyb2F6c29CMkJDeApxcGR5R3gwTnozZFlyK1dZelBIN1ZlYkNORXNtRzM1dUlXd1VvcVJyZVdG
NmpkcTR1NUhBQVRIRFFXendaOUw0CldaQVcyckNQQlZzUEVsTWhSbGVaL2tHNkxKL3F3V0JTSGlj
ek9pNm5LTHN6ZzZBS25RWUlibFBXamVvQ2E3ZEMKSzN4cUh5dnNSVG5wQjNLWVdGNEtjeDd6cmRI
ZjVmU0xZcWZwbDVNcFZYK3phVHllWU1CNmdFbEluZTRDTGFFRQpSVC9OczZ0VXdlSlcrVStqZ0NT
OStLdWFuYXJwTXZGNUEzTmxRbDNFSTd2dXNpYVl3dnU1ZlFqcjJVVjJWMWViCjJPUW5MalNXeVk1
N29SSmhqakMwanh3ZDhNL0lBVWZMTjM3WWY5QT0KPWJZUEMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f4ddc7061c842b53--
