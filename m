Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F188C1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 18:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753547AbdKJSgt (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 13:36:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59030 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753354AbdKJSgs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 13:36:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC533BE22A;
        Fri, 10 Nov 2017 13:36:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MIeg8J/uVFvE3Ijp/vw/+YJoPjQ=; b=d8D5hJ
        XjMi0P5xpI+s41vYuao3zkd6pfC1lQf8Mi1H/DOtfs0amhk8tg0H+3xLbbpFuphC
        W+ljdXtOsD8D/FnJ2PBlrc4Qf9uthL6D6Q07kQOdkWoSkYdQIkgixantEZpVIsex
        8hmHf2bvUJyLuFjiYZMXboBfVloAGOTEf3EYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uzm8VjNhmIXq3Y5tHK4ckJVb2k/iIE9F
        PeJKXxpcgv5uOkXiwmzacRjsMmmm4LwXlvloSfWUETNsPgqgbJ7yhaXQhRoy5hm4
        yHJ0ocUtn8vIj/EUaEPjpLrdNnaTSqarIP3HkFK2JiNjAjmxp+BUW3IdFr5+Cxwq
        Ki6xNw9lXso=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C377DBE229;
        Fri, 10 Nov 2017 13:36:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 438DBBE228;
        Fri, 10 Nov 2017 13:36:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 3/9] Add a function to update HEAD after creating a commit
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20171110110949.328-1-phillip.wood@talktalk.net>
        <20171110110949.328-4-phillip.wood@talktalk.net>
Date:   Sat, 11 Nov 2017 03:36:46 +0900
In-Reply-To: <20171110110949.328-4-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Fri, 10 Nov 2017 11:09:43 +0000")
Message-ID: <xmqq7euyf0ap.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BB46D68-C646-11E7-8EA8-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Add update_head() based on the code that updates HEAD after committing
> in builtin/commit.c that can be called by 'git commit' and other
> commands.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>
> Notes:
>     changes since v1:
>      - rename update_head() to update_head_with_reflog()

The above proposed log message still calls it with the old name
though.
