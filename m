From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: More gitweb queries..
Date: Fri, 27 May 2005 15:00:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505271457480.17402@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
 <20050527192941.GE7068@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505271248450.17402@ppc970.osdl.org>
 <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
 <20050527192941.GE7068@cip.informatik.uni-erlangen.de>
 <7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net> <20050527195552.GA6541@cip.informatik.uni-erlangen.de>
 <7vu0kowho9.fsf@assigned-by-dhcp.cox.net> <20050527203227.GA11139@cip.informatik.uni-erlangen.de>
 <7vk6lkwgfl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 23:57:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbmoe-0004lz-GB
	for gcvg-git@gmane.org; Fri, 27 May 2005 23:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVE0V6g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 17:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbVE0V6f
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 17:58:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:64918 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262614AbVE0V6d (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 17:58:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4RLwOjA010611
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 May 2005 14:58:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4RLwNHX011660;
	Fri, 27 May 2005 14:58:23 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6lkwgfl.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 27 May 2005, Junio C Hamano wrote:
>
> >>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:
> 
> TG> But I guess 8 is the limit, isn't it? Did you thought to make this 8 a
> TG> 'n' or is 8 just enough? :-)
> 
> Built-in limit of commit object is 16, not 8.

Actually, even that is not actually built into the commit object itself, 
that's just a #define in commit-tree.c.

Change the MAXPARENT design from 16 to 1024, and nobody will notice any 
difference at all, except "git-commit-tree.c" will use 20kB more memory ;)

There's no limit in the data structures, although there clearly is a 
"sanity" limit (and I personally suspect it comes before you hit 16 ;)

		Linus
