From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: notice: pu broken tonight
Date: Tue, 09 Jun 2009 19:11:05 +0200
Message-ID: <4A2E97A9.7040906@lsrfire.ath.cx>
References: <7vy6s1pzwb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 19:11:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME4rH-0007xL-7l
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 19:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbZFIRLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 13:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbZFIRLW
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 13:11:22 -0400
Received: from india601.server4you.de ([85.25.151.105]:56156 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbZFIRLV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 13:11:21 -0400
Received: from [10.0.1.101] (p57B7F69F.dip.t-dialin.net [87.183.246.159])
	by india601.server4you.de (Postfix) with ESMTPSA id AA7812F8055;
	Tue,  9 Jun 2009 19:11:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vy6s1pzwb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121190>

Junio C Hamano schrieb:
> I usually make sure all four branches pass the tests before pushing them
> out, but in tonight's integration, the tip of 'pu' does not pass test for
> me, hence this notice.

The following patch makes the tests pass again for me.  Feel free to squash
it into 10c29915.


 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 2d36f78..25029a9 100644
--- a/Makefile
+++ b/Makefile
@@ -921,7 +921,7 @@ SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
 BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $(SANE_TOOL_PATH_SQ)|'
 PATH := $(SANE_TOOL_PATH):${PATH}
 else
-BROKEN_PATH_FIX = d
+BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
 endif
 
 ifeq ($(uname_S),Darwin)
