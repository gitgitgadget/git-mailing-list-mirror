Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA31CC10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 19:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD822465D
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 19:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NufHOclZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgCJTr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:47:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51446 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgCJTr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 15:47:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4CD7EBD39B;
        Tue, 10 Mar 2020 15:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FXWghETqXkqP
        DQBha3fGfwsiDys=; b=NufHOclZ2KL1A5DIvUYSY3fQFbE76T8ovVgt6UxCjEGM
        krWkgEUahG9BGZwYBzA33NlIjubyfsaudKXxqDwS2RvuPkyBhXqLtFJJjMqsd1Sm
        AoAvdyscGQHgcWWqaOASYClav7fhCLxT9SOsiemh0gjUVzsXOLwpBitzZc9aw+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rzOEly
        /fkynlAs73wtt5VASjSsLv1xrP4R7vxntQgz9wpi2a7wmE2ySQzHt3WnxW9bJHZO
        OIbmRHkWoytbg8NpgWI9762LX5ifiC9Lros4/p3Pyegi8npfJEC9lXIE1932pLn5
        6jLJTXkb9KjM1zN0AMZLGR9MpQOvd9gzoGD+0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 459A1BD39A;
        Tue, 10 Mar 2020 15:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5E65FBD395;
        Tue, 10 Mar 2020 15:47:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     =?utf-8?Q?J=C3=B6rn?= Engel <joern@purestorage.com>,
        git@vger.kernel.org
Subject: Re: new file mode 160000
References: <20200310184111.GD1443@cork> <87lfo8m3fu.fsf@igel.home>
Date:   Tue, 10 Mar 2020 12:47:20 -0700
In-Reply-To: <87lfo8m3fu.fsf@igel.home> (Andreas Schwab's message of "Tue, 10
        Mar 2020 20:10:13 +0100")
Message-ID: <xmqqo8t4hu0n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F59092AE-6307-11EA-B98B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On M=C3=A4r 10 2020, J=C3=B6rn Engel wrote:
>
>> Something weird happened to us and I have no idea how to reproduce it.
>> A developer managed to create a git commit with the following content:
>>
>> diff --git a/foo b/foo
>> new file mode 160000
>> index 000000000000..b7e7816c1266
>> --- /dev/null
>> +++ b/foo
>> @@ -0,0 +1 @@
>> +one line of content
>>
>> File name and content obfuscated, the rest is verbatim from the git
>> commit.
>>
>> Now, file mode 160000 doesn't make sense to me.
>
> 0160000 is S_IFLNK in MiNT
> <https://github.com/freemint/freemint/blob/master/sys/mint/stat.h>.

Yeek.  That sounds like a ticking time-bomb.

