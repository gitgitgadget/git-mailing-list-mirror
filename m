From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fetch--tool: fix uninitialized buffer when reading from
 stdin
Date: Mon, 26 Feb 2007 09:06:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702260905420.12485@woody.linux-foundation.org>
References: <Pine.LNX.4.63.0702261306140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702260821310.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702261741360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 26 18:06:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLjJ5-0002xi-Ah
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 18:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbXBZRGc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 12:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbXBZRGc
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 12:06:32 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53594 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030339AbXBZRGb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 12:06:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1QH6KhB031471
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Feb 2007 09:06:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1QH6K0u025298;
	Mon, 26 Feb 2007 09:06:20 -0800
In-Reply-To: <Pine.LNX.4.63.0702261741360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-2.447 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40631>



On Mon, 26 Feb 2007, Johannes Schindelin wrote:
> 
> But I agree your patch is saner.

Well, it's not the "saner" I'm worried about, I was more worried about  
the fact that your patch added random '\0' characters in the middle of the 
stdin input if it was ever bigger than CHUNK_SIZE. I suspect you only 
tested with small input to stdin.

			Linus
