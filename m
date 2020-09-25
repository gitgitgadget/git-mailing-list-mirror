Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD202C4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A36320838
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aoA/EDF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgIYUdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 16:33:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63792 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgIYUT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 16:19:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9E50ED1D9;
        Fri, 25 Sep 2020 16:19:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eicmaRmuoC4KIwCAPVNb3kDay0s=; b=aoA/ED
        F1aEjrhSO+nxlGqftMW2SVCd5l7BDoheeDwTiz+X5x9ZCaqNAt2pb9FvZ1IlVZA4
        nmIdGFQjgUXexy05CJ5z2/aLR2tyXDKf5hNFV3st6/FAnJWIyllTYDZcGJnSuMjW
        +ejdl8ajIka/ccL7CrT3OB5jfoMAp7y6PwbBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y2aH2uEfuUAqD1/pLDXFUhoy0+ZOLGUc
        9ebZ0qRT6FHXoZoj77H2Gzwt6LU/Z6HFMt/X8MUNVIgp5XBHr3RbT+Ppy0hpo0Wu
        uOBQwGqaiigoUfAQuG8B6dmlR3yeXl8J72NTdp+Op1/S88L9RmPKN3qQl4Tvt4EL
        d0cWd0GgA8M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E2518ED1D8;
        Fri, 25 Sep 2020 16:19:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 30CF3ED1D6;
        Fri, 25 Sep 2020 16:19:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     shubham verma <shubhunic@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 03/11] t7001: remove unnecessary blank lines
References: <20200925170256.11490-1-shubhunic@gmail.com>
        <20200925170256.11490-4-shubhunic@gmail.com>
        <CAPig+cQWvn0YXUZRHE2ocH8+FS1aAnhjKiMsQvXXkNQ7LgEmfg@mail.gmail.com>
Date:   Fri, 25 Sep 2020 13:19:53 -0700
In-Reply-To: <CAPig+cQWvn0YXUZRHE2ocH8+FS1aAnhjKiMsQvXXkNQ7LgEmfg@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 25 Sep 2020 13:50:09 -0400")
Message-ID: <xmqqzh5dk3rq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79BCFA8A-FF6C-11EA-9922-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> It is very uncommon style to hide the subshell as these two tests do:
>
>     test_expect_success 'title' '(
>         ...
>     )'
>
> Instead, these should be formatted as:
>
>     test_expect_success 'title' '
>         (
>             ...
>         )
>     '
>
> Note that the "(" and ")" of the subshell are indented with a TAB, and
> then the body of the subshell is indented again with another TAB in
> order to comply with current style guidelines.
>
> Fixing these might possibly be done in patch [1/11], however, they are
> so unusual and would change indentation of the body lines that they
> might deserve a patch of their own to avoid being lost in the noise of
> [1/11].

I agree that adding that to 01/11 might be too noisy, but 04/11 may
be a good match.

Thanks.
