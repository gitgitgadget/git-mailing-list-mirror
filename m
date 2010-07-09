From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tests: Use skip_all=<reason> to skip tests
Date: Fri, 09 Jul 2010 10:49:18 -0700
Message-ID: <7v4og8mtpd.fsf@alter.siamese.dyndns.org>
References: <4C36ECDB.9090707@drmicha.warpmail.net>
 <1278675688-4702-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 19:49:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXHhe-0006Nt-U4
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 19:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126Ab0GIRt3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 13:49:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab0GIRt2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 13:49:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 77351C39C8;
	Fri,  9 Jul 2010 13:49:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=c/2pgIY0CCBl
	aAIaAL9MmX5r3Ww=; b=B/lVKjCvyfWTPY0Dijevxqp0rL22DLOxF8ieiAaEfygV
	tpesfGkaOFC5yDCwuLqcGIZ9xrts8FciGRuHaoPnJTb6wgqjJR+MftP0jC47lI5T
	1PrhGToi00SE3b011ucHq9bWVdRGzhDPt4Cjdm4xnPpqJFYGABlWVMjIu6IWZn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DhfiPW
	Q6pqHgCbL6G+FN6TioswofrT17rvzwFJE6AEHMGN2Pwh4XMtLAu/9ep3RjGZ9dri
	AArK+r2XdMRO/uBRpUxZziapM9WhiJTSncaMVGt/pxem5JS+a0lye9nbkAPmmSVd
	l0lube30rrWpWEiDDS1YFA8yjShz0f5cMSHlw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4250CC39C7;
	Fri,  9 Jul 2010 13:49:24 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C184C39C3; Fri,  9 Jul
 2010 13:49:19 -0400 (EDT)
In-Reply-To: <1278675688-4702-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\,  9 Jul
 2010 11\:41\:28 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4FA1F052-8B82-11DF-B8A3-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150681>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change tests to skip with skip_all=3D<reason> + test_done, instead of
> using say <reason> + test_done.
>
> This is a follow-up to "tests: Skip tests in a way that makes sense
> under TAP" (fadb5156e4). I missed these cases when preparing that
> patch, hopefully this is all of them.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>
> On Fri, Jul 9, 2010 at 09:33, Michael J Gruber <git@drmicha.warpmail.=
net> wrote:
>> After trying out tests with prove (I like it!) I was just about to m=
ake
>> a patch before I saw this...
>
> Great, good to know that you find the TAP support useful.
>
>> So, this does what it should, at least with my set of prerequisites.
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 08.07.201=
0 03:16:
>>> Change tests to skip with skip_all=3D* + test_done instead of using=
 say
>>> + test_done.
>>
>> I didn't understand this at all at first, only after I was about to
>> write that patch myself. Maybe 'with skip_all=3D"reason"' or
>> 'skip_all=3D<reason>' etc.?
>
> Changed the subject + body of the patch to use <reason>

That makes sense, but I am beginning to hate this skip_all business.

There is no "skip"-ness to what the variable does from the semantic poi=
nt
of view.  In the context of test helper library whose service consists =
of
counting the number of tests that succeeded, failed, and are known to b=
e
still broken, one would expect that the word "skip" would mean it someh=
ow
would help counting the tests that are prepared by the test author but
were not run for some reason, but this variable is not about that (note
that I am not suggesting us to actually count and say "N tests skipped"=
).
It is only about giving parting words at the end before the test script
exits.

The variable is not about skip_ALL either.  In the majority of cases, i=
t
is more like "finishing here, telling the user that we are doing so
without running the remainder of the script", and in one case, it is mo=
re
like "skipped one test, reporting after the fact".

Among 63 assignments to $skip_all that are all over in t/*.sh scripts, =
the
only ones that are not immediately followed by test_done are in
lib-git-svn.sh (chooses one among 3 messages), lib-httpd.sh (sets a tra=
p
before calling test_done), and t3600-rm (makes a mental note to report
that one test was skipped long before all the tests run).

I suspect that it might be much easier in the long run for test writers=
 if
we made test_done take optional "parting words" parameter instead of us=
ing
a global variable "$skip_all" and forcing them to carefully set it.  Th=
en
we can lose special meaning to the global variable $skip_all, most of t=
he
scripts that currently assign to the variable do not need the assignmen=
ts,
and only the very few special cases can use $skip_all as their local
convention to decide what optional "parting words" parameter to give to
the test_done helper.

The change would look something like this (I just did a few as a
demonstration).

What do you think?

 t/lib-git-svn.sh            |   11 ++++-------
 t/t2007-checkout-symlink.sh |    3 +--
 t/test-lib.sh               |    5 +----
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index c3f6676..cfc0d5b 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -5,12 +5,10 @@ git_svn_id=3Dgit""-svn-id
=20
 if test -n "$NO_SVN_TESTS"
 then
-	skip_all=3D'skipping git svn tests, NO_SVN_TESTS defined'
-	test_done
+	test_done 'skipping git svn tests, NO_SVN_TESTS defined'
 fi
 if ! test_have_prereq PERL; then
-	skip_all=3D'skipping git svn tests, perl not available'
-	test_done
+	test_done 'skipping git svn tests, perl not available'
 fi
=20
 GIT_DIR=3D$PWD/.git
@@ -21,8 +19,7 @@ PERL=3D${PERL:-perl}
 svn >/dev/null 2>&1
 if test $? -ne 1
 then
-    skip_all=3D'skipping git svn tests, svn not found'
-    test_done
+    test_done 'skipping git svn tests, svn not found'
 fi
=20
 svnrepo=3D$PWD/svnrepo
@@ -46,7 +43,7 @@ then
 	else
 		skip_all=3D'Perl SVN libraries not found or unusable'
 	fi
-	test_done
+	test_done "$skip_all"
 fi
=20
 rawsvnrepo=3D"$svnrepo"
diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index 05cc8fd..fd3d7be 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -8,8 +8,7 @@ test_description=3D'git checkout to switch between bran=
ches with symlink<->dir'
=20
 if ! test_have_prereq SYMLINKS
 then
-	skip_all=3D"symbolic links not supported - skipping tests"
-	test_done
+	test_done "symbolic links not supported - skipping tests"
 fi
=20
 test_expect_success setup '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ac496aa..2c4474d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -657,12 +657,9 @@ test_done () {
 	fi
 	case "$test_failure" in
 	0)
-		# Maybe print SKIP message
-		[ -z "$skip_all" ] || skip_all=3D" # SKIP $skip_all"
-
 		if test $test_external_has_tap -eq 0; then
 			say_color pass "# passed all $msg"
-			say "1..$test_count$skip_all"
+			say "1..$test_count${1:+" # SKIP $1"}"
 		fi
=20
 		test -d "$remove_trash" &&
