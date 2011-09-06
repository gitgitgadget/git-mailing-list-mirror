From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] push: old receive-pack does not understand --quiet
Date: Tue, 06 Sep 2011 08:03:39 +0200
Message-ID: <4E65B7BB.8050601@drmicha.warpmail.net>
References: <20110903105723.GA16304@tin.tmux.org> <1315067656-2846-1-git-send-email-drizzd@aon.at> <1315067656-2846-4-git-send-email-drizzd@aon.at> <7v62l7crpg.fsf@alter.siamese.dyndns.org> <4E6494F7.7010101@drmicha.warpmail.net> <7vwrdmbx76.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	tobiasu@tmux.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 08:03:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0ol9-0001Bt-GC
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 08:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370Ab1IFGDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 02:03:43 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54739 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752031Ab1IFGDm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2011 02:03:42 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 82A6224E96;
	Tue,  6 Sep 2011 02:03:41 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 06 Sep 2011 02:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=4X0LbqQ5quf14tOia12eun
	ghCCA=; b=hM7Ng3wN8wD/WFPSA/AMMZQZBJkf5zDTBvWWXLZcXBnwAte32FLRdv
	5/XogDXrWj+Q0lgQnYWCKVcQrtZUzPfQ1OXwXPGqa9DJDeRc2Sq+Ng653eqLOf+z
	cp5BFkf93y2lWm2ZDotAftqnCMnlO5LFLKJYCPClLaFKQANQ8vtA4=
X-Sasl-enc: Bb24Etm/JYfvyFWZ6YiBsXwUIq+/4vstYlHEdtW+yruY 1315289021
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C1484B61018;
	Tue,  6 Sep 2011 02:03:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7vwrdmbx76.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180770>

Junio C Hamano venit, vidit, dixit 05.09.2011 21:34:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Being cc'ed makes me feel guilty but I don't know what for...
> 
> No guilt involved. 28d836c (test: allow running the tests under "prove",
> 2010-10-14) made you a good _suspect_ for having more clues than I do to
> resolve it, iow, it was asking for help, not pointing any finger.

I plead non-guilty on the account of "prove-clue". All evidence to the
contrary is fabricated ;)

> Anyhow, thanks for a quick workaround, even though I still do not
> understand what the issue is (that is, what is wrong with the
> t/lib-terminal helper).

Seriously, I use prove as my standard target because I prefer its output
for parallel tests, but I have no idea how to debug the test output
(which TAP wants to parse). I've made sure that my workaround works with
and without the httpd runs, and with -j1 and -j8. My blackbox
understanding tells me that a subtest counter used to be increased and
the respective output quelled - maybe by a lib*.sh which used to be
sourced after lib-terminal.sh, because after rearranging the output is
there.

Michael
