From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: gitpacker progress report and a question
Date: Fri, 16 Nov 2012 14:13:51 +0100
Message-ID: <m2d2zdvgfk.fsf@igel.home>
References: <20121115212818.GA21558@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Fri Nov 16 14:14:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZLkH-0000Yx-8D
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 14:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585Ab2KPNNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 08:13:55 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:43382 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab2KPNNy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 08:13:54 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Y30JJ1nwKz3hhl9;
	Fri, 16 Nov 2012 14:13:51 +0100 (CET)
X-Auth-Info: kq9KsnI8AJHFJ2UZke4mTqem+zwUCiakb+nEGaZGoAc=
Received: from igel.home (ppp-88-217-126-17.dynamic.mnet-online.de [88.217.126.17])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Y30JH6jS8zbbfb;
	Fri, 16 Nov 2012 14:13:51 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 6EF88CA2A4; Fri, 16 Nov 2012 14:13:51 +0100 (CET)
X-Yow: "DARK SHADOWS" is on!!  Hey, I think the VAMPIRE forgot his UMBRELLA!!
In-Reply-To: <20121115212818.GA21558@thyrsus.com> (Eric S. Raymond's message
	of "Thu, 15 Nov 2012 16:28:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209872>

"Eric S. Raymond" <esr@thyrsus.com> writes:

>                     if commitcount > 1:
>                         do_or_die("rm `git ls-tree --name-only HEAD`")

This will fail on file names containing whitespace or glob meta
characters.  Better use "git rm -qr ." here.  You don't have to care
about the index since you are doing "git add -A" later anyway.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
