From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git cherry-pick --strategy=resolve segfaults if picking a root
 commit
Date: Mon, 16 May 2011 08:01:33 -0700
Message-ID: <7vwrhqlmeq.fsf@alter.siamese.dyndns.org>
References: <iqgbvs$pm5$1@dough.gmane.org>
 <20110512104558.GA22108@sigill.intra.peff.net>
 <20110512110855.GA5240@sigill.intra.peff.net>
 <20110516102744.GA23286@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 16 17:01:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLzIs-0000pQ-JC
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 17:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755696Ab1EPPBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 11:01:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553Ab1EPPBo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 11:01:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EB51C5F15;
	Mon, 16 May 2011 11:03:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YVJUz18Wv0B11HdYTO73Sjcbsnk=; b=MfI60w
	9t+4VcE8tmSTzkjX+aqYkNl6V98DeUwUBG8WLlFMFdCpG9B2CPFZ+XVVXMebRYh2
	gjdgln7sbbcT4vikpn7B1hvb2IshJXQgkiHGakEeUp9GBXSHI9Bmak1RpLxDBO+7
	YJPdOH3/j7lx/srZ7aJn79p4ZddKyx8oJFPGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cIpeAYQInuAY3XBUTvu0v/GjE0y1IvF7
	DD01hd2LrwTZFCUKRxP1U1n2VV0iH+iw3bTQ14ewyFbiHsDY4SLp+o3/jS3urJu7
	kVn3AOGjHZoUjsih82lNVt5LOTvmdVPe2m22KllVwALaABVW187/y8M8IsbUskHw
	0mBPvlrEcgQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A511F5F11;
	Mon, 16 May 2011 11:03:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 78FA05F0D; Mon, 16 May 2011
 11:03:41 -0400 (EDT)
In-Reply-To: <20110516102744.GA23286@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 16 May 2011 06:27:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B235AEB2-7FCD-11E0-9C7F-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173739>

Jeff King <peff@peff.net> writes:

> On Thu, May 12, 2011 at 07:08:55AM -0400, Jeff King wrote:
>> The series is:
>> 
>>   [1/3]: cherry-pick: handle root commits with external strategies
>>   [2/3]: revert: allow reverting a root commit
>>   [3/3]: t3503: test cherry picking and reverting root commits
>
> I seem to recall seeing an email from you saying that merge-helpers need
> to handle tree-ish arguments, so this is an OK direction to go. But now
> I can't seem to find it. Did I dream it?
>
> If that is the case, then I think this series is worth picking up. So I
> thought I'd prod you on it (I'm happy to repost, too, if that's easier).

No you did not dream it but I think it is worth picking up. It was in my
"to look at" queue that was accidentally got lost.

Thanks for reminding.
