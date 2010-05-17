From: Giuseppe Scrivano <gscrivano@gnu.org>
Subject: Re: [RFC][PATCH] Print the usage string on stdout instead of stderr.
Date: Mon, 17 May 2010 14:40:43 +0200
Message-ID: <87vdamu2es.fsf@thor.thematica.it>
References: <878w7ieu4p.fsf@thor.thematica.it>
	<4BF12C96.9030802@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 17 14:40:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODzcU-0000X4-3q
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 14:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298Ab0EQMjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 08:39:51 -0400
Received: from chapters.gnu.org ([91.121.9.110]:39109 "EHLO chapters.gnu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752747Ab0EQMju (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 08:39:50 -0400
Received: by chapters.gnu.org (Postfix, from userid 111)
	id A4DF646C086; Mon, 17 May 2010 14:39:50 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on chapters.gnu.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
X-Spam-Level-GNUchapters: 
Received: from thor.thematica.it (localhost.localdomain [127.0.0.1])
	by chapters.gnu.org (Postfix) with ESMTP id 2044446C070;
	Mon, 17 May 2010 14:39:50 +0200 (CEST)
In-Reply-To: <4BF12C96.9030802@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 17 May 2010 13:46:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147231>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> More importantly, callers expect error messages on stderr, such as usage
> with wrong arguments. I don't think scripts would call commands with
> '-h', and if they do they do so on purpose and can parse stderr, knowing
> there is no stdout in this case.

It looks like a workaround to me.  Anyway, if -h is left unchanged then,
I think, --help should be adjusted as well when it doesn't use an
external pager.

These two commands behave differently:

git status --help 2>/dev/null | cat -
git status -h 2>/dev/null | cat -

IMO, what should be changed is -h to be uniform with --help, as the it
is the expected output, not an error.

Cheers,
Giuseppe
