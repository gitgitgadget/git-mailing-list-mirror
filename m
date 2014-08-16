From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH 2/2] Push the Makefile variable NATIVE_CRLF to C
Date: Sat, 16 Aug 2014 22:17:07 +0200
Message-ID: <53EFBC43.8030205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 22:17:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIkPb-00022x-9o
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 22:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbaHPURJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Aug 2014 16:17:09 -0400
Received: from mout.web.de ([212.227.15.14]:57055 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbaHPURI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 16:17:08 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LpwMZ-1WlryH1Msp-00fhec; Sat, 16 Aug 2014 22:17:06
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:qXkowRA68Z2z8iNLV23iMPfGpcRE4AYa/kJnqXivtCTK1Hr+Krc
 wfgGJ2DOVP9oE+jAi5ZUef4A7HgxKhCgnDJos/HoKSnEDa7BBK7RFDCD41klvLXsrDQg8Xf
 CXMMHvTeNZdGoD24f0E/QX4FWwOZ6XVl35sRAsRKSxWIaX+aQc7kLWouhKJ/nO6V8/24Q3a
 V5q/PAzwPoWecRLPHJbOg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255341>

Re-do the fix in 757543ae0c5d8d:
Propagate the Makefile variable NATIVE_CRLF to the C preprocessor

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 63a210d..00ba537 100644
--- a/Makefile
+++ b/Makefile
@@ -1482,6 +1482,10 @@ ifdef NO_REGEX
 	COMPAT_OBJS +=3D compat/regex/regex.o
 endif
=20
+ifdef NATIVE_CRLF
+	BASIC_CFLAGS +=3D -DNATIVE_CRLF
+endif
+
 ifdef USE_NED_ALLOCATOR
        COMPAT_CFLAGS +=3D -Icompat/nedmalloc
        COMPAT_OBJS +=3D compat/nedmalloc/nedmalloc.o
--=20
2.1.0.rc2.210.g636bceb
