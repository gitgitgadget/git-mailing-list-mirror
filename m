From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git svn: don't introduce new paragraph for git-svn-id
Date: Tue, 21 Aug 2012 21:45:38 +0000
Message-ID: <20120821214538.GA4879@dcvr.yhbt.net>
References: <1343856197-6393-1-git-send-email-robert@debian.org>
 <20120801214318.GA10384@dcvr.yhbt.net>
 <5019AD3A.8030609@debian.org>
 <20120801230118.GA15479@dcvr.yhbt.net>
 <50315ED1.6080803@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Luberda <robert@debian.org>
X-From: git-owner@vger.kernel.org Tue Aug 21 23:45:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3wGf-0004Oz-Gm
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 23:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758650Ab2HUVpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 17:45:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40506 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758482Ab2HUVpi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 17:45:38 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 901413EA2C;
	Tue, 21 Aug 2012 21:45:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <50315ED1.6080803@debian.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203993>

Robert Luberda <robert@debian.org> wrote:
> I have been quite a busy recently, so it took me longer that I thought.

No worries, thanks for following up.

> It was quite hard for me to think some sensible option name, and finally
> have chosen --trim-svn-log (svn.trimsvnlog as config key name). Please
> let me know if such name is ok for you. If not, I'll try to find a
> different one (but as I wrote I'm not really good at giving names to
> options/functions/variables, etc. :()

I think having "svn" in "svn.trimsvnlog" twice is redundant and not ideal.
Perhaps just --trim-log and svn.trimlog?

> I considered making the option a default one for new git svn clones, so
> that existing repositories would use the older approach, but I gave up
> the idea, and implemented the simpler solution, in which the option must
> be given explicitly if one needs the new behavior. If making it a
> default for new clones would make sense for you, I can try to implement
> this as well.

Default behavior should not change, especially not without warning.

> For consistency, the `--add-author-from' option was modified not to add
> an extra new line before 'From: ' line when the newly introduced option
> is in effect.

OK.

> I'm sending a new patch in next e-mail, could you please look at it and
> share any comments you might have? One thing I was not sure about is the
> requirement, introduced in the change, of having a whitespace character
> after a colon in pseudo-header lines
> (e.g. `From:somebody <somebody@somewhere.com>' won't be considered as a
> pseudo-header) - is this consistent with a way git handles
> headers/pseudo-headers?

Both git-send-email and git-am check for space after these headers,
so git-svn should, too
