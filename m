From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t6302: simplify non-gpg cases
Date: Mon, 09 May 2016 23:03:14 -0700
Message-ID: <xmqqk2j2sb4t.fsf@gitster.mtv.corp.google.com>
References: <dea0877d-fe83-fb47-4df3-21fd69d8421d@web.de>
	<20160509160725.GA11861@sigill.intra.peff.net>
	<CAPig+cQ2kSVzy0K303J3Guhk3-NzcReb5V7ohqOy2pPL_5GrSA@mail.gmail.com>
	<20160509164859.GA8231@sigill.intra.peff.net>
	<CAPig+cQPbwM0+6yruK0VKKq2ujFLoCLogS7eQNN7WWgRjG5V0w@mail.gmail.com>
	<20160510024032.GA16965@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6ger?= =?utf-8?Q?shausen?= 
	<tboegi@web.de>, Karthik Nayak <karthik.188@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 10 08:03:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b00lO-000839-Gj
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 08:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbcEJGDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 02:03:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52231 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750890AbcEJGDS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 02:03:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 19788144CB;
	Tue, 10 May 2016 02:03:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1XJ63ioUYV0NAkDMVsr5MR7Bue8=; b=lsKKFo
	Q4VA5xYJ1BepGsLsBAEeOElHG2uPogJTmThrwkN3R17RIKLEDI223+72DYk2ew/o
	gJkstYhATDoeTqFcNGXMRykVE6gpqQd+DOjdawQ10D6MED68GKyX82N1QFRaM6Ll
	GlLCZaq6tGD/0DR/4KYTXH8YJ3PNvIoKKJXok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y0KMvXUuYVAgWqEiRvmOv7hUWjNcEjgA
	iCP1WHcIsjRM4x7WmwEFyJhKbrD1LGWOeaFj9d9ZO1/E2v7HtjRYcvGpn4wefi5M
	NjlBXjAsOM4yK0sawTI0qymKJID9uN5SUMZkKuvYZvC/a8T+ARuDJoEmx2bhwnmx
	VvFKbrfhtHQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 11FEE144C9;
	Tue, 10 May 2016 02:03:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D1D6144C8;
	Tue, 10 May 2016 02:03:16 -0400 (EDT)
In-Reply-To: <20160510024032.GA16965@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 9 May 2016 22:40:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E33E6678-1674-11E6-AE4A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294097>

Jeff King <peff@peff.net> writes:

> [+cc Junio as this should be the final version]

Thanks, I think I queued with "do not cat a single file to a pipe"
tweak already.

>> > When commit 618310a taught t6302 to run without the GPG
>> 
>> 618310a (t6302: skip only signed tags rather than all tests when GPG
>> is missing, 2016-03-06)
>
> I sometimes intentionally avoid using that longer form when the title of
> the commit does not convey what I want to communicate, and I have to
> summarize the change in my own words anyway (in this case the
> interesting thing is not _what_ it did, but _how_ it chose to do it). So
> I find including the original subject line just bloats the sentence and
> makes the point harder to find.
>
> But I'm curious whether other people run into that problem, or if
> readers would prefer an unconditional full-citation.

Personally, I find your version better in this case, simply because,
as you said, the focus is different, and because the readers
familiar with the recent history can still tell from your
description which commit you are talking about without resorting to
"git show 618310a".  The only thing we are losing is the datestamp,
which is more relevant when referring to a commit in more distant
past.  But in general, not everybody writes a good log message like
you do, so if they try to imitate what you did above, the end result
is likely to end up being a cryptic mess that does not help identify
which commit they are talking about. For that reason, I am a bit
hesitant to say everybody should omit the original when they (think
they) do their own rephrasing.

> Thanks, I did the reversion with s/test_prepare_expect/cat/ rather than
> reverting 618310a, but I agree dropping this useless-use-of-cat is worth
> doing. Here's v2 with that change and your reviewed-by.
