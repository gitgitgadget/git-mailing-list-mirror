From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-rebase: Teach rebase "-" shorthand.
Date: Wed, 19 Mar 2014 14:02:38 -0700
Message-ID: <xmqq7g7p3nrl.fsf@gitster.dls.corp.google.com>
References: <xmqq61nb8fap.fsf@gitster.dls.corp.google.com>
	<1395226935-53044-1-git-send-email-modocache@gmail.com>
	<xmqqob123wjm.fsf@gitster.dls.corp.google.com>
	<20140319180213.GB11018@serenity.lan>
	<xmqqsiqe2es6.fsf@gitster.dls.corp.google.com>
	<20140319191217.GC11018@serenity.lan>
	<xmqqk3bq2cyc.fsf@gitster.dls.corp.google.com>
	<20140319195503.GD11018@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Tim Chase <git@tim.thechases.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:02:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQNdP-0006L0-FX
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 22:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309AbaCSVCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 17:02:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57971 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755202AbaCSVCm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 17:02:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9467F756B8;
	Wed, 19 Mar 2014 17:02:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IXMFanAt+o6Zu4A51PpEHdZAgdM=; b=l3KVdF
	VxoxH9UVTkEEFMXQxviLFXxcfPI9Y/Z0Xi03ep5YDGrodTG3ux3p5kHB/kDEsx5h
	ZjqEt65l2r4AJkP6E1rvdp6KCiRKeDxfiZFqD8WAoMSjIpmmago/LtssN0ahWyEw
	+cK07xMO9vXAoyA6mOhFFyd1xus+PYVmBrh5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wOtizQzOhdr4ENo1MmhdA8+VIW5l9Njt
	rYCiND12EXgPT71HYXyoTvbQRQ3kEqtrdVXoBmhCMW9bQOXczwMSHe3hLCl2NnZB
	rwhc7TQl6+gbK+Gj9bB3iKVzN3NQOWWKjZULeVCmwtkcar1OP2ZxWwC9VPkL2v6l
	7OnW2dwUm70=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81D81756B7;
	Wed, 19 Mar 2014 17:02:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD952756B6;
	Wed, 19 Mar 2014 17:02:40 -0400 (EDT)
In-Reply-To: <20140319195503.GD11018@serenity.lan> (John Keeping's message of
	"Wed, 19 Mar 2014 19:55:03 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CF023A4C-AFA9-11E3-9892-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244490>

John Keeping <john@keeping.me.uk> writes:

>> I thought your suggestion was:
>> 
>>     'rebase @{-1}' says 'Fast-fowarded HEAD to @{-1}'. It should say
>>     'Fast-forwarded HEAD to 4f407407 (rebase: allow "-" short-hand
>>     for the previous branch, 2014-03-19)' instead.
>> 
>> Or it could be:
>> 
>>     'rebase @{-1}' says 'Fast-fowarded HEAD to @{-1}'. It should say
>>     'Fast-forwarded HEAD to master' instead.
>> 
>> In either case, it does not look like such a change is about
>> teaching "-" as a synonym to "@{-1}".
>
> My suggestion was specifically:
>
>     'rebase -' says 'Fast-forwarded HEAD to -'.  It should say
>     'Fast-forwarded HEAD to master' instead.

OK, it was closer to the latter.

But why is it OK to leave @{-1}, which is just as "hmm, I do not
remember what the previous branch was myself" when the user says
"@{-1}" in the output while it not OK to leave "-" in the output?

I do not think of any sane reason, and that is why I think this
improvement is not part of "teaching rebase that '-' can be used in
place of @{-1}" topic.
