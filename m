From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Add core.pager config variable.
Date: Tue, 3 Jul 2007 15:50:08 -0400
Message-ID: <5CF58212-5486-4BA6-AC78-50F62D1B7F6E@silverinsanity.com>
References: <20070703181811.GA17966@Hermes.local> <200707032142.07154.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 21:50:17 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5oO9-0007Bd-3T
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 21:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757299AbXGCTuO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 15:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757450AbXGCTuO
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 15:50:14 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:46018 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266AbXGCTuN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 15:50:13 -0400
Received: from [192.168.1.4] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 67DD21FFC02F;
	Tue,  3 Jul 2007 19:50:11 +0000 (UTC)
In-Reply-To: <200707032142.07154.robin.rosenberg.lists@dewire.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51531>


On Jul 3, 2007, at 3:42 PM, Robin Rosenberg wrote:

> Nak.
>
> PAGER cannot override core.pager with this.

core.pager is acting exactly like GIT_PAGER.  The priority goes (from  
pager.c:30):

GIT_PAGER
core.pager
PAGER
"less"

I think this is a desirable option because I'd like to tell all other  
programs to use less and tell git to use tig (which I'm trying out).   
I specifically want core.pager to override PAGER, but this leaves  
GIT_PAGER as the final override.  Why should I export an environment  
variable to every program when git has a configuration file?  And  
what does overriding PAGER break?  If the user doesn't want to use  
core.pager, they don't have to.

~~ Brian
