From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form
 after-the-fact annotations on commits
Date: Mon, 28 May 2007 19:58:50 +0200
Message-ID: <200705281958.51079.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <20070528172949.GA7295@mellanox.co.il> <20070528174205.GB7295@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon May 28 19:59:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsjV8-00005k-UK
	for gcvg-git@gmane.org; Mon, 28 May 2007 19:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbXE1R7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 13:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbXE1R7S
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 13:59:18 -0400
Received: from smtp.getmail.no ([84.208.20.33]:49980 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbXE1R7R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 13:59:17 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIR0031DJASA100@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 28 May 2007 19:59:16 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIR004THJA3CI90@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 28 May 2007 19:58:51 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIR00DV8JA3JS90@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 28 May 2007 19:58:51 +0200 (CEST)
In-reply-to: <20070528174205.GB7295@mellanox.co.il>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48632>

On Monday 28 May 2007, Michael S. Tsirkin wrote:
> Quoting Michael S. Tsirkin <mst@dev.mellanox.co.il>:
> > Maybe note names could include the object they point to?
> > Would this help with the scalability too (i.e. only get
> > names for objects we want)?
> 
> Hmm, I just noticed there's refs/notes/{object-sha}/{note-sha}
> that does exactly that. So - this seems to be clear to everyone
> else, but I seem to miss the reason why does this not scale well?
> We can just get the notes for objects we pull, right?

Currently, only "git-note -l" (and by extension gitk) uses the shortcut
through refs/notes/{object-sha}/...

The --decorate code and everybody else goes through for_each_note_ref()
which looks up every note ref in the repo.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
