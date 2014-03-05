From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] commit.c: use skip_prefix() instead of starts_with()
Date: Wed, 05 Mar 2014 14:23:13 -0800
Message-ID: <xmqqd2i02sku.fsf@gitster.dls.corp.google.com>
References: <1393967190-3181-1-git-send-email-tanayabh@gmail.com>
	<xmqqzjl5iro0.fsf@gitster.dls.corp.google.com>
	<xmqqvbvtiph8.fsf@gitster.dls.corp.google.com>
	<CAEc54XB3hdsJcO4QFuqFHi+mZtZDrV2wFdMQ1uHiPrxzfo99jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: tanay abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 23:23:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLKDi-00029P-0h
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 23:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717AbaCEWXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 17:23:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37721 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754582AbaCEWXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 17:23:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFFD7712AB;
	Wed,  5 Mar 2014 17:23:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BCRLffjpSaVWLA1LURW8SkqEviQ=; b=deLWrx
	uMqXlUez3otatGJs6CC/l/b7nSRQpPCvBXUWzu0HtlARDHufcOGDuFxYjwuUN4X8
	iSQFG6LDOY10g6zsp8v/20FMZc04tJqqFeGPJzZh8v1oWCIBmQ3H2xDPjzCtuD1Z
	aQvfWfeU03SuwEi93w/kdk4yzSGXiN6AL1Jgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FSXxVw7hmKs2ujKcQxWLtROxHJK3rQ5Z
	7/BtuCNVL4KTEOsGmgc1ZhrNan7pj6hlYF9h/S8L2KZdo6Ko/z2TM6gnS0sJQ7pF
	5Xe1BEZEOp/gekC4lJGcSDFcPZ1VFv0+l790rC2++ltbDXTwNHpluuyjkSdid+J0
	dZYi8wxVh/A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2F36712AA;
	Wed,  5 Mar 2014 17:23:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF256712A5;
	Wed,  5 Mar 2014 17:23:14 -0500 (EST)
In-Reply-To: <CAEc54XB3hdsJcO4QFuqFHi+mZtZDrV2wFdMQ1uHiPrxzfo99jw@mail.gmail.com>
	(tanay abhra's message of "Wed, 5 Mar 2014 03:59:55 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BE8D3374-A4B4-11E3-98EA-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243487>

tanay abhra <tanayabh@gmail.com> writes:

> On Wed, Mar 5, 2014 at 3:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> >> +            found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1);
>> >> +            if(!found) {
>>
>> Missing SP between the control keyword and parenthesized expression
>> the keyword uses.
>>
>> I've fixed this (and the broken indentation) locally and queued the
>> result to 'pu', so no need to resend to correct this one.
>>
>> Thanks.
>>
>>
> Sorry about the indentation, it was due to not setting the tab to eight
> spaces. I found your mail late, so I had already
> sent a revised patch [1]. Please ignore that mail.
>
> Also , what should be my next step ,should I present a rough draft of a
> proposal , or tackle other bugs on the mailing list?

As far as I, as the maintainer of the project, am concerned [*1*],
we are done and I expect/require nothing more from you on this
change.

The MicroProject page says:

    ... If you've already done a microproject and are itching to do
    more, then get involved in other ways, like finding and fixing
    other problems in the code, or improving the documentation or
    code comments, or helping to review other people's patches on
    the mailing list, or answering questions on the mailing list or
    in IRC, or writing new tests, etc., etc. In short, start doing
    things that other Git developers do!

FYI, [GSoC 2014 timeline] (Google for it) tells us that would-be
students are supposed to be discussing project ideas with their
mentoring organizations now, in preparation for the actual student
application that begins on Mar 10 and ends on Mar 21.


[Footnote]

*1* I should mention that I am not involved in GSoC administration
and student selection for the Git project.
