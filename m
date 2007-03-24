From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git / Subversion Interoperability
Date: Sat, 24 Mar 2007 13:13:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703241258560.6730@woody.linux-foundation.org>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org>
 <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk>
 <20070323012422.GC17773@spearce.org> <Pine.LNX.4.64.0703230128330.4001@beast.quantumfyre.co.uk>
 <20070323103426.GA15923@diana.vm.bytemark.co.uk> <20070324064130.GC25863@spearce.org>
 <20070324185517.GA10876@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-1349684047-1174767186=:6730"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 21:14:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVCco-0000eP-DK
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 21:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbXCXUNs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 16:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbXCXUNs
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 16:13:48 -0400
Received: from smtp.osdl.org ([65.172.181.24]:49612 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338AbXCXUNr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 16:13:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2OKD81o006554
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 24 Mar 2007 13:13:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2OKD6Lx012758;
	Sat, 24 Mar 2007 13:13:07 -0700
In-Reply-To: <20070324185517.GA10876@diana.vm.bytemark.co.uk>
X-Spam-Status: No, hits=-0.474 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43015>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-1349684047-1174767186=:6730
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Sat, 24 Mar 2007, Karl Hasselström wrote:
>
> There is a slight problem with directly converting between svn:ignore
> and .gitignore, though: the semantics are only almost the same.
> Specifically, git's ignore patters are recursive (applies to
> subdirectories) while subversion's are not. But it's not a big
> problem.

You should be able to use an "absolute" path-name to ignore something in 
.gitignore, in which case it is not used recursively.

So if your .gitignore looks like

	*.o

it means that it recursively ignores all *.o files starting at that level.

HOWEVER, if you write it as

	/*.o

it means that it ignores *.o files only *within* that level (so it's 
"absolute" wrt the particular .gitignore file, not globally).

So you can have both behaviours.

[ I think the exact behaviour is: if there is a '/' anywhere in the name, 
  it's not a recursive match and has to match the file exactly, but 
  somebody like Junio should probably back me up on that ]

		Linus
---1463790079-1349684047-1174767186=:6730--
