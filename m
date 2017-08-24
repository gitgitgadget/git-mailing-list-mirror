Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2B120285
	for <e@80x24.org>; Thu, 24 Aug 2017 16:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753839AbdHXQqN (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 12:46:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52423 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753802AbdHXQqM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 12:46:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5038CA5BD2;
        Thu, 24 Aug 2017 12:46:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QbimHiNrXv/6BRUXMiZeciGAfic=; b=fzxVyw
        +F2Xdunh8RknQkeyOXao1v7zobl7l31mt6Hcr9JlcesbLQ49zMMF4M+qwhLPMOnb
        8dfvEIolD7rOhg6ufKgJ6owZXkNtgn0efyrWCXSlGSIxNYMBEVIs0xXvvDdxh/5m
        7Behc6s26O9pgOVwXn4SkryzCXCVf+jZIKWGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bHT3vk3n36JMk3WLwFU67PlnXQZNB0cn
        N0NPX0Y74Hl82ho9eYxt1cWi3Ri7dqIgpl54uy++kzhGUfXot2vMuV6gcBcRq37C
        Q9BGcuwzkxqlXW+HFAYS2yXu9HWESRLqk/+KOuHe11LkdAPwr21PB6NgGcRJtIR1
        c1/uDeJxSwE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4837EA5BD1;
        Thu, 24 Aug 2017 12:46:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A4F0A5BCE;
        Thu, 24 Aug 2017 12:46:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 0/5] Add option to autostage changes when continuing a rebase
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
        <xmqqa83rrrdu.fsf@gitster.mtv.corp.google.com>
        <xmqqa83qq2uf.fsf@gitster.mtv.corp.google.com>
        <xmqq60eeq24l.fsf@gitster.mtv.corp.google.com>
        <8cdda835-0b4f-6ffb-31bf-6192999818be@talktalk.net>
        <6a71f802-b20c-f6bc-7bb5-8d81db3353d8@talktalk.net>
        <xmqqpocloqcp.fsf@gitster.mtv.corp.google.com>
        <a3b7af29-8b3a-5253-21da-957920212a6e@talktalk.net>
        <xmqqinhg5ysf.fsf@gitster.mtv.corp.google.com>
        <d1eaed1c-5e62-0a93-f65d-06be43812617@talktalk.net>
        <xmqqefs34mz4.fsf@gitster.mtv.corp.google.com>
        <5dcd588d-b6ce-713d-dc28-25853d5bb4b3@talktalk.net>
Date:   Thu, 24 Aug 2017 09:46:10 -0700
In-Reply-To: <5dcd588d-b6ce-713d-dc28-25853d5bb4b3@talktalk.net> (Phillip
        Wood's message of "Thu, 24 Aug 2017 14:25:05 +0100")
Message-ID: <xmqqtw0wx6b1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC420E86-88EB-11E7-AC11-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> It could be expensive to check that the local modifications will not
> interfere with the rebase - wouldn't it have to look at all the files
> touched by each commit before starting? What do cherry-pick and am do
> here when picking several commits?

Yes, so?

"I do not think of a way to implement it cheaply, so we forbid
anybody from finding a clever optimization to implement it cheaply
by adding a feature that will not work well with it when it
happens?"

