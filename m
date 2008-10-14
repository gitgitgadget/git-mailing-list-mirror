From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Add Linux PPC support to the pre-auto-gc example hook
Date: Tue, 14 Oct 2008 16:42:45 +0200
Message-ID: <20081014144245.GX536@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 16:45:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpl7x-0005a8-OD
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 16:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbYJNOmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 10:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbYJNOmu
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 10:42:50 -0400
Received: from virgo.iok.hu ([193.202.89.103]:37177 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbYJNOmt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 10:42:49 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C9F0D5808D;
	Tue, 14 Oct 2008 16:42:47 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id ACC134465E;
	Tue, 14 Oct 2008 16:42:45 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 6B65311901A1; Tue, 14 Oct 2008 16:42:45 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98188>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 contrib/hooks/pre-auto-gc-battery |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto-gc-battery
index b0a8caa..1f914c9 100644
--- a/contrib/hooks/pre-auto-gc-battery
+++ b/contrib/hooks/pre-auto-gc-battery
@@ -30,6 +30,9 @@ then
 elif grep -q '0x01$' /proc/apm 2>/dev/null
 then
 	exit 0
+elif grep -q "AC Power \+: 1" /proc/pmu/info 2>/dev/null
+then
+	exit 0
 elif test -x /usr/bin/pmset && /usr/bin/pmset -g batt |
 	grep -q "Currently drawing from 'AC Power'"
 then
-- 
1.6.0.2
