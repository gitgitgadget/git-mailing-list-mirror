Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA67C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 07:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A609922C7E
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 07:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbhAXHEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 02:04:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60240 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbhAXHEd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 02:04:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A32D293B58;
        Sun, 24 Jan 2021 02:03:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7HkWaam+8m708PRPS23RY4IwFEw=; b=dQ/6km
        kFE1IARFtoWUkBoRH+IdyMymu3LCVAIkeyvJtmFUcEP5CNpE5Em2VS4OlKDCoEQB
        /w02yLm1wczQME6jUuoOxM9ONqEURw6AdQ3cH5y5lxclQvZS54Kut3FPou4JxKh9
        rZklLO9d025ZHT0/58TqNlrs6cCUxtzkRe+fo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tPVLm7+306vutgiaIZ6VrJE1WPFumU9I
        goB2eDQXnXda2C1anUMWSm+19k239IIidP3v8gWSxCPre4BQ0Sp/1OjyqGs6ec8o
        6HM7Qq7o38ZSMEoZRD7JhXAj/ejgvKG6Jbq8jOFz1vTPNdJpUznS3dqyj5SUh3qW
        YYkYjS/HqEY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CED193B56;
        Sun, 24 Jan 2021 02:03:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E65A93B54;
        Sun, 24 Jan 2021 02:03:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #04; Sat, 16)
References: <xmqq8s8so84r.fsf@gitster.c.googlers.com>
        <CABPp-BGHpvmx-hdZ==MdODKEDVTr92m3rs4T2d_w9Aa0d0zanQ@mail.gmail.com>
        <xmqqft2ucf4p.fsf@gitster.c.googlers.com>
        <CABPp-BHMmi1A2fzkVsgEUeeMQywtU6YaCU93nq1K7301YhtpjQ@mail.gmail.com>
Date:   Sat, 23 Jan 2021 23:03:49 -0800
In-Reply-To: <CABPp-BHMmi1A2fzkVsgEUeeMQywtU6YaCU93nq1K7301YhtpjQ@mail.gmail.com>
        (Elijah Newren's message of "Sat, 23 Jan 2021 21:27:50 -0800")
Message-ID: <xmqq35yq24ve.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F7A7680-5E12-11EB-8A27-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Jan 21, 2021 at 10:35 AM Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> Even though I wanted to merge the en/ort-directory-rename down to
>> 'next' yesterday, it has just got updated and I had to rebase the
>> ort-perf branch using the material from the old thread, so neither
>> is in 'next' as of now.
> ...
> reports, it's kinda important to get it right.  So...
>
> * I'm not touching en/ort-directory-rename; I still think it is ready
> for merging to next.

By "not touching", do you mean you now want me to discard the latest
round that is on en/ort-directory-rename and revert the topic to the
previous version?
