Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5599238141
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755380263; cv=pass; b=tak0RTdRPgDkatafICxNnZRH9krLT788hym/4OdRmGGFFozJHnNXEGet/MwwROIHx56UmXFZxK7/oPJVaouf/5LnHc+YJShWMxTU2+Sfo37mqlqYTYwudfTU2iau19Rtn73EQmyUGItRPAjk1qPcleu/Ng6kSkaZApD60c7764E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755380263; c=relaxed/simple;
	bh=TIe9oJtwwSRSfk10ifVvgyNAzJpyO9XxOymBmsWpQE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3WkaekAgplyWuHPTXl0GBwY+itrkUHjnNTM5lR5Oo6Rx1f4HLsIkjw6GEgBta50YMiMPciSsZiE7Q0LrlbDWyzg/DLe/lekqKoXiE1in2Ypq3xi+dq8GkeQkr4/tcgebiT4fbLFjN3r9pJQxndTsSDJ1Z5qRx7JIhjVDoTgujA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=NpKpZnKO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="NpKpZnKO"
ARC-Seal: i=1; a=rsa-sha256; t=1755380246; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JowwU2Dfz3lucEjM0OmydH+kacmU7CcNg3mMN/ucgB8GASTlvsXGqIb74hdkfoTnjyosNYHbOxcnlL0ie5sEb2P6OWTItY0ozKZ3d4Hv2jPZdIe4OZFuf+5fF/4SQ9gD63ozC+4oTW3qLEaMTVaJcSb71E2fB++Maej0nAWe5gg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755380246; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mGS2fb10RmHYT3aAruUiCPfeAAO5fvW6Z536+DwB94o=; 
	b=DDXQ6mwP8ltuNAAsT0U78nKarV2AkbuAmxrD9gLCtAlj3mfAuv/DNgwc214ZGnxQJ+xmmvJqaJM/CIhZz/KKKm1xzW63qoNse3pcpvvlvY4KgYF10fg8+xZUQyFF1tKvVqFaf7hi4By1kdIxZ/e2Ckswmz7J6hekkTgSfc27neo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755380245;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mGS2fb10RmHYT3aAruUiCPfeAAO5fvW6Z536+DwB94o=;
	b=NpKpZnKOYG8PVbFe9mvwRGP1F+lhzdqiLN9Hj6+de7AplmA85enUc3SbsD1DL9hu
	LCriqhbZegGB0iiXDJSLEkWz5dhNFXVHzA0INUDfZCDHc6LaoKrVQkiw43937K1ELfR
	qAG0ekv8LMnX05LZHhAmQrYZ3FPlmR7g+bD/RqtY=
Received: by mx.zohomail.com with SMTPS id 1755380244250288.4950397447907;
	Sat, 16 Aug 2025 14:37:24 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 4/9] t: submodules: add basic mixed gitdir path tests
Date: Sun, 17 Aug 2025 00:36:37 +0300
Message-ID: <20250816213642.3517822-5-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.50.1.679.gbf363a8fbb.dirty
In-Reply-To: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add some basic submodule tests for mixed gitdir path handling of
legacy (.git/modules) and new-style (.git/submodule) paths.

For now these just test the coexistence, creation and push/pull of
submodules using mixed paths.

More tests will be added later, especially for new-style encoding.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 t/meson.build                           |   1 +
 t/t7425-submodule-mixed-gitdir-paths.sh | 101 ++++++++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100755 t/t7425-submodule-mixed-gitdir-paths.sh

diff --git a/t/meson.build b/t/meson.build
index bbeba1a8d5..ffd74f1d3b 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -874,6 +874,7 @@ integration_tests = [
   't7422-submodule-output.sh',
   't7423-submodule-symlinks.sh',
   't7424-submodule-mixed-ref-formats.sh',
+  't7425-submodule-mixed-gitdir-paths.sh',
   't7450-bad-git-dotfiles.sh',
   't7500-commit-template-squash-signoff.sh',
   't7501-commit-basic-functionality.sh',
diff --git a/t/t7425-submodule-mixed-gitdir-paths.sh b/t/t7425-submodule-mixed-gitdir-paths.sh
new file mode 100755
index 0000000000..801e90522a
--- /dev/null
+++ b/t/t7425-submodule-mixed-gitdir-paths.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description='submodules handle mixed legacy and new (encoded) style gitdir paths'
+
+. ./test-lib.sh
+
+test_expect_success 'setup: allow file protocol' '
+	git config --global protocol.file.allow always
+'
+
+test_expect_success 'create repo with mixed new and legacy submodules' '
+	git init legacy-sub &&
+	test_commit -C legacy-sub legacy-initial &&
+	git -C legacy-sub config receive.denyCurrentBranch updateInstead &&
+	legacy_rev=$(git -C legacy-sub rev-parse HEAD) &&
+
+	git init new-sub &&
+	test_commit -C new-sub new-initial &&
+	git -C new-sub config receive.denyCurrentBranch updateInstead &&
+	new_rev=$(git -C new-sub rev-parse HEAD) &&
+
+	git init main &&
+	(
+		cd main &&
+
+		git config receive.denyCurrentBranch updateInstead &&
+
+		git submodule add ../new-sub new &&
+		test_commit new-sub &&
+
+		git submodule add ../legacy-sub legacy &&
+		test_commit legacy-sub &&
+
+		# simulate legacy .git/modules path by moving submodule
+		mkdir -p .git/modules &&
+		mv .git/submodules/legacy .git/modules/ &&
+		echo "gitdir: ../.git/modules/legacy" > legacy/.git
+	)
+'
+
+test_expect_success 'clone from repo with both legacy and new-style submodules' '
+	git clone --recurse-submodules main cloned &&
+	(
+		cd cloned &&
+
+		# At this point, .git/modules/<name> should not exist as
+		# submodules are checked out into the new path
+		test_path_is_dir .git/submodules/legacy &&
+		test_path_is_dir .git/submodules/new &&
+
+		git submodule status >list &&
+		grep "$legacy_rev legacy" list &&
+		grep "$new_rev new" list
+	)
+'
+
+test_expect_success 'commit and push changes to submodules' '
+	(
+		cd cloned &&
+
+		git -C legacy switch --track -C master origin/master  &&
+		test_commit -C legacy second-commit &&
+		git -C legacy push &&
+
+		git -C new switch --track -C master origin/master &&
+		test_commit -C new second-commit &&
+		git -C new push &&
+
+		# Stage and commit submodule changes in superproject
+		git switch --track -C master origin/master  &&
+		git add legacy new &&
+		git commit -m "update submodules" &&
+
+		# push superproject commit to main repo
+		git push
+	) &&
+
+	# update expected legacy & new submodule checksums
+	legacy_rev=$(git -C legacy-sub rev-parse HEAD) &&
+	new_rev=$(git -C new-sub rev-parse HEAD)
+'
+
+test_expect_success 'fetch mixed submodule changes and verify updates' '
+	(
+		cd main &&
+
+		# only update submodules because superproject was
+		# pushed into at the end of last test
+		git submodule update --init --recursive &&
+
+		test_path_is_dir .git/modules/legacy &&
+		test_path_is_dir .git/submodules/new &&
+
+		# Verify both submodules are at the expected commits
+		git submodule status >list &&
+		grep "$legacy_rev legacy" list &&
+		grep "$new_rev new" list
+	)
+'
+
+test_done
-- 
2.50.1.679.gbf363a8fbb.dirty

