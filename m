From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] index-pack: never prune base_cache.
Date: Wed, 23 Jul 2008 14:09:40 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807231407040.8986@racer>
References: <20080722231745.GD11831@artemis.madism.org> <20080723101415.GA23769@atjola.homenet> <alpine.DEB.1.00.0807231246560.2830@eeepc-johanness> <20080723111931.GF15243@artemis.madism.org> <alpine.DEB.1.00.0807231235150.8986@racer> <20080723120045.GA21274@atjola.homenet>
 <20080723121118.GA20614@artemis.madism.org> <20080723125226.GA11679@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1600079916-1216818581=:8986"
Cc: Pierre Habouzit <madcoder@debian.org>, spearce@spearce.org,
	Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 15:10:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLe75-0008PQ-Rg
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 15:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbYGWNJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 09:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbYGWNJl
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 09:09:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:50709 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751704AbYGWNJk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 09:09:40 -0400
Received: (qmail invoked by alias); 23 Jul 2008 13:09:38 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp012) with SMTP; 23 Jul 2008 15:09:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YbNwlGZhYdIVEbwLg+K6ksUd1ifonJQxuN137Vu
	W1+2zoAf/UdzH0
X-X-Sender: gene099@racer
In-Reply-To: <20080723125226.GA11679@atjola.homenet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89646>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1600079916-1216818581=:8986
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 23 Jul 2008, Björn Steinbrink wrote:

> On 2008.07.23 14:11:18 +0200, Pierre Habouzit wrote:
> > It may belong to something (stdin) that is consumed.
> 
> Probably thanks to me, babbling about stdin without having a clue what 
> I'm talking about, that rationale is wrong.
> 
> We may not prune base_cache since that object might come from a
> different pack than the one that we are processing. In such a case, we
> would try to restore the data for that object from the pack we're
> processing and fail miserably.

Then the proper fix would be to load the object from that pack again.

> The patch itself should be fine.

No, since it opens the whole issue of memory explosion again, the same 
issue Shawn's original patch tried to fix.

Ciao,
Dscho

P.S.: Could you please, please, please cull the part you are not 
responding to?  This mailing list is read by more than 50 people.  If you 
sum up the time it takes them to realize that that quoted part was 
irrelevant, I am sure you will end up with a larger number of minutes than 
it would take you to just delete it.

Thanks.

--8323329-1600079916-1216818581=:8986--
