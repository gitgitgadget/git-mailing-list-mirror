From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Unresolved issues
Date: Tue, 20 Feb 2007 18:03:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702201758560.4043@woody.linux-foundation.org>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702200934270.20368@woody.linux-foundation.org>
 <7vfy90v729.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702201621050.4043@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702210136050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702201648000.4043@woody.linux-foundation.org>
 <alpine.LRH.0.82.0702202003370.31945@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 03:04:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJgqY-0005bf-Jt
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 03:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030532AbXBUCEi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 21:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030531AbXBUCEi
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 21:04:38 -0500
Received: from smtp.osdl.org ([65.172.181.24]:33659 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030509AbXBUCEh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 21:04:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1L240hB001564
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Feb 2007 18:04:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1L23xwn029704;
	Tue, 20 Feb 2007 18:03:59 -0800
In-Reply-To: <alpine.LRH.0.82.0702202003370.31945@xanadu.home>
X-Spam-Status: No, hits=-0.456 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40276>



On Tue, 20 Feb 2007, Nicolas Pitre wrote:
>
> I think this is not generic enough.  For one thing this should not be 
> used for crlf only.  There is also the binary patch generation code that 
> wants to know if a file is binary or not.
> 
> What about:
> 
> 	[filetype "text"]
> 		match=*.[ch]
> 		attribute=text
> 		crlfmangle=true
> 
> 	[filetype "images"]
> 		match=*.jpg
> 		attribute=binary
> 		merge=special_jpg_merger

Yes, that's a much nicer format - both more readable, and more generic. 

Although I'd just suggest skipping the "crlfmangle". Just document the 
fact that for "attribute=text", we mangle line-endings as per the rules 
defined elsewhere (which is possibly different for input/output in 
addition for the normal unix/windows rule changes)

And then you can just have multiple "match=" rules, so that you don't need 
to make one complex one. 

		Linus
