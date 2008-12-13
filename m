From: Resul Cetin <Resul-Cetin@gmx.net>
Subject: Optimizing cloning of a high object count repository
Date: Sat, 13 Dec 2008 16:24:56 +0100
Message-ID: <200812131624.57618.Resul-Cetin@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: gentoo-scm@gentoo.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 13 16:26:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBWO0-0001te-03
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 16:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804AbYLMPZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 10:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755501AbYLMPZG
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 10:25:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:34007 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754742AbYLMPZE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 10:25:04 -0500
Received: (qmail invoked by alias); 13 Dec 2008 15:25:01 -0000
Received: from i59F6A60F.versanet.de (EHLO rowo) [89.246.166.15]
  by mail.gmx.net (mp005) with SMTP; 13 Dec 2008 16:25:01 +0100
X-Authenticated: #13824512
X-Provags-ID: V01U2FsdGVkX1+cRn8f0HOcLqls4UIzXaZA7nwwHQW7y5x+/1o0E0
	dV5BDjTR3vekdO
User-Agent: KMail/1.10.3 (Linux/2.6.26-1-amd64; KDE/4.1.3; x86_64; ; )
Content-Disposition: inline
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103001>

Hi,
there are currently different ideas to move gentoo's cvs repository to an 
other scm. Current tests showed that svn will not make anything better (it 
gets in most perfomance and size based benchmarks even worse). Another idea is 
to move to git. It looks really promising in size based benchmarks but cloning 
seems nearly impossible. The current test repository is available at 
git://git.overlays.gentoo.org/exp/gentoo-x86.git and is around 900MB in size 
and has 4696137 objects. It really takes ages to do the counting of the 
objects on the server and compressing takes much longer.
The size of the linux repository seems to be smaller but in the same range 
object count and repository size but clones are much much faster. Is there any 
way to optimize the server operations like counting and compressing of objects 
to get the same speed as we get from git.kernel.org (which does it in nearly 
no time and the only limiting factor seems to be my bandwith)?
The only other information I have is that Robin H. Johnson made a single 
~910MiB pack for the whole repository.

Thx in advance,
	Resul
