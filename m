From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: showing unstaged, etc., changes at the bash prompt
Date: Fri, 6 Feb 2009 11:20:01 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngoo771.6pi.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 12:21:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVOmE-0006Zg-Cx
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 12:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbZBFLUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 06:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbZBFLUP
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 06:20:15 -0500
Received: from main.gmane.org ([80.91.229.2]:33242 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245AbZBFLUN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 06:20:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LVOkk-0002cu-Q1
	for git@vger.kernel.org; Fri, 06 Feb 2009 11:20:10 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 11:20:10 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 11:20:10 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108686>

In a thread on "[PATCH v2] bash: offer to show (un)staged changes",
on 2009-02-01, Thomas Rast <trast@student.ethz.ch> wrote:

> Add a bit of code to __git_ps1 that lets it append '*' to the branch
> name if there are any unstaged changes, and '+' if there are any
> staged changes.
>
> Since this is a rather expensive operation and will force a lot of
> data into the cache whenever you first enter a repository, you have to
> enable it manually by setting bash.showDirtyState to a true value.

I'd been doing something a little crazy-sounding that I
thought I should share (for what it is worth).  My problem
was that this expense Thomas mentioned was not just on first
entering a repo, but on *each* command, for some of my users
(long story...  old hardware, wrong kind of "corporate
mandated" software, Windows...  please don't ask <sigh>)

Also, instead of just a symbol, I wanted a *count* of how
many files are staged (git added), modified, untracked,
unmerged, etc.  A color-coded number for each type would be
great.

But I couldn't run this extra stuff at every prompt.  I
wanted it to kick in only when

    * I change directories, or
    * I switch branches, or the branch state (according to
      __git_ps1) changes, or
    * when I want it to, but I won't type a command (huh?)

The idea is that it should be as convenient and accessible
as the current __git_ps1, but it shouldn't really happen on
every prompt.

That last part is a bit of a hack, but basically, if you hit
enter twice in a row quickly at the bash prompt, you get the
more detailed stuff added to __git_ps1's output :-)

Sounds crazy but if you try it, you might just like it...
The link to the shell script is toward the end of
http://sitaramc.github.com/2-command-line-usage/souped-up-bash-prompt.html

Comments welcome but please be kind.  I'm still learning
git, compared to most of you lot :-)

Sitaram

PS: A lot of the color stuff is from
git://github.com/lvv/git-prompt.git
