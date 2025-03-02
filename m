Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C06F30C
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740931356; cv=none; b=QU3g5W3o0a1/MM7M++92mcg6tNdoh1f8KXrw3LisNXhlX4z4AgOMjAGb3eq5nB135ST0bCLj1NAL9AlT9yXUg3v51RhihoSojfakPlG2TN6k6Io90t+wZgxt4aDqetl/CkmYAXq5Or/oLvI8Wcj+vPiFEYeJJg5axPH21EgnxD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740931356; c=relaxed/simple;
	bh=QJH0c4MUCVyZNvj6x7WSbcFHf0Taaa8BwbQMiqBHLzc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Xu98rTQhlXTBbuP7vdLLBD9dRHxtBbpR1cpwAdOrzZVrzfTHta7HQGljAKiqHu+WPwZ1EvEHQ0NKSbI9JMMZgyDHqTnl3KzFd1z2nuMC1+Zt1mqahIduvA72gi04s9GldaNNrlSKNFekr+rE4pjRMKBNbbOflb8wgxva7Ef/UKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaIzx0/l; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaIzx0/l"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so24851685e9.0
        for <git@vger.kernel.org>; Sun, 02 Mar 2025 08:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740931352; x=1741536152; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MRn02QZZrZnCpDyHoQrc3KKk+17n0c3mUsL6HEPz0Lk=;
        b=IaIzx0/lQuXMVqLupXAu1RqBvhwVOTLnU5qRBZsfs+VBq97DA/EBQl/nYA0nVj/hzl
         YjruYoKOrATM3xzP9yRzkkLfivfVW2mpEYYanf+4B7EzGlnOXrMT9KVPhSFWhx7bj+2Q
         lOcOK2lPXNZbw3mCM5iALipb8NaTYEUMdN7ycUS5K0bO42Rk3C1rHK8dw86fH6by6oTw
         H66NqKa7DkLxiRFcXts1Z9qM6SibqtWlRCYn2gZKOoLVIBSTm3bWuIF/lcL9/ZLyJseB
         Brz/0sZVq+cKoUoWS/96QVY1ibvVIFI3XKaO/coshj0k0Z6LOOyQZAn0JVO712gBCtJT
         bnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740931352; x=1741536152;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRn02QZZrZnCpDyHoQrc3KKk+17n0c3mUsL6HEPz0Lk=;
        b=RbaM6lDFFstqP8u8mqxGRSjxSAGbDfB2xQXIpIquwkti367MWHRD5QlSFLEHc0P+RV
         GlYLO3QzYdEdJAsmgYD1OjI8FbXCsAC/9EbQCZMfgkywZwzoVDjyFP1cR7fKg3y0e9dZ
         0Yd3kubzc978r5tvC1KIeQbmK65cjCly+VreYgCpVKOnM6DIwcbwadZLa/a9oI/pm4tt
         RoksJIMRn9Cb/n2ayPVZFOr9Ny5QWW0571+Bl729TKss4bdrKHdbksjdESirN9hnSeC6
         6mPymEX4dXwUvtH0dIbyhfROHwiByzbQVXxDOw+oRlYb3/rhWJdtEh+6Gvq0CCLSrD6p
         9Now==
X-Gm-Message-State: AOJu0YzeYqW3qX/YXdb2jrn3djsagWgOSuT2HgjfUtpuDbrJW4k71n/Y
	YXmlZ9L5076WNjaKMsP96qRcySBsRLAQF4wR04BpqdXTHesFHAsndjgtzA==
X-Gm-Gg: ASbGncvihVdCkX4Q6n2D7nyytlReOFujyh3fhA5CjxUvqSL64dhIl94Doc459jy8jJW
	LE4HACK8MdA6JR5fZrWp1GZUHprfaAGM3nkam8jCZaJcfmEKWk78vTTXvhx8VnNwXgPyonTTfMM
	v+2Icu7f8ALFaeAmDZ08v48OiygRHUkaDA5HMqXir+e6jtvcWmUb6M2d81ExBBQZpOsU5uJADyi
	lekKM/3yrKJf6PlRSuC7kyzqJdG/SUmgH3DCj5gTNzyqOx76Fr4rRgYiQAF4ZMR131MRZedQVKf
	39ZKkg7wbMs2TEdf1YsIFLflBGiBdtcBe1bk63NG4Hdfvg==
X-Google-Smtp-Source: AGHT+IHhLYFeySVHj36mX23kGEBbyiVPZ4K6OvbQxw/lx6hPQ/814BrZQEgLtDDpWi3OjmFF9hRGSw==
X-Received: by 2002:a05:600c:19d1:b0:439:9377:fa22 with SMTP id 5b1f17b1804b1-43ba670fb72mr86842455e9.18.1740931351941;
        Sun, 02 Mar 2025 08:02:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532b8dsm156001885e9.14.2025.03.02.08.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:02:31 -0800 (PST)
