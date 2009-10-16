From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH RFC] git describe without refs distinguishes dirty
	working tree
Date: Fri, 16 Oct 2009 10:39:02 -0700
Message-ID: <20091016173902.GT10505@spearce.org>
References: <dffdbd190910160812h6d6a876el8261a622b5439b30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jean Privat <jean@pryen.org>
X-From: git-owner@vger.kernel.org Fri Oct 16 19:39:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myqlj-0001Y7-In
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 19:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbZJPRi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 13:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbZJPRi6
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 13:38:58 -0400
Received: from george.spearce.org ([209.20.77.23]:37952 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbZJPRi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 13:38:58 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C2233381FE; Fri, 16 Oct 2009 17:39:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <dffdbd190910160812h6d6a876el8261a622b5439b30@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130515>

Jean Privat <jean@pryen.org> wrote:
> git describe without refs still works on HEAD but append "-dirty" if the
> working three is dirty. If the working tree is clean, nothing is appended.
> 
> Previous behavior can be achieved by specifying "HEAD".
> 
> Many build scripts use `git describe` to produce a version number.
> However, additional git commands are required to distinguish builds done
> with a clean tree from builds done with a dirty tree.
> This patch helps the writing of these scripts since `git describe` do
> the intended thing.
> 
> This new behavior could affect existing scripts by producing version
> number like v1.0.4-14-g2414721-dirty-dirty.
> These scripts could be easily fixed by explicitly using HEAD when calling
> `git describe` and works with any version of git.
> 
> Signed-off-by: Jean Privat <jean@pryen.org>

Yea, I think this is reasonable and sane thing to do.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> Note that documentation of `git describe` did not mentioned the behavior
> of the command when no committish is specified.
> However, since it is still a behavior change. If the patch is accepted,
> it could target version 1.7.

Yea, 1.7 may be safer for this, but also many scripts are based
on the GIT-VERSION-GEN in git.git which uses HEAD as an explicit
argument.  So they might actually be OK with this change.

-- 
Shawn.
