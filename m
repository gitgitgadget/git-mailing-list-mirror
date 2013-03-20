From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3200 (branch): modernize style
Date: Wed, 20 Mar 2013 13:43:38 -0700
Message-ID: <7vwqt1dcp1.fsf@alter.siamese.dyndns.org>
References: <1363782612-19260-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 21:44:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIPrm-00085V-Hu
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 21:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864Ab3CTUnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 16:43:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34242 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756738Ab3CTUnl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 16:43:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85330AF87;
	Wed, 20 Mar 2013 16:43:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4oo5l/qSaQZltYAWSVWXYZVbQio=; b=iay6hy
	AGZ6L7N0YMf1IBC9y7TaON4PAjKO2vZPJ/re2/0v36w8I3aCOc84An9C0ZB8s4Ok
	jN5/r2fpUGecqSnpNIMNntfG91tHeD7IdsLZsZ1XHF7X6EmlL3UEQjfBUXekkOyu
	qI84HJ3Q1d2nLrVr/Cg0BrorqhI5QdeFv66Rw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oxSqU3TaEwO3d6p09MtsfyFcvLOnxv/0
	1NCanmgyA5d2GjqXApHqHljSjQwZYgT7hciUIQ/BgaKzCXa6VlyBA/otyJCigt9s
	QxnFvyZ6no3jHYLh1qaPDWXlvd/e72zpW5glZuizt/2RMiT2is1WfryhV9f71HJ2
	y2xd16jwCOk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7740EAF86;
	Wed, 20 Mar 2013 16:43:40 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE4BAAF76; Wed, 20 Mar 2013
 16:43:39 -0400 (EDT)
In-Reply-To: <1363782612-19260-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Wed, 20 Mar 2013 18:00:12 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D88CD5D8-919E-11E2-9BB1-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218678>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>  Another random patch. Found it while grep'ping around.  I thought I
>  could automate my work, which would have been the case if it was
>  consistently inconsistent.  Unfortunately, it wasn't, and I ended up
>  doing a lot of manual janitorial work :|

Thanks.  It would have been nicer to also fix the redirection,
e.g. "cmd >target" (not "cmd > target") that appear in the first
hunk, i.e. this on top (I'll squash this in myself).

 t/t3200-branch.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 3203b15..74fbba1 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -8,10 +8,10 @@ test_description='git branch assorted tests'
 . ./test-lib.sh
 
 test_expect_success 'prepare a trivial repository' '
-	echo Hello > A &&
+	echo Hello >A &&
 	git update-index --add A &&
 	git commit -m "Initial commit." &&
-	echo World >> A &&
+	echo World >>A &&
 	git update-index --add A &&
 	git commit -m "Second commit." &&
 	HEAD=$(git rev-parse --verify HEAD)'
@@ -750,7 +750,7 @@ test_expect_success 'detect misconfigured autosetuprebase (bad value)' '
 
 test_expect_success 'detect misconfigured autosetuprebase (no value)' '
 	git config --unset branch.autosetuprebase &&
-	echo "[branch] autosetuprebase" >> .git/config &&
+	echo "[branch] autosetuprebase" >>.git/config &&
 	test_must_fail git branch &&
 	git config --unset branch.autosetuprebase
 '
