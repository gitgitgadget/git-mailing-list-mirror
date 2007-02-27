From: Junio C Hamano <junkio@cox.net>
Subject: Worrisome bug trend
Date: Tue, 27 Feb 2007 04:31:41 -0800
Message-ID: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 13:31:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM1Uk-0007rh-Rz
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 13:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbXB0Mbo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 07:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933075AbXB0Mbn
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 07:31:43 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:38617 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbXB0Mbn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 07:31:43 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227123143.IGBK3546.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 07:31:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UcXi1W0051kojtg0000000; Tue, 27 Feb 2007 07:31:42 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40718>

I was reviewing the bugs we fixed since v1.5.0 and noticed
almost all of them are ancient ones.  We do have small number of
bugs introduced by recently added commands and options, but I
see quite a few that are from 2005.

I take that as a sign that git hasn't been exercised well and
yet more ancient bugs are sleeping, waiting to be triggered, not
as a sign that we are very careful and adding only small number
of risky new code in the releases.

Which is kind of depressing...

The following table shows each bug fixed since v1.5.0, and the
commit that introduced the bug.  Many bugs are attributed to the
first commit that introduced the feature.

20276889 (daemon socksetup() does not set FD_CLOEXEC)
	a87e8be2 Jul 13 2005

de6f0def (no-trivial-merge)
	6ea23343 Mar 18 2006

f4421325 (blame with missing parameter)
	cee7f245 Oct 19 2006

185c975f (trust_executable_bit not trusting too much)
	3e09cdfd Oct 11 2005

256c3fe6 (rev-list commit encoding)
	52883fbd Dec 25 2006

75b62b48 (combine-diff broken cast)
	e702496e Aug 23 2006 (memcpy->hashcpy)
	funny thing is that another similar cast is correct.

8ab40a20 (show-ref --verify)
	26cdd1e7 Dec 17 2006

c06d2daa (format-patch filename length)
	0acfc972 Jul  5 2005

50892777 (diff --git a//etc/inittab)
	65056021 Apr 28 2006 (first built-in diff)

ab242f80 rerere (find_conflict skips adjacent)
	658f3650 Dec 20 2006 (inception, C rewrite)

12891727 rerere (find_conflict uses symlinks)
	658f3650 Dec 20 2006 (inception, C rewrite)
	8389b52b Jan 28 2006 (original Perl version)

ffa84ffb (pack-object fixed arglen)
	8d1d8f83 Sep 06 2006 

308efc10 (merge-index symlink handling)
	54dd99a1 Dec 02 2005

17cd29b2 (merge-recursive symlink handling)
	3af244ca Jul 27 2006

4fc970c4 (diff --cc symlink while merging)
	ea726d02 Jan 28 2006 (teach --cc to diff-files)

4e5104c1 (git-remote command did not like dots in name)
	e194cd1e Jan 03 2007

34fc5cef (mailinfo choke with too long a line)
	c5f7674a Jul 16 2005 (inception)

ee24ee55 (diff --cc int vs size_t)
	4fc970c4 Feb 25 2007

63e50d49 (apply fixes whitespace errors of context lines)
	d0c25035 Sep 23 2006 (inception of feature)
