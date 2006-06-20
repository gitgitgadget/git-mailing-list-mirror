From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Q] what to do when waitpid() returns ECHILD under signal(SIGCHLD,
 SIG_IGN)?
Date: Mon, 19 Jun 2006 17:44:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606191742470.5498@g5.osdl.org>
References: <7vwtbc7ll6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606191654590.5498@g5.osdl.org> <7vfyi07jf2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 02:44:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsULu-0008T3-5K
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 02:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWFTAoT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 20:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWFTAoT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 20:44:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51844 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965016AbWFTAoT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 20:44:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5K0iFgt021826
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Jun 2006 17:44:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5K0iETd020326;
	Mon, 19 Jun 2006 17:44:14 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyi07jf2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22153>



On Mon, 19 Jun 2006, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Whether we want to do that in the main() routine or when we actually do 
> > the fork() or whatever is a different issue.
> 
> I do not offhand think of a place where we do fork() but not
> waitpid(), and it is very tempting to cheat and do that in the
> main(), since I do not see a downside to it.

Yeah, it probably does make sense. That said, there are several "main()" 
functions, so you'd still end up having to verify that we catch all the 
paths.. Are all users of fork() built-in by now? 

			Linus
