From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Very limited pathspec wildcards..
Date: Wed, 3 Aug 2005 12:38:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508031234280.3258@g5.osdl.org>
References: <Pine.LNX.4.58.0508031038320.3258@g5.osdl.org>
 <7voe8ec08j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 21:40:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0P4s-0000tB-5B
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 21:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVHCTiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 15:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVHCTiu
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 15:38:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52146 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262427AbVHCTit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 15:38:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j73JcijA015861
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 Aug 2005 12:38:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j73JciUH004025;
	Wed, 3 Aug 2005 12:38:44 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe8ec08j.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 3 Aug 2005, Junio C Hamano wrote:
> 
> Wouldn't something like this work equally well?

Nope, for several reasons:
 - it's _horribly_ inefficient (ie it traverses directories that it 
   doesn't need to)
 - it shows all the changeset comments, regardless of whether they are 
   releant or not. It just removes the diffs.

Try it out.

Junio, name-based filters _have_ to be done early. This is why
"diffcore-pathspec" isn't used any more - it's _much_ too inefficient to
do it later.

		Linus
