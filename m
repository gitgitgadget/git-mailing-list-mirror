From: Marc Branchaud <marcnarc@xiplink.com>
Subject: "remote-tracking branch"?
Date: Mon, 11 Jun 2012 10:54:05 -0400
Message-ID: <4FD6068D.1010509@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 16:54:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se60o-0006yZ-6j
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 16:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab2FKOya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 10:54:30 -0400
Received: from smtp142.dfw.emailsrvr.com ([67.192.241.142]:39759 "EHLO
	smtp142.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab2FKOy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 10:54:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp4.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id EAF513A0A41
	for <git@vger.kernel.org>; Mon, 11 Jun 2012 10:54:28 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp154.ord.emailsrvr.com (smtp154.ord.emailsrvr.com [173.203.6.154])
	by smtp4.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id AC5DB3A090F
	for <git@vger.kernel.org>; Mon, 11 Jun 2012 10:54:28 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp24.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 4E2011980F2;
	Mon, 11 Jun 2012 10:53:57 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp24.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id F06E31980B0;
	Mon, 11 Jun 2012 10:53:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199654>

On 12-06-11 06:04 AM, Lucien Kong wrote:
> "git rebase -i" can be very dangerous if used on an already published
> history. This code detects that one is rewriting a commit that is an
> ancestor of a remote-tracking branch, and warns the user through the
> editor. This feature is controlled by a new config key
> rebase.checkremoterefs.

When I first read this I was confused by the term "remote-tracking branch".
I see that the docs for "git remote" and "git branch" use this term for
branches like 'origin/master', as does the glossary.

But to me 'origin/master' is simply a "remote branch".  In my mind, a
"remote-tracking branch" is a local branch with its "remote" and "merge"
config values set.  So if my local config has
	branch.public.remote = origin
	branch.public.merge = refs/heads/master
then my local 'public' branch is a "remote-tracking branch" that tracks the
'master' branch in the 'origin' repository.

I feel my interpretation is reinforced by the --track/--no-track options in
"git branch".

I believe the docs would be clearer if they used the terms "remote branch"
and "remote-tracking branch" in this way.[1]  But before submitting a patch,
I'd like to hear what others think.  Am I maybe missing some other
interpretation of "remote branch"?  Or is there already a term for "a local
branch that tracks a remote branch"?

		M.

[1] I understand that strictly speaking, all branches are local, and a
"remote branch" like 'origin/master' is in fact a local branch named 'master'
in the 'origin' namespace, and that it's really the fetch refspecs in a
remote's configuration that link updates in a remote repository to some local
branches, and there's no requirement that a remote named 'origin' be linked
with the local 'origin' ref namespace, and so on and so on.  I think these
details are important, and should be documented somewhere.  But I also think
"remote branch" is a good shorthand term to refer to all that.
