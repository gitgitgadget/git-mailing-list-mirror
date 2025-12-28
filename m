Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F056223A984
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766945462; cv=none; b=MfRPR7WZbEUcbansRfu3meBQ3O18pfZKbReh4gvcZeGY4CeeCQmMmErUpTdQ/+Wf2XHr1V7k7SyLLvBdIvuTRhxJLsD5d5plrXJvVVj9OEJS5iYlepkzxR7INY5Il6/bkFNzfHlL9pOMm6y7rbuSwU22p+wBvAwbrdLqZwykwmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766945462; c=relaxed/simple;
	bh=qKCeV6zotuqzUbYzG4UdV5Fm/X+tTlBasybT9HdQUHk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AjFJUafGXDXyHRQ77S5cyFaeK9bhgmokPY17PV9MUd/LvzoBfQ+JfNKlnkJw8JhV+GiuvMARVoW0QGURJpJvxby2btHT7k88VBe4m8Y6Mxe3TMJQaG3B7oSxbUkxsGKwvjEwpSOZA0/WYqmOSQRutwhHXk5WdAUXKFkbdnWDtqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=dEJNFuqJ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="dEJNFuqJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766945451; x=1767550251; i=l.s.r@web.de;
	bh=i2vCF3psZ4CqNou+ZnCcVHrdmg+FPPyx+UAQGt6uIXU=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dEJNFuqJJYE/0Wh6NmRnep0j7kVDzuTCU53im2XZs0CLu/wQAEBNCZUKrJXj84FW
	 9JT/HsMgn2GVkdo1eAvOB9cdPlpPhblZWRhJUkVWYET3kKfJzNaWyypwBEc8ko3Ww
	 YvyoNcAwxIp1ulS9Eu5yEf6qjUVP6TGL+cfTB1YnrQiF+uLhixchuEL+nZ/aHQal2
	 U3VvNFPXBtOogcxAgypu52QfY2yRqYJovgkH/OqwhulQM9J3H8+ojD5gNcm8+L8Pg
	 dX4HgqZNGjQ7Zs2H0Rv8SUDYzeXXh6UxGNF8sgGn1gh14Xag/wl0mBlTu3vR+s7kZ
	 +vb600UNHY33cPCNLw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.18.156]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MECGX-1vjW8M2U33-008xeq for <git@vger.kernel.org>; Sun, 28 Dec 2025 19:10:51
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 0/4] tag: stop using the_repository
Date: Sun, 28 Dec 2025 19:10:47 +0100
Message-ID: <20251228181051.68724-1-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:geu3wbrctj2xuAFidA2QiOYtDzw5dMzIJc08z/GwRfS32lfR2I/
 qMtVhgW9TeezpAOAtOzCXI/nVsnL5gCJzMV7w6b9cMgG5obI1iIOkHeBKBBeT65HBRMSpTG
 dZA4RAV3eDsbxdGMFLN14MPgAsSa9YJJDGHPCcEQI2D8lSaqK65Ez0J0OQk9lAblhD7U73p
 bKEwcxzdFjRnoC0tuEegA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WnMDvqeFOUk=;AolxSN5x1Q6WEc78XXDO2jyOIeS
 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

Push the use of the_repository and the_hash_algo from the tag
functions to their callers.  Also converts some cases of implicit use,
which seem unintended.

  tag: use algo of repo parameter in parse_tag_buffer()
  tag: support arbitrary repositories in gpg_verify_tag()
  tag: support arbitrary repositories in parse_tag()
  tag: stop using the_repository

 builtin/describe.c     |  6 +++---
 builtin/pack-objects.c |  2 +-
 builtin/tag.c          |  2 +-
 builtin/verify-tag.c   |  2 +-
 fsck.c                 |  2 +-
 object-name.c          |  2 +-
 ref-filter.c           |  2 +-
 tag.c                  | 27 ++++++++++++++-------------
 tag.h                  |  4 ++--
 walker.c               |  2 +-
 10 files changed, 26 insertions(+), 25 deletions(-)

=2D-=20
2.52.0

