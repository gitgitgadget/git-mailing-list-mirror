From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Cloning marks pack for .keep
Date: Tue, 8 Jul 2008 09:57:46 +0300
Message-ID: <20080708065746.GA3536@mithlond.arda.local>
References: <48728A52.8080107@gmx.ch> <20080708044606.GC2542@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean-Luc Herren <jlh@gmx.ch>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 08:59:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG7AI-0007Zk-Mb
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 08:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbYGHG6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 02:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbYGHG6I
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 02:58:08 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:60628 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751412AbYGHG6H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 02:58:07 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 483E82F101B11ABE; Tue, 8 Jul 2008 09:57:48 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KG790-0000z3-LB; Tue, 08 Jul 2008 09:57:46 +0300
Content-Disposition: inline
In-Reply-To: <20080708044606.GC2542@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87724>

Shawn O. Pearce wrote (2008-07-08 04:46 +0000):

> Jean-Luc Herren <jlh@gmx.ch> wrote:
> > After cloning a local repository with "git clone file://...", the
> > resulting repo had one big pack file, as expected, but also
> > a matching ".keep" file.  Certainly this is a bug, isn't it?  The
> > same happens if I clone git.git.  I used git 1.5.6.1 but observed
> > the same with the current master.  I bisected this behavior to
> > commit fa740529 by Shawn O. Pearce (CC'ing him).  Since this dates
> > back to 2007, I wonder if maybe only I am seeing this, but I cannot
> > think of any reason for it.
> 
> This is a known issue to me; I have been seeing this behavior myself
> since probably fa74 hit next.  I just don't clone often so I've never
> thought about it much.  ;-)

Earlier I noticed that this issue sometimes causes the repository to
grow pretty much after "git gc" because .keep packs are not touched.
This was discussed two months ago:

http://thread.gmane.org/gmane.comp.version-control.git/81856

I tend to think that .keep packs are not good idea at least for small
and medium sized repos. For _really_ big ones I'm not sure.
