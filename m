From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Mini bug report origin/pu: t1512 failed on Mac OS X (commit  957d74062c1f0e
 ?)
Date: Wed, 11 Jul 2012 22:09:02 +0200
Message-ID: <4FFDDD5E.3080309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 11 22:09:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp3Dk-0007pi-Li
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 22:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439Ab2GKUJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 16:09:07 -0400
Received: from mout.web.de ([212.227.15.3]:53489 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753318Ab2GKUJG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 16:09:06 -0400
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MGRVU-1SbrwN0kpU-00DzdH; Wed, 11 Jul 2012 22:09:04 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
X-Provags-ID: V02:K0:D2evjAV/teRrgau39ghRie5CfVXRUrKf2aiEikXoq4r
 jmqJN5NjPDUK9ZJ8G8ByUcvr/HaeLCh0zgigmsEh6VuWZijpR2
 2ObS0XFzk/04zTwd7zsuo42QoRsYhy+AI13Qnl74/MdE1FVPZr
 Q0+z0sO8S8Ywu5O2pTrDLZYHWUlBDAD+QIdgf96dECl6FpUMj1
 bEmKsukzAEi2TaP2x4rHQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201326>

The following tweak will make t1512 work on my Mac OS box:


--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -257,7 +257,7 @@ test_expect_success 'rev-parse --disambiguate' '
        # commits created by commit-tree in earlier tests do not share
        # the prefix.
        git rev-parse --disambiguate=000000000 >actual &&
-       test "$(wc -l <actual)" = 16 &&
+       test "$(wc -l <actual)" -eq  16 &&
        test "$(sed -e "s/^\(.........\).*/\1/" actual | sort -u)" = 000000000



/Torsten
