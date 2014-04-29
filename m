From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 12/12] MINGW: config.mak.uname: add explicit way to request MinGW-build
Date: Tue, 29 Apr 2014 13:12:06 +0400
Message-ID: <1398762726-22825-13-git-send-email-marat@slonopotamus.org>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:13:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf46V-0006Ji-AC
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933155AbaD2JN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:13:27 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:46153 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932967AbaD2JNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:13:25 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wf45O-0006BN-M6; Tue, 29 Apr 2014 13:12:23 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247539>

When crosscompiling, one cannot rely on `uname` from host system.
Thus, add an option to use `make MINGW=1` for building MinGW build
from non-MinGW host (Linux, for example).

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 config.mak.uname | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index d5f7953..c7f3d74 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -13,6 +13,11 @@ ifdef MSVC
 	uname_O := Windows
 endif
 
+ifdef MINGW
+	uname_S := MINGW
+	uname_O := MINGW
+endif
+
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...
-- 
1.9.1
