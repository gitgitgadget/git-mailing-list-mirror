From: Pavel Roskin <proski@gnu.org>
Subject: cogito testsuite failure
Date: Tue, 31 May 2005 23:47:52 -0400
Message-ID: <1117597672.13776.17.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 01 05:46:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdKBH-00087I-3b
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 05:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVFADs4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 23:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVFADs4
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 23:48:56 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:16852
	"EHLO dv.roinet.com") by vger.kernel.org with ESMTP id S261225AbVFADsx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 23:48:53 -0400
Received: from dv.roinet.com (localhost.localdomain [127.0.0.1])
	by dv.roinet.com (8.13.4/8.13.4) with ESMTP id j513lqlq017545;
	Tue, 31 May 2005 23:47:52 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j513lqmK017542;
	Tue, 31 May 2005 23:47:52 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: Junio C Hamano <junio@siamese.dyndns.org>,
	git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

"make test" fails for current cogito:

*** t4008-diff-break-rewrite.sh ***
*   ok 1: setup
*   ok 2: change file1 with copy-edit of file0 and remove file0
*   ok 3: run diff with -B
*   ok 4: validate result of -B (#1)
*   ok 5: run diff with -B and -M
*   ok 6: validate result of -B -M (#2)
*   ok 7: swap file0 and file1
*   ok 8: run diff with -B
*   ok 9: validate result of -B (#3)
*   ok 10: run diff with -B and -M
*   ok 11: validate result of -B -M (#4)
*   ok 12: make file0 into something completely different
*   ok 13: run diff with -B
* FAIL 14: validate result of -B (#5) compare_diff_raw current expected
*   ok 15: run diff with -B
* FAIL 16: validate result of -B -M (#6) compare_diff_raw current expected
*   ok 17: run diff with -M
* FAIL 18: validate result of -M (#7) compare_diff_raw current expected
*   ok 19: file1 edited to look like file0 and file0 rename-edited to file2
*   ok 20: run diff with -B
*   ok 21: validate result of -B (#8)
*   ok 22: run diff with -B -M
*   ok 23: validate result of -B -M (#9)
* failed 3 among 23 test(s)

The failures happens because the test uses file ../README, which was
changed recently (and therefore, its checksum changed as well).  Also,
this and several other tests refer to ../COPYING, which is going to
change as well (it has an old mailing address of FSF).

I suggest that we use separate test files.  It would be great if those
files included text in several languages to test support for non-ASCII
symbols (maybe HELLO from emacs sources).

Or maybe we could use short files embedded in the scripts.  Or maybe we
could use sed to take significant portions of GPL that don't include
Linus' foreword, any mailing addresses or "19" when it's used as two
first digits of a year.

-- 
Regards,
Pavel Roskin

