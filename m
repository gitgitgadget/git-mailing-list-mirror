From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Include rev-list options in git-log manpage.
Date: Fri, 18 Jan 2008 17:37:11 +0100
Message-ID: <4790D5B7.2000508@viscovery.net>
References: <20080117214425.GP29972@genesis.frugalware.org> <7vejcfiop4.fsf@gitster.siamese.dyndns.org> <20080118161714.GS29972@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 17:38:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFuEj-0000VO-6Z
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 17:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761858AbYARQhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 11:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761967AbYARQhS
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 11:37:18 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:20309 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762066AbYARQhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 11:37:16 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JFuDJ-0006Fg-M7; Fri, 18 Jan 2008 17:37:06 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E24AC69F; Fri, 18 Jan 2008 17:37:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080118161714.GS29972@genesis.frugalware.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71036>

Miklos Vajna schrieb:
>  Documentation/git-log.txt          |    6 +-
>  Documentation/git-rev-list.txt     |  358 +-----------------------------------
>  Documentation/rev-list-options.txt |  364 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 367 insertions(+), 361 deletions(-)
>  create mode 100644 Documentation/rev-list-options.txt

Had you used format-patch -C then the patch would have been shorter by
~240 lines. And it would have been immediately obvious that you have put
this inside ifndef::gitlog[] brackets:

> +ifndef::git-log[]
> +--first-parent::
> +	Follow only the first parent commit upon seeing a merge
> +	commit.  This option can give a better overview when
> +	viewing the evolution of a particular topic branch,
> +	because merges into a topic branch tend to be only about
> +	adjusting to updated upstream from time to time, and
> +	this option allows you to ignore the individual commits
> +	brought in to your history by such a merge.
> +endif::git-log[]

I wonder why these brackets are necessary. This text applies to git-log,
too, no? Can't you just remove that paragraph from git-log.txt?

-- Hannes
