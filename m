From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Errors install git-1.5.2.2 on 64-bit AIX
Date: Tue, 19 Jun 2007 20:21:34 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706192007000.3593@woody.linux-foundation.org>
References: <4b3406f0706191945j1a489743qfacdcafd7f7d73d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Dongsheng Song <dongsheng.song@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 05:21:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0qlP-0002wW-6T
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 05:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758355AbXFTDVq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 23:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758287AbXFTDVq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 23:21:46 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54771 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758081AbXFTDVp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jun 2007 23:21:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5K3Leaf017757
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 Jun 2007 20:21:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5K3LYE8027016;
	Tue, 19 Jun 2007 20:21:34 -0700
In-Reply-To: <4b3406f0706191945j1a489743qfacdcafd7f7d73d4@mail.gmail.com>
X-Spam-Status: No, hits=-2.517 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50525>



On Wed, 20 Jun 2007, Dongsheng Song wrote:
> 
> But install failed:
> [ ... ]
> Usage: install [-c dira] [-f dirb] [-i] [-m] [-M mode] [-O owner]
>               [-G group] [-S] [-n dirc] [-o] [-s] file [dirx ...]
> gnumake: *** [install] Error 2

Do you possibly have a "ginstall" somewhere in addition to the GNU make?

If so, just make the "INSTALL" macro in the Makefile point to that instead 
of the (apparently totally broken) regular "install" program on AIX.

Maybe it's called "gnuinstall".

That said, the installation is really just a matter of copying, so you 
*could* just replace the uses of "install" with either "-mkdir" or "cp" 
depending on whether it's used to make sure a directory exists, or to 
actually copy the programs.

		Linus
