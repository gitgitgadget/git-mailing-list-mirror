Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510813624A8
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931517; cv=none; b=J5OpO/aLEzGZuGgjkMMRPNqjtiomEuv2KoVVsvuXHvltoomiPSdqSRjgQlkhTBQDTMh4DebjPUL5rpBRw0EblywM0CD+0cZk2sdU2aGxSCRw3NLvlyDgVBV6RoUC6zt0KDysfcD35M0ISXPSwTaR/qv2rrfZxRUTjiuzfZkPJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931517; c=relaxed/simple;
	bh=txucygGQLtBRgxzcblI5tsDItX5sQM0J3RnKjBWUNC0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OczqG3ULtD23WHkHKZPXIBaXpYQDa/NTW0dJjnLLjGNd2t5GOte9PjqpqWwQHmpvYKyLKpQka5FbDMayxFUDJdRBlQA4oulxU8n3WN5QClEUhzOxhz9G1JAaWj7BulOAcllbxZc9HCGB4tVFTzPf99xhjzgk8JsxliIzNtpc4Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=YM5QCv0a; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="YM5QCv0a"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6895P30M022775-6895P30O022775
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 9 Sep 2026 08:25:04 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1x4Anv-00BSGk-Rp
	for git@vger.kernel.org;
	Wed, 09 Sep 2026 08:25:03 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 08:25:03 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 76bf585d;
	Wed, 9 Sep 2026 05:25:03 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH 0/2] guides: keep Documentation/Makefile and command-list.txt in sync
Date: Wed, 9 Sep 2026 08:24:59 +0300
Message-ID: <20260909052501.8448-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-16.utu.fi (130.232.247.56) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhZSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=u2ZgDDf9iRs6wMXV+igh87kb/2gDAu1quqWu7vScRYs=;
 b=YM5QCv0axLmsDEOx3NwLbkH+Hlz12MozMYsoit83zD7GnEoFI3lqXa0I/MmGf6yL0OLMIQrm2tAR
	I9EqlvGo6C7gFGz8yRDbND3bjcKabS0dZc16KUXyF3hAx9KQe4FaSdFmCl39QYDs59AgZ/j+eYYn
	Q34PdB2Z7j9JRA5+T8+K4tvQBdxyYHj3tN6E88HLdy+EVPyVUFxpCXjIld+ll6msJ0nhPU8sG0e1
	R3TjvSfhexMRcfXepKT9EKJtONKnIDOvVg/Hsb63YHuwxfgofVgdtY9L1c7jEhK+DdGs4yCpiEA3
	P4dsH9k/spfFTf6Ju6E28KMhJSQEJxet7W9vmA==

Documentation/lint-manpages.sh was expanded with a new test
ensuring that command-list.txt also includes all non-command
manual pages (concept guides and interface manuals).

Based on kh/doc-datamodel.

Tuomas Ahola (2):
  command-list: add gitformat-loose(5) and gitpacking(7)
  lint-docs: check the guide list in command-list.txt

 Documentation/Makefile         | 2 ++
 Documentation/lint-manpages.sh | 9 ++++++---
 command-list.txt               | 2 ++
 3 files changed, 10 insertions(+), 3 deletions(-)


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
prerequisite-patch-id: 13af80fdddfc7d4f65437343cee0ca3787cbdea4
-- 
ta/command-list-guides-sync-lint

