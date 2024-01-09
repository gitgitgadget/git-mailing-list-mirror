Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408DF17C2
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzjnqtZf"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d480c6342dso20802045ad.2
        for <git@vger.kernel.org>; Mon, 08 Jan 2024 22:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704780589; x=1705385389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h9GHtnTsyY54o58MVbkU1AgffMswycRNIVXF0GDjVm8=;
        b=TzjnqtZf1WZ1jO7Z3I7Er50Xo5k286T3ZNv3JC34U90ekbaThurjKAnGmAJljLIB6j
         gmrfGQnmcbbpaPzN6LWBr74SiPgB1+Xf4nh6gtcbZskmGY4mYZ9Q0xwN4cERh7+URWVm
         eUYZ1lstUYJlzrVrZKQx66yAK2qnpSWbNDQwRc4sf+7RLe7rLZRq0bmVCgJLrg4xKdAW
         eCMPkK6BbrFcZqx7FNkBT+JQdzZCYG1GVd1+RGzIitm7Tyjrxmk39bDBjYD5klJ6hOIf
         Z7VvqQizuIs3vRCB82uvZA6f4QDXy+RP1UL/+hAOECL2laMFhMDuXPk9XCPImy09LWCL
         ubmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704780589; x=1705385389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9GHtnTsyY54o58MVbkU1AgffMswycRNIVXF0GDjVm8=;
        b=Rdw72zDgtE+tCW4xcwkHGZG9T59nlku4JDiRiLHWGno/xjyPpbpMRjy3Zys6g7Bvkx
         wbo70CGQri5CG5u36sFagbK/cHbG2AuUsxyTpGCyKkiJkrqr47dBzR9EhxPWkf1qjgWi
         IzgXf0GkjW5ZjYoCZyD4nOE1Ihh5sFvPpQXj4hSSNoReZ3xKurgRcsy51Nv3e14iDwtn
         HK5xRjHdGrO/syhZIrdEtZNCkrjPL9h3KmOFfJ8PyEL9rUROZu8CYC0rV1rzlTM7HVZo
         HqcdmIQmTZoFb+53K6N3CsBX+Kti9kEkQ3bCqib0qpdu/q0wqIXzR7Gn3vgt9q70S0SW
         yi2Q==
X-Gm-Message-State: AOJu0YzdeiYN2oiTaWvXEx0G5rOC1zLtavqGEMDD3zzzRQl1jGYij4lP
	9BEor87HqLYJbq7oCHX9GXFvb07IZmUKLmAXMWs=
X-Google-Smtp-Source: AGHT+IHZ5fYKox84miyS8KlU26tyDkVLXAv2MKOAtOHzk1pJuqdmY+IpXHqvYILrtwyGFRPuRWDyEg==
X-Received: by 2002:a17:902:aa8f:b0:1d4:e254:3548 with SMTP id d15-20020a170902aa8f00b001d4e2543548mr5131260plr.19.1704780589044;
        Mon, 08 Jan 2024 22:09:49 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id v20-20020a1709028d9400b001d05456394csm896020plo.28.2024.01.08.22.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 22:09:48 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH 0/2][GSOC] t7501: Add tests for various index usages, -i and -o, of commit command and amending commit to add signoff.
Date: Tue,  9 Jan 2024 11:34:12 +0530
Message-ID: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds tests for various index usages, -i and -o, of commit
command and amending commit to add Signed-of-by trailer. This is in
reference to the comment added in commit 12ace0b2 which reads:

  # FIXME: Test the various index usages, -i and -o, test reflog,
  # signoff, hooks

Ghanshyam Thakkar (2):
  t7501: Add tests for various index usages, -i and -o, of commit
    command.
  t7501: Add test for amending commit to add signoff.

 t/t7501-commit-basic-functionality.sh | 108 ++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

-- 
2.43.0

