From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/4] Split up default "core" config parsing into helper
 routine
Date: Wed, 18 Jun 2008 17:28:19 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806181726550.2907@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806181524490.2907@woody.linux-foundation.org> <alpine.LFD.1.10.0806181529570.2907@woody.linux-foundation.org> <20080618224919.GA22599@sigill.intra.peff.net> <alpine.LFD.1.10.0806181552590.2907@woody.linux-foundation.org>
 <20080618231316.GB23053@sigill.intra.peff.net> <alpine.LFD.1.10.0806181632080.2907@woody.linux-foundation.org> <20080619000842.GA25117@sigill.intra.peff.net> <alpine.LFD.1.10.0806181721580.2907@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 19 02:30:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K982O-0005Rb-Rh
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 02:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639AbYFSA3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 20:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756471AbYFSA3L
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 20:29:11 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34356 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756564AbYFSA3K (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 20:29:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5J0SKrN024847
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jun 2008 17:28:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5J0SJ81028690;
	Wed, 18 Jun 2008 17:28:20 -0700
In-Reply-To: <alpine.LFD.1.10.0806181721580.2907@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.851 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85434>



On Wed, 18 Jun 2008, Linus Torvalds wrote:
> 
> Nobody should ever use "git-config" normally. You should fire up your 
> editor and just edit the damn file in place. But no, we don't have a 
> man-page for that.

Btw, one reason people end up talking about git-config is that it's easier 
to tell *other* people to "run this command" than it is to tell them to 
"edit this file so it looks like <xyz>".

And I think that's understandable, but still very sad. That file was 
designed to be edited by humans, and it's actually much easier to edit 
that way than to do lots of "git config" runs.

			Linus
