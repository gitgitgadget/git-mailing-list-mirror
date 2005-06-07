From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH 0/4] Writing refs in git-ssh-push
Date: Tue, 7 Jun 2005 09:30:45 +0200
Message-ID: <20050607073045.GZ3669@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.21.0506061616590.30848-100000@iabervon.org> <Pine.LNX.4.58.0506062008560.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 09:28:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfYUf-0007Ja-Vy
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 09:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVFGHbF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 03:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVFGHbF
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 03:31:05 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:19365 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261629AbVFGHa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2005 03:30:58 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j577UkS8028115
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 7 Jun 2005 07:30:46 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j577Ujvn028114;
	Tue, 7 Jun 2005 09:30:45 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506062008560.2286@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> 	PATH=$PATH:~/bin in my .bashrc,

this should work because ssh executes a *not* login shell when you execute a
remote command. And bash reads .bashrc always and .bash_profile only for login
shell. Is bash your login shell?

For me it works:

(excalibur) [~] cat .bashrc
export PATH=$PATH:~/bin
(excalibur) [~] ssh localhost env | grep PATH
PATH=/usr/local/bin:/bin:/usr/bin:/usr/X11R6/bin:/home/cip/adm/sithglan/bin

In university I had to put the following in my .cshrc (because I have tcsh as
login shell and can't change it) to make bk push and stuff working:

(faui00u) [~] cat .cshrc
setenv PATH /opt/csw/bin:/usr/X11R6/bin:/sbin:/usr/bin:/usr/sbin:/local/bin:/bin:/local/bitkeeper/bin

	Thomas
