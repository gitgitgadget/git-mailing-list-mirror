From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Mon, 02 May 2011 13:04:56 +0200
Message-ID: <4DBE8FD8.90303@drmicha.warpmail.net>
References: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net> <20110429223433.GA3434@sigill.intra.peff.net> <m2k4ecy6rv.fsf@igel.home> <7vfwp0uwu4.fsf@alter.siamese.dyndns.org> <m21v0kw1es.fsf@igel.home> <4DBE6E77.3030703@drmicha.warpmail.net> <BANLkTinxszGhtYobuvci5Yi8eTHW+pi2wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 13:05:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGqw6-0007kH-5Q
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 13:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582Ab1EBLE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 07:04:59 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34083 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752731Ab1EBLE6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 07:04:58 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0347C20303;
	Mon,  2 May 2011 07:04:58 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 02 May 2011 07:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=jvUQQHBURvEzffA8AQuYBw+9xrY=; b=RaZsuYpUD9FucgYKPX3Hqh2sjGjh+0IgCWfn42WWh05UEBG8BMFHv+Pnct/58dlMk/jgrSzA2/L8A5MiDdsU4F1BIkVY6mSQFN9HsWu1ZZjblR/x2xf/cNWmcbQewKAHyWJw2HvZVOZ1F3OXyasGehaTxkWRplqSc8cjVHBxNQE=
X-Sasl-enc: pnvENarRcjIxRzgy7FzYGZbhKO0GbQ5ef73SMKQkTwMQ 1304334297
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 28120403CC9;
	Mon,  2 May 2011 07:04:57 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <BANLkTinxszGhtYobuvci5Yi8eTHW+pi2wA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172568>

Junio C Hamano venit, vidit, dixit 02.05.2011 12:25:
> 
> On May 2, 2011 1:42 AM, "Michael J Gruber" <git@drmicha.warpmail.net
> <mailto:git@drmicha.warpmail.net>> wrote:
> 
>> Regarding rebase -i -<n>:
>> git-rebase (-i) does not have a log/rev-list like interface at all (just
>> like git-cherry does not), and introducing an argument which looks like
>> it did would just increase the user confusion, I'm afraid.
> 
> That cuts both ways. Some people can already be confused by it not being
> in line with the log family. Just like format-patch that was born
> without the log family interface later learned it, it is not impossible
> to teach rebase the same, no?
> 

Just because we went in a wrong direction then, is it good to go in the
same direction now?

I'm not saying it necessarily was a wrong direction, I just don't
consider that an argument.

You can consider my "log --cherry" being part of a long time plan to git
rid of "kinda-loggish but not log-like" command interfaces (in that case
git-cherry).

Introducing a shortcut ~n for HEAD~n does not introduce new
inconsistencies (it's a shortcut for a commit, for every command which
takes a commit) - and does not contradict introducing -n at all, btw.
But introducing -n means introducing a range like revision argument to a
command which does not grok ranges at all, so that is a much deeper
decision.

Michael
