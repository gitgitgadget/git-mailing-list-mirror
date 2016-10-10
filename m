Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAF9120989
	for <e@80x24.org>; Mon, 10 Oct 2016 18:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbcJJS2j (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 14:28:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60691 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751764AbcJJS2j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 14:28:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A47A4530F;
        Mon, 10 Oct 2016 14:28:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+FbB0/L4XwDfcDpxS6he+RMMpEM=; b=Yi1Z02
        +hoaZvZ0CmxjyxhTcx9CZVP9aLjTw5uXQ1bzdyogiKC5j/0VUjsT/oY3KgoGQwq1
        Fmp+NgfaksNAgtYMky1tKCAbNs3Jz5ZLSLB0s1oJw/ZOfY/6rYM2I7AZxi6elLOf
        mg+tVwp8jWUC7y85ciYyWxpRT37pHJ/PYxo3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fjQYzgZgoCLro/eDhXugxSnUdg76ak6A
        75DSRH4btGwW7dxMtwuHMRAenUWEFvlr7Lj92YATOw+4xGMvbxt64cgGZfucz8tj
        eN6GfU/sVmmROaqPlMXgq4DTY+TdKLPSoWnMltbLUQGPlmCMotobHiCY8xWkNSgH
        mNf52h6M1pk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00DD94530E;
        Mon, 10 Oct 2016 14:28:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8084C4530C;
        Mon, 10 Oct 2016 14:28:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Luis Gutierrez <luisgutz@gmail.com>
Subject: Re: [PATCH v4 4/4] mergetool: honor -O<orderfile>
References: <20161008000130.22858-1-davvid@gmail.com>
Date:   Mon, 10 Oct 2016 11:28:35 -0700
In-Reply-To: <20161008000130.22858-1-davvid@gmail.com> (David Aguilar's
        message of "Fri, 7 Oct 2016 17:01:30 -0700")
Message-ID: <xmqqa8ecf48c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C359D6A-8F17-11E6-B5E8-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Teach mergetool to pass "-O<orderfile>" down to `git diff` when
> specified on the command-line.
>
> Helped-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Since v3:
>
> I missed one last piped invocation of "git mergetool" in the tests,
> which has been fixed.

I only see 4/4 in v4; am I correct to assume that 1-3/4 of v4 are
the same as their counterparts in v3?
