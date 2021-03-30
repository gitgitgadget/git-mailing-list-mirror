Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C5EC433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 22:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D17619BC
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 22:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhC3W6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 18:58:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60275 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbhC3W6C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 18:58:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F36612E847;
        Tue, 30 Mar 2021 18:58:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aWvKW2e5ccv1MR+ejsHlJRhdfIc=; b=DzN7B7
        muMzQN68HGwgOFDmpBLqUe8Zk8eXexNnwCmFhnjER7YmJCbSPuE/Gq84/HH+aAUK
        NWPq6k+2dQFTRTSRzrc6Zthrz2N9wsL1AI66y1ytRVM8X0fuBrieY8j2BdZjdULX
        Ubb0AlENmVPx2M20JORYFuCeKgp1hp6QK6SuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qwXLXol/bZgdpvOW8nYLFvJkrlYdvVcQ
        k+fq4zpgGyOuFNg3aFJivSh9HysFbH4IEAfJx/7z2RI+x7bCKo+mZZOLgsoa2jYy
        8dKcyyXe0RBH/9hg1db0+mM8Ql7a2fioQYH5Bc6H4DICL2up9nAkpYpe+S6nPFnK
        ugu3ep1pg/s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3684A12E846;
        Tue, 30 Mar 2021 18:58:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 13EC412E842;
        Tue, 30 Mar 2021 18:57:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Dominyk Tiller <dominyktiller@gmail.com>,
        Git List <git@vger.kernel.org>,
        Dominyk Tiller via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] persistent-https: add go.mod to fix compile
References: <pull.989.git.git.1617109668438.gitgitgadget@gmail.com>
        <xmqqy2e4cvbl.fsf@gitster.g>
        <3dd5a0cd-94cc-e7ec-b1b1-feb39c65e85d@gmail.com>
        <xmqq1rbwcn4a.fsf@gitster.g>
        <CAPig+cRmJLkkzsROuUifah2-RgSoEXmLnBDV8-a8iL3jF0CBLQ@mail.gmail.com>
Date:   Tue, 30 Mar 2021 15:57:56 -0700
In-Reply-To: <CAPig+cRmJLkkzsROuUifah2-RgSoEXmLnBDV8-a8iL3jF0CBLQ@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 30 Mar 2021 18:12:54 -0400")
Message-ID: <xmqqpmzgb66j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5ECE9AB8-91AB-11EB-A83E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Mar 30, 2021 at 6:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>> In any case, explaining these things in this response is good, but
>> eventually we need to make sure that the readers of the resulting
>> commit would not have to ask the same question, without having to
>> refer to external documentation.
>
> It might also be worthwhile -- for the non-Go readers -- for the
> commit message to mention that this addition of a `go.mod` file does
> not hinder those stuck with old pre-module versions of Go (it doesn't
> help them either, but that's less significant), thus this change does
> not require them to update to a modern version of Go (i.e. we're not
> raising the minimum required version).

Thanks for spelling out the most important part of what the readers
should be able to read from the resulting commit.  I agree that
piece of information is a must.



