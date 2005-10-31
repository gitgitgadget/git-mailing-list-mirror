From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild
 bug)
Date: Mon, 31 Oct 2005 08:25:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510310819290.27915@g5.osdl.org>
References: <43652934.8000308@zytor.com> <7vy84ajl4c.fsf@assigned-by-dhcp.cox.net>
 <20051031064105.GV8041@shell0.pdx.osdl.net> <43663EEA.5050102@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Wright <chrisw@osdl.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 17:27:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWcTt-0002gl-FP
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 17:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVJaQZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 11:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVJaQZ2
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 11:25:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37846 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932444AbVJaQZ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 11:25:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9VGR1sC019574
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 08:27:01 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9VGPLhE013269;
	Mon, 31 Oct 2005 08:25:21 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43663EEA.5050102@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10864>



On Mon, 31 Oct 2005, H. Peter Anvin wrote:
> 
> The git-core RPM definitiely needs to be split.  Doubly ironic that it's
> called "core".

I don't think it's necessarily ironic. It's actually a good thing.

I think that what we want to have is one _project_ (called "git"), which 
can generate multiple RPM's ("git-core", "git-svnimport", "git-docs", 
whatever).

So I think it was good that we called the RPM "git-core". We've just not 
yet done the obvious thing to create a few _other_ RPM's.

Now, I'm not certain how happy RPM would be with having one source RPM 
generate multiple binary RPM's, so we might have problems with some stupid 
RPM rules, but I think we should really do this. There's always going to 
be some extra feature that not everybody needs, but that it would be silly 
to have its own project for. 

Having one bigger project means that it's much easier to maintain, and 
there's less administrative overhead (good maintainers are really hard to 
find: you should realize how lucky we are to have Junio). Trying to split 
up the source code into independent projects at this level would just be 
much more pain than it's worth. But clearly we want to split up the RPM's.

		Linus
