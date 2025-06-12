Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6580B7FD
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 04:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749704367; cv=none; b=mrqkPd6Z9GvrT+4/L8QZ3sKrNmWm8+QSWYKWpWIu6JNtin2EApJ25sa3akjFBa63o3ctyA9Ehi4k47ZWmvCUsDL1ak0wj0kNpfU2q1njTeQzpsiayc1tNmvHrzUEDBuRh7VXxYybdka4JD8E6ODTC1yhehOagi6MgCd+bvHIwPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749704367; c=relaxed/simple;
	bh=eg9tln3+t/MaY9nkbDCxCOAbTu4WKftvGfCIPB4m7PI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zjr8OuLazY716nUHhHh2+KbAf1gBfyOxHoNMWp6ymiyNiSpjp8EumO8YbLrhxSMUeM8nxmgOsR19hbR8mawAjDQ4bEL2mEEG6KY+vXmR7T+yTLu/gp1NqKa6O+cK+5+hhqgyWecJK/q+A8vNJNgFbe810PaZT8v5Bb+3NsABKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSuiAm5E; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSuiAm5E"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-7d21cecc11fso94550085a.3
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 21:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749704364; x=1750309164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ydXuekpHJftdbchZlcmZUu6QrgVU8RXHvqINZ9F3SB0=;
        b=jSuiAm5EWDj/qMFUNQPujEduvfckcAA0FiflJ3CeeoFrB+8cLUxCGTANEsRKPeFUDI
         QMVV/odCrVjg66Qjxk71CC/3I81775axrXH3W+PTxfSwvlPK5z2kY2xlZg+m++4Em64A
         f3+KT+j1dITTAj3R6w4lJu++Sb35/QQPCPRno3epgSVDf8IjnK6pqXNBpj9UksPAtxFU
         u5C/v+VedGLtYNogf2cgy4md2EtaAwm6cHJmAtFnJpCKyXS1lX0t/BUzelPB/cjwlo+u
         I/vReo1iBFR6NVkXDKOeDs2qDqEH+Fco2g31ILc06V/9Eb5iNCqP60tIkYarbdjN08ja
         S6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749704364; x=1750309164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydXuekpHJftdbchZlcmZUu6QrgVU8RXHvqINZ9F3SB0=;
        b=XI4Y70ArevDK4Ew+P3f7iO6sXX3OohXPHYGRxEfXsHCARqMhic/6uDn1muKgCLRQ6T
         rb7SpEawR3WozGNFIa81W5n4hDqx7PXP7GxCO2/7fKYUd1b7JpmbkjwKWrKyeHNGvLXp
         37jq8OgMRLxVDGCl6fEkPTrWuVAftu1VOMQQlcPEFfEOi6rMooVQQc5pSiP4WuAU+m1C
         Sd65zjjLYTSsUcDMMCaUoUTMCHkIa4LzNbBzT9EIRnM2QRizHGy7Ifj08x33BlO6ifad
         BwIwSUiN4sfJHUseTdf1tUMSQTn1IXth79EphLZZFv/mL3jrYgVnTw04a2qIlc0cJfLQ
         I+ng==
X-Gm-Message-State: AOJu0YxPbC2qTna02QOu55Fzf/rb8HN1qwXGniVuObs0iux+5O8EN27c
	+CSD8xuDwNRpGnEHtg78nkPsjNRQbx3mr6vmbWN4bmE5WV8JtXJ+0nuJU03fhpXu3xswQQ==
X-Gm-Gg: ASbGncsMsERn2iDU2Ut94rX12NF6b7qxiViOcvuekWa+idoo4Fbb/xDi77hTPjPJMZo
	GkHGMiGgrs3QaO69OqZby8pEpt5PJ1NLk+SzRTsawso/MjwBb5bDWYSmzIP4wDmwVzndfLGARWH
	KEO688zC28voUt5GQf4PyVkfmeFtqAxaUtEPgqNFIMW25In4GSRlcZykCpl5Px3fWuI7qQQE4FL
	u4+lLAXES0QbJf2dpjLTx0yTHZq2aM+dlwmFT7+GArA6Lw1UOQ7iVy2bLK2UPvKDkRbriI6j4kM
	0F0FiOdPPVf+xnavvjlKvwL7SalstFFYo1xhwTgmT5Cm/MvBhx76zptvngLFFfYodHHA
X-Google-Smtp-Source: AGHT+IFcWNUBiBTVwLmRESQWBw95rX4GHn5wSs07njYDmqsTE19jHqM5R/NlOhDzZWq49CUSivXfHw==
X-Received: by 2002:a05:622a:a18f:b0:4a5:8b39:626b with SMTP id d75a77b69052e-4a7229efcbamr32380151cf.27.1749704352583;
        Wed, 11 Jun 2025 21:59:12 -0700 (PDT)
Received: from r760 ([188.253.126.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7247224ccsm6980531cf.4.2025.06.11.21.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 21:59:12 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	ayu.chandekar@gmail.com,
	Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: [PATCH] git.c: remove the_repository dependence in run_builtin()
Date: Thu, 12 Jun 2025 12:59:05 +0800
Message-ID: <20250612045905.3023227-1-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.rc0.47.g9cc88feafa.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

run_builtin() takes a repo parameter, so the use of the_repository
is no longer necessary. Removed the usage of the_repository.

The comment before trace_repo_setup() advises not to use get_git_dir(),
but this note is unrelated to trace_repo_setup() itself. Additionally,
get_git_dir() has now been renamed to repo_get_git_dir(). Remove this
comment line.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 git.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index 77c4359522..429ad1c2fb 100644
--- a/git.c
+++ b/git.c
@@ -462,12 +462,11 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	precompose_argv_prefix(argc, argv, NULL);
 	if (use_pager == -1 && run_setup &&
 		!(p->option & DELAY_PAGER_CONFIG))
-		use_pager = check_pager_config(the_repository, p->cmd);
+		use_pager = check_pager_config(repo, p->cmd);
 	if (use_pager == -1 && p->option & USE_PAGER)
 		use_pager = 1;
 	if (run_setup && startup_info->have_repository)
-		/* get_git_dir() may set up repo, avoid that */
-		trace_repo_setup(the_repository);
+		trace_repo_setup(repo);
 	commit_pager_choice();
 
 	if (!help && p->option & NEED_WORK_TREE)
-- 
2.43.0

