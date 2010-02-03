From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Fix signal handler
Date: Wed, 03 Feb 2010 12:55:51 +0100
Message-ID: <4B696447.10803@web.de>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net> <4B689CC5.3000400@web.de> <20100202223208.GB18781@sigill.intra.peff.net> <4B694DEE.5030207@web.de> <20100203102915.GA25486@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 12:56:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncdpv-0008JT-PO
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 12:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757218Ab0BCLzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 06:55:54 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:49036 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757167Ab0BCLzx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 06:55:53 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id B276814D00E5A;
	Wed,  3 Feb 2010 12:55:52 +0100 (CET)
Received: from [78.54.162.123] (helo=[192.168.1.202])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Ncdpo-0005ET-00; Wed, 03 Feb 2010 12:55:52 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <20100203102915.GA25486@coredump.intra.peff.net>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1+kQRhm6RfUXT7J8tQxYTZBHdFrBTCwBJF+XRAu
	vcti2sMLW0MwYFFkYOA8XE+qCncvhs4u0YjM+kHS7mIh/o6kKs
	NtKlvgjcAKm/Stjd2Llw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138830>


>
> I think it is simply impractical.

I have got the opposite opinion.


> It's not that we're ignoring a specification, it's that there _isn't_
> a concrete specification for the set of systems we're interested in.
>   

I have got doubts on your view. Known specifications are available for
POSIX and corresponding programming languages like C and C++. I know
that they have got open issues on their own because a few important
wordings are not as precise and clear as you might prefer.

For which software environments do you miss programming standards?

How many efforts would you like to spend on conditional compilation for
"special" platforms?


>
> But if you are interested in addressing the situation, I am suggesting
> that the first step would be to demonstrate that there in fact _is_ a
> race condition, and it is not simply some theoretical problem.
>   

I try to point out this open issue once more.

Can you imagine any unwanted results if the desired address can not be
atomically set in a way that fulfils requirements for signal handler
implementations?
Can it happen that the assigned function pointer will become a dangling
pointer because of word-tearing?


Another "dangerous" use case:
Do you know if any function is called during the execution in a signal
handling context that is not async-signal-safe like "fprintf()"?

Regards,
Markus
