Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F05C2BE7D7
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749761618; cv=none; b=RCpL52fL/jlQ6icRHHyEULE2k/NNOV/qoiPLnjU+kbhb003JolUZXovEfV08L++NRakpXCoqgFa/1kykR2ld94EL2iUezHJYKdz99QXoZ5AZH6EVxp9uuCE6GaJOJBdzRdJY6QaAjOuGd410tX7zV3wNRzTLjQKiuNe1ezS9BKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749761618; c=relaxed/simple;
	bh=wJSCows8b0pWhRxV3DZEpkpk2scrZ4uZ0N27iUCqVaI=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=ECNOnEYjc5qHrvnGdcrW7/AZY6UdNqRTzaObzP2fflBvcMUbuvzsq7KIYZY/duvl0L5qbjJf9LUakD34hSGaHKvBuvcHC0m76LD7Sra310T4SuoOmXN2J+yBEtTPl58zTvQVzCVm9HUH5/lQaq7GsJtGUOXPyf9iJL2JuJO0swM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdpCiC8X; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdpCiC8X"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-73972a54919so1392832b3a.3
        for <git@vger.kernel.org>; Thu, 12 Jun 2025 13:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749761616; x=1750366416; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nk7r9427y+JG+2TojwO+ilaTos0ziL+9JA1iBiKS/FU=;
        b=RdpCiC8XuNuL+ECPGs1fXNX7Jz31W+tjtu3VYWahkoRma8jwyaoKHFanhaTd9NfBF1
         Y3rIVNJMNYIJSZiJB8J5hrMiAcC63lKyuHcPb7Qa94ZDGJeA8h6kHrqTXxxG2AaeMFaC
         5t3dz02SquXx1KUu9AiSFa9ldTK3IDNHYjHCxdE+FE7ND4ttMAoqaAmhoVtypQ/EydjE
         OrvIOoTkzNa23tPHWHoSM++hzty72nHZ/x1Dcc605OXPP7bce2uDjLhBB3pCCeuhkkxc
         keyF5kqYSAA2U3Kz0aFIQpKS7IDYVA65tGWoxh/J/o1m6UP7hXJUjV7Qy667qZN1jrkm
         VSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749761616; x=1750366416;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk7r9427y+JG+2TojwO+ilaTos0ziL+9JA1iBiKS/FU=;
        b=dLMsr+VDOzYx1m0dgcq11bQCpEVup+vl09++CUHzVOOb90YdSjObofPVXyzGR+cKhg
         dvwQEPMekq8OnYD62dFtiicZcQKkwpbuOpl4N/vL7Y3tC1Tsykt/vE/ulBaciHO/lCuX
         C656UZOVl1aP1Ss41SacIxMISBOSCRipOX+3SYQqSWxrdl8tQ1Yl90TU1wZd7NyayLfe
         HE0Gi/1GyXhdW6Avf5vxjzToiBhCAyDb7IKQJ9jQxeB29NYtLvszy1KCepq/aT6sAfIV
         afnE8NwB+sJl20bUM/iQJWWEK30uoshCLt8TKD6KZAb6t/s7xP/hNW8FsBXXVVR0F21M
         PiUg==
X-Gm-Message-State: AOJu0YyCQ8/LBHI2BDt+GcPYlRhcE674fDilR2V6DHb5e8Ly14ESgwaY
	L2/hA+jlXlwIAzseh3UbqCIAKC1IfKQnF7Cw4+hyX7UAQWnUcECS5m6mBUqkbg==
X-Gm-Gg: ASbGncuJ8htW2jrPHxbCu+mPbYpXoHArel+bUsuLiZoHRFGGTG6W+Km3zlu1lxw2tTg
	WNZWmG6Fl11Awr41qHt5kdAFULGZy7sOnRAv/D0iXH1BtCzvuPP0hXb2QkJfGiJGPgAqE/Ubcfu
	lumKTJT8trjB8VfgkJq/kh6X/l5IEcP2VbaNho7P/yPgZy/XrXpAC6MO/CxZLZFA+aEQUOW9S64
	dmAyeF65K2mVfxG/Zqetmk8fonKcAB7ikMvZkl2usM6CCJQSFT+qib2E4PrIqChwjcpMWNM6OGR
	1GY5l4oTe7lHgeJC2Z0fr/TixlQeyfZITZMCp6vQ/oDN2C4AhOtUZ8awgKHEMQq1le6AEdfMmCR
	k0bedKbikgcT1/CoS4ko1
X-Google-Smtp-Source: AGHT+IF7gQbJJ8tbVR8/Obyt2jVccPpKZObeZt6qtExDrL4eVhzXHRtEb5rRg+An5HqAYAjqXD8JkQ==
X-Received: by 2002:a05:6a00:cd0:b0:742:a77b:8c4 with SMTP id d2e1a72fcca58-7488f694794mr1003980b3a.3.1749761616011;
        Thu, 12 Jun 2025 13:53:36 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffeca70sm181496b3a.21.2025.06.12.13.53.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2025 13:53:35 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: [GSoC] Blog: Machine-Readable Repository Information Query Tool
Message-Id: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
Date: Thu, 12 Jun 2025 17:53:22 -0300
Cc: Karthik Nayak <karthik.188@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
To: git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi!

I'm one of the GSoC contributors on Git, and I'll post my progress
weekly in my GSoC blog. 

All the updates will be located in the same page, here:
https://lucasoshiro.github.io/gsoc-en/

You'll also find there my GSoC proposal and a list containing
the patches that I sent to the mailing list and their status.

Feel free to contact me if you have any questions, comments or
any other kind of feedback.

Thanks!
