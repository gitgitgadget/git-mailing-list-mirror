From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Rename handling
Date: Wed, 21 Mar 2007 16:10:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703211607120.6730@woody.linux-foundation.org>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
 <45FED31B.8070307@midwinter.com> <200703191903.20005.andyparkins@gmail.com>
 <45FEE2B2.6050904@midwinter.com> <etpson$qih$1@sea.gmane.org>
 <Pine.LNX.4.63.0703210120230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <4601B199.9060300@midwinter.com> <Pine.LNX.4.63.0703212341020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 22 00:11:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU9xN-0002FL-Ic
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 00:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbXCUXK6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 19:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753118AbXCUXK4
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 19:10:56 -0400
Received: from smtp.osdl.org ([65.172.181.24]:58036 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099AbXCUXKz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 19:10:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2LNAfG9009191
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Mar 2007 16:10:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2LNAexU006495;
	Wed, 21 Mar 2007 16:10:41 -0700
In-Reply-To: <Pine.LNX.4.63.0703212341020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.473 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42825>



On Thu, 22 Mar 2007, Johannes Schindelin wrote:
> 
> That is a particularly bad example: you are not renaming files in that 
> example!

Well, yes and no.

I would actually say that it si a particularly *good* example.

With git, you can actually record renames exactly this way: you just need 
to make sure that you don't change the content, and you make it two 
independent commits.

That is in fact how some systems that support "explicit renames" actually 
do it: the rename is literally a separate option, and cannot necessarily 
go together with other actions (in particular, several file-ID-following 
systems do not allow "cross-renames" in the same commit, for example, and 
you actually have to do them as two separate commits).

Git *allows* you to do renames with changes. In fact, I'd normally 
encourage it. But it doesn't force it, and then renames are totally 
unambiguos except for the case where you simply have the *same*file* in 
multiple places, and you remove or add multiple copies (again, you can do 
that unambiguously too, if you limit it to *one* such rename per commit)

		Linus
