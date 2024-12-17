Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACA4A23
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470757; cv=none; b=CY87i7jk5OXlqeknSXQY2n7K/6pmaQ3J1ERaTcEQcII6Iqyg+weneOOgZ/tXbdmq1KOGwZe0qXO2tlCWiBdBcbXfBE/VDxk5w9uLmkpCASg5ZNqDnPNpradqCfaNC/fhMK9v6yTV7FEI9D0yM8ftgp65+edciCy7e8z+c6oa9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470757; c=relaxed/simple;
	bh=VKgdMtmVB56++X1cebn1wKXauDOC2rsafO2L8IdIsJw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=imPEVitGf8dwLRdQoFb2ghiOTGxJks/WRvreCH34+3BlgppKRLp1QHcm7QFmcG7LrJ4HhTrZ2jNuj6YG4Rj1r8urT3nwQALvM3oBuu78jITgb6nXp6w1GLTLaVDGIgj5f0CNe7th60u4j8jT3Pv+wVDNU7BVAnmX+sl5k5+//ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4YCVGg6YcVzRpKY;
	Tue, 17 Dec 2024 22:25:47 +0100 (CET)
Message-ID: <ce2827ab-7827-42d6-8fd9-77be18bcda4c@kdbg.org>
Date: Tue, 17 Dec 2024 22:25:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] gitk: macOS startup, commit ID to clipboard, text wrapping
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit c18400c6bb04f4e8875c1930db72ddd9b94649ca:

  Makefile(s): avoid recipe prefix in conditional statements (2024-11-24 13:45:49 +0100)

are available in the Git repository at:

  https://github.com/j6t/gitk.git master

for you to fetch changes up to 661734e6c8c38d2cd2000481ffb22cca6e2b0e5e:

  Merge branch 'ah/commit-id-to-clipboard' (2024-12-17 21:54:58 +0100)

These updates add the following features to Gitk:

 * The commit message and the patch text can optionally be displayed
   with lines wrapped. There are separate options for these two kinds
   of text.

 * When a commit is selected, the commit ID is copied to the "X11
   selection" (to be pasted with a middle mouse click, only available
   on X11). The commit ID can now also optionally be copied to the
   primary clipboard (to be pasted with Ctrl-V typically).

 * Section headers in the Preferences dialog are now better visible.

There is also a bug fix:

  * Starting Gitk on macOS no longer hangs indefinitely.

----------------------------------------------------------------
Avi Halachmi (:avih) (3):
      gitk: UI text: change "SHA1 ID" to "Commit ID"
      gitk: prefs dialog: refine Auto-select UI
      gitk: support auto-copy comit ID to primary clipboard

Christoph Sommer (2):
      gitk: make headings of preferences bold
      gitk: add text wrapping preferences

Johannes Sixt (3):
      Merge branch 'sv-20231026' of https://github.com/nafmo/gitk-l10n-sv
      gitk: offer "Copy commit ID to X11 selection" only on X11
      Merge branch 'ah/commit-id-to-clipboard'

Peter Krefting (1):
      gitk: sv.po: Update Swedish translation (323t)

Tobias Pietzsch (1):
      gitk: check main window visibility before waiting for it to show

 gitk     |  86 +++++---
 po/sv.po | 734 ++++++++++++++++++++++++++++++++-------------------------------
 2 files changed, 439 insertions(+), 381 deletions(-)

