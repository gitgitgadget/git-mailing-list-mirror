Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC97A1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 02:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436713AbfJXCOh (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 22:14:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63140 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436605AbfJXCOh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 22:14:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 702571CCCF;
        Wed, 23 Oct 2019 22:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yJj/xBtIgYNS5YS66Q+DUT7S5cA=; b=uNS/U4
        FlWb2IL3/hPutTnjrva6RFXD48KJSoLstzSDiboytai3C138yNKYkTUDcNNgzpr6
        wI8fJJpROBmWRTGjATXu/biBcC9B/kyzskjJ3lj7ONP1AAPuuW+bpq3c9UsgvCIF
        imuwDymfpxo33c8yMuWDlX/jGEkWk+5UhCcq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hS8yQeIWaq9b1G7EQBXCspbbkEgIR4+p
        BZiPopo7JLRoHw9kpL9T2v7uR14vz7yz+ZTVj5zAKcQkC87PgrG3t8YaAyqcQtbl
        jzKJ7Kx8KqVFVLwiuzFkF1k4hrOO6ZZ7xhHl1YpssHbx8Z8r8kJxZJVPTTyXaQi9
        C451kjlCFYE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6595E1CCCE;
        Wed, 23 Oct 2019 22:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CBF441CCCD;
        Wed, 23 Oct 2019 22:14:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v3 1/1] config: move documentation to config.h
References: <pull.405.v2.git.1571727906.gitgitgadget@gmail.com>
        <pull.405.v3.git.1571808652.gitgitgadget@gmail.com>
        <d6cbb3197af2c59f0222c7806ab6a6fcdf83869a.1571808652.git.gitgitgadget@gmail.com>
        <20191023213834.GA124161@google.com>
Date:   Thu, 24 Oct 2019 11:14:33 +0900
In-Reply-To: <20191023213834.GA124161@google.com> (Emily Shaffer's message of
        "Wed, 23 Oct 2019 14:38:34 -0700")
Message-ID: <xmqqeez2hoty.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05C37982-F604-11E9-9BC1-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Wed, Oct 23, 2019 at 05:30:52AM +0000, Heba Waly via GitGitGadget wrote:
>> From: Heba Waly <heba.waly@gmail.com>
>> 
>> Move the documentation from Documentation/technical/api-config.txt into
>> config.h as it's easier for the developers to find the usage information
>> beside the code instead of looking for it in another doc file, also
>> documentation/technical/api-config.txt is removed because the information
>> it has is now redundant and it'll be hard to keep it up to date and
>> syncronized with the documentation in config.h
>> 
>> Signed-off-by: Heba Waly <heba.waly@gmail.com>
>
> Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
>
> Thanks for the effort, Heba. (I guess you are an expert on git-config
> now!)

Thanks, both.  Will queue.
