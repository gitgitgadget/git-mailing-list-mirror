From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: What's cooking in git.git (Jun 2013, #07; Thu, 20)
Date: Sun, 23 Jun 2013 19:21:37 +0200
Message-ID: <871u7sg2u6.fsf@hexa.v.cablecom.net>
References: <7v1u7woydw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Fredrik Gustafsson <iveqy@iveqy.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 19:21:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqnzC-0005UZ-4D
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 19:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805Ab3FWRVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 13:21:41 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:37861 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637Ab3FWRVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 13:21:40 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 23 Jun
 2013 19:21:23 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 23 Jun
 2013 19:21:37 +0200
In-Reply-To: <7v1u7woydw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 20 Jun 2013 21:56:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228746>

Junio C Hamano <gitster@pobox.com> writes:

> * tr/test-v-and-v-subtest-only (2013-06-18) 8 commits
>  - test-lib: support running tests under valgrind in parallel
>  - test-lib: allow prefixing a custom string before "ok N" etc.
>  - test-lib: valgrind for only tests matching a pattern
>  - test-lib: verbose mode for only tests matching a pattern
>  - test-lib: self-test that --verbose works
>  - test-lib: rearrange start/end of test_expect_* and test_skip
>  - test-lib: refactor $GIT_SKIP_TESTS matching
>  - test-lib: enable MALLOC_* for the actual tests
>
>  Allows N instances of tests run in parallel, each running 1/N parts
>  of the test suite under Valgrind, to speed things up.
>
>  The tip two may be useful in practice but is a tad ugly ;-)
>
>  Will merge to 'next'.

Please hold off; Fredrik found an issue with the test automation that
bisects to "verbose mode for only tests matching a pattern"; when
running with the 'test' target (not with prove however), the suite
reports

  failed test(s):  

  fixed   0
  success 9788
  failed  2
  broken  69
  total   9989

Even worse, I botched a rebase that makes the commit before --
"self-test that --verbose works" untestable.  I'm pretty sure that it
has the same problem, too, though I'm still investigating the actual
issue.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
