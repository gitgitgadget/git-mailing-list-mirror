From: Matthias Kestenholz <lists@spinlock.ch>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 14:46:54 +0100
Message-ID: <1169214414.18684.25.camel@localhost.localdomain>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>
	 <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>	 <45B07875.9030506@fs.ei.tum.de>
	 <81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>
	 <45B0C7E6.4020509@op5.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Junio C Hamano <junkio@cox.net>,
	Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 14:47:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7u5M-0000fw-3o
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 14:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbXASNrM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 08:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbXASNrM
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 08:47:12 -0500
Received: from elephant.oekohosting.ch ([80.74.144.79]:40837 "EHLO
	elephant.oekohosting.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965134AbXASNrL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 08:47:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by elephant.oekohosting.ch (Postfix) with ESMTP id 4B36162C0A4;
	Fri, 19 Jan 2007 14:47:01 +0100 (CET)
Received: from elephant.oekohosting.ch ([127.0.0.1])
	by localhost (elephant.oekohosting.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18709-10; Fri, 19 Jan 2007 14:46:55 +0100 (CET)
Received: from [129.132.210.14] (vpn-global-dhcp3-014.ethz.ch [129.132.210.14])
	by elephant.oekohosting.ch (Postfix) with ESMTP id 2C50062C09A;
	Fri, 19 Jan 2007 14:46:55 +0100 (CET)
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <45B0C7E6.4020509@op5.se>
X-Mailer: Evolution 2.8.2.1 
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37183>

On Fri, 2007-01-19 at 14:30 +0100, Andreas Ericsson wrote:
> Alex Riesen wrote:
> > On 1/19/07, Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> >> >
> >>
> >> % cd .hg && hg status -A .
> >> abort: path contains illegal component: .hg
> >>
> >> I think this is a sensible thing to do.
> > 
> > No, it isn't. It is not unlikely to have repo in repo
> > (and some people already have them).
> > Mercurial is wrong here.
> 
> For managing repos inside repos (onion repos?) I think it should
> be safe to abort if we're not at top-level.
> 


Why not check for /.git/ somewhere inside the current working directory
(pwd) ? That's the way mercurial does it currently, and I think that is
a sane thing to do _if_ you want to protect the user from his own
stupidity.
