From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 17:15:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610181711110.3962@g5.osdl.org>
References: <20061018053647.GA3507@coredump.intra.peff.net>
 <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org> <20061018185225.GU20017@pasky.or.cz>
 <20061018185907.GV20017@pasky.or.cz> <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610181510510.1971@xanadu.home> <20061018191834.GA18829@spearce.org>
 <Pine.LNX.4.64.0610181525410.1971@xanadu.home> <20061018204626.GA19194@spearce.org>
 <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org> <20061018214143.GF19194@spearce.org>
 <7vwt6xxofi.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181542160.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610181910440.1971@xanadu.home> <Pine.LNX.4.64.0610181655430.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 02:15:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaLZ6-000497-OX
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 02:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945920AbWJSAPM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 20:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945922AbWJSAPM
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 20:15:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38538 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945920AbWJSAPK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 20:15:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9J0F1aX027077
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Oct 2006 17:15:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9J0F0W8024293;
	Wed, 18 Oct 2006 17:15:00 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610181655430.3962@g5.osdl.org>
X-Spam-Status: No, hits=-0.971 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29307>



On Wed, 18 Oct 2006, Linus Torvalds wrote:
> 
> So I'll happily send my patches to anybody who wants to try (I don't write 
> the index file yet, but it should be easy to add), but I'm getting the 
> feeling that "builtin-unpack-objects.c" is the wrong tool to use for this, 
> because it's very much designed for streaming.

A potentially even simpler way would probably be to literally just use 
"git-pack-objects" directly, and just have a very special mode that allows 
mapping the thin pack as if it was a real pack (ie basically 
pre-populating a fake pack entry, where the fake part comes from adding 
the missing objects by hand to the mapping).

So many ways to do it, so little real motivation ;)

		Linus
