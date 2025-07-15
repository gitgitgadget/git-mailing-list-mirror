Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79F8248C
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 00:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539690; cv=none; b=Md9LEjL1GiBWLk4Hy8Z9xHWG8izlUkNNPC1ekWlVeHLWcOCD9E/Ig28Mo0JyH1J/NcrcUTExi4PkDRjiyFYDirdxGBzD1AgaP3g7hxoU8sl1I/UHw+ZZ0poUy4y1F4yd2x6xuuELY/MfzO99xpcHoBb/xte91B4+P0AELJ52kK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539690; c=relaxed/simple;
	bh=flPv47bynEBSXqNt+pELijKDO60IfMMaUT+zf4XphKM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=He3LvuPsdhZK7g+AnssJRbvAygg3IfmaLrKdh+RHa9tXRm4n6984oAHPzxkpy00Q/6D7UyUJugtgZjX5H4QA5h9OtK1j69D7CvRSLj491Xde8IStAGCiSotyZJD58PWq14w/reWLozGHY/3xa7unNp07Gng+/RTAZP9tVbosJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lG0EOKsY; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG0EOKsY"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-8815049d0a8so1999407241.2
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 17:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752539687; x=1753144487; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flPv47bynEBSXqNt+pELijKDO60IfMMaUT+zf4XphKM=;
        b=lG0EOKsYBmkASZcxLT+wOTHacZWI9ZKBANuWYdJegMfdVTnqUL2/m4dOh18t9h1HEG
         ZeXMMf69ePE6isyj/k3LcPyQPiIopoJKON9nuub/ytts5yNvQhmW9o7kK0Dc+oYcMSpV
         R8i0rW0D+HQwLSg5K6H7C3a6R58Qrg0kOy/nLT4TVyPZjp38HvSMXhq6cA5BuDML4F9A
         jcF5j6LxoeO2LFYh96lL1XQaemFqJofpNgC5nadMulm0eRnm0AXOd6BdA7O5ZeIHjE/z
         HFlu4Zynjh8zsjFrvvcCSikUUY6E6Pb3HWffIBoarmdFG47Uiv1xHhFIzTtOL3G36Ue1
         R0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752539687; x=1753144487;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flPv47bynEBSXqNt+pELijKDO60IfMMaUT+zf4XphKM=;
        b=AWJgPCKSgOmucAprIScu2d1doLQQQbhlD7qs6qsymqHNyT+xDB1zkZcjBTvqmQcPkf
         BbAY9lY45y2G4cgspyqu+Iaf85RjoMx4awuIDT9wto1SnKPK+TJyTjJepRnJyKpzlUz4
         G86gRzzYtDlrIoH0dFrtLapz+MZbWX2T/oZzHVRvnX/8m4oqZXrz7Kk9jEJWKk1m/YMr
         Z5PBJ5BQJr0Iyy/R3mQAI0srKQxchx5b8NSrfnc6H/SCplB5cFo7ItLHWe5ou9FpGYYl
         iafLDBcL/hIPD2zMYDazkiDJ6F0G2GUk3L20JCBRTuI6xCaeCrKEY0pMsQp3PJsY2nNK
         Y9cQ==
X-Gm-Message-State: AOJu0YwKReHllz5Gi40DppPREd1dp+3o6SZzIm9xAdmKEL4VZ2VXljPY
	OrajiW1PHRI2pUhmDC9k8vpvN0C8YVdwsbBOykbv1f2uin+QGdJKhRbxAUdCVA==
X-Gm-Gg: ASbGncut9SV1+G0N3IPnX7bk9+Ll2975HIx06j4mRHIdJyoOlrtEGLd4NeyZOXkiYBv
	/P6XPFylAkdvun0nqW0vkBCfhmd8f/i3e+8nZcRhzf+0ado6gdS1iKgYQvs6YgQa5iOc8ickxuZ
	2qHMXMYE+jc36jw+PBTBvHXG9Pf4sfmsArpa2rQ/EB5UQ2fOqMV50CEzY5zdp1KF11Wz351VMX3
	LW4qUqIEiZfndp52I32bU4PXYaIxPXKGzN/xrA8FRU4c1BUsenS7O2IqrQx+DoKdK6yrQcWs23s
	X1SoF1TbDHh+JRbu+CzhwYvC+ipUgdcj5VvZ6m0kSAElxdJJntOeoqvQEpMAb5P9Of8c4mIPt+v
	ZGsQpC0HRzbjHqPmWQkBEphQ1B1l1v3HcHezge0NayD3rFYly
X-Google-Smtp-Source: AGHT+IGzX2a/TBubeng9NOW5d+k8hhC2TJBXjc3yFSDyN95YVrXSeFcieNcu6yaNVMY7OJ5ESMm5fw==
X-Received: by 2002:a67:e00b:0:10b0:4e5:9380:9c25 with SMTP id ada2fe7eead31-4f6423346d2mr6725934137.3.1752539687393;
        Mon, 14 Jul 2025 17:34:47 -0700 (PDT)
Received: from smtpclient.apple ([187.101.144.40])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-888ec246bd9sm1923577241.4.2025.07.14.17.34.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jul 2025 17:34:47 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC] Blog: Machine-Readable Repository Information Query Tool
 (week 6)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
Date: Mon, 14 Jul 2025 21:34:32 -0300
Cc: Karthik Nayak <karthik.188@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: 7bit
Message-Id: <9A4E7241-DC4C-4F0B-A70D-737819D911FA@gmail.com>
References: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
To: git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi!

Here's the 6th update on my GSoC blog:

https://lucasoshiro.github.io/gsoc-en/#week-6-jul-8th--jul-13th
