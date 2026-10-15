Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D518383993
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086748; cv=none; b=kD1dYegpQTpl0sV21tR8tjgKeI3iRaRYmIcsxIj9I8QCgXipFod5etb3nY9jybD12Aq0L5r0YJ44B92iclII/5EJVXpE5uhgOkKNxcjGSh6Iz5u5gxgZuZFwF9j+7++oUz1aDZnZK0b0EIGcyzwlXHruUN9o9aqKfxU+JlVA+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086748; c=relaxed/simple;
	bh=0TFusQXyFQdCtOZBS/0lbe+EkyIfalkcnr2pHFCO73w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Uk0gvROO8IxyHEuhgvZgesJS/ZKhy24nxONmRMOkNpubtRL3D5QnN+8S+JWy/2NBgGM6lciQTzsei2S6jJEKSCiZOK2sWZblMhhrt7jgM7t5ly5njetRdTUkfEl+eRsWp9zfw+UA5xMA2KUEAmqmeLQFbb/gnKBTCHoDO9z/1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWQIGq80; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWQIGq80"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48df8fe8513so690447f8f.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792086741; x=1792691541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0TFusQXyFQdCtOZBS/0lbe+EkyIfalkcnr2pHFCO73w=;
        b=aWQIGq80LzfbJzr6B5Jo1YcVWVZJw55XozfuUcxZW2rFz8e9AmG4EbGmPo0l7Pd1OR
         3yiHZX0EPvowvGpBS8jOGf13m4beSKLga9SuwDtlWPlrPAJJ1zMmhqQXQJvgK4gMuAmQ
         X1PoMPbJmTFXyE9t3PjEU/t8oo4csxjna9NT3ncNO2PmFQh55hG7U1iKf35u+xViauZ+
         Kqh/l8j12V5bEzlevkOrA+CkU5U3wrqR9wip/6X7ZvejFdJkB4t/TjM8303GksIRrL82
         X/MoLf2j76OHbIwaczouYSfriTA8jMWNP16HuVMvvoXsmDAKugUzxXKxxyhLfWIU9ZsM
         zghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792086741; x=1792691541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0TFusQXyFQdCtOZBS/0lbe+EkyIfalkcnr2pHFCO73w=;
        b=id5DyHV8zZeioJXKOLKrMI2D7EEyddowxqEx8zKo8YDra4tcjbFtqE+r9JGHRM0RJn
         TlnTFOgzLtjMOAb/vZuxiOVmxjlXI6LBbcL+2vXSdYmQxiB2KWao1SuyecfQDmADpDzP
         NE+PC4G/z866HRpeA/H2x0bqZOKJ7YhAL8qnD0WJKwrQIlkm2/Tr6oKLq8H75QM+P0B4
         f+GD20sbJ7p3EICJREWVQiGSwJDSW0d+W8xQ7BXNkqRDWdnYqMW57s4ZZacy9cFl9t5/
         lWf21dyvWVkS193JuaZGZ0ZqGAveJrzkw733zfJOuPjKywjM5UBjOqsrj5QeBsVha21v
         IzCw==
X-Gm-Message-State: AFq9FYIuxa8bfQVBOohhXF/eCx0ioGCGeS7fiKrT5/ko8yhi1+lsvnQi
	hbPZrtvAoFEF2s85+tCckxn8x66acXL5XGxjpv5xh2E5LfxcMTT8PTTkiN2R0TCa
X-Gm-Gg: AYBFou047RLlaErCOdtSI0r0QFqOb3e+AXPVHaJ/RzH5hWOABl6cv3lhdIhRhQivOkX
	0D6+letf6EQcU6n7RhAkNSmEDg7IndtXg1ILIYn7H44mOS/NvZUNhuLs2DMpLlncZTnaOazUj4Y
	XgxtsFBWe6yuUJXWhchmtK8aVXRz0+/TZDzPgmBhugdMiGjuHu7pMjXhv3IQ/02dgN7PjiiXczm
	i7eJdGXKOIy3ZCiPOoT+FTyup5vovV04OWSabwNwMl7x/b7QRQkDp+wkbWTNpYSwtIgpUW4iJNV
	hcH/xwMC72hX0NZBtwU8hJgFtbbWrL8vnKFi6Jn7nq/e8hym/Z4IdcI+wL/C3Af0Fc1i6bybs3m
	tc/SvHHOsgjTXtj9sJtBw6cqnKVdZkmAPTur7YScFyvlRC7vldxjKo4GnCA9JYzwPFe7lV8YuL5
	1sgay68QGen8Def9xtlqd4BVzC8BUIIlF3xEUL6ytxFX/tfDd5raUkwULoAIJVlx2aKNgR80l26
	bwQ9eABcq1wuaE801PgQYs=
X-Received: by 2002:a5d:5d8a:0:b0:48d:ee3e:24a9 with SMTP id ffacd0b85a97d-48dee3e2508mr12009733f8f.19.1792086741438;
        Thu, 15 Oct 2026 10:52:21 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaa5dbsm21066681f8f.12.2026.10.15.10.52.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:52:20 -0700 (PDT)
From: kerylefondji7@gmail.com
To: git@vger.kernel.org
Subject: [Outreachy] - Keryle
Date: Thu, 15 Oct 2026 18:51:31 +0100
Message-ID: <20261015175131.1739-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

My name is Keryle Fondji, and I am an outreachy applicant. I am excited to join the Git community and starting my journey in open-source software for the first time.

For my internship project, I will be working on "Improve how command arguments and options are scanned and parsed", guided by Christian Couder and Siddharth Asthana.

I am currently setting up my development environment in order to be ready to take my first steps into the codebase, look for and contribute my first patch.

I look forward to learning from all of you and working together through this journey!

Kind regards,
Keryle
