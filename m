From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/7] send-pack: typofix error message
Date: Thu,  8 Sep 2011 13:01:36 -0700
Message-ID: <1315512102-19022-2-git-send-email-gitster@pobox.com>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 00:56:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nWc-0004sj-IN
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 00:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749Ab1IHW4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 18:56:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38545 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab1IHW4m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 18:56:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B7274632
	for <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=lMzN
	3VhjzrHwJm7wczFJWeRmTwQ=; b=NGhwqTP5osjybgIkIL3+VQKn82Rf48WspAl4
	Pjuq1dvsnza/U6BkemD4sFe5kbfwgeFXNmy0+CML3MWQPc6WoZzyjLMTb5L2QG+X
	cj8lBlAiTIGIj2fvrXx9QAZ8BFbnfCBi2lS4Da77cLYZam7V6wcxQILTQUJVgMwW
	fVh2Pq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=By1vEy
	8oMZnol+J2vcc52G20kPycIg26LdgNttdTMeqlIkriC8+CYRvAP/6r/l6OWUc1Nq
	FengPxDxrsoJE5HS5NgU3HPl0kakXoLvSIXnQp0hf2LJ5iqkqlVLEjBA3rvNDvyg
	4bTGTixvs4v3TFE39YSiXizeGrrPlVqIL1eCc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2418E4631
	for <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1EA04630 for
 <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.188.g3793ac
In-Reply-To: <1315512102-19022-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 611B6E26-DA55-11E0-920D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180979>

The message identifies the process as receive-pack when it cannot fork the
sideband demultiplexer. We are actually a send-pack.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/send-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index c1f6ddd..87833f4 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -334,7 +334,7 @@ int send_pack(struct send_pack_args *args,
 		demux.data = fd;
 		demux.out = -1;
 		if (start_async(&demux))
-			die("receive-pack: unable to fork off sideband demultiplexer");
+			die("send-pack: unable to fork off sideband demultiplexer");
 		in = demux.out;
 	}
 
-- 
1.7.7.rc0.188.g3793ac
