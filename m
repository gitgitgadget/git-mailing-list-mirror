Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9FE304985
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 21:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755380277; cv=pass; b=IfPaDVDtoRrIWCN4mWP6jV8al6BDnzAbJT3Hd5pjFH1vbPt39AYn791/yK3FkOGKvTbfsy1qBKw3lkJhmusXtCd+izel9YfVFodblfrl/vLqMSTNJ8cbXwb3ywIjEMohlGm7kkP2WeAQTKPDQ3E67g716g3VcH6+QtDSXEXiA2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755380277; c=relaxed/simple;
	bh=bByFX13QRllrCV+5RJ8SrliUkFcrbtYKY0kHuZQ4Lpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYyRQcRmWeVIXcAOmi0VmXDL3JN9ZYGYc4rtvVkEunFevCPrmXMMzYw0sAiK5vm9Z+k0Fwd9Fzg9hDEItlSSb96a13hL98fwmZrqWyEqoYNf1/9037DJwNvd9j5xWeQmRN58VW/i2NTKJcvWuqZFQRj21LgLuqcvV7cqz4mmEI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=h1ymzHhn; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="h1ymzHhn"
ARC-Seal: i=1; a=rsa-sha256; t=1755380262; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HqEibZp4iH3vvfm7h7fbl32Y4eeUPuqNS7iyr0tTro1EKSO8XPx9g+A/l6dBGPFbJxloMj0o3cZJsDQvyKTIXYo9ca6GNwx+KpVI/5MEm6iqNGjcbTgL6ZCZ9XDi9Bmgl2hhUZBQQLH1fKexRs7G8VHG3Y9//uhmXDgOny9sG8A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755380262; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HYkRwszaLVoNsH6XsqItim8hW7rsfYPERKsv0xQx7Zc=; 
	b=CVJbQAHMwgZKo7Xfa2TnwTGNeN6DPst6L++s9AgoOqlo4CWC99F8AmAVZrITqH5HMgbp9bVj9bwrn7WBFkOiCGi/1QWVphRK+GCeTX6uG922gYesGVOrJdqjlut0vRoyR6cRX5GJQjuLsr2DNqKcj3V5QVwHYM412bZYHRQbxWI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755380262;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=HYkRwszaLVoNsH6XsqItim8hW7rsfYPERKsv0xQx7Zc=;
	b=h1ymzHhnMvbD0ZZTfNFx7O6EH6eOqnjj8zlyMgjBgVCuGK5F+FsG489/YX5HoM3X
	7WDd7OL8CwgdF+QmOCnDvHI6f//M+f56zoWIUT8vDPBykF8GiGsCwBXkRFFKRfVzmW9
	lp4BhCzH1VzFTpiepkiyq3QhJmdof1z01ywETQyc=
Received: by mx.zohomail.com with SMTPS id 1755380260091145.33211024600212;
	Sat, 16 Aug 2025 14:37:40 -0700 (PDT)
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
Subject: [PATCH 9/9] t: add gitdir encoding tests
Date: Sun, 17 Aug 2025 00:36:42 +0300
Message-ID: <20250816213642.3517822-10-adrian.ratiu@collabora.com>
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

Add some tests to further exercise the gitdir encoding functionality
alongside the existing mixed directory and nested gitdir tests.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 t/t7425-submodule-mixed-gitdir-paths.sh | 52 +++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/t/t7425-submodule-mixed-gitdir-paths.sh b/t/t7425-submodule-mixed-gitdir-paths.sh
index 902b2560ca..cfdf487a56 100755
--- a/t/t7425-submodule-mixed-gitdir-paths.sh
+++ b/t/t7425-submodule-mixed-gitdir-paths.sh
@@ -152,4 +152,56 @@ test_expect_success 'checkout -f --recurse-submodules must corectly handle neste
 	verify_submodule_gitdir_path clone_nested hippo/hooks submodules/hippo%2fhooks
 '
 
+test_expect_success 'new style submodule gitdir paths are properly encoded' '
+	(
+		cd main &&
+
+		# add new-style submodule name containing /
+		git submodule add ../new-sub foo/bar &&
+		git commit -m "add foo/bar" &&
+
+		# simulate existing legacy submodule name containing escaping char %
+		git clone --separate-git-dir .git/modules/foo%bar ../legacy-sub foo%bar  &&
+		cat >>.gitmodules <<-EOF &&
+		[submodule "foo%bar"]
+			path = foo%bar
+			url = ../legacy-sub
+		EOF
+		git add .gitmodules &&
+		git commit -m "add foo%bar" &&
+
+		# add new style submodule name containing escaping char %
+		git submodule add ../new-sub fooish%bar &&
+		git commit -m "add fooish%bar" &&
+
+		# add a mixed case submdule name
+		git submodule add ../new-sub FooBar &&
+		git commit -m "add FooBar" &&
+
+		# add a reserved name on Windows
+		git submodule add ../new-sub COM1 &&
+		git commit -m "add COM1"
+	) &&
+	verify_submodule_gitdir_path main foo/bar submodules/foo%2fbar &&
+	verify_submodule_gitdir_path main foo%bar modules/foo%bar &&
+	verify_submodule_gitdir_path main fooish%bar submodules/fooish%25bar &&
+	verify_submodule_gitdir_path main FooBar submodules/_foo_bar &&
+	verify_submodule_gitdir_path main COM1 submodules/_c_o_m1
+'
+
+test_expect_success 'submodule encoded name exceeds max name limit' '
+	(
+		cd main &&
+
+		# find the system NAME_MAX (fall back to 255 if unknown)
+		name_max=$(getconf NAME_MAX . 2>/dev/null || echo 255) &&
+
+		# each "%" char encodes to "%25" (3 chars), ensure we exceed NAME_MAX
+		count=$((name_max + 10)) &&
+		longname=$(printf "%%%0.s" $(seq 1 $count)) &&
+
+		test_must_fail git submodule add ../new-sub "$longname"
+	)
+'
+
 test_done
-- 
2.50.1.679.gbf363a8fbb.dirty

