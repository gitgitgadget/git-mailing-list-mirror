From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: Re: Corruption: empty refs/heads in otherwise filled repo: cannot clone?
Date: Mon, 30 Jun 2008 14:20:12 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200806301420.12872.J.Wielemaker@uva.nl>
References: <200806301149.18115.J.Wielemaker@uva.nl> <200806301344.09938.J.Wielemaker@uva.nl> <200806301403.57900.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 14:21:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDINd-0007ue-4c
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 14:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757377AbYF3MUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 08:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755812AbYF3MUP
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 08:20:15 -0400
Received: from korteweg.uva.nl ([146.50.98.70]:37796 "EHLO korteweg.uva.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756566AbYF3MUO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 08:20:14 -0400
Received: from gollem.science.uva.nl ([146.50.26.20]) by korteweg.uva.nl with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 30 Jun 2008 14:20:12 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <200806301403.57900.jnareb@gmail.com>
Content-Disposition: inline
X-OriginalArrivalTime: 30 Jun 2008 12:20:12.0878 (UTC) FILETIME=[A55EDEE0:01C8DAAB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86912>

On Monday 30 June 2008 14:03, Jakub Narebski wrote:
> Jan Wielemaker wrote:
> > Summarising, I think the conclusion is that git pack-refs has somehow
> > been run on this repository, and being a bare one this is not a
> > particulary good idea right now. I have the impression I should `unpack'
> > them by putting the appriate files in heads (done) and tags (now still)
> > and (re)move packed-refs.
>
> If you use new enough git both on server and on clients it should
> not have problems with packed-refs. I would rather check permissions
> of $GIT_DIR and $GIT_DIR/packed-refs.

There is no permission problem, as a I proved by doing a recursive copy
of the whole repo (cp -a, no errors) and the problem prevails on the
copy. A serious scan for permission errors was my first step. Almost
looks like something in the environment, but I can't find anything weird
there either.

> If "git show-ref" and "git for-each-ref" works, then
> "git ls-remote <repo>" should work, and git-fetch/git-clone
> shoulw work too...

Thanks for the pointers. I'll leave it for now (busy ...). I now
understand how it is supposed to work. If I can find time at some point
I'll run strace in different setups to see whether I can spot the
difference.

Anyway, thanks to your help I am fairly confident my repo is in good
shape again.

	Cheers --- Jan
