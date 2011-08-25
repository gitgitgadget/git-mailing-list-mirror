From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] branch: list branches by single remote
Date: Thu, 25 Aug 2011 10:29:20 +0200
Message-ID: <4E5607E0.1050300@drmicha.warpmail.net>
References: <4E383132.3040907@elegosoft.com> <20110804040646.GA5104@sigill.intra.peff.net> <4E4A729D.9030906@drmicha.warpmail.net> <20110816151448.GA5152@sigill.intra.peff.net> <4E551548.9090807@elegosoft.com> <4E551AD0.7050702@drmicha.warpmail.net> <7vei0apsj9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Schubert <mschub@elegosoft.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 10:29:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwVJd-0007sU-7t
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 10:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549Ab1HYI30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 04:29:26 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:49457 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752135Ab1HYI3Y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 04:29:24 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1964820B45;
	Thu, 25 Aug 2011 04:29:23 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 25 Aug 2011 04:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=uegzU+oqG7SyUKobUcLEaT
	s0vO0=; b=afCRHF1LTIek+XvaOChvrpdYp8DU6Naa/vDaW6WB68tUtk3ZGpYrnT
	/Sy04NcW7M3oNify7kv/L3hHpCENiWy4kUzTpsr4VXLXp4CEJjIIBZnMol/KSQhb
	kt/Od79TWg0VpPRFmHFh4LrNwRaYJgWGqXRBCygVJCqxxKWhRBKH4=
X-Sasl-enc: oeBHoedis/SgkthE7C1XDbGEct3WaQ+iEHeKY/k5u4Tm 1314260962
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 24417901F0E;
	Thu, 25 Aug 2011 04:29:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7vei0apsj9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180067>

Junio C Hamano venit, vidit, dixit 24.08.2011 20:34:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>> As suggested, I've just called it "--glob" for now.
>>
>> Well, again, what's the point in replicating
>>
>> http://permalink.gmane.org/gmane.comp.version-control.git/172228
>>
>> and how is it different?
>> As I've mentioned, I've been in the middle of polishing that up.
> 
> It is not unusual for a similar itch to happen to different people
> independently.
> 
> If this were something you reposted even a WIP re-polish within the past
> two weeks, I would understand and even sympathise with your irritation,
> but please don't expect everybody to dig back FOUR MONTHS worth of mail
> backlog to find an topic that may or may not be abandoned by the original
> author.  Perhaps we would need a weekly posting of topics people have

Well, I've mentioned it earlier in this thread, though without a link.
It's the time when several of us are off-line for a couple weeks. I've
also mentioned it in the thread about filtering by remote.

On a side note, the list here usually does require people to search
back, and much longer than this, on frequently requested issues. But how
does a newcomer discover "frequently"? Right, by searching back years,
not months.

> posted, found to be not quite ready yet, and are still being polished and
> not abandoned [*1*]?
> 
> Having said that, I still appreciate that you posted a link to the
> previous topic:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/172226
> 
> so that the discussions in this thread to scratch the same "itch" can
> benefit from the points raised in the previous thread that need to be
> considered.
> 
> The old thread talks about renaming existing options and transition plans
> to make the "listing" mode of "branch" and "tag" more similar, which may
> be a good plan in the longer term.
> 
> I however can see that teaching "--glob" to both "branch" and "tag" (in
> other words, "tag -l" would become a synonym for "tag --glob") an equally
> good longer term plan.

I don't care about the names, but I'd hate to introduce more
inconsistencies. The implementation is a non-brainer, it's really
something only Apple could get a patent on. The other Michael and I came
up with basically the same patch because it follows "automatically". But
the ui is important.

So I'll take the opportunity and discuss this further in the cover
letter for the upcoming series.

Michael
