Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603570;
	b=4v/w0qdTQxVyMUSxeJ71WwKvDCFQbGblY936WSeUPkB96G6RppXrOhwg7l+huvAKxbOz
	 cyh4rWLUxPT7CTyj2sQqw7nCU4LEKkYkvvOeSnlRm2Lnj0t5Qys2zHa+D9N0YXusIwrq3
	 UJH8dzuSIhiik+Kh/b4UGesBTRLD+KBOI297voHgror6Pz2OovpS85YnIdVTnOPD9XOWS
	 68D6qBT0NiQUYuLxUC0ysxvyjW/66iRmWaDGQukYEOzmOVbbnCiTQepTam/3VTqSAbbO7
	 97bDA+4N3HszwiZtHwXL0aiiKrjh592PfkfanDpfLc3Ddb+Imz5SeZxTqZVilJqJqEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zSXQR98bnaEr1r6UttuCJhq0FSSU0soGDYzSA9IFopI=;
	b=t82zxxd8FEm4Zowv92XmsSTT4M/FDA39pkLtQhWuEomqGS4DY23cjJGYUMCcfR5VM/Pt
	 j0bA4DJd5ZjbpQA+WyNyOHyNz29wa2v+bHN3YtsK7c6n4uam1H7i/QODQPywJWZ0O0GFZ
	 dGj0PAGMU/+PILhJqOqr6Y2y13QC1nYnuofPPvwtcbWNmNMMEyremDwW4zZ4C8HDrExR1
	 +ix+4AoOLJqbDj3e7mvgev4m9KP5aoVGzg81JPm5LfDx5EpoBCfo/VCK0qPGpHX6Y93GT
	 FVUKSEtNkwfM2poaUqucXsb7LMZqdaY+6sJlusuiosnAkbcxa8ZeZXEf2EcMYzrj50g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qy4Sj40Z;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5DE606A31F
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 17:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B5DE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qy4Sj40Z
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48afbd2c386so745821f8f.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792603568; x=1793208368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zSXQR98bnaEr1r6UttuCJhq0FSSU0soGDYzSA9IFopI=;
        b=Qy4Sj40ZUG+Ap89dVfvA91YOGO97MNTKbMn2G4ByQCRUwKi3T2L8RLqMBcNAsXaSEB
         4WqdnkyhqSBruun6AoJ9Zc+rVs71NsW1lRy7ohLWWhCPzcpnyrPnQXtlA1vyTM9m/R0c
         GMsPzZZf7Sc67ZpJEpzwHuQO/0j1APyNtuhqIa/p0xgQJprWvbUeUEPMAvdrpgzZOCpQ
         keFrzDCMhRSDP8W+5UJRnKfu8s7MEeTi/zUuXC9CwfmwdMf26uyS8PiAi5BMk0yKSPuL
         EsinejF4pUaStupgyuG2WaMUmf5PIrYGMRzNxq7byysyDBhQsE30mJ5OjCP5buvpnbjY
         pIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792603568; x=1793208368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zSXQR98bnaEr1r6UttuCJhq0FSSU0soGDYzSA9IFopI=;
        b=2djbsK4EFa5W+Fs9YBMlc6lwTkoEkx+90PwLnVCG/iDBonKaycZmrEGVOBIm8d5jNC
         +V2nSMCOwu4I2xli0cY851Ht9NtVh6gXENzPmf4njnnpSJaBqJsdCHRt4qJedCNy7krt
         FNuefmu0I+bgyi6uZxhsXAlcYtWu+j2ikZHinTUeqhguSpkU2liRP/tFE41RILfS1pCY
         XMjcGOVlQqeUMM/EZMK2IlS/wi8Y3tIOaKnXDLv/pm0WSeJ5Tn3s1dIS/aYjMqsGH3xO
         RnrRM3EBppXx3W3zBBtwcbKRkUN5yrKSHzq05BZgu5ZGKT+/PQoTj805gfJHtzpx2YhY
         tOLA==
X-Gm-Message-State: AFq9FYLXPURq19EU48fDLkGNKyG5GAToETAKsPaUvM3bFqPULpf5M97h
	YO0N6ViWHeC0UL/0eGtJv5WrFpKyRSSA3+rbVyKJjkC+gvoT66on4IltdKjE+Z20BNA=
