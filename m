From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] contrib: add 'git difftool' for launching common merge  tools
Date: Mon, 19 Jan 2009 06:03:06 +0100
Message-ID: <200901190603.06506.markus.heidelberg@web.de>
References: <1232092802-30838-1-git-send-email-davvid@gmail.com> <200901182025.24045.markus.heidelberg@web.de> <402731c90901181634u32b39c87t6e88d9efef0d3485@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 06:07:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOmMN-0007Ur-Rs
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 06:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbZASFCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 00:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbZASFCR
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 00:02:17 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:40707 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbZASFCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 00:02:16 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 883DDFBEF73B;
	Mon, 19 Jan 2009 06:02:14 +0100 (CET)
Received: from [89.59.93.106] (helo=pluto.local)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LOmH8-0002PE-00; Mon, 19 Jan 2009 06:02:14 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <402731c90901181634u32b39c87t6e88d9efef0d3485@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19SEUssuOlr2k+tyuE4qxWJ0a1BhyyHTmYEvD4p
	wG36a6hX6QKMkxLTQ9ulsyRnaq5siVvqXD639CxFCbopyD0yxc
	s7uWEHRm4lhttu6g2yGA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106321>

David Aguilar, 19.01.2009:
> On Sun, Jan 18, 2009 at 11:25 AM, Markus Heidelberg
> <markus.heidelberg@web.de> wrote:
> > David Aguilar, 16.01.2009:
> >> +     meld|vimdiff)
> >> +             "$merge_tool_path" "$LOCAL" "$REMOTE"
> >> +             ;;
> >> +
> >> +     gvimdiff)
> >> +             "$merge_tool_path" -f "$LOCAL" "$REMOTE"
> >> +             ;;
> >
> > Maybe use '-c "wincmd l"' for Vim as in my patch for git-mergetool to
> > automatically place the cursor in the editable file? Useful for editing,
> > if git-difftool is used to diff a file from the working tree.
> >
> > See http://thread.gmane.org/gmane.comp.version-control.git/106109
> 
> 
> Very cool.  When you have unstaged changes git diff sends the local
> filename as the 2nd argument so I changed the vim command to "wincmd
> r" so that vim places the cursor on the right hand side.

Well, in "wincmd l" "l" doesn't mean "left", it doesn't mean "put the
cursor into the left window", it just moves the cursor into the next
right window. So "wincmd r" doesn't mean "put the cursor into the right
window", but "rotate the window" (see :help ctrl-w_r).

So with "wincmd r" the local file would be moved to the left side and
the index file to the right side, still containing the cursor. Not what
we want.

With "wincmd l" the local file would stay on the right side, the index
file on the left side, but the cursor would move from the left to the
right side. Now we can edit the local file.

> > You have deleted all the '-' chars from git-command, but when using it as the
> > name I think it's the preferred method, only when used as command then without
> > slash.
> 
> I was wondering about that.  I think I tried to follow the lead from
> the git-diff.txt documentation, but "diff" is a builtin and thus
> doesn't have an actual git-diff, so I see why they should be
> different.

Hmm, I don't think it makes a difference, whether it's a builtin or not.
git-diff only exists behind the scenes, invoking it as "git-diff"
doesn't work anymore with default settings. On the other hand, I can
also invoke "git difftool" without the slash, git can find it. The same
way I can for example call "git svn", which also isn't a builtin.

Markus
