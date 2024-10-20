Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339DB192D8C
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729440058; cv=none; b=XAP9J/IVU54rekvSn10Qoh35Fj0Fn3TQxQQ1aBbDw8PK49gnQV6Wg3mThx7cXiMVTr7FZxKdB/SDlL2A1gQKv2DDBcv4cMLH9CoRLCtVAatdK/vnhGsSAflENKHcYVq9f3J5k3VIZi1QepHjrMKK75wHoABAm3zqN+SuyWAQhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729440058; c=relaxed/simple;
	bh=paLFStsR8vgt+HnQ8/xBDnyUMcCh/Jq3pwGQzELbWj0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iXNc2o7EFodfjvL9d+SZnMu4HHiRHJ+OPAJBEpir4G9DcVlK7mZT7OXa9WcziykzbE6waClwR9HwXIOomR/oUxgIqpRsyqVTsFJ9WQzIwvjZlQvxoFcSPzs6OfvXHzxipOZlF4tcqUjQC9L6n9uc1b79xWpRXR0ArE334/tXhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=mBl4Beh/; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="mBl4Beh/"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 2YMGtCeuAy9pX2YMHto072; Sun, 20 Oct 2024 17:00:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1729440045; bh=0gbyHHsSddyZCpb2rACn2fWnaNkLqFw8rkQhzLb3ZYY=;
	h=Date:To:Cc:From:Subject;
	b=mBl4Beh/3bDayzG6AkpxhYZC66mwDIDsOmXIC5nNWHZuuzwnZx+ZZAer++ZQ5NH5Z
	 OAS8YvyyAvTzLDH4K0YPqSSnlJNXClOhVlRr/jTvk9XUfMKhqv8kyir3bJ/RWNZ4Uv
	 Z7txGvvouH/mWjSd/IZ7u2ladSG+8ofQiJSR9rW5IHJwOhoTSe0kR7m7cRFCTNu6kx
	 Og2ESPKKqmeZaSPSw/Ez6QOxhPUJQOkGFNjJCB0zbG/KCN411oPP/QOYGa82rR3r7X
	 +ZYsw4zSUXMXUCQlMFCyDmP455jT/rV1IAPEqQU+oSv7jcTeKcGVTkZHP8j9FGkSJU
	 4mrKT01ZyoiFQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=JYgfrlKV c=1 sm=1 tr=0 ts=6715292d
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=f6rjVxDtyWQEP9_GTUgA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <8b08b64a-aa5a-422d-9815-e67911a703e0@ramsayjones.plus.com>
Date: Sun, 20 Oct 2024 17:00:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] t/meson.build: fix up tests for 'seen' branch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPGBZ8KJSUW5KME8BK9kFL6irQUpW2HXsqvjaUgkjVAf7eRgDGecMdD5KlOtzMVpz5WFGYGG4mUaojV5QAFAVcAY3b8wxErJ5x3U8r3hMQdb/hPKoHvM
 V2fBKZT0d1krjdvH+uyaf2+R5JoQGb0h/7MUzuMiugxI/4ncQ35iK5dGwVDSQsXDRt32eefMLcyQU8ROu8DCsOWNwXXTuTD5JyM=


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Patrick,

So, having got the build to work, I noticed that 'ninja test' was running
less tests than 'make test': 1028 v. 1035. Having a fixed list of tests
to run has 'issues'. :) This patch fixes up the list for the 'seen' branch.

The 'new' tests in 'seen' are:

  t1017-cat-file-remote-object-info.sh
    branch: 'ej/cat-file-remote-object-info'
    commit: ef30c4557c ("cat-file: add remote-object-info to batch-command",
    2024-09-25)

  t5710-promisor-remote-capability.sh
    branch: 'cc/promisor-remote-capability'
    commit: 3cb155a011 ("Add 'promisor-remote' capability to protocol v2",
    2024-09-10)

  t6601-path-walk.sh
    branch: 'ds/path-walk'
    commit: d7e16a4ca9 ("t6601: add helper for testing path-walk API",
    2024-10-08)

  t8015-blame-default-ignore-revs.sh
    branch: 'am/git-blame-ignore-revs-by-default'
    commit: eca5438740 ("blame: respect .git-blame-ignore-revs automatically",
    2024-10-12)

  t8016-blame-override-ignore-revs.sh
    branch: 'am/git-blame-ignore-revs-by-default'
    commit: 0386bb36aa ("blame: introduce --override-ignore-revs to bypass
    ignore revisions list", 2024-10-12)

A 'new' test in 'next':

  t2408-worktree-relative.sh
    branch: 'cw/worktree-relative'
    commit: 717af916cd ("worktree: link worktrees with relative paths",
    2024-10-07)

A missing test which (as you know ;) ) is in maint:

  unit-tests/t-reftable-reader.c
    commit: 0a148a8eda ("reftable/reader: make table iterator reseekable",
    2024-09-16)

Hmm, this is going to be a PITA as far as maintenance is concerned! :(
If I am reading it correctly, the cmake solution uses file globbing
to get the list of test files to run - could meson do the same?

ATB,
Ramsay Jones



 t/meson.build | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/meson.build b/t/meson.build
index 152fd7dc13..a956e6db75 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -43,6 +43,7 @@ unit_test_programs = [
   'unit-tests/t-reftable-block.c',
   'unit-tests/t-reftable-merged.c',
   'unit-tests/t-reftable-pq.c',
+  'unit-tests/t-reftable-reader.c',
   'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
   'unit-tests/t-reftable-stack.c',
@@ -166,6 +167,7 @@ integration_tests = [
   't1014-read-tree-confusing.sh',
   't1015-read-index-unmerged.sh',
   't1016-compatObjectFormat.sh',
+  't1017-cat-file-remote-object-info.sh',
   't1020-subdirectory.sh',
   't1021-rerere-in-workdir.sh',
   't1022-read-tree-partial-clone.sh',
@@ -295,6 +297,7 @@ integration_tests = [
   't2405-worktree-submodule.sh',
   't2406-worktree-repair.sh',
   't2407-worktree-heads.sh',
+  't2408-worktree-relative.sh',
   't2500-untracked-overwriting.sh',
   't2501-cwd-empty.sh',
   't3000-ls-files-others.sh',
@@ -716,6 +719,7 @@ integration_tests = [
   't5703-upload-pack-ref-in-want.sh',
   't5704-protocol-violations.sh',
   't5705-session-id-in-capabilities.sh',
+  't5710-promisor-remote-capability.sh',
   't5730-protocol-v2-bundle-uri-file.sh',
   't5731-protocol-v2-bundle-uri-git.sh',
   't5732-protocol-v2-bundle-uri-http.sh',
@@ -818,6 +822,7 @@ integration_tests = [
   't6500-gc.sh',
   't6501-freshen-objects.sh',
   't6600-test-reach.sh',
+  't6601-path-walk.sh',
   't6700-tree-depth.sh',
   't7001-mv.sh',
   't7002-mv-sparse-checkout.sh',
@@ -944,6 +949,8 @@ integration_tests = [
   't8012-blame-colors.sh',
   't8013-blame-ignore-revs.sh',
   't8014-blame-ignore-fuzzy.sh',
+  't8015-blame-default-ignore-revs.sh',
+  't8016-blame-override-ignore-revs.sh',
   't9001-send-email.sh',
   't9002-column.sh',
   't9003-help-autocorrect.sh',
-- 
2.47.0
