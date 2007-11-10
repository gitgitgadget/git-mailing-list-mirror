From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] git-hash-object should honor config variables
Date: Sat, 10 Nov 2007 15:00:33 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711101458020.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 21:01:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqwW9-0002hm-35
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 21:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbXKJUBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 15:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753843AbXKJUBE
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 15:01:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25483 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822AbXKJUBD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 15:01:03 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRB001IG3KZA1A0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 10 Nov 2007 15:00:36 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64374>

... such as core.compression.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/hash-object.c b/hash-object.c
index 18f5017..0a58f3f 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -42,6 +42,8 @@ int main(int argc, char **argv)
 	int prefix_length = -1;
 	int no_more_flags = 0;
 
+	git_config(git_default_config);
+
 	for (i = 1 ; i < argc; i++) {
 		if (!no_more_flags && argv[i][0] == '-') {
 			if (!strcmp(argv[i], "-t")) {
