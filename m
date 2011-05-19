From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add-interactive: shortcut to add hunk and quit
Date: Thu, 19 May 2011 12:25:38 -0700
Message-ID: <7v7h9m7arx.fsf@alter.siamese.dyndns.org>
References: <20110517071232.GA19396@mrq1.org>
 <4DD390AF.9020705@drmicha.warpmail.net>
 <7vr57wc9ja.fsf@alter.siamese.dyndns.org>
 <201105191216.51709.trast@student.ethz.ch>
 <20110519110259.GA11507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Harlan <pgit@pcharlan.com>,
	Hermann Gausterer <git-mailinglist@mrq1.org>,
	git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 19 21:26:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN8rB-0007i1-A7
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 21:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934280Ab1ESTZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 15:25:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934055Ab1ESTZz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 15:25:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 197FA43B1;
	Thu, 19 May 2011 15:28:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=aC/4CpzR4Bus2v8bXTzfsOYUCb0=; b=QPhFNB72fiT6T7985vjs
	vQ0Zu9nRDm/2A5K7+lAhW+0La35p0LyQ7FRSPqvlYz39zeM1eHEThdX45PFqPMyy
	fTL1n7oEof42kU1XK5rnzotiNgVTDrFuQudLCUiMvcAOi/fab6MIy9BFY2KtLxEW
	O8P+CrW9DRkWPZCZjYE8UV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=GPtfoxXLBfSzBgUQ3LBrXjRP5VEpqCxxNqN/ileQ+J9Cu3
	FWavzkWw5KhSLgsA/VXJXOuFiwnpBrdyZuFc2Pz+Owk2JJ7zAz5GazW8f1/AaffO
	xb5y3VPGGTZZTZWAIcOCv6DiWfSBwEmMzQzIE6RFGCTlC/VvDbjoA+wpI0aZk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9B7F043AE;
	Thu, 19 May 2011 15:27:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5B1ED43AC; Thu, 19 May 2011
 15:27:48 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1959A51C-824E-11E0-96EF-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173994>

Jeff King <peff@peff.net> writes:

> On Thu, May 19, 2011 at 12:16:51PM +0200, Thomas Rast wrote:
>
>> Junio C Hamano wrote:
>> > 
>> > I think "single-key" was a poorly designed attempt to improve productivity
>> > the ("y" <RET>)*5 into "y"*5
>> 
>> Actually for me it more often is
>> 
>>   y RET n RET *think* y RET s RET n RET ...
>
> Yeah. I personally find the concept of "5y" crazy; how do you know that
> it is 5, and not 4 or 6, if you haven't yet seen them?

That one is surprisingly easy to answer. Before I decide to use
"incremental", I've seen the diff at least once but more often number of
times. I know where things are when I start my incremental sessions, and
"5" (just an example) is something I would use when I think I know there
are 8 or 9, i.e. a number that will surely undershoot but will get me
to the end sooner. An alternative would be something akin to "/<pattern>"
but that adds, instead of skips.

> I think a confirmation question is a bad idea. It helps with
> fat-fingering, but not much else.

I agree, but fat-fingering is a real problem single-key mode introduces,
and that is why I suggested a similar final confirmation only for 'a' in
the single-key mode.

> I think a much better safety valve is to store the user's worktree state
> that we are about to destroy. Then when they accidentally erase
> something, whether they realize it immediately, or even 5 minutes later,
> it is recoverable. And in the common case where everything goes well,
> they needn't be bothered at all.

Intereting.

Where does the data go (perhaps to "stash create", not "stash save"), and
where would we plug that in ("checkout -p" codepath only)?