X-Gm-Gg: AYBFou3kFOnR98qZuzJNTa5G0/9/nea7grmojQ3gfjPHXjAJzIiI4NqPmHnCT7r8ZOi
	/GdzNTaqysO8HYdT0P0YgFHEBIWXNKmqo5AFiE1qXEG1G8cjqxhiC1TmFah7DAx/gB/anx9Vn/H
	pd7Chj9DlePjrq9G7Pru3WqnVVqr8VVanwyTgrqk3wtNAohs8FW6eqONxGYgtWO0/WHOkMpUBnx
	1XzHAyVmo0ExooCj2z7ubFWmrsKoYFIl8dhqWxXjSU0XoTmECIn/RWnizYzI68wjNSxhvUsYWoI
	182DxkA8uvNTDkaPCvG/FqZs+zXXAzKUWw+3rMmxVYMK7qKVI0BbQaeVNONqxEeMz7Aae9Jl7Y/
	Hw2RLMrEdyQdvNWn90mE5kXd3XJ4DzHB4E6lggTGXvJG0IYnSw517gmkDULAT7t2Pd0xyE2o8+K
	Xl7BDzSIA8Svet/zE9f4WhUmUm+W1oynsgDhl+g6xyeViWJcnTMR1X2syZ0nJZIfllthBbegl8M
	Mm9Elk4CAJrTrtxKIPlPjbYXgPXdbK+gEyOuRs5ySnDhKe0M7Tk2xr9I1LW6DvoLDo9XGpCDRNT
	Cf8chcZVtgKlwQ==
X-Received: by 2002:a05:6000:2ac9:b0:487:27f6:a4e9 with SMTP id ffacd0b85a97d-48e264e8e4cmr4768462f8f.57.1792603568194;
        Wed, 21 Oct 2026 10:26:08 -0700 (PDT)
Received: from zito.localdomain ([102.90.98.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254efb2csm7214727f8f.2.2026.10.21.10.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:26:07 -0700 (PDT)
From: Azuama Odinaka Maximus <azuama69@gmail.com>
To: git@vger.kernel.org
Cc: Azuama Odinaka Maximus <azuama69@gmail.com>
Subject: [PATCH v2] rev-list: skip --grep argument in early scan
Date: Wed, 21 Oct 2026 18:24:57 +0100
Message-ID: <20261021172458.6373-1-azuama69@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021151253.3689-1-azuama69@gmail.com>
References: <20261021151253.3689-1-azuama69@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The early option scan in rev-list does not account for options
that take a separate argument. As a result, a pattern passed to
--grep can be mistaken for another option.

Skip the argument to --grep so that it is not interpreted as an
option during the early scan.
---
 builtin/rev-list.c          |  2 ++
 t/t6022-rev-list-missing.sh | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 0faa833fac..453d82d25c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -771,6 +771,8 @@ int cmd_rev_list(int argc,
 			revs.exclude_promisor_objects = 1;
 		} else if (skip_prefix(arg, "--missing=", &arg)) {
 			parse_missing_action_value(repo, arg);
+		} else if (!strcmp(arg, "--grep")) {
+			i++;
 		} else if (!strcmp(arg, "--missing-only")) {
 			arg_missing_only = 1;
 		} else if (!strcmp(arg, "-z")) {
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 1bd2c3bc4f..180e6ac766 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -215,6 +215,17 @@ do
 	'
 done
 
+test_expect_success "--grep accepts a pattern beginning with --" '
+	git rev-list --grep=--missing-only --max-count=1 HEAD >expect &&
+	git rev-list --grep --missing-only --max-count=1 HEAD >actual &&
+	test_cmp expect actual
+'
+test_expect_success "--grep does not trigger --exclude-promisor-objects in early scan" '
+    git rev-list --grep=--exclude-promisor-objects --missing=print HEAD >expect &&
+    git rev-list --grep --exclude-promisor-objects --missing=print HEAD >actual &&
+    test_cmp expect actual
+'
+
 test_expect_success "--missing-only requires --missing=print or --missing=print-info" '
 	test_must_fail git rev-list --missing-only --objects HEAD 2>err &&
 	test_grep "requires --missing=print" err
-- 
2.53.0

