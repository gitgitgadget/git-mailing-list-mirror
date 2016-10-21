Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BFAA20229
	for <e@80x24.org>; Fri, 21 Oct 2016 18:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935146AbcJUScW (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 14:32:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61905 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934190AbcJUScW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 14:32:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B977F46086;
        Fri, 21 Oct 2016 14:32:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wxMAFShR4iJDfmRTQTgo8Uaf2Fs=; b=p4Hqwn
        ZN8wDIHxyQV+x3jNrY2s7CrvzYfJHEUFSOQNgjAb4tO1GvlevChXXrexNKJsLZUX
        kROqBQWQsFlM6J95p8HYotPfkkH0yg+LYZO2cYrxQ5o4gGRCCLRm+EEwKZrkjrA/
        Em143NGP35AL64Sy4SSNVaBBM34wn78uqVBkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qsUDsoR0+VymqExcn913OkVBStlv1v67
        38zISkeXlBrAvXjvzVJVV7cs8EH10h2vtO+bA6RCujNhDrhp+vHrXbIBnfoTyU2J
        mOdyX3kyacDocKiN96A1wMes5uGIjDIKnKl5meRAxv1+U95KkDk7+uY6nc52fPfN
        kHJ4UIUZ+Ew=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CB0146085;
        Fri, 21 Oct 2016 14:32:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1422546083;
        Fri, 21 Oct 2016 14:32:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 22/27] sequencer: teach write_message() to append an optional LF
References: <cover.1476450940.git.johannes.schindelin@gmx.de>
        <cover.1477052405.git.johannes.schindelin@gmx.de>
        <d858bd99a3ad3dea807f38b8bd42a221a9f7924c.1477052405.git.johannes.schindelin@gmx.de>
Date:   Fri, 21 Oct 2016 11:32:13 -0700
In-Reply-To: <d858bd99a3ad3dea807f38b8bd42a221a9f7924c.1477052405.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 21 Oct 2016 14:26:09 +0200
        (CEST)")
Message-ID: <xmqqmvhxbljm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B07691C4-97BC-11E6-B625-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This commit prepares for future callers that will have a pointer/length
> to some text to be written that lacks an LF, yet an LF is desired.
> Instead of requiring the caller to append an LF to the buffer (and
> potentially allocate memory to do so), the write_message() function
> learns to append an LF at the end of the file.

As no existing callers need this, it probably is better left out and
added to the series that actually needs the new feature as a
preparatory step.

