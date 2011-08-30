From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Idea: "git format-patch" should get more information out of git
Date: Tue, 30 Aug 2011 14:21:13 +0200
Message-ID: <4E5CD5B9.80306@drmicha.warpmail.net>
References: <4E587CC0.4090508@alum.mit.edu> <7vippiaduw.fsf@alter.siamese.dyndns.org> <7v1uw69h96.fsf@alter.siamese.dyndns.org> <20110829185546.GD756@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 30 14:21:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyNJj-0006kc-Pf
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 14:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab1H3MVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 08:21:18 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35822 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751273Ab1H3MVR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2011 08:21:17 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EEA3420C91;
	Tue, 30 Aug 2011 08:21:16 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 30 Aug 2011 08:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=3/jnivdLfl1JHY+YKRWWN3
	F3oiw=; b=gsZbDAGLbPrbL0oRBT3aJgGyJ2z0FMQvcvf2/YGV8vRj0NqJJshSVW
	2JUJa04yFxKHN4AUZVeu0YcKF9JomP2PMInx8VE03hK+WEHbFe4XauUx9mMJRYYN
	A/T2zV7s2yEZgxFKREHimWj4ibnQVca759zylj48d/EsCrZ3XOZyA=
X-Sasl-enc: dqcXZgMiwgFhsTMKN2suwgD215q4nq8qqcQrxE0BCyeL 1314706876
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0113BB20321;
	Tue, 30 Aug 2011 08:21:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <20110829185546.GD756@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180405>

Jeff King venit, vidit, dixit 29.08.2011 20:55:
> On Sat, Aug 27, 2011 at 11:34:13PM -0700, Junio C Hamano wrote:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>>
>>>> 4. There is no place to store the "additional information" (the part
>>>> that comes in patch emails between the "---" and the diffstat) while
>>>> working on the patch series;...
>>>
>>> I thought there was a RFC floating around to do this using notes and also
>>> teach it to "commit -e" a few months ago? I vaguelly recall that Peff and
>>> one of the J's were involved, so I am CC'ing them.
>>
>> Also, when I prepare a commit to be sent with an additional piece of
>> information, I often write "---" and the additional message after my
>> S-o-b: line while preparing the commit log message. Unlike format-patch
>> that strips that off, commit keeps it, which is handy.
> 
> After playing around a bit with my earlier series, I made the
> realization (perhaps obvious to others :) ), that if you are in a
> pure-patch workflow, keeping the "---" in your commit message locally is
> much simpler. It follows the commit around through rebases
> automatically, it gets put into format-patch output automatically, and
> so forth.

I'm confused: Does format-patch keep it or strip it as you say above?

Anyways, notes survive rebase etc., and at format-patch time you can
decide whether you want to include them or not (with my patch).

> The only real downside is that you can never tell git "don't show me the
> cover letter cruft". Which is probably OK for your own local patches.

You can with notes...

> But the point of the "---" is that information should never make it into
> a repo, which means in any workflow that involves pulling actual git
> commits, it won't work (after reading Michael's response in another
> thread, though, I think he would be interested in a hybrid
> pull-or-apply-via-mail system).

The only difficulty would be sharing notes in a push-pull workflow (for
lack of tool support, though we do have merge support).

Cheers,
Michael
