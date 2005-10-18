From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-fetch-pack: avoid unnecessary zero packing
Date: Tue, 18 Oct 2005 10:48:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510181046401.3369@g5.osdl.org>
References: <Pine.LNX.4.64.0510181032400.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Oct 18 19:50:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERvZS-0002Bs-2p
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 19:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVJRRsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 13:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVJRRsL
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 13:48:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15285 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750793AbVJRRsK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 13:48:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9IHm5FC001075
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Oct 2005 10:48:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9IHm47T022196;
	Tue, 18 Oct 2005 10:48:05 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0510181032400.3369@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10219>


Gaah. Ignore this version - I had re-organized the code, and that 
introduced a stupid bug for the case where the local side didn't have any 
such ref at all.

I'll send a corrected patch momentarily.

		Linus

On Tue, 18 Oct 2005, Linus Torvalds wrote:
> 
> If everything is up-to-date locally, we don't need to even ask for a 
> pack-file from the remote, or try to unpack it.
