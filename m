From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Thu, 2 Aug 2007 13:43:33 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708021340450.8184@woody.linux-foundation.org>
References: <46AFCF3E.5010805@alum.mit.edu>
 <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	users@cvs2svn.tigris.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:43:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGhWT-0007Gc-60
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 22:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbXHBUnq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 16:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXHBUnq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 16:43:46 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58420 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751771AbXHBUnp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 16:43:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l72Khdgs025854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Aug 2007 13:43:40 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l72KhXJC008410;
	Thu, 2 Aug 2007 13:43:33 -0700
In-Reply-To: <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de>
X-Spam-Status: No, hits=-2.679 required=5 tests=AWL,BAYES_00,TW_SV
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.183 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54604>



On Thu, 2 Aug 2007, Steffen Prohaska wrote:
> 
> Right now, I'd prefer the import by parsecvs because of the
> simpler history. However, I don't know if I loose history
> information by doing so. I'd start by a run of cvs2svn to validate
> the overall structure of the CVS repository.

Well, once imported, you could just go through the branches and tags, and 
just delete the ones you consider uninteresting, and then do a "git gc".

You'd want to re-pack after a fast-import anyway (regardless of the source 
of the fast-import input), so maybe cvs2svn ends up giving you a bit 
unnecessary info, but it should be easy enough to get rid of 
after-the-fact.

		Linus
