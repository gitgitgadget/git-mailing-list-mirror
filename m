From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 14:28:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031427050.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031625050.28181@xanadu.home>
 <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
 <20070403210319.GH27706@spearce.org> <Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org>
 <20070403211709.GJ27706@spearce.org> <Pine.LNX.4.64.0704031425220.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Chris Lee <clee@kde.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:29:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYqZ3-0000OT-Kg
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 23:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945974AbXDCV3O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 17:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945975AbXDCV3O
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 17:29:14 -0400
Received: from smtp.osdl.org ([65.172.181.24]:44837 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945974AbXDCV3N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 17:29:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33LSOPD023465
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 14:28:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33LSMl1003746;
	Tue, 3 Apr 2007 14:28:23 -0700
In-Reply-To: <Pine.LNX.4.64.0704031425220.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.454 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43672>



On Tue, 3 Apr 2007, Linus Torvalds wrote:
> 
> Yes, we could definitely skip the re-lookup if we had a "don't really 
> care, I can recreate the object myself" flag (ie anybody who is going to 
> write that object)

Side note: with "alternates" files, you might well *always* have the 
objects. If you do

	git clone -l -s ...

to create various branches, and then pull between them, you'll actually 
end up in the situation that you'll always find the objects and get back 
to the really expensive case..

		Linus
