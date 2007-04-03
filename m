From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 14:26:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031425220.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031625050.28181@xanadu.home>
 <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
 <20070403210319.GH27706@spearce.org> <Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org>
 <20070403211709.GJ27706@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Chris Lee <clee@kde.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:28:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYqXv-00089Z-3h
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 23:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945968AbXDCV1h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 17:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945974AbXDCV1h
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 17:27:37 -0400
Received: from smtp.osdl.org ([65.172.181.24]:44804 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945968AbXDCV1g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 17:27:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33LQgPD023439
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 14:26:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33LQfMG003711;
	Tue, 3 Apr 2007 14:26:42 -0700
In-Reply-To: <20070403211709.GJ27706@spearce.org>
X-Spam-Status: No, hits=-0.455 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43670>



On Tue, 3 Apr 2007, Shawn O. Pearce wrote:
> 
> Right.  But maybe we shouldn't be scanning for packfiles every
> time we don't find a loose object.  Especially if the caller is in
> a context where we actually *expect* to not find said object like
> half of the time... say in git-add/update-index.  ;-)

Yes, we could definitely skip the re-lookup if we had a "don't really 
care, I can recreate the object myself" flag (ie anybody who is going to 
write that object)

			Linus
