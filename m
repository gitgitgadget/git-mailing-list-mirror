Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4DEC3B1BF
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 23:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946142086A
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 23:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wmuZNbAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgBPXtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 18:49:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50806 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgBPXtq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 18:49:46 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 86EAEAE4E1;
        Sun, 16 Feb 2020 18:49:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=chERRkjbCD4HcFUhv8VK1/4DNCQ=; b=wmuZNb
        AQSZFDXGGQ8ZMnCGIJRpfkKj3eUQn71oH3hEbCoL4KgPo/GulzviZmqC7SuIJYv3
        Vj2WNH6vOkeYHJ/3HBpaPaqZZQfrVrw8q1w8C6lfizx7c+sLlrVWSOIOmk8pN6Ou
        nux5NU1duNdiT/cFCw7sttmdCHWMKTUVc9oDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F/eqAtX8TufvVW/IyLR+26ATrf7K9dyo
        YCvgEUfxXPFaxrYXMmFkXrulWixvuon0F18m6RBsDSrcKQ3M469L9bfmAIL4hinx
        ybKp+G93cuwA0KGutNgU4AVtU3fDtlNAVw3Kh77LH16U6aq1VccfrIidxQ3VNsQn
        GsfoEYsW5Xs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E91FAE4E0;
        Sun, 16 Feb 2020 18:49:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD348AE4DF;
        Sun, 16 Feb 2020 18:49:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hariom verma <hariom18599@gmail.com>
Cc:     git <git@vger.kernel.org>, johannes.schindelin@gmx.de
Subject: Re: [PATCH 2/3] t5509: initialized `pushee` as bare repository
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>
        <d156d04ca87f9fcffb1c08a08576dddcdc64c055.1581620351.git.gitgitgadget@gmail.com>
        <xmqqsgjeqm6w.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2002141252050.46@tvgsbejvaqbjf.bet>
        <xmqqpnehp5x4.fsf@gitster-ct.c.googlers.com>
        <CA+CkUQ-PERGy8xJ-a=5kzbN+N9f4uVQ35Hc4Aob70gJGz++fKQ@mail.gmail.com>
Date:   Sun, 16 Feb 2020 15:49:40 -0800
In-Reply-To: <CA+CkUQ-PERGy8xJ-a=5kzbN+N9f4uVQ35Hc4Aob70gJGz++fKQ@mail.gmail.com>
        (Hariom verma's message of "Sun, 16 Feb 2020 03:22:48 +0530")
Message-ID: <xmqqo8tym6sr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00C593FC-5117-11EA-B769-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hariom verma <hariom18599@gmail.com> writes:

> On Fri, Feb 14, 2020 at 8:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>> If the series is fixing two bugs, perhaps 2/3 can first fix it for a
>> primary worktree case by seeing what HEAD symref for the primary
>> worktree points at is the target of a push without iterating over
>> all the worktrees, have the test change in 2/3 (i.e. "fixing the
>> 'unborn' case revealed a wrong expectation in an existing test"),
>> and a couple of new tests to see what a push from sideways would do
>> to an unborn branch that is checked out in the primary worktree when
>> .denyCurrentBranch is and isn't in effect.
>>
>> Then 3/3 can use the same logic to see if one worktree is OK with
>> the proposed ref update by the push used in 2/3 (which no longer
>> uses refs_resolve_unsafe()') to check for all worktrees.  The new
>> tests introduced in 2/3 would be extended to see what happens when
>> the unborn branch getting updated by the push happens to be checked
>> out in a secondary worktree.
>
> As far as my understanding goes, what we want is:
> 1) fixing `.denyCurrentBranch` for unborn branches in primary worktree. (2/3)
> 2) writing test (expect it to fail if `unborn` & 'non-bare' case) (2/3)
> 3) making `.denyCurrentBranch` respect all worktrees. (3/3)
> 4) extending tests written in step 2 for secondary worktrees. (3/3)
>
> Correct me if I'm wrong.

If the above is what _you_ want, then there is nothing for me to
correct ;-)

What I suggested was somewhat different, though.

  1) get_main_worktree() fix you have as [1/3] in the current round.

  2) fix `.denyCurrentBranch` for unborn branches in the primary
     worktree, new tests for the cases I outlined in the message you
     are responding to, and adjusting the test (i.e. what you have
     as [2/3] in the current round).

  3) fix `.denyCurrentBranch` to pay attention to HEAD of not just
     the primary worktree but of all the worktrees, and add tests.

Thanks.
