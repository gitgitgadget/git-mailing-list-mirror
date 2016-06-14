From: Heiko Becker <heirecka@exherbo.org>
Subject: [PATCH] gnome-keyring: Don't hard-code pkg-config executable
Date: Tue, 14 Jun 2016 13:27:05 +0200
Message-ID: <20160614112705.7162-1-heirecka@exherbo.org>
Cc: drafnel@gmail.com, Heiko Becker <heirecka@exherbo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 13:35:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCmd8-0002VL-7C
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 13:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbcFNLfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 07:35:25 -0400
Received: from j61898.servers.jiffybox.net ([185.21.103.105]:44672 "EHLO
	heiko-becker.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbcFNLfX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 07:35:23 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jun 2016 07:35:22 EDT
Received: from stiller.fritz.box (p4FDB7256.dip0.t-ipconnect.de [79.219.114.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by heiko-becker.de (Postfix) with ESMTPSA id 74A101D7CD3;
	Tue, 14 Jun 2016 13:27:18 +0200 (CEST)
X-Mailer: git-send-email 2.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297290>

Helpful if your pkg-config executable has a prefix based on the
architecture, for example.

Signed-off-by: Heiko Becker <heirecka@exherbo.org>
---
 contrib/credential/gnome-keyring/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/credential/gnome-keyring/Makefile b/contrib/credential/gnome-keyring/Makefile
index c3c7c98..22c19df 100644
--- a/contrib/credential/gnome-keyring/Makefile
+++ b/contrib/credential/gnome-keyring/Makefile
@@ -4,12 +4,13 @@ all:: $(MAIN)
 CC = gcc
 RM = rm -f
 CFLAGS = -g -O2 -Wall
+PKG_CONFIG = pkg-config
 
 -include ../../../config.mak.autogen
 -include ../../../config.mak
 
-INCS:=$(shell pkg-config --cflags gnome-keyring-1 glib-2.0)
-LIBS:=$(shell pkg-config --libs gnome-keyring-1 glib-2.0)
+INCS:=$(shell $(PKG_CONFIG) --cflags gnome-keyring-1 glib-2.0)
+LIBS:=$(shell $(PKG_CONFIG) --libs gnome-keyring-1 glib-2.0)
 
 SRCS:=$(MAIN).c
 OBJS:=$(SRCS:.c=.o)
-- 
2.9.0
