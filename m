From: "Post, Mark K" <mark.post@eds.com>
Subject: RE: Git-daemon messing up permissions for gitweb
Date: Fri, 9 Jun 2006 16:52:22 -0400
Message-ID: <5A14AF34CFF8AD44A44891F7C9FF410507957896@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 22:52:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fonxn-0007Vo-Nq
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 22:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbWFIUwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 16:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965257AbWFIUwM
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 16:52:12 -0400
Received: from ahmler4.mail.eds.com ([192.85.154.77]:22429 "EHLO
	ahmler4.mail.eds.com") by vger.kernel.org with ESMTP
	id S965239AbWFIUwL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 16:52:11 -0400
Received: from ahmlir4.mail.eds.com (ahmlir4-2.mail.eds.com [192.85.154.134])
	by ahmler4.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59Kq36x003039;
	Fri, 9 Jun 2006 16:52:04 -0400
Received: from ahmlir4.mail.eds.com (localhost [127.0.0.1])
	by ahmlir4.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59KpqfF009223;
	Fri, 9 Jun 2006 16:51:52 -0400
Received: from usahm012.amer.corp.eds.com ([130.175.214.153])
	by ahmlir4.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59KpqJC009213;
	Fri, 9 Jun 2006 16:51:52 -0400
Received: from usahm236.amer.corp.eds.com ([130.175.214.169]) by usahm012.amer.corp.eds.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 9 Jun 2006 16:52:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git-daemon messing up permissions for gitweb
Thread-Index: AcaMBc8zHKOUrTJBSZKqbcI+HlCb2QAAE7tA
To: "Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 09 Jun 2006 20:52:22.0611 (UTC) FILETIME=[9B140230:01C68C06]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21556>

Since umask isn't an environment variable, per se, I'm not sure how this
will change anything.

One other thing I noticed is that init-db.c spells core.sharedRepository
with a capital R, but setup.c spells it "core.sharedrepository" with no
upper case letters.  Would this make any difference to anything I'm
seeing? 


Mark Post

-----Original Message-----
From: Linus Torvalds [mailto:torvalds@osdl.org] 
Sent: Friday, June 09, 2006 4:44 PM
To: Junio C Hamano
Cc: git@vger.kernel.org; Post, Mark K
Subject: Re: Git-daemon messing up permissions for gitweb



On Fri, 9 Jun 2006, Junio C Hamano wrote:
>
> But that should be tweakable by configuring what sshd does for
> the user, shouldn't it?  The "LOGIN PROCESS" section from man
> sshd(8) seems to talk about $HOME/.ssh/environment, for example.

Yeah. That's probably the right place to set things up.

		Linus
