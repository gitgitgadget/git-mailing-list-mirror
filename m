Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280FCC433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 21:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245370AbiCNVsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 17:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiCNVsc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 17:48:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BCB3A5F7
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 14:47:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52CDA11225D;
        Mon, 14 Mar 2022 17:47:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9YDCHnOvTU1H1VbA3fyibV1YYIW2zaBzjTjMkD
        xkh6Q=; b=IdIFjiXiV7v5B4+klM3zbeEdm6KsSixtxKEu9n9BzXstN4pB0u+nol
        vPYdpouLyAPP/D5VvnOSAfmoNO3LoOQh+JO0AeylTaUBaptedjdGbXftg7RxeS2Q
        uzDVmLH+gCerlz55JAUCrB2EQjDFQ1ETuGSjvt8yq0z6WlK0a64Mo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 48A3E11225C;
        Mon, 14 Mar 2022 17:47:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD34A11225A;
        Mon, 14 Mar 2022 17:47:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/2] rebase: use test_commit helper in setup
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
        <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
        <f3f084adfa616a7bae7e7c94644f65a36f38652b.1647019492.git.gitgitgadget@gmail.com>
        <xmqqee36watb.fsf@gitster.g>
        <4072d712-4138-6cf0-e0e0-5a3303ce010a@gmail.com>
Date:   Mon, 14 Mar 2022 21:47:18 +0000
In-Reply-To: <4072d712-4138-6cf0-e0e0-5a3303ce010a@gmail.com> (Phillip Wood's
        message of "Mon, 14 Mar 2022 10:52:34 +0000")
Message-ID: <xmqqk0cwnr4p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 534E3FCA-A3E0-11EC-A284-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 13/03/2022 07:50, Junio C Hamano wrote:
>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> From: John Cai <johncai86@gmail.com>
>>>
>>> To prepare for the next commit that will test rebase with oids instead
>>> of branch names, update the rebase setup test to add a couple of tags we
>>> can use. This uses the test_commit helper so we can replace some lines
>>> that add a commit manually.
>> OK.
>> 
>>>   test_expect_success 'prepare repository with topic branches' '
>>> -	git config core.logAllRefUpdates true &&
>> This lossage is not explained.  I do not know if we actually make
>> use of the reflog in the tests, though.
>
> It is the default these days so we don't need to waste a process
> setting it here.

I said "not explained" in the log message.  I didn't ask anybody to
explain it to me or to readers on the list.

Thanks.
