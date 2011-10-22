From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] make the sample pre-commit hook script reject names with newlines, too
Date: Sat, 22 Oct 2011 19:35:42 +0200
Message-ID: <m262jhoro1.fsf@igel.home>
References: <87obx9eygk.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sat Oct 22 19:36:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHfUL-0004QH-3k
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 19:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426Ab1JVRfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 13:35:51 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:59752 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399Ab1JVRft (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 13:35:49 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id CDEF0188B5BD;
	Sat, 22 Oct 2011 19:35:56 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 422771C00123;
	Sat, 22 Oct 2011 19:35:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id 4H+9MocQ3chO; Sat, 22 Oct 2011 19:35:44 +0200 (CEST)
Received: from igel.home (ppp-93-104-141-210.dynamic.mnet-online.de [93.104.141.210])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat, 22 Oct 2011 19:35:44 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 67CA1CA29C; Sat, 22 Oct 2011 19:35:43 +0200 (CEST)
X-Yow: Yow!!  "Janitor trapped in sewer uses ESP to find decayed burger"!!
In-Reply-To: <87obx9eygk.fsf@rho.meyering.net> (Jim Meyering's message of
	"Sat, 22 Oct 2011 19:19:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184106>

Jim Meyering <jim@meyering.net> writes:

> @@ -26,7 +29,7 @@ if [ "$allownonascii" != "true" ] &&
>  	# even required, for portability to Solaris 10's /usr/bin/tr), since
>  	# the square bracket bytes happen to fall in the designated range.
>  	test "$(git diff --cached --name-only --diff-filter=A -z $against |
> -	  LC_ALL=C tr -d '[ -~]\0')"
> +	  LC_ALL=C tr -d '[ -~]\0' | wc -c)" != 0

This will fail if the output of wc contains leading spaces.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
