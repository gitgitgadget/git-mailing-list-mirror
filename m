Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8A13CFBA
	for <git@vger.kernel.org>; Fri, 10 May 2024 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379173; cv=none; b=gHhFMYfhB4t3cwwi8epdJWei7e5VgPgFMdItXiM0WaiDDXCmjmeqBeOivV9GZ60SFmVcz8igpH0E+QTw+s/D+evbVVxptyMVTNwWUOMIigxBB45LsTwXyRaFQf067mOFjWg/TCA0ZO00mOiD3Q6QprTlo5xbihHDIwtLJZOaqjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379173; c=relaxed/simple;
	bh=4hMSnIZYfaZih9zZ5SxsFEBnWpJdXHDzLrRS2enqesM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=p6rf69bagNPyBGWxmYPTg6Ebh18SIjgJiZmqkO0k3JHUvTB50DPDVrdqJ/swyQvPBcBl8AtZnPTeqqy+3ImJhFsG/71BiGXob+JTjwC9SBs5p5Wgzm6fhx+figIvj3Ra4ylNa7PqSUqsY41gL1IPKulPa2T0vUm0DTkLsJVTD/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr; spf=pass smtp.mailfrom=online.fr; dkim=pass (2048-bit key) header.d=online.fr header.i=@online.fr header.b=YKYHr7b2; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.fr header.i=@online.fr header.b="YKYHr7b2"
Received: from [IPV6:2a01:e0a:122:9f40:2c1c:a337:c1ca:2139] (unknown [IPv6:2a01:e0a:122:9f40:2c1c:a337:c1ca:2139])
	(Authenticated sender: thomas.koutcher@online.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 5379019F522;
	Sat, 11 May 2024 00:12:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=online.fr;
	s=smtp-20201210; t=1715379163;
	bh=4hMSnIZYfaZih9zZ5SxsFEBnWpJdXHDzLrRS2enqesM=;
	h=Date:From:Subject:To:From;
	b=YKYHr7b2Eg9MdQ00NxbChJtTG1MwDfNJv7VoY4HlnbK8Hah8w4SClK90MIf8rvkOP
	 HmNQ6NuwGR57TSfog4UTfnyM5Asm9sWpjk6SQRJwocZj7sNOkfZjwKy5Luv9LFQJHq
	 95ZD9wLfqKpTefPVDpefrQxroq3AfKGyltzaCVSSDOLcIHWkyxijONmWWDVYhoZmy8
	 sFTsGZoVzcCX/6ZL6C+B49L+C0Q72N+2z+UDI9kIUrUfv+atYurbyo3eil2mg1im7o
	 pSkkOi3+2+m+OKIA5m/rej+Nc9WMPzKhBkcGvNW86eBAR75WPkF5FOGgEUfbuJ9Z8t
	 R/FJv4iVY++3w==
Message-ID: <63ad4c23-0baf-4c40-aa45-0a35c3bf90dc@online.fr>
Date: Sat, 11 May 2024 00:12:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Koutcher <thomas.koutcher@online.fr>
Subject: [ANNOUNCE] tig-2.5.10
Content-Language: en-GB, et, fr
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I am pleased to announce Tig version 2.5.10 aiming mainly at fixing
a regression introduced in 2.5.9 related to colouring in the status
view. See the release notes below for a detailed list of changes.

What is Tig?
------------

Tig is an ncurses-based text-mode interface for git. It functions mainly
as a Git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various Git
commands.

- Homepage:https://jonas.github.io/tig/
- Manual:https://jonas.github.io/tig/doc/manual.html
- Tarballs:https://github.com/jonas/tig/releases
- Gitter:https://gitter.im/jonas/tig
- Q&A:https://stackoverflow.com/questions/tagged/tig

Release notes
-------------
Bug fixes:

  - Fix `stat-*` coloring file names in `tig status` instead of just
    markers (regression in 2.5.9). (#1326)
  - Fix keybinding with +[cmd] not triggering view refreshing. (#1324)
  - Fix reopening the blame view from the main view.
  - Fix editing when stdin is redirected. (#1330)
  - Fix compilation warnings with ncurses 6.5.
  - Make `Ctrl-C` to kill only the command running in the foreground. 
(#1331)

Change summary
--------------
The diffstat and log summary for changes made in this release.

  INSTALL.adoc      |  4 ++--
  Makefile          |  2 +-
  NEWS.adoc         | 13 +++++++++++++
  include/tig/io.h  |  2 +-
  include/tig/tig.h |  2 ++
  src/blame.c       | 11 +++++++++--
  src/display.c     | 15 +++++++--------
  src/draw.c        | 12 +++++++-----
  src/io.c          | 18 +++++++++++++++---
  src/main.c        |  8 ++++++++
  src/status.c      |  4 ++--
  src/tree.c        |  5 ++---
  src/view.c        |  5 +++--
  13 files changed, 72 insertions(+), 29 deletions(-)

Thomas Koutcher (6):
       Fix keybinding with +[cmd] not triggering view refreshing (#1324)
       Fix reopening the blame view from the main view
       Fix editing when stdin is redirected
       Fix compilation warnings with ncurses 6.5
       Make `Ctrl-C` to kill only the command running in the foreground
       tig-2.5.10

xaizek (1):
       Fix incorrect filename coloring in tig status (#1326)

--
Thomas Koutcher

