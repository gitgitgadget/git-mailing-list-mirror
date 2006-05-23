From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: file name case-sensitivity issues
Date: Tue, 23 May 2006 14:16:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605231412350.5623@g5.osdl.org>
References: <20060523210615.GB5869@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 23 23:17:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FieF1-0004k9-Qz
	for gcvg-git@gmane.org; Tue, 23 May 2006 23:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWEWVQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 17:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWEWVQd
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 17:16:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52930 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932274AbWEWVQc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 17:16:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4NLGRtH028424
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 May 2006 14:16:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4NLGPOr021487;
	Tue, 23 May 2006 14:16:26 -0700
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060523210615.GB5869@steel.home>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20641>



On Tue, 23 May 2006, Alex Riesen wrote:
>
> Very simple to reproduce on FAT and NTFS, and under Windows, as usual,
> when a problem is especially annoying. I seem to have no chance to
> get my hands on this myself, so I at least let everyone know about the
> problem.

I don't think we can fix it.

At least not in the short term.

The closest I can imagine is to add a config option like "core.lowercase", 
and that would make us always add files to the index in lower case. That, 
together with making sure that "setup_pathspec()" &co always also 
lower-case their arguments might get things limping along with minimal 
trouble.

But it won't ever do things _well_. Anything non-ascii would be just a 
nightmare.

		Linus
