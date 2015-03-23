From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: [PATCH] clone: Warn if clone lacks LICENSE or COPYING file
Date: Mon, 23 Mar 2015 12:46:48 -0400 (EDT)
Message-ID: <E1Ya5V2-0001bT-QE@rmm6prod02.runbox.com>
References: <xmqqoanld3v1.fsf@gitster.dls.corp.google.com>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "stefanbeller" <stefanbeller@gmail.com>,
	"dennis" <dennis@kaarsemaker.net>, "gitster" <gitster@pobox.com>
To: "git" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 17:47:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya5VA-0004HQ-My
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 17:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbbCWQqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 12:46:52 -0400
Received: from aibo.runbox.com ([91.220.196.211]:38647 "EHLO aibo.runbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbbCWQqv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2015 12:46:51 -0400
Received: from [10.9.9.241] (helo=rmm6prod02.runbox.com)
	by bars.runbox.com with esmtp (Exim 4.71)
	(envelope-from <dwheeler@dwheeler.com>)
	id 1Ya5V2-0003Bc-Kh; Mon, 23 Mar 2015 17:46:49 +0100
Received: from mail by rmm6prod02.runbox.com with local (Exim 4.76)
	(envelope-from <dwheeler@dwheeler.com>)
	id 1Ya5V2-0001bT-QE; Mon, 23 Mar 2015 17:46:48 +0100
Content-Disposition: inline
Received: from [Authenticated user (258406)] by secure.runbox.com with
 http (RMM6); Mon, 23 Mar 2015 16:46:48 GMT
X-Mailer: RMM6
In-Reply-To: <xmqqoanld3v1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266147>

Junio C Hamano:
>    An open source hosting site can help better by checking at the
>   project creation time, because the people who interact with that
>    interface are solely in the position to set and publish licensing terms.

That doesn't help with the many projects that have *already* been created.
E.G., GitHub has a license chooser now, but didn't for years, and it's still optional.
Also, repos stored as shared filesystems don't do that kind of checking.

More importantly, focusing on the "hosting site" doesn't warn people
who *clone* from repos. The people who take on legal risks are often not
the posters, but the people who clone *from* the sites.  Thus, *they* are the
ones who need the warning, and git is in an especially good spot to detect the issue.


>     The general consumer who are cloning and fetching do not
>    have direct control over this, and the only thing the could do to
>     nudge the publishers is with an out-of-line communication...

That's an option, but another option is to NOT use it. Often
people have no idea there's an issue, and in their rush and lack of warning
they forget to check the basics.


>    An approach that checks only the top-level directory for fixed
>    filename pattern would not be an effective way to protect the
>    cloners, either.

I disagree, I think it's remarkably effective. *Many* projects
do this, including git itself. After all, many humans need to find out the licensing
basics too; having a simple convention for *finding* it helps humans and tools alike.
It's not even limited to open source software; developers of proprietary materials
(software or now) *also* typically want to declare licensing.

Sure, the top-level licensing text might be incomplete, but having that information
provides a big help, and it's what most people rely on anyway. Indeed, a *lack*
of this is a sign of trouble, which is exactly what warnings are good for.

--- David A. Wheeler

(P.S. I posted this previously but it seems to have failed for some reason,
so I'm resending this in a different way.)
