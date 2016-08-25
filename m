Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63CED1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 20:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758398AbcHYUqe (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 16:46:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54143 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757807AbcHYUq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 16:46:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D35E36E87;
        Thu, 25 Aug 2016 16:46:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XwFt3uIK/Yq6KTpZEeN6Nw8joLE=; b=oRFl7k
        Xoqsn0/OQDrUpK7GNdTDSjRSEga0orIF2IU7ZNRa79wSXrUTj6ZMvAmGZvnwxeMA
        Ivzhqf4pRM5QUdQy/nKyIkwJ+PIaTvu5KvR+9ozLaoXZPWajuScmuLsNDgA+wsu9
        hIesGV2RruHplUMxS2JJc7yjEQTGMZLYhNQAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gv5MuWkFVHbqLt4hgLA1HoNw8NQKJU8h
        IhJ0XG+Z+6ge2qhmsjnl5pnpg6nfPt6oVnu///2GY77vGb0blxhheB1q9dgFJyTH
        i+oi+XY1k08APnIWAp2x/crV1IkF6ihqqHgtM7BNl99dxCHDbCJd7NyFhVEa+cgN
        87856GxLh/M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9612036E86;
        Thu, 25 Aug 2016 16:46:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 197F536E85;
        Thu, 25 Aug 2016 16:46:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 2/2] gitattributes: Document the unified "auto" handling
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
        <20160825155258.29007-1-tboegi@web.de>
Date:   Thu, 25 Aug 2016 13:46:20 -0700
In-Reply-To: <20160825155258.29007-1-tboegi@web.de> (tboegi@web.de's message
        of "Thu, 25 Aug 2016 17:52:58 +0200")
Message-ID: <xmqqpoowlgpv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB4749C6-6B04-11E6-8EA3-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> +If you want to ensure that text files that any contributor introduces to
> +the repository have their line endings normalized, you could set the
> +`text` attribute to "auto" for _all_ files.
> +
> +------------------------
> +*	text=auto
> +------------------------
> +

That is very understandable, especially that the text before this
added paragraph is about "core.autocrlf" configuration that is about
"your" changes.  It contrasts gitconfig vs gitattributes very well.

However, it is no longer clear what "you should instead" in the
existing paragraph attempts to contrast with.  "If you want all text
files, then use '* text=auto'" is what is said previously.  And your
updated example below says "If you do not want that, and instead you
want X, do '*.txt text'".  But the value of X is reads the same as
the above one: "you want all text files to be normalized".

>  If you want to interoperate with a source code management system that
>  enforces end-of-line normalization, or you simply want all text files
>  in your repository to be normalized, you should instead set the `text`
> -attribute to "auto" for _all_ files.
> +attribute to "text" for text files.
>  
>  ------------------------
> -*	text=auto
> +*.txt	text
>  ------------------------

In short, the above is incoherent and not understandable, without
updating the three lines of introductory text you left untouched at
the beginning of the paragraph, when read in the (updated) context.

> -This ensures that all files that Git considers to be text will have
> +This ensures that all files marked as text will have

This is a good update of the description to match the updated example.
