Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190C620986
	for <e@80x24.org>; Tue, 27 Sep 2016 21:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964845AbcI0U7z (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:59:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62485 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935958AbcI0U7t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:59:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC99641CDC;
        Tue, 27 Sep 2016 16:59:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZigIuqwImmTvmZO3cenrayJJgOU=; b=CoqJWd
        wV601LTNViMcU4BtkvaktVyknhgT8beRAKOiNJBKt5eQl2z/xTleuvumNPacgHJD
        Z6B/i4v9lYxPFyOx8wM3es3oHBr6WQkrqyIxaw1uN+l+7p0F+A8pgresUBpPtire
        7mQXMNHRwlV13939Xh6JU7B2KZt6rsBq4JQxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KP1Wtsi/kAjM5e+5h4qKjmpyFGDfBzIo
        duUMjroeOK0bi0snf2RuTdybKoyDXMjgU+P2g7npfSXcEMfdXyaOfKz/QpgtEJ4q
        MPKukJygtCPTJ8dak1gpPUG14UQjTAftXNp7P4R36OnZCStiY6yGwJb7HhzuLnWh
        eTw1ybU+7/Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4E7741CDB;
        Tue, 27 Sep 2016 16:59:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5397041CDA;
        Tue, 27 Sep 2016 16:59:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4 v4] ls-files: pass through safe options for --recurse-submodules
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
        <1474930003-83750-1-git-send-email-bmwill@google.com>
        <1474930003-83750-4-git-send-email-bmwill@google.com>
        <xmqqd1jpnpyh.fsf@gitster.mtv.corp.google.com>
        <20160927204440.GE32565@google.com>
Date:   Tue, 27 Sep 2016 13:59:45 -0700
In-Reply-To: <20160927204440.GE32565@google.com> (Brandon Williams's message
        of "Tue, 27 Sep 2016 13:44:40 -0700")
Message-ID: <xmqqa8etm532.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52DEF6A2-84F5-11E6-B990-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Oh there is a separate if gaurd for pathspecs which is introduced in 2/4
> and then removed once pathspec support has been added in 4/4.

Thanks; I missed to spot that when I wrote the message you are
responding to, but it indeed is there ;-)
