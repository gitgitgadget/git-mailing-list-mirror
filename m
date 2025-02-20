Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A71F0E38
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046586; cv=none; b=r/0Fmoei/rEMht2vqQeYN5KmSHbCyv6GQTiQEIdvuEtM0UzR4QcP+GGzTm1b+wx9yM/vQj3kiK4rtS8g4pUWbXK1YA9MH/cKrUYpAm6f3kFUjMKTA7LIe1Z99WWD29xt/4eZXz+Wat7qQrP+FehqhMF6eW3p5zUkJDfw8AuunWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046586; c=relaxed/simple;
	bh=+ZBdV8cP7eLoPooT9gjycdEychAzWlIVbSfDo8NzUFI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=cRNmBuLExbXte1rapQihyZ9I5E11LMoT7ks7fCY3BKRx6nBB2d+usZ0GKGt8FUzc2JVQ+xVHbZU8GaQSl/5Fj6In1DKJeXSkdjI9WE3X0xa9+/8nKxcelcpa3FbAwHorl0PytNNtraqrgy4fgajyJmctJe7ZT0IDlvNgF8Fz5K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Yz8LG58rYz7QV3p
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 11:16:22 +0100 (CET)
Received: from [192.168.1.103] (089144220218.atnat0029.highway.webapn.at [89.144.220.218])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Yz8L71zGrzRnmF;
	Thu, 20 Feb 2025 11:16:15 +0100 (CET)
Message-ID: <94cdb4c6-5466-44bc-ba42-120ae86fa951@kdbg.org>
Date: Thu, 20 Feb 2025 11:16:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] gitk: various fixes for Windows, Meson build
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit e76b53ef23871ff81ab305822eb605baf0cc5bd3:

  gitk: Update Bulgarian translation (327t) (2024-12-24 11:58:09 +0100)

are available in the Git repository at:

  https://github.com/j6t/gitk.git master

for you to fetch changes up to 4a6cc6a20eeb593f1ad0f60475a9867532d7c5d5:

  Merge branch 'pks-meson-support' of https://github.com/pks-t/gitk (2025-02-20 10:54:37 +0100)

----------------------------------------------------------------
James J. Raden (1):
      gitk: make the "list references" default window width wider

Johannes Schindelin (2):
      gitk(Windows): avoid inadvertently calling executables in the worktree
      gitk: fix arrow keys in input fields with Tcl/Tk >= 8.6

Johannes Sixt (2):
      Merge branch 'g4w-gitk' of https://github.com/dscho/gitk
      Merge branch 'pks-meson-support' of https://github.com/pks-t/gitk

Karsten Blees (1):
      gitk: Unicode file name support

Patrick Steinhardt (2):
      gitk: extract script to build executable
      gitk: introduce support for the Meson build system

Sebastian Schuberth (1):
      gitk: Use an external icon file on Windows

 Makefile        |   5 +-
 generate-tcl.sh |  11 +++
 gitk            | 213 +++++++++++++++++++++++++++++++++++++++++++++++---------
 meson.build     |  30 ++++++++
 po/meson.build  |  19 +++++
 5 files changed, 241 insertions(+), 37 deletions(-)
 create mode 100755 generate-tcl.sh
 create mode 100644 meson.build
 create mode 100644 po/meson.build
