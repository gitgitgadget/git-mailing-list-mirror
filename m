From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] api-credential.txt: document that helpers field is filled-in automatically
Date: Mon, 11 Jun 2012 19:51:47 +0200
Message-ID: <1339437107-25909-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7vzk897rqi.fsf@alter.siamese.dyndns.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 11 19:52:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se8mm-0002NI-Ds
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 19:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437Ab2FKRwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 13:52:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34650 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905Ab2FKRwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 13:52:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5BHgii0019763
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 19:42:44 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Se8mL-0002Vn-1T; Mon, 11 Jun 2012 19:51:49 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Se8mK-0006ka-SE; Mon, 11 Jun 2012 19:51:48 +0200
X-Mailer: git-send-email 1.7.11.rc0.57.g84a04c7
In-Reply-To: <7vzk897rqi.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Jun 2012 19:42:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BHgii0019763
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1340041368.41002@z7tzheTDsh3GiQoBEr/IBg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199684>

It was unclear whether the field was to be specified by the user of the
API.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> It is correct that the C API asks helpers that the user configured,
> but I think it is common across three API functions, not limited to
> credential_fill().  credential_apply_config() is called from approve
> and reject, too.

Ah, right, so compared to v1, we can move the sentence to the
description of the "helpers" field, like this:

 Documentation/technical/api-credentials.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 21ca6a2..48f51ed 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -21,7 +21,9 @@ Data Structures
 The `helpers` member of the struct is a `string_list` of helpers.  Each
 string specifies an external helper which will be run, in order, to
 either acquire or store credentials. See the section on credential
-helpers below.
+helpers below. This list is filled-in by the API functions
+according to the corresponding configuration variables before
+consulting helpers.
 +
 This struct should always be initialized with `CREDENTIAL_INIT` or
 `credential_init`.
-- 
1.7.11.rc0.57.g84a04c7
