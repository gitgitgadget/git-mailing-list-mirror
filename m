From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 12:30:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504231228480.2344@ppc970.osdl.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <42674724.90005@ppp0.net>
 <20050422002922.GB6829@kroah.com> <426A4669.7080500@ppp0.net>
 <1114266083.3419.40.camel@localhost.localdomain> <426A5BFC.1020507@ppp0.net>
 <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
 <20050423183406.GD20410@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 21:24:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPQEr-0008Ca-W9
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 21:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVDWT24 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 15:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVDWT24
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 15:28:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:42911 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261652AbVDWT2w (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 15:28:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3NJSds4030633
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 12:28:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3NJScpx014553;
	Sat, 23 Apr 2005 12:28:39 -0700
To: Jan Harkes <jaharkes@cs.cmu.edu>
In-Reply-To: <20050423183406.GD20410@delft.aura.cs.cmu.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Apr 2005, Jan Harkes wrote:
> 
> Why not keep the tags object outside of the tree in the tags/ directory.

Because then you have all those special cases with fetching them and with 
fsck, and with shared object directories. In other words: no. 

You can have symlinks (or even better, just a single file with all the
tags listed, which you can create with "fsck", for example) from the tags/
directory, but the thing is, objects go in the object directory and
nowhere else.

			Linus
