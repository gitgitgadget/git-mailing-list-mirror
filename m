From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Sun, 11 Dec 2011 20:00:05 +0100
Message-ID: <m2hb176iiy.fsf@igel.home>
References: <jbvj5o$skt$1@dough.gmane.org>
	<20111211022218.GA22749@sita-lt.atc.tcs.com>
	<jc2l2a$som$1@dough.gmane.org> <m3ehwbge8f.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Gelonida N <gelonida@gmail.com>, git@vger.kernel.org,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 11 20:00:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZodD-0005xm-66
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 20:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab1LKTAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Dec 2011 14:00:11 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:46151 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab1LKTAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2011 14:00:09 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id C5AC71C0C169;
	Sun, 11 Dec 2011 20:00:06 +0100 (CET)
X-Auth-Info: w6+3u0ARfNKe6fbW9OB6J46dH58V+jt2wq3UX2WG5qk=
Received: from igel.home (ppp-88-217-99-15.dynamic.mnet-online.de [88.217.99.15])
	by mail.mnet-online.de (Postfix) with ESMTPA id B613C1C001AE;
	Sun, 11 Dec 2011 20:00:06 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 0EF3ACA29C; Sun, 11 Dec 2011 20:00:05 +0100 (CET)
X-Yow: I once decorated my apartment entirely in ten foot salad forks!!
In-Reply-To: <m3ehwbge8f.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Sun, 11 Dec 2011 10:22:42 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186808>

Jakub Narebski <jnareb@gmail.com> writes:

> Something like
>
>   git for-each-ref '--format=%(refname) %(upstream)' |
>   while read refname upstream
>   do
>   	# there is upstream
>   	test -n "$upstream" || break
>   	# and if fast-forwards
>   	test $(git merge-base $refname $upstream) = $(git rev-parse $refname) || break
>   	git update-ref -m "$message" $refname $upstream
>   done

You probably meant s/break/continue/.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
