Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F355B165F13
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325167; cv=none; b=BOjclPPhEqCK0AlrMuQI6poDZ48uC8tgVoo3C/0at5bFl5DQnGx0F0WICpGLmgs+vF2aIMZ9Zma9ZN0yLoUDaPbCdAK9aDhtjEs6q5mtTaNULCN/i8KHL+xHADRtVTCUaoCsbYlVpVjH95Cpsi3YGnL9713b/nI2zEqXjWh9NaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325167; c=relaxed/simple;
	bh=BMtHLmSq6d3jC0EVdrm3Y4YPT1203VhhexD9Dcx6OOQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=BFNgauXZFIhGyRleif+N6+pyF3GjTtzPbDmbmJsngkEggv9pCXrNaBFUETqCA4n2m2WMb2/Wy1jn0vC7QZWIU+6uyjispYtiMvVb+vFVibbc85EHaDlw7+ZdMhjLrVB5maN2Xk77eDJZqtGRAJm7D+APPI+IFZRvEGhAjlSH2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4bwhtC5nPhzRnPp;
	Mon,  4 Aug 2025 18:32:35 +0200 (CEST)
Message-ID: <7ee0ae6e-c28d-4681-8020-c7b8cf072c8e@kdbg.org>
Date: Mon, 4 Aug 2025 18:32:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] gitk: Tcl-9, hide refs by glob, colors in Prefs dialog
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit 2d3f3f01270a47bed15db774b577b22a9c9c8d9e:

  gitk: remove header of now empty section "General options" (2025-07-22 18:34:21 +0200)

are available in the Git repository at:

  https://github.com/j6t/gitk.git master

for you to fetch changes up to 93ff79ed417e8d1afa770b31721ad3640ed2d0ad:

  Merge branch 'docglobs' of github.com:ilyagr/gitk (2025-08-04 18:20:32 +0200)

----------------------------------------------------------------
Alexander Shopov (2):
      gitk i18n: Update Bulgarian translation (322t)
      gitk i18n: Remove the locations within the Bulgarian translation

Ilya Grigoriev (1):
      gitk: Mention globs in description of preference to hide custom refs

Johannes Sixt (7):
      gitk: avoid duplicated upstream refs
      Merge branch 'mr/sort-refs-by-type'
      Merge branch 'master' of github.com:alshopov/gitk
      Merge branch 'ml/abandon-old-version'
      Merge branch 'oa/hide-more-refs'
      Merge branch 'ml/tcltk-9'
      Merge branch 'docglobs' of github.com:ilyagr/gitk

Mark Levedahl (8):
      gitk: set config dialog color swatches in one place
      gitk: restore ui colors after cancelling config dialog
      gitk: update scrolling for TclTk 8.7+ / TIP 474
      gitk: switch to -translation binary
      gitk: Tcl9 doesn't expand ~, use $env(HOME)
      gitk: use -profile tcl8 for file input with Tcl 9
      gitk: use -profile tcl8 on encoding conversions
      gitk: allow Tcl/Tk 9.0+

Michael Rappazzo (1):
      gitk: filter invisible upstream refs from reference list

Ori Avtalion (1):
      gitk: Add user preference to hide specific references

 gitk     | 185 ++++++++++++++++++++++---------
 po/bg.po | 375 +++------------------------------------------------------------
 2 files changed, 146 insertions(+), 414 deletions(-)
