From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ignoring non-submodule subrepositories
Date: Thu, 27 Sep 2007 12:29:15 -0700
Message-ID: <7vy7eructw.fsf@gitster.siamese.dyndns.org>
References: <20070927170700.GA10250@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:29:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iaz3D-0000QW-1L
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 21:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757605AbXI0T3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 15:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757084AbXI0T3V
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 15:29:21 -0400
Received: from rune.pobox.com ([208.210.124.79]:54170 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756693AbXI0T3V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 15:29:21 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 7A8FE13B12C;
	Thu, 27 Sep 2007 15:29:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A848113B0B9;
	Thu, 27 Sep 2007 15:29:39 -0400 (EDT)
In-Reply-To: <20070927170700.GA10250@lapse.madduck.net> (martin f. krafft's
	message of "Thu, 27 Sep 2007 18:07:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59319>

martin f krafft <madduck@madduck.net> writes:

> I have a repository inside another, and for several reasons, I do
> not want to use git-submodule in this case. My issue is that
> git-status lists the subrepository as untracked.
>
> Of course, I could add it to .gitignore alright, but instead
> I wonder whether it would not make sense to ignore subdirectories
> themselves containing .git/ directories, not explicitly so as to not
> mess with git-submodule, but implicitly.
>
> Thoughts?

I've had a line "/Meta" in my .git/info/excludes ever since I
started to maintain the 'todo' branch (which is managed in an
independent repository situated there, and pushed into the
'todo' branch of git.git), and having to have that line never
bothered me.

While I do not think of a reason offhand not to ignore anything
that has .git/ and is not a subproject, other than that ignoring
might interfere your adding such a separate project as a
subproject.  I know "git add" would countermand the ignore list,
but not listing means it lets you forget.

Thinking about it more, such a separate project is not even
special.  We list untracked files to remind you that you might
want to add them.  Why should a separate project that is not
tracked by us (i.e. a potential superproject) be treated any
differently from other untracked things on the filesystem?

So, my thoughts are moderate "negative" at this point, but
others may have better arguments..
