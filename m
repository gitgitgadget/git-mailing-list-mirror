From: Jiang Xin <worldhello.net@gmail.com>
Subject: Test "t/t7502-commit.sh" failed
Date: Thu, 26 Jul 2012 14:27:52 +0800
Message-ID: <CANYiYbHbMw1HpvoCr4yBbWF=Q9Hoc1Zsq3-WoTrx4aQg7R0e4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 26 08:28:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuHYF-0004ai-Ql
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 08:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632Ab2GZG1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 02:27:54 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60078 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab2GZG1x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 02:27:53 -0400
Received: by yhmm54 with SMTP id m54so1594602yhm.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 23:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=eKL8dtlj/LV1Vjz+Ns2z4+/VThj7thrt1R2BBj4CuTI=;
        b=r/KrXoEeMfHI15xHDBfHDY34wBx29yxM5CSEBkoTubQD3wuSp0Il18U7mL5v2BSlpR
         JQGA/J6Lo3TK2PLCTglkhJY7xbAnqAhdPRMNNrppY+PeswnAcvYkKecmslBLVF/tXkBH
         zjcgxGCQAtddxG3xjwzfsosiWEk0QopRB3oUNW6CZx3aN3CLjcx9Wk54jG/kFjJx1eQ9
         Zp0bwOxOjN7fbpX7JfA/yU5TpJ3TX6nHwhOxoMLIBiJEz52z2Kz1WFK72IS65UYc5M+N
         WHKbnrWS4dbGDKSog8XxV+J8rh4honC15PNPdD1s4VnQk6DZpbABWainE5ySajyg/IeI
         nRwg==
Received: by 10.50.17.162 with SMTP id p2mr765489igd.52.1343284072818; Wed, 25
 Jul 2012 23:27:52 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Wed, 25 Jul 2012 23:27:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202227>

Test "t/t7502-commit.sh" failed. I guess it's commit
v1.7.9.7-1-gf20f387 which breaks it.

    $ git log -1 --oneline --stat v1.7.9.7-1-gf20f387
    f20f commit: check committer identity more strictly
     builtin/commit.c | 2 +-
     1 file changed, 1 insertion(+), 1 deletion(-)

Result of t/t7502-commit.sh:

not ok - 21 committer is automatic
#
#
#               echo >>negative &&
#               (
#                       sane_unset GIT_COMMITTER_EMAIL &&
#                       sane_unset GIT_COMMITTER_NAME &&
#                       # must fail because there is no change
#                       test_must_fail git commit -e -m "sample"
#               ) &&
#               head -n 8 .git/COMMIT_EDITMSG | \
#               sed "s/^# Committer: .*/# Committer:/" >actual
#               test_i18ncmp expect actual
#

Contents of file expect:

    sample

    # Please enter the commit message for your changes. Lines starting
    # with '#' will be ignored, and an empty message aborts the commit.
    #
    # Author:    A U Thor <author@example.com>
    # Committer:
    #

Contents of file actual:

    sample

-- 
Jiang Xin
