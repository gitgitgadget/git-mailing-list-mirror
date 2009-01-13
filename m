From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: how to combine 2 commits?
Date: Tue, 13 Jan 2009 06:35:11 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngmodgv.ple.sitaramc@sitaramc.homelinux.net>
References: <20090113045422.GA6940@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 07:36:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMctK-0001w6-9i
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 07:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbZAMGfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 01:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbZAMGfW
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 01:35:22 -0500
Received: from main.gmane.org ([80.91.229.2]:55269 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbZAMGfV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 01:35:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LMcrv-0004y5-Nh
	for git@vger.kernel.org; Tue, 13 Jan 2009 06:35:19 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 06:35:19 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 06:35:19 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105460>

On 2009-01-13, bill lam <cbill.lam@gmail.com> wrote:
> Sorry I don't know the correct git terminology for it.  I make some
> changes to scripts but also accidentally changed all scripts to use
> dos linefeed.  Failed to notice this and commit all changes. Then I
> tried to correct it by changing all scripts back to unix
> linefeed and commit again.
>
> How to combine these 2 commits so that the changes of linefeed cancel
> out each other and the history only shows the intended changes of the
> few scripts.

I tend to make lots of small commits on the work tree, and
having to combine them meaningfully later.

I like using "git rebase -i HEAD~5" (if I want to rebase the
last 5 commits).  In the editor that pops up, I reorder the
ones that I know should be together, and on each set to be
squashed, I change the "pick" to "s" (for squash) on all but
the first one.  Save the file and it's all done.

Works like a charm.  For me, moving commits around in an
editor, deleting them even, is very intuitive.
