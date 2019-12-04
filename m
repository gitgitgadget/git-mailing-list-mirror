Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DCDC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 16:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E5C206DB
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 16:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yXTu+zfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfLDQWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:22:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55342 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfLDQWu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 11:22:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38D2631AA7;
        Wed,  4 Dec 2019 11:22:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BKV0IhXa2TQNrl6tq+W7bKF/E6g=; b=yXTu+z
        flfrTXQSmz2SoSQFmW4YljuuLwmq1fj7itAQKtJ6AgmnLYomMwzsl8OPSL8GR/ku
        ZsQHM28CXDr+QBDOtVGKgJUyCgbgEuApop1uV78Uqh4sqe8TqYvXXnxt1u28XCk6
        1APO415NjKnDhn52qYtyRjS1aY52d5wfZqeUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FSb0UEpotj6Uirff/vxx2W8YATMC+xcX
        V+GE2b3w/+uWd46AKMrpGs9cOnu23JJzOOKJU3PnBAOe95X17KwTgGdMyGeklLir
        Lm5bl0nr0cb/XH7Z5t7vLEJcGQO7QGhtUvQsy1tJe38DBdsq9cYNhJyvAjUb2QBB
        4PB3eX4duFE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F58431AA2;
        Wed,  4 Dec 2019 11:22:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 796EB31A9E;
        Wed,  4 Dec 2019 11:22:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] contrib: git-cpcover: copy cover letter
References: <20191203201233.661696-1-mst@redhat.com>
        <20191204044449.GB226135@google.com>
        <CAPig+cTFbpAo5+kahLT+7E1zQe24S5icm0SSB=HF4xqsD2VdAA@mail.gmail.com>
Date:   Wed, 04 Dec 2019 08:22:43 -0800
In-Reply-To: <CAPig+cTFbpAo5+kahLT+7E1zQe24S5icm0SSB=HF4xqsD2VdAA@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 4 Dec 2019 00:18:28 -0500")
Message-ID: <xmqqlfrs5acs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D4DF560-16B2-11EA-BF42-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Dec 3, 2019 at 11:45 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Michael S. Tsirkin wrote:
>> > My flow looks like this:
>> > 2. vi <dir>/v<n-1>-0000-cover-letter.patch <dir>/v<n>-0000-cover-letter.patch
>> > copy subject and blurb, avoiding patchset stats
>> > 3. add changelog update blurb as appropriate
>> >
>> > The following perl script automates step 2 above.
>>
>> Neat.  I wonder, should "git format-patch" learn an option for this?
>>         git format-patch -v<n> --cover-letter \
>>                 --last-cover-letter=<dir>/v<n-1>-0000-cover-letter.patch \
>>                 -o <dir>
>
> That was my first thought, as well, although, as this has similar
> purpose to the new git-format-patch --cover-from-description= option,
> perhaps a more suitable name might be --copy-cover-from= or something?
>
> I could even imagine a new option -V<n> which has the combined effect
> of setting the re-roll count (like -v) and automagically copying the
> cover letter material from cover letter v<n-1> located in <dir>.

I actually looked into doing something similar but without any new
option (i.e. unconditionally --cover-letter with -v<n> would check
for v<n-1>-0000-cover.letter and does the right thing) some time
ago.  I do not recall why I gave up (not that I tried very hard),
but IIRC, the current reroll-count was not passed down in the
callchain to make_cover_letter() to do this.

But I think that was even before we integrated the range-diff stuff,
which does seem to use the "given we are doing <n>, let's compare
with <n-1>" thing, so perhaps it is not too difficult.

I am just saying that I think the change would not have to be opt-in,
but can be unconditionally made, simply because replacing the BLURB
HERE placeholder with *anything* written by human user previously is
a 100% improvement ;-)

Thanks.
