Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC928C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 19:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE7023ACA
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 19:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbhAVTUD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 14:20:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61093 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbhAVSrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 13:47:16 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0852C933E4;
        Fri, 22 Jan 2021 13:46:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lc3J4OidTKQURNDxtoHi5ULFsjU=; b=Kgsixa
        QZaE0r/MSldTWhljcN50KXiOOl+P06YmqBUX7CNYKyz49oEFaOfay1aZurgdwnRf
        xiQfzy36TvYqSMX2sz6kBcXBlGe5+Gkf1iR5wUeUxxdwa2sMbuaiNcqGi/spRDZq
        y2E32KpqoerLuUlFrxpV72hiQL5BM4MCLSjQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nr6QNBDDn+crsWEp7Z3k9adL9hpZ1L9R
        zg0PA/Cc8kl3TVS3YzcIwk7Rid3Il/z4MrV7ZbVjDEoHOko02mEvA4dynMF4s797
        ChZS0Wul+owry32rr2u2EO9Q6F0ijTz9CZsxBMdk2AaPmRy9KIkuXm0eq/vG3EN7
        +BlIrc1PuyI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3046933E3;
        Fri, 22 Jan 2021 13:46:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A4E8933E2;
        Fri, 22 Jan 2021 13:46:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     "Patricia B. C." <pati.camsky@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Can git change?
References: <CAK8LAYVZKjbMEDWTyvQv2eY+qR0qw1=mn=c4KCZvit7gsqTibA@mail.gmail.com>
        <CAP8UFD0fZBdZ6qwDP9_yW7VAfskTKPC7HVSpK4rD=bORuECpJA@mail.gmail.com>
Date:   Fri, 22 Jan 2021 10:46:32 -0800
In-Reply-To: <CAP8UFD0fZBdZ6qwDP9_yW7VAfskTKPC7HVSpK4rD=bORuECpJA@mail.gmail.com>
        (Christian Couder's message of "Fri, 22 Jan 2021 14:31:57 +0100")
Message-ID: <xmqqpn1w95dj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 260561EC-5CE2-11EB-BCFF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Hi,
>
> On Fri, Jan 22, 2021 at 2:05 PM Patricia B. C. <pati.camsky@gmail.com> wrote:
>>
>> Hello!
>> My name is Patricia and I work as a software engineer in Brazil. I
>> also teach sometimes at Le Wagon, a programming school.
>> I brought the discussion about changing our repositories' branch to
>> main instead of master. The response of one of the owners was that
>> "Git has not changed it, so we will not change". So here I was,
>> wondering if maybe Git would hear me out :)
>> Do you have any thoughts on it?
>
> There have been a lot of discussions about this topic. You can find
> some pointers to them (though maybe not the most recent ones) in the
> article "The history of `master` in Git" in:
>
> https://git.github.io/rev_news/2020/07/29/edition-65/
>
> There has been also an official statement by the Conservancy and the
> Git PLC (Project Leadership Committee):
>
> https://sfconservancy.org/news/2020/jun/23/gitbranchname/

I got an impression that Patricia wanted to follow what we do to
this project, but AFAIU, both of the above are about what Git does
to help end-user projects to rename.  They do not talk about what
branch this project uses.

A much more relevant direct reference is the brian's assessment for
us to switch in Edition 65, plus the test clean-up series from
Dscho.

Having said all that, imitating what we do to our project may
probably not be a good idea.  We have done, and we will do in the
future, experimental things, some of which may turn out to be bad
ideas [*1*].  The users are probably better off imitating projects
with larger developer base.


[Footnote]

*1* subtree merging of gitk and git-gui, for an example, and having
    an octopus merge in the history is another.
