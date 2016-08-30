Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 912611F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 17:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933084AbcH3Re7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 13:34:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51647 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933226AbcH3Rey (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 13:34:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F9C03A610;
        Tue, 30 Aug 2016 13:34:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sE3W2y+7sjwLTPjbQwgc8uFzK5U=; b=ajm+93
        ngK52OsOeccCj9tAm01NH1LENESBX6xuqk0OdMcUL8GE7/DHmyhWQptBcT3l4RoM
        ZMbTmprAHwjPOueEf4bd4evaVWZSJuphqJEGH11l6l0p1PxPFEMWYKr6ipRomlzI
        w3fBTpDzTYhwrVOqzKkbYY1c5YEWvXU1RMcm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z8lxvlL9BuQJTM/HUascSCUq7Dkr+SE+
        PWclz6M8vn/8rIonuiNp2VvO3iK7FoCrZnqFUW4qaPcqTg4DH8GI1Zxe3mF5wZI7
        gX7yYsYm+ZpP7KXWz+cJk5QvLmwodfn+yNyMCBMyXBC4KLUkbMcnZXxg2tQRiBP1
        PPOXVRL8UCI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 189C23A60F;
        Tue, 30 Aug 2016 13:34:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9575A3A60D;
        Tue, 30 Aug 2016 13:34:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joe Perches <joe@perches.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: git am and duplicate signatures
References: <1472573556.5512.93.camel@perches.com>
        <xmqqwpiy5haf.fsf@gitster.mtv.corp.google.com>
        <1472577999.5512.107.camel@perches.com>
Date:   Tue, 30 Aug 2016 10:34:50 -0700
In-Reply-To: <1472577999.5512.107.camel@perches.com> (Joe Perches's message of
        "Tue, 30 Aug 2016 10:26:39 -0700")
Message-ID: <xmqq8tve5fet.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F13156C-6ED8-11E6-B7FE-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Tue, 2016-08-30 at 09:54 -0700, Junio C Hamano wrote:
>> Support for more generic footers was supposed to come when the
>> "interpret-trailers" topic started, but the author of the topic
>> seems to have lost interest before the mechanism has become ready to
>> be integrated in the workflow commands like "am", "commit", "rebase"
>> etc., which is unfortunate.
>
> I think adding at least an option to git send-email
> allowing auto-cc's for all
> 	"<foo>-by: [name] <address>"
> lines in the commit log would be useful.
>
> Today, only "Signed-off-by" and "CC" lines are
> added to cc's.
>
> I've always called these lines "<foo>-by:" lines
> "signatures", but perhaps there's a better name.

I think we casually call them footers (as they are counter-part to
"headers"), or trailers.
