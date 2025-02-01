Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B13A2C9A
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738393961; cv=none; b=MCPKZtRt/ewdUoHsDKTRJXOjJGpjR9qm8yVuyL3aQia81mzyzmbPuDs+zXkJE0Vl5Jhjd4OIfW5yyDx5PrXbYbiVS5EZd52AQRFbZjWFMhCFCDKtha2+JgjKnKy05AkoTJKM8Zrt2TnQURww6MrmN1hPTx/A9tcYyYjOd8PTx6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738393961; c=relaxed/simple;
	bh=s02pgkuWHMlhBkrOOPvd6gl/8UWc34ndjduRFAKv2gE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3u0VhsebB9PcG7Eb3NN79XpXF5FpRccEiDRks84l7XwRIaqwO+5jihDwPtn7JuULUq4xcsblauHZlMBmXraaPBTqyqXzKQiWmK58AlHiuM1Ty/urszpaz71yLG9NfB6XLRXR+IpLQHipZxKxAuafVywnBGr+kKhnShZtfUjvYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TICAu8Fa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TICAu8Fa"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216728b1836so47253215ad.0
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 23:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738393959; x=1738998759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lllxn7QgArIFmn2fbp7cHUxUXYCYsVCpxB7GHHsLYNM=;
        b=TICAu8FahRWU8zIWKLWK1vbg08ojOVnY+ZJrv7/G/8GeIKxK+Lw037ANuGJ19Cp0Us
         kj4/z64ZwZZww3id8DzDIBVDUBXItR/PKaENiozF2a3nJekWTOG9HMsMsTyW7/vWudAA
         ikomvNz/uEVUdRlr1icQGG/IjDlMqzJziXVMVPkrPoULcse2Z+83F0PjQA1qd9dNi4lU
         t1wd3pfTXyh/Ku451TSe72nNwcid8oosbgENSJswqCCbotpX+fD/LLJZBLvB/7kcwil7
         ySsKxTSi0uGUVnL4kcz5N6qQomGSkkO7/d4qmatYkaFx5WvCENg2gUcEEKaq9E+gMiqj
         ZX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738393959; x=1738998759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lllxn7QgArIFmn2fbp7cHUxUXYCYsVCpxB7GHHsLYNM=;
        b=tfuXE6a7IR1NjqKxAhBf7pampouX3ckzfUkUJE0cyLF/u2na4JBi05Y2DbYWsBOxyU
         Nvvalz5U2M3Wtxf3iXRWOMyKg8hPbgOWScXAVrpVxbmTB0aWeWKx0AXowRkcksbyH6yq
         a3EyAgxSz80/O6fLPxWizNs1OwFFlcLAOTpgkL3JtoJ3J124DmJwkIiWGuACtSw9hmgs
         zPOjcJB1Nty+rDSjADF8S3PMoos7iWOWAs3W53UfcPCfG7HC5JUBNoI+FYG6te590JHJ
         ftcFIzc8U32p5nk8zv9I9lai0Owo26zbtOXYRRKw8cq9FeO4RlmVUVxTBVEeNbTz3abf
         7h3Q==
X-Gm-Message-State: AOJu0YyQ4dEzo2scVi4wJ4ILORqPA9VWnF1ByZSYeLUoLYZ17guQKnAk
	n9Z9NYIAbT4E0za1QqTUKV7Wv7Ma/AwZcE+PLlp6gIgrpI1pO5HZfFV4yA==
X-Gm-Gg: ASbGnct61sNmrMbkgP47QLhS2r16oKkcZnFEbWoGWlxeGRHbYAVpK8pwGYIr0zUMESF
	DW4wvPnNwbRchA9G3OnU5gIxPcUruzgUP+EskEpiERyoOtSTunhFZgvS1yZnpkSUF+7pYhmcf+J
	at0Kh7xCdgKN7VNf2O5KJwiVF1fG+KG0xdBc11kjdo4FyQJNDc+413dBly8xyohKzqabZlwgDEm
	WgwrJP+5FBz2e33PhkjbMdizEOtbS2iIaUz54jqPHY1LdHQhGA4pkjCupVbZLQ/ffs0y9NkfRPE
	1nKsJEesIy/2PHVSkd5HXGPbCGUfPXc0zgw=
X-Google-Smtp-Source: AGHT+IHfMwUGFlIWFfdRF9jxDdSsqfGIhrbX8r54PzFqcn98V40364fcEiZJpMP4EJOZTaHBa7ax/w==
X-Received: by 2002:a17:903:124a:b0:215:65f3:27f2 with SMTP id d9443c01a7336-21dd7c35654mr177200615ad.8.1738393958809;
        Fri, 31 Jan 2025 23:12:38 -0800 (PST)
Received: from fedora-insp13.domain.name ([2401:4900:1c54:d058:2960:c25e:6cd7:90a3])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21de31ee2f3sm40220065ad.39.2025.01.31.23.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 23:12:38 -0800 (PST)
From: ambar chakravartty <amch9605@gmail.com>
To: git@vger.kernel.org
Cc: ambar chakravartty <amch9605@gmail.com>
Subject: [GSoC][PATCH 0/1] t5401: prefer test_path_is_* helper function
Date: Sat,  1 Feb 2025 12:41:28 +0530
Message-ID: <20250201071129.30395-1-amch9605@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I'm Ambar, an undergraduate Computer Science student and I am interested in
contributing to the Git project. I have picked the "use test_path_is_*
in test scripts" microproject to work on.

I have read the thread at https://public-inbox.org/git/CAPig+cRfO8t1tdCL6MB4b9XopF3HkZ==hU83AFZ38b-2zsXDjQ@mail.gmail.com/
specifying the context in which it is suitable to use 
"test_path_is_*" and as such found t5401-update-hooks.sh  
where "test -f" is being used as assertion.

Thanks,
Ambar

ambar chakravartty (1):
  t5401: prefer test_path_is_* helper function

 t/t5401-update-hooks.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.48.1

