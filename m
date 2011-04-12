From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/7] i18n: mark init-db messages for translation
Date: Tue, 12 Apr 2011 11:20:27 -0700
Message-ID: <7vsjtnpc0k.fsf@alter.siamese.dyndns.org>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
 <1302464048-21806-2-git-send-email-avarab@gmail.com>
 <7v39lorli9.fsf@alter.siamese.dyndns.org>
 <7vy63gq6s2.fsf@alter.siamese.dyndns.org>
 <BANLkTincUmH7SjypXfDMXDfg8BxW4MW+Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 20:20:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9iCj-00060J-2I
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 20:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327Ab1DLSUm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 14:20:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932291Ab1DLSUk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 14:20:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F1FB83469;
	Tue, 12 Apr 2011 14:22:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4SWPDoLLHAt9
	Z1HvA0lR9UNTfYM=; b=dVRNhYnQuqR/AmWu+Imi49r/XZlcihiPJ7GpCaING/Fm
	GxWcuTJfQIXzx84O7P3eHQOXJKOZkyehcukxZtCzcO52v/QEi/mlPvgubTR8KHcr
	k/WkLgzfOZJ/LKErsp4j/BCP9MuPcpoWGn9yfrj3/6TZBoN8O+JTQeMDkfeRh44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hCE+Jo
	iYYbM1iADbI+UZyqADUgjfpSVBvhGszRi9wRBlai3Q5rcMpzr/Fo858bxXMfy+sy
	DY6rH5HSgFxr5eYbi8sOZHQfnrD42F99kRBD3UCkSfbLbd3rgn5KFZ5JZ3ef2oUT
	L0F8NPEy7bb7NBF7777BNnI45z3XKb4FE0PFw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CEE313466;
	Tue, 12 Apr 2011 14:22:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 692B03465; Tue, 12 Apr 2011
 14:22:27 -0400 (EDT)
In-Reply-To: <BANLkTincUmH7SjypXfDMXDfg8BxW4MW+Jg@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 12 Apr
 2011 09:44:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D41AF606-6531-11E0-8D91-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171409>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Ah, thanks. Missed that. I'd have spotted it if I dug down instead of=
 sending.
>
> I'll re-send one without the translation for this plumbing message.

No need to resend, if the reroll is just the removal of the part that
marks the fprintf() argument, and sprinkles t0001 with C_LOCALE_OUTPUT
to skip checking of the contents of .git file.

By the way, don't you think the attached is far easier to read than
artificially breaking a single test into "do" and "check" phase?  The
majority of the l10n dependent tests can and should lose C_LOCALE_OUTPU=
T
prerequisite and use this instead for far superiour readability, I thin=
k.

At least this makes it far more pleasant to read both the actual script
and the output in non-poison cases.

 t/test-lib.sh               |    8 ++++
 t/t5526-fetch-submodules.sh |   93 ++++++++++++++++-------------------=
-------
 2 files changed, 44 insertions(+), 57 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index abc47f3..3e7c2bb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1077,6 +1077,14 @@ else
 	test_set_prereq C_LOCALE_OUTPUT
 fi
=20
+# Use this instead of test_cmp to compare files that contain expected =
and
+# actual output from git commands that can be translated.  When runnin=
g
+# under GETTEXT_POISON this pretends that the command produced expecte=
d
+# results.
+test_i18ncmp () {
+	test -n "$GETTEXT_POISON" || test_cmp "$@"
+}
+
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYML=
INKS
 rm -f y
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index af78e21..a1fddd4 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -66,12 +66,9 @@ test_expect_success "fetch --recurse-submodules recu=
rses into submodules" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
-	)
-'
-
-test_expect_success C_LOCALE_OUTPUT "fetch --recurse-submodules recurs=
es into submodules: output" '
-	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err
+	) &&
+	test_i18ncmp expect.out actual.out &&
+	test_i18ncmp expect.err actual.err
 '
=20
 test_expect_success "fetch alone only fetches superproject" '
@@ -98,12 +95,9 @@ test_expect_success "using fetchRecurseSubmodules=3D=
true in .gitmodules recurses i
 		cd downstream &&
 		git config -f .gitmodules submodule.submodule.fetchRecurseSubmodules=
 true &&
 		git fetch >../actual.out 2>../actual.err
-	)
-'
-
-test_expect_success C_LOCALE_OUTPUT "using fetchRecurseSubmodules=3Dtr=
ue in .gitmodules recurses into submodules" '
-	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err
+	) &&
+	test_i18ncmp expect.out actual.out &&
+	test_i18ncmp expect.err actual.err
 '
=20
 test_expect_success "--no-recurse-submodules overrides .gitmodules con=
fig" '
@@ -132,12 +126,9 @@ test_expect_success "--recurse-submodules override=
s fetchRecurseSubmodules setti
 		git fetch --recurse-submodules >../actual.out 2>../actual.err &&
 		git config --unset -f .gitmodules submodule.submodule.fetchRecurseSu=
bmodules &&
 		git config --unset submodule.submodule.fetchRecurseSubmodules
-	)
-'
-
-test_expect_success C_LOCALE_OUTPUT "--recurse-submodules overrides fe=
tchRecurseSubmodules setting from .git/config: output" '
-	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err
+	) &&
+	test_i18ncmp expect.out actual.out &&
+	test_i18ncmp expect.err actual.err
 '
=20
 test_expect_success "--quiet propagates to submodules" '
@@ -154,24 +145,18 @@ test_expect_success "--dry-run propagates to subm=
odules" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules --dry-run >../actual.out 2>../actual.=
err
-	)
-'
-
-test_expect_success C_LOCALE_OUTPUT "--dry-run propagates to submodule=
s: output" '
-	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err
+	) &&
+	test_i18ncmp expect.out actual.out &&
+	test_i18ncmp expect.err actual.err
 '
