From: Junio C Hamano <junkio@cox.net>
Subject: Re: lost again on syntax change - local repository?
Date: Sun, 27 Nov 2005 21:11:37 -0800
Message-ID: <7v7jat2w6u.fsf@assigned-by-dhcp.cox.net>
References: <861x118r9t.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 06:11:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgbIl-00011R-L3
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 06:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVK1FLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 00:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVK1FLk
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 00:11:40 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:10396 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751235AbVK1FLj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 00:11:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128051033.BQPH17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 00:10:33 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <861x118r9t.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "27 Nov 2005 18:01:18 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12849>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> At this point, I'm where I was before.  And this next step worked,
> although I had to say "origin":
>
>     localhost:..Git/Play/local.git % cg-push
>     WARNING: I guessed the host:path syntax was used and fell back to the git+ssh protocol.
>     WARNING: The host:path syntax is evil because it is implicit. Please just use a URI.
>     ssh: \033]2;[zsh] localhost: No address associated with nodename
>     fatal: unexpected EOF
>
> Uh, say what?  /some/file/foo.git#branch is no longer legal syntax?
> Help!

If it is not absolutely necessary that you need to use Cogito,
IOW, if git barebone Porcelains are good enough for your use,
the following may be adequate.

	$ echo >.git/remotes/origin <<EOF
	URL: /path/to/remote.git/
        Push: master
        Pull: master:origin
        EOF
	$ git push origin

I said "may be" because I do not understand the sequence before
"At this point"; how your local.git is initially set up to
relate to the remoge.git.  I do not see local.git being created
by cloning remote.git.  But modulo that the above should work
fine; I do that as a cheap backup on my local machine.
