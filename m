Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 355311FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 18:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbcFUSj1 (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 14:39:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752784AbcFUSj0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2016 14:39:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2498225C46;
	Tue, 21 Jun 2016 14:39:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xB4bqwszN1oz
	8zZdSGTyQguOcqU=; b=algBpkyk0XGUfpy48atKfPtqi33SOrJ9Lo0T/nd2tbyL
	YbmbQGIwEMyOOzGEuQQtrU48R46ww4MMcXKVDqUYWt0+DBFV81/kFqYjj6wI+KRQ
	nt7nf9TSho8nBYwAEpPgrZsaLyAb9wKdyGdzeDO4p2eKMJtLXFpnwy1vBBExFx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YIRmDU
	CX/u5cS8ZAaK9v1U4HZCL11COLJVLGvsVMsVWNo7+ZmYWff42tXxB+kFNNkGBVfy
	T4VQPqEoZTP+YoFRkMNeSz2RVJI6aPmooVTgcUMPLF2KGHzILk3/vIz25kT7pNt+
	zVy2aVx6O7Df3dVUTyzcthUdSp/aPukOpDqv4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B3C825C45;
	Tue, 21 Jun 2016 14:39:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 88C0925C44;
	Tue, 21 Jun 2016 14:39:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Armin Kunaschik <megabreit@googlemail.com>
Cc:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	David Aguilar <davvid@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] t7800 readlink not found
References: <CALR6jEiJwx14zAyond9ggz29Q64Fz84URtjr8zaddjnrdY7TjA@mail.gmail.com>
	<vpqk2ijs8p2.fsf@anie.imag.fr>
	<xmqq1t4r75sv.fsf@gitster.mtv.corp.google.com>
	<CALR6jEj67MA7CCHQ_jfdtAuGoo9wjPie0+a=e-BqJjoYtJ9oHw@mail.gmail.com>
	<xmqqfut75peg.fsf@gitster.mtv.corp.google.com>
	<CALR6jEixZitA1CTE_kDkDEHv59ALT9zkCOgd28unMhLUZKt48Q@mail.gmail.com>
	<20160527041944.GA17438@gmail.com> <574CDA24.1020906@googlemail.com>
	<574D1BEA.5020409@web.de>
	<xmqqzir67p1y.fsf@gitster.mtv.corp.google.com>
	<CALR6jEgAtvuecJ4OPOAcDGh3o02oM_WP5_CM8Y52eW2hjuLDNg@mail.gmail.com>
Date:	Tue, 21 Jun 2016 11:39:22 -0700
In-Reply-To: <CALR6jEgAtvuecJ4OPOAcDGh3o02oM_WP5_CM8Y52eW2hjuLDNg@mail.gmail.com>
	(Armin Kunaschik's message of "Tue, 21 Jun 2016 16:44:06 +0200")
Message-ID: <xmqqy45ypesl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7A0E1BA8-37DF-11E6-A9A2-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Armin Kunaschik <megabreit@googlemail.com> writes:

> On Tue, May 31, 2016 at 7:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Torsten Bögershausen <tboegi@web.de> writes:
>>
>>>> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
>>>> index 7ce4cd7..905035c 100755
>>>> --- a/t/t7800-difftool.sh
>>>> +++ b/t/t7800-difftool.sh
>>>> @@ -446,7 +446,7 @@ write_script .git/CHECK_SYMLINKS <<\EOF
>>>>   for f in file file2 sub/sub
>>>>   do
>>>>      echo "$f"
>>>> -    readlink "$2/$f"
>>>> +    ls -ld "$2/$f" | sed -e 's/.* -> //'
>>>>   done >actual
>>>>   EOF
>>>>
>>> I don't know how portable #ls -ld" really is.
>>
>> The parts with mode bits, nlinks, uid, gid, size, and date part do
>> have some variations.  For example, we have been burned on ACL
>> enabled systems having some funny suffix after the usual mode bits
>> stuff.
>>
>> However, as far as this test is concerned, I do not think "how
>> portable is the output from ls -ld" is an especially relevant
>> question.  None of the things we expect early in the output (the
>> fields I enumerated in the previous paragraph) would contain " -> ".
>> And we know that we do not use a filename that has " -> " (or "->")
>> as a substring in our tests.
>>
>> We don't have to use readlink, even on platforms where we do have
>> readlink.  Building the conditional to be checked at runtime and
>> providing a shell function read_link that uses "ls -ld | sed" or
>> "readlink" depending on the runtime check is wasteful.
>
> Just a short, curious question: Is this patch to be accepted/included some time?
> I didn't see it in 2.8.4 nor 2.9.0. Maybe it just fell off the table...

Yes, I think this fell off the table as I was waiting for some kind
of agreement or counter-proposal, neither of which came and the
thread was forgotten.

Unless Torsten still has strong objections (or better yet, a better
implementation), I am inclined to queue it as-is.

Thanks for pinging the thread.
