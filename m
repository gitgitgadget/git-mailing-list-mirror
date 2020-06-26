Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1105EC433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 15:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5ED820706
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 15:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ahnidM73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgFZPES (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:04:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62054 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgFZPES (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 11:04:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3364E6C15E;
        Fri, 26 Jun 2020 11:04:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T89VaNOhHMa7Z/2Lg8wosa263us=; b=ahnidM
        73ntJwfbJubW3fKxjWMU7VxhyoWC5YdlDH4aPr1LRXuhhsFoOZQ2ThOH+1VBR8KM
        iaPjoUuygZDaVcYsedWDkaBCdu3yHuwluY9nRIrvwq7w2bbvI1UhSRsjZqQpSinE
        5fllLYPn7fuuYqlrjxlvvoULzViUdRng6DMM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uxQcd5HgJnTm4cqVd6LTuDTULyZn8OZE
        0y/WC154Qc0u17PyilqK6RZ62xy8QtNc726ARPeSFojSOef9UL73ipdgFPL/c5JC
        OKx4ZI0Sw2p1TF4/Mflb8LjnKs3/yKp+WJ/IYycjPaxboTmEy1TaaAIQwFi5Fk3u
        TaUIaIvWCqE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A7906C15D;
        Fri, 26 Jun 2020 11:04:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5CF46C15C;
        Fri, 26 Jun 2020 11:04:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 0/5] cleanup ra/rebase-i-more-options
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200626095528.117524-1-phillip.wood123@gmail.com>
Date:   Fri, 26 Jun 2020 08:04:09 -0700
In-Reply-To: <20200626095528.117524-1-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Fri, 26 Jun 2020 10:55:23 +0100")
Message-ID: <xmqqsgehhnrq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D4F93B8-B7BE-11EA-8FB3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> I've updated the commit messages, option handling and tests as
> suggested by dscho. I've also changed the tests that used
> '--strategy=resolve' to use a real external merge strategy so they
> continue to test the same code path once Alban's patches to handle the
> resolve strategy without forking are merged

Thanks, will take a look and replace.

