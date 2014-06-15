From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 05/14] read-tree: add t1013 for submodule updates
Date: Sun, 15 Jun 2014 18:59:51 +0200
Message-ID: <539DD107.2080303@web.de>
References: <539DD029.4030506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 19:00:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwDmp-0001yb-4p
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 19:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbaFORAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 13:00:03 -0400
Received: from mout.web.de ([212.227.15.4]:59337 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520AbaFORAB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 13:00:01 -0400
Received: from [192.168.178.41] ([84.132.144.103]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MIvXZ-1Wtko50gUT-002aa8; Sun, 15 Jun 2014 18:59:52
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD029.4030506@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:D1jVSP5pOZx8Cppq9Llc7m/rmMF8BLoyJOe//00wG3Fp8byTkwO
 2OlqQhhH8Uqxs6Byy/VUyyYxY9v3/Awgg8ZXjm6MpQDMm4C3eezzYcJvg8u5r2m1KD1f3eg
 RLK+5yUTUmapOFQXdX8opnyOIhZZ6ymQcA4So+lbpoGCjJxmvLTtCdk2rO3xYZry2rIPYMm
 ArjLFeBvTctNxzRJkbR/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251687>

Test that the read-tree command updates the work tree as expected for
changes which don't result in conflicts with the '-m' and '--reset' flag.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/t1013-read-tree-submodule.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100755 t/t1013-read-tree-submodule.sh

diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
new file mode 100755
index 0000000..20526ae
--- /dev/null
+++ b/t/t1013-read-tree-submodule.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+test_description='read-tree can handle submodules'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-submodule-update.sh
+
+test_submodule_switch "git read-tree -u -m"
+
+test_submodule_forced_switch "git read-tree -u --reset"
+
+test_done
-- 
2.0.0.275.gc479268
