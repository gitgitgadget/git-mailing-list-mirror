From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Include rev-list options in git-log manpage.
Date: Thu, 17 Jan 2008 23:21:27 -0800
Message-ID: <7vejcfiop4.fsf@gitster.siamese.dyndns.org>
References: <20080117214425.GP29972@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 08:22:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFlYa-0007iI-Qz
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 08:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbYARHVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 02:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbYARHVl
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 02:21:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbYARHVk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 02:21:40 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F09F1CB0;
	Fri, 18 Jan 2008 02:21:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D58D1CAB;
	Fri, 18 Jan 2008 02:21:36 -0500 (EST)
In-Reply-To: <20080117214425.GP29972@genesis.frugalware.org> (Miklos Vajna's
	message of "Thu, 17 Jan 2008 22:44:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70969>

Miklos Vajna <vmiklos@frugalware.org> writes:

> It seems that all the git-rev-list options (--grep, --author, etc) were missing
> from the git-log manpage. This can be quite problematic if one does not know
> that git-log accepts the options of git-rev-list.
>
> So move these options to a separate file and include it from both
> git-rev-list.txt and git-log.txt.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> Noticed by tsuna on IRC. I hope this is okay for 1.5.4.

Have you generated documentation with and without patch and run
diff between them?

There is an obvious duplicated inclusion of pretty-options.txt[]
in git-log.{1,html}.

In addition, this part

> -Commit Formatting
> -~~~~~~~~~~~~~~~~~
> -
> -Using these options, linkgit:git-rev-list[1] will act similar to the
> -more specialized family of commit log tools: linkgit:git-log[1],
> -linkgit:git-show[1], and linkgit:git-whatchanged[1]

is _clearly_ written for git-rev-list and unsuitable for any of
the commands listed above.

git-log manual page has been saying that "This manual page
describes only the most frequently used options."  I would agree
that it is a laudable goal to replace that sentence with an
included common source text, but there needs to be a bit more
careful copyediting than your a patch.
