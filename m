From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH 0/4] ident attribute related patches (resend w/ testsuite)
Date: Mon, 15 Mar 2010 16:30:40 +0100
Message-ID: <cover.1268664693.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 16:31:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrCGC-0002vH-Eh
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 16:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897Ab0COPbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 11:31:12 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mail.roxen.com ([212.247.29.220]:44526 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753616Ab0COPbK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 11:31:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 674F5628191
	for <git@vger.kernel.org>; Mon, 15 Mar 2010 16:31:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t2Q+6eyIho+1; Mon, 15 Mar 2010 16:31:07 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 9057562817D;
	Mon, 15 Mar 2010 16:31:07 +0100 (CET)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o2FFV73q022011;
	Mon, 15 Mar 2010 16:31:07 +0100 (CET)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o2FFV75A022010;
	Mon, 15 Mar 2010 16:31:07 +0100 (CET)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142211>

These are some patches that are needed to get the support for the
'ident' attribute to a useable state.

Since last time, some issues that caused the the existing testsuite to
fail have been fixed, and the testsuite has been extended to test the
issues fixed by the patches.

Henrik Grubbstr=C3=B6m (Grubba) (4):
  convert: Safer handling of $Id$ contraction.
  convert: Keep foreign $Id$ on checkout.
  convert: Inhibit contraction of foreign $Id$ during stats.
  convert: Added core.refilteronadd feature.

 Documentation/config.txt |    6 ++++
 builtin/apply.c          |    2 +-
 builtin/blame.c          |    2 +-
 cache.h                  |    9 +++++-
 combine-diff.c           |    2 +-
 config.c                 |    5 +++
 convert.c                |   53 ++++++++++++++++++++++++++++++----
 diff.c                   |    2 +-
 environment.c            |    1 +
 sha1_file.c              |   60 +++++++++++++++++++++++++++++++++++++-
 t/t0021-conversion.sh    |   72 ++++++++++++++++++++++++++++++++++++++=
++++----
 11 files changed, 196 insertions(+), 18 deletions(-)
