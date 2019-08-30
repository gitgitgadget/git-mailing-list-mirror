Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EF141F461
	for <e@80x24.org>; Fri, 30 Aug 2019 20:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfH3U1i (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 16:27:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58925 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfH3U1i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 16:27:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5BA2E7789B;
        Fri, 30 Aug 2019 16:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=g3VIFqU7i5fF
        uKLimDtmbk88KlE=; b=dPPkwqjeH1lOqj6r4a3GHU5n6A52DbNhe+zXbtuLBLVU
        /v7GGetCeFsLowvrVKe8dA/sEj77QtE82IknP1+aPlOwsoIZhoESoeptIZ+PXwBV
        /guk9zDTGW/GiyzUffEd2SUbTpy8uLCyOnwxE1fKugPF8wIqNkXhdEyuWH9/zww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=T8U6Io
        B/0n0g625yBmnI7UsxggLsPay+cxChfzSoKQSsNepNMfv1SM/GAP0gV1vHTsKJNV
        aQ97BrUOy7JnWlWHelMCiIjqF+iv7TKQXD1NI+c1DcUcrWFK6Odi4WMDPVG4jmiu
        ZNujf3AwMzdewouj0I248xVzSgaQls1bh8X7E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 538697789A;
        Fri, 30 Aug 2019 16:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 81D1F77897;
        Fri, 30 Aug 2019 16:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v2] merge-options.txt: clarify meaning of various ff-related options
References: <877e6x3bjj.fsf@osv.gnss.ru>
        <20190828155131.29821-1-newren@gmail.com>
        <CAN0heSoqy4sCY8NUWKuEkXwe2XxnYAN6Mn2N75hYwfQ_5WGYdQ@mail.gmail.com>
        <xmqqef12xwr4.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGsPEikU=KZgZgMbSLFn7Cf+fy0L==w8m4Wk95BnpHj+Q@mail.gmail.com>
Date:   Fri, 30 Aug 2019 13:27:28 -0700
In-Reply-To: <CABPp-BGsPEikU=KZgZgMbSLFn7Cf+fy0L==w8m4Wk95BnpHj+Q@mail.gmail.com>
        (Elijah Newren's message of "Fri, 30 Aug 2019 12:48:59 -0700")
Message-ID: <xmqqef12wg9b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 97345D84-CB64-11E9-B00E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Aug 30, 2019 at 12:45 PM Junio C Hamano <gitster@pobox.com> wro=
te:
>>
>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>
>> >> +--ff::
>> >> +       Whether to only allow resolving the merge as a fast forward
>> >> +       (only updating the branch pointer to match the merged branc=
h
>> >> +       and not creating a merge commit), to never allow it (always
>> >> +       creating a merge commit), or to prefer it when possible.  T=
he
>> >> +       default is --ff, except when merging an annotated (and
>> >
>> > It would be great if you'd write this as `--ff` so that it got
>> > monospaced in the rendered documentation. ...
>> > I'd also write `refs/tags/`, but I realize that you're just inheriti=
ng
>> > what is already here. ...
>>
>> These comments may sound nitpicky at times, and some parts may be
>> beyond the scope of the discussion on the patch and are better left
>> for a later time, but the consistency is valuable.
>>
>> Thanks for mentioning them; and it would be appreciated if these
>> suggesions are followed through after the dust settles.
>
> I'm confused; these suggestions were incorporated into V3 already.  Am
> I misunderstanding something here?

I was assuming that outside the context of the patch there also are
the same malformatted reference to refs/blah and --option "you're
just inheriting", which would be cleaned up outside of this topic
after the dust settles, if the suggestions are followed through.



