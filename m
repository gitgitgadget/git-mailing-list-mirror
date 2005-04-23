From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 12:38:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>      
 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>      
 <426A4669.7080500@ppp0.net>       <1114266083.3419.40.camel@localhost.localdomain>
       <426A5BFC.1020507@ppp0.net>       <1114266907.3419.43.camel@localhost.localdomain>
       <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>      
 <20050423175422.GA7100@cip.informatik.uni-erlangen.de>      
 <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 21:32:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPQM9-0000Sv-Ve
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 21:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVDWTgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 15:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVDWTgl
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 15:36:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:37024 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261699AbVDWTgg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 15:36:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3NJaPs4031028
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 12:36:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3NJaO3Y014796;
	Sat, 23 Apr 2005 12:36:24 -0700
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <2911.10.10.10.24.1114279589.squirrel@linux1>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Apr 2005, Sean wrote:
> 
> A script that knows how to validate signed tags, can easly strip off all
> the signing overhead for display.   Users of scripts that don't understand
> will see the cruft, but at least it will still be usable.

NO.

Guys, I will say this once more: git will not look at the signature.

That means that we don't "strip them off", because dammit, they DO NOT 
EXIST as far as git is concerned. This is why a tag-file will _always_ 
start with 

	commit <commit-sha1>
	tag <tag-name>

because that way we can use fsck and validate reachability and have things 
that want trees (or commits) take tag-files instead, and git will 
automatically look up the associated tree/commit. And it will do so 
_without_ having to understand about signing, since signing is for trust 
between _people_ not for git.

And that is why I from the very beginning tried to make ti very clear that
the signature goes at the end. Not at the beginning, not in the middle,
and not in a different file. IT GOES AT THE END.

		Linus
