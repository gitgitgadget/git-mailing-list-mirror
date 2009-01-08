From: Andre Przywara <andre.przywara@amd.com>
Subject: [PATCH] allow 8bit data in email body sent by send-email
Date: Thu, 8 Jan 2009 14:50:57 +0100
Message-ID: <1231422657-15305-1-git-send-email-andre.przywara@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andre Przywara <andre.przywara@amd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 14:51:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKvI4-0005OB-Ku
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 14:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256AbZAHNtm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jan 2009 08:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756206AbZAHNtm
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 08:49:42 -0500
Received: from outbound-va3.frontbridge.com ([216.32.180.16]:27164 "EHLO
	VA3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439AbZAHNtl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2009 08:49:41 -0500
Received: from mail211-va3-R.bigfish.com (10.7.14.237) by
 VA3EHSOBE006.bigfish.com (10.7.40.26) with Microsoft SMTP Server id
 8.1.240.5; Thu, 8 Jan 2009 13:49:40 +0000
Received: from mail211-va3 (localhost.localdomain [127.0.0.1])	by
 mail211-va3-R.bigfish.com (Postfix) with ESMTP id ABC6714C8282	for
 <git@vger.kernel.org>; Thu,  8 Jan 2009 13:49:40 +0000 (UTC)
X-BigFish: VPS-26(zzaf6W936eQ3117Kzzzzz32i66h)
X-Spam-TCS-SCL: 5:0
X-FB-SS: 5,
Received: by mail211-va3 (MessageSwitch) id 1231422579262696_1405; Thu,  8 Jan
 2009 13:49:39 +0000 (UCT)
Received: from ausb3extmailp02.amd.com (ausb3extmailp02.amd.com
 [163.181.251.22])	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)	by mail211-va3.bigfish.com (Postfix) with
 ESMTP id 2872E13B005A	for <git@vger.kernel.org>; Thu,  8 Jan 2009 13:49:39
 +0000 (UTC)
Received: from ausb3twp01.amd.com (ausb3twp01.amd.com [163.181.250.37])	by
 ausb3extmailp02.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id
 n08DnZ2m000857	for <git@vger.kernel.org>; Thu, 8 Jan 2009 07:49:38 -0600
X-WSS-ID: 0KD5NQG-01-GO4-01
Received: from sausexbh2.amd.com (SAUSEXBH2.amd.com [163.181.22.102])	by
 ausb3twp01.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id 2CC31194422	for
 <git@vger.kernel.org>; Thu,  8 Jan 2009 07:49:27 -0600 (CST)
Received: from SAUSEXMB3.amd.com ([163.181.22.202]) by sausexbh2.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Thu, 8 Jan 2009 07:49:33 -0600
Received: from SDRSEXMB1.amd.com ([172.20.3.116]) by SAUSEXMB3.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Thu, 8 Jan 2009 07:49:33 -0600
Received: from localhost.localdomain ([165.204.85.38]) by SDRSEXMB1.amd.com
 with Microsoft SMTPSVC(6.0.3790.3959);	 Thu, 8 Jan 2009 14:49:31 +0100
X-Mailer: git-send-email 1.5.5
X-OriginalArrivalTime: 08 Jan 2009 13:49:31.0213 (UTC) FILETIME=[EE7FE7D0:01C97197]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104920>

Hi,
when sending patch files via git send-email, the perl script assumes
7bit characters only. If there are other bytes in the body (foreign lan=
guage
characters in names or translations), some servers (like vger.kernel.or=
g)
reject the mail because of th=E4t. This patch always adds an 8bit heade=
r line
to each mail.
If someone thinks this has any side-effects, tell me, I am open to sugg=
estions.

Regards,
Andr=E9.

Signed-off-by: Andre Przywara <andre.przywara@amd.com>

Andre Przywara
AMD-Operating System Research Center (OSRC), Dresden, Germany
Tel: +49 351 277-84917
****to satisfy European Law for business letters:
Advanced Micro Devices GmbH
Karl-Hammerschmidt-Str. 34, 85609 Dornach b. Muenchen
Geschaeftsfuehrer: Jochen Polster; Thomas M. McCoy; Giuliano Meroni
Sitz: Dornach, Gemeinde Aschheim, Landkreis Muenchen
Registergericht Muenchen, HRB Nr. 43632

---
 git-send-email.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 77ca8fe..68a462c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -793,6 +793,7 @@ To: $to${ccline}
 Subject: $subject
 Date: $date
 Message-Id: $message_id
+Content-Transfer-Encoding: 8bit
 X-Mailer: git-send-email $gitversion
 ";
 	if ($thread && $reply_to) {
--=20
1.5.5
