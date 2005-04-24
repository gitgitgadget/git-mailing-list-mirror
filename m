From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] Selective diff-tree
Date: Sat, 23 Apr 2005 22:09:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
References: <1113400651.20848.135.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 07:02:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPZGF-00084y-I9
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 07:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVDXFHM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 01:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVDXFHM
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 01:07:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:28328 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262258AbVDXFHI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 01:07:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3O573s4003818
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 22:07:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3O572fb029666;
	Sat, 23 Apr 2005 22:07:02 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113400651.20848.135.camel@hades.cambridge.redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Apr 2005, David Woodhouse wrote:
>
> The patch below makes diff-tree take extra arguments, specifying the
> files or directories which should be considered 'interesting'. Changes
> in uninteresting directories are not reported; we don't even bother to
> recurse down into those trees.

David, I took your patch, updated it for some changes in diff-tree, and
then totally rewrote (and simplified) your testing for "interesting".
There was no reason to consider "/" special, as it falls out of the other
cases quite naturally.

It passes all the tests I threw at it, but they weren't exhaustive (but I 
do think I tested the border cases). Mind double-checking that it works 
for your cases too?

		Linus
