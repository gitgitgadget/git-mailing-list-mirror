Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15108211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 05:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeK2QRa (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 11:17:30 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57782 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeK2QRa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 11:17:30 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C3B13BFD5;
        Thu, 29 Nov 2018 00:13:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ijr5RL+KFUfDmOOzxShXI2f5Z44=; b=PW9/CL
        idkm1OB9e6SdH6MmU/lz4hIlWzm/zKKLbVO/30sFKmVqFtmEWT7LQ3Y1a+54k92c
        Wc3tw/pwlH0YE7oL1MCUzy7LR38VMqxMDAowYQCZgxaSX1OnbThhd0aclnKDSFqW
        4VqBY8mGkQBtWNYlhhnNhQCoF+rPKral0Ef80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CqdVMUOgx9YicKR20ONqsetWBkCjSd3X
        Gj6QCDr4tdC0Wxg9GjBFeqfnbe9ywOIV8Vog0c71kuPIRALhw+ryKkdTJ2V/zsSh
        S4pU7RbPkG/w4sjcsZE42xiOqtQp+x8l8IoncSTlx0HbIZ3g4OhXLbCZnsKSktGE
        tYKE5vvAtSw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 811E93BFD4;
        Thu, 29 Nov 2018 00:13:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8B6593BFD2;
        Thu, 29 Nov 2018 00:13:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Carlo Arenas <carenas@gmail.com>, Git List <git@vger.kernel.org>,
        Beat Bolli <dev+git@drbeat.li>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] config.mak.dev: enable -Wpedantic in clang
References: <20181127100557.53891-1-carenas@gmail.com>
        <CAPig+cT1ruGsd-7yXV3Oxs2_9zOh-d4HgZiQ-OVZzHc1buo4FQ@mail.gmail.com>
        <CAPUEsphe5E4ZrLy=NmuAHhdE4jOjYhAstOzHRNtBcuwrhvwbvg@mail.gmail.com>
        <CAPig+cQXkNo_Sztf3y5ciZ3jjj=XrJ+ESCxEsU_RKxb_0x+STw@mail.gmail.com>
Date:   Thu, 29 Nov 2018 14:13:19 +0900
In-Reply-To: <CAPig+cQXkNo_Sztf3y5ciZ3jjj=XrJ+ESCxEsU_RKxb_0x+STw@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 27 Nov 2018 14:03:43 -0500")
Message-ID: <xmqqva4gpits.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D7D7936-F395-11E8-B2B2-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Playing Devi's Advocate, what if Apple's clang "8" was, in reality,
> real-world clang 3? Then this condition would incorrectly enable the
> compiler option on Apple for a (real) clang version below 4. For this
> reason, it seems we shouldn't be trusting only the clang version
> number when dealing with Apple.
>
> (I suspect that it won't make a difference in actual practice, so it
> may be reasonable to punt on this issue until/if someone complains.)

Why do we care which true version of clang is being used here in the
first place?  Is it because some version of clang (take -Wpedantic
but misbehave | barf when -Wpedantic is given) while some others are
OK?

If the only problem is that some version of clang barf when the
option is given, perhaps we can do a trial-compile of helloworld.c
or something, or is that something we are trying to avoid in the
first place?

It appears to me that ./detect-compiler tool (by the way, perhaps we
should start moving these build-helper-tools sitting at the top level
down to ./build-helpers/ subdirectory or something so that we can focus
on the source code when running "ls" at the top level of the hierarchy)
can become more intelligent to help things like this.
