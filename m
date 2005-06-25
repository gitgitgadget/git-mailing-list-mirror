From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix oversimplified optimization for add_cache_entry().
Date: Fri, 24 Jun 2005 17:57:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506241755280.11175@ppc970.osdl.org>
References: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net> <7vvf439vdl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 02:50:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlys5-000093-VM
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 02:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263216AbVFYA4k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 20:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbVFYA4k
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 20:56:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263216AbVFYAz1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 20:55:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5P0tLjA018051
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Jun 2005 17:55:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5P0tIqh022808;
	Fri, 24 Jun 2005 17:55:20 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf439vdl.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 24 Jun 2005, Junio C Hamano wrote:
> 
> Resurrect the unoptimized directory-file conflict check code for
> now as well.  The new one did not handle higher stages properly.

I really don't want to do this. 

Can you fix the "optimized" one instead? Currently the only "optimization"  
is really to just not call it for any non-stage0 thing, the real advantage
is that the old code was totally unreadable and did everything in one big 
thing. 

I'm ok with dropping the optimization, but I don't want to lose the 
cleanup of splitting that horrible old function into two.

		Linus
