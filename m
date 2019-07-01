Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B51D1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 16:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfGAQFL (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 12:05:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59927 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfGAQFL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 12:05:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 614256BA07;
        Mon,  1 Jul 2019 12:05:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tQFhcH48+H4cI3ZFn0UK+EXRteU=; b=Ane8UE
        cHyL8i0xtDMRMdyxFJllSEYuBHmsTSUAM69NvE1hC1MP1ILUbaCRqXpkL/SqZkhA
        8wt9IfRuNvyq8tkLINZ6W2Xff5qx/ZnfS9WuXeCBOI1qrhJVpw6xLqjVEfq46FSW
        4Zq+FJJey6NfMGkzDSSh48e5QYfHRLHkexJ5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wXGliHKRCE2bsLQWpjU0wI5GQRLtAMw+
        EJSCuBnBlVWT2PGnlRNyqqMO9nS1YiqoiR29IdfIEWkXwMNmha7rZyzcPGs9s9P1
        n4uhPk5xE3BSPq1Wty1THm6f/y1GD7jr0sJJ/7CwyvnOZJgTCkrB8obdO1oWd16r
        KcP1x/BLmdc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 59A8A6BA06;
        Mon,  1 Jul 2019 12:05:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1211C6BA04;
        Mon,  1 Jul 2019 12:05:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        t.gummerer@gmail.com
Subject: Re: What's cooking in git.git (Jun 2019, #07; Fri, 28)
References: <xmqqzhm173sp.fsf@gitster-ct.c.googlers.com>
        <20190701150228.18471-1-rohit.ashiwal265@gmail.com>
Date:   Mon, 01 Jul 2019 09:05:01 -0700
In-Reply-To: <20190701150228.18471-1-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Mon, 1 Jul 2019 20:32:28 +0530")
Message-ID: <xmqqv9wl7nbm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCCC5F68-9C19-11E9-8932-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> On Fri, 28 Jun 2019 15:17:42 -0700 Junio C Hamano <gitster@pobox.com> wrote:
>>
>> [...]
>> * ra/cherry-pick-revert-skip (2019-06-24) 6 commits
>>  - cherry-pick/revert: advise using --skip
>>  - cherry-pick/revert: add --skip option
>>  - sequencer: use argv_array in reset_merge
>>  - sequencer: rename reset_for_rollback to reset_merge
>>  - sequencer: add advice for revert
>>  - advice: add sequencerInUse config variable
>>
>>  "git cherry-pick/revert" learned a new "--skip" action.
>>
>>  Will merge to 'next'.
>> [...]
>
> Phillip[1] and Thomas[2] suggested some changes which I believe will
> improve the state of the patch series. Please wait for a little while
> so that I can send another revision.

Will wait.  Thanks for a quick note.
