From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH 0/5] ident attribute related patches (resend w/ testsuite v3)
Date: Mon, 29 Mar 2010 13:28:54 +0200
Message-ID: <cover.1269860022.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 13:29:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwD9h-0005ax-5F
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 13:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695Ab0C2L3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 07:29:08 -0400
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
Received: from mail.roxen.com ([212.247.29.220]:46286 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab0C2L3G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 07:29:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 3D056628256
	for <git@vger.kernel.org>; Mon, 29 Mar 2010 13:29:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UPxYOLSGx+RT; Mon, 29 Mar 2010 13:29:03 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 1F967628254;
	Mon, 29 Mar 2010 13:29:03 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o2TBT3VR006171;
	Mon, 29 Mar 2010 13:29:03 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o2TBT2aB006170;
	Mon, 29 Mar 2010 13:29:02 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143458>

These are some patches that are needed to get the support for the
'ident' attribute to a useable state.

Since last time, suggestions by Bert Wesarg <bert.wesarg@googlemail.com=
>
and Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> have been implement=
ed.

The testsuite passes on Linux/x86 and Solaris/x86.

Henrik Grubbstr=C3=B6m (Grubba) (5):
  convert: Safer handling of $Id$ contraction.
  convert: Keep foreign $Id$ on checkout.
  convert: Use the enum constant SAFE_CRLF_FALSE.
  convert: Inhibit contraction of foreign $Id$ during stats.
  convert: Added core.refilteronadd feature.

 Documentation/config.txt |    6 ++++
 builtin/apply.c          |    3 +-
 builtin/blame.c          |    3 +-
 cache.h                  |    9 +++++-
 combine-diff.c           |    3 +-
 config.c                 |    5 +++
 convert.c                |   52 +++++++++++++++++++++++++++++----
 diff.c                   |    3 +-
 environment.c            |    1 +
 sha1_file.c              |   60 +++++++++++++++++++++++++++++++++++++-
 t/t0021-conversion.sh    |   72 ++++++++++++++++++++++++++++++++++++++=
++++----
 11 files changed, 199 insertions(+), 18 deletions(-)
