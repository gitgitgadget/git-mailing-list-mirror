Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124B1C8D7
	for <git@vger.kernel.org>; Sun, 21 Jul 2024 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721594804; cv=none; b=NzN926zpFLu7i3ibJSJ2kToeMwf39D3x1hV9o/IzAL4T9LqqCTLD9kA4bC5895PMQTmI8rOnXTMn5gr527N/IBl0tX/2MpR62Nur9PRpvUY5hk0Q1fG3Ca1Nare93W0xC53z3eMOWMSJa+1NAR2RE1poironnwnNGLEtYmwQIuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721594804; c=relaxed/simple;
	bh=p9yRByLNVsPJauTQTQYfr2DDz+oYzi8FjJus35YlDuY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UjYIbMSlCliC7CA2i4ZyCMWqgT8337bMdLdwFrsTEMxEJEWRzpjp+tzFae4o9RjFe9gaiPp9/zI9bNTAY+uMqh+ItIPZ1IQY5XWij15vmgNTAxVXsRrInVnEjFSM0IpV2+AjteP5PEgOA7qdnijScFIrJgncFnNL+VtYk9tD2n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=ODQFwrxP; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="ODQFwrxP"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id VdOzsQwCRdfdlVdP0sTWOC; Sun, 21 Jul 2024 21:43:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1721594611; bh=nV51CfjtpFy/l9KH/B0uw+M2hdt3dB283oirKmgFMG4=;
	h=Date:To:Cc:From:Subject;
	b=ODQFwrxPIMeYBw+x8pdv6qGF6gLogQb6AFtAs3ZdpdbSE/YtS9SdekB0a3FKGjiMN
	 fsFSq+1IEnjFb8Cbbznqd7ateKUkQmYFxa2AzYAR82TCmnQx+5iGOuw5BkmKG3cx5e
	 Tm/STBTgK7nCPJTFyQNNb24+zhf5FS1EcqyNNmOjq5DNy9kcQE7/1vJuuk7zIjgMC9
	 e8IWUP775syeR8G60h7YdClsIWsoc9oq97OIla8obpCmIQPahIigSIoVD07mr182/f
	 ojvMQa0GuuAfXu8R+xkJR+6y5sLLiwnXIWn6HXVoCtlegzwpTYpEMQzgvBgFb9v0AQ
	 DBajHuqvHnDhw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=DtP1+3/+ c=1 sm=1 tr=0 ts=669d72f3
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=TWQvlKnluaRQ4y2WY4MA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <57f9a518-8b71-442e-ae21-58b283b073a9@ramsayjones.plus.com>
Date: Sun, 21 Jul 2024 21:43:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: seen branch dirty after 'make clean'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBdf4r2DxeCG319L+/JpRNCpWYPE+cKGxODmPR3Wnbn5isKvFUBQAi6k5RAh3xKUkFvgkN5AHXaKrvmk0GfAEGWahGIjabI2EmhRBiw8QNcB5NCssi7X
 LyM0PzdftVoodpVTT2V1sMLAFyti70VAsW0YX97FzBs1MhzlKHG+AEnt1cNis1eeNrf44kuuZdhvkr99nLmt+8zwhGRk1cr7Cu8=


Just a quick heads up; with current seen branch, if you do a 'make clean'
before building (as I routinely do), then:

  $ pwd
  /home/ramsay/git
  $ 

  $ git gcs HEAD
  19a89823f5 ("Merge branch 'pw/add-patch-with-suppress-blank-empty' into seen", 2024-07-20)
  $ 

  $ make clean >/dev/null
  $ 

  $ git status -uno
  On branch seen
  Your branch is up-to-date with 'origin/seen'.
  
  Changes not staged for commit:
    (use "git add/rm <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working directory)
  	deleted:    Documentation/docinfo.html
  
  no changes added to commit (use "git add" and/or "git commit -a")
  $ 

  $ git describe --dirty
  v2.46.0-rc1-129-g19a89823f5-dirty
  $ 

  $ git restore Documentation/docinfo.html
  $ 

  $ git status -uno
  On branch seen
  Your branch is up-to-date with 'origin/seen'.
  
  nothing to commit (use -u to show untracked files)
  $ 

  $ git describe --dirty
  v2.46.0-rc1-129-g19a89823f5
  $ 
 
This is because commit dbc2de902e ("asciidoctor: fix `synopsis` rendering",
2024-07-20) adds a tracked file (Documentation/docinfo.html) which the clean
target deletes (via *.html).

ATB,
Ramsay Jones

