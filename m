From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form
 after-the-fact annotations on commits
Date: Mon, 28 May 2007 09:58:02 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705280957070.26602@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <200705281254.23297.johan@herland.net> <alpine.LFD.0.98.0705280924410.26602@woody.linux-foundation.org>
 <200705281840.50814.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 28 18:58:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsiY2-0003ZP-Fj
	for gcvg-git@gmane.org; Mon, 28 May 2007 18:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbXE1Q6N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 12:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbXE1Q6N
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 12:58:13 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:44224 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751211AbXE1Q6M (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 May 2007 12:58:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4SGw3aj007369
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 May 2007 09:58:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4SGw2vM017196;
	Mon, 28 May 2007 09:58:02 -0700
In-Reply-To: <200705281840.50814.johan@herland.net>
X-Spam-Status: No, hits=-3.054 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48626>



On Mon, 28 May 2007, Johan Herland wrote:
> 
> I still don't see what makes note objects inherently more expensive than
> commit objects. Except for the refs, of course, but we're getting rid
> of those (at least replacing them with a more efficient reverse mapping).

It's exactly the refs that I worry about.

Anything that needs to read in all notes at startup is going to be _slow_.

In contrast, commits we read when (and only when) we need them.

		Linus
