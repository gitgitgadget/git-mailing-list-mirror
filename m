From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <tor.arne.vestbo@nokia.com>
Subject: [PATCH v3 0/2] git-clone: Add new option --branch to override initial branch
Date: Fri, 27 Mar 2009 18:45:11 +0100
Message-ID: <1238175913-19175-1-git-send-email-tor.arne.vestbo@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 27 18:47:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnG8v-0007DF-3s
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 18:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688AbZC0RpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 13:45:06 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbZC0RpE
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 13:45:04 -0400
Received: from smtp.nokia.com ([192.100.122.230]:42615 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059AbZC0RpD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 13:45:03 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2RHiedu014187;
	Fri, 27 Mar 2009 19:44:53 +0200
Received: from vaebh104.NOE.Nokia.com ([10.160.244.30]) by esebh105.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 27 Mar 2009 19:44:30 +0200
Received: from mgw-int01.ntc.nokia.com ([172.21.143.96]) by vaebh104.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 27 Mar 2009 19:44:30 +0200
Received: from localhost.localdomain (olwst90124.europe.nokia.com [172.24.90.124])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n2RHiSXv032239;
	Fri, 27 Mar 2009 19:44:29 +0200
X-Mailer: git-send-email 1.6.2.GIT
X-OriginalArrivalTime: 27 Mar 2009 17:44:30.0891 (UTC) FILETIME=[AEC887B0:01C9AF03]
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114919>

This mini-series is a continuation of the efforts to add add a new
option to git clone to allow overriding the initial branch.

The previous patch (v2) and discussion can be found here:

  http://thread.gmane.org/gmane.comp.version-control.git/111967/focus=3D=
111983

With Junios' comments to v2 of my patch here:

  http://thread.gmane.org/gmane.comp.version-control.git/111967/focus=3D=
111983

I believe I've covered all the issues in the review, but if there's
still issues please let me know and I'll rework the patch.

Best,

Tor Arne


Tor Arne Vestb=C3=B8 (2):
  Move find_ref_by_name_abbrev to refs.c so it can be used globally
  git-clone: Add new option --branch to override initial branch

 Documentation/git-clone.txt |    5 +++
 builtin-clone.c             |   71 +++++++++++++++++++++++++----------=
-------
 cache.h                     |    1 +
 refs.c                      |   10 ++++++
 remote.c                    |   10 ------
 t/t5702-clone-options.sh    |   70 +++++++++++++++++++++++++++++++++++=
+++++--
 6 files changed, 125 insertions(+), 42 deletions(-)
