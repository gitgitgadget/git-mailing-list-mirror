From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 06/14] reset: add t7112 for submodule updates
Date: Sun, 15 Jun 2014 19:00:28 +0200
Message-ID: <539DD12C.7000009@web.de>
References: <539DD029.4030506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 19:00:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwDna-0002dz-U5
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 19:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbaFORAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 13:00:51 -0400
Received: from mout.web.de ([212.227.17.12]:61086 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494AbaFORAu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 13:00:50 -0400
Received: from [192.168.178.41] ([84.132.144.103]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MddBI-1X632f26ou-00PQR1; Sun, 15 Jun 2014 19:00:29
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD029.4030506@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:lJKISlp6VPJqd1PU98qA98N2mwHmu6ZttS6tVIfA1pqhys+P1uW
 P39lwlTy6/5bDxtxnIe1N9IbUEcm/9eFYywELS09DigeukERnXeHD4prYYit6aHFN7NFK9j
 tUlH27Ck8VEZ4Y6wBNwwthe4KSBJx7mhJ3u8Je0wc1uaK13qPY+A/kRroTfk/hZV/qPYHOi
 siAKLsiUIcQm6tF9wLy3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251688>

Test that the reset command updates the work tree as expected for changes
with '--keep', '--merge' (for changes which don't result in conflicts) and
'--hard'.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/t7112-reset-submodule.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100755 t/t7112-reset-submodule.sh

diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
new file mode 100755
index 0000000..2eda6ad
--- /dev/null
+++ b/t/t7112-reset-submodule.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+
+test_description='reset can handle submodules'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-submodule-update.sh
+
+test_submodule_switch "git reset --keep"
+
+test_submodule_switch "git reset --merge"
+
+test_submodule_forced_switch "git reset --hard"
+
+test_done
-- 
2.0.0.275.gc479268
