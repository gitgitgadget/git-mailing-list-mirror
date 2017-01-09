Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3E51FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 23:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764292AbdAIXCw (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 18:02:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63247 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755864AbdAIXCv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 18:02:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B4CB860C4E;
        Mon,  9 Jan 2017 18:02:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZRPAQ9CrXprBXDoS2eaSX6PCUAQ=; b=Vj64/g
        6tyY5IZl8JnmpWAm7pXx+D7wzTgzxybNPm8AaUB9NUQPcnzZ0eKkGljjIjmM/I3T
        VUPLrXr8VZ4ugwAyNWf42AGfY9iCQreJe+0yGmrhdtrb7zYzZoe+SNZ2OrzLdPbb
        KnMqW1m/7TbvqjdQbIjFTgK9v3yGAjZtxDzAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VPrIaFcqXgvKzDCyvm+Qb5rdFkAtI2Kx
        TdJsUTw3ab3LvoawX/YgL1aph7494TghA8gQbNNWynqeQHbqFkvzgHVVAjes85ze
        iEErgRikrag98vhBC4MOXBgSMXbIpWZzWgRq6pBy6SC+qQRaraqGSLo7M9v9qTPP
        SuRs6VVucLY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC5B560C4D;
        Mon,  9 Jan 2017 18:02:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2013160C4C;
        Mon,  9 Jan 2017 18:02:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 00/38] Teach the sequencer to act as rebase -i's backend
References: <cover.1481642927.git.johannes.schindelin@gmx.de>
        <cover.1483370556.git.johannes.schindelin@gmx.de>
        <xmqqinpnuaxl.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 09 Jan 2017 15:02:47 -0800
In-Reply-To: <xmqqinpnuaxl.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 09 Jan 2017 14:26:46 -0800")
Message-ID: <xmqqa8azu99k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDB875E0-D6BF-11E6-B5F2-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I ran out of time for the day and haven't looked at individual
> patches yet.  I may find other issues, but from the interdiff, that
> was the only thing that I found even worse than the previous round,
> and everything else was either the same or has improved.

... I forgot to say a few things:

 * In the meantime, I think this is overall better than what we had
   for the past few weeks; I'll try to replace the copy in my tree
   with this round, even though this may not be the final one.

 * There were a few style issues [*1*] pointed out by the
   checkpatch.pl script borrowed from the kernel land.

 * And finally, you wrote "This marks the count down to '3': two
   more patch series after this (really tiny ones) and we have a
   faster rebase -i."  This is seriously an exciting news.  Thanks.

I probably am still forgetting to say a few more things, but I'd
send this message out in this shape for now.  Thanks.


[Footnote]

*1*

Subject: [PATCH v3 10/38] sequencer (rebase -i): add support for the 'fixup' and 'squash' commands
ERROR: do not use assignment in if condition
#118: FILE: sequencer.c:725:
+		if (buf.buf[0] != comment_line_char ||

ERROR: do not use assignment in if condition
#142: FILE: sequencer.c:749:
+		if (!(head_commit = lookup_commit_reference(head)))

ERROR: do not use assignment in if condition
#144: FILE: sequencer.c:751:
+		if (!(head_message = get_commit_buffer(head_commit, NULL)))

ERROR: do not use assignment in if condition
#167: FILE: sequencer.c:774:
+	if (!(message = get_commit_buffer(commit, NULL)))

total: 4 errors, 1 warnings, 320 lines checked
------------------------------------------------
Subject: [PATCH v3 12/38] sequencer (rebase -i): write an author-script file
ERROR: do not use assignment in if condition
#35: FILE: sequencer.c:500:
+		else if ((eol = strchr(message, '\n')))

total: 1 errors, 0 warnings, 62 lines checked
------------------------------------------------
Subject: [PATCH v3 23/38] sequencer (rebase -i): copy commit notes at end
ERROR: open brace '{' following function declarations go on the next line
#36: FILE: sequencer.c:862:
+static void flush_rewritten_pending(void) {

ERROR: do not use assignment in if condition
#41: FILE: sequencer.c:867:
+	if (strbuf_read_file(&buf, rebase_path_rewritten_pending(), 82) > 0 &&

total: 2 errors, 0 warnings, 112 lines checked
