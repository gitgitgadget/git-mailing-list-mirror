From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Silence error messages unless 'thorough_verify' is set
Date: Sun, 10 Jun 2007 21:16:19 +0200
Message-ID: <200706102116.19414.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706101410.17771.johan@herland.net>
 <Pine.LNX.4.64.0706101943350.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 21:16:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxStp-0001OZ-Gd
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 21:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983AbXFJTQ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 15:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754987AbXFJTQ2
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 15:16:28 -0400
Received: from smtp.getmail.no ([84.208.20.33]:53468 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754309AbXFJTQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 15:16:27 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJF00M01PJEMG00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 21:16:26 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00EGQPJ71190@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 21:16:19 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00JCZPJ73R60@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 21:16:19 +0200 (CEST)
In-reply-to: <Pine.LNX.4.64.0706101943350.4059@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49758>

On Sunday 10 June 2007, Johannes Schindelin wrote:
> On Sun, 10 Jun 2007, Johan Herland wrote:
> > On Sunday 10 June 2007, Johannes Schindelin wrote:
> > > As for the general direction of implementing notes as tags: If you 
> > > want to make them fetchable, you have to deal with conflicts. If you 
> > > want to be able to amend notes, _especially_ when they should be 
> > > fetchable, you want a history on them.
> > 
> > I'm not sure what kind of notes you're talking about here. If you're 
> > talking about my git-note concept, I designed notes to be immutable 
> > (thus not amendable) and there is therefore _no_ merging or potential 
> > for conflicts between notes.
> 
> Okay, that is one way you can go about implementing notes.
> 
> > The only resolution needed is to figure out which order the notes for a 
> > given object should be presented. The default here is chronological 
> > sorting.
> 
> There are several problems with that approach I'd like to point out:
> 
> - In distributed environments, you can not rely on timestamps. Ever.

Not really, but that doesn't stop many programs from trying anyway...
(e.g. email clients). And still, it's not like the date (or sorting)
is crucial to the 'notes' concept or implementation.

> - If a note is deleted, you will fetch it again as long as the other side 
>   did not delete it.

Yep. This was considered an acceptable tradeoff in the design. But I
understand that some people won't like it.

> - You cannot undo a typo (since the notes are immutable, you would see 
>   both versions), once the typoed note was fetched.

Yep. Also a tradeoff in the design. Also going to piss off some
people, I guess.

> Basically, everything I see as a problem here suggests that note writing 
> is very much like working on a branch. That's why I suggest to treat it 
> exactly like a branch to begin with.

I see you point.


BTW, I have some patches implementing the 'notes' concept on top
of the softrefs patches. They're just lying around now waiting
to be cleaned up and sent to the list, but I'm not sure it's worth
it, since they don't add anything that's not in your lightweight
annotation patch...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
