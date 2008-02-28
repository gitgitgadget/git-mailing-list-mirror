From: Jean-Luc Herren <jlh@gmx.ch>
Subject: [PATCH] fast-import: exit with proper message if not a git dir
Date: Thu, 28 Feb 2008 23:29:54 +0100
Message-ID: <47C735E2.2010500@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 23:30:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUrGs-0000Sp-Il
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 23:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbYB1W35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 17:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbYB1W35
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 17:29:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:43748 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752040AbYB1W34 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 17:29:56 -0500
Received: (qmail invoked by alias); 28 Feb 2008 22:29:54 -0000
Received: from 176-44.78-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.78.44.176]
  by mail.gmx.net (mp055) with SMTP; 28 Feb 2008 23:29:54 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1/J/Y8QqTjJAfV2KoZjSR9H6xsw/4OcZxHEq5Tdj/
	NwyS4/A5XCSvTJ
User-Agent: Thunderbird 2.0.0.9 (X11/20071118)
X-Enigmail-Version: 0.95.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75470>

git fast-import expects to be run from an existing (possibly
empty) repository.  It was dying with a suboptimal message if that
wasn't the case.

Signed-off-by: Jean-Luc Herren <jlh@gmx.ch>
---
 fast-import.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 0d3449f..7f197d5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2377,6 +2377,7 @@ int main(int argc, const char **argv)
 {
 	unsigned int i, show_stats = 1;
 
+	setup_git_directory();
 	git_config(git_pack_config);
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
-- 
1.5.4.2
