From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Display of merges in gitk
Date: Fri, 5 Aug 2005 07:10:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508050658260.3258@g5.osdl.org>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 16:13:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E12vG-0005om-9X
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 16:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbVHEOK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 10:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVHEOK4
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 10:10:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33956 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263032AbVHEOKr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2005 10:10:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j75EAdjA030779
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 Aug 2005 07:10:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j75EAdMP015900;
	Fri, 5 Aug 2005 07:10:39 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Jul 2005, Paul Mackerras wrote:
>
> I have reworked the way gitk displays merges.

Ok, goodie. It works fine in my environment, with most merges showing up 
as not interesting. But a merge like

	3e0777b8fa96f7073ed5d13d3bc1d573b766bef9

shows an example of where there was actually both real content merges, and 
some real clashes.

However, most of the content merges were trivial, and they often hide the 
real clashes. For example, if you click on that merge, a _lot_ of it looks 
like it might be clashes, even though most of it was auto-merged. This is 
not really a problem, but I get the feeling that it could be improved 
somehow - maybe a button that hides the parts that don't have clashes? 


> In the usual case of two parents, lines from the first parent are in red
> and lines from the second parent are in blue.  Lines in the result that
> don't correspond to either parent are in bold black.

To get the alternate output, maybe something like:
 - run "merge" on the original/parent1/parent2 (the same way the
   git-merge-one-file-script does)
 - anything that merged fine is in black (regardless of which parent it 
   came from), and then mark the merge rejects are in red/blue depending 
   on parent?

I don't know how doable that would be.

		Linus
