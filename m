From: Andrew Morton <akpm@osdl.org>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 16:56:20 -0800
Message-ID: <20060213165620.11ec6051.akpm@osdl.org>
References: <20060213002502.5c23122c.akpm@osdl.org>
	<7virrj1v44.fsf@assigned-by-dhcp.cox.net>
	<20060213013205.4ba47836.akpm@osdl.org>
	<7vbqxb1sho.fsf@assigned-by-dhcp.cox.net>
	<20060213021917.742b2b10.akpm@osdl.org>
	<7v8xsezsni.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 01:57:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8oVM-00054l-Au
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 01:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWBNA5S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 19:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWBNA5S
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 19:57:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10963 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030340AbWBNA5R (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 19:57:17 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1E0vDDZ006450
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Feb 2006 16:57:13 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k1E0vCkE016701;
	Mon, 13 Feb 2006 16:57:12 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xsezsni.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16094>

Junio C Hamano <junkio@cox.net> wrote:
>
> Sorry, this question is what I do not quite understand.
> 
>  Here is my understanding of the situation.
> 
>   - Betweeen 2.6.16-rc1 and 2.6.16-rc2 a bug you are chasing was
>     introduced.  You know rc1 works fine but rc2 is bad.
> 
>   - You suspect that changes introduced by merging Jeff's tree
>     at some point between -rc1 and -rc2 may be causing this.
> 
>  Am I totally misunderstanding the situation?

yup ;)

The bug is in Jeff's tree only
(git+ssh://master.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git#ALL)
so I wanted to perform the bisection on the git-netdev-all branch.

So I did a `git log git-netdev-all' and looked at where the ipw2200 changes
were and then decided that the 2.6.16-rc1 and 2.6.16-rc2 commits straddled
those changes nicely, so I chose those as the bisection starting points.
