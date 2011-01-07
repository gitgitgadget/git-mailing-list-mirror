From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Sat, 8 Jan 2011 00:21:33 +0200
Message-ID: <20110107222133.GA2377@LK-Perkele-VI.localdomain>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
 <alpine.LFD.2.00.1101061552580.22191@xanadu.home>
 <AANLkTikgzqoG2cymNJ0NN03RsTRJi22R9M+0LFJ8U2yB@mail.gmail.com>
 <alpine.LFD.2.00.1101062221480.22191@xanadu.home>
 <20110107052207.GA23128@sigill.intra.peff.net>
 <20110107053119.GA23177@sigill.intra.peff.net>
 <20110107185218.GA16645@LK-Perkele-VI.localdomain>
 <20110107191719.GA6175@sigill.intra.peff.net>
 <20110107214501.GA29959@LK-Perkele-VI.localdomain>
 <20110107215631.GA10343@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Zenaan Harkness <zen@freedbms.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 07 23:21:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbKgr-0003Sh-7m
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 23:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536Ab1AGWVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 17:21:25 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:40491 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab1AGWVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 17:21:25 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 7F98FC7D2A;
	Sat,  8 Jan 2011 00:21:23 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A02EF53C15D; Sat, 08 Jan 2011 00:21:23 +0200
Received: from LK-Perkele-VI (a88-112-56-215.elisa-laajakaista.fi [88.112.56.215])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id CF7491C6386;
	Sat,  8 Jan 2011 00:21:18 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20110107215631.GA10343@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164774>

On Fri, Jan 07, 2011 at 04:56:31PM -0500, Jeff King wrote:
> On Fri, Jan 07, 2011 at 11:45:01PM +0200, Ilari Liusvaara wrote:
> 
> 
> I think there should always be an assumption that mirrors are not
> necessarily complete. That is necessary for bundle-like mirrors to be
> feasible, since updating the bundle for every commit defeats the
> purpose.

Also add protocol that grabs a bundle from HTTP and then opens that
up? :-)

> It would be nice for there to be a way for some mirrors to be marked as
> "should be considered complete and authoritative", since we can optimize
> out the final check of the master in that case (as well as for future
> fetches). But that's a future feature. My plan was to leave space in the
> mirror list for arbitrary metadata of that sort.

The first thing one should get/do when connecting to another repository
is its list of references. One can see from there if what one has got
is complete or not (with --use-mirror that only allows skipping commit
negotiation and fetch, not the whole connection due to the fact that the
repositories are contacted in order)...

-Ilari
