From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Show of hands, how many set USE_NSEC
Date: Fri, 8 Aug 2008 11:00:17 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808081056090.3462@nehalem.linux-foundation.org>
References: <20080808163455.GE9152@spearce.org> <alpine.DEB.1.00.0808081854120.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080808165718.GG9152@spearce.org> <alpine.LFD.1.10.0808081027590.3462@nehalem.linux-foundation.org> <20080808175247.GH9152@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 08 20:02:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRWHk-0008Vj-3D
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 20:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbYHHSAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 14:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbYHHSAy
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 14:00:54 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38305 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751720AbYHHSAx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Aug 2008 14:00:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m78I0IcM009969
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Aug 2008 11:00:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m78I0Hqm021004;
	Fri, 8 Aug 2008 11:00:18 -0700
In-Reply-To: <20080808175247.GH9152@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.409 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91702>



On Fri, 8 Aug 2008, Shawn O. Pearce wrote:
> 
> That single file however does not need to be structured internallyy
> the way it is.

Ok, at that point I certainly agree.  

As long as we're talking about a single flat file, I don't think it would 
be all that painful to have a totally new index format. The original 
format was (obviously) designed to be just mmap'ed and turned into a C 
array with no real parsing.

But once we started building a separate index data structure with internal 
structure _anyway_ (for the extended in-memory flags and the filename 
hashing), a lot of the reasons for the original format kind of went away.

			Linus
