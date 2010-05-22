From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git-status and git-diff now very slow in project with a submodule
Date: Sat, 22 May 2010 14:05:19 +0200
Message-ID: <4BF7C87F.3060207@web.de>
References: <ht3194$1vc$1@dough.gmane.org>	<7vy6fe7ldo.fsf@alter.siamese.dyndns.org>	<AANLkTilctjct-a911H14XMnaBydYR1I6lPbEuFThTJ99@mail.gmail.com> <m2tyq1qgxa.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: SLONIK.AZ@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat May 22 14:06:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFnSu-00020f-0G
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 14:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266Ab0EVMF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 08:05:26 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:33990 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab0EVMFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 08:05:25 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 8C45D15189091;
	Sat, 22 May 2010 14:05:23 +0200 (CEST)
Received: from [80.128.110.225] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OFnSF-0003jB-00; Sat, 22 May 2010 14:05:23 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <m2tyq1qgxa.fsf@igel.home>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/5ww3DAuzJTBq5hp4UKntNcXbHfEEdMGJK+K7G
	SqIFW+NIo/XefdcmmQ0USZX0t85sl4CBlVKdr1Gf3MjRl/fkD4
	GsqQNTdNegr0oEJb4kBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147519>

Am 21.05.2010 19:54, schrieb Andreas Schwab:
> Leo Razoumov <slonik.az@gmail.com> writes:
> 
>> Speaking of .gitignore and untracked files. Explicitly mentioning all
>> such untracked files in .gitignore is often unpractical. For example,
>> during build process some large projects autogenerate many temporary
>> *.c  *.h *.cpp files. Hunting all of them down and adding to
>> .gitignore is a waste of time and one cannot use globs *.c *.h for
>> obvious reasons.
> 
> You can actually, since tracked files are never ignored.

Hm, but that would mean newly added files would never show up again
(the same .gitignore is used by the developers of that submodule when
they do work on it). So I wouldn't add *.c to .gitignore either ...

But I don't consider it a "waste of time" to get the .gitignore
straight for pretty much the same reasons I want to see no warnings
during compilation: So i can instantly see when something fishy
might be going on. I consider that a "best practice" instead.

And for those projects where you can't or don't want to change the
.gitignore: Just ignore when "git status" tells you a submodule has
"untracked content" (it shows that information since 9297f7).
