From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: git-svn tests fail since 1.7.2.2
Date: Thu, 28 Oct 2010 12:28:57 +0200
Message-ID: <20101028122857.3c8d3f4d@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 12:29:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBPjG-0004W7-Qc
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 12:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757485Ab0J1K3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 06:29:01 -0400
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:2805 "EHLO
	smtp-vbr15.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab0J1K27 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 06:28:59 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr15.xs4all.nl (8.13.8/8.13.8) with ESMTP id o9SASveA004521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 28 Oct 2010 12:28:57 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
X-Mailer: Claws Mail 3.7.6cvs54 (GTK+ 2.18.6; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160168>

I always compile git myself from scratch. One reason is that I want
git-gui to push tags by default, and the option is not available to
store that in some global config. The patches I apply are available
as http://tux.nl/Files/git-patch

(the templates/Makefile patch is to make install work on HP-UX and AIX
 too, where my machines don't seem to like the original installation
 code, but that doesn't change anything else).

Up to and including 1.7.2.1, all went smooth and fine, but as of
1.7.2.2 (and 1.7.3.1 and 1.7.3.2), the tests started to fail on svn
issues. These tests fail * with or without * my patches. As a result
of these failures, I do not dare to install newer versions of git.

I (have to) use svn for some remote repositories that I clone with
git-svn to be able to use my favorite tools. IMHO svn sucks in user
tools, so I prefer git, but that is probably like preaching to the
choir here :)

I even created a few post-commit hooks in svn to sync a git clone
automatically so I don't have to waste time in svn land to track down
changes from a svn repo to some local svn repo's used in Eclipse.

I do *not* have a ~/.subversion or ~/.svn*

--8<---
*** t9101-git-svn-props.sh ***
ok 1 - checkout working copy from svn
ok 2 - setup some commits to svn
ok 3 - initialize git svn
ok 4 - fetch revisions from svn
ok 5 - test svn:keywords ignoring
ok 6 - raw $Id$ found in kw.c
ok 7 - propset CR on crlf files
ok 8 - fetch and pull latest from svn and checkout a new wc
ok 9 - Comparing crlf
ok 10 - Comparing ne_crlf
ok 11 - Comparing lf
ok 12 - Comparing ne_lf
ok 13 - Comparing cr
ok 14 - Comparing ne_cr
ok 15 - Comparing empty_cr
ok 16 - Comparing empty_lf
ok 17 - Comparing empty
ok 18 - Comparing empty_crlf
ok 19 - Set CRLF on cr files
ok 20 - fetch and pull latest from svn
ok 21 - CRLF + $Id$
ok 22 - CRLF + $Id$ (no newline)
ok 23 - test show-ignore
not ok - 24 test create-ignore
#
#               git svn fetch && git pull . remotes/git-svn &&
#               git svn create-ignore &&
#               cmp ./.gitignore create-ignore.expect &&
#               cmp ./deeply/.gitignore create-ignore.expect &&
#               cmp ./deeply/nested/.gitignore create-ignore.expect &&
#               cmp ./deeply/nested/directory/.gitignore create-ignore.expect &&
#               git ls-files -s | grep gitignore | cmp - create-ignore-index.expect
#
not ok - 25 test propget
#
#               git svn propget svn:ignore . | cmp - prop.expect &&
#               cd deeply &&
#               git svn propget svn:ignore . | cmp - ../prop.expect &&
#               git svn propget svn:entry:committed-rev nested/directory/.keep   | cmp - ../prop2.expect &&
#               git svn propget svn:ignore .. | cmp - ../prop.expect &&
#               git svn propget svn:ignore nested/ | cmp - ../prop.expect &&
#               git svn propget svn:ignore ./nested | cmp - ../prop.expect &&
#               git svn propget svn:ignore .././deeply/nested | cmp - ../prop.expect
#
not ok - 26 test proplist
#
#               git svn proplist . | cmp - prop.expect &&
#               git svn proplist nested/directory/.keep | cmp - prop2.expect
#
# failed 3 among 26 test(s)
1..26
-->8---

git-1.7.3.2/t $ prove -v t9*
:
:
Test Summary Report
-------------------
t9101-git-svn-props.sh                           (Wstat: 256 Tests: 26 Failed: 3)
  Failed tests:  24-26
  Non-zero exit status: 1
t9143-git-svn-gc.sh                              (Wstat: 256 Tests: 11 Failed: 1)
  Failed test:  10
  Non-zero exit status: 1
Files=71, Tests=865, 451 wallclock secs ( 0.53 usr  0.07 sys + 106.75 cusr 52.05 csys = 159.40 CPU)
Result: FAIL


These tests fail on *all* my Linux boxes, which happen to be OpenSUSE
ranging from 11.0 to 11.3. FWIW I am not interested in svn support on
HP-UX at the moment.

OpenSUSE 11.0/64:
Linux 2.6.25.20-0.7-default/#1  HP xw4600 Core(TM)2 Quad CPU Q9450 @ 2.66GHz/1998(4) x86_64  3950 Mb
+ svn, version 1.5.7 (r36142)

OpenSUSE 11.2/64:
Linux 2.6.31.12-0.2-default/#1  HP xw6400 Xeon(R) CPU E5320 @ 1.86GHz/1596(4) x86_64  3962 Mb
+ svn, version 1.6.6 (r40053)

OpenSUSE 11.3/32:
Linux 2.6.34.7-0.5-desktop/#1  HP EliteBook 8540p Core(TM) i5 CPU M 540 @ 2.53GHz/1199(4) i686  3868 Mb
+ svn, version 1.6.9 (r901367)


I'm not subscribed to this list and (sorry) have no time to follow it,
so if you need more feedback, please keep me Cc'd

-- 
H.Merijn Brand  http://tux.nl      Perl Monger  http://amsterdam.pm.org/
using 5.00307 through 5.12 and porting perl5.13.x on HP-UX 10.20, 11.00,
11.11, 11.23 and 11.31, OpenSuSE 10.1, 11.0 .. 11.3 and AIX 5.2 and 5.3.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
