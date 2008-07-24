From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Preserve cwd in setup_git_directory()
Date: Thu, 24 Jul 2008 13:26:40 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241324040.8986@racer>
References: <20080724031441.GA26072@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-933159196-1216902411=:8986"
Cc: git@vger.kernel.org, Geoff Russell <geoffrey.russell@gmail.com>
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 14:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLzvB-0003Mz-0K
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 14:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbYGXM0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 08:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbYGXM0t
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 08:26:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:40110 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750817AbYGXM0s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 08:26:48 -0400
Received: (qmail invoked by alias); 24 Jul 2008 12:26:47 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp032) with SMTP; 24 Jul 2008 14:26:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bocoC0gnbyTCBPn6E/cfSxdH8rC3zo8TdDdbKW5
	X8I0z/ZbJzhpFI
X-X-Sender: gene099@racer
In-Reply-To: <20080724031441.GA26072@laptop>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89871>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-933159196-1216902411=:8986
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 24 Jul 2008, Nguyễn Thái Ngọc Duy wrote:

> When GIT_DIR is not set, cwd is used to determine where .git is. If 
> core.worktree is set, setup_git_directory() needs to jump back to the 
> original cwd in order to calculate worktree, this leads to incorrect 
> .git location later in setup_work_tree().

I do not understand.  core.worktree is either absolute, in which case 
there is no problem.  Or it is relative to where the config lives, no?

Besides, this touches a _very_ delicate part of Git.  I'd rather not touch 
it during the -rc cycle.

I remember I was opposed to the whole worktree crap, and judging by the 
sheer amount of bug reports, next to nobody uses it anyway.

It was implemented in a really ugly manner, too, and my attempt to fix it 
was still messy.  That is why we have _only_ problems with it.

Just thinking of worktree makes me uneasy,
Dscho

--8323329-933159196-1216902411=:8986--
