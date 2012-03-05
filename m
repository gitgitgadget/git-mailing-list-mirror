From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-{pull,rebase} message without tracking
 information friendlier
Date: Sun, 04 Mar 2012 23:49:20 -0800
Message-ID: <7vty2332tb.fsf@alter.siamese.dyndns.org>
References: <vpqbooit61u.fsf@bauges.imag.fr>
 <1330540914-14515-1-git-send-email-cmn@elego.de>
 <7vobshs8go.fsf@alter.siamese.dyndns.org>
 <1330836086.691.87.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 08:49:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Sfh-0007LL-0H
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 08:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267Ab2CEHtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 02:49:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54200 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828Ab2CEHtX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 02:49:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BAED50AC;
	Mon,  5 Mar 2012 02:49:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=eGB8H29liO4aw92gqc3O6U7/Yy4=; b=o/QtwazfHNuqN46z+Zlz
	9jVPmtJEJ6l1lI+t+UCke1n07uJZupZUDBnnpmkfE4vO3aVQo8Aa/Rckg747oytU
	8kqc62WPs7+FfaNn6/pCeoLTdKiMIaOYzzB8Xl1nDmGeMNPx8tc4wLSlWEqbFZPG
	MtggogdaxoXVHriD4j5afpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=XA+Am7Q+kqRczJ3Nbc7gm/7wCcumzcXYwQ8CPErtBIXPQ1
	sZLJ9m/zbi9stRKaHCmU0BykcMIKvm1dpMl4yrZJVF3ZIbolQMouNYCCGfFNvFWT
	z/93dwFzkEQuJ3gEUnBdPpsaFIVFsUOTb+5aihWF2/2fwQ8QM+D8Uah+Wvme0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4364450AB;
	Mon,  5 Mar 2012 02:49:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC5B950AA; Mon,  5 Mar 2012
 02:49:21 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8734A4E-6697-11E1-97A5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192210>

I think the updated message is much easier to read, so I've queued
this almost as-is (except for minor and obvious typo fixes,
e.g. whish) and merged it to 'next'.

Thanks.

By the way, these needed to be squashed in.

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index e647272..370ffdf 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -160,14 +160,12 @@ rm -f B
 
 test_expect_success 'fail when upstream arg is missing and not on branch' '
 	git checkout topic &&
-	test_must_fail git rebase >output.out &&
-	grep "You are not currently on a branch" output.out
+	test_must_fail git rebase
 '
 
 test_expect_success 'fail when upstream arg is missing and not configured' '
 	git checkout -b no-config topic &&
-	test_must_fail git rebase >output.out &&
-	grep "branch.no-config.merge" output.out
+	test_must_fail git rebase
 '
 
 test_expect_success 'default to @{upstream} when upstream arg is missing' '
