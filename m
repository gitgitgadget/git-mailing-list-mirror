From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/5] fix up 'jk/pack-bitmap' branch
Date: Thu, 07 Nov 2013 21:58:02 +0000
Message-ID: <527C0CEA.4020705@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Vicent Marti <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 07 23:15:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeXr7-0008EC-J1
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 23:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531Ab3KGWPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 17:15:05 -0500
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:47225 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755367Ab3KGWPB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 17:15:01 -0500
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id D0E2E40147F;
	Thu,  7 Nov 2013 22:14:59 +0000 (GMT)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 97B9C401471;
	Thu,  7 Nov 2013 22:14:59 +0000 (GMT)
Received: from [192.168.254.4] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Thu,  7 Nov 2013 22:14:56 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237435>

Hi Jeff,

These patches fix various errors/warnings on the cygwin, MinGW and
msvc builds, provoked by the jk/pack-bitmap branch.

Note that this does not fix all problems on the msvc build; I have
a solution, but I don't like it. :-D  So, I'm going to try a different
fix. I had hoped to have done this by now, but ... (hopefully, sometime
this weekend).

Note that I have only tested the cygwin and MinGW builds by running
the t5310-pack-bitmaps.sh test, and only on a little-endian machine.
(Torsten has tested the first patch on a big-endian)

Note also, that these patches are build on top of the 'pu' branch
as of yesterday (pu @ 2b65d9ebc).

So, could you please squash these patches into the relevant commits
on your branch.

Thanks!

ATB,
Ramsay Jones

Ramsay Jones (5):
  compat/bswap.h: Fix build on cygwin, MinGW and msvc
  Makefile: Add object files in ewah/ to clean target
  khash.h: Spell the null pointer as NULL
  pack-objects: Limit visibility of 'indexed_commits' symbols
  ewah_bitmap.c: Fix printf format warnings on MinGW

 Makefile               |  5 +--
 builtin/pack-objects.c |  6 ++--
 compat/bswap.h         | 97 +++++++++++++++++++++++++++++++++++---------------
 ewah/ewah_bitmap.c     |  6 ++--
 khash.h                |  2 +-
 5 files changed, 79 insertions(+), 37 deletions(-)

-- 
1.8.4
