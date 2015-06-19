From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 15/19] fsck: Document the new receive.fsck.<msg-id> options
Date: Fri, 19 Jun 2015 15:35:05 +0200
Organization: gmx
Message-ID: <e6abae4f1ccd972946b788a7a76406ac9134856f.1434720655.git.johannes.schindelin@gmx.de>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 19 15:36:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wTF-00024I-Mz
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 15:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699AbbFSNfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 09:35:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:52007 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398AbbFSNfK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 09:35:10 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MDi9C-1ZKnlX2euU-00H67E; Fri, 19 Jun 2015 15:35:05
 +0200
In-Reply-To: <cover.1434720655.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:PCOwjio0BIitylEceNvVlb4nbSk5vs0Kz3rjpU9jo9obuoC03Nm
 x50aJXcW5w1ePg19MmG7PsdgsxyNXWqpTEeMGuCJEffMcJZiIKBqDDQhQYf1NZwuiolTEMz
 YHYWDqAvA9sMLWQqv46vA/eiiqnUEhraiU17rd2TrL1VdgED9NEsIhTrd67iraMzZWNPz94
 LuL5EiQRr4mP+/F7py/Yw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hz2F8OQdPEY=:GyXdPSgWsoi5vMCp+idXje
 BPED/rNwv31gvCfBcAkn+Z7ZlnsCpqrj8qZYkNoTkQ45QFiXKz9turUEzG5Nf3/2V/TzrWkjf
 o3IydTo7/o9sh1hb4BqzWf+iSfMlD8vOwTaCMMKNQfXm+CP+asoVBYfEqzhAOgQjl6ytnG/XI
 uZFPaeEDtTgMfkApET6AZI4zvq/OaXCyC3izosnFxymlWanTHAz3qC6yldrgloCsz6wwWbP0E
 kRhGlonjvk3Ae8+flHi51FLFAoZoFp3eaCPXEduwXQ5P+i6fU7H94HnQeoYmi0LBimKHTjIq4
 kYcAb2m4Dl2a9FS5qgwHFJnKEIB0y93BqIofKYNPFFKV9Qpydzanl6hH3Sj5fASFBg0TAgz8Z
 CWlmdWMrc8153QlorN84tZP8VfO3CP0oENaZ3CIO5zebOTb2P+JOMlp9K7uRg/XMeg83GCsxP
 hgiHbGIIkxzO2OycoqMzLYYYQdMJcDnM56D48qcQR6ZByKASJQ0GsU2sngEZZeuMSQi6+Vj2q
 HWRXIAmaIm/QU+Xkkt4Cq7puQbgPKRxJlKtSyK+6wTrDjOqg/pWNau/4vRwE1HlaVPiUdz32X
 M1Dvslh7V9u7U4SevFaSmQ7OggqiM8tisbILVB3pkGJPC8NdZN1PwrPC0SjNb/B7w/m7Z1ruw
 h9rN7k4Qr7OAhE7v6zwmkTynqNZNllfge1Q+2X6La4m6AVeO1IMZJRA19Ds3TOBa6xUI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272150>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3e37b93..306ab7a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2205,6 +2205,20 @@ receive.fsckObjects::
 	Defaults to false. If not set, the value of `transfer.fsckObjects`
 	is used instead.
 
+receive.fsck.<msg-id>::
+	When `receive.fsckObjects` is set to true, errors can be switched
+	to warnings and vice versa by configuring the `receive.fsck.<msg-id>`
+	setting where the `<msg-id>` is the fsck message ID and the value
+	is one of `error`, `warn` or `ignore`. For convenience, fsck prefixes
+	the error/warning with the message ID, e.g. "missingemail: invalid
+	author/committer line - missing email" means that setting
+	`receive.fsck.missingemail = ignore` will hide that issue.
++
+This feature is intended to support working with legacy repositories
+which would not pass pushing when `receive.fsckObjects = true`, allowing
+the host to accept repositories with certain known issues but still catch
+other issues.
+
 receive.unpackLimit::
 	If the number of objects received in a push is below this
 	limit then the objects will be unpacked into loose object
-- 
2.3.1.windows.1.9.g8c01ab4
