From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH v5 00/14] New remote-hg helper
Date: Tue, 30 Oct 2012 18:16:05 +0000
Message-ID: <20121030181604.GY26850@arachsys.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
 <20121030102526.GN4891@arachsys.com>
 <CAMP44s1g8rFGP7UOcvp9BEZ1oiSh3+-gYheciqO8Fmghipot8A@mail.gmail.com>
 <20121030180021.GX26850@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:16:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTGMi-0005YL-4M
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 19:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224Ab2J3SQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 14:16:27 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:54586 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934079Ab2J3SQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 14:16:09 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.80)
	(envelope-from <chris@arachsys.com>)
	id 1TTGMB-000778-T0; Tue, 30 Oct 2012 18:16:08 +0000
Content-Disposition: inline
In-Reply-To: <20121030180021.GX26850@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208718>

Chris Webb <chris@arachsys.com> writes:

> A common idiom when working with hg bookmarks is to completely ignore the
> (not very useful) hg branches (i.e. all commits are on the default hg
> branch) and have a bookmark for each line of development used exactly as a
> git branch would be.
> 
> On such a repository, at the moment you will always get a warning about
> multiple heads on branches/default, even though you actually don't care
> about branches/default (and would prefer it not to exist) and just want the
> branches coming from the bookmarks.

Something which you can do with hg clone is

  hg clone http://my.repo/foo#master

to clone just the history behind the master bookmark from foo. This works
nicely with git-remote-hg too:

  git clone hg::http://my.repo/foo#master

gives you just origin/master and origin/branches/default, not
origin/otherbookmark. This is a case where it would be particularly nice to
be able to kill origin/branches/default and just keep the identical
origin/master.

Cheers,

Chris.
