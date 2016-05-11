From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 2/2] mingw: remove unnecessary definition
Date: Wed, 11 May 2016 10:43:41 +0200 (CEST)
Message-ID: <040c307b42f5d91db21caa8ed19afce93178691f.1462956195.git.johannes.schindelin@gmx.de>
References: <cover.1462881473.git.johannes.schindelin@gmx.de> <cover.1462956195.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 10:45:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0PmC-00027N-Oo
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 10:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbcEKIps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 04:45:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:62069 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160AbcEKIpE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 04:45:04 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Metpl-1bG0i030cz-00OUAW; Wed, 11 May 2016 10:44:49
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462956195.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Fuvm6+uKmKMOFAd1LHoh6O235/LYaLTrXGmPkXrDC6yd/ltHui+
 513mTI03aSzI8xUXHceDkHCJrqAG+ehgJjd0KTb7P5/wnoKBSaaZ/EdRjKEJonHohf9uX55
 nbjfwQEnCJuVUAIdpUxG2UVd2H/Z7+NIo19SvSoLEWIBN3vBP+tHKeJl+DFElUX3ThmkZsV
 NAPy9onDwUmRP1FaRjkZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aX+Jq2FR8ps=:OU/TQQNFzE57eL85Vx4P/p
 NdrVhUAvlM4A9LaMW1MgSr1Q/ZO9n0A5G7QMAhJNPkJ4/e0CHB7Hkdk4AkbnfeDyDjW0C+inq
 /zOMNoG6TlOahMv9G1kHI2R107HuZqlfqY+jDSYW9rb5REc8A2ahWxBjUcDOVcpSBHYcd9Rgc
 PekuOO8zVg/L4Uc2kuC8XTi7QS699o1RmDZ6tr/a0EzRk01xaaXQtoBtVB4tcflnOBUNVYMEE
 7v7eeKwHyE5jHAXjdUeARIMGncuFy2UMxLOZzrkAAnOcXjazVddsTThUNHiL39VaX//C8wmwO
 brg8JbQgz40h6AWbUbNjd2P21j9sPDxwqRcColaZ9hFcVkoa+17FBeu+5MlixsgN4w4+hHrmo
 aDKuLX6QA745rAD4jsiNeREJweExLbCY+BRvtrsoK8e94QarNb4U/a0z2XTS0bSjS3FVdPXc2
 vmhURLK0zYaSdAyR0pRkDgIRZSYQ4XwDwzr+y0A0s3S96QGywUUKQfM8d2n4uAQtPY3dn0fxH
 d6dalIdc4RnyOuGv9DIG1ZPFX2HUTXjOhTYu3IiyaeJraVEG643QyyuZAfcc+fFXLYxPELf4t
 X9B07j95KGPky9Hy1o3+YU8RJ2DdEU32zwaorF4zibjuRxuh3aTThQPbKpJsYUJanFDv6cc6y
 Atv6yWATRdicnbhFis1kcQN/E1Fq1VWJjRDxB5aAORvnXaYL6hScK4t2ez94qBl6bPakB/KYb
 S+rw0NoJOyV5WbyJOS00Ww1qKYYJHOci3ppGRZGXFCXLcdIuLZB+aA72pXw8Ccl3lbA8sxH7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294245>

For some reason, the definition of the MINGW version of
`mark_as_git_dir()` slipped into this developer's patch series to
support building Git for Windows.

As the `mark_as_git_dir()` function is not needed at all anymore (it was
used originally to support the core.hideDotFiles = gitDirOnly setting,
but we now use a different method to support that case), let's just
remove it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 1de70ff..a1808b4 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -416,9 +416,6 @@ int mingw_offset_1st_component(const char *path);
 void mingw_open_html(const char *path);
 #define open_html mingw_open_html
 
-void mingw_mark_as_git_dir(const char *dir);
-#define mark_as_git_dir mingw_mark_as_git_dir
-
 /**
  * Converts UTF-8 encoded string to UTF-16LE.
  *
-- 
2.8.2.465.gb077790
