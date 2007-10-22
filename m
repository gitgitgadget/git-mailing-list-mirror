From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Let users override name of per-directory ignore file
Date: Mon, 22 Oct 2007 12:50:29 +0200
Message-ID: <20071022105029.GB31862@diana.vm.bytemark.co.uk>
References: <20071021144542.8855A5BB85@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 22 12:51:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjusH-0003wx-Bp
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 12:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbXJVKu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2007 06:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbXJVKu4
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 06:50:56 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3607 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbXJVKuz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 06:50:55 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ijure-0008OW-00; Mon, 22 Oct 2007 11:50:30 +0100
Content-Disposition: inline
In-Reply-To: <20071021144542.8855A5BB85@nox.op5.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61984>

On 2007-10-15 14:09:32 +0200, Andreas Ericsson wrote:

> When collaborating with projects managed by some other scm, it often
> makes sense to have git read that other scm's ignore-files. This
> patch lets git do just that, if the user only tells it the name of
> the per-directory ignore file by specifying the newly introduced git
> config option 'core.ignorefile'.

> +	For example, setting core.ignorefile to .svnignore in
> +	repos where one interacts with the upstream project repo
> +	using gitlink:git-svn[1] will make a both SVN users and
> +	your own repo ignore the same files.

> +   The name of the `.gitignore` file can be changed by setting
> +   the configuration variable 'core.ignorefile'. This is useful
> +   when using git for projects where upstream is using some other
> +   SCM. For example, setting 'core.ignorefile' to `.cvsignore`
> +   will make git ignore the same files CVS would.

I agree with what you're trying to do, but you're ignoring the fact
that Subversion's ignore patterns (and possibly cvs's too -- I haven't
checked) are not recursive, while the patterns in .gitignore are
recursive per default. So using ignore patterns directly from
Subversion ignores more files under git than the same patterns did
under Subversion.

One possible way to solve that would be to optionally have
non-recursive per-directory ignore files. I haven't looked at how this
is implemented, though, so I don't know if it's a good suggestion or
not.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
