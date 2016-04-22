From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: make test Unexpected passes
Date: Fri, 22 Apr 2016 21:05:24 +0100
Message-ID: <571A8404.5030200@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: ben.woosley@gmail.com, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 22:05:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1athKZ-0004qd-EF
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 22:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbcDVUFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 16:05:30 -0400
Received: from avasout07.plus.net ([84.93.230.235]:57800 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbcDVUFa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 16:05:30 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id lY5S1s0062D2Veb01Y5UWg; Fri, 22 Apr 2016 21:05:28 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=ytdg1oe-me6gtZ-LOuwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292263>

Hi Ben, Junio,

Tonight, the testsuite passed with a couple of 'unexpected passes', viz:

$ tail -17 ptest-out
[13:24:29]
All tests successful.

Test Summary Report
-------------------
t3421-rebase-topology-linear.sh                  (Wstat: 0 Tests: 76 Failed: 0)
  TODO passed:   50, 54
t6036-recursive-corner-cases.sh                  (Wstat: 0 Tests: 22 Failed: 0)
  TODO passed:   11
Files=746, Tests=13515, 445 wallclock secs ( 3.83 usr  0.61 sys + 52.78 cusr 27.89 csys = 85.11 CPU)
Result: PASS
make clean-except-prove-cache
make[2]: Entering directory `/home/ramsay/git/t'
rm -f -r 'trash directory'.* 'test-results'
rm -f -r valgrind/bin
make[2]: Leaving directory `/home/ramsay/git/t'
make[1]: Leaving directory `/home/ramsay/git/t'
$ 

In the first case, t3421-*.sh, git bisect fingered commit f32ec670
("git-rebase--merge: don't include absent parent as a base", 20-04-2016).

In the second case, t6036-*.sh, git bisect fingered commit b61f9d6e
("ll-merge: use a longer conflict marker for internal merge", 14-04-2016).

I won't have any time tonight to look into this any further (are these
false positives?), so I thought I would just make sure you were aware
of these 'unexpected passes'.

ATB,
Ramsay Jones
