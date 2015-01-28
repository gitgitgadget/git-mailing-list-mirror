From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-push.txt: document the behavior of --repo
Date: Wed, 28 Jan 2015 12:55:58 -0800
Message-ID: <xmqqsieufwv5.fsf@gitster.dls.corp.google.com>
References: <xmqqppa1mrku.fsf@gitster.dls.corp.google.com>
	<d8bed5c1736a4a291208227b0f54c1039d67f5cc.1422361902.git.git@drmicha.warpmail.net>
	<CAPig+cQCf+vKbZ5ydFSNmGCUvmCkQW-DEPhO1JAAap1VorhXsA@mail.gmail.com>
	<xmqqfvauhdfi.fsf@gitster.dls.corp.google.com>
	<CAPig+cR-45NzCK5mu9d=1o8nss54ShYn1Snexx5rT+En8XeMcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git List <git@vger.kernel.org>, Prem <prem.muthedath@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 22:07:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGZpP-0003RY-Uo
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 22:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756796AbbA1VGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 16:06:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754440AbbA1U4B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 15:56:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 613A63407B;
	Wed, 28 Jan 2015 15:56:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UzlbP1Rqw0FoUahjztc9uRtNJY4=; b=x0tirq
	4OEvKiVjU5Fm/WDBbrvzQwUk/EQE0epN8oX37xEz1OLVP4Pj7bMUOt9++Zyo4/Lc
	c+WDFLusFG0cyvOB/M8biDp+CKT+zI70FByA4Cnt2lu9GrH3fu0idz4UBaNup8rH
	B1QtC3y4+LpY9twmur4JkS/nP7E8hm+QXkjGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lkjtSRH/zlJy0Uk5r6enkPrSliAYGxeE
	ryKyL4/Yw7jyH4ycSucQ+lBCgHOTdCBOQz2hN34FFQzRA3JKV+wun4VPlHKX9oYx
	AZCjUeCBYvGeBAPtnGcMUcbWtYPOBK8GQk7BIiQ9lfWWNodK2CTEYNHDzIRX891L
	MCrT1chGZ50=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 54F9734079;
	Wed, 28 Jan 2015 15:56:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB75A34078;
	Wed, 28 Jan 2015 15:55:59 -0500 (EST)
In-Reply-To: <CAPig+cR-45NzCK5mu9d=1o8nss54ShYn1Snexx5rT+En8XeMcA@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 28 Jan 2015 15:30:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 101B17BE-A730-11E4-9EBF-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263117>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jan 28, 2015 at 3:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>>> +       This option is equivalent to the <repository> argument; the latter
>>>> +       wins if both are specified.
>>>
>>> To what does "latter" refer in this case? (I presume it means the
>>> standalone <repository> argument, though the text feels ambiguous.)
>>>
>>> Also, both the standalone argument and the right-hand-side of --repo=
>>> are spelled "<repository>", so there may be potential for confusion
>>> when talking about <repository> (despite the subsequent "argument").
>>> Perhaps qualifying it as "_standalone_ <repository> argument" might
>>> help.
>>
>> I didn't find that "latter" too hard to understand (I admit that my
>> reading stuttered there, though).
>>
>> I do not think saying "standalone <repository> argument" there would
>> help very much, because there is no mention of "standalone" around
>> there.  The earlier part of the sentence mentions "option" and
>> "argument", so "the repository specified as an argument is used if
>> both this option and an argument are given" or something?
>
> Yes, that addresses the two (minor) ambiguities and sounds fine.
> Thinking about it afterward, I came up with this:
>
>     This option is equivalent to the <repository> argument. If both
>     are specified, the command-line argument takes precedence.

Sure, even though I felt a similar stuttering at around 'both' when
reading it for the first time.

Let me amend using your phrasing and requeue.
