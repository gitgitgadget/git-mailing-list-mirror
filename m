From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git status: ignore empty directories (because they cannot be added)
Date: Tue, 23 May 2006 07:35:18 +0200
Message-ID: <E1FiPIu-0003cJ-03@moooo.ath.cx>
References: <7vu07h8rzr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 23 07:36:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiPYb-0001f5-Ah
	for gcvg-git@gmane.org; Tue, 23 May 2006 07:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWEWFfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 01:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWEWFfW
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 01:35:22 -0400
Received: from moooo.ath.cx ([85.116.203.178]:5830 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751345AbWEWFfV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 01:35:21 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vu07h8rzr.fsf@assigned-by-dhcp.cox.net>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20565>

> > and a new option -u / --untracked-files to show files in untracked
> > directories.
> >
> > ---
> > A few things I'm not sure about:
> > - Should there be another option to disable --no-empty-directory?
>
> I am not sure about this.  We used to show everything in a
> directory full of untracked directory, which was distracting and
> that was the reason we added --directory there.  Maybe it would
> be less confusing if we just updated the message
>
>           print "#\n# Untracked files:\n";
>           print "#   (use \"git add\" to add to commit)\n";
>           print "#\n";
>
> to say "use 'git add' on these files and files in these
> directories you wish to add", or something silly like that,
> without this patch?

I do not know if I understand you correctly, do you want to leave out
the -u part of the patch or the whole patch?

Well, anyway, here the reasons for this patch:
- Working in a git repository with a lot of empty directories is
  annoying, because all of them show up in git status even though they
  cannot be added. With --no-empty-directories they are hidden.
- If there is a directory which may be added because it is quite
  useful to have the -u option to see what is in there to add (without
  using ls path/to/directory).
