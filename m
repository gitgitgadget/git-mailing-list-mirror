Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB09C81CFF
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE572075E
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gPtHj7ul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgD0X1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:27:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58433 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgD0X1T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 19:27:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3E7EC8148;
        Mon, 27 Apr 2020 19:27:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/86JHPBa3yINKAuY80cgNYNnJ3c=; b=gPtHj7
        ulsyFjpc+IpVPVpr7iATag2IBZgcx7akbhNdxIS4gobiH0ouzxGBcxOKStZD+fay
        a+nVgejIPLB3yUNBZZlK/XtvxUCLFSIWip7/fWGy0ycUYTSslOodJ2NWLW4ZM7G0
        uYFsLu5RN850w79HkbggKlkP5xZaL6CI/QuAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MS9XKJ7vQuHg1ifR4aPdfTEQLrMrNipF
        xkxz+ZHEM4aNOiDQ8D3glvk8uisqt9k0OJTuQFHXXHjGXb+5kFsvvtPYF9wZsqS7
        qCn8Zrnp9X3IP59zbFP6m5zm+MiqEa3D4URlDA5x47L5iFozd7OFxXMe7YN7CGWf
        g4yJSJS+acI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D5E7C8147;
        Mon, 27 Apr 2020 19:27:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E5B3CC8146;
        Mon, 27 Apr 2020 19:27:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: drop time.h include
References: <20200425003002.GC17217@google.com>
        <20200427204859.171084-1-emilyshaffer@google.com>
        <20200427210311.GB36078@google.com>
        <xmqqh7x47har.fsf@gitster.c.googlers.com>
        <xmqqd07s7gjr.fsf@gitster.c.googlers.com>
        <20200427215619.GC77802@google.com>
Date:   Mon, 27 Apr 2020 16:27:13 -0700
In-Reply-To: <20200427215619.GC77802@google.com> (Emily Shaffer's message of
        "Mon, 27 Apr 2020 14:56:19 -0700")
Message-ID: <xmqqzhaw5x2m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0C47A68-88DE-11EA-8923-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Mon, Apr 27, 2020 at 02:41:12PM -0700, Junio C Hamano wrote:
>> 
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Jonathan Nieder <jrnieder@gmail.com> writes:
>> >
>> >> Emily Shaffer wrote:
>> >>
>> >>> As pointed out in
>> >>> https://lore.kernel.org/git/20200425003002.GC17217@google.com,
>> >>
>> >> This breadcrumb shouldn't be needed, since the rest of the commit
>> >> message already speaks for itself.  We can save the future "git log"
>> >> reader some time by leaing it out.
>> >
>> > True.
>> 
>> Well, removing these two lines made the rest non-sentence, so I had
>> to rewrite the thing.  I am not sure if the educational value warrants
>> the mention of compat/ exemption, but it people find it too noisy,
>> it can certainly be dropped.
>
> I've got a reroll to drop the "stdio.h" include too - do you want me to
> send it? Your commit message is much nicer than what I came up with on
> my end dropping the breadcrumb and generalizing to include stdio.h, so I
> can adapt it if you're interested in the reroll.

Sure.  I already queued it and merged it to 'next', but the result
hasn't been pushed out and I am bisecting a test failure in some
newish topics that are merged to 'jch' recently, so I do not mind
taking a reroll and redoing 'next' before I can push it out today.

Thanks.
