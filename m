From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH RFC 0/5] Patches to avoid reporting conversion changes.
Date: Sat, 17 Apr 2010 22:32:39 +0300
Message-ID: <87eiid6fjc.fsf@jondo.cante.net>
References: <cover.1271432034.git.grubba@grubba.org>
	<874ojbqnry.fsf@jondo.cante.net> <86ljcnclvu.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Sat Apr 17 21:32:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Dl3-0003wH-VK
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 21:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556Ab0DQTcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 15:32:45 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:43712 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab0DQTco (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 15:32:44 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 1489918D380;
	Sat, 17 Apr 2010 22:32:43 +0300 (EEST)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A02F2F11D74; Sat, 17 Apr 2010 22:32:43 +0300
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id E692B403C;
	Sat, 17 Apr 2010 22:32:39 +0300 (EEST)
In-Reply-To: <86ljcnclvu.fsf@red.stonehenge.com> (Randal L. Schwartz's message
	of "Fri, 16 Apr 2010 11:06:45 -0700")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145173>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Jari" == Jari Aalto <jari.aalto@cante.net> writes:
>
> Jari>     if ( $OS_ERROR ) ...
>
> Right, but without looking, is it $OS_ERROR or $OSERROR?

I don't see any difference, because that variable is always within the
close context of previous statements. The reader would consult the lines
above.

And if that's the only problem, which I don't believe it is for a Perl
programmer, there is also $ERRNO.

> You're trading a list of single punctuation characters, pretty
> unambiguous, for things that could have been named a dozen different
> ways each.

A typical Perl program used those "single puctuation variables" and they
are not immediately understandable; unless you know them by heart.

They are cute for one-liners, but not suitable for maintainable
programs, edited by N developers, with different backgrounds and skills.

To make the code actually readable by anyone, not just by a Perl coder
breathing the language 24/7, is what software, any software would be
better off.

It's akin to the opening "magic values" in a program:

    100
    130
    140

Good programmers write instead (pseudo code):

    ERROR_MINOR = 100
    ...


    return ERROR_MINOR

Jari
