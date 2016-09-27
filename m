Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FDE620986
	for <e@80x24.org>; Tue, 27 Sep 2016 22:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753706AbcI0WMm (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 18:12:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61393 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751762AbcI0WMk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 18:12:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B61D3F0ED;
        Tue, 27 Sep 2016 18:12:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YL8k0owOWdHd7T7D7pRlUkEYibs=; b=bJF0Uw
        ROInT6bhEu2FudwcIAdo3KE/21naOfqv+b/MuY2nQgMnagLHSEkE0eskdwUD+guS
        cNJE607HdFkCwZXkp/dHl9+scqDWS25mID7tjhssOemaMCNv14sO7xkwGYktS+Um
        UVDUdXuaBPictnZTOxeXhgPMoZ9C1xDrOy/Bo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Zspon6eFqLm+PRMuz3UEX+DuHR5QmuMB
        c/gW3ll4cv8sqZ+Xje6cYeehj3FLv2jwG00hl/azy2xIENe7FnSD6UzFtcun7r/e
        +lw6wKecW18pD/t6Nl+1vqVN+OcBEYv/D12EphXPmvBBcQI7UR7Zc49ojMuRgRin
        N2cDx5KI4mI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2376E3F0EC;
        Tue, 27 Sep 2016 18:12:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9EFB73F0EB;
        Tue, 27 Sep 2016 18:12:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Pranit Bauva" <pranit.bauva@gmail.com>, <git@vger.kernel.org>
Subject: Re: [PATCH v2] rev-list-options: clarify the usage of --reverse
References: <010201576bfb6c7d-0b68228f-9503-4dd1-9721-713477fa2596-000000@eu-west-1.amazonses.com>
        <010201576d63f422-abe45938-0da1-4fc0-b0e7-3e552b59d10a-000000@eu-west-1.amazonses.com>
        <A9427F4400044104B47378E024C7C2A4@PhilipOakley>
Date:   Tue, 27 Sep 2016 15:12:36 -0700
In-Reply-To: <A9427F4400044104B47378E024C7C2A4@PhilipOakley> (Philip Oakley's
        message of "Tue, 27 Sep 2016 22:51:30 +0100")
Message-ID: <xmqqoa39kn57.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 805F4CB2-84FF-11E6-B261-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> micro-nit: 'first' and 'last' can be tricky to distinguish for lists...

Let's do this then.

-- >8 --
From: Pranit Bauva <pranit.bauva@gmail.com>
Date: Tue, 27 Sep 2016 20:44:09 +0000
Subject: [PATCH] rev-list-options: clarify the usage of --reverse

Users often wonder if the oldest or the newest n commits are shown
by `log -n --reverse`.  Clarify that --reverse kicks in only after
deciding which commits are to be shown to unconfuse them.

Reported-by: Ruediger Meier <sweet_f_a@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/rev-list-options.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 4f009d4..f8946d4 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -638,8 +638,9 @@ avoid showing the commits from two parallel development track mixed
 together.
 
 --reverse::
-	Output the commits in reverse order.
-	Cannot be combined with `--walk-reflogs`.
+	Output the commits chosen to be shown (see Commit Limiting
+	section above) in reverse order. Cannot be combined with
+	`--walk-reflogs`.
 
 Object Traversal
 ~~~~~~~~~~~~~~~~
-- 
2.10.0-561-g98a6b79

