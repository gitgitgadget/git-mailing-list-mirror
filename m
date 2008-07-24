From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Preserve cwd in setup_git_directory()
Date: Thu, 24 Jul 2008 15:09:58 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241506340.8986@racer>
References: <20080724031441.GA26072@laptop>  <alpine.DEB.1.00.0807241324040.8986@racer> <fcaeb9bf0807240540i400fe0d1s7ea8efe72203471d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Geoff Russell <geoffrey.russell@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 16:10:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM1X1-0004ZH-08
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 16:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbYGXOJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 10:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbYGXOJ5
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 10:09:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:44184 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751643AbYGXOJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 10:09:56 -0400
Received: (qmail invoked by alias); 24 Jul 2008 14:09:55 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp060) with SMTP; 24 Jul 2008 16:09:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18oUbRZ7nAoqdjU9EN30F3KGF1TGyYcbF1Ufaaisz
	HctyXK3v+eC5FB
X-X-Sender: gene099@racer
In-Reply-To: <fcaeb9bf0807240540i400fe0d1s7ea8efe72203471d@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89885>

Hi,

On Thu, 24 Jul 2008, Nguyen Thai Ngoc Duy wrote:

> On 7/24/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> >  On Thu, 24 Jul 2008, Nguyen Thai Ngoc Duy wrote:
> >
> >  > When GIT_DIR is not set, cwd is used to determine where .git is. If 
> >  > core.worktree is set, setup_git_directory() needs to jump back to 
> >  > the original cwd in order to calculate worktree, this leads to 
> >  > incorrect .git location later in setup_work_tree().
> >
> > I do not understand.  core.worktree is either absolute, in which case 
> > there is no problem.  Or it is relative to where the config lives, no?
> 
> The problem is GIT_DIR is not absolute in this case. So cwd must stay
> where git dir is until it is absolute-ized by setup_work_tree().

I do not see GIT_DIR being set in your test case at all.

I do not see how get_git_work_tree() ro get_relative_cwd() should ever be 
allowed to chdir().

_If_ they were (which I strongly doubt), they should chdir() back 
themselves.

I now wasted easily 30 minutes just trying to make sense of your patch and 
your response.  And I am still puzzled.

Your commit message was of no help.

This patch is definitely the opposite of "obviously correct".

Ciao,
Dscho
