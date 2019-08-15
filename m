Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99F821F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 16:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbfHOQ5A (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 12:57:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61365 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfHOQ5A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 12:57:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57DAA15E0CF;
        Thu, 15 Aug 2019 12:56:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CdCURay7f5SWqKGWssI9Vbu8/zA=; b=G2SGwT
        Ia/iOTq0UfT3PFnpTZti3nQFv9m18rbjf5HzAO+cdry1Mth3AE5d0TSlQGKovyG9
        zK/+XXVTfn3MniFkDpxvZmpIiyuocl4mYn7CAjfMcdkGrYKgbPMFVdr5PKvfMyo2
        PPQbG3QVkO6E3YteiN/Ra00mhZvLUAkLPEpKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qyg+XTPK+SgHwaKckSMDtABO6veGgzfl
        VS7BlIVnSepDx5Z+lBBpj4kDv5mFRjYAhJca0tG8wq07X9/w40LObOzM9jozj+UR
        tpRHDdEphh3SIMZdecPWDPQ4VdjbKFx5eeMYZuXl1SuVj5j4BEvA8fbyhwNQbTxn
        X0lkPAWy7qg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D41315E0CE;
        Thu, 15 Aug 2019 12:56:58 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9CB9615E0CD;
        Thu, 15 Aug 2019 12:56:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2019, #04; Wed, 14)
References: <xmqq36i35tfv.fsf@gitster-ct.c.googlers.com>
        <CAHd-oW4kMr+Q1GhNQ7B7RW2hafqokvUoxg9qkXXyt98L53=Ahw@mail.gmail.com>
        <CAPUEspjWbHC2md3kFu8O88275pYSzpFmu9kjHEn4_0_hjxZ8MA@mail.gmail.com>
Date:   Thu, 15 Aug 2019 09:56:56 -0700
In-Reply-To: <CAPUEspjWbHC2md3kFu8O88275pYSzpFmu9kjHEn4_0_hjxZ8MA@mail.gmail.com>
        (Carlo Arenas's message of "Wed, 14 Aug 2019 19:15:50 -0700")
Message-ID: <xmqqef1m4baf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1387654-BF7D-11E9-9B39-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Wed, Aug 14, 2019 at 4:58 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
>>
>> On Wed, Aug 14, 2019 at 6:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> [...]
>> > * mt/grep-submodules-working-tree (2019-07-30) 1 commit
>> >   (merged to 'next' on 2019-08-02 at e1a46a195f)
>> >  + grep: fix worktree case in submodules
>>
>> There is a new version of this patch here[1], addressing the comments
>> you and Christian made.
>
> since it is already in next, would be better to submit a patch on top
> of the current topic instead (more details in
> Documentation/SubmittingPatches).

Thanks.  Or we could just go the lazier route.  A new stable release
would happen within a day or two, and then in a week or so after that,
the tip of 'next' gets rewound and rebuilt on top of it.  We can
discard the older copy and replace with the newer one when it happens.
