From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t: Replace 'perl' by $PERL_PATH
Date: Tue, 12 Jun 2012 09:44:10 -0700
Message-ID: <7vhaugjx9h.fsf@alter.siamese.dyndns.org>
References: <1339441313-5296-1-git-send-email-vfr@lyx.org>
 <7v1ull7j9k.fsf@alter.siamese.dyndns.org>
 <CABPQNSY=X8HG__vcEncdcgjT4fvqaC1gX_5_QH4n0+bX0tNT6g@mail.gmail.com>
 <7vsje0jyxh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: vfr@lyx.org, git@vger.kernel.org, Jeff King <peff@peff.net>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 12 18:44:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeUCX-0008QF-Sj
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 18:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202Ab2FLQoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 12:44:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37889 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743Ab2FLQoN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 12:44:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38D4B9373;
	Tue, 12 Jun 2012 12:44:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dddvq5nDWKGX/QrZbj4xUYyj8yM=; b=WgwvNf
	c07inpDjxNMO7kc2Oq6NMIgK98HhQIsSmeS3OpgkQT9OfhPM05V8APedoxRwRcdx
	h/P4TMcWmiH+00aC4Zxpak+Kw5xzAxupKpAFiEDRjW8Usbdi1cMHmyHP8WuV8hHF
	aSA6OpdtZo1sT+R5RQ1EksyvWEszOJhKn/4Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kxOa08uc01z1Xoj0NYwJq/tUoHrwyNkA
	vZWzb/iOj0w6lJ6g9FMZ7oNcM59/4CYQDNbiiJ8hiysWros/EwsgoZSjffJ4SUXc
	u4XuCggVqv/0qpQZ0K3V2XtxA2+lt5AFYx0lI8Dvx/ZlitbRXr3+TKlLze2Erf29
	WJg5dtOpVVk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 308CA9372;
	Tue, 12 Jun 2012 12:44:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EB159370; Tue, 12 Jun 2012
 12:44:11 -0400 (EDT)
In-Reply-To: <7vsje0jyxh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 12 Jun 2012 09:08:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D65D5E1E-B4AD-11E1-B0F6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199810>

Junio C Hamano <gitster@pobox.com> writes:

> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> Having an MSYS version of Perl in PATH is "broken" in the Windows
>> world, so it's THIS Perl that people might want to keep out of their
>> PATH.
>
> Fair enough.  After all, that is why we have $PERL_PATH that can be
> used (and is used) in our Porcelain scripts.

Let's also apply something like this to t/README.

As to vfr's patch, I'll replace $PERL_PATH with "$PERL_PATH" and queue.


 t/README | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/t/README b/t/README
index 3534f43..4c3ea25 100644
--- a/t/README
+++ b/t/README
@@ -307,6 +307,25 @@ Don't:
    Use test_done instead if you need to stop the tests early (see
    "Skipping tests" below).
 
+ - use '! git cmd' when you want to make sure the git command exits
+   with failure in a controlled way by calling "die()".  Instead,
+   use 'test_must_fail git cmd'.  This will signal a failure if git
+   dies in an unexpected way (e.g. segfault).
+
+ - use perl without spelling it as "$PERL_PATH". This is to help our
+   friends on Windows where the platform Perl often adds CR before
+   the end of line, and they bundle Git with a version of Perl that
+   does not do so, whose path is specified with $PERL_PATH.
+
+ - use sh without spelling it as "$SHELL_PATH", when your script can
+   be misinterpreted by broken platform shell (e.g. Solaris).
+
+ - chdir around in tests.  It is not sufficient to chdir to
+   somewhere and then chdir back to the original location later in
+   the test, as any intermediate step can fail and abort the test,
+   causing the next test to start in an unexpected directory.  Do chdir
+   inside a subshell if necessary.
+
  - Break the TAP output
 
    The raw output from your test may be interpreted by a TAP harness. TAP
@@ -342,9 +361,9 @@ If you need to skip tests you should do so by using the three-arg form
 of the test_* functions (see the "Test harness library" section
 below), e.g.:
 
-    test_expect_success PERL 'I need Perl' "
-        '$PERL_PATH' -e 'hlagh() if unf_unf()'
-    "
+    test_expect_success PERL 'I need Perl' '
+        "$PERL_PATH" -e "hlagh() if unf_unf()"
+    '
 
 The advantage of skipping tests like this is that platforms that don't
 have the PERL and other optional dependencies get an indication of how
