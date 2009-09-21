From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [msysGit] Issue 332 in msysgit: .gitattributes dir/ patterns
	are not processed
Date: Mon, 21 Sep 2009 23:39:24 +0200
Message-ID: <20090921213916.GA47509@book.hvoigt.net>
References: <001636d33903a05b960474181c0a@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 23:39:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mpqbd-0006tN-0m
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 23:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbZIUVjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 17:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbZIUVjX
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 17:39:23 -0400
Received: from darksea.de ([83.133.111.250]:54043 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751047AbZIUVjW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 17:39:22 -0400
Received: (qmail 29819 invoked from network); 21 Sep 2009 23:39:24 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 21 Sep 2009 23:39:24 +0200
Content-Disposition: inline
In-Reply-To: <001636d33903a05b960474181c0a@google.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128912>

On Mon, Sep 21, 2009 at 03:26:55PM +0000, codesite-noreply@google.com wrote:
> New issue 332 by vsuvo...@geolearning.com: .gitattributes dir/ patterns are  
> not processed
> http://code.google.com/p/msysgit/issues/detail?id=332
> 
> What steps will reproduce the problem?
> 1. Create a project and initialize git:
>     md foo
>     cd foo
>     git init
> 
> 2. create subdirectory and a file in it:
>     md bar
>     echo sample text >bar\testfile.txt
> 
> 3. create .gitatributes, add/commit it:
>     echo bar/ binary >.gitattributes
>     git add .gitattributes
>     git commit -m "ground zero"
> 
> 4. check bar\testfile.txt
>     git check-attr binary bar/testfile.txt
> 
> What is the expected output? What do you see instead?
> expected output: "bar/testfile.txt": binary: set
> see instead:     "bar/testfile.txt": binary: unspecified

This issue came up on the msysgit bug tracker. So here is either the
documentation wrong or the implementation.

Because it does not make sense to specify any attributes to directories
itself I would expect the contents of the directory to get the
attributes.

What do you think?

cheers Heiko
