From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-subtree Ready #2
Date: Mon, 20 Feb 2012 15:14:43 -0800
Message-ID: <7vd399jdwc.fsf@alter.siamese.dyndns.org>
References: <877gztmfwy.fsf@smith.obbligato.org>
 <8739acra5j.fsf@smith.obbligato.org>
 <20120215050855.GB29902@sigill.intra.peff.net>
 <87sjicpsr1.fsf@smith.obbligato.org> <87ty2ro1zf.fsf@smith.obbligato.org>
 <20120220205346.GA6335@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David A. Greene" <greened@obbligato.org>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 21 00:14:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzcRZ-0006C0-2L
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 00:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714Ab2BTXOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 18:14:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40510 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317Ab2BTXOq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 18:14:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E594B661B;
	Mon, 20 Feb 2012 18:14:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=VX+oHIaLnORZrhoFA5AlBzUvl5U=; b=Wf5SIoAxXLr0uph37vdI
	jTIAQbwLP5mVPdk2eprzMcO6/5xVaN9+iNgxy1aJPXIqKQlb8Lw8soK/zhqnqRmz
	+0POhaAk8sRjBsDdSX6iucyYK0wD4C4BJc78GcBTffS8AXwR4dO225EgJpp1xlYH
	3/mo4Tf21iMJp6XronDG2z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Lea1x5dNk+UeHrPBTr/3ZhDf8JL+++0S/p1VpLkLcqITNv
	uOgCZl7Lcror+VKiUJaYHhHd347LfAw37UXEKAP4ig+CZFoy+ZR63E+xXtcOrAiD
	Uxqd5CPgt2MHHMBCIOouwFaLcpWy3PWlNGDFQ1lx7aSRX9QulJMylTIWD/nd0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC516661A;
	Mon, 20 Feb 2012 18:14:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 369C46619; Mon, 20 Feb 2012
 18:14:45 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD2F4E96-5C18-11E1-A62F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191124>

Jeff King <peff@peff.net> writes:

> On Wed, Feb 15, 2012 at 10:07:16PM -0600, David A. Greene wrote:
> ...
> Of course there's no real reason we can't take it slow by putting it in
> contrib, and then graduating from there. It just seems like an
> unnecessary and complicated interim step. Either way, I do think it's
> worth saving the commit history by doing a real merge.
>
> I dunno. It is really up to Junio, I guess.

It sounds like the simplest and cleanest would be to treat it as if its
current version came as a patch submission, cook it just like any other
topic in 'pu' down to 'next' down to eventually 'master', with the usual
review cycle of pointing out what is wrong and needs fixing followed by a
series of re-rolls.

The total amount of change does not look too bad, either:

    $ git diff --stat master...origin/subtree
     contrib/subtree/.gitignore         |    5 +
     contrib/subtree/COPYING            |  339 +++++++++++++++++
     contrib/subtree/Makefile           |   45 +++
     contrib/subtree/README             |    8 +
     contrib/subtree/git-subtree.sh     |  712 ++++++++++++++++++++++++++++++++++++
     contrib/subtree/git-subtree.txt    |  366 ++++++++++++++++++
     contrib/subtree/t/Makefile         |   71 ++++
     contrib/subtree/t/t7900-subtree.sh |  508 +++++++++++++++++++++++++
     contrib/subtree/todo               |   50 +++
     t/test-lib.sh                      |   11 +-
     10 files changed, 2114 insertions(+), 1 deletion(-)

It does look like it needs to start its life in contrib/ if we were to put
this in git.git. I haven't looked at the script fully, but it has an issue
from its first line, which is marked with "#!/bin/bash".  It is unclear if
it is infested by bash-isms beyond repair (in which case "#!/bin/bash" is
fine), or it was written portably but was marked with "#!/bin/bash" just
by inertia.  A patch that corresponds to the above diffstat immediately
shows many style issues including trailing eye-sore whitespaces.

It seems that it is even capable of installing from contrib/subtree, so
keeping it in contrib/ while many issues it may have gets fixed would not
hurt the original goal of giving the script more visibility.

The change to t/test-lib.sh should be made independent of this topic, I
would think.

----------------------------------------------------------------
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e28d5fd..c877a91 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -55,6 +55,7 @@ unset $(perl -e '
 		.*_TEST
 		PROVE
 		VALGRIND
+                BUILD_DIR
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
@@ -924,7 +925,15 @@ then
 	# itself.
 	TEST_DIRECTORY=$(pwd)
 fi
-GIT_BUILD_DIR="$TEST_DIRECTORY"/..
+
+if test -z "$GIT_BUILD_DIR"
+then
+    echo Here
+	# We allow tests to override this, in case they want to run tests
+	# outside of t/, e.g. for running tests on the test library
+	# itself.
+        GIT_BUILD_DIR="$TEST_DIRECTORY"/..
+fi
 
 if test -n "$valgrind"
 then
----------------------------------------------------------------
This change deserves its own justification.

After looking at the history of subtree branch there, however, I agree
that it would not help anybody to have its history in my tree with log
messages like these (excerpt from shortlog output):

      update todo
      Some todo items reported by pmccurdy
      todo
      Docs: when pushing to github, the repo path needs to end in .git
      todo
      todo^
      todo
      todo: idea for a 'git subtree grafts' command
