Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61DF2BE7D7
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527202; cv=none; b=DraFI4EOrnykbkXuhVtaWJ058m0g0+Ye+SRgrB7Av0rhnGObx23IFL32JlPSuwKEjaa3MovAjCpQN7sGvYX3hW/1U8kJZpTeeVQhasNEjyn2TdNdaUn0I10UW4rurT4A/e+uoMSW6h3rOVL9x/lIfUf7WHiK5VURRMW4e1xaq1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527202; c=relaxed/simple;
	bh=I2V1QFZEJwuOZoBQrsfRd17pPLb/nTavtuveMs2T5p4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=aZr4d2q7oVNMg+gRuGJz+F8UeFL70hybu8rtFLaJH3w6xb+KfOQ6bfCG9/Ifd9dpavP0rlchptc6jMGoRQ2WSQIhCXYRZKfYK8cp+lrcWJ+/nmimIl0cuL8NqsdDhIINlXJDi6CJXQUSmC/6edNjHlPFMSdpMekYG5iPN6T15wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4cMS3Z5Jvsz7QXw4
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 19:14:34 +0200 (CEST)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4cMS3P3mMLzRpKJ;
	Wed, 10 Sep 2025 19:14:25 +0200 (CEST)
Message-ID: <4ceca07d-f9b2-4826-92c4-14c95d47fc70@kdbg.org>
Date: Wed, 10 Sep 2025 19:14:25 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] git-gui: question helper, fix Revert Changes
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit e3923e3e90da55e12545b5ef5aa34f21e97409d8:

  Merge branch 'cb/no-tcl86-on-macos' (2025-08-04 18:27:03 +0200)

are available in the Git repository at:

  https://github.com/j6t/git-gui.git master

for you to fetch changes up to 7ef77ec0054b3b4ef3cfee6ef97c43c01965be88:

  git-gui: sync Makefiles with git.git (2025-09-06 11:59:48 +0200)

----------------------------------------------------------------
Adam Dinwoodie (1):
      git-gui: sync Makefiles with git.git

Heiko Voigt (1):
      git-gui: provide question helper for retry fallback on Windows

Johannes Schindelin (3):
      git gui: set GIT_ASKPASS=git-gui--askpass if not set yet
      git-gui--askyesno: allow overriding the window title
      git-gui--askyesno (mingw): use Git for Windows' icon, if available

Johannes Sixt (3):
      git-gui: fix error handling of Revert Changes command
      Merge branch 'js/ask-yesno'
      Merge branch 'ml/misc-simplifications'

Mark Levedahl (2):
      git-gui: simplify PATH de-duplication
      git-gui: simplify using nice(1)

 Makefile             |  3 +++
 git-gui--askyesno    | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-gui.sh           | 42 ++++++++++++-----------------------
 lib/index.tcl        |  7 +++++-
 po/glossary/Makefile |  3 +++
 5 files changed, 89 insertions(+), 29 deletions(-)
 create mode 100755 git-gui--askyesno
