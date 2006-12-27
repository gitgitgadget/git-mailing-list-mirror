From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFH] An early draft of v1.5.0 release notes
Date: Wed, 27 Dec 2006 11:12:56 +0100
Organization: At home
Message-ID: <emtgps$f1q$1@sea.gmane.org>
References: <7vvejx948y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Dec 27 11:10:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzVkF-00050R-Db
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 11:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbWL0KK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 05:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbWL0KK2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 05:10:28 -0500
Received: from main.gmane.org ([80.91.229.2]:47670 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655AbWL0KK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 05:10:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GzVjk-0002sm-Oh
	for git@vger.kernel.org; Wed, 27 Dec 2006 11:10:17 +0100
Received: from host-81-190-19-121.torun.mm.pl ([81.190.19.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 11:10:16 +0100
Received: from jnareb by host-81-190-19-121.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 11:10:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-121.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35459>

Junio C Hamano wrote:

> This is still rough, but I think we have a pretty good idea what
> will and what won't be in v1.5.0 by now, and end-of-year is a
> good slow time to summarize what we have done.

Very nice idea! Perhaps those release notes can find it's way into
either v1.5.0 commit, or v1.5.0 tag comment?

Just a few comments:

>  - git-add without any argument does not add everything
>    anymore.  Say "git add ." if you want to.
> 
>  - git-add tries to be more friendly to users by offering an
>    interactive mode.

Perhaps information that git-add can be used to add ignored files
with -f option should be added? Or is it not important enough?
 
>  - The commits referred to by reflog entries are now protected
>    against pruning.  The new command "git reflog expire" can be
>    used to truncate older reflog entries and entries that refer
>    to commits that have been pruned away previously.
> 
>    Existing repositories that have been using reflog may get
>    complaints from fsck-objects; please run "git reflog expire
>    --all" first to remove reflog entries that refer to commits
>    that are no longer in the repository before attempting to
>    repack it.

That's a bit bad, as it forces to lose some info... but that
info was not that useful anyway.
 
>  - A commit object recorded in non UTF-8 encoding records the
>    encoding i18n.commitencoding specified in the originating
>    repository in a new "encoding" header.  This information is
>    used by git-log and friends to reencode the message to UTF-8
>    when displaying.

I don't quite like it. Why if someone uses different encoding
that utf-8 because his terminal is not set to utf-8? Having suddenly
what looks like garbage on output, while input was in local encoding
(and specified in i18n.commitencoding) is a bit suprising...
 
> ----------------------------------------------------------------
> (shortlog since v1.4.4.3 here)

I'd rather have description a la "what's cooking" here... 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
