From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/7] i18n: mark init-db messages for translation
Date: Tue, 12 Apr 2011 15:55:41 -0700
Message-ID: <7v62qjnkpe.fsf@alter.siamese.dyndns.org>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
 <1302464048-21806-2-git-send-email-avarab@gmail.com>
 <7v39lorli9.fsf@alter.siamese.dyndns.org>
 <7vy63gq6s2.fsf@alter.siamese.dyndns.org>
 <BANLkTincUmH7SjypXfDMXDfg8BxW4MW+Jg@mail.gmail.com>
 <7vsjtnpc0k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 00:56:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9mV4-00077j-Hn
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 00:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515Ab1DLWzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 18:55:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55945 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080Ab1DLWzw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 18:55:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BF55F580B;
	Tue, 12 Apr 2011 18:57:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bes7r85B/ySGTU/+meeGeybEsls=; b=Fd2hgd
	P5isAaSBWCbv0OzZNUoztWq2cADoJF8/PvFSYstHq3RgZqmwGkQsgb2LI4TvY8JF
	G4yXwAbM5NpOCE3s2Nf1MOnT1EAher4yG20DOnmim76GS01b715OH8LTtL/+JjXZ
	carCuq9zJeJqcnS6jTp7OUXZ1sv0aqOEbHzxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DV+mAt2uFkglHSCTaMPrcvUAnDsFJmvi
	mjOfeUOEurBopVHZIDY4y0ddEYTGQr7rDjnKDfTDcr1kDuirw0Ve5SN1ge8AJrZB
	micAjMYKGyV64QPihQppOeVIDNO7WFDzNsGtnu/emKr4rxKTc27NCQ2yD1UK6mUQ
	rX2E6ntHUDI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9F5B15801;
	Tue, 12 Apr 2011 18:57:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9D3C457FB; Tue, 12 Apr 2011
 18:57:40 -0400 (EDT)
In-Reply-To: <7vsjtnpc0k.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 12 Apr 2011 11:20:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46831F54-6558-11E0-B004-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171425>

Junio C Hamano <gitster@pobox.com> writes:

> By the way, don't you think the attached is far easier to read than
> artificially breaking a single test into "do" and "check" phase?  The
> majority of the l10n dependent tests can and should lose C_LOCALE_OUTPUT
> prerequisite and use this instead for far superiour readability, I think.
>
> At least this makes it far more pleasant to read both the actual script
> and the output in non-poison cases.

And this is for the other common pattern: use grep to find expected
string.

 t/test-lib.sh   |    8 ++++++++
 t/t0001-init.sh |   10 +++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3e7c2bb..b764acb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1085,6 +1085,14 @@ test_i18ncmp () {
 	test -n "$GETTEXT_POISON" || test_cmp "$@"
 }
 
+# Use this instead of "grep expected-string actual" to see if the
+# output from a git command that acn be translated contains an
+# expected string.  When running under GETTEXT_POISON this pretends
+# that the command produced expected results.
+test_i18ngrep () {
+	test -n "$GETTEXT_POISON" || grep "$@"
+}
+
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYMLINKS
 rm -f y
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index a5816d0..651e098 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -180,7 +180,7 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 	fi
 '
 
-test_expect_success C_LOCALE_OUTPUT 'reinit' '
+test_expect_success 'reinit' '
 
 	(
 		sane_unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG &&
@@ -190,11 +190,11 @@ test_expect_success C_LOCALE_OUTPUT 'reinit' '
 		git init >out1 2>err1 &&
 		git init >out2 2>err2
 	) &&
-	grep "Initialized empty" again/out1 &&
-	grep "Reinitialized existing" again/out2 &&
+	test_i18ngrep "Initialized empty" again/out1 &&
+	test_i18ngrep "Reinitialized existing" again/out2 &&
 	>again/empty &&
-	test_cmp again/empty again/err1 &&
-	test_cmp again/empty again/err2
+	test_i18ncmp again/empty again/err1 &&
+	test_i18ncmp again/empty again/err2
 '
 
 test_expect_success 'init with --template' '
