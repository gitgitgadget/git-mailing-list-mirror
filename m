From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/10] t5404: do not assume the "matching" push is the
 default
Date: Fri,  4 Jan 2013 22:52:59 -0800
Message-ID: <1357368788-28035-2-git-send-email-gitster@pobox.com>
References: <1357368788-28035-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 07:53:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrNdV-0000vb-Mo
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 07:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865Ab3AEGxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 01:53:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56340 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799Ab3AEGxM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 01:53:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CA0B8CCB
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=T56I
	HX/7eOYyDlCQQr+ly2os7mw=; b=mmefb2isWIP+4bkyamUDq90JCRlMpqfbt9DP
	1/r8xTQZeOLf3Wr49PX3xbA+ZGOL4eYAPGx765sxCiPK0ZpkCIfIns8A3S9Z34Rb
	So+utmLFA/KSpxwnno9z/a6wu/yEAiPRguhhT5QSUJq+iaNXRgf9eJJ+dFSy3IQC
	IU3NbPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=NsntT/
	GsMnVOgEFJabKlPpOGHei3ikAD1Ua72hk1P2/En82hH1q/CA7dhQbcNLoSYd5S8o
	B1fk06/iqXYvfoKsVZ/CwRP09s4/p8bszunjjjg8NB/fdMW/FgsWoMJgP350DHhx
	oF7ofiHn4z2i5cYSw4mQJP/m02d6fL5k3ti3g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FA928CCA
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F25F8CC9 for
 <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:11 -0500 (EST)
X-Mailer: git-send-email 1.8.1.299.gc73b41f
In-Reply-To: <1357368788-28035-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 924F2CDA-5704-11E2-A523-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212667>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5404-tracking-branches.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
index c240035..2b8c0ba 100755
--- a/t/t5404-tracking-branches.sh
+++ b/t/t5404-tracking-branches.sh
@@ -36,7 +36,7 @@ test_expect_success 'prepare pushable branches' '
 '
 
 test_expect_success 'mixed-success push returns error' '
-	test_must_fail git push
+	test_must_fail git push origin :
 '
 
 test_expect_success 'check tracking branches updated correctly after push' '
-- 
1.8.1.299.gc73b41f
