From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v5 0/6] Disable "git status" comment prefix
Date: Fri,  6 Sep 2013 19:43:03 +0200
Message-ID: <1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq38phsvuc.fsf@anie.imag.frvpq38phsvuc.fsf@anie.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 06 19:44:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI04s-0001On-Cr
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 19:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019Ab3IFRoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 13:44:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54096 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777Ab3IFRoI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 13:44:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r86HhGUx014263
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Sep 2013 19:43:16 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VI03y-0000b1-Nr; Fri, 06 Sep 2013 19:43:18 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VI03y-0006jB-CQ; Fri, 06 Sep 2013 19:43:18 +0200
X-Mailer: git-send-email 1.8.4.5.g8688bea
In-Reply-To: <vpq38phsvuc.fsf@anie.imag.frvpq38phsvuc.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 Sep 2013 19:43:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r86HhGUx014263
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1379094199.23919@BLDIFvR7YW+YxRALC4dYEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234075>

Compared to v5:

* One test update I had forgotten. Now, the testsuite actually pass.

* Changed the config to status.displayCommentPrefix.

* Added the last patch, to add a missing blank line.

Matthieu Moy (6):
  builtin/stripspace.c: fix broken indentation
  wt-status: use argv_array API
  submodule summary: ignore --for-status option
  status: disable display of '#' comment prefix by default
  tests: don't set status.displayCommentPrefix file-wide
  status: add missing blank line after list of "other" files

 Documentation/config.txt           |   7 +
 builtin/commit.c                   |  10 +
 builtin/stripspace.c               |   8 +-
 git-submodule.sh                   |  13 +-
 t/t3001-ls-files-others-exclude.sh |   2 +-
 t/t7060-wtstatus.sh                | 109 +++--
 t/t7401-submodule-summary.sh       |  12 +-
 t/t7508-status.sh                  | 965 ++++++++++++++++++++-----------------
 t/t7512-status-help.sh             | 600 +++++++++++------------
 wt-status.c                        |  91 +++-
 wt-status.h                        |   1 +
 11 files changed, 966 insertions(+), 852 deletions(-)

-- 
1.8.4.5.g8688bea
