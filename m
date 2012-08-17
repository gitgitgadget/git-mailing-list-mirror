From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Git feature request: --amend older commit
Date: Fri, 17 Aug 2012 18:37:13 +0200
Message-ID: <87628heapy.fsf@thomas.inf.ethz.ch>
References: <20120817154749.11762.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 18:37:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2PY4-0000AC-GG
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 18:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758473Ab2HQQhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 12:37:19 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:11980 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758469Ab2HQQhR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 12:37:17 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 17 Aug
 2012 18:37:10 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 17 Aug
 2012 18:37:14 +0200
In-Reply-To: <20120817154749.11762.qmail@science.horizon.com> (George
	Spelvin's message of "17 Aug 2012 11:47:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203620>

"George Spelvin" <linux@horizon.com> writes:

> With git's "commit frequently" style, I often find that I end up with a
> commit that includes a typo in a comment or I forgot one call site when
> updating functions or something.
[...]
> But it would be really handy if there were a one-step command for doing this.
>
> Something like "git commit --fixup HEAD~3", where "git commit --fixup HEAD"
> would be equivalent to "git commit --amend".

Umm, --fixup is already taken and makes the subject be 'fixup! <subject
of argument>'.  This can then be used by rebase -i --autosquash (or
rebase.autosquash=true) to automatically put the fixup(s) that have
accumulated into the right places.  In addition, git-rebase learned to
automatically use the upstream as the default base.

So for me it's usually a matter of

  git add -p
  git commit --fixup=...
  # repeat the above two until all fixups are lined up
  git rebase -i
  # close editor without making changes

Is that still too much effort?


<plug mode=shameless>

The ideas discussed in
  http://thread.gmane.org/gmane.comp.version-control.git/202535/focus=202569
also help selecting the fixup argument more quickly.

</plug>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
