From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] cvsimport: cleanup commit function
Date: Wed, 24 May 2006 05:52:12 -0400
Message-ID: <20060524095212.GA29510@coredump.intra.peff.net>
References: <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com> <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org> <20060522214128.GE16677@kiste.smurf.noris.de> <7v8xotadm3.fsf@assigned-by-dhcp.cox.net> <46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com> <20060523065232.GA6180@coredump.intra.peff.net> <20060523070007.GC6180@coredump.intra.peff.net> <118833cc0605231047o2012deefh5e77b8496da1e673@mail.gmail.com> <20060523205944.GA16164@coredump.intra.peff.net> <7vpsi41f82.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Morten Welinder <mwelinder@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 11:52:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fiq2M-0005um-1V
	for gcvg-git@gmane.org; Wed, 24 May 2006 11:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbWEXJwO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 05:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbWEXJwO
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 05:52:14 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:60375 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S932655AbWEXJwN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 05:52:13 -0400
Received: (qmail 74530 invoked from network); 24 May 2006 09:52:12 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 24 May 2006 09:52:12 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 24 May 2006 05:52:12 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Morten Welinder <mwelinder@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vpsi41f82.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20675>

On Tue, May 23, 2006 at 04:41:33PM -0700, Junio C Hamano wrote:

> Are you two talking about running git-commit-tree via env is two
> fork-execs instead of just one?  Does that have a measurable
> difference?

Yes, that's what I was talking about. No, probably not a huge
difference. I did some performance measurements of all of the recent
cvsimport changes on a small-ish personal repo (I don't have the gentoo
repo). The results were not significant (<= 1% improvement for each
change).  I would expect some of the changes (index-info, fetchfile) to
have an impact on a repo with different characteristics (like the gentoo
one).

-Peff
