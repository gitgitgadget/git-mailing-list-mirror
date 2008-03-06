From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] unquote_c_style: fix off-by-one.
Date: Thu, 06 Mar 2008 22:28:19 +0100
Message-ID: <20080306212819.GA10873@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 22:30:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXNew-0003uk-Jx
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 22:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760164AbYCFV2W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 16:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760226AbYCFV2V
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 16:28:21 -0500
Received: from pan.madism.org ([88.191.52.104]:47051 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759681AbYCFV2V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 16:28:21 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 075993147B
	for <git@vger.kernel.org>; Thu,  6 Mar 2008 22:28:19 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 15AE54DA748; Thu,  6 Mar 2008 22:28:19 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76424>

Thanks to Adeodato Sim=C3=B2 for having caught this.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 quote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/quote.c b/quote.c
index d061626..40702f6 100644
--- a/quote.c
+++ b/quote.c
@@ -288,7 +288,7 @@ int unquote_c_style(struct strbuf *sb, const char *=
quoted, const char **endp)
 		switch (*quoted++) {
 		  case '"':
 			if (endp)
-				*endp =3D quoted + 1;
+				*endp =3D quoted;
 			return 0;
 		  case '\\':
 			break;
--=20
1.5.4.3.593.g07854
