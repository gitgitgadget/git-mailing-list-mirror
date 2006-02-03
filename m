From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: The merge from hell...
Date: Thu, 2 Feb 2006 21:45:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602022139190.3462@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE7FF@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 06:46:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4tlx-0001Y6-4R
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 06:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWBCFqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 00:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWBCFqI
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 00:46:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28308 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751154AbWBCFqH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 00:46:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k135jwDZ027496
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Feb 2006 21:45:59 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k135jvfi027279;
	Thu, 2 Feb 2006 21:45:57 -0800
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE7FF@hdsmsx401.amr.corp.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15526>



On Thu, 2 Feb 2006, Brown, Len wrote:
> 
> I can do 16 next time, or 22, or none

Actually, you can't do 22:

	/*
	 * Having more than two parents is not strange at all, and this is
	 * how multi-way merges are represented.
	 */
	#define MAXPARENT (16)

(commit-tree.c).

Now, admittedly you should literally need no more than to change that 
#define and recompile, but at least by default, git-write-tree won't 
accept more than 16 parents.

The 12-way merge was a bit over the top, but it worked. I'd suggest not 
beign quite _that_ aggressive in the future, though, but it's not a big 
deal.

One thing I'd ask for: would it be possible to have more descriptive 
branch names than just numbers? Even if you want to track it by bugzilla 
entry number, how about calling it "bugzilla-12345" instead? 

I can make the educated guess that it's the bugzilla.kernel.org tracking 
number, but still.. I think it would make the changelog more readable and 
understandable to outsiders.

		Linus
