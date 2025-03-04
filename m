Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13023B0
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079768; cv=none; b=THtNq7jZOwtalCkMfbb1GiMvge91FU1vwylpJY7VN+/0hD0XGF0jkB0cxcYc4RBFuqx+dav/Qbk0Q1rKrBkgggrjbsLMwOi0LZiOko8T10oABmCHRlYMRp07HIHzH2awHC+BJ766sKfxvHv6wZWF61Xr37N90AHK853b4QpV2rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079768; c=relaxed/simple;
	bh=L7CP9eXUe7bz6/CURTIWdt1GasMyts8DK+Ck2zrW4jA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQLrIqFCfd/dnrJsGnLr/C+rudF98Bnegt2wqLI7U9bF5d72Zen9TE6Pa6y5u8nYdmXVPx5uLEjLfR4fMzQwZjIKkGulVboWgs5tNDayGgyJPTM/cfOD2Tv8yjcVx6slGanqZ4r2ujHnsYWvtL1eoEqs5b1noy33ItujwY4gRgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiQOOUVq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiQOOUVq"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-219f8263ae0so98707035ad.0
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 01:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741079765; x=1741684565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6FsO2L+zZW9aRh8YvkbOVr0zWy6tNLYFJWGBb6H9XA=;
        b=jiQOOUVq1HX/yOAd88AAAYVdEoSSKbehwAk8QgLF/7CxfSZiN3sBVVjunlXfKRiydg
         xwWVLpviBLndu1/p/0ioP6B2kk7LpghX6fPoHFKf1tPc3GsxyAWyCc2p5Q2b7qjcC+h7
         xj5B1SvCOvFLfbFY54/KdaJuP+Tr3WW0NWVdc+ZZfltXx/6hTAGcYukkWGA5joYGzzgM
         jyH5mRqhVtMCfhfQSPq6L9sQS4oEMbczLOsFs+RRf6O3iBGkpE6GYcNA1mwiLQbSwgpL
         U7bCQLOdGeOHoQyAQiDvpJU4mIVqwwvok3mgTCtj69EjNyO4DecknxF/b2RrkQEsw8sy
         4eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741079765; x=1741684565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6FsO2L+zZW9aRh8YvkbOVr0zWy6tNLYFJWGBb6H9XA=;
        b=n+El7nCEJWSA7EA06FkhljAwkZ/8wZVNPUtondMWq/cxolOjTT8fhXwujKISHdE9n4
         jIInp6By4UfSSabyXi4Dt9+KNA0HB3gwmeq+940q2Yqm3/uXrimiKtSKgxuF4zsozTBI
         j+g86FvI/dax+788fMKQ13mU4j0MrlzJY3bz8pcjcz3jmw4VX5UKwWN7EFN9BqEbavzg
         cq8pdhdQM0N/WE6MguoRn8k4nSGyRAlOrspc0wOeD0lC1Vp+13o36gg7OnSFrpCBp8NA
         az5S73+Un/q/OmRgUainroNev508btdE2jdK+rjIAOAqerUMRqkptgtcWHnm8n1qwoR2
         zdJQ==
X-Gm-Message-State: AOJu0Yx+Eq5BpPXLzMoY/BBzIRmY97YgM2VIupbcIqRyfNyq8S6R5tfv
	rhGapAjtrWxvkg/zcHvOEBd3sNO9/r2HGUcvdH1e21d6Vu8WkLMYfBPYJBklYBI=
X-Gm-Gg: ASbGncvkD0gyLXHWo7FiqoqppvD3aM6gU2bVnew0J1VbEdAYSlt2KowGhWto7Y2akIL
	V+2ADjr7TQnVcH4vGSrucj7OP2cyCUpspBO96b3wcvXfNKUkITqn/FGQLo/leW2F03eZ8AQZjkK
	jS6IrwsbmsbyKVBwUdAncbF+acTjBLgAkmbuuhGdUvg5ebA39Z0GUiYxkyJ8/q3ldg/6VHdRljW
	oyRZtG8qzD3dNUNwkrPAMhrGZ9lK83BmdEgf2nYFPqGbyWpNTEglIQQDfjuKEkkoORC581PacbU
	2Rag6dGLs9L1AhZAjrWUwEdufU9ovE73He6KNQs9GWUnQOlnAR6qKqZjhq3+4mB5u/n1MEyNE+k
	SQg63ql8APOFYkvE=
X-Google-Smtp-Source: AGHT+IFCHvjpiWZsvOjS2VkMvoBBwutaYFcWoe0VNRFFAIg4NQaOKKobQbfmZL+tuuVlcXaEExm3Yg==
X-Received: by 2002:a05:6a00:981:b0:736:47a5:e268 with SMTP id d2e1a72fcca58-73647a5f2e5mr12223672b3a.1.1741079765051;
        Tue, 04 Mar 2025 01:16:05 -0800 (PST)
Received: from localhost.localdomain ([2409:40c4:307:e1c:f069:cd37:99b2:31c5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2a640sm10759696b3a.16.2025.03.04.01.16.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Mar 2025 01:16:04 -0800 (PST)
From: Mahendra Dani <danimahendra0904@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Mahendra Dani <danimahendra0904@gmail.com>
Subject: [GSOC][PATCH v2 0/1] t1403: verify path exists and is a file
Date: Tue,  4 Mar 2025 14:45:56 +0530
Message-Id: <20250304091556.22478-1-danimahendra0904@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250301105838.1481-1-danimahendra0904@gmail.com>
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test -e does not provide a nice error message when we hit test failures,
so use test_path_exists() instead.

Further, verify that if the path exists, then the path is a file using
test_path_is_file() helper function.

Thanks,
Mahendra

Mahendra Dani (1):
  t1403: verify that path exists and is a file

 t/t1403-show-ref.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Range-diff against v1:
1:  42dd686abe = 1:  42dd686abe t1403: verify that path exists and is a file
-- 
2.39.2 (Apple Git-143)

