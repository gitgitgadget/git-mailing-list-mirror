From: Han Boetes <han@mijncomputer.nl>
Subject: git on OpenBSD
Date: Sat, 1 Oct 2005 08:23:26 +0200
Message-ID: <20051001062348.GA7903@boetes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 01 08:24:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELan7-0003Xh-4v
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 08:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVJAGXu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 02:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVJAGXu
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 02:23:50 -0400
Received: from cc15467-a.groni1.gr.home.nl ([82.73.147.65]:43538 "HELO
	boetes.org") by vger.kernel.org with SMTP id S1750740AbVJAGXt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2005 02:23:49 -0400
Received: (qmail 30984 invoked by uid 1000); 1 Oct 2005 06:23:49 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9586>

Hi,

I just managed to get git compile on OpenBSD,

I modified the Makefile a bit to make it work. I suppose these
modifications will make it work on Free- and NetBSD as well, but
I haven't tested it so I'm not sure.

iconv is installed in /usr/local that's why I had to add it to the
searchpath.


diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -162,6 +162,10 @@ ifeq ($(shell uname -s),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
 endif
+ifeq ($(shell uname -s),OpenBSD)
+	NEEDS_LIBICONV = YesPlease
+	PLATFORM_DEFINES += -I/usr/local/include -L/usr/local/lib
+endif
 ifeq ($(shell uname -s),SunOS)
 	NEEDS_SOCKET = YesPlease
 	NEEDS_NSL = YesPlease




# Han
-- 
Lbh unir whfg ivbyngrq gur Qvtvgny Zvyyraavhz Pbclevtug Npg  ol  oernxvat  gur
cebgrpgvba bs pbclevtugrq zngrevny. Vs lbh ner abg n pvgvmra  be  erfvqrag  bs
gur HFN, lbh evfx orvat vzcevfbarq naq uryq jvgubhg onvy sbe hc gb  gjb  jrrxf
hcba ragel gb gur HFN (c) Copyright 2001 by Hartmann Schaffer (signature only)
