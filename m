From: John Keeping <john@keeping.me.uk>
Subject: Re: Adding a commit to the front of my branch?
Date: Mon, 11 Jan 2016 14:16:12 +0000
Message-ID: <20160111141612.GK14056@serenity.lan>
References: <CAHd499B8gRMVWnUBZ0aO2RtokYqTm6fO7+7zfbsJNTnKw4MVsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 15:16:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIdGo-0006Xh-Fy
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 15:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933624AbcAKOQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 09:16:25 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:45643 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933184AbcAKOQW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 09:16:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id CEFA2CDA5A9;
	Mon, 11 Jan 2016 14:16:20 +0000 (GMT)
X-Quarantine-ID: <l9AriUBvP0sS>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l9AriUBvP0sS; Mon, 11 Jan 2016 14:16:19 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id A6AD7CDA59A;
	Mon, 11 Jan 2016 14:16:14 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAHd499B8gRMVWnUBZ0aO2RtokYqTm6fO7+7zfbsJNTnKw4MVsQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283651>

On Mon, Jan 11, 2016 at 07:36:25AM -0600, Robert Dailey wrote:
> Normally to add commits on my branch, I perform an interactive rebase:
> 
> $ git rebase -i origin/master
> 
> I mark the commit I want to put the new commit on top of as 'edit'.
> However, if I want to add a commit to the front of my branch, I don't
> really have a commit to mark as "edit". I tried to be tricky with
> this, and did:
> 
> $ git rebase -i origin/master^
> 
> However this doesn't work if my merge-base is a merge commit. I get a
> ton of superfluous commits in my TODO file.
> 
> Is there a built-in mechanism I can use, with relative ease, to
> accomplish this goal? At the moment I have to run a series of a couple
> of commands to do this, namely mark the oldest commit on my branch as
> 'edit', reset it, stash it, add new commit, pop stash, commit again,
> etc.
> 
> Normally I'd add a new tip commit and reorder it to accomplish this,
> however commits on my branch already alter this code and I don't want
> to create unnecessary conflicts during rebase. The patch needs to be
> based on merge-base.

Have you considered creating a new (temporary) branch based on master,
adding the new commit there and inserting "pick $new_commit_sha1" at the
start of the instruction sheet when rebasing the original branch?
