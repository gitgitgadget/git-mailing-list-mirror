From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow
 trees
Date: Sun, 15 Apr 2007 11:18:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704151115270.5473@woody.linux-foundation.org>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net> 
 <Pine.LNX.4.64.0704141019290.18655@racer.site>  <20070415000330.GG3778@curie-int.orbis-terrarum.net>
  <Pine.LNX.4.63.0704141655390.31807@qynat.qvtvafvgr.pbz> 
 <20070415020139.GB2689@curie-int.orbis-terrarum.net>  <20070415043146.GB2229@spearce.org>
 <fcaeb9bf0704142257x3761ef2cie3996420b3bcd24a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 20:18:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hd9J8-0001dX-JI
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 20:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbXDOSSf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 14:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753285AbXDOSSf
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 14:18:35 -0400
Received: from smtp.osdl.org ([65.172.181.24]:60302 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753276AbXDOSSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 14:18:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3FIITIs021183
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 15 Apr 2007 11:18:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3FIISST017738;
	Sun, 15 Apr 2007 11:18:28 -0700
In-Reply-To: <fcaeb9bf0704142257x3761ef2cie3996420b3bcd24a@mail.gmail.com>
X-Spam-Status: No, hits=-0.455 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44500>



On Sun, 15 Apr 2007, Nguyen Thai Ngoc Duy wrote:
> 
> Can we add an attribute like Subversion's svn:keywords? If the
> attribute is set, we expand keywords when checkout and remove
> expansion in memory before doing any git operations. It's some kind of
> I/O filter for working directory access.

NNOOo-oooo...

Keyword substitution is just *stupid*. It's an inexcusable braindamage. 
Don't do it. It leads to all kinds of idiotic problems downstream, and it 
really doesn't help *anything* except for "but I'm used to it". There are 
absolutely no valid uses for it.

If you want to tag your files somehow, do it in "git archive" when 
exporting it, but not in the working tree. And realize that once you 
export it with the stupid keyword expansion, diffs etc will all be 
corrupted, and will not - AND MUST NOT - apply to the uncorrupted working 
tree.

			Linus
