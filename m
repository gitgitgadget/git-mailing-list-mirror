From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 10:23:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
References: <428E49DD.406@zytor.com> <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>
 <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188>
 <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com>
 <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com>
 <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
 <20050524161745.GA9537@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 19:26:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dad8S-00021E-76
	for gcvg-git@gmane.org; Tue, 24 May 2005 19:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVEXRY6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 13:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVEXRWk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 13:22:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:18909 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261537AbVEXRV6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 13:21:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4OHLijA007055
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 10:21:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4OHLhYc007065;
	Tue, 24 May 2005 10:21:43 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Linus Torvalds wrote:
> 
>  - the commit time will be the conversion time, not the original commit 
>    time (but the _author_ time will be correct). I suspect that for a 
>    conversion like this, we really should add support for GIT_COMMIT_DATE. 
> 
>    That would also make the archive conversion 100% reproducible, ie
>    everybody should get the exact same objects (and thus the exact same
>    SHA1 values) which is good.
> 
> I'll add the GIT_COMMIT_DATE thing, but the name translation is for 
> somebody else.

Done. I've also fixed the timezone to "+0000", so that it doesn't matter 
where you do the conversion, you should always get the same results 
(again, I just pushed that out, it might not have hit the public mirrors 
yet).

To get GIT_COMMITTER_DATE (note: COMMITTER, not COMMIT, to illogically 
match the name/email ones) you obviously also need a new git. So to have 
it all working right, you should have the top commits in git-tools and git 
be

    cvs2git: set timezone info to UTC, the way CVS does

and

    git-commit-tree: allow overriding of commit date

respectively.

And if this doesn't work for you, point me to the CVS archive that causes 
you trouble. 

		Linus
