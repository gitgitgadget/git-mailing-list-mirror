From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6] t4010: correct expected object names
Date: Sun, 15 Feb 2015 15:43:41 -0800
Message-ID: <1424043824-25242-4-git-send-email-gitster@pobox.com>
References: <1424043824-25242-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 00:44:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YN8r3-0006FA-Ph
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 00:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbbBOXnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2015 18:43:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56264 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751797AbbBOXnv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2015 18:43:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE1B539CEB;
	Sun, 15 Feb 2015 18:43:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=vYT9
	I/BktuKJ567hR4AaZ8VAjpw=; b=wbDdLpQNViCLB+CgUd+VeVRLc2w1QthqWhZq
	Vu2rVT/k4fEMt+2ud3EKCMXm4c9ZOO1mCcO9N9+beJiLPjW/Su98IkceZ9KxxN3g
	dOBK9zdPRJ228JjlawquWctqX406YaKo6Q0KywPu8/XBnBVyiYIsDg1TPqfGKrtY
	ABx9Rrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=a6aKYo
	Ukm/5lBGpiPcxuSMXKcsMghmqRsYW8uUZRt2iD7by/JP5IaUz0qxlbj8pFXWCscw
	qsja8XaJgNaV4CWs3VRiUd2dlWK0tS0cmdaPv/3m8Kv0cdl5WTcRiDMbdZbMAgRM
	Ypqn53XVsgGM/sbobHBetJ8C+p7wLiuGK8Bmk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D4E8739CEA;
	Sun, 15 Feb 2015 18:43:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B78439CE9;
	Sun, 15 Feb 2015 18:43:50 -0500 (EST)
X-Mailer: git-send-email 2.3.0-266-g5b48884
In-Reply-To: <1424043824-25242-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7E0CE172-B56C-11E4-8C0E-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263858>

The output the test expects is bogus.

It was left unnoticed only because compare_diff_raw, which only
cares about the add/delete/rename/copy was used to check the result.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4010-diff-pathspec.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 589bc6b..6219a2e 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -56,7 +56,7 @@ test_expect_success \
      compare_diff_raw current expected'
 
 cat >expected <<\EOF
-:100644 100644 766498d93a4b06057a8e49d23f4068f1170ff38f 0a41e115ab61be0328a19b29f18cdcb49338d516 M	file0
+:100644 100644 8e4020bb5a8d8c873b25de15933e75cc0fc275df dca6b92303befc93086aa025d90a5facd7eb2812 M	file0
 EOF
 test_expect_success \
     'limit to file0 should show file0' \
-- 
2.3.0-266-g5b48884
