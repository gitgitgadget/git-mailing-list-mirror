From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 1/5] fetch: Reset remote refs list each time fetch_main is called
Date: Fri, 29 Sep 2006 20:05:40 +0200
Message-ID: <87mz8i1rbf.fsf@gmail.com>
References: <87r6xu1rci.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 29 20:05:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTMk6-0003XQ-Sg
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 20:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWI2SFo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 29 Sep 2006 14:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWI2SFo
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 14:05:44 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:57255 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1751270AbWI2SFn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 14:05:43 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k8TI5fQ03736
	for <git@vger.kernel.org>; Fri, 29 Sep 2006 20:05:41 +0200
To: git <git@vger.kernel.org>
In-Reply-To: <87r6xu1rci.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Fri, 29 Sep
	2006 20:05:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28118>


This prevents the fetch of the heads again in the second call of fetch_=
main.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 git-fetch.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index bcc67ab..f1522bd 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -257,6 +257,7 @@ fi
 fetch_main () {
   reflist=3D"$1"
   refs=3D
+  rref=3D
=20
   for ref in $reflist
   do
--=20
1.4.2.1.g38049
