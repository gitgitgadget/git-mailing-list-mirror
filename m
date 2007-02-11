From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 'git status' is not read-only fs friendly
Date: Mon, 12 Feb 2007 00:24:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702120018110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
 <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
 <e5bfff550702100651j244e5a2flf02fb91dc71799b3@mail.gmail.com>
 <7v1wkykmj1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702102135080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbqk0cq7i.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702112305580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vsldcba3k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:24:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGO3h-0005cX-Oj
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbXBKXY1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbXBKXY1
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:24:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:53882 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932591AbXBKXY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:24:26 -0500
Received: (qmail invoked by alias); 11 Feb 2007 23:24:24 -0000
X-Provags-ID: V01U2FsdGVkX1+D+y9dp6eDY74IS3o+hOFjZGbHx9LJ0ybhl+lOKh
	KVKQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vsldcba3k.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39326>

Hi,

On Sun, 11 Feb 2007, Junio C Hamano wrote:

> Ah, you misread me.  What I was trying to drive at was if we find the 
> subtle difference between Cygwin's lstat(2) emulation and lstat(2) 
> result from the NTFS driver in the Linux kernel, we could start and fuel 
> flamewar on _other_ lists (namely, kernel and Cygwin) saying "you guys 
> are inconsistent which inconvenience applications great deal".

I have no access to cygwin right now, so I'll argue using MinGW instead.

As I already said, I do not know what would happen if we touched st_ino. 
We'd likely have to touch it, since it takes 2 bytes on MinGW, and 4 bytes 
on Linux. Also, IIRC Cygwin fakes the inodes; and it depends on the Cygwin 
version, how it does it.

Also, we check st_uid and st_gid explicitely, which is more a problem to 
be solved by the person mounting the filesystem than the person 
maintaining the filesystem driver.

AFAICT we do not use st_dev anyway.

> And watching other people flame each other is a lot more fun than 
> flamewar raging close to home ;-).

Sometimes I find them fun here, too. That is, if it is not such a tiring 
flamewar as the renaming issues which creep up regularly.

Ciao,
Dsho
