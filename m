From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cvsimport: rewritten in Perl
Date: Tue, 5 Jul 2005 19:41:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507051936350.3570@g5.osdl.org>
References: <20050705230226.0F9F4353A69@atlas.denx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 04:57:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq06P-0003uS-U8
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 04:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVGFCzt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 22:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVGFCqs
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 22:46:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22663 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262061AbVGFCmR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 22:42:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j662fVjA015763
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 5 Jul 2005 19:41:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j662fURW007390;
	Tue, 5 Jul 2005 19:41:30 -0700
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050705230226.0F9F4353A69@atlas.denx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 6 Jul 2005, Wolfgang Denk wrote:
> 
> I tested this on the U-Boot CVS repository (available at
> http://cvs.sourceforge.net/cvstarballs/u-boot-cvsroot.tar.bz2).
>
> Committing initial tree 2183da96d548c02bd4f99b05e673395f81212878
> Cannot create object: Too many open files

If you make it print out its <pid> and then pause, you can use 

	ls -l /proc/<pid>/fd/

to get an idea of what the files may be. Looks like the new perl version 
is leaking file descriptors..

Matthias?

		Linus
	
