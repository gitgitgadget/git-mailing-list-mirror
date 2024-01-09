Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFD3374FD
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iied/rHz"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3e2972f65so10946385ad.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 08:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704819321; x=1705424121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jStjABErBhsaaPlaOf38TtG3OWPD2UzWwXnzkszdloQ=;
        b=iied/rHzhKqb2UHOAgknizhdzm/Oa1ecL0Ck9ghywOF7R8IvvfPnmAeY2IdM9Cb+9E
         ruDwhDXPLl0AUVjBuz0sWrZb6JzcqGkqTkRO9BF04TZm3UDSb+5CWlGZere3MkEvw71Z
         BjA64O5KsoLOhCxQOpXenD+FgB6ofhpavU/b/Q9ydf4PwT2nQBvhDPWXYQZHvtkRGwRc
         LUir/nO72yHdAbpa6Y5BGApcAih1qWYfz1ztJyJ6LfS19xDAS5Uke/3lSMOJhtiOQ4V/
         2JKQ5CwcwPfWCGPsz//NsF1cJys2+6xBfPmUNWhPMEnrHtpBd6xsG6CRYkwJdIM3uEXF
         nmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704819321; x=1705424121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jStjABErBhsaaPlaOf38TtG3OWPD2UzWwXnzkszdloQ=;
        b=h/v77kg1oTO49SF7zrbwsGgDTfvxgQsVblZTfmE0913R0DWrPRPbyv9P+1Bd3XLmGR
         7i9Z4nOB2gF3tP4tg45OeWFYPRbn3x+YXxyHBP7y6MTCSUw031Nubm2J7QbH8CYSmJOK
         Jd2Mu7DUT8EtAXu8iqFtIhCjh8hf8KeGwq4OYq395npp+Aj3vdVOpbNTru4NdjxViITW
         IoQY/izRGLc9XOhBC3/QC+HCJkvZo1KKazjvv7C2k4aS+1mi+zRHEw/mqChdurgZjEz8
         t1bMpBhYmyj42ckxYP6CoYp0ZZ9z65Y1Yaea3LvVsfcbX12UDO5eVoqz11Cf5hwzv9tZ
         bPFw==
X-Gm-Message-State: AOJu0YwdYrgTyb6p0hPEaBVglFf/HYKRjNBTVvA0p7cT3kdXWi+nHbWZ
	9CtC9Qt1Fu7NTmymC4Cwj8o39yA4SMyKm9M0
X-Google-Smtp-Source: AGHT+IEEtFIJ98YqBRdET8XpvuZvxAyQswfTmvL2PfslYw9I3Y/icuWP+J9CUSIAX3zMJz1aynesVQ==
X-Received: by 2002:a17:903:40ce:b0:1d4:ab9e:4d51 with SMTP id t14-20020a17090340ce00b001d4ab9e4d51mr3979808pld.7.1704819321379;
        Tue, 09 Jan 2024 08:55:21 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id y24-20020a1709027c9800b001cca8a01e68sm1985851pll.278.2024.01.09.08.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 08:55:20 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v2 0/2] t7501: add tests for --include, --only,
Date: Tue,  9 Jan 2024 22:21:19 +0530
Message-ID: <20240109165304.8027-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
References: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds tests for --include, --only of commit and test
for amending the commit with --signoff. And it also addresses the
reviews of Christian Couder and Phillip Wood.

The v2 of this patch removes unnecessary initialization of git repos
and reuses existing files instead of creating new files. Also, it 
removes some redundant code, namely committing everytime for tracking new
files, instead of just staging the files.

The second patch of this series refactors the test with a better
approach as suggested by Phillip Wood.

Ghanshyam Thakkar (2):
  t7501: add tests for --include, --only of commit
  t7501: add test for --amend with --signoff

 t/t7501-commit-basic-functionality.sh | 68 ++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

-- 
2.43.0

