From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 08:40:31 +0100
Message-ID: <53103D6F.9050602@viscovery.net>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com> <20140228053703.GA32556@sigill.intra.peff.net> <531032DD.9000904@viscovery.net> <20140228071401.GA1229@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 08:40:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJI3q-0000Ew-It
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 08:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbaB1Hkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 02:40:37 -0500
Received: from so.liwest.at ([212.33.55.19]:34031 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457AbaB1Hkf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 02:40:35 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WJI3b-0007uG-Rg; Fri, 28 Feb 2014 08:40:31 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 98DD216613;
	Fri, 28 Feb 2014 08:40:31 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20140228071401.GA1229@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242902>

Am 2/28/2014 8:14, schrieb Jeff King:
> I didn't think we bothered to make "sh -x" work robustly. I don't mind
> if we do, but "git grep -E 'test_(i18n)?cmp .*err" shows many potential
> problem spots.
> 
> Hmm. Looks like it is only a problem if you are calling a shell function
> (since it is the shell function's trace output you are seeing). So this
> test would be OK as-is, but testing for an error, like:
> 
>   test_must_fail git branch -u foo foo 2>stderr
> 
> would not be, because we see the trace from test_must_fail. So some of
> the callsites found by my grep are actually probably fine.

Yeah, your assessment is correct: only shell function output is affected.

Some time (years?) ago, I used to run the tests on Windows with sh -x,
redirected to a log file to be able to trace intermittent failures. It was
distracting to find many false positives. Today, I don't do that anymore,
and it is not a big deal for me, just like for anybody else ;-)

Consider the topic settled.

-- Hannes