=20
 test_expect_success "Without --dry-run propagates to submodules" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
-	)
-'
-
-test_expect_success C_LOCALE_OUTPUT "Without --dry-run propagates to s=
ubmodules: output" '
-	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err
+	) &&
+	test_i18ncmp expect.out actual.out &&
+	test_i18ncmp expect.err actual.err
 '
=20
 test_expect_success "recurseSubmodules=3Dtrue propagates into submodul=
es" '
@@ -180,12 +165,9 @@ test_expect_success "recurseSubmodules=3Dtrue prop=
agates into submodules" '
 		cd downstream &&
 		git config fetch.recurseSubmodules true
 		git fetch >../actual.out 2>../actual.err
-	)
-'
-
-test_expect_success C_LOCALE_OUTPUT "recurseSubmodules=3Dtrue propagat=
es into submodules: output" '
-	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err
+	) &&
+	test_i18ncmp expect.out actual.out &&
+	test_i18ncmp expect.err actual.err
 '
=20
 test_expect_success "--recurse-submodules overrides config in submodul=
e" '
@@ -197,12 +179,9 @@ test_expect_success "--recurse-submodules override=
s config in submodule" '
 			git config fetch.recurseSubmodules false
 		) &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
-	)
-'
-
-test_expect_success C_LOCALE_OUTPUT "--recurse-submodules overrides co=
nfig in submodule: output" '
-	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err
+	) &&
+	test_i18ncmp expect.out actual.out &&
+	test_i18ncmp expect.err actual.err
 '
=20
 test_expect_success "--no-recurse-submodules overrides config setting"=
 '
@@ -243,8 +222,8 @@ test_expect_success "Recursion stops when no new su=
bmodule commits are fetched"
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	test_cmp expect.err.sub actual.err &&
-	test_cmp expect.out.sub actual.out
+	test_i18ncmp expect.err.sub actual.err &&
+	test_i18ncmp expect.out.sub actual.out
 '
=20
 test_expect_success "Recursion doesn't happen when new superproject co=
mmits don't change any submodules" '
@@ -261,7 +240,7 @@ test_expect_success "Recursion doesn't happen when =
new superproject commits don'
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	! test -s actual.out &&
-	test_cmp expect.err.file actual.err
+	test_i18ncmp expect.err.file actual.err
 '
=20
 test_expect_success "Recursion picks up config in submodule" '
@@ -289,8 +268,8 @@ test_expect_success "Recursion picks up config in s=
ubmodule" '
 			git config --unset fetch.recurseSubmodules
 		)
 	) &&
-	test_cmp expect.err.sub actual.err &&
-	test_cmp expect.out actual.out
+	test_i18ncmp expect.err.sub actual.err &&
+	test_i18ncmp expect.out actual.out
 '
=20
 test_expect_success "Recursion picks up all submodules when necessary"=
 '
@@ -321,8 +300,8 @@ test_expect_success "Recursion picks up all submodu=
les when necessary" '
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	test_cmp expect.err.2 actual.err &&
-	test_cmp expect.out actual.out
+	test_i18ncmp expect.err.2 actual.err &&
+	test_i18ncmp expect.out actual.out
 '
=20
 test_expect_success "'--recurse-submodules=3Don-demand' doesn't recurs=
e when no new commits are fetched in the superproject (and ignores conf=
ig)" '
@@ -375,8 +354,8 @@ test_expect_success "'--recurse-submodules=3Don-dem=
and' recurses as deep as necess
 			git config --unset -f .gitmodules submodule.deepsubmodule.fetchRecu=
rsive
 		)
 	) &&
-	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err
+	test_i18ncmp expect.out actual.out &&
+	test_i18ncmp expect.err actual.err
 '
=20
 test_expect_success "'--recurse-submodules=3Don-demand' stops when no =
new submodule commits are found in the superproject (and ignores config=
)" '
@@ -393,7 +372,7 @@ test_expect_success "'--recurse-submodules=3Don-dem=
and' stops when no new submodul
 		git fetch --recurse-submodules=3Don-demand >../actual.out 2>../actua=
l.err
 	) &&
 	! test -s actual.out &&
-	test_cmp expect.err.file actual.err
+	test_i18ncmp expect.err.file actual.err
 '
=20
 test_expect_success "'fetch.recurseSubmodules=3Don-demand' overrides g=
lobal config" '
@@ -420,8 +399,8 @@ test_expect_success "'fetch.recurseSubmodules=3Don-=
demand' overrides global config
 		cd downstream &&
 		git config --unset fetch.recurseSubmodules
 	) &&
-	test_cmp expect.out.sub actual.out &&
-	test_cmp expect.err.2 actual.err
+	test_i18ncmp expect.out.sub actual.out &&
+	test_i18ncmp expect.err.2 actual.err
 '
=20
 test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=3Don-dema=
nd' overrides fetch.recurseSubmodules" '
@@ -448,8 +427,8 @@ test_expect_success "'submodule.<sub>.fetchRecurseS=
ubmodules=3Don-demand' override
 		cd downstream &&
 		git config --unset submodule.submodule.fetchRecurseSubmodules
 	) &&
-	test_cmp expect.out.sub actual.out &&
-	test_cmp expect.err.2 actual.err
+	test_i18ncmp expect.out.sub actual.out &&
+	test_i18ncmp expect.err.2 actual.err
 '
=20
 test_expect_success "don't fetch submodule when newly recorded commits=
 are already present" '
@@ -468,7 +447,7 @@ test_expect_success "don't fetch submodule when new=
ly recorded commits are alrea
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	! test -s actual.out &&
-	test_cmp expect.err actual.err
+	test_i18ncmp expect.err actual.err
 '
=20
 test_done
