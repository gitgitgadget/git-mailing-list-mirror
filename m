Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E62B67F
	for <git@vger.kernel.org>; Thu, 29 May 2025 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748506065; cv=none; b=icJB6V0wAzJQcgZlK7tlyodtrDI9LCVsMpz0Kn5VIYE3SIASMfkOiy066orqKlbmMJ/M3nIsYd/y9zyhKWS2Lq27vQX4Teg3IggKpKq9t7TTyX9YiWegeuP4CYlGG3dWw0pYbo7ZSCG5E1XWUC13zGjZwMW6D1kzFfeJuP4LY8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748506065; c=relaxed/simple;
	bh=vW4H3vIcclgOwKQwjdbgU4nUBhJDPhRkSfUPwltbVoQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=HyvsDBOyVfMaZ5RpVeuFFPIJIGBJJQVD1aJgqvYvBj6YpqXGv6M0UfzOWxSXFeh/FQaDaGPVkCq1HnLk2q/yTOxmy9zMRNG8unyWYpsjj3XRP7Rd18//jazXTBDrYB0MsBfTLnTnaGSofty7VKOyHV7VyZYcTwuM1sZfaN+5ne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4b7JrR2yGyz7QXZ2
	for <git@vger.kernel.org>; Thu, 29 May 2025 10:07:35 +0200 (CEST)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4b7JrG1pmSzRq1X;
	Thu, 29 May 2025 10:07:25 +0200 (CEST)
Message-ID: <d92e7ef9-615e-4f35-b091-cfae64f4888e@kdbg.org>
Date: Thu, 29 May 2025 10:07:25 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] git-gui: Meson build system
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit 309bb874dcba2c96f8b12d20bed16cf6a1ea0133:

  Merge branch 'js/po-update-workflow' (2025-05-09 19:17:19 +0200)

are available in the Git repository at:

  https://github.com/j6t/git-gui.git master

for you to fetch changes up to 61f8788fe9d362efb112f69a58cf0510a7e49ee0:

  Merge branch 'pks-meson-support' of github.com:pks-t/git-gui (2025-05-29 10:01:14 +0200)

----------------------------------------------------------------
Johannes Sixt (1):
      Merge branch 'pks-meson-support' of github.com:pks-t/git-gui

Patrick Steinhardt (10):
      git-gui: replace GIT-GUI-VARS with GIT-GUI-BUILD-OPTIONS
      git-gui: prepare GIT-VERSION-GEN for out-of-tree builds
      git-gui: make output of GIT-VERSION-GEN source'able
      git-gui: drop no-op GITGUI_SCRIPT replacement
      git-gui: extract script to generate "git-gui"
      git-gui: extract script to generate "tclIndex"
      git-gui: extract script to generate macOS wrapper
      git-gui: extract script to generate macOS app
      git-gui: stop including GIT-VERSION-FILE file
      git-gui: wire up support for the Meson build system

 .gitattributes            |   1 +
 .gitignore                |   2 +-
 GIT-GUI-BUILD-OPTIONS.in  |   7 +++
 GIT-VERSION-GEN           |  44 +++++++++-----
 Makefile                  | 115 +++++++++--------------------------
 generate-git-gui.sh       |  29 +++++++++
 generate-macos-app.sh     |  30 ++++++++++
 generate-macos-wrapper.sh |  35 +++++++++++
 generate-tclindex.sh      |  32 ++++++++++
 lib/meson.build           |  74 +++++++++++++++++++++++
 meson.build               | 148 ++++++++++++++++++++++++++++++++++++++++++++++
 po/meson.build            |  38 ++++++++++++
 12 files changed, 453 insertions(+), 102 deletions(-)
 create mode 100644 GIT-GUI-BUILD-OPTIONS.in
 create mode 100755 generate-git-gui.sh
 create mode 100755 generate-macos-app.sh
 create mode 100755 generate-macos-wrapper.sh
 create mode 100755 generate-tclindex.sh
 create mode 100644 lib/meson.build
 create mode 100644 meson.build
 create mode 100644 po/meson.build
