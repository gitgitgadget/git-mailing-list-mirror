From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/4] send-pack: typofix error message
Date: Fri,  9 Sep 2011 13:41:41 -0700
Message-ID: <1315600904-17032-2-git-send-email-gitster@pobox.com>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
 <1315600904-17032-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 22:41:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R27td-0002zX-Hw
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 22:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933651Ab1IIUlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 16:41:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933350Ab1IIUls (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 16:41:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4861B5E57
	for <git@vger.kernel.org>; Fri,  9 Sep 2011 16:41:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=lMzN
	3VhjzrHwJm7wczFJWeRmTwQ=; b=KvPdL1ru0JlEJug+eyrDMCX5hUuwCU7UgtWS
	aR3XKW2Oia09wwhwEmDpQ0LPYcdDazjhJdRdd7nKeLovLzd4qmxoJPGGw7umZRcq
	mfmB+ZS9KwqdlOF/+M330ofKxz7FM0HHQH4jtbWAQlMM250mV6sqPOa0GAyyivYW
	XTMZfy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=amfY4z
	maxRW/penTR/UCk8axX6DAh0a8Pa3SLli4mt3s5emBRI4Rwuo+jSjQkyP9oPKsS7
	7EQMYF5F2FDX5BdjdFNq5/pTsMOlVq8wegmCkMYuQxOCG1/BK4S1Xo+hLKptrUAS
	KekBSFIXAfmfMGFzx4K1f6qCXx6+VhHR91feg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F8215E56
	for <git@vger.kernel.org>; Fri,  9 Sep 2011 16:41:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C827A5E55 for
 <git@vger.kernel.org>; Fri,  9 Sep 2011 16:41:47 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.188.g3793ac
In-Reply-To: <1315600904-17032-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 23473E66-DB24-11E0-AC10-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181118>

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
