Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83F7C1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 16:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbdHVQLr (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 12:11:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65297 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751303AbdHVQLk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 12:11:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F224B05DE;
        Tue, 22 Aug 2017 12:11:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zckv+OY7YeizzZhfH2i4wcbwvjA=; b=RrgQfx
        rIieLJSW6dE9S4SQMZbjx91qp3gyQBcwLQMXWy8LYLGFpHx+3V7F2sxOK1GaY2KH
        u0IyfxqquYJXydN/g8DrY/mhU29HL56pu/Hp0GpQniuQkgIpWfhA2INWtsiMStj2
        Ew+UI46yfBNqzoFmEcnmbjaxb0Hi18kYqXU18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dA/KrxitgpzQNS25+/HS/pfTrR1C4cuT
        tyUmX7/zoFPfRrnYveVN8kHkh2yk/Xt7PCAdGxfiLoIVoFfl49dkGqTvdZVP8rsY
        jX9kKCZ64+4kArffCmvVDLag74FNgZFj/n4GHZ13d6P0S225VmgRKWoGvzXUYVsQ
        mdnXl2BRnns=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 276D4B05DD;
        Tue, 22 Aug 2017 12:11:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 69C22B05DC;
        Tue, 22 Aug 2017 12:11:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     hIpPy <hippy2981@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Michael J Gruber <git@grubix.eu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] Documentation/git-merge: explain --continue
References: <cover.1503319519.git.git@grubix.eu>
        <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
        <ddd9c06813f8e2e9d8160f2ed965e728190bc573.1503319519.git.git@grubix.eu>
        <CAN0heSrG7ackEW1BMpadNnPKSUCXATbxfUykcpppC6-Y2OCWJQ@mail.gmail.com>
        <8e8c8cdc-cad8-550d-9669-3f078f0d77d1@grubix.eu>
        <CAN0heSq0t=Jkaq-dgt_T4K9an4Peat0jArRQgE6JgsWwu53FPw@mail.gmail.com>
        <CAM_JFCzq+DPUFbC60kjNjHz3OZLt-X3bLXJdSFpBnATtZ6otdA@mail.gmail.com>
Date:   Tue, 22 Aug 2017 09:11:38 -0700
In-Reply-To: <CAM_JFCzq+DPUFbC60kjNjHz3OZLt-X3bLXJdSFpBnATtZ6otdA@mail.gmail.com>
        (hIpPy's message of "Tue, 22 Aug 2017 08:24:56 -0700")
Message-ID: <xmqq1so34m6d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9461658A-8754-11E7-B100-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hIpPy <hippy2981@gmail.com> writes:

> I think 'git merge --continue' should be advertised more that 'git
> commit' as typically one is familiar with 'git rebase --continue' and
> 'git cherry-pick --continue'. I for a long time did not know I could
> also use 'git commit' to continue a merge but that's just me.

Perhaps.  "rebase" and "am" (and range pick "cherry-pick A..B") are
operations that works on more than one change, so it makes perfect
sense to have a way to say "I am done with this step. Please go on
and do the rest".

There is no "go on and do the rest" after resolving a conflicted
merge, as "merge" is, unlike the other ones to which "--continue"
legitimately has a reasonable meaning, an operation that does just
one thing.  From that point of view, "git merge --continue" is a
mistaken UI that shouldn't have happened.


