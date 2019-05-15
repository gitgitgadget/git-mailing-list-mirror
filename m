Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789071F461
	for <e@80x24.org>; Wed, 15 May 2019 08:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfEOIxC (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 04:53:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52593 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfEOIxC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 04:53:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8F74145AD4;
        Wed, 15 May 2019 04:52:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R74354VX7yb4Br91ZHiYgwqF190=; b=j+6fxP
        H222VvoTd8faXHLD5yYem9J/HO/dIoS5uZiuISR91j8iKnzWJpGeigGNmNrEJWpH
        99PSeDDSGyqllDhVy+w2BxW9qh2CVZh9sAr6ijBNJyb5wWdFhfeeMnh9eGvAmfaN
        mBKaCGh7eIACTj1wfS6/7q5pUECymXBPiMb1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dNtFVkokq8kwN+JKK3lOd0ct/7K6zHrl
        zTE8+qgaTnSQVfh6al4HICd4w3h8bgkq8WfD7Awx0/FOLEPMHrF3vGJvJ2siU3qO
        uXvdqOSqjwgTufVu7TGzir1uKgWGQQMEFU2JI7GaNEjmrIeP8GWn1HlFk4RqmvZz
        JAu3WxY6NaQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CD87145AD3;
        Wed, 15 May 2019 04:52:59 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DFAB5145AD2;
        Wed, 15 May 2019 04:52:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/1] stash: document stash.useBuiltin
References: <pull.193.git.gitgitgadget@gmail.com>
        <6c250451658f34c1415bfcba35ee6303cecac0dc.1557825553.git.gitgitgadget@gmail.com>
        <CAPig+cRoyOJrEuVY109NKafTCUc399p9tk64L9sZok=AOZ1MPg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1905151025580.44@tvgsbejvaqbjf.bet>
Date:   Wed, 15 May 2019 17:52:57 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1905151025580.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 15 May 2019 10:26:36 +0200 (DST)")
Message-ID: <xmqqo9445cba.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6C98E1C-76EE-11E9-AD5D-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> See a few nits below, none of which are necessarily worth a re-roll.
>
> Thanks!
>
> Junio, do you agree, do you want to fix it up on your side?

I think you'd see all of them in what I've pushed out.

>> > +one-off testing you should report the behavior difference as a bug in
>>
>> s/testing/&,/
>>
>> > +git (see https://git-scm.com/community for details).
>>
>> s/^git/Git/

The last one might be a bit iffy, as we are talking about (a
possible bug in) a specific implementation of "git", as opposed to
Git as general concept, but I took it anyway.

Thanks, all.
