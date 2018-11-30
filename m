Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F65E211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 14:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeLABXQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 20:23:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59451 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeLABXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 20:23:16 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FE0411588A;
        Fri, 30 Nov 2018 09:13:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8xYmlE8ASKs4sRPaH/ROG6CGgO0=; b=H8BLAV
        nfjszhSr/jDw5kznQl3PGAOnN2j48hKF/fGlaq20vCCkwey34CoGExl79vwElBSJ
        O/EfoNH5tz4FCQsIQ6G/vQa1G8g/YmgtL7fi0WSNc1VhrtjmeiGZ4NeKV7FMbEzx
        pXH5Sucyhp1NiLeTau/vmujhe/pzV+1oljd20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fm5oBWlXjzAk4xUEFi7BI2Ytn8q4wlmC
        xMMC3g0QtCRJXksRcdMdupg3kpjwTLfWkWwNNU17l5BnfljYwnMXAzw8VIc2xW+/
        Cnuz4iYEskjmvoLcrJFPdbK93XssecfFwNT5P+oGh6vUXaByTMaZxvkG3kOL9gB1
        krTioPLeb84=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 860CA115889;
        Fri, 30 Nov 2018 09:13:49 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E5F87115888;
        Fri, 30 Nov 2018 09:13:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: en/rebase-merge-on-sequencer, was Re: What's cooking in git.git (Nov 2018, #07; Fri, 30)
References: <xmqqva4fj62k.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811301429220.41@tvgsbejvaqbjf.bet>
Date:   Fri, 30 Nov 2018 23:13:47 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1811301429220.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 30 Nov 2018 14:31:57 +0100 (STD)")
Message-ID: <xmqqpnumk604.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 281F6DDA-F4AA-11E8-9537-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 30 Nov 2018, Junio C Hamano wrote:
>
>> * en/rebase-merge-on-sequencer (2018-11-08) 2 commits
>>  - rebase: implement --merge via git-rebase--interactive
>>  - git-rebase, sequencer: extend --quiet option for the interactive machinery
>> 
>>  "git rebase --merge" as been reimplemented by reusing the internal
>>  machinery used for "git rebase -i".
>
> I *think* a new iteration has landed (which has 7 instead of 2 commits):
> https://public-inbox.org/git/20181122044841.20993-1-newren@gmail.com/

"Landed" as opposed to "be in-flight"?  

You got me worried by implying that I merged them to either 'master'
or 'next' where it is harder to back out ;-).

During the freeze, especially after -rc1, I stop paying attention to
anything other than regression fixes and fixes to the addition since
the previous releases, unless I have too much time and get bored and
the new topic is trivial (which often means a single patch).

I'll mark the topic with the following, and continue ignoring it (or
any other topics) for now.  Thanks.

* en/rebase-merge-on-sequencer (2018-11-08) 2 commits
 - rebase: implement --merge via git-rebase--interactive
 - git-rebase, sequencer: extend --quiet option for the interactive machinery

 "git rebase --merge" as been reimplemented by reusing the internal
 machinery used for "git rebase -i".

 Reroll exists.
 cf. <20181122044841.20993-1-newren@gmail.com>


