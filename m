From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 2/2] mingw: remove unnecessary definition
Date: Tue, 10 May 2016 13:59:27 +0200 (CEST)
Message-ID: <573b7125f33272b3886edce51042785e62cd29a9.1462881473.git.johannes.schindelin@gmx.de>
References: <cover.1462603453.git.johannes.schindelin@gmx.de> <cover.1462881473.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 13:59:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b06KO-0007S7-68
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 13:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbcEJL7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 07:59:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:52989 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbcEJL7r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 07:59:47 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MUILK-1b9Pzm32pO-00R4I8; Tue, 10 May 2016 13:59:29
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462881473.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:rSSWKNugfRuMcatFSd2j/BaRejx4MUkX0ulB8P4x5MFvxqPbTtZ
 9wWZLKBezB6RyYqy8rpnqVRNPqsJUmWyj4V/Lkdo6J3l+qWTqBRvi5px2Tg1ygzhNhCKuWL
 /95qcWDD5A2ucANdZP/3opuCYcoMR53eaqbyvdvy3UVgqeA5izH1MuPPkrP70VaFS2dMFsq
 HucCsqH586hhw+Ze3i9wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:30Ja3alAJVk=:PlMIdz3KrI2phDEnBGmLIi
 PF3PSrzY0lrtDzOhKP/g5mxf7cjqaeyIdjRyj6SlxnJ8frF64FEZtunN1zZpcQ2rqTIlktyEo
 Epg/JG13m3reu5dgwUcLb17j/J+vIrS1vj716xuFA3Lg13v7HTmu4NQZcY7DhZugwLDmR9Qgw
 F/JizDVftxzC2JXNK6+Y/lH4JCORz3gSIGEEjvixPQtEG3MzNu96HTaU/JkixuzxWupvGIZTT
 MF+w5nJL8vflpzzdFmVM4uyD+m6x1yXURMQ17fmgA2day2cHrEpsSYyuLBCoabNEwEEFsBIlt
 8IArJXU4oTAOemqS9vlSR6RnDhtNsWPs7Hz3kf3iv0rNVFAB30rKbyue5LGK95JcC2cTezIvb
 ikBWGa5NCu90eckwfHAt8HsJpF+iB6YKuORyPOgeoSVedsHYIEaJgMnQXLZhAwmiUFm4yz8b0
 iUN/71FnFX9fcpXbfigJ8Rk7nwEeOn7mX9RnOhBQFDzwTErYhhkj6kvLkaIhCSrZGktxEUzlf
 w1Nf00jtFd0kIPIt0X4kteJr5k+LlCMlPjGn+GpIJfsoVfvseRHyc3m6rffO245SZ6VY6cayF
 t+lQPSVk0VLm6tJjeehZmwdUsHGkpHdJaZwhO8cRyIUYA0Tye5ZoTUu8rcK9i8KBLRMRii685
 zaeqyJblM1mVEm5jeSuOsbPwQXiZUx0bgc9cyCqvLt9W+z5qwh6A3ZBrQb3viNYnZHTQ2Q1Md
 r986m1f7BxN8XzJNxby48iKNcnO2GupWS9z6JvhokDIzPRynrun9OSgoL3bB7RR1ikcWTyHN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294125>

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
index edec9e0..69bb43d 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -417,9 +417,6 @@ int mingw_offset_1st_component(const char *path);
 void mingw_open_html(const char *path);
 #define open_html mingw_open_html
 
-void mingw_mark_as_git_dir(const char *dir);
-#define mark_as_git_dir mingw_mark_as_git_dir
-
 /**
  * Converts UTF-8 encoded string to UTF-16LE.
  *
-- 
2.8.2.463.g99156ee
