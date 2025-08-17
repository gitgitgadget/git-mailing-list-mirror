Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2838EEA8
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.244.194.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755465023; cv=none; b=QS84SLZ7nvExTKSlxMcUCmSLpSGv1DeVdyZkR8X4b0KsbozjKmajC16rFVhHpyWkgofAoDwILrM88FS14sWN/I5X8YoWIYfX/VT2BxC+cSjMNDwVtYcL+Ms8O+4FjyhX58cakC0ugDCv6UHlN+eXMUGApyroXnSwRUqFyT9nRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755465023; c=relaxed/simple;
	bh=qxsl5qJjYPlI4YJp/h9jqmLuHnyIO4JTgn8+jLWDkL0=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=rs6rvYciL/ys2VDDZ3EJgcSxGI3r+RnzMme6yGS8GZHY2wOUY1rcL0zsXuL4z0kOdvMWoqB37BU9YKYIB1tInXAMLQse1E/HYSQaWVJfM0LEO8P1uIg5y4Ct3f7fNhNyMJagIepJBqnzoL8qtLeN3bd3kkh0xEFcvNkJD6ucVa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de; spf=pass smtp.mailfrom=rd10.de; dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b=VekXlywa; arc=none smtp.client-ip=185.244.194.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rd10.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b="VekXlywa"
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4c4pGC2bkQz94vx
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 23:02:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rd10.de; s=key2;
	t=1755464579; bh=qxsl5qJjYPlI4YJp/h9jqmLuHnyIO4JTgn8+jLWDkL0=;
	h=Date:From:To:Subject:From;
	b=VekXlywaUDv1Itmva43x0Bkb8CtWQmQp9MzZ/V1YZ1KPU5HzKvyMNxflEfnPB42Xx
	 9mZgBH0PRNM0ekFTtScr7Idp1QqEQ16+UXkueOjvh2SnyHW/2wfos4xUJt7fhW8WLC
	 Qf5fCXosCRIms4Asb1gk6qTf9eAjNeF0sykoptPWkSGINfx5sMTL3mcMiszzDify7s
	 jxI4drFJ2tDJPO0agwhzLQAA2oZv14kO7TNu6FNJxuy8b/AC5dnONXNZDqO4blsMWg
	 B0PE8YQsaHx7s8ufoxD/wO1lEQvi/zfTJMLFcmYKlcPkXfFFT0egW/i0Djq2TH5Zji
	 FISM/hmMUmXQg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4c4pGC1v7Gz7wfY
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 23:02:59 +0200 (CEST)
Received: from mx2eb1.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4c4pGC0MsWz8scg
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 23:02:59 +0200 (CEST)
Received: from [IPV6:2a02:3102:8e00:2060:29c6:3163:3c04:c7fe] (dynamic-2a02-3102-8e00-2060-29c6-3163-3c04-c7fe.310.pool.telefonica.de [IPv6:2a02:3102:8e00:2060:29c6:3163:3c04:c7fe])
	by mx2eb1.netcup.net (Postfix) with ESMTPSA id 83258100207
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 23:02:54 +0200 (CEST)
Authentication-Results: mx2eb1;
        spf=pass (sender IP is 2a02:3102:8e00:2060:29c6:3163:3c04:c7fe) smtp.mailfrom=rdiez-2006@rd10.de smtp.helo=[IPV6:2a02:3102:8e00:2060:29c6:3163:3c04:c7fe]
Received-SPF: pass (mx2eb1: connection is authenticated)
Message-ID: <4398af77-3183-4ac5-9a25-aca6289d8c8f@rd10.de>
Date: Sun, 17 Aug 2025 23:02:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "R. Diez" <rdiez-2006@rd10.de>
Content-Language: en-GB
To: git@vger.kernel.org
Subject: Graphical tool to merge and reorder commits
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <175546457473.30031.13798634689934687344@mx2eb1.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 83258100207
X-NC-CID: T/2b4q0+2uB0xao8Amy6pzPbIIWKA38BhjQzwGi4

Hi all:

I find merging and rewriting the commit history with Git difficult.

Is there some graphical tool to merge and reorder commits with the mouse? Or failing that, a good terminal interface with menus and the like which allows merging and reordering in an easy, visual fashion.

Here are more details about what I mean. Say I have this commit history:

  A - B - C [master]

I want to visually create a test branch first, by dragging commits B and C together (merging them), and then appending commit A afterwards:

  A - B - C [master]
  BC - A [test]

Maybe I need to manually merge or fix some commit in the middle of the test branch. I can do that with the normal Git tools and commands I already know. Then I want to keep visually adding commits to the test branch.

That is, I want to build the test branch mostly interactively with the mouse. While doing that, I would like to click on the nodes and see the commit messages and patches, like with git-gui.

If I manage to complete the test branch (and it compiles cleanly), I then want the test branch to become master, like this:

  A - B - C - D [now orphaned]
  BC - A [master]

Ideally, I could drag the tag, or right-click on one node and assign a tag.

I know I can probably find out all the relevant commit hashes by hand and do all the merging and rearranging with the command line, but even though I am normally a console and command-line fan, I find it especially hard with Git.

I have tried or investigated numerous Git tools: git-gui, gitk, Gittyup, GitUI, GitButler, SourceGit, git-cola, Guitar, gitg, tig, giggle, qgit, RabbitVCS, Magit, lazygit, ... They are all fine for normal commits and the like. However, most fall short fairly quickly. For example, the ability to highlight character or word-based changes inside a text line is rare. And none of them really appealed to me when merging, let alone rearrange commits visually.

Thanks in advance,
   rdiez
