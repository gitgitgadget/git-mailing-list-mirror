From: Junio C Hamano <junkio@cox.net>
Subject: Re: when is "git diff" output suitable for patch?
Date: Thu, 13 Jul 2006 14:27:33 -0700
Message-ID: <7vhd1lurei.fsf@assigned-by-dhcp.cox.net>
References: <20060713212127.GA30770@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 23:27:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G18iz-0006qD-D9
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 23:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbWGMV1g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 17:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWGMV1g
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 17:27:36 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:62339 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030402AbWGMV1f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 17:27:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060713212734.XLVS12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Jul 2006 17:27:34 -0400
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060713212127.GA30770@fieldses.org> (J. Bruce Fields's message
	of "Thu, 13 Jul 2006 17:21:27 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23852>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> I assume the -C and -M, -c, and -cc options all result in diff output
> that can't be correctly applied by "patch" any more?  (Would a patch to
> the git-diff-files documentation warning about this be helpful?)

May not be bad to have, except that I do not know if
"git-diff-files" documentation is the right place to talk about
it.

> Someone I'm working with is having trouble applying patches that they
> created with a simple "git diff".  The patches in question have some
> "copy from/copy to" headers.  Should that every happen with just a plain
> "git diff"?  Is this a bug in their version of git?  (They're on 1.2.4).

As far as I recall "git diff" never defaulted to -M.  These days
you can have diff.renames = true in the configuration to make it
so, but and I do not think there was any way to do that back in
1.2.4.

If _they_ created the diff with git, and if that is the same
_they_ who are having trouble applying, maybe you can suggest to
use "git apply" instead of "patch -p1"?
