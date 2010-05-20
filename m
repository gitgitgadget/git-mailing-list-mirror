From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 0/5] Various fixes for Windows
Date: Thu, 20 May 2010 20:57:50 +0200
Message-ID: <cover.1274380838.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 20 21:01:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFAzL-0008GA-8z
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 21:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832Ab0ETTAw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 May 2010 15:00:52 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:15149 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751492Ab0ETTAw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 15:00:52 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 54337CDFA1;
	Thu, 20 May 2010 21:00:48 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7CFE219F5F0;
	Thu, 20 May 2010 20:58:05 +0200 (CEST)
X-Mailer: git-send-email 1.7.1.64.ga1799.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147406>

Here are some unrelated patches that I had accumulated over the past
weeks that improve the git experience on Windows.

The first three are maint-worthy and have been cooked long enough.
IMO it is safe to put them on maint directly.

Erik Faye-Lund (1):
  mingw: use _commit to implement fsync

Ian McLean (1):
  Fix "Out of memory? mmap failed" for files larger than 4GB on Windows

Johannes Sixt (1):
  Recent MinGW has a C99 implementation of snprintf functions

Ren=C3=A9 Scharfe (1):
  Fix checkout of large files to network shares on Windows XP

bert Dvornik (1):
  start_command: close cmd->err descriptor when fork/spawn fails

 Makefile              |    1 -
 compat/mingw.c        |   17 +++++++++++++++++
 compat/mingw.h        |    5 ++++-
 compat/win32mmap.c    |    6 +++---
 run-command.c         |    2 ++
 t/t5516-fetch-push.sh |    2 +-
 t/t5705-clone-2gb.sh  |   12 +++++++++---
 7 files changed, 36 insertions(+), 9 deletions(-)
