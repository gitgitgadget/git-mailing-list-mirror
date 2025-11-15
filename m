Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A0128395
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 03:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763176592; cv=none; b=PrwPJdxNplCDmpm+IhGfYwooJGzC6QloW0PXXL8HY6mvPV0SGK5BTSvNcoWgcrXHG4qh6QPurl74TEQ9Ur9AuenHuDp3smqn5D2A5swLZMmAs9lBeCyqpa7DqWnqILpuri/bTawvpQiysbKMdALLtdSSXBJwGXKk+Tc/uUpr8uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763176592; c=relaxed/simple;
	bh=bMCCz/OijBvfdXKreoGMooLhQNJhBjeNuOrJwft2yK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=InbKwZx8lcM3dqYBCdkeVVwxZ+k9Ca3jd9GB8HYKzMmxpX7+FkdRX0Q2R9oyiKyS833wbSaKQNJZs/0qSLja+W6PW/LFYiAFEpGt1RP0+m1wdxquAfwRqOlC030riz/uY3FxcTaBX74AtbhwIluT/QGzE5ccBDG9yqlX5R3hPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBJ6ePFZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBJ6ePFZ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29555b384acso27719125ad.1
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 19:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763176590; x=1763781390; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bMCCz/OijBvfdXKreoGMooLhQNJhBjeNuOrJwft2yK8=;
        b=JBJ6ePFZ8lcaLRmN5HMH9RW+yg88TOqNIVaHBi2CjNS4bt3HQt4v8gBKewBUb+A87q
         sxXcbDb2w6QqUKzRbHRJxhIZXnOwdT79hVVdV8E1PTXjxFriK7JxO5CLDjoip3SbJkf3
         H3r5K9v45MlTkDnDSz1oiQKq76q+QqZdv2p/9eKmPeTijkDfjhFgt2kHAt8v+csEtjLx
         B3kYDeW04RYvxqkCGtO+8Vw9Oe2aaIHjUjsJ6pMWh0rh0C5xZRWF83k/8ZsxtGZ7E5GW
         eSYSWlp9fbw4SdQbPoxKWAz1Id4VEMEE68AIb2b8trowDWOuJ8R1F2kIVcopgHosiBqp
         tlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763176590; x=1763781390;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMCCz/OijBvfdXKreoGMooLhQNJhBjeNuOrJwft2yK8=;
        b=dhU9MdcXc65o9x2OPekiUGjqU1I2uLb/gQlJcopHszPMiFBGFFIGsYj4DQ2mHoHFiq
         gGVBzdsEOlvToWxmdsdzox2s9TKtMrDoWFGE5Gi2CszcAzoEChHg/sWLsu/5Dw81WEjd
         f+iwnS6A1lhzf1xZxfqecTX0kL6IVUe4/J5KvmeF9rjTM874Sf2rhjV7+dfmgwrIPBDL
         5nAhwAtszixML97yYhfI9ZVhIp8rDIUmu6aZo/LHsZn83G5TtT1D64BqOjU1FNHMWMLs
         rCeW+/cl/XseVzMQ4z0F4Kn+45RcZbfd4Vh8u5vvXh6seN/M/CfdVGIhkxQ63ftFGMvX
         23ZQ==
X-Gm-Message-State: AOJu0YzmalYEx/xclmkCrd5BdQRwTaBWCv92e2j35AXtBOjYaOBaHTaW
	bqo0Ak7zUboGofcMfwCrb2/rlQkVu69QLIvCAvLWkcotDlbbtJc9X8up7ljFzSCFaXI=
X-Gm-Gg: ASbGncsTGz9Ua459DK9cwZXQ2eCYvpDO2U1mZChO8s7YwU4vMh6WkBbxeiY+lSRqD6p
	VjZTDeZ0aOhqO1DMTvSmB5pmUyhglERaoEKijbXOuKK5JI0ynax6LUYHNlDQuYjWewtTeRw5mmf
	up84rQVZrejyPaBPy2OQM6CmXCT5XgT3A/AXF+/OjvRBDx59KVbXHH4msE2qRNS7/pgw12wCNIs
	2cnnEvPkX6Rv6yHzh3uwfqJNtNiaFMbyS2kE0Qq6ISYCnPaKCs4JRAPiMM1RDlZN5Mn0x9yKLX8
	CEpXAO/ihs6uhojxiEztiDsVIo/A5/2ZMmLLPK5W/RVmHQbok/nvOuhQQ1PvYsYfGtavktsUPcQ
	QpadaDC4X0/FKKQGUznwTkusTruKVPrSmXcKvhfyqK73O3B/Crdg41xs8LfB6W+kgc/Ppn/4gTw
	ER1QBB6xmgN65G/jcG9WYPpvUyug3T/wU=
X-Google-Smtp-Source: AGHT+IH2MSeg6rwxETISnNSjVOcKt2R4GaesogoLx+VfwRxv+lcSYtOz7CWztujYpg2a7+ZpijA3gw==
X-Received: by 2002:a17:903:230a:b0:295:94e1:91da with SMTP id d9443c01a7336-2986a73b093mr59369905ad.33.1763176589774;
        Fri, 14 Nov 2025 19:16:29 -0800 (PST)
Received: from localhost (1-163-87-121.dynamic-ip.hinet.net. [1.163.87.121])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2985c2ccafesm69123475ad.97.2025.11.14.19.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 19:16:28 -0800 (PST)
From: Chia-Sheng Chang <changchias@gmail.com>
To: git@vger.kernel.org
Cc: =?utf-8?B?Sk9OQVRIQU4uQ0hBTkcg5by15ZiJ6IGW?= <changchias@gmail.com>
Subject: I still use git whatchanged
Date: Sat, 15 Nov 2025 11:16:25 +0800
Message-ID: <87ms4o0yuu.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Git team,

I still use git whatchanged command.

Best regards,

Chia-Sheng Chang
