From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git applymbox is too anal
Date: Thu, 8 Sep 2005 17:58:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509081754150.3051@g5.osdl.org>
References: <20050908232535.GA7700@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 02:59:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDXE0-0001Z6-UI
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 02:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVIIA6W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 20:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVIIA6W
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 20:58:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14980 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932244AbVIIA6V (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 20:58:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j890wJBo030796
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 8 Sep 2005 17:58:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j890wIx3017557;
	Thu, 8 Sep 2005 17:58:19 -0700
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050908232535.GA7700@kroah.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8229>



On Thu, 8 Sep 2005, Greg KH wrote:
> 
> Or am I missing some option to 'git applymbox' that I can't seem to
> find?

No. git-apply wants an exact bit-for-bit match. Partly because fuzz is 
hard, but mostly because I don't like it. I apply a _lot_ of patches, and 
if a unforgiving "git-apply" works for me, it should work for you too.

One issue is that I want to apply patches that apply cleanly, and if the 
patch was generated against some older kernel version, then it should 
quite likely be _applied_ towards that older kernel version. Then you can 
use git to merge the two.

Of course, I only do that occasionally, for bigger clashes. For smaller 
things, I just edit the patch by hand. And sometimes, I ask the sending 
side to re-generate the patch.

Applying with a fuzz does the right thing most of the time. But "most" 
isn't good enough. I'd rather have a human look at anything that requires 
fuzz.

		Linus
