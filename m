From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Fix misuses of "nor" in comments
Date: Fri, 21 Mar 2014 10:52:07 -0700
Message-ID: <xmqq4n2rv3qw.fsf@gitster.dls.corp.google.com>
References: <1395353785-23611-1-git-send-email-jlebar@google.com>
	<1395353785-23611-4-git-send-email-jlebar@google.com>
	<CAEjxke_+=v8HOi9u5Bd_CxmnWcJmaFBSjrXJF8puEp7X84H_nQ@mail.gmail.com>
	<CAMuNMfov+Z0Hx_a-hZ2ZGRdkTtw1eqUn01gWEQ+caT3VcHZkVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jason St. John" <jstjohn@purdue.edu>, git <git@vger.kernel.org>,
	Richard Hansen <rhansen@bbn.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Justin Lebar <jlebar@gmail.com>
To: Justin Lebar <jlebar@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 18:52:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR3cL-0006oc-JP
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 18:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbaCURwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 13:52:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49558 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbaCURwN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 13:52:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 461D47475E;
	Fri, 21 Mar 2014 13:52:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ci2xTSZDHuPan5tSX9yAe5RkbeA=; b=MW4b1v
	vkyJkMhkl0UHAyuibux5QxWiGf+AKTcBq244N09RB0LwW4+AZE1VKtQoVnxL+Prb
	AzmGCqe8o8zVTp1am5Fb2MwwB5DmPCRFS648Ew6sIPjWk2xaR4auqMwNXujA4F69
	vt9fpVlGfKw1znNSn2bWEhCzv1F+NWnteIuiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FiydZULjHeyJAj5x9cn4xDQV0tc3Zzpo
	uc2FnmATOMXrvTIx1oRx0aH4Uk1h1nQQNuTmhJe5I7c1F/k32ZFjNAxi1+U6Pll3
	lq4bqtCq+V1KIlz1Qs6bsHxYm7SwJeMvKOOXjvEGTaxcJxcx4tYi6AeC1IevBytN
	NCoxFWm29s0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33DCB7475D;
	Fri, 21 Mar 2014 13:52:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A67E74744;
	Fri, 21 Mar 2014 13:52:09 -0400 (EDT)
In-Reply-To: <CAMuNMfov+Z0Hx_a-hZ2ZGRdkTtw1eqUn01gWEQ+caT3VcHZkVQ@mail.gmail.com>
	(Justin Lebar's message of "Thu, 20 Mar 2014 16:13:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 86071C8A-B121-11E3-8DE4-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244710>

Justin Lebar <jlebar@google.com> writes:

> Thanks for the quick reply.
>
> When I send a new patch, should I fold these changes into the original
> commit, or should I send them as a separate commit?
>
>>> diff --git a/builtin/apply.c b/builtin/apply.c
>>> index b0d0986..6013e19 100644
>>> --- a/builtin/apply.c
>>> +++ b/builtin/apply.c
>>> @@ -4061,7 +4061,7 @@ static int write_out_one_reject(struct patch *patch)
>>>                 return error(_("cannot open %s: %s"), namebuf, strerror(errno));
>>>
>>>         /* Normal git tools never deal with .rej, so do not pretend
>>> -        * this is a git patch by saying --git nor give extended
>>> +        * this is a git patch by saying --git or giving extended
>>>          * headers.  While at it, maybe please "kompare" that wants
>>>          * the trailing TAB and some garbage at the end of line ;-).
>>>          */
>>
>> I don't think the change from "give" to "giving" here is grammatically correct.
>
> Is it?  I might be misunderstanding the sentence, then.  I parse the
> new sentence as...

The new sentence should say what the original wanted to say, which I
think was:

    - Do not pretend this is a git patch by saying --git
    - Do not show extended headers.

I however think that extended headers is one attribute of a patch
being a "git patch", so I would say that the break down of your new
version:

>   Do not pretend this is a git patch by
>   - saying --git, or
>   - giving extended headers.

makes sense.
