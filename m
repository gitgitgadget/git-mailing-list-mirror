From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git 1.3.2 on Solaris
Date: Tue, 23 May 2006 11:48:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605231144230.5623@g5.osdl.org>
References: <19270.1148407414@lotus.CS.Berkeley.EDU>
 <Pine.LNX.4.64.0605231110230.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 23 20:48:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fibvd-0007Zr-QQ
	for gcvg-git@gmane.org; Tue, 23 May 2006 20:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWEWSsW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 14:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWEWSsW
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 14:48:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61841 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932258AbWEWSsV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 14:48:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4NImJtH021364
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 May 2006 11:48:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4NImI0g016673;
	Tue, 23 May 2006 11:48:19 -0700
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <Pine.LNX.4.64.0605231110230.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20620>



On Tue, 23 May 2006, Linus Torvalds wrote:
> 
> I absolutely agree. That is why the OS has a "access()" system call. It's 
> there to ask the OS whether the file is executable (or readable/writable).

Side note: I'm not claiming that "access()" is a wonderful thing. I do 
agree that we might want to replace it with something else inside of git, 
if only because of portability concerns.

So I'm really just ranting my normal "standards lawyerese doesn't mean 
much" rant..

(access() also has other isses: X_OK obviously means different things for 
directories and for regular files, so quite often you need to do a stat() 
on the thing _anyway_ just to determine whether it's "executable in the 
'execve()' sense" or "executable in the 'path lookup' sense").

		Linus
