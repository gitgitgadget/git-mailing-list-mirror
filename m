From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Failing a test on OpenServer 6 t5100-mailinfo.sh
Date: Sat, 8 Aug 2009 10:17:40 -0600
Message-ID: <alpine.LNX.2.00.0908081014560.13290@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 18:17:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZoc9-0007bj-AO
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 18:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbZHHQRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 12:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbZHHQRl
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 12:17:41 -0400
Received: from suse104.zenez.com ([198.60.105.164]:48962 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbZHHQRl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 12:17:41 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id A43F2AB802F; Sat,  8 Aug 2009 10:17:40 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 80F8C93852B
	for <git@vger.kernel.org>; Sat,  8 Aug 2009 10:17:40 -0600 (MDT)
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125286>

Hello,

With a config.mak.autogen that is fixed for OpenServer 6.

I now have three tests that fail.

The first is because of the OS does not allow perl to do somethings.

The second is a new problem.

*** t5100-mailinfo.sh ***
*   ok 1: split sample box
*   ok 2: mailinfo 0001
*   ok 3: mailinfo 0002
*   ok 4: mailinfo 0003
*   ok 5: mailinfo 0004
*   ok 6: mailinfo 0005
*   ok 7: mailinfo 0006
*   ok 8: mailinfo 0007
*   ok 9: mailinfo 0008
*   ok 10: mailinfo 0009
*   ok 11: mailinfo 0010
* FAIL 12: mailinfo 0011

                         git mailinfo -u msg$mail patch$mail <$mail 
>info$mail &&
                         echo msg &&
                         test_cmp "$TEST_DIRECTORY"/t5100/msg$mail msg$mail 
&&
                         echo patch &&
                         test_cmp "$TEST_DIRECTORY"/t5100/patch$mail 
patch$mail &&
                         echo info &&
                         test_cmp "$TEST_DIRECTORY"/t5100/info$mail 
info$mail

*   ok 13: mailinfo 0012
*   ok 14: mailinfo 0013
*   ok 15: split box with rfc2047 samples
* FAIL 16: mailinfo rfc2047/0001

                         git mailinfo -u $mail-msg $mail-patch <$mail 
>$mail-info &&
                         echo msg &&
                         test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg 
&&
                         echo patch &&
                         test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-patch 
&&
                         echo info &&
                         test_cmp 
"$TEST_DIRECTORY"/t5100/rfc2047-info-$(basename $mail) $mail-info

*   ok 17: mailinfo rfc2047/0002
*   ok 18: mailinfo rfc2047/0003
* FAIL 19: mailinfo rfc2047/0004

                         git mailinfo -u $mail-msg $mail-patch <$mail 
>$mail-info &&
                         echo msg &&
                         test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg 
&&
                         echo patch &&
                         test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-patch 
&&
                         echo info &&
                         test_cmp 
"$TEST_DIRECTORY"/t5100/rfc2047-info-$(basename $mail) $mail-info

*   ok 20: mailinfo rfc2047/0005
*   ok 21: mailinfo rfc2047/0006
*   ok 22: mailinfo rfc2047/0007
*   ok 23: mailinfo rfc2047/0008
*   ok 24: mailinfo rfc2047/0009
*   ok 25: mailinfo rfc2047/0010
* FAIL 26: mailinfo rfc2047/0011

                         git mailinfo -u $mail-msg $mail-patch <$mail 
>$mail-info &&
                         echo msg &&
                         test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg 
&&
                         echo patch &&
                         test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-patch 
&&
                         echo info &&
                         test_cmp 
"$TEST_DIRECTORY"/t5100/rfc2047-info-$(basename $mail) $mail-info

*   ok 27: respect NULs
*   ok 28: Preserve NULs out of MIME encoded message
*   ok 29: mailinfo on from header without name works
* failed 4 among 29 test(s)
gmake[2]: *** [t5100-mailinfo.sh] Error 1
gmake[2]: Leaving directory `/home/zenez/build/osr6/git/t'



-- 
Boyd Gerber <gerberb@zenez.com> 801 849-0213
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
