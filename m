Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB7E24B25D
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736543105; cv=none; b=Agv6b9jT9cL59hZsRQPbOihpiJ5HAi6fhEC6pYtLzV9pY2QeNjqkVAFsSmkEiPC9lpNdU2FeEc1NdvMSQuLlBZ1YWKLwuVuEHSt1TrUOZzYBPapOLq6Usf+oiP+g5EbAAErVEx+/avy8T94GRaclKYzRjcYmrSz8VOWSJFgoCxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736543105; c=relaxed/simple;
	bh=aiFDiORHZaU8Zg+j8toK9XMHxpxm7IizHFhYHT5EHDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQoSLq4nEY0f4ctk1zPt+5Jky0+SjXwO07oCuMOIDihRinMSBDLvq6dkXYY8/pd3hCd+GZPX4x2tu34xTG43791AHHoLCQ/Bu3JzQ9WFFtFBuqmsREQHonpKBgYPox9dZtC9v7Y5Ksp7zKcDBnwRsvb/Gu9kzQk5mObP9ZAlXys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggRbT2co; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggRbT2co"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso4236899a12.0
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 13:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736543102; x=1737147902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fop25omWxwjvcCcdZiIYXhNgXQs4f4gRhQfnKmH0TA8=;
        b=ggRbT2coQP5k524FdUtKEGZfgMVL6B9owaHOxZgLnoJuNY95shdt5QDgTFh5Sypa8M
         kspl8hsVSENtrAnefpy94bNL5N1WXT2czq9jZs2Ne9OhZwdnZmEZA9tOmCbnnON37Elk
         Fwx6H+PKAMZ1MguVwqhG6rpsCrmgOW4g75tGfew0QSEeNa1DIiMFn0n1r338PPfPart2
         w3mj+DwnX9DRs6neZG0nQV0KCMMCxSoG9hLT7iYnuP7MbL7AtJiKrTAqtt0It3bIowjp
         S20spVj8ATwX8MpR0uolkvkBQMYDwb2eGB1DFmcLYKyDQEd3W+MnLC80D2FG5I1O+A6v
         5o7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736543102; x=1737147902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fop25omWxwjvcCcdZiIYXhNgXQs4f4gRhQfnKmH0TA8=;
        b=d3Q3UKDlzNMZjq5jkP1njs8kXwnAEkzKKTbjSiz8Q0vD0LD0bM+764Y/aD5WQT/J5J
         NE1oZxZQEfr5q6T4uEesKCkExF7G+G0ZZ/OpVXqeYN2aqeR+cXqocrHyvlv5XvKpIe2y
         Wfr2cbpGYUKgmoydkF3PKbXDKQF7v63kt/mejD3iIcepfF9FVponopSVCzkUKMY3kcWz
         thtywjEhfaKDzU6svfLBhRhjFy3rNRyQiGY6aHbDpZKzPY18oZN3O0w48Es1MKm2I2MF
         Lr4hFz+AulpEIbQUd1wmXSvxZJCYW4jN+Z9TG6JC6UMXXfWzLvZYbd+7XiFmblFmDoAV
         v1ag==
X-Gm-Message-State: AOJu0YzoATEDYzFcRD0ttiKITYRKEmTOsQGxh3o4vvWxZjSqNDzNARW0
	O1778bEbHHQ5/RxJOr7tE2/7NiInDKLaMMPrfwf5XNwp/31RzsjlpYrSSg==
X-Gm-Gg: ASbGncv5v48V3o5BGEX4i8h7XMF/icC7ABnjh0BR6aNjnc6GkvcWRdOfKmpjQgco6Mi
	LFpcCC3ng2D+iUTghbQGQfw4yMC/B/tS+ViTI7wJSNO8w/bGyCg9pOq5Q/bNNty0pqcKxeXIDot
	po2TeijmnLAseAQw7WyUXbueBS5IeODP6sKKOoy3ExpnMOPiEYOAR0MBEWyyFK43UznfKEo4oRa
	/GJ/33qdwYZhqFqY+8JWcgPqjrguXUtVqwlD6xMNsfjqgBevylLiAMwC5hT+A==
X-Google-Smtp-Source: AGHT+IFtzo2XKN8O4b27y6CmDR02OSzbLlNdG/Y+GSoATu3FmM1PRGXT0lqowPRBfr/CmHFnHwFEkA==
X-Received: by 2002:a17:907:36ce:b0:aaf:87e5:4eac with SMTP id a640c23a62f3a-ab2abcb12fdmr1162462566b.54.1736543101637;
        Fri, 10 Jan 2025 13:05:01 -0800 (PST)
Received: from localhost ([217.156.233.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9649939sm200943166b.182.2025.01.10.13.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 13:05:01 -0800 (PST)
From: M Hickford <mirth.hickford@gmail.com>
To: 
Cc: git@vger.kernel.org,
	derrickstolee@github.com,
	stolee@gmail.com
Subject: transfer.credentialsInUrl should warn about personal access tokens in user field #leftoverbits
Date: Fri, 10 Jan 2025 21:05:00 +0000
Message-ID: <20250110210500.675629-1-mirth.hickford@gmail.com>
X-Mailer: git-send-email 2.48.0.rc2.32.g01723adee1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assuming config key transfer.credentialsInUrl is set to "warn", Git warns about "plaintext credentials" if the user includes a password in the remote URL. https://git-scm.com/docs/git-config#Documentation/git-config.txt-transfercredentialsInUrl . This is implemented in remote.c

    $ git clone https://tim:hunter2@example.com/example.git
    warning: URL 'https://tim:<redacted>@example.com/example.git' uses plaintext credentials

It would be neat to warn similarly if the user includes a personal access token in the *user* field of the remote URL:

    git clone https://<pat>@github.com/...

This is a popular practice according to StackOverflow https://stackoverflow.com/a/70320541/284795 (800k views).

GitHub personal access tokens are easily recognised by their prefixes "ghp_" and "github_pat_" https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/about-authentication-to-github#githubs-token-formats 

#leftoverbits
