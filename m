From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Move couple of ifdefs after "include config.mk"
Date: Thu, 01 Dec 2005 02:16:56 -0800
Message-ID: <7v7japjf53.fsf@assigned-by-dhcp.cox.net>
References: <20051201012333.44bd81f2.tihirvon@gmail.com>
	<Pine.LNX.4.63.0512010144050.11941@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051201033201.02b47071.tihirvon@gmail.com>
	<7vhd9tmw1g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512010906400.22709@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjlkx2f.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0512010140m1b96db84x70c7d92f8f644a2a@mail.gmail.com>
	<7viru9jgku.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0512010153t3f768a82m8f9a12effa4a715e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 11:18:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhlVY-0008EW-KO
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 11:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVLAKRA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 05:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVLAKQ7
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 05:16:59 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:47801 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932119AbVLAKQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 05:16:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201101659.LTKQ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 05:16:59 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0512010153t3f768a82m8f9a12effa4a715e@mail.gmail.com>
	(Alex Riesen's message of "Thu, 1 Dec 2005 10:53:09 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13049>

Alex Riesen <raa.lkml@gmail.com> writes:

> On 12/1/05, Junio C Hamano <junkio@cox.net> wrote:
>> > I have even my specific targets in the config.mak (and would actually
>> > like to have the default target put before including config.mak, so
>> > default call to make is always the same).

Hmph.  Do you mean something like this?

-- >8 --
diff --git a/Makefile b/Makefile
index 00521fe..45db357 100644
--- a/Makefile
+++ b/Makefile
@@ -1,3 +1,6 @@
+# The default target of this Makefile is...
+all:
+
 # Define MOZILLA_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine coming from Mozilla. It is GPL'd and should be fast
 # on non-x86 architectures (e.g. PowerPC), while the OpenSSL version (default
