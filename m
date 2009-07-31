From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: [PATCHv2 2/2] Documentation: git-send-email: correct statement about standard ports
Date: Fri, 31 Jul 2009 11:45:00 -0600
Organization: icecavern.net
Message-ID: <200907311145.01759.wjl@icecavern.net>
References: <1248995334-28545-1-git-send-email-wjl@icecavern.net> <1248995334-28545-2-git-send-email-wjl@icecavern.net> <7vzlaku9d4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 19:45:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWwAd-0004EK-G9
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 19:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbZGaRpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 13:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbZGaRpO
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 13:45:14 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:36873 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751404AbZGaRpN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 13:45:13 -0400
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id A3E7635A36;
	Fri, 31 Jul 2009 19:45:10 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.29-2-amd64; KDE/4.2.2; x86_64; ; )
In-Reply-To: <7vzlaku9d4.fsf@alter.siamese.dyndns.org>
X-Face: #;qMWg=Msk*d]z]X1P2-t9]~6+RoGF$nJo89f%|Y`^whfl3Wj$X2Q_1u)ZAW@Hx|g)J]!)
 =?utf-8?q?=0A=09Br0=3FK3Imj?=)np=]r*QN,Q8].V99^Og'xl-d9FM~$yaSGB"mfXb>x[QNi[()
 =?utf-8?q?oob=60/4M42=26We=0A=09cC1jq=3DQ=5CS?=@ck\>H@
 =?utf-8?q?t=26Y7Y=3Apub=3DHOWqY=7D-d=5CwrCxvsTo7k1Ek=7DqQO=5D5=7EngK=5E=25?=
 =?utf-8?q?cT5IzmmG=5BQ=0A=09Nha=7D=5DAmI=60R-6m84VcWT4=236c?=)1`>t{$~l6:gZMtv18ge'!d[Yk-/?T3>C5O-|6On4(
 =?utf-8?q?N=7BAV=23=0A=094Eyw52=5B=3A=25Z?=>#"c
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124585>

On Friday 31 July 2009 10:04:39 Junio C Hamano wrote:
> As you noted, port 465 has been used as a well-known de-facto port to run
> SMTP over SSL at many places.  I do not think it would help anybody by
> clarifying that it is a "non-standard" port here.  This is not a place to
> educate people on which port they should run their SMTP servers.
>
> But I do not care deeply enough, and I can let it pass.
>
> I have much more trouble with that "like 465" than I have with "non
> standard".

If you don't like the phrasing, how about this revised patch? I call it a
"common SSL smtp port", and refer directly to 465. I think should make everyone
happy:

---

>From f0f6d41705f51f198c7cd87cbbf4ffdbe3fdf84e Mon Sep 17 00:00:00 2001
From: Wesley J. Landaker <wjl@icecavern.net>
Date: Thu, 30 Jul 2009 14:53:29 -0600
Subject: [PATCH 2/2] Documentation: git-send-email: correct statement about standard ports

The current documentation states that servers typically listen on port
465 and calls this "ssmtp". While it's true that many mail servers use
port 465 for SSL smtp, this is non-standard, and hails from the days
before smtp and submission TLS support, that arrived in RFC2487 and
RFC3207. Port 465 is actually assigned by IANA for unrelated purposes,
and is mostly still used by mail servers today only to support Outlook
Express.

In any case, this patch helps the documentation better reflect both
standards and reality, while still helpfully mentioning ports numbers
that a user may wish to specify.

Signed-off-by: Wesley J. Landaker <wjl@icecavern.net>
---
 Documentation/git-send-email.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 1c94351..767cf4d 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -142,8 +142,9 @@ user is prompted for a password while the input is masked for privacy.
 
 --smtp-server-port=<port>::
 	Specifies a port different from the default port (SMTP
-	servers typically listen to smtp port 25 and ssmtp port
-	465); symbolic port names (e.g. "submission" instead of 587)
+	servers typically listen to smtp port 25, but may also listen to
+	submission port 587, or the common SSL smtp port 465);
+	symbolic port names (e.g. "submission" instead of 587)
 	are also accepted. The port can also be set with the
 	'sendemail.smtpserverport' configuration variable.
 
-- 
1.6.3.1
