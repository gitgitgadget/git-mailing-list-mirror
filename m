From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: What's cooking in git.git (May 2013, #05; Mon, 20)
Date: Tue, 21 May 2013 09:19:22 +0200
Message-ID: <87hahwajgl.fsf@linux-k42r.v.cablecom.net>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 09:19:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uegr2-0002lo-7R
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 09:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755613Ab3EUHTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 03:19:24 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39778 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754197Ab3EUHTX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 03:19:23 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 21 May
 2013 09:19:18 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 21 May 2013 09:19:22 +0200
In-Reply-To: <7v38thrxwo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 20 May 2013 17:15:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225019>

Junio C Hamano <gitster@pobox.com> writes:

> * tr/test-v-and-v-subtest-only (2013-05-16) 6 commits
>  - test-lib: support running tests under valgrind in parallel
>  - test-lib: allow prefixing a custom string before "ok N" etc.
>  - test-lib: valgrind for only tests matching a pattern
>  - test-lib: verbose mode for only tests matching a pattern
>  - test-lib: refactor $GIT_SKIP_TESTS matching
>  - test-lib: enable MALLOC_* for the actual tests
>
>  Allows N instances of tests run in parallel, each running 1/N parts
>  of the test suite under Valgrind, to speed things up.
>
>  The tip one may be useful in practice but is a tad ugly ;-)

I was hoping for some success stories ;-)

I think Peff (who I stupidly managed to not Cc in the series, there's
another git-send-email usability issue there) asked for the third from
the tip, which lets you run valgrind only on a certain test.  (For
example, if you've already had two coffees while your computer found out
which test it was, this is a much faster way of seeing if the failure
disappeared.)

So one obvious way of going forward is cooking this for a while and
seeing whether people find the one-test-only or the massively-parallel
feature useful (or maybe both).

[To anyone who just reads this, but did not see the original series, I
should also point out that this only applies within a tNNNN-foo.sh test
file.  You can already parallelize a full valgrind test run much better
than the above.]

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
