From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.8.2
Date: Wed, 28 Dec 2011 14:31:35 -0800
Message-ID: <7vd3b8z5tk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 23:31:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rg22B-0007Hh-Hr
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 23:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab1L1Wbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 17:31:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624Ab1L1Wbh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 17:31:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5117F6A52;
	Wed, 28 Dec 2011 17:31:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=bEJuCH7fc59Q4VeEGKzL6GoodMA=; b=owVKiUnO+EE/fl22azyGJPXiqHyD
	PsDpohsuSS7eCPFLsnvAm5QQr9FnozRnKIJvo9ad1PImugkbdOZCQp4aPqJh8FD2
	7iKKyPJQ4UQCm3XtNb6q+JCAR/vYRg0c/kL9+bwW2ZSGNw7xyPkZGNLIhzhg92Op
	FtiIWMkrSrCs4ks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	Ev3UOAE7C14zkfPNvlLF2T8Ff+r4Imfq1mfCdsup6WJsaU5S+NoIzbzxLcYOS7kf
	+SfFUS2unZ1ZgOwDsiRWTQy0ycrS/NPj8FwgKGBxytmR+qBtDk0hgOY2fyA97++l
	jz8BI85T+Xb/+5EJV8zkh+ifkfGP660aorWU1rWFYE4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4946C6A51;
	Wed, 28 Dec 2011 17:31:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A10846A4E; Wed, 28 Dec 2011
 17:31:36 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B3F914F4-31A3-11E1-B182-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187765>

The latest maintenance release Git 1.7.8.2 is available. It contains
accumulated fixes that applies to the 1.7.8.X maintenance track that have
already been applied to the 'master' branch to be part of the upcoming
1.7.9 release.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

7187c1af96db0c181b801957d6e152ec7cd60ab6  git-1.7.8.2.tar.gz
9047175e5c46aa3260c42e6b4459cf4ee5a7bb8a  git-htmldocs-1.7.8.2.tar.gz
cc394a0a9689297fddad40c1ccbded0ba9d708da  git-manpages-1.7.8.2.tar.gz

Also the following public repositories all have a copy of the v1.7.8.2
tag and the maint branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git


Git v1.7.8.2 Release Notes
==========================

Fixes since v1.7.8.1
--------------------

 * Porcelain commands like "git reset" did not distinguish deletions
   and type-changes from ordinary modification, and reported them with
   the same 'M' moniker. They now use 'D' (for deletion) and 'T' (for
   type-change) to match "git status -s" and "git diff --name-status".

 * The configuration file parser used for sizes (e.g. bigFileThreshold)
   did not correctly interpret 'g' suffix.

 * The replacement implemention for snprintf used on platforms with
   native snprintf that is broken did not use va_copy correctly.

 * LF-to-CRLF streaming filter replaced all LF with CRLF, which might
   be techinically correct but not friendly to people who are trying
   to recover from earlier mistakes of using CRLF in the repository
   data in the first place. It now refrains from doing so for LF that
   follows a CR.

 * git native connection going over TCP (not over SSH) did not set
   SO_KEEPALIVE option which failed to receive link layer errors.

 * "git branch -m <current branch> HEAD" is an obvious no-op but was not
   allowed.

 * "git checkout -m" did not recreate the conflicted state in a "both
   sides added, without any common ancestor version" conflict
   situation.

 * "git cherry-pick $commit" (not a range) created an unnecessary
   sequencer state and interfered with valid workflow to use the
   command during a session to cherry-pick multiple commits.

 * You could make "git commit" segfault by giving the "--no-message"
   option.

 * "fast-import" did not correctly update an existing notes tree,
   possibly corrupting the fan-out.

 * "git fetch-pack" accepted unqualified refs that do not begin with
   refs/ by mistake and compensated it by matching the refspec with
   tail-match, which was doubly wrong. This broke fetching from a
   repository with a funny named ref "refs/foo/refs/heads/master" and a
   'master' branch with "git fetch-pack refs/heads/master", as the
   command incorrectly considered the former a "match".

 * "git log --follow" did not honor the rename threshold score given
   with the -M option (e.g. "-M50%").

 * "git mv" gave suboptimal error/warning messages when it overwrites
   target files. It also did not pay attention to "-v" option.

 * Authenticated "git push" over dumb HTTP were broken with a recent
   change and failed without asking for password when username is
   given.

 * "git push" to an empty repository over HTTP were broken with a
   recent change to the ref handling.

 * "git push -v" forgot how to be verbose by mistake. It now properly
   becomes verbose when asked to.

 * When a "reword" action in "git rebase -i" failed to run "commit --amend",
   we did not give the control back to the user to resolve the situation, and
   instead kept the original commit log message.

Also contains minor fixes and documentation updates.
