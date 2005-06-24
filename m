From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: rev-parse, unknown arguments and extended sha1's
Date: Fri, 24 Jun 2005 09:43:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506240941520.11175@ppc970.osdl.org>
References: <20050624122436.GA15182@pc117b.liacs.nl>
 <Pine.LNX.4.58.0506240904240.11175@ppc970.osdl.org> <20050624161718.GA14909@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 18:36:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlrAA-0001DA-Bi
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 18:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbVFXQmW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 12:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbVFXQmT
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 12:42:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63628 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263141AbVFXQlP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 12:41:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5OGf6jA014962
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Jun 2005 09:41:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5OGf6ij031668;
	Fri, 24 Jun 2005 09:41:06 -0700
To: Sven Verdoolaege <skimo@liacs.nl>
In-Reply-To: <20050624161718.GA14909@pc117b.liacs.nl>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 24 Jun 2005, Sven Verdoolaege wrote:
>
> This is what I use:
> 
> rev2=`echo $rev | sed -e 's/[^0-9a-f]//'`
> rev3=`echo $rev2 | sed -e 's/........................................//'`
> if test "x$rev3" = "x" -a "x$rev" = "x$rev2"; then
> 	echo "valid SHA1"
> fi

Oooh. UGGHLEE.

This is one reason I don't do much shell.

Anyway, I think I'll make git-rev-parse have some option to "error out if 
the result is anything but a single revision number", since this is really 
the only reason for git-rev-parse in the first place: to make readable 
scripts.

		Linus
