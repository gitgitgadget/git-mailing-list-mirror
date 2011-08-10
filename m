From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: About git-diff
Date: Wed, 10 Aug 2011 19:01:49 +0200
Message-ID: <m2hb5pb3pe.fsf@igel.home>
References: <1312941177.17928.YahooMailClassic@web121810.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luiz Ramos <luizzramos@yahoo.com.br>
X-From: git-owner@vger.kernel.org Wed Aug 10 19:02:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrCAJ-0006px-Po
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 19:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177Ab1HJRBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 13:01:53 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:55403 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139Ab1HJRBw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 13:01:52 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id DAED81C01CE2;
	Wed, 10 Aug 2011 19:01:50 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 9F5DF1C0004E;
	Wed, 10 Aug 2011 19:01:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id hVCP-3TgMTOF; Wed, 10 Aug 2011 19:01:50 +0200 (CEST)
Received: from igel.home (ppp-88-217-105-8.dynamic.mnet-online.de [88.217.105.8])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Wed, 10 Aug 2011 19:01:50 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id B407DCA293; Wed, 10 Aug 2011 19:01:49 +0200 (CEST)
X-Yow: Someone is DROOLING on my collar!!
In-Reply-To: <1312941177.17928.YahooMailClassic@web121810.mail.ne1.yahoo.com>
	(Luiz Ramos's message of "Tue, 9 Aug 2011 18:52:57 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179073>

Luiz Ramos <luizzramos@yahoo.com.br> writes:

> If I run:
>
> $ git diff b2 ./
>
> that is, the "non-cached" version, it will show the same results. This is
> confusing IMHO, because the git-diff manual suggests that invocation
> should render the difference between the named tree contents and the
> working directory. In the working directory, only to recall, file_1 and
> file_2 are both present and with good versions. In my understanding, the
> command should report that file_1 is in excess in the working directory,
> relative to b2, and report nothing about file_2, as it is in the same
> version as the sample in the tree b2.

Since file_2 is not tracked in the current branch, its existence in the
directory is ignored.

> This doesn't seem to be the same thing git-diff-index manual states,
> however. The manual gets more deep into the details, and it's not so easy
> to understand it unless one knows a lot of the inner commands, which does
> not apply to me. In my basic reading, it seems that behind the scenes,
> git-diff-index is what is run in this case, and the fact that file_2 is
> not in the tree associated to b1 is a relevant thing in this case. So, the
> index seem to matter, and if I try to do it, a previous "git update-index"
> should be done.

It's not the index, but the current tree that matters:

           show me the differences between HEAD and the currently checked out
           tree - index contents _and_ files that aren't up-to-date

Note that it talks about "files that aren't up-to-date".  Thus untracked
files are not considered.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
