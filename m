Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112CE1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 21:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753901AbcKUVWb (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 16:22:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54368 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752800AbcKUVWa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 16:22:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45BFF52FB3;
        Mon, 21 Nov 2016 16:22:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=thThIvKVKuuNCneYNVUvt7kks7A=; b=KY84VJ
        L/TcYQaa6idWq9C6fqaxQ6kVBJb1JYjWdt0CkArHDbLI2GCLeE8WYd12WZdqJimA
        shAvezgixta6wDyN1MRqzoqNAHXvdsUCuA/X5AA8O6XPhlu0QjidoOfi/6TO+Dfj
        su6TtKW4ROcs1X209tA8CHYU0xp4vNRIzjneM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iAEUKmn8KKyDL/gj4UPL7GygQuHvoesA
        3T0iGlvIddCKzVri3Z0zgZUwsMWBJwzgdgF1VNPph1jxl6rf/UcaKZbdYBEDd77U
        RKQgoQ2G5hn6y6r9PvNxQZ7+JFUgfeyBz1gtFl/dnpHSaMqXDUzdDH2GB6zAv95R
        jCEbxus1DVg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BBB652FB2;
        Mon, 21 Nov 2016 16:22:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ADD9B52FB1;
        Mon, 21 Nov 2016 16:22:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH] doc: mention user-configured trailers
References: <CA+P7+xrQEBYQQhqJQQCpLrs+4WOJOvH1X27w5Ou=2VPT=FegGQ@mail.gmail.com>
        <1479761241-26284-1-git-send-email-jonathantanmy@google.com>
Date:   Mon, 21 Nov 2016 13:22:27 -0800
In-Reply-To: <1479761241-26284-1-git-send-email-jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 21 Nov 2016 12:47:21 -0800")
Message-ID: <xmqqtwb0h6jw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B0793C4-B030-11E6-8A18-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In commit 1462450 ("trailer: allow non-trailers in trailer block",
> 2016-10-21), functionality was added (and tested [1]) to allow
> non-trailer lines in trailer blocks, as long as those blocks contain at
> least one Git-generated or user-configured trailer, and consists of at
> least 25% trailers. The documentation was updated to mention this new
> functionality, but did not mention "user-configured trailer".
>
> Further update the documentation to also mention "user-configured
> trailer".
>
> [1] "with non-trailer lines mixed with a configured trailer" in
> t/t7513-interpret-trailers.sh
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>
> Yes, mentioning a trailer in a Git config will cause interpret-trailers
> to treat it similarly to a Git-generated trailer (in that its presence
> causes a block partially consisting of trailers to be considered a
> trailer block). See the commit message above for a test case that
> verifies that.
>
> I took a look at the documentation, and it wasn't completely documented,
> so here is a patch to correct that.

Looks sensible. Thanks.

>  Documentation/git-interpret-trailers.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index e99bda6..09074c7 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -49,7 +49,8 @@ will be added before the new trailer.
>  
>  Existing trailers are extracted from the input message by looking for
>  a group of one or more lines that (i) are all trailers, or (ii) contains at
> -least one Git-generated trailer and consists of at least 25% trailers.
> +least one Git-generated or user-configured trailer and consists of at
> +least 25% trailers.
>  The group must be preceded by one or more empty (or whitespace-only) lines.
>  The group must either be at the end of the message or be the last
>  non-whitespace lines before a line that starts with '---'. Such three
