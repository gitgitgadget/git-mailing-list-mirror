From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling large files with GIT
Date: Wed, 8 Feb 2006 09:01:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602080853480.2458@g5.osdl.org>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
 <Pine.LNX.4.63.0602081248270.31700@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0602080815180.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 08 18:05:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6sh4-0003sS-Gb
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 18:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030606AbWBHRBX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 12:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030607AbWBHRBX
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 12:01:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13778 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030606AbWBHRBW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 12:01:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k18H1EDZ031844
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Feb 2006 09:01:15 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k18H1DIW001053;
	Wed, 8 Feb 2006 09:01:14 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.64.0602080815180.2458@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15743>



On Wed, 8 Feb 2006, Linus Torvalds wrote:
>
> The fact that all the operations work on a full object, and the delta's 
> are (on purpose) just a very specific and limited kind of size 
> compression is just very ingrained.

Side note: the original explicit git "delta" objects by Nicolas Pitre 
would have handled this large-file-case much more gracefully. 

The pack-files had absolutely huge advantages, though, so I think we (I) 
did the right thing there in making the delta code only a very specific 
special case..

It is possible that we could re-introduce the "explicit delta" object, 
though (it's not incompatible with also doing pack-files, it's just that 
pack-files made 99% of all the arguments for an explicit delta go away).

		Linus
