From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [BUG?] git rebase not accepting :/ syntax
Date: Fri, 07 Sep 2012 15:54:49 +0200
Message-ID: <m2ipbqx7iu.fsf@igel.home>
References: <20120907150803.0ae2b186@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Fri Sep 07 15:55:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9z1Q-0005wv-GE
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 15:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759387Ab2IGNyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 09:54:53 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:53879 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295Ab2IGNyw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 09:54:52 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XD0Wt5BSPz4KK7b;
	Fri,  7 Sep 2012 15:54:50 +0200 (CEST)
X-Auth-Info: 7cb/8FFrDh/dnDF8kZ+iQCkrdmqeppU6YBguvyaq4B0=
Received: from igel.home (ppp-88-217-117-28.dynamic.mnet-online.de [88.217.117.28])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XD0Wt4b5DzbbfR;
	Fri,  7 Sep 2012 15:54:50 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id E9F50CA2A4; Fri,  7 Sep 2012 15:54:49 +0200 (CEST)
X-Yow: I hope something GOOD came in the mail today so I have
 a REASON to live!!
In-Reply-To: <20120907150803.0ae2b186@chalon.bertin.fr> (Yann Dirson's message
	of "Fri, 07 Sep 2012 15:08:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204969>

Yann Dirson <dirson@bertin.fr> writes:

> In 1.7.10.3, "git rebase -i :/Merge" will complain with:
>
> fatal: Needed a single revision
> invalid upstream :/Merge
>
> ... whereas "git rev-parse :/Merge" has no problem resolving
> to a single revision.

git rebase actually calls "git rev-parse :/Merge^0", which due to the
unlimited nature of :/ doesn't work.

> OTOH, "git rebase -i HEAD^{/Merge}" does work, and rev-parse resolves
> it to the same commit.

OTOH, "git rev-parse HEAD^{/Merge}^0" works as expected.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
