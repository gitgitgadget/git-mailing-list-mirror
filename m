From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v6 1/5] t6006 (rev-list-format): don't hardcode SHA-1 in expected outputs
Date: Tue, 25 Jun 2013 12:55:28 +0400
Message-ID: <b67a3a9e4320465c771a47559b45665bd45f9194.1372149305.git.Alex.Crezoff@gmail.com>
References: <cover.1372149305.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 10:58:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrP4p-0001IX-6D
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 10:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab3FYI56 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jun 2013 04:57:58 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:62955 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab3FYIzo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 04:55:44 -0400
Received: by mail-la0-f53.google.com with SMTP id fs12so11774380lab.12
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 01:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=JnVXYqUbLXqLHenlGFl4H81YNlOG3clAKy3vwvOv8Ag=;
        b=am8GtcV7og9s7s1BLb+9ENp+g1djDBo03o+aIgyB6rpjeDuoJYOnXs/rKJOm3LY6uB
         XzmalwqDFOhBmcrEwihQqyZVyiaQVZuMmfLsdjiN/SpHXa0M9C1Cz/Lkb94bj2KvZ+tE
         EdedF/W/FEeS7BCD5hrhVeNLkNlDowNCv8bW8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=JnVXYqUbLXqLHenlGFl4H81YNlOG3clAKy3vwvOv8Ag=;
        b=hOLILnq7MniQXqmGpXmz7/tsYLYSZR2me8KzA6wL/WiMOUlD8mfwvHbJ5lg4vpWnEt
         Snh+1ECIOIWHINU2ER/t+NzqIMsgUaE2/6obYHvbmJBJJdbsTd8/gLtlT3ZjNlINIvA5
         EX1EB0Po1/UhYgbcUJHBE9S7RcMuSvu99BZypWTXbYuWPOM5H+kjYTZ2fd+3hmfuuqID
         rWx2y3m6mlCsDMtxuaJduNTDO/A2JbOJxZc/VyBv+ToEhuDbH8lZCR4LcZBJwCn4ZBjM
         mORrZIsqv2A11fDai0G0rbd4xcEjD0ViT0OJ16XXRF75gBZUn6kKD/WchM+If6KQqAR/
         +kMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=JnVXYqUbLXqLHenlGFl4H81YNlOG3clAKy3vwvOv8Ag=;
        b=EvGylLJdb8kHDPi4RrAqTFcnzPJ6GeL9ZeNJL5LslHdiSidjGvWrXOhB9f7wmCR1NI
         EVfSFQ7FbmDnbANnlTcGMVtuHwHj0Twyv/greB1o8DC0Ak7fy/Ieen5B4/AcrcmMlwlW
         b+han5IaG7Dqc8fQ4PE9J7Sy+67AJnfqA5KSsn2RTTgX/Ze/1UKTyjItTUexk+L0v8KD
         XaYq1SPFuGPQi3O84bMgycPrLe6/5YuN+aFAyh0icJbtTPnEhXpbibF1zu/wy37hpr7k
         xweoa8rda0c6+AnBQocX3K8TCKKDc7uCOews+JxKu+PH7OEDWLPTFZHo2EHE0qvAUdrR
         H+rg==
X-Received: by 10.112.219.102 with SMTP id pn6mr2985824lbc.18.1372150542987;
        Tue, 25 Jun 2013 01:55:42 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id m1sm8346564lag.3.2013.06.25.01.55.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 01:55:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1372149305.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1372149305.git.Alex.Crezoff@gmail.com>
References: <cover.1371720245.git.Alex.Crezoff@gmail.com> <cover.1372149305.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQlCNVX92UZEg4kAmbtMGTZypfen7fHSMBDHtXWmbsMzvyX0SjZCo1i6lEAnt70W28R4FswG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228953>

The expected SHA-1 digests are always available in variables. Use
them instead of hardcoding.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t6006-rev-list-format.sh | 140 +++++++++++++++++++++++++------------=
--------
 1 file changed, 77 insertions(+), 63 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 0393c9f..cc1008d 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -7,8 +7,19 @@ test_description=3D'git rev-list --pretty=3Dformat tes=
t'
=20
 test_tick
 test_expect_success 'setup' '
-touch foo && git add foo && git commit -m "added foo" &&
-  echo changed >foo && git commit -a -m "changed foo"
+	: >foo &&
+	git add foo &&
+	git commit -m "added foo" &&
+	head1=3D$(git rev-parse --verify HEAD) &&
+	head1_short=3D$(git rev-parse --verify --short $head1) &&
+	tree1=3D$(git rev-parse --verify HEAD:) &&
+	tree1_short=3D$(git rev-parse --verify --short $tree1) &&
+	echo changed >foo &&
+	git commit -a -m "changed foo" &&
+	head2=3D$(git rev-parse --verify HEAD) &&
+	head2_short=3D$(git rev-parse --verify --short $head2) &&
+	tree2=3D$(git rev-parse --verify HEAD:) &&
+	tree2_short=3D$(git rev-parse --verify --short $tree2)
 '
=20
 # usage: test_format name format_string <expected_output
@@ -32,49 +43,49 @@ has_no_color () {
 	test_cmp expect "$1"
 }
