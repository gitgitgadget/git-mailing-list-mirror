Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABA0280331
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208905; cv=none; b=AjRcMYeIRQgU4xmLEeO+RT1mKGfvwev3rhVdpF+T6uUBLk0nHrZ7xbQPt7KjAuJffT6wABcBYtuffJ3Wtw1JsA/z9vGnrnYWHyOvipjhD+5ks3Sghj/EuaxIXmLxOP0l8WR4Zcg0IPCoT8+QqB3FZAE5zjo3EqpWpe0LC7Arx8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208905; c=relaxed/simple;
	bh=JPXPbN/BTSGQEeGO99JD4MyWvjer4luILjZ9CjDJvpU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=BpMRn+mwY6wQWTffuEqG73YUxv1yuIKYDk43VsH0S5Ez+9XiggqrPi7QySSyS7cb3tudPL7Qtdru/CZiHcvBaIhoZPXsYtdGYJLAHI3a6DV9IxCz4j5XUX51o3jyUGpbQNNIqABoQBVewXXqKpFhSaZzfRoA0cYHqZJNefU9URc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4bml5q5Wypz7RMhC
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 19:45:03 +0200 (CEST)
Received: from [192.168.1.102] (089144220187.atnat0029.highway.webapn.at [89.144.220.187])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4bml5f0BSkzRnlJ;
	Tue, 22 Jul 2025 19:44:53 +0200 (CEST)
Message-ID: <a13a5626-c5f8-43af-84cd-a3dec0d0095b@kdbg.org>
Date: Tue, 22 Jul 2025 19:44:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] gitk: Sync with 2.50.1, Tcl >= 8.6, git >= 2.20
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Many of the commits listed below are already in git.git via v2.50.1.
Additionally, with this version, we require more modern Tcl/Tk and Git.
New features are:
- Refs in the refs dialog are sorted by kind (local, upstream remote,
  other remote, tags, other refs).
- SHA256 repositories are supported.

The following changes since commit bfb0fa7099e541c15d103b75f453f613a751da03:

  Merge branch 'top-panel-search-highlight' of github.com:bnfour/gitk (2025-05-22 19:15:31 +0200)

are available in the Git repository at:

  https://github.com/j6t/gitk.git master

for you to fetch changes up to 2d3f3f01270a47bed15db774b577b22a9c9c8d9e:

  gitk: remove header of now empty section "General options" (2025-07-22 18:34:21 +0200)

----------------------------------------------------------------
Avi Halachmi (:avih) (1):
      gitk: encode arguments correctly with "open"

Johannes Sixt (20):
      gitk: treat file names beginning with "|" as relative paths
      gitk: have callers of diffcmd supply pipe symbol when necessary
      gitk: sanitize 'exec' arguments: simple cases
      gitk: sanitize 'exec' arguments: 'eval exec'
      gitk: sanitize 'exec' arguments: redirections
      gitk: sanitize 'exec' arguments: redirections and background
      gitk: sanitize 'exec' arguments: redirect to process
      gitk: sanitize 'open' arguments: simple commands
      gitk: sanitize 'open' arguments: simple commands with redirections
      gitk: sanitize 'open' arguments: simple commands, readable and writable
      gitk: collect construction of blameargs into a single conditional
      gitk: sanitize 'open' arguments: command pipeline
      gitk: sanitize 'open' arguments: revisit recently updated 'open' calls
      Merge branch 'ah/fix-open-with-stdin'
      Merge branch 'js/fix-open-exec'
      gitk: choosefont - remove a stray debugging line
      Merge branch 'ti/support-sha256'
      Merge branch 'mr/sort-refs-by-type'
      Merge branch 'ml/abandon-old-version' (early part)
      gitk: remove header of now empty section "General options"

Mark Levedahl (15):
      gitk: require git >= 2.20
      gitk: remove code targeting git <= 1.7.2
      gitk: Make TclTk 8.6 the minimum, allow 8.7
      gitk: remove implementations for Tcl/Tk < 8.6
      gitk: use $config_variables as list for save/restore
      gitk: always use themed Tk (ttk)
      gitk: replace ${NS} with ttk
      gitk: remove non-ttk support code
      gitk: separate x11 / win32 / aqua Mouse bindings
      gitk: wheel scrolling multiplier preference
      gitk: mousewheel scrolling functions for Tk 8.6
      gitk: update win32 scrolling for Tk 8.6 / TIP 171
      gitk: update x11 scrolling for TclTk 8.6 / TIP 171
      gitk: update aqua scrolling for TclTk 8.6 / TIP171
      gitk: allow horizontal commit-graph scrolling

Michael Rappazzo (3):
      gitk: sort by ref type on the 'tags and heads' view
      gitk: make 'sort-refs-by-type' optional and persistent
      gitk: separate upstream refs when using the sort-by-type option

Takashi Iwai (1):
      gitk: Add support of SHA256 repositories

Taylor Blau (1):
      Merge branch 'js/fix-open-exec-2.40.0' into js/fix-open-exec

 gitk | 1405 ++++++++++++++++++++++++++++++++----------------------------------
 1 file changed, 671 insertions(+), 734 deletions(-)
