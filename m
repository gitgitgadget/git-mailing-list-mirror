From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 2/3] DWIM "git checkout frotz" to "git checkout -b
 frotz origin/frotz"
Date: Mon, 19 Oct 2009 07:58:11 +0200
Message-ID: <20091019055811.GA7779@atjola.homenet>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
 <7vaazpxha4.fsf_-_@alter.siamese.dyndns.org>
 <20091018193448.6117@nanako3.lavabit.com>
 <20091018120053.GA11391@atjola.homenet>
 <20091019052043.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 07:58:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzlGD-0004qi-Oi
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 07:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbZJSF6P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2009 01:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753145AbZJSF6P
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 01:58:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:59434 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753125AbZJSF6O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 01:58:14 -0400
Received: (qmail invoked by alias); 19 Oct 2009 05:58:17 -0000
Received: from i59F5B861.versanet.de (EHLO atjola.homenet) [89.245.184.97]
  by mail.gmx.net (mp059) with SMTP; 19 Oct 2009 07:58:17 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18flQY07P4fobjKLxqXCmbroMsnVDr7/bXye97jkd
	tBf2xC3ZYNgNc9
Content-Disposition: inline
In-Reply-To: <20091019052043.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130653>

On 2009.10.19 05:20:43 +0900, Nanako Shiraishi wrote:
> A user who always wants tracking can set the config option and use=20
> the new "git checkout frotz" shortcut, but a user who usually=20
> doesn't want tracking doesn't have the config option and when he=20
> wants tracking only for this new branch he can explicitly say "git=20
> checkout -t origin/frotz", right?

Well, branch.autosetupmerge has three possible values.
 - true: Do the upstream setup when starting from remote tracking
   branches
 - always: Also do the upstream setup when starting from a local branch
   head
 - false: Don't do any upstream setup

The default is "true", which should catch the "git checkout frotz"
shortcut, as that selects a remote tracking branch as the starting
point. So the user doesn't have to change any config setting to have
that act as if -t was given.

Only if we doesn't want "git checkout frotz" to not do the upstream
setup, he needs to set branch.autosetupmerge to false.

And falling back to "git checkout --track/--no-track origin/frotz" he
can override whatever config setting he has.

Bj=F6rn
