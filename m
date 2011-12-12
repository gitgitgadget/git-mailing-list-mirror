From: Jerome DE VIVIE <j.devivie@prometil.com>
Subject: Re: [PATCH] tag deletions not rejected with receive.denyDeletes=
 true
Date: Mon, 12 Dec 2011 15:06:06 +0100 (CET)
Message-ID: <12967682.2821323698766430.JavaMail.root@promailix.prometil.com>
References: <6271653.2751323698446271.JavaMail.root@promailix.prometil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 15:06:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra6WH-0006Mn-Sz
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 15:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681Ab1LLOGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Dec 2011 09:06:13 -0500
Received: from promailix.prometil.com ([87.98.147.193]:51143 "EHLO
	promailix.prometil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab1LLOGM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2011 09:06:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by promailix.prometil.com (Postfix) with ESMTP id 3F7551BC500;
	Mon, 12 Dec 2011 15:06:11 +0100 (CET)
Received: from promailix.prometil.com ([127.0.0.1])
	by localhost (promailix.prometil.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fl1htMchoByv; Mon, 12 Dec 2011 15:06:06 +0100 (CET)
Received: from promailix.prometil.com (mail.prometil.com [87.98.147.193])
	by promailix.prometil.com (Postfix) with ESMTP id 7DFA81BC3AE;
	Mon, 12 Dec 2011 15:06:06 +0100 (CET)
In-Reply-To: <6271653.2751323698446271.JavaMail.root@promailix.prometil.com>
X-Originating-IP: [193.57.220.1]
X-Mailer: Zimbra 5.0.18_GA_3011.UBUNTU8 (ZimbraWebClient - FF3.0 (Win)/5.0.18_GA_3011.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186910>


Junio C Hamano <gitster@pobox.com> writes :
> Our documentation can also use some updates, as it dates to the days =
back
> when we more liberally used "refs" and "branches" interchangeably.

Ok, I have turned the patch below for documentation.

=46or protecting tags, I can do it with triggers but its painful with l=
ots of repositories. I propose to extend receive.denyDeletes with these=
 values:
- "false"/"none" (existing behavior)
- "true"/"branches" (existing behavior)
- "tags": protect tags only
- "all": protect both tags and branches

Your opinion ?

BR
J=C3=A9r=C3=B4me


Signed-off-by: Jerome de Vivie <jedevivie-ext@airfrance.fr>
---
 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5a841da..9c7c7fe 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1642,7 +1642,7 @@ receive.unpackLimit::
=20
 receive.denyDeletes::
 	If set to true, git-receive-pack will deny a ref update that deletes
-	the ref. Use this to prevent such a ref deletion via a push.
+	a branch. Use this to prevent such a branch deletion via a push.
=20
 receive.denyDeleteCurrent::
 	If set to true, git-receive-pack will deny a ref update that
--=20
1.7.6.msysgit.0
