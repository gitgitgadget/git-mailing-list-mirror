From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge summaries
Date: Fri, 18 May 2007 11:33:57 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705181130580.3890@woody.linux-foundation.org>
References: <25A3C618-8D12-42A8-9478-D3A4E7633CE7@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri May 18 20:35:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp7IP-0000J6-JK
	for gcvg-git@gmane.org; Fri, 18 May 2007 20:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383AbXERSfQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 14:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756253AbXERSfQ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 14:35:16 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42062 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755383AbXERSfP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 14:35:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4IIY1DG003658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 May 2007 11:34:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4IIXwME020949;
	Fri, 18 May 2007 11:33:59 -0700
In-Reply-To: <25A3C618-8D12-42A8-9478-D3A4E7633CE7@zib.de>
X-Spam-Status: No, hits=-2.894 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.180 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47626>



On Fri, 18 May 2007, Steffen Prohaska wrote:
>
> It took me some time to figure out how to get summaries of the merged branch
> into merge messages. Finally I recognized that I simply need to set
> 
> 	git-config merge.summary true

Yes.

> I have two questions:
> 1) Why isn't 'true' the default setting? The two probably most prominent git
> repositories, git and kernel, both use merge summaries.

Think about _who_ uses it for those two prominent repositories for a while.

[ pause, ponder here ]

In other words, "merge.summary" should be true ONLY FOR TOP-LEVEL 
MAINTAINERS.

Making it true for anybody else is almost always a bug. Yes, I and Junio 
have it enabled, but pretty much nobody else should, because if they pull 
from me or Junio in order to merge, their merge summaries would be exactly 
the wrong way around!

> 2) Why does git-merge have a switch '--no-summary' to switch summaries off,
> but doesn't have a switch '--summary' to switch them on?

Probably because "normal users" should never use summaries in the first 
place, so it's just not been an issue.

		Linus
