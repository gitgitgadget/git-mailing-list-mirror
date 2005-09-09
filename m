From: Junio C Hamano <junkio@cox.net>
Subject: Post 0.99.7 preperation patches
Date: Fri, 09 Sep 2005 02:20:53 -0700
Message-ID: <7virxalhqi.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net>
	<7virxbtder.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 11:21:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDf47-0000rT-GD
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 11:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbVIIJU4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Sep 2005 05:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbVIIJU4
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Sep 2005 05:20:56 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:33488 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965117AbVIIJUz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2005 05:20:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050909092054.PZLR11315.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Sep 2005 05:20:54 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Petr Baudis <pasky@suse.cz>
In-Reply-To: <7virxbtder.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 08 Sep 2005 15:14:52 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8236>

Junio C Hamano <junkio@cox.net> writes:

> The "master" branch post 0.99.6 already has the renamed tools
> with backward compatibility symlinks.  I'll be sending a
> patch to address an issue raised by some people separately to
> see what the list thinks, and also will attempt to send out a
> patch for the Pasky and Catalin heads later this week.

I've prepared these and will be sending them out separately to
you two, hoping they would help you prepare for post 0.99.7
changes.  Note that 0.99.6 does not know about these new names,
the current "master" branch knows about both new and old names,
so will 0.99.7, and in 0.99.8 the old names will be removed, if
things go as planned.

Here is a small script that I used before auditing what it did
to your trees by running 'git diff' on its result.

------------
#!/bin/sh
git-ls-files |
xargs perl -i -p -e '
	s/git-merge-one-file-script/git-merge-one-file/g;
	s/git-count-objects-script/git-count-objects/g;
	s/git-format-patch-script/git-format-patch/g;
	s/git-parse-remote-script/git-parse-remote/g;
	s/git-request-pull-script/git-request-pull/g;
	s/git-cherry-pick-script/git-cherry-pick/g;
	s/git-archimport-script/git-archimport/g;
	s/git-send-email-script/git-send-email/g;
	s/git-verify-tag-script/git-verify-tag/g;
	s/git-cvsimport-script/git-cvsimport/g;
	s/git-ls-remote-script/git-ls-remote/g;
	s/git-checkout-script/git-checkout/g;
	s/git-sh-setup-script/git-sh-setup/g;
	s/git-octopus-script/git-octopus/g;
	s/git-resolve-script/git-resolve/g;
	s/git-checkout-cache/git-checkout-index/g;
	s/git-bisect-script/git-bisect/g;
	s/git-branch-script/git-branch/g;
	s/git-commit-script/git-commit/g;
	s/git-rebase-script/git-rebase/g;
	s/git-relink-script/git-relink/g;
	s/git-rename-script/git-rename/g;
	s/git-repack-script/git-repack/g;
	s/git-revert-script/git-revert/g;
	s/git-status-script/git-status/g;
	s/git-convert-cache/git-convert-objects/g;
	s/git-clone-script/git-clone/g;
	s/git-fetch-script/git-fetch/g;
	s/git-prune-script/git-prune/g;
	s/git-reset-script/git-reset/g;
	s/git-update-cache/git-update-index/g;
	s/git-diff-script/git-diff/g;
	s/git-pull-script/git-pull/g;
	s/git-push-script/git-push/g;
	s/git-merge-cache/git-merge-index/g;
	s/git-add-script/git-add/g;
	s/git-log-script/git-log/g;
	s/git-tag-script/git-tag/g;
	s/git-local-pull/git-local-fetch/g;
	s/git-diff-cache/git-diff-index/g;
	s/git-fsck-cache/git-fsck-objects/g;
	s/git-http-pull/git-http-fetch/g;
	s/git-ssh-pull/git-ssh-fetch/g;
	s/git-ssh-push/git-ssh-upload/g;
'
git-update-cache --refresh
