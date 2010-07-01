From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: Test 17 of `t9119-git-svn-info.sh' fails with svn 1.6.9
Date: Thu, 01 Jul 2010 10:54:26 +0200
Message-ID: <8739w3fupp.fsf@ft.bewatermyfriend.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Eric Wong <normalperson@yhbt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 11:05:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUFhq-0004J6-7a
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 11:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab0GAJFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 05:05:07 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:58271 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab0GAJFF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 05:05:05 -0400
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jul 2010 05:05:05 EDT
Received: from [212.117.84.72] (helo=bones.voodoo.lan)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1OUFYV-0003r3-GW; Thu, 01 Jul 2010 10:55:35 +0200
Received: by bones.voodoo.lan (Postfix, from userid 1000)
	id 6878B190AA; Thu,  1 Jul 2010 10:54:26 +0200 (CEST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150012>

Hello,

Running the test suite currently breaks for me at this point:

[snip]
*   ok 16: info --url added-file
* FAIL 17: info added-directory

                mkdir gitwc/added-directory svnwc/added-directory &&
                ptouch gitwc/added-directory svnwc/added-directory &&
                touch gitwc/added-directory/.placeholder &&
                cd svnwc &&
                        svn_cmd add added-directory > /dev/null &&
                cd .. &&
                cd gitwc &&
                        git add added-directory &&
                cd .. &&
                (cd svnwc; svn info added-directory)            >
                expected.info-added-directory &&
                (cd gitwc; git svn info
                added-directory)                >
                actual.info-added-directory &&
                test_cmp expected.info-added-directory
                actual.info-added-directory

*   ok 18: info --url added-directory
[...]
* failed 1 among 38 test(s)
make[2]: *** [t9119-git-svn-info.sh] Error 1
[snap]

I briefly searched the list archives via gmane but didn't find this
reported yet. I've got no idea what's going on in that test, as I'm no
expert in subversion matters at all. So I can't be of more help than
saying "well, it breaks for me.". :)

Anyway, my svn version is "svn, version 1.6.9 (r901367)". The test suite
I ran is from yesterdays git master branch. If it matters, this is a
Linux box running a debian 2.6.26-2-686 kernel; the file system in
question is `ext3' being mounted `noatime'.

Regards, Frank

PS: I hope I Cced the right group of people.

-- 
In protocol design, perfection has been reached not when there is
nothing left to add, but when there is nothing left to take away.
                                                  -- RFC 1925
