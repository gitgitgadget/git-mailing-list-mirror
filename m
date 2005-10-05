From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: clone: I'm only doing a max of 256 requests
Date: Wed, 5 Oct 2005 15:48:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510051547090.31407@g5.osdl.org>
References: <20051005191300.GC17475@hexapodia.org> <7virwbu4wz.fsf@assigned-by-dhcp.cox.net>
 <7vhdbvk6ln.fsf@assigned-by-dhcp.cox.net> <7vy857iqzh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 00:51:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENI4t-0002ip-Vv
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 00:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbVJEWsi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 18:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbVJEWsi
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 18:48:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54453 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030410AbVJEWsh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 18:48:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j95MmW4s005308
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 5 Oct 2005 15:48:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j95MmVNq004073;
	Wed, 5 Oct 2005 15:48:31 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy857iqzh.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.49__
X-MIMEDefang-Filter: osdl$Revision: 1.119 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9743>



On Wed, 5 Oct 2005, Junio C Hamano wrote:
> 
> Hmph.  I was reading linux-2.6/fs/exec.c::copy_strings(), but I
> do not see any such size limit (other than exceeding the total
> machine memory size, probably reported by alloc_page() failing)
> imposed there.  Am I looking at the wrong place?

Look for "MAX_ARG_PAGES".

Ie the limit is about 128kB by default (32 pages). Note that that includes 
not just arguments, but environment.

		Linus
