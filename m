From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: workaround for a bug in svn serf backend
Date: Fri, 27 Dec 2013 20:34:43 +0000
Message-ID: <20131227203443.GA9189@dcvr.yhbt.net>
References: <20131226202805.GV20443@google.com>
 <1388131515-3015-1-git-send-email-rkagan@mail.ru>
 <20131227200708.GD20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roman Kagan <rkagan@mail.ru>, git@vger.kernel.org,
	Benjamin Pabst <benjamin.pabst85@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 27 21:35:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vwe7h-0007Dt-Aa
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 21:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573Ab3L0Uep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 15:34:45 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:42093 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723Ab3L0Ueo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 15:34:44 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D083C44C2FB;
	Fri, 27 Dec 2013 20:34:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131227200708.GD20443@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239744>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Roman Kagan wrote:
> 
> > Subversion serf backend in versions 1.8.5 and below has a bug that the
> > function creating the descriptor of a file change -- add_file() --
> > doesn't make a copy of its third argument when storing it on the
> > returned descriptor.  As a result, by the time this field is used (in
> > transactions of file copying or renaming) it may well be released, and
> > the memory reused.
> >
> > One of its possible manifestations is the svn assertion triggering on an
> > invalid path, with a message
> >
> > svn_fspath__skip_ancestor: Assertion `svn_fspath__is_canonical(child_fspath)' failed.
> [...]
> 
> Makes sense.  Perhaps also worth mentioning that this is fixed by
> r1553376, but no need to reroll just for that.

Thanks all, I noted this in an addendum to the commit:

    Subversion serf backend in versions 1.8.5 and below has a bug(*) that the

    ...

    * [ew: fixed in Subversion r1553376 as noted by Jonathan Nieder]

> > Cc: Benjamin Pabst <benjamin.pabst85@gmail.com>
> > Cc: Eric Wong <normalperson@yhbt.net>
> > Cc: Jonathan Nieder <jrnieder@gmail.com>
> 
> No need for these lines --- the mail header already keeps track of who
> is being cc-ed.

I don't mind seeing it in history.  At least I've gotten accustomed to
it from the Linux kernel and tracking patch flow between dev -> stable
trees.

> > Signed-off-by: Roman Kagan <rkagan@mail.ru>
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Eric Wong <normalperson@yhbt.net>


The following changes since commit 7794a680e63a2a11b73cb1194653662f2769a792:

  Sync with 1.8.5.2 (2013-12-17 14:12:17 -0800)

are available in the git repository at:


  git://git.bogomips.org/git-svn.git master

for you to fetch changes up to 2394e94e831991348688831a384b088a424c7ace:

  git-svn: workaround for a bug in svn serf backend (2013-12-27 20:22:19 +0000)

----------------------------------------------------------------
Roman Kagan (1):
      git-svn: workaround for a bug in svn serf backend

 perl/Git/SVN/Editor.pm | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)
