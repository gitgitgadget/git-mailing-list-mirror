From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC/PATCH] Add git-squash tool and tests
Date: Tue, 10 Jun 2008 01:46:10 +0200
Message-ID: <20080609234610.GF8079@leksak.fem-net>
References: <484D47C9.9050509@gnu.org> <1213043398-30524-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0806092133260.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:47:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5r4v-0000bi-8o
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 01:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbYFIXqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 19:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754287AbYFIXqQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 19:46:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:51055 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751728AbYFIXqP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 19:46:15 -0400
Received: (qmail invoked by alias); 09 Jun 2008 23:46:14 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp036) with SMTP; 10 Jun 2008 01:46:14 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX188DLwP3ds8ADs3epqmcpIC3eXwnz+IqaBsxtZ/IC
	ccFcjLE0SCAPpo
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K5r3y-0000Zd-DN; Tue, 10 Jun 2008 01:46:10 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806092133260.1783@racer>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84458>

Hi,

> Isn't it possible to do this with something like
> 
> 	$ git reset --hard X^ &&
> 	  git merge --no-ff --squash HEAD@{1}

$ git merge --no-ff --squash HEAD@{1}
You cannot combine --squash with --no-ff.

But without --no-ff it somehow squashes to the index, I just have to
commit ;-)


Btw,
if you husk and boil git-squash.sh a while, you get down to
  git reset --soft X^
  git commit {options}
which is way simpler.

The rest is just usage-blabla, option passing and checking for merges
that should result in an error if no --include-merges is provided.

(But, yes, as git-squash is porcelain this doesn't matter at all.)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
