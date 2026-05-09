Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7288C346E74
	for <git@vger.kernel.org>; Sat,  9 May 2026 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778334262; cv=none; b=ABwEBrPzsmgvcYrH9XgQ5WBsi5a+aiusF89kA4yEzBFrU+xwfz6XraST4GImz7Kq4jkH6zSgtaMHDKbcVlKbM2eoyGASWSKK1DDKnGdMC1QJGiHw07MLVk34Mx5tGG/o3ae+Hb7ElExtgrZDydPkXIR0DzMUHoZqg2EaVwzMXHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778334262; c=relaxed/simple;
	bh=9R3bRLLc0ewber+ADzVrEa2BqcI3MIUCTzy7xEAbrrg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqSE2R9nweMx9GpSTBeGSWVzOLkCDF6LRYYkQkiywLKKcu51DYMEL7xbdK8lhtNMQQjXozKG+1pb9uErbEP34c4rMFleJ5yci8rPoBCap1SCYweFLAchhMRBRW1RJ++HV1pNKx18Ygfi4MPH6mEF9ljQLGXVj/ByrOHKI1rlUWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=QsKn8Kb9; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="QsKn8Kb9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778334248;
	bh=a9jOYjJuvL2L7rGJDWhmSf+OAKkjBz5dHuVvoxgdnyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QsKn8Kb9FmTvf4n+KsM147Rq/2TF5+adJvltHb5BNwLTnBUm10vXWFbx1zliN+mOV
	 ioE7myphP1ln2CQ8QOZ1/K0T4DI+Igc4ry1d/EoBipggyth6FcHjmhZyP8qHP2lCLP
	 1Y2YPeLWtx4RTiasBlVEwR8QapL1KGKxX7/0T8jI=
Received: from localhost.localdomain ([58.209.116.75])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id B052222E; Sat, 09 May 2026 21:44:05 +0800
X-QQ-mid: xmsmtpt1778334245th80eqowb
Message-ID: <tencent_66A1C2CDB9D5B764A5B4468D3F11845A2A09@qq.com>
X-QQ-XMAILINFO: Ml7LbUPF84oOIRwKlsedD8Z3pYBmqejOpNuH0wI1TixSEtR3s+Z3hGbQa5K1Qg
	 ExBw4WdV6rcTBuDbgLVHjJ8QmpgW6whyjL4Hzxls9+16oQDzoJfOckWC9sqiT5WtBQ0vWz9wfrFp
	 Px2a/CtY2fMpy+4a+hdzl/qJ+2lhJDBoAJyMkRbUR7VXiORbMjZEdqKylobzDrIfNEo8Oz0VLN+V
	 fcUtX3U9jo3y5pqBv3vorX9nrNF9vOwHB41oVEZz69M0i0LSf2aAYVlXCXGlBa3G8uVRmZ3WDcUs
	 Q6iQPaOEDtQBtxDme9SRkUOovQEGfLSuVSVlkTVIL7DcRO6reMNojjLEAxN8J9m2SZ2os8o4Fg3e
	 VJw84UuoSRSNZ7I4LakAp3IH/L4jPhnI/pwegQr+A+N6EHmAfDmToIAsY1OSWCQ1sZ+o9IWEexYb
	 /I4vG/H84Iijxe9zkWAI9oGT97Z6ZVDJ+uuAQO6cieGcOBOJhxU78JswNpwT+BQ3/7km57zcsAot
	 sImwC8GartaFgen1NcYhM7sLb/c+BKkQESb2u/5OcO2YlXZOMxlcr8bx8/9e7pbMJagXBpvo1d7e
	 qSYV6BxQATMLXohR5G/2qWradx1aRblFuSFNcGj+YkOnqrVoEwcLiW/0h5GkdgJ2cnu3IvbGElIP
	 ZYyqoml/Z8Epv4KK7hjapvOj0C2ADjJUPqhoaInhAVaj0KwCYvdazVpL5Z16x9HmE0I4Q894+9YT
	 vhDOJKn8TYEVBDlVg/d6C3oVhddUpIq+d8FtJakTgYpeV1eufgT3sRlX4HQxR3/1laeUv5Q+kwiA
	 ghPKJn5oaZQB1Mucc1O5tII/BMkB3XELESSAxFRhIKqTg3NGSiQm7c/bZleFl1T5hzTYsnJ+qape
	 kO2dOc5eN3i9JXstgbavgSyG6cbApglOH8zwan9qtaWxCULp20Uf4sz0fJZ7BHcWsCnUIicegqbx
	 4EjWdsCNFsUpQuigubxcAOltgpc6QNnMDjbIoYL9SjkEuyxt8v4LL//3DC2/fP/dKZCc+ObcGlTL
	 esc3ILhtd8XbR+zrdxDSEmBWwZ2qpxnEptyE8l+w==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Aina Boot <bootaina702@gmail.com>,
	Shroom Moo <egg_mushroomcow@foxmail.com>
Subject: [PATCH v7 0/3] git-gui: robustify startup and fix environment handling
Date: Sat,  9 May 2026 21:37:52 +0800
X-OQ-MSGID: <20260509133756.1367-1-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <tencent_DDD6467B3F6184562B51C23BB9DBB79EA409@qq.com>
References: <tencent_DDD6467B3F6184562B51C23BB9DBB79EA409@qq.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series addresses the startup crash introduced by Git commit
"2d92ab32fd ("rev-parse: make --show-toplevel without a worktree an
error", 2019-11-19)", which causes `git gui` to die with a Tcl error
when a worktree is missing (e.g. inside a .git directory without a
working tree, or in a bare repository).

Additionally, it resolves two historically inconsistent behaviours:
- The "Visualize ... History" menu items were enabled in bare
  repositories but triggered Tcl errors due to the missing worktree.
- `GIT_WORK_TREE` and `GIT_DIR` environment variables were not
  respected early enough, so `GIT_WORK_TREE=/some/path git gui`
  often ignored the explicit worktree and brought up the repository
  picker, and an exported empty `GIT_WORK_TREE` confused commands
  like `git branch --show-current` in bare repositories.

Shroom Moo (3):
  git-gui: restructure repository startup
  git-gui: disable gitk visualization when no worktree available
  git-gui: handle GIT_DIR and GIT_WORK_TREE early

 git-gui/git-gui.sh | 187 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 141 insertions(+), 46 deletions(-)

-- 
2.52.0.windows.1