=20
-test_format percent %%h <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format percent %%h <<EOF
+commit $head2
 %h
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 %h
 EOF
=20
-test_format hash %H%n%h <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-131a310eb913d107dd3c09a65d1651175898735d
-131a310
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-86c75cf
+test_format hash %H%n%h <<EOF
+commit $head2
+$head2
+$head2_short
+commit $head1
+$head1
+$head1_short
 EOF
=20
-test_format tree %T%n%t <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-fe722612f26da5064c32ca3843aa154bdb0b08a0
-fe72261
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-4d5fcadc293a348e88f777dc0920f11e7d71441c
-4d5fcad
+test_format tree %T%n%t <<EOF
+commit $head2
+$tree2
+$tree2_short
+commit $head1
+$tree1
+$tree1_short
 EOF
=20
-test_format parents %P%n%p <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-86c75cf
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+test_format parents %P%n%p <<EOF
+commit $head2
+$head1
+$head1_short
+commit $head1
=20
=20
 EOF
=20
 # we don't test relative here
-test_format author %an%n%ae%n%ad%n%aD%n%at <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format author %an%n%ae%n%ad%n%aD%n%at <<EOF
+commit $head2
 A U Thor
 author@example.com
 Thu Apr 7 15:13:13 2005 -0700
 Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 A U Thor
 author@example.com
 Thu Apr 7 15:13:13 2005 -0700
@@ -82,14 +93,14 @@ Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
 EOF
=20
-test_format committer %cn%n%ce%n%cd%n%cD%n%ct <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format committer %cn%n%ce%n%cd%n%cD%n%ct <<EOF
+commit $head2
 C O Mitter
 committer@example.com
 Thu Apr 7 15:13:13 2005 -0700
 Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 C O Mitter
 committer@example.com
 Thu Apr 7 15:13:13 2005 -0700
@@ -97,43 +108,43 @@ Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
 EOF
=20
-test_format encoding %e <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+test_format encoding %e <<EOF
+commit $head2
+commit $head1
 EOF
=20
-test_format subject %s <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format subject %s <<EOF
+commit $head2
 changed foo
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 added foo
 EOF
=20
-test_format body %b <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+test_format body %b <<EOF
+commit $head2
+commit $head1
 EOF
=20
-test_format raw-body %B <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format raw-body %B <<EOF
+commit $head2
 changed foo
=20
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 added foo
=20
 EOF
=20
-test_format colors %Credfoo%Cgreenbar%Cbluebaz%Cresetxyzzy <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format colors %Credfoo%Cgreenbar%Cbluebaz%Cresetxyzzy <<EOF
+commit $head2
 =1B[31mfoo=1B[32mbar=1B[34mbaz=1B[mxyzzy
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 =1B[31mfoo=1B[32mbar=1B[34mbaz=1B[mxyzzy
 EOF
=20
-test_format advanced-colors '%C(red yellow bold)foo%C(reset)' <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format advanced-colors '%C(red yellow bold)foo%C(reset)' <<EOF
+commit $head2
 =1B[1;31;43mfoo=1B[m
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 =1B[1;31;43mfoo=1B[m
 EOF
=20
@@ -186,39 +197,42 @@ This commit message is much longer than the other=
s,
 and it will be encoded in iso8859-1. We should therefore
 include an iso8859 character: =A1bueno!
 EOF
+
 test_expect_success 'setup complex body' '
-git config i18n.commitencoding iso8859-1 &&
-  echo change2 >foo && git commit -a -F commit-msg
+	git config i18n.commitencoding iso8859-1 &&
+	echo change2 >foo && git commit -a -F commit-msg &&
+	head3=3D$(git rev-parse --verify HEAD) &&
+	head3_short=3D$(git rev-parse --short $head3)
 '
=20
-test_format complex-encoding %e <<'EOF'
-commit 1ed88da4a5b5ed8c449114ac131efc62178734c3
+test_format complex-encoding %e <<EOF
+commit $head3
 iso8859-1
-commit 131a310eb913d107dd3c09a65d1651175898735d
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head2
+commit $head1
 EOF
=20
-test_format complex-subject %s <<'EOF'
-commit 1ed88da4a5b5ed8c449114ac131efc62178734c3
+test_format complex-subject %s <<EOF
+commit $head3
 Test printing of complex bodies
-commit 131a310eb913d107dd3c09a65d1651175898735d
+commit $head2
 changed foo
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 added foo
 EOF
=20
-test_format complex-body %b <<'EOF'
-commit 1ed88da4a5b5ed8c449114ac131efc62178734c3
+test_format complex-body %b <<EOF
+commit $head3
 This commit message is much longer than the others,
 and it will be encoded in iso8859-1. We should therefore
 include an iso8859 character: =A1bueno!
=20
-commit 131a310eb913d107dd3c09a65d1651175898735d
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head2
+commit $head1
 EOF
=20
 test_expect_success '%x00 shows NUL' '
-	echo  >expect commit 1ed88da4a5b5ed8c449114ac131efc62178734c3 &&
+	echo  >expect commit $head3 &&
 	echo >>expect fooQbar &&
 	git rev-list -1 --format=3Dfoo%x00bar HEAD >actual.nul &&
 	nul_to_q <actual.nul >actual &&
--=20
1.8.3.1.15.g5c23c1e
