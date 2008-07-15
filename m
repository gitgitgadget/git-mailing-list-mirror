From: Yves Orton <yves.orton@booking.com>
Subject: Re: [PATCH] git rev-parse: Fix --show-cdup inside symlinked
	directory
Date: Tue, 15 Jul 2008 18:58:19 +0200
Message-ID: <1216141099.19334.196.camel@gemini>
References: <1216131208.19334.171.camel@gemini>
	 <20080715145920.13529.25603.stgit@localhost>
	 <alpine.DEB.1.00.0807151614510.8950@racer>
	 <20080715154036.GR10151@machine.or.cz>  <1216140100.19334.189.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 15 18:59:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIns7-0008BQ-6r
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 18:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762005AbYGOQ6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 12:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762001AbYGOQ6Z
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 12:58:25 -0400
Received: from msx2.activehotels.net ([62.190.24.12]:60948 "EHLO
	mx2.activehotels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761999AbYGOQ6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 12:58:24 -0400
Received: from p5098d9db.dip0.t-ipconnect.de ([80.152.217.219] helo=[192.168.250.20])
	by mx2.activehotels.net with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.50)
	id 1KInr2-0006pd-R2; Tue, 15 Jul 2008 17:58:21 +0100
In-Reply-To: <1216140100.19334.189.camel@gemini>
X-Mailer: Evolution 2.22.3.1 
X-AH-Spam-Helo: [192.168.250.20]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88581>

On Tue, 2008-07-15 at 18:41 +0200, Yves Orton wrote:
> On Tue, 2008-07-15 at 17:40 +0200, Petr Baudis wrote:
> > 
> >   P.S.: Either way, there is a possible workaround to tell git about the
> > working directory manually using git --work-tree=... that I missed to
> > mention on IRC, Yves.
> 
> Hmm, am i using it wrong then?
> 
> [dmq@somewhere apps]$ git-rev-parse --git-dir
> /home/dmq/git_tree/main/.git
> [dmq@somewhere apps]$ git --work-tree="$(git-rev-parse --git-dir)" pull
> --rebase
> /usr/bin/git-sh-setup: line 139: cd: .git: No such file or directory
> Unable to determine absolute path of git directory

Hmm, realizing that was the workdir it wanted i tried it like so:

[dmq@somewhere apps]$ git --work-tree="$(git-rev-parse --git-dir)/.."
pull --rebase
/usr/bin/git-sh-setup: line 139: cd: /home/dmq/git_tree/main/apps/.git:
No such file or directory
Unable to determine absolute path of git directory

Yet:

[dmq@somewhere apps]$ git-rev-parse --git-dir
/home/dmq/git_tree/main/.git

is correct.

> cheers,
> yves
> ps: not on list, please cc me on replies (sorry for the hassle)
> 
