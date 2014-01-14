From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] Documentation: "git pull" does not have the "-m" option
Date: Tue, 14 Jan 2014 11:57:03 -0800
Message-ID: <xmqq7ga249b1.fsf@gitster.dls.corp.google.com>
References: <loom.20140114T025825-557@post.gmane.org>
	<xmqqvbxm4dyq.fsf@gitster.dls.corp.google.com>
	<52D5874D.7070102@web.de> <7v61pm1hfe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Zakharyaschev <imz@altlinux.org>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 14 21:07:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3AGW-0005cD-Pf
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 21:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbaANUHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 15:07:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52285 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbaANUHD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 15:07:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13795611C1;
	Tue, 14 Jan 2014 15:07:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=hnrj47WfZkOG4Ku/i9TGKKHU3Zs=; b=kSB1wLi3JAVFsW+LabTU
	mmQctLO5vAqw24QJ7KhKA79SdOXGkN04kkB11U3pHvOx9Y1LiIvaRNL8XwSRgaYA
	4hcSotW4VAJvNUMpSSL9rw2hxiPLtfmGpNtnxWUSWRhS7B3m25w18DUdx1fMNRiY
	vZqidIhfUB6UqpMWQunG/eI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=pDk2C2mWpZCTVLv40XAirzZM+c2YvMw49LaakDolavU0nL
	4hAwKvQaCGMVquAE2ltLLtqGxyOfObmvWmmkV1FtLXK4QvEPOoAblpni6ysV2/BT
	Q0hpDqIs/8Acspd3lzK1yUPPq806QjHMutOfTergMy+jb1r5kD7KnXPd8yEOE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAAE3611C0;
	Tue, 14 Jan 2014 15:07:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9CDD611BC;
	Tue, 14 Jan 2014 15:07:00 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6DCD12F8-7D57-11E3-A0AF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240412>

Even though "--[no-]edit" can be used with "git pull", the
explanation of the interaction between this option and the "-m"
option does not make sense within the context of "git pull".  Use
the conditional inclusion mechanism to remove this part from "git
pull" documentation, while keeping it for "git merge".

Reported-by: Ivan Zakharyaschev
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Merge the result of applying 1/2 on top of 409b8d8 to 66fa1b2,
   and then apply this.

 Documentation/merge-options.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index f192cd2..d462bcc 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -14,9 +14,12 @@ inspect and further tweak the merge result before committing.
 	further edit the auto-generated merge message, so that the user
 	can explain and justify the merge. The `--no-edit` option can be
 	used to accept the auto-generated message (this is generally
-	discouraged). The `--edit` (or `-e`) option is still useful if you are
-	giving a draft message with the `-m` option from the command line
-	and want to edit it in the editor.
+	discouraged).
+ifndef::git-pull[]
+The `--edit` (or `-e`) option is still useful if you are
+giving a draft message with the `-m` option from the command line
+and want to edit it in the editor.
+endif::git-pull[]
 +
 Older scripts may depend on the historical behaviour of not allowing the
 user to edit the merge log message. They will see an editor opened when
-- 
1.8.5.3-493-gb139ac2
