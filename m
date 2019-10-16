Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5279D1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 01:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390482AbfJPBcJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 21:32:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57317 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfJPBcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 21:32:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C13E333E14;
        Tue, 15 Oct 2019 21:32:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bZCcB1CBEPrOHqZ570iXw3BbCJs=; b=bbMetn
        SWMHq7MyU/JLh1iFHXr+dY4YKn2yTBnYfDwx7qEOy12MiwKu2LUNyy+CgPPEpn33
        UEq3IhqvQi63t9GAMv6t34TTMvI6hfu4oo1uDXO1Thg2wLiCj4l1quXfh2MMf0r3
        +ps/A2ek+eiW4t8cyicdQiexrhFDwenitre/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qZ/APUc0AEr5CY0K8RgiJps+ANQ/QuXB
        qIuJvVDnvT9jD3YOs757dmnD7tzoOjrApzIkjRWyqUILfHsywsMy2cFPLGK3lA7q
        092PH89u1wsZ9NRDtjXoH5gUE4zzK9BfXjETSdjy1s0YP5ve3OVpw2lwfmESxgfN
        Vp7sqI5RB20=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D5A633E12;
        Tue, 15 Oct 2019 21:32:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1026633E10;
        Tue, 15 Oct 2019 21:32:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 0/6] sequencer: start running post-commit hook again
References: <pull.388.git.gitgitgadget@gmail.com>
        <pull.388.v2.git.1571135132.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1910151624450.46@tvgsbejvaqbjf.bet>
Date:   Wed, 16 Oct 2019 10:32:02 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910151624450.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 15 Oct 2019 16:26:01 +0200 (CEST)")
Message-ID: <xmqqtv89a31p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C215B38A-EFB4-11E9-8E5F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Phillip,
>
> On Tue, 15 Oct 2019, Phillip Wood via GitGitGadget wrote:
>
>> When I converted the sequencer to avoid forking git commit i forgot about
>> the post-commit hook. These patches are based on
>> pw/rebase-i-show-HEAD-to-reword, otherwise the new test fails as that branch
>> changes the number of commits we make.
>> ...
>
> I had a look over the patches, too, and all looks good to me.

Me three; thanks, both.
