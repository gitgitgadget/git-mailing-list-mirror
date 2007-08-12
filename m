From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 12:45:26 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708121243220.30176@woody.linux-foundation.org>
References: <85ir7kq42k.fsf@lola.goethe.zz> 
 <alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org> 
 <alpine.LFD.0.999.0708121140190.30176@woody.linux-foundation.org>
 <9e4733910708121228v2fa8d356ld93efa7d1d5effd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 21:45:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKJNd-0007oo-6y
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 21:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938349AbXHLTpj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 15:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938213AbXHLTpi
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 15:45:38 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42220 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937920AbXHLTpg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 15:45:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7CJjWOm006012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Aug 2007 12:45:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7CJjQ5w018924;
	Sun, 12 Aug 2007 12:45:26 -0700
In-Reply-To: <9e4733910708121228v2fa8d356ld93efa7d1d5effd6@mail.gmail.com>
X-Spam-Status: No, hits=-2.742 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55709>



On Sun, 12 Aug 2007, Jon Smirl wrote:
> 
> Could the topological graph for a packfile be computed at pack time
> and stored in the packfile so that gitk doesn't have to keep
> recomputing it?

For a single (full) pack, with no loose objects, sure, you could cache it. 
But then you might as well just cache it all outside git instead.

>		 Does it work to merge multiple precomputed graphs
> retrieved from the pack files?

No. For multiple packs, there aren't even any "precomputed graphs". You 
could probably do it with some fragment thing, and then be really clever 
putting all the fragments together, but I think it's complex as hell.

		Linus
