From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Conflicting "-n" short options for git-pull?
Date: Sat, 15 Sep 2007 16:39:45 -0700
Message-ID: <7vfy1f8pmm.fsf@gitster.siamese.dyndns.org>
References: <200709152114.54985.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Sun Sep 16 01:39:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWhEx-0008UV-IL
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 01:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbXIOXjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 19:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753295AbXIOXjw
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 19:39:52 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:35684 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbXIOXjv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 19:39:51 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2B591135B4A;
	Sat, 15 Sep 2007 19:40:09 -0400 (EDT)
In-Reply-To: <200709152114.54985.elendil@planet.nl> (Frans Pop's message of
	"Sat, 15 Sep 2007 21:14:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58281>

Frans Pop <elendil@planet.nl> writes:

> According to the man page for git-pull from git-core 1.5.3.1 (Debian 
> package), two options are defined as having the short option "-n":
>
>      -n, --no-summary
>          Do not show diffstat at the end of the merge.
> [...]
>      -n, --no-tags
>          By default, git-fetch fetches tags that point at objects that are
>          downloaded from the remote repository and stores them locally. This
>          option disables this automatic tag following.

The manpage option descriptions are shared between the
commands.  Maybe we should drop mention of the shorthand form.

When git-fetch is used -n means --no-tags because there is no
other -n; when git-pull indirectly invokes git-fetch, you need
to spell it --no-tags because --no-summary takes precedence.
