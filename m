From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: modernise style: more uses of test_line_count
Date: Wed, 11 Apr 2012 09:52:38 -0700
Message-ID: <7vy5q2ky7d.fsf@alter.siamese.dyndns.org>
References: <e701486509c3306420e6bcf82e7d0d79fb2e7ae1.1334143281.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:53:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0mw-00063D-1V
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673Ab2DKQwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 12:52:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60190 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932418Ab2DKQwl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:52:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CC6865BD;
	Wed, 11 Apr 2012 12:52:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=/AM6IvHkLXdhYbmJNFasXpTkukA=; b=aB2TtNGdVXqhVl8i3pkY
	lDQcyqwT1g5BKKq6aN49iJkqBgOK2KGBP7tejAarmiDeTO9ffw6ZdOh000WMlsHO
	6ei0Gvw6ljze/zWa/bP5hVuf4/chdI+qikwMRUuS9CwTJPUgOp5oKVa69Ut+VutY
	iKC6cqiuGMU1h0K+5Mz2hPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=DL1AWA6acJoIPDcDQNUNJXJtWRGIaTOjZl+dZyCxWVAX5v
	sZU/r8V3Bac3BUCDROXROFKCUNfChbeuidfxRofetWU9N0EWY7WogircWSz8ClnD
	lrxrCF9Fwx7YJh4fHvcPC8Iy4rLfmlPD+KBqPY9T9UwllGUJABR+11etdh5y8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8317265BC;
	Wed, 11 Apr 2012 12:52:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1686C65BB; Wed, 11 Apr 2012
 12:52:39 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFCEE5BA-83F6-11E1-8330-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195216>

I'll squash this in, but otherwise it looks good.  There is nothing
conflicting in flight right now.

Thanks.

 t/t3415-rebase-autosquash.sh         |    4 ++--
 t/t6042-merge-rename-corner-cases.sh |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 5fc366a..a1e86c4 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -33,7 +33,7 @@ test_auto_fixup () {
 	test_tick &&
 	git rebase $2 -i HEAD^^^ &&
 	git log --oneline >actual &&
-	test_line_count = 3 actual
+	test_line_count = 3 actual &&
 	git diff --exit-code $1 &&
 	test 1 = "$(git cat-file blob HEAD^:file1)" &&
 	test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
@@ -62,7 +62,7 @@ test_auto_squash () {
 	test_tick &&
 	git rebase $2 -i HEAD^^^ &&
 	git log --oneline >actual &&
-	test_line_count = 3 actual
+	test_line_count = 3 actual &&
 	git diff --exit-code $1 &&
 	test 1 = "$(git cat-file blob HEAD^:file1)" &&
 	test 2 = $(git cat-file commit HEAD^ | grep first | wc -l)
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index b8d15fc..466fa38 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -104,7 +104,7 @@ test_expect_failure 'conflict caused if rename not detected' '
 	test 0 -eq $(git ls-files -u | wc -l) &&
 	test 0 -eq $(git ls-files -o | wc -l) &&
 
-	test_line_count = 6 c
+	test_line_count = 6 c &&
 	test $(git rev-parse HEAD:a) = $(git rev-parse B:a) &&
 	test $(git rev-parse HEAD:b) = $(git rev-parse A:b)
 '
