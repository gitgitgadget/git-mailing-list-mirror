From: Linus Torvalds <torvalds@osdl.org>
Subject: "git cvsimport"
Date: Tue, 7 Jun 2005 16:03:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506071556000.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jun 08 00:59:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dfn1u-0001wB-ML
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 00:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVFGXCL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 19:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVFGXCL
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 19:02:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:39364 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262029AbVFGXBx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2005 19:01:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j57N1mjA013060
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Tue, 7 Jun 2005 16:01:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j57N1m7J020808
	for <git@vger.kernel.org>; Tue, 7 Jun 2005 16:01:48 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok,
 here's something for testers and/or documentation people: I wrapped a 
little script around cvs2git (which I imported from the git tools thing), 
and now you can do

	git cvsimport <cvsroot> <modulename>

and it might all "just work".

Right now the little sript is actually being anal and checking that 
CVSROOT is a directory, even though I think it all _should_ work even if 
CVSROOT is remote too. But I don't have any remote things to test, and for 
all I know maybe performance is horrible, so for now it artificially 
limits it to locally accessible CVS repos.

I'd love it if somebody tested the remote case (and, if it works, sends me
a patch that just removes the anal tests in git-cvsimport-script), and
maybe even updated the information a bit more.. As it is, that
Documentation/cvs-migration.txt file is a bit on the light side.

Finally, I don't know what to do about cvsps options. It seems that the 
default time-fuzz is a bit too long for some projects, so at least that 
one should be overridable. So my silly script is not exactly wonderful, 
but I think it's more approachable than people doing the magic by hand 
(and forgetting to set TZ to UTC and the "-A" flag etc etc).

		Linus
