Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3B482DC
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKqLdlWC"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5988c1d947aso848079eaf.1
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 08:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704904626; x=1705509426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11wKT4T/czfTKSfHnh85OS7U+bR6urOQQCxxBqMw8ds=;
        b=WKqLdlWChDai/beUoCZ33V7/alwGu0gSub3ibowwyV295qxCcBWul8CaP/llAIdnC2
         4luZM/FEPi5fE7EJI3T9kuQKnsvOtlS79Zwj411LEdIGb0NjYP4d/Lel5D7kGQBhirKC
         jLR5e8qRP8dBnT6J8FeaHC0uKnsidQjChJaArVbV67KEFSenaTxb4A4KNFjSEO3Y38uI
         aKAXCSOEiLnTyv2+JgJjtH0mEiSG/kZgHLi2n0XVPQPSDjHdTm4ZrMdFq6FKWns+DF28
         5ZImeBQwSDm3SwlwI6D1K+DgZuaGF8lB57IrcwxcrmMfuRc7KuWzbEHhrr7qSgyY0JpT
         BWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704904626; x=1705509426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11wKT4T/czfTKSfHnh85OS7U+bR6urOQQCxxBqMw8ds=;
        b=GniqYqy0s1g9vERUSc7fbW7EdjqjKgpGdovUpyFV3QdQSHi1MYifG1BUWnwHHC53ob
         TV2Fpofc5qLDh3+dEr95WlCHy7Q4F4fVX1+i7EXpz4UA50Ibh/23VUTEGpPnLG1CGQGd
         RX0UPFd/Yn5ynmlr5KDWy4/76S/rBXhNp5z0jYiJksIZ//1cgmhb53aar3feAm+iv4Pq
         vB5HOAkdZx6CUF0NOzQ3+33ZqviU1pbvqWrLVbICra/V0zYYlVZU5Ru9M1aN+N1oVbxe
         OCogaapeO6eVLdPyuVu+URFWPOad1/Gr7+r0Bo+XTyWnfvzdl9ehFpAXSni7jsFrkPSj
         Ytgg==
X-Gm-Message-State: AOJu0YxOj0UkL5/kCsGYOYRcflZUM5WFj03hmnXBKY+47eDfPxJVZ6X6
	PifE/VsV2Q9oVpkwnmGynefEhY74xpWBICV18yg=
X-Google-Smtp-Source: AGHT+IEVhjLCzYdXLuBYfMLkJ2ea6t9WtzVbkZ7ls/UvjBFZbb/wWLJ6VYUGp+aSd7MJJRMopC51SA==
X-Received: by 2002:a05:6358:6503:b0:16b:c401:e714 with SMTP id v3-20020a056358650300b0016bc401e714mr1379609rwg.5.1704904626214;
        Wed, 10 Jan 2024 08:37:06 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id fb11-20020a056a002d8b00b006daca8ecb85sm3692310pfb.139.2024.01.10.08.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 08:37:05 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v3 0/2] t7501: add tests for --include, --only and
Date: Wed, 10 Jan 2024 22:05:16 +0530
Message-ID: <20240110163622.51182-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109165304.8027-2-shyamthakkar001@gmail.com>
References: <20240109165304.8027-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The v3 of the patch series addresses the comments from Junio and adds
the test to check --amend --signoff does not add signoff if it
already exists as suggested by Phillip Wood.

Also I have removed two tests from v2 which tested the same thing as
other tests in the series, namely:

- removed 'commit --include'. This pattern is tested in '--include with 
staged changes'.
- removed 'commit --only'. This pattern is tested in '--only excludes 
staged changes'.

Ghanshyam Thakkar (2):
  t7501: add tests for --include and --only
  t7501: add tests for --amend --signoff

 t/t7501-commit-basic-functionality.sh | 68 ++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

-- 
2.43.0

