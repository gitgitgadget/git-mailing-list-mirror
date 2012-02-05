From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Specifying revisions in the future
Date: Sun, 05 Feb 2012 23:15:40 +0100
Message-ID: <m2wr81vsdv.fsf@igel.home>
References: <jgjkk0$qrg$1@dough.gmane.org> <vpqipjlf309.fsf@bauges.imag.fr>
	<m21uq9x8q2.fsf@igel.home> <m3ehu9kknw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, jpaugh@gmx.us,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 23:15:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuANB-00034t-MJ
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 23:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199Ab2BEWPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 17:15:43 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:49847 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab2BEWPm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 17:15:42 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id DDF9A1C1D9FE;
	Sun,  5 Feb 2012 23:15:41 +0100 (CET)
X-Auth-Info: l/JuCCiheaajihK90OlBQICCzOL4RGXJrPKLl1SV7Do=
Received: from igel.home (ppp-88-217-114-0.dynamic.mnet-online.de [88.217.114.0])
	by mail.mnet-online.de (Postfix) with ESMTPA id D098D1C000AD;
	Sun,  5 Feb 2012 23:15:41 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id AB452CA29F; Sun,  5 Feb 2012 23:15:40 +0100 (CET)
X-Yow: I don't think you fellows would do so much RAPING and PILLAGING if you
 played more PINBALL and watched CABLE TELEVISION!!
In-Reply-To: <m3ehu9kknw.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Sun, 05 Feb 2012 13:57:55 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189976>

Jakub Narebski <jnareb@gmail.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>> 
>> > "the successor of <commit>", OTOH, is not well defined, since there can
>> > be several successors, and one can't order them reliably (you can't
>> > really know the set of successors, because they can exist in different
>> > repositories).
>> 
>> Yet it would be nice to have a concise notation for "the nth successor
>> of <commit> towards <commit>" (using --first-parent ordering when
>> ambiguous).
>
> First, "the nth successor"... from which refs?

>From the first given commit towards the other given commit (the latter
defaulting to HEAD).

> Second, `--first-parent' won't help here.  Take for example the
> following situation:
>
>    ---X<---*<---.<---A
>             \
>              \--.<---B
>
> X+3 is A or B?

If "towards A" then it is A, if "towards B", it is B.  In other words,
to get the "nth successor of C1 towards C2" take the leftmost possible
parent when walking from C2 to C1, then walk back n commits along this
path.  This way you should have an unambigous definition.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
