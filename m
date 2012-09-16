From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Remove all files except a few files, using filter-branch
Date: Sun, 16 Sep 2012 19:06:59 +0200
Message-ID: <m24nmxkibw.fsf@igel.home>
References: <CAFT+Tg_ipyPgNQxx8XsXySzmA3YM3mKe1gB5GyTNqN++gdphnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: semtlenori@gmail.com
X-From: git-owner@vger.kernel.org Sun Sep 16 19:07:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDIJX-0007X8-FB
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 19:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747Ab2IPRHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 13:07:08 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:56506 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab2IPRHI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 13:07:08 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XKcMT189Wz3hhfZ;
	Sun, 16 Sep 2012 19:07:01 +0200 (CEST)
X-Auth-Info: 6HN0iUq4iFSfCz+K9cnu1zFrQYldDNLQJwQdwUAwd9c=
Received: from igel.home (ppp-88-217-122-238.dynamic.mnet-online.de [88.217.122.238])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XKcMT0G7rzbbp4;
	Sun, 16 Sep 2012 19:07:01 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 3EEE3CA2A3; Sun, 16 Sep 2012 19:06:59 +0200 (CEST)
X-Yow: NANCY!!  Why is everything RED?!
In-Reply-To: <CAFT+Tg_ipyPgNQxx8XsXySzmA3YM3mKe1gB5GyTNqN++gdphnQ@mail.gmail.com>
	(EungJun Yi's message of "Mon, 17 Sep 2012 01:28:31 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205633>

"Yi, EungJun" <semtlenori@gmail.com> writes:

> Hi, all.
>
> I want to remove all files except a few files, in the history of my
> git repository.
>
> I tried to do that as follows:
>
>     git filter-branch --index-filter "git rm --cached --ignore-unmatch
> $(git ls-files | grep -v '^filename$' | tr '\n' ' ')"

Try instead first removing all files, then restoring the files you want
to keep.

--index-filter "git rm --cached -qr -- . && git reset -q -- filename"

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
