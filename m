Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAF0D2047F
	for <e@80x24.org>; Mon, 25 Sep 2017 00:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933355AbdIYAke (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 20:40:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55467 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932769AbdIYAke (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 20:40:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B69A59A7EF;
        Sun, 24 Sep 2017 20:40:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9OPwxLTyDqEdefkjp8lxkwrg2kg=; b=eJXY6O
        44pmfVcUi1jZqnZgHkTt63FwIKhRNjMDj6Eii6aR7Dsd4c5C2iF4lsNsU42KI2nR
        iq+U7Aup1iiS07owFGs/Oe/fyCil+jWPHgioLfUVciEuyBqW/WywBV4A0WPPapeD
        m3pjDuowkBw0W3+G0VSLAgKWizmQOs/chHous=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hMa4wIzbA7jL6tzNHHL82cDx3LKNpmDh
        T8v56LKzTZnaqXrFXM+o4uf2UD7bsD9sAi6FZ1yKnhMffOZ5FGkKrZhXi8527Fy6
        Tb4JzRqDkxwBpuQl/mzm4B6YqUKqq+OFJscO6zfO9di+xYSNbyXZVCCSNorlsp5O
        FqSMm1L1Glc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADE3B9A7EB;
        Sun, 24 Sep 2017 20:40:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E7C69A7E9;
        Sun, 24 Sep 2017 20:40:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2017, #03; Fri, 15)
References: <xmqq8thgy03t.fsf@gitster.mtv.corp.google.com>
        <CALiud+m1PAD8r0ygoUj3g4LzQjdoPu0CmjiejyG8pHOhr3Fk=Q@mail.gmail.com>
        <xmqqpoajmtu4.fsf@gitster.mtv.corp.google.com>
        <xmqqlgl7l7ul.fsf@gitster.mtv.corp.google.com>
        <CALiud+mjN=cTg_CXWNWnE=0N5RiT-FEN5JMGbYW0byMbmexQvQ@mail.gmail.com>
Date:   Mon, 25 Sep 2017 09:40:31 +0900
In-Reply-To: <CALiud+mjN=cTg_CXWNWnE=0N5RiT-FEN5JMGbYW0byMbmexQvQ@mail.gmail.com>
        (Sahil Dua's message of "Sun, 24 Sep 2017 18:16:48 +0200")
Message-ID: <xmqq7ewnhaps.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23822890-A18A-11E7-96B1-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sahil Dua <sahildua2305@gmail.com> writes:

> On Fri, Sep 22, 2017 at 5:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> So here is such an update.  As the topic is not in 'next' yet, it
>> could also be implemented by replacing patch(es) in the series, but
>> doing it as a follow-up fix made it easier to see what got changed
>> (both in the code and in the tests), so that is how I decided to do
>> this patch.
>>
> Awesome! Thanks for the patch. It was easier than I'd have expected it
> to be. Looks like it fixes the concerns of moving head. Is there
> anythign required from my side on this features / series of patches?

If you now agree with the updated behaviour and think it makes more
sense that "git branch -c new HEAD" does not check out 'new', then
there is nothing required.  Well, other than the usual finding,
reporting and optionally fixing bugs in the documentation and the
code, that is ;-)

Thanks.
