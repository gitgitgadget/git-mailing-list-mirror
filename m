Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C07F202A0
	for <e@80x24.org>; Thu,  2 Nov 2017 04:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbdKBEXq (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 00:23:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50634 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751258AbdKBEXo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 00:23:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06001AF2A2;
        Thu,  2 Nov 2017 00:23:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jjIF/3H98UVx0FerrB/eutmTrnk=; b=AkVY/z
        GV/apUWDZFOXV1SEFVVqTkI4MfcrBy9cwIR9S5eS8VE8TPrkY/5o5ltvCLPLbKFj
        BHN4s0Jq98jcq+P+N3HAaJ0DEc2W/W7O7wkN75hzNpr5E+sXFMC2P+Fl5WOej7gb
        XDP3l2RhrOS+TtjayY/TGfClIb/pRDH0MmF8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GF4SzOYJ7qJOD+U+pi3eNAgts5akBcuN
        qf40Hb4gkDaKu6xs+ItDYbgQ205VcRmFTO+XxAWQYUu0zkirsyS7zVuRdGSmdnCi
        xLaUo+UPH5KOqbrczZ9jEftw9yBPNVghUGiJtexomsJdvNlo8baoQb8ymZSAmPJj
        EOakzgnbAPk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0BE0AF2A1;
        Thu,  2 Nov 2017 00:23:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44B39AF29F;
        Thu,  2 Nov 2017 00:23:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] builtin/describe.c: describe a blob
References: <20171028004419.10139-1-sbeller@google.com>
        <20171031003351.22341-1-sbeller@google.com>
        <20171031003351.22341-7-sbeller@google.com>
        <xmqqinevzvel.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYO=4SWzfKY6bU8Spn5Ubw39ghOH6wanFhFEsKD8q9vrA@mail.gmail.com>
        <xmqq4lqewu2b.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYC4=rDSWC7WCGVL4n4OC8BpvMJFwxx+LV9GqoGnSHFSA@mail.gmail.com>
        <xmqqinetsayr.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 02 Nov 2017 13:23:36 +0900
In-Reply-To: <xmqqinetsayr.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 02 Nov 2017 10:53:00 +0900")
Message-ID: <xmqq375xs3zr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9961EF64-BF85-11E7-A169-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The reason why we say "-ish" is "Yes we know v2.15.0 is *NOT* a
> commit object, we very well know it is a tag object, but because we
> allow it to be used in a context that calls for a commit object, we
> mark that use context as 'this accepts commit-ish, not just
> commit'".

Having said all that, there is a valid case in which we might want
to say "blob-ish".

To review, X-ish is the word we use when the command wants to take
an X, but tolerates a lazy user who gives a Y, which is *NOT* X,
without bothering to add ^{X} suffix, i.e. Y^{X}.  In such a case,
the command takes not just X but takes X-ish because it takes a Y
and converts it internally to an X to be extra nice.

When the command wants to take a blob, but tolerates something else
and does "^{blob}" internally, we can say it takes "blob-ish".
Technically that "something else" could be an annotated tag that
points at a blob object, without any intervening commit or tree (I
did not check if the "describe <blob>" code in this thread handles
this, though).

But because it is not usually done to tag a blob directly, it would
probably be not worth to say "blob-ish" in the document and cause
readers to wonder in what situation something that is not a blob can
be treated as if it were a blob.  It does feel like we would be
pursuing technical correctness too much and sacrificing the readability
of the document, at least to me, and a bad trade-off.


