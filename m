From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH] Add compat/setenv.c, use in git.c.
Date: Mon, 05 Dec 2005 10:07:17 -0800
Message-ID: <14404.1133806037@lotus.CS.Berkeley.EDU>
References: <7vr78sebp8.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 19:10:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjKkd-0005ti-HN
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 19:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVLESHo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 13:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVLESHo
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 13:07:44 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:31385 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932484AbVLESHn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 13:07:43 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id jB5I7H6d014580;
	Mon, 5 Dec 2005 10:07:17 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id jB5I7H15014579;
	Mon, 5 Dec 2005 10:07:17 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7vr78sebp8.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13219>

And Junio C Hamano writes:
 - putenv(3) says
 - 	The string pointed to by string becomes part of the environment,
 - 	so altering the string changes the environment.

Good catch, thanks.  The Solaris man page first says the 
string space is "no longer used", but at the very end warns 
against using an automatic variable.  Chalk one up for lousy 
docs.

(And sizeof(char) is just habit; 99% of my mallocs aren't of 
char...  Sorry.)

Jason
