From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Thu, 23 Feb 2012 11:35:14 +0100
Message-ID: <m262exrg65.fsf@igel.home>
References: <4F46036F.3040406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Nikolaj Shurkaev <snnicky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 11:35:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0W1F-0007b0-1D
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 11:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387Ab2BWKfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 05:35:19 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:50537 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab2BWKfT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 05:35:19 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3TtsQY000bz3hhZt;
	Thu, 23 Feb 2012 11:35:16 +0100 (CET)
X-Auth-Info: YnRSs/NSx6Ll65pLwwy9YPogdNnUw7C+VFUqhAKdmjI=
Received: from igel.home (ppp-88-217-102-60.dynamic.mnet-online.de [88.217.102.60])
	by mail.mnet-online.de (Postfix) with ESMTPA id 517DE1C000A9;
	Thu, 23 Feb 2012 11:35:17 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id E0005CA29E; Thu, 23 Feb 2012 11:35:15 +0100 (CET)
X-Yow: Look!!  Karl Malden!
In-Reply-To: <4F46036F.3040406@gmail.com> (Nikolaj Shurkaev's message of "Thu,
	23 Feb 2012 12:14:23 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191350>

Nikolaj Shurkaev <snnicky@gmail.com> writes:

> I did something like this:
> git log -z --patch HEAD~10..HEAD -- SomePathHere | xargs -0 
> --max-chars=1000000 ~/1.sh
>
> If I put
> echo "started"
> into the file  ~/1.sh I see that the file is called only once instead of
> multiple times.

If you want the command to be called once for each commit you need to
pass --max-args=1 to xargs.  Otherwise xargs will cumulate the arguments
until --max-chars is reached, and the command is expected to loop over
them.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
