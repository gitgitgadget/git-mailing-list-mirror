Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C53F1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 04:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfJKEZC (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 00:25:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62358 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfJKEZC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 00:25:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3512498D00;
        Fri, 11 Oct 2019 00:25:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jUTQo8os9f4ZTSgk4Kp4ebLULjk=; b=N1U9pP
        zlxoOQN1lq/R0hKDdJknvqw1Q2Pfi6SrKBBTO4PJsn9scOUaaEC3Zd2TC2wZBuUu
        Dme3+OlhHdZOaUpgoQT5HzFRnqeh1HdUW31Og2ECFgvarkvwUdfwYxracUCpi/8N
        nbj3TpMpQn8+hXyqDXPDw3f8tC5VP/QqjRTM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MiHCkN+G+xYw6+YZnsSfaxvjqUVycCsx
        H9wupE3/rcXSKQAfzy5s1a7P/blOArxb+tZbZa47nJgwXJFbDyK3TEonQRE5wsgu
        lklCy07tIlJPfI1alv/MN/Ri805snRvtdokH3od3xTWNtrvB+jrl0xUHArwNeVTY
        T7hTer81YqI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2CF0698CFF;
        Fri, 11 Oct 2019 00:25:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5FA9998CFE;
        Fri, 11 Oct 2019 00:24:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] sequencer: use run_commit_hook()
References: <pull.388.git.gitgitgadget@gmail.com>
        <420ecf442c729878da5219f3c718dd136e4fa2b4.1570732608.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1910102314390.46@tvgsbejvaqbjf.bet>
Date:   Fri, 11 Oct 2019 13:24:55 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910102314390.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 10 Oct 2019 23:15:52 +0200 (CEST)")
Message-ID: <xmqqk19bj4dk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14FFDF64-EBDF-11E9-B23D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  builtin/commit.c | 22 ----------------------
>>  commit.h         |  3 ---
>>  sequencer.c      | 45 ++++++++++++++++++++++++++++++++++-----------
>>  sequencer.h      |  2 ++
>>  4 files changed, 36 insertions(+), 36 deletions(-)
>
> Hmm. I would have thought that `commit.c` would be a more logical home
> for that function (and that the declaration could remain in `commit.h`)?

Good correction.

Thanks.
