Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22468C4167E
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380102AbiDDVVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380346AbiDDTj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 15:39:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFBA13EA3
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 12:37:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7BAE9191BF6;
        Mon,  4 Apr 2022 15:37:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9JCbWJ2SVHN+
        LmaQq/w7XWjbI9SSBReTI8QumAnVJs4=; b=nj7Wil8krRiCBgONTbAZSJcTqAWo
        4GDdU7bJoitofpDODRBGiMIUEjCd4p6PiqIddcxghdrwwJ+TY8vMMJNDKeiXb4JA
        KVzdRTbmGQ3BpPjXr8flF1qIgEoPptM3TtB48kQmBHzfrWRMqsvt+fceZrJgbHfi
        8+SzX8AxWz6we3s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 744FF191BF5;
        Mon,  4 Apr 2022 15:37:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4D3E6191BED;
        Mon,  4 Apr 2022 15:37:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, prohaska@zib.de,
        eyvind.bernhardsen@gmail.com
Subject: Re: [PATCH] convert: clarify line ending conversion warning
References: <20220404055151.160184-1-alexhenrie24@gmail.com>
        <xmqqtub8rdrw.fsf@gitster.g>
        <CAMMLpeQUZ3OfP=G-qKRjUVON=hninYEDQeeCrAdfM9maAZ3j7Q@mail.gmail.com>
Date:   Mon, 04 Apr 2022 12:37:26 -0700
In-Reply-To: <CAMMLpeQUZ3OfP=G-qKRjUVON=hninYEDQeeCrAdfM9maAZ3j7Q@mail.gmail.com>
        (Alex Henrie's message of "Mon, 4 Apr 2022 11:21:24 -0600")
Message-ID: <xmqqtub8prm1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A8C1A4E6-B44E-11EC-BD08-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

>> I have mixed feelings with this change, even though I agree that the
>> original is not good.  The first sentence of the updated text
>> already says that right now, the file ends with CRLF, and that the
>> conversion happen the next time you check out the file to the
>> working tree.  And that makes "For now ... still" totally redundant.
>>
>> Perhaps a single sentence, nothing more than
>>
>>         warning: in '%s', CRLF will be replaced by LF the next time
>>         you check it out
>>
>> is sufficient?  I dunno.
>
> I like your idea to move the file name to the start of the message,
> and I think that will address =C3=86var's concern as well.
>
> It doesn't matter to me whether the message is one sentence or two
> sentences. If you have a slight preference for one sentence then let's
> just do that.

"For now" smelled like sending a wrong and/or confusing message.  Is
it "for now" until we update the software, and with future versions
of Git, "git add" will pretend as if the user immediately checked it
out?

While I do not care too deeply between one and two sentences,
getting rid of the seemingly redundant "For now" sentence will
remove the source of such confusion, so ....


