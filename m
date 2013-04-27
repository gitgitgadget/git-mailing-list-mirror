From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/6] misc sparse patches (part 2)
Date: Sat, 27 Apr 2013 20:14:40 +0100
Message-ID: <517C23A0.40709@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:46:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB53-0008N7-LP
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392Ab3D0Tqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:46:42 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:33107 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756325Ab3D0Tqk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:46:40 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 7244D384081;
	Sat, 27 Apr 2013 20:46:39 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id C036138407C;
	Sat, 27 Apr 2013 20:46:38 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:46:38 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222668>


Hi Junio,

These patches are from a long running branch on MinGW; I have been
updating this branch for about four years now! The main reason for
not submitting these patches before is simply that I haven't sent
my patches to port sparse to MinGW upstream yet. So, as far as I
know, nobody can confirm/deny that these patches actually fix a
problem. :-D

Note that the first 5 patches are fairly straight forward and
shouldn't be controversial. I don't think the same can be said
of the final patch, especially since it reverts a recent trend
(to make the argv parameter of main() a const char **).

[Note: after this and the previous series, both cygwin and MinGW
are sparse clean. Linux still has about 8 warnings related to the
use of transparent unions in the library headers (all sockaddr
types), which requires a patch to sparse.]

ATB,
Ramsay Jones

Ramsay Jones (6):
  compat/unsetenv.c: Fix a sparse warning
  compat/win32/pthread.c: Fix a sparse warning
  compat/poll/poll.c: Fix a sparse warning
  compat/win32mmap.c: Fix some sparse warnings
  compat/mingw.c: Fix some sparse warnings
  sparse: Fix mingw_main() argument number/type errors

 compat/mingw.c         |  6 +++---
 compat/mingw.h         | 11 +++++++++--
 compat/poll/poll.c     |  2 +-
 compat/unsetenv.c      |  1 -
 compat/win32/pthread.c |  2 +-
 compat/win32mmap.c     |  4 ++--
 credential-store.c     |  4 ++--
 fast-import.c          |  4 ++--
 git.c                  |  3 ++-
 remote-testsvn.c       |  2 +-
 test-chmtime.c         |  2 +-
 test-index-version.c   |  2 +-
 test-mergesort.c       |  2 +-
 test-parse-options.c   |  4 ++--
 test-subprocess.c      |  4 ++--
 15 files changed, 30 insertions(+), 23 deletions(-)

-- 
1.8.2
