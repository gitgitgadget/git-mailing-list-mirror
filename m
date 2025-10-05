Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0795B1E990E
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759663920; cv=none; b=eRE8psKBsz7Esjsbg2L9JDP4yoJLare0aDtSHImQ3qWMbp4UnafVbvnyMvoZvHqHkUr6nkzxtUNYJOjGh1kfy2lx4QkM+sLaQEb1MhD+7wxgBHhGAy3Z4B1eiSc274et8eZOhGMVbb8XlURZS3oSSPNnf2ip+Dsk0g3Vgdwq+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759663920; c=relaxed/simple;
	bh=0nISw42WsEEWghne4cvuKxkh/CzydQbU5loZ3Xz66po=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=S7L0WlWJp5acpTvutoyyQvS7mSWGVCjFQInX3haqB3W8uBfNFcVXy+zRwaiIkZgnXIuUmYNc7OGN5bXV7QyLlDKsL4Ivrn2ITSZHfn8/hnuSFHBNxRGs4R5RZOtR4WVsWOWhyo4NVT6URNfwRbgcXfWa7UOjR5lM/Wtjdq0Zfgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4cfgGg666Vz7QgGt
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 13:31:55 +0200 (CEST)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4cfgGV4BwfzRnQP;
	Sun,  5 Oct 2025 13:31:46 +0200 (CEST)
Message-ID: <91ef957d-2acf-4d74-9427-e2eac5316067@kdbg.org>
Date: Sun, 5 Oct 2025 13:31:46 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] gitk: UI themes, osascript fix on macOS, fix absent remote
 tracking branches
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit ac8fec7d8de265e56441713faaf4e08f11c31469:

  gitk: add README with usage, build, and contribution details (2025-08-28 19:51:31 +0200)

are available in the Git repository at:

  https://github.com/j6t/gitk.git master

for you to fetch changes up to c435c515dad872532705d45d9ff81d3f4af22d6d:

  Merge branch 'ml/themes' (2025-10-05 13:09:49 +0200)

----------------------------------------------------------------
Eric Sunshine (1):
      gitk: fix MacOS 10.14 "Mojave" crash on launch

Johannes Sixt (3):
      Merge branch 'mr/sort-refs-by-type'
      Merge branch 'es/ignore-osascript-failure'
      Merge branch 'ml/themes'

Mark Levedahl (13):
      gitk: use themed spinboxes
      gitk: make sha1but a ttk::button
      gitk: use config variables to define and load a theme
      gitk: do not invoke tk_setPalette
      gitk: use text labels for commit ID buttons
      gitk: use text labels for next/prev search buttons
      gitk: eliminate Interface color option from gui
      gitk: eliminate unused ui color variables
      gitk: add proc run_themeloader
      gitk: add theme selection to color configuration page
      gitk: make configuration dialog resizing useful
      gitk: separate code blocks for configuration dialog
      gitk: set minimum size on configuration dialog

Michael Rappazzo (1):
      gitk: fix error when remote tracking branch is deleted

 gitk | 283 +++++++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 164 insertions(+), 119 deletions(-)
