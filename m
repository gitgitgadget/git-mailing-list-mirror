Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 323D31F858
	for <e@80x24.org>; Thu, 28 Jul 2016 15:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbcG1PLb (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 11:11:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57416 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932406AbcG1PLb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 11:11:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E927D2E996;
	Thu, 28 Jul 2016 11:11:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EuiQc5EY0o6WBd0HHUhVv5F8O+g=; b=etAdmh
	CkoksKoze7iH25xVQ73Vyv8b/KWD2jk1W2Ysm/shK7KwVaSi7ewKIF+GK56nhc42
	+dYzVLbPk/hq/eS7jY51s0X5B9WovCM/oF8GLd3U78/iWbm7cCxLxYFff19HJtCR
	l9vLNVe1t/IVmnAETWYcxUCA/IpiSD11FB0x4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W9MDlaenBrVp+k+PBYTi2mRURTUZMC60
	sd6hnYWJ7muH826pSsPnZYW8UzYzrDg6YCjFmPuM2cLcHq1al4W9IdxX/iEuSz0D
	y0ekUuQd6LpVkbvkIV73zIZA9wgraJ8POe/m8a2/FFPScOe28wCA6Raz14VKSJNo
	Iyi+0P38i8I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E18502E995;
	Thu, 28 Jul 2016 11:11:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 584F22E993;
	Thu, 28 Jul 2016 11:11:29 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Find a topic branch containing a commit
References: <CACsJy8CMnywB8AdmLxB8LnsznHrMTieoezhaQS=2r1pnM8ONZA@mail.gmail.com>
	<CAGZ79kY5UrjSj8xbjB+MvTE2xUyt+te1RKN6Bf0WiEA23iZ7wg@mail.gmail.com>
	<CACsJy8CKLmjW82TJHUoqrM1smmiP=dcDqvOpN_QDPePEy0ZuJw@mail.gmail.com>
	<a7cd0ee3-8281-b220-1acc-c9516325ecde@alum.mit.edu>
Date:	Thu, 28 Jul 2016 08:11:27 -0700
In-Reply-To: <a7cd0ee3-8281-b220-1acc-c9516325ecde@alum.mit.edu> (Michael
	Haggerty's message of "Thu, 28 Jul 2016 15:46:08 +0200")
Message-ID: <xmqqa8h1u7a8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F809E8A-54D5-11E6-A5E8-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 07/27/2016 08:03 PM, Duy Nguyen wrote:
>>>
>>> https://github.com/mhagger/git-when-merged ?
>> 
>> Beautiful. If it had an option to show a topic (i.e. git-log from
>> merge base to merge point) I would be ecstatic.
>
> That's a good idea. I just created a pull request to add that feature:
>
>     https://github.com/mhagger/git-when-merged/pull/13
>
> Let me know what you think!

It would be nice to have a mode to give the result in a more human
readable way.

I use when-merged to find where to queue a follow-on fix to a topic
that has already graduated to 'master'.  When the patch fixes an
earlier mistake of the commit X, "git when-merged X master" gives me
the merge's 40-hex object name, and the next step is almost always
to pass it to "git describe [--contains]".  This tells me down to
which maintenace track the fix can go.

Of course I can get that information by running a separate "git
describe [--contains] X", but when I'll be running "when-merged"
anyway, it is a wasted step.

Then "git show" of the found merge tells me where the tip of the
topic is and what the topic was called (older topic branches are
culled sometime after they are merged to 'master' and relevant
maintenance tracks), and allows me to queue the patch to the correct
place (after re-creating the topic if necessary).


    
