From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Don't fflush(stdout) when it's not helpful
Date: Fri, 29 Jun 2007 16:43:14 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706291641590.8675@woody.linux-foundation.org>
References: <20070626171127.GA28810@thunk.org>
 <alpine.LFD.0.98.0706261024210.8675@woody.linux-foundation.org>
 <20070628190406.GC29279@thunk.org> <20070628213451.GB22455@coredump.intra.peff.net>
 <20070628235319.GD29279@thunk.org> <20070629010507.GL12721@planck.djpig.de>
 <20070629034838.GF29279@thunk.org> <20070629063819.GA23138@coredump.intra.peff.net>
 <7vmyyjgrxk.fsf@assigned-by-dhcp.pobox.com>
 <alpine.LFD.0.98.0706290851480.8675@woody.linux-foundation.org>
 <20070629174046.GC16268@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Jun 30 01:44:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4Q88-0007Ei-1R
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 01:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbXF2Xn6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 19:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752524AbXF2Xn6
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 19:43:58 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54646 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752411AbXF2Xn5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jun 2007 19:43:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5TNhK4b014774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Jun 2007 16:43:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5TNhEiU031077;
	Fri, 29 Jun 2007 16:43:14 -0700
In-Reply-To: <20070629174046.GC16268@thunk.org>
X-Spam-Status: No, hits=-4.629 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51184>



On Fri, 29 Jun 2007, Theodore Tso wrote:
> 
> Comments?

Looks ok to me. 

This should probably be paired up with the change to git.c (in "next") to 
do the "fflush()" before the "ferror()" too, in case the error is pending.

		Linus