Message-Id: <pull.1870.git.1740931350451.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 02 Mar 2025 16:02:30 +0000
Subject: [PATCH] meson: fix building technical and howto docs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When our asciidoc files were renamed from "*.txt" to "*.adoc" in
1f010d6bdf7 (doc: use .adoc extension for AsciiDoc files, 2025-01-20)
the "meson.build" file in "Documentation" was updated but the
"meson.build" files in the "technical" and "howto" subdirectories were
not. This causes the meson build to fail when configured with
-Ddocs=html. Fix this by updating the relevant "meson.build" files.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    meson: fix building technical and howto docs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1870%2Fphillipwood%2Fmeson-doc-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1870/phillipwood/meson-doc-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1870

 Documentation/howto/meson.build     | 34 ++++++++--------
 Documentation/technical/meson.build | 62 ++++++++++++++---------------
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/Documentation/howto/meson.build b/Documentation/howto/meson.build
index c023c104161..961e0533629 100644
--- a/Documentation/howto/meson.build
+++ b/Documentation/howto/meson.build
@@ -1,20 +1,20 @@
 howto_sources = [
-  'coordinate-embargoed-releases.txt',
-  'keep-canonical-history-correct.txt',
-  'maintain-git.txt',
-  'new-command.txt',
-  'rebase-from-internal-branch.txt',
-  'rebuild-from-update-hook.txt',
-  'recover-corrupted-blob-object.txt',
-  'recover-corrupted-object-harder.txt',
-  'revert-a-faulty-merge.txt',
-  'revert-branch-rebase.txt',
-  'separating-topic-branches.txt',
-  'setup-git-server-over-http.txt',
-  'update-hook-example.txt',
-  'use-git-daemon.txt',
-  'using-merge-subtree.txt',
-  'using-signed-tag-in-pull-request.txt',
+  'coordinate-embargoed-releases.adoc',
+  'keep-canonical-history-correct.adoc',
+  'maintain-git.adoc',
+  'new-command.adoc',
+  'rebase-from-internal-branch.adoc',
+  'rebuild-from-update-hook.adoc',
+  'recover-corrupted-blob-object.adoc',
+  'recover-corrupted-object-harder.adoc',
+  'revert-a-faulty-merge.adoc',
+  'revert-branch-rebase.adoc',
+  'separating-topic-branches.adoc',
+  'setup-git-server-over-http.adoc',
+  'update-hook-example.adoc',
+  'use-git-daemon.adoc',
+  'using-merge-subtree.adoc',
+  'using-signed-tag-in-pull-request.adoc',
 ]
 
 howto_index = custom_target(
@@ -26,7 +26,7 @@ howto_index = custom_target(
   env: script_environment,
   capture: true,
   input: howto_sources,
-  output: 'howto-index.txt',
+  output: 'howto-index.adoc',
 )
 
 custom_target(
diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
index 3a65ee59b3c..a13aafcfbb8 100644
--- a/Documentation/technical/meson.build
+++ b/Documentation/technical/meson.build
@@ -1,37 +1,37 @@
 api_docs = [
-  'api-error-handling.txt',
-  'api-merge.txt',
-  'api-parse-options.txt',
-  'api-simple-ipc.txt',
-  'api-trace2.txt',
+  'api-error-handling.adoc',
+  'api-merge.adoc',
+  'api-parse-options.adoc',
+  'api-simple-ipc.adoc',
+  'api-trace2.adoc',
 ]
 
 articles = [
-  'bitmap-format.txt',
-  'build-systems.txt',
-  'bundle-uri.txt',
-  'commit-graph.txt',
-  'directory-rename-detection.txt',
-  'hash-function-transition.txt',
-  'long-running-process-protocol.txt',
-  'multi-pack-index.txt',
-  'packfile-uri.txt',
-  'pack-heuristics.txt',
-  'parallel-checkout.txt',
-  'partial-clone.txt',
-  'platform-support.txt',
-  'racy-git.txt',
-  'reftable.txt',
-  'remembering-renames.txt',
-  'repository-version.txt',
-  'rerere.txt',
-  'scalar.txt',
-  'send-pack-pipeline.txt',
-  'shallow.txt',
-  'sparse-checkout.txt',
-  'sparse-index.txt',
-  'trivial-merge.txt',
-  'unit-tests.txt',
+  'bitmap-format.adoc',
+  'build-systems.adoc',
+  'bundle-uri.adoc',
+  'commit-graph.adoc',
+  'directory-rename-detection.adoc',
+  'hash-function-transition.adoc',
+  'long-running-process-protocol.adoc',
+  'multi-pack-index.adoc',
+  'packfile-uri.adoc',
+  'pack-heuristics.adoc',
+  'parallel-checkout.adoc',
+  'partial-clone.adoc',
+  'platform-support.adoc',
+  'racy-git.adoc',
+  'reftable.adoc',
+  'remembering-renames.adoc',
+  'repository-version.adoc',
+  'rerere.adoc',
+  'scalar.adoc',
+  'send-pack-pipeline.adoc',
+  'shallow.adoc',
+  'sparse-checkout.adoc',
+  'sparse-index.adoc',
+  'trivial-merge.adoc',
+  'unit-tests.adoc',
 ]
 
 api_index = custom_target(
@@ -43,7 +43,7 @@ api_index = custom_target(
   ],
   env: script_environment,
   input: api_docs,
-  output: 'api-index.txt',
+  output: 'api-index.adoc',
 )
 
 custom_target(

base-commit: 03944513488db4a81fdb4c21c3b515e4cb260b05
-- 
gitgitgadget
