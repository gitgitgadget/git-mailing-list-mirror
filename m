Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF35F1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 02:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfJ2CZa (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 22:25:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50011 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfJ2CZa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 22:25:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DC0834393;
        Mon, 28 Oct 2019 22:25:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=um4Q2P41+EyTqf9nytfgJj7cq48=; b=N3MsIB
        4I0DtRYmVsfiyhg4VPfxgByHG7N1h+h1lHtTnwfZNGYon2EoLQ6je/+1L6OmTsLO
        uW6hInn49WCGPg0q1ZZs+T4/V8iqNRvyrz7k0JvtbU9o6f/PHk22hkqpFhPz6odU
        ntl31R/qVlu3dGUpaXWdvxy+zW6BlDGS+sJD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r6Ufa6BtEHniwUpIcIbxRZKOIEP/ARc2
        p5IqbVn4XNeIeACBMaGDWzeGGGkacYWSJkN5FRdf81NE/FvdMQdFcK/MWpRZ0/xT
        nRUzYZ6mTemE7wFif7hRCu+LthPibqLOsIW+QiXNdE4OSY2/8noFA5t3KbXUfohr
        2JDHRf6aaxo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7542134392;
        Mon, 28 Oct 2019 22:25:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC65834391;
        Mon, 28 Oct 2019 22:25:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix git stash with skip-worktree entries
References: <pull.355.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1910272203360.46@tvgsbejvaqbjf.bet>
        <xmqqpniha9a8.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910282152080.46@tvgsbejvaqbjf.bet>
Date:   Tue, 29 Oct 2019 11:25:26 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910282152080.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 28 Oct 2019 21:56:05 +0100 (CET)")
Message-ID: <xmqqzhhk70fd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F16ED64-F9F3-11E9-BBA8-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Yeah, I do not recall seeing any of the patches in the topic (nor
>> the cover letter).  It is not clear to me what "lose" above means,
>> which is an indication that I didn't read the topic a month ago X-<.
>
> Sorry, in this context, "to lose a file" means that a `git stash` would
> record such a file as deleted. A subsequent `git stash apply` _would_
> then delete it.

That would be a good thing to explain in the log message.

Thanks.
