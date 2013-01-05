From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/10] t5505: do not assume the "matching" push is the
 default
Date: Fri,  4 Jan 2013 22:53:00 -0800
Message-ID: <1357368788-28035-3-git-send-email-gitster@pobox.com>
References: <1357368788-28035-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 07:53:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrNdW-0000vb-6l
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 07:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947Ab3AEGxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 01:53:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56369 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863Ab3AEGxO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 01:53:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D8B28CCF
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hep8
	i84QoaTHYoYuHN9obSXRjf4=; b=pOAkIuEqvNPvohTDOS0CnwjG+0fwaQq6slgT
	bBsa93LbEbW5dG7HeqknodX6YR6pentnSox1darhstUusjcEUg4iUx8KZOBSO9Og
	cvJOPZIEzx2L96UjqbFzmata/ghBl1rtee7HYNSz0W55SYhu62eRaL7B3kGBF6V7
	ASX/Sjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=YTs4tQ
	N9CiAlL2uBK9wL98otAg4q1LilNbRVyxB5eVt8vdpZwmq2UKPpuf/sE5+BNnogSh
	HGp4ibmdsBgDWL2kRxfl2w0k6jw+B8gDaeUi0MchCv1/fcuiczsHSVfWoQWNeekZ
	5vNlnoQbvz/ChHUPYYWNVVGXD+vJN48H94dMs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FFCC8CCE
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5BAD8CCC for
 <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:13 -0500 (EST)
X-Mailer: git-send-email 1.8.1.299.gc73b41f
In-Reply-To: <1357368788-28035-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 936DD1B6-5704-11E2-878E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212670>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5505-remote.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index ccc55eb..6579a86 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -345,7 +345,7 @@ test_expect_success 'fetch mirrors do not act as mirrors during push' '
 	) &&
 	(cd mirror-fetch/child &&
 	 git branch -m renamed renamed2 &&
-	 git push parent
+	 git push parent :
 	) &&
 	(cd mirror-fetch/parent &&
 	 git rev-parse --verify renamed &&
-- 
1.8.1.299.gc73b41f
