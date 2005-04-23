From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 12:58:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504231252450.2344@ppc970.osdl.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>         
 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>         
 <426A4669.7080500@ppp0.net>          <1114266083.3419.40.camel@localhost.localdomain>
          <426A5BFC.1020507@ppp0.net>          <1114266907.3419.43.camel@localhost.localdomain>
          <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>         
 <20050423175422.GA7100@cip.informatik.uni-erlangen.de>         
 <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org>   
 <2911.10.10.10.24.1114279589.squirrel@linux1>    <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org>
 <1907.10.10.10.24.1114281858.squirrel@linux1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 21:53:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPQgE-0002JW-Q6
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 21:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVDWT5M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 15:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVDWT5M
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 15:57:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:31907 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261747AbVDWT5D (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 15:57:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3NJuqs4032229
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 12:56:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3NJupvJ015239;
	Sat, 23 Apr 2005 12:56:51 -0700
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <1907.10.10.10.24.1114281858.squirrel@linux1>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Apr 2005, Sean wrote:
> 
> Okay now you're just being difficult <g>   You're acting like it's
> impossible for git to grab the SHA1 out of the clear text message if there
> is signing overhead above the tag reference.   That is nonesense.

No. It's not "impossible" for git to parse crap. But git won't.

There are two ways you can write programs:
 - reliably
 - unreliably

and I do the first one. That means that a program I write does something 
_repeatable_. It does the same thing, regardless of whether a human 
happened to write "REF:" in the comment section, or anything else.

The thing is, great programs come not out of great coding, but out of 
great data structures. The whole git philosophy bases itself on getting 
the data structure right. 

And what you are asking for is doing it _wrong_. So in git I don't just
parse random free-form text and guess that a line that starts with REF: is
a reference to a commit. It has very rigid and well-specified data 
structures, and that's how you make reliable programs.

I don't care what anybody else does on top of git, but dammit, I'll make 
sure that the core infrastructure is designed the right way. 

And that means that we don't guess, and that we don't parse random ASCII
blobs. It means that we have very very fixed formats so that programs can
either do the right thing or unambiguously say "that's crap".

I've said it before, and I'll say it again: we have enough crap that calls 
itself SCM's out there already. I want git to be reliable and _simple_, 
not a collection of crap that just happens to work.

		Linus
