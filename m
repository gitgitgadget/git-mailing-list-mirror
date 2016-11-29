Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E0751FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 19:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755102AbcK2T2s (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 14:28:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52425 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753065AbcK2T2r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 14:28:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61FD2535A6;
        Tue, 29 Nov 2016 14:28:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1CjGPUdiJEOKxM4v5Jx0xCRhPmA=; b=UOZK8v
        +XRrXuJlrwHQIN2cB36ohTb11rQzC2FbS7I02nF/2+n3xhdMklxkI24dagEkfKV+
        jBXZb77l+yOIw9QBjIwH8kB3TPIEY9NySiNVc7QYUVvZcpOb4++VaFYQS82yevGG
        k0hNZwhUtlknVVVSP47HP+gCLjW/IGM4Op4mY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QoQI+s9ZZBb7dfaV3JKvHkJ6P3p7rsqQ
        /4ok38lvm4f73H/VuN13CBWqzg0TZqDaEKQzD85C5LauXtnZtKXWdINUlnAjI7zf
        HsEam5Px6NmeftYStuK7fKumb3sNn2gO8m6lpiXNslkV3a95Eez6ly6IEF3RmD0G
        81o7GChuZnk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A628535A1;
        Tue, 29 Nov 2016 14:28:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CBC05535A0;
        Tue, 29 Nov 2016 14:28:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 00/11] git worktree (re)move
References: <20161112022337.13317-1-pclouds@gmail.com>
        <20161128094319.16176-1-pclouds@gmail.com>
        <xmqqwpfnidxm.fsf@gitster.mtv.corp.google.com>
        <xmqqshqbicga.fsf@gitster.mtv.corp.google.com>
        <CACsJy8DQDPzZGJXLpTVHVFUeupPpp5e=b9z4m7xceJWrxPfF3Q@mail.gmail.com>
        <20161129135646.GA19797@ash>
Date:   Tue, 29 Nov 2016 11:28:44 -0800
In-Reply-To: <20161129135646.GA19797@ash> (Duy Nguyen's message of "Tue, 29
        Nov 2016 20:56:46 +0700")
Message-ID: <xmqqfumaf5lf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B9ED8B0-B66A-11E6-B9AB-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Another way, as pointed out by j6t, is go with "move within filesystem
> only", at least at the first step. Which is probably a good idea
> anyway so we can concentrate on git-specific stuff before going to
> minor and complicated copy/move details.

Yup, that is a very sensible approach.
