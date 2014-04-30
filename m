From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/8] CodingGuidelines: give an example for redirection
Date: Wed, 30 Apr 2014 14:45:07 -0700
Message-ID: <1398894312-30763-4-git-send-email-gitster@pobox.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 23:45:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfcJw-0004xn-Q9
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 23:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759475AbaD3Vpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 17:45:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759042AbaD3Vpb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 17:45:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6146B825F1;
	Wed, 30 Apr 2014 17:45:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3udk
	woFie/roBel2I/DR6Fec/D8=; b=JbbldAncHfQm8b30TEr6c/R87JfKknB4aVJV
	7spa1U2lM1VuTh/KHAknTsVgJ1pwEEkloYdK0WYwDhT24Qw1f082p3S6jzqjc2up
	8VZEhYyfuLilLFXmijI/q+mNDqQAZZlFNT8xkul6ox5i4wzHI2eI+V9GvSy+uGHP
	r4n2dcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=sMn/Bf
	VlneqLao/qXB04jEVqrqtEl+hHQGIwkMbvp45PoION/o7/lNQvrPFAA9AdmQ3spj
	VI2lCwTluKvcVu5hPYK+M/CnPlKJZKHIkSV4pkyqBlaru/xsXAEGTHxth4Bq7Fkk
	3CaGDxEFx07Ljp4qEfo4Jx0UCd59IRcNe4H2s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CBD3825E9;
	Wed, 30 Apr 2014 17:45:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C43E2825E5;
	Wed, 30 Apr 2014 17:45:27 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-rc1-355-gd6d6511
In-Reply-To: <1398894312-30763-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BE63C76E-D0B0-11E3-B148-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247788>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 9b103cb..1e0c4cf 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -53,6 +53,12 @@ For shell scripts specifically (not exhaustive):
    redirection target in a variable (as shown above), our code does so
    because some versions of bash issue a warning without the quotes.
 
+	cat hello > world < universe	# incorrect
+	cat hello >world <universe	# correct
+
+	echo hello >$world		# incorrect
+	echo hello >"$world"		# correct
+
  - We prefer $( ... ) for command substitution; unlike ``, it
    properly nests.  It should have been the way Bourne spelled
    it from day one, but unfortunately isn't.
-- 
2.0.0-rc1-355-gd6d6511
