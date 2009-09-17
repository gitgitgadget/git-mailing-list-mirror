From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH v2] fetch: Speed up fetch by rewriting
 find_non_local_tags
Date: Thu, 17 Sep 2009 09:13:03 +0200
Message-ID: <200909170913.03639.johan@herland.net>
References: <20090916074737.58044.42776.julian@quantumfyre.co.uk>
 <alpine.LNX.2.00.0909170039410.14993@reaper.quantumfyre.co.uk>
 <alpine.LNX.2.00.0909170227160.15719@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Sep 17 09:13:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoBB4-0007am-Dg
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 09:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758474AbZIQHNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 03:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758310AbZIQHNE
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 03:13:04 -0400
Received: from smtp.getmail.no ([84.208.15.66]:51799 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757476AbZIQHND (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2009 03:13:03 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KQ300C70TDSM6A0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 17 Sep 2009 09:13:04 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KQ3001CLTDST300@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 17 Sep 2009 09:13:04 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.9.17.70327
User-Agent: KMail/1.12.1 (Linux/2.6.30-ARCH; KDE/4.3.1; x86_64; ; )
In-reply-to: <alpine.LNX.2.00.0909170227160.15719@reaper.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128720>

On Thursday 17 September 2009, Julian Phillips wrote:
> On Thu, 17 Sep 2009, Julian Phillips wrote:
> > On Wed, 16 Sep 2009, Junio C Hamano wrote:
> >>  I am just curious.  How would a "just one item lookbehind" code
> >> perform compared to this one?
> >
> > The code you wrote ealier is almost the same as the string_list
> > version, ~ 4.3s, so very marginally slower but a lot less code change. 
> > Personally I'd be happy with any of the three, so long as I don't have
> > to wait 30s to find out that nothing's happened at $dayjob anymore ;)
> 
> FWIW: I've Just modified my v2 patch to make use of the requirement that
> the peeled ref immediately follow the base ref, and it's now ~4.1s and
> should use less memory than the original too.  I won't bother posting it
> unless someone thinks it worth it though.

It's worth it. :)


...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
