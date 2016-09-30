Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F853207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 18:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932348AbcI3SlC (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 14:41:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54076 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933227AbcI3SlA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 14:41:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 105533E0CC;
        Fri, 30 Sep 2016 14:40:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s+kATFksqrcess8Hag5wOlYQJbU=; b=U0+O3p
        n9nFSZDtPoDOQN0zpA/JnhiL+goTA1+WGCJMyggbsnWeoGpuonb5DN7TbNH3pW4N
        IBdTx2tgFwYfqd6j0oLbqL9siNMt9JtUkeBuBD46oxiaTjxkJ8gQCBNOkS79KOjC
        /q41oQW+UmCjDetSA6MRTp5qBlVinZwApGOf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t3YwGxPEYvzmwlCviqBT7HGTTFINc1zK
        obGTTQ3IAYK7uQjuztc56nU83QimCezvBHySQbiub7Ygl8R3KKoOaxyLOqjd605w
        8y+EvtCWrUF+P5idwBr+JwNe2SVRGrytG9GEbmOmOSdK0nRP5gV2z3uG0xq8p1Zn
        t1Jr7ZKpl+A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07F953E0CB;
        Fri, 30 Sep 2016 14:40:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8536F3E0CA;
        Fri, 30 Sep 2016 14:40:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <20160928233047.14313-1-gitster@pobox.com>
        <20160928233047.14313-5-gitster@pobox.com>
        <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org>
        <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
        <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
        <20160929191609.maxggcli76472t4g@sigill.intra.peff.net>
        <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
        <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
        <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com>
        <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
        <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
        <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
        <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com>
        <xmqqtwcyavou.fsf@gitster.mtv.corp.google.com>
        <xmqqoa36auyx.fsf@gitster.mtv.corp.google.com>
        <xmqqeg42au5w.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 30 Sep 2016 11:40:56 -0700
In-Reply-To: <xmqqeg42au5w.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 29 Sep 2016 21:27:55 -0700")
Message-ID: <xmqqmvip9qo7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DC2849E-873D-11E6-BC81-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> From: Junio C Hamano <gitster@pobox.com>
> Date: Thu, 29 Sep 2016 21:19:20 -0700
> Subject: [PATCH] abbrev: adjust to the new world order
>
> The default_abbrev used to be a concrete value usable as the default
> abbreviation length.  The code that sets custom abbreviation length,
> in response to command line argument, often did something like:
>
> 	if (skip_prefix(arg, "--abbrev=", &arg))
> 		abbrev = atoi(arg);
> 	else if (!strcmp("--abbrev", &arg))
> 		abbrev = DEFAULT_ABBREV;
> 	/* make the value sane */
> 	if (abbrev < 0 || 40 < abbrev)
> 		abbrev = ... some sane value ...
>
> The new world order however is that the default_abbrev is a negative
> value that signals find_unique_abbrev() that it needs to dynamically
> find out a good default value.  We shouldn't coerce a negative value
> into a random positive value like the above sample code.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

There is another instance buried deep in an obscure macro.  A
minimum fix may look like this, but I really hope somebody else
finds a better approach.  Peff alluded to "when it is still -1
substituting it with a reasonable value like 7" in a separate
thread, and we probably would want a way to allow accessing that
"reasonable value like 7" without triggering auto sizing logic
too early.

With this and the patch in the message I am responding to, your
patch from the last night seems to pass all the tests for me.

 transport.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport.h b/transport.h
index 6fe3485325..8a96e22bb0 100644
--- a/transport.h
+++ b/transport.h
@@ -142,7 +142,7 @@ struct transport {
 #define TRANSPORT_PUSH_ATOMIC 8192
 #define TRANSPORT_PUSH_OPTIONS 16384
 
-#define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
+#define TRANSPORT_SUMMARY_WIDTH (2 * (DEFAULT_ABBREV < 0 ? 7 : DEFAULT_ABBREV) + 3)
 #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
 
 /* Returns a transport suitable for the url */
