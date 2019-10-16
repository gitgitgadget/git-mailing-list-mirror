Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6161F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 01:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfJPBZW (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 21:25:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64175 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfJPBZW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 21:25:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE604A3115;
        Tue, 15 Oct 2019 21:25:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UrvsgNG8gEKXHmCeI8IkTz6YAoE=; b=Yp4MkM
        qcnruqYFpIbB1KG95GHeMfos2jNn5A4T+ppn6utnR0VYkuKpaMmYaYvGX5Sf6NAV
        EgyNnPRaZQfub6JL0QBEMUSs4P/IIswZCX6YQ8rxGfR0XULn5JB3Fnl8otypzQIF
        93P+WQc7a2R1+wfKArmhaTBG8XZqPFYzRy9/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i+VJur61lfgUxpxYPmHp+NnD7mKPjl89
        OYZn9bbj6A8hDf4NBAU5r2lPaPxaJv/GlhnAdoD3WIddLA5PpHyNx6PG+OErJHbQ
        L40WajrDb05YcFUL99S0RwkxN93rPBdy/crUnMu0FvznV9EBAb2biw6OnO6w/cQn
        Cv+zsLCjhqg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A6DF6A3114;
        Tue, 15 Oct 2019 21:25:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AB5D4A3112;
        Tue, 15 Oct 2019 21:25:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2019, #04; Tue, 15)
References: <xmqqh84abmjm.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHnSG+PtnU=jKHW2_hfLtBK1Sib_W+nqY08gGj8yHGCgw@mail.gmail.com>
Date:   Wed, 16 Oct 2019 10:25:16 +0900
In-Reply-To: <CABPp-BHnSG+PtnU=jKHW2_hfLtBK1Sib_W+nqY08gGj8yHGCgw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 15 Oct 2019 08:17:06 -0700")
Message-ID: <xmqq8splbhxf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D076F03E-EFB3-11E9-A699-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> * en/merge-recursive-directory-rename-fixes (2019-10-12) 2 commits
>>   (merged to 'next' on 2019-10-15 at ebfdc3ff7b)
>>  + merge-recursive: fix merging a subdirectory into the root directory
>>  + merge-recursive: clean up get_renamed_dir_portion()
>>
>>  A few glitches in the heuristic in merge-recursive to infer file
>>  movements based on movements of other files in the same directory
>>  have been corrected.
>>
>>  Will merge to 'master'.
>
> I'm surprised this one was merged straight down to next; perhaps I
> should have highlighted my plans a bit clearer in the thread?

My mistake.  I am willing to revert the merge to give the topic a
clean slate.  Just tell me so.

Thanks.

> Also, a very minor point but "glitches" may be misleading; it suggests
> (to me at least) a malfunction rather than a failure to trigger,...

I used the word to mean a failure to trigger (after all, a heuristic
that fails to trigger when most people would naturelly expect it to
is showing a glitch in that case).  A better phrasing, please?
