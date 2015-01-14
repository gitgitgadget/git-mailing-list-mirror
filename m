From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/10] prompt.c: remove git_getpass() nobody uses
Date: Wed, 14 Jan 2015 15:40:48 -0800
Message-ID: <1421278855-8126-4-git-send-email-gitster@pobox.com>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 00:41:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBXYn-0002cw-Po
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 00:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbbANXlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 18:41:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59489 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751364AbbANXlF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 18:41:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EA0D2DB89;
	Wed, 14 Jan 2015 18:41:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=LXdA
	7exmsAa6MCEMgOS+f3EX2lE=; b=VCjmdPzeFDAmD4EvE2YDKu4Anc6HfiZFzyhI
	CC39tbZqaXtKEAszLi0BIyV1f6YUjzsSwo3KUXmQ8sCL/DkjQ8UefCMcZX1CL3Kp
	TgNT2E90ZH+VZIpe5VfaBVcmkZ9GYy4JQy6wKjrZnMzPuARMgkPggbDiqvDEGNGO
	8a9Lx8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=F42tBC
	YvmbzDEjmPm4xzfIbk8SN0oKEbxtvtznJCWwg08SiwKAZg+/wTJNyAoXf6n1ozZW
	mii/tMn3mgnjm2oQ4qLTe9OLS2yxSeC355ME9l6qwWiOqa6dzH5lxmdfLx61VeMm
	t1wYddUkBYomBRVFbTqO4ClejoVMzY+ULmVGI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 950BA2DB88;
	Wed, 14 Jan 2015 18:41:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A8F32DB82;
	Wed, 14 Jan 2015 18:41:01 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc0-134-g109a908
In-Reply-To: <1421278855-8126-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CC40FE1C-9C46-11E4-93F9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262441>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 prompt.c | 5 -----
 prompt.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/prompt.c b/prompt.c
index 8181eeb..7540639 100644
--- a/prompt.c
+++ b/prompt.c
@@ -73,8 +73,3 @@ char *git_prompt(const char *prompt, int flags)
 	}
 	return r;
 }
-
-char *git_getpass(const char *prompt)
-{
-	return git_prompt(prompt, PROMPT_ASKPASS);
-}
diff --git a/prompt.h b/prompt.h
index 04f321a..e04cced 100644
--- a/prompt.h
+++ b/prompt.h
@@ -5,6 +5,5 @@
 #define PROMPT_ECHO    (1<<1)
 
 char *git_prompt(const char *prompt, int flags);
-char *git_getpass(const char *prompt);
 
 #endif /* PROMPT_H */
-- 
2.3.0-rc0-134-g109a908
