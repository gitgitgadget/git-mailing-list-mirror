From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: GIT_DIR question
Date: Sun, 17 Jun 2007 23:52:35 +0200
Message-ID: <20070617215235.GA27753@moooo.ath.cx>
References: <f36b08ee0706170829w59979d86i7bf09bc35ff28fca@mail.gmail.com> <f36b08ee0706170834m464ce57dl3fd5b549b23abb16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yakov Lerner <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 23:52:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I02fr-0000CK-KU
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 23:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbXFQVwm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 17:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbXFQVwm
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 17:52:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:36035 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751044AbXFQVwl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 17:52:41 -0400
Received: (qmail invoked by alias); 17 Jun 2007 21:52:39 -0000
Received: from pD9EB8B82.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.139.130]
  by mail.gmx.net (mp046) with SMTP; 17 Jun 2007 23:52:39 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19r32Ngcjhr78eyoA+dMwbmXAO1iIaXYL7hNnDvFS
	6ooFhOA5Pk4Qyu
Content-Disposition: inline
In-Reply-To: <f36b08ee0706170834m464ce57dl3fd5b549b23abb16@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50375>

Yakov Lerner <iler.ml@gmail.com> wrote:
> I wanted to create cloned repo, but with metaninfo separately from data.
> I cloned the repo ( git-clone ~/repo ~/x) ,
> then I moved ~/x/.git to different place (mv ~/x/.git ~/git);
> then exported GIT_DIR=~/git; then
> cd ~/x;
> But now 'git status' says 'fatal: runstatus must be run in a work tree' . 
> Why ?
> 
> 'ls $GIT_DIR'  shows
>  FETCH_HEAD  HEAD  ORIG_HEAD  branches  config
>  description  hooks  index  info  logs  objects  refs
> This is ok, no ?

With current git you have to name the repository directory '.git' to
use it with a working tree.  Some commands work even though the
repository is named differently, others don't.

In pu is a patch series by me which changes this.  First of all the
core.bare option is used all the time, the directory name of the
repository does not matter if core.bare is specified.  Additionally
you can specify the working tree through the config option
core.worktree or the environment variable GIT_WORK_TREE.  With this
you can even work in a subdirectory of the working tree.  But this is
only in pu and it is not decided yet if this will make it into master,
even though I hope it will.  Perhaps more people asking for this helps :)
