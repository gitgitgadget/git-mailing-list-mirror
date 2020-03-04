Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB562C3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 21:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A54E20828
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 21:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QI1/8S88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbgCDV17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:27:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60861 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387762AbgCDV17 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 16:27:59 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15F445D7B0;
        Wed,  4 Mar 2020 16:27:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BsrwyXQPR1mvZskJ2FFChDvC7cg=; b=QI1/8S
        88u7j/fmjtX6tcps2Q6iJQZExmCf4ymIzVqZZtIpPrlzurwfYdSrW1OWsl9nSrbP
        pOyCChBbNk3uGUaYg0mA7wgbj7qEGlnIzlexWIgN24WSd9keTCAfqwYoVGKOFqEl
        Mj1G4mUt8gkFZdGgznaY+Tv5KHeAzjhm6AKT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CDPekLzZ8OlWfQtv1CMQJX3I7pZiXhEP
        izacxHVKsWkbmpqF97ON1LGNFtFtRYKiwH9HRAdXS3iWORe3qUZhh61FHPd/L7H4
        bvhduc+pIv2VvzLf9tSpZbNyfZpHanrPzK9GwpE2pknActNVbBN9ozoJiGGWgAPi
        gODqtBc9YUY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F342C5D7AF;
        Wed,  4 Mar 2020 16:27:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4FF095D7AE;
        Wed,  4 Mar 2020 16:27:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: hv/receive-denycurrent-everywhere, was Re: What's cooking in git.git (Mar 2020, #01; Tue, 3)
References: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2003042139530.46@tvgsbejvaqbjf.bet>
Date:   Wed, 04 Mar 2020 13:27:54 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2003042139530.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 4 Mar 2020 21:40:54 +0100 (CET)")
Message-ID: <xmqqr1y74xph.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02FF9D2A-5E5F-11EA-BDDC-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Could we make sure that
> https://lore.kernel.org/git/pull.570.git.1583305200143.gitgitgadget@gmail.com
> is also integrated into this before it advances? It only adds a regression
> test case (which according to the PR build passes just fine).

Yup, Eric also reminded me of the same earlier.  Queued.

Thanks (duplicated reminders are a lot more appreciated than no
reminders at all ;-).
