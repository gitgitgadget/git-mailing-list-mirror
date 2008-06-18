From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/4] Split up default "core" config parsing into helper
 routine
Date: Wed, 18 Jun 2008 16:34:49 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806181632080.2907@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806181524490.2907@woody.linux-foundation.org> <alpine.LFD.1.10.0806181529570.2907@woody.linux-foundation.org> <20080618224919.GA22599@sigill.intra.peff.net> <alpine.LFD.1.10.0806181552590.2907@woody.linux-foundation.org>
 <20080618231316.GB23053@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 19 01:36:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K97CT-0007ZS-4m
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 01:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbYFRXfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 19:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754664AbYFRXfa
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 19:35:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37943 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754660AbYFRXf3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 19:35:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5INYowA022030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jun 2008 16:34:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5INYnRU026635;
	Wed, 18 Jun 2008 16:34:50 -0700
In-Reply-To: <20080618231316.GB23053@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.853 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85424>



On Wed, 18 Jun 2008, Jeff King wrote:
> 
> It seems like the '.' implies hierarchy, but the syntax of the file
> doesn't really follow it. But that's a minor issue, and really not worth
> the pain it would take to change at this point.

Hierarchy is idiotic in a human-readable file. It's not how people work.

And you're looking at the wrong part. You're looking at the _code_ part, 
which is not the primary thing. The primary thing is the config file 
syntax. And

	[branch "mybranch"]
		url = xyz

is a hell of a lot more readable than any alternatives I've ever seen, and 
no, there is no hierarchy _anywhere_ there, and shouldn't be.

Forget about "branch.mybranch.url". It has no meaning. It's not what you 
are supposed to ever use as a human (it's purely for scripting). It's not 
worth even thinking about.

			Linus
