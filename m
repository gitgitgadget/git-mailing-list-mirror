Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0891B1F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 02:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbeKXNhM (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 08:37:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62975 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729978AbeKXNhM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 08:37:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 05BC5348A3;
        Fri, 23 Nov 2018 21:50:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WF55p5EMMo4R57IEeEv/BxDSMwY=; b=B8cnn2
        Ct6Bax2W68rZkPYCL6P2p9hqukBzL/R1CV76K4tuCCstUFMKrpEzYt/cbHT/UKOo
        0o7ukCYqAvR+4xd24U1QnpQsU97OG0Oli+anv0qysePrX5CwLx2M90OzVapGX3jg
        pTxoSq5pIvBKWGBQUVb5kZKp/jeBMRTeO6dGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xM1iR50u5kknp8uE6DDiOkZ8SpQMMMYM
        8w6rQrMkNOrb2KahQn8oNkphTevcCXfJw32NpPIpQQVD3tfFFaO/v9LtdhoPtIk2
        j/N+8JIaKzggVWyAan6RiZtohKRwYb2UBjzr4JlO3YFIGwHDhvJyTqmg2MGHUybG
        w2SgXLTq4ac=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F2ABB348A2;
        Fri, 23 Nov 2018 21:50:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F30B0348A1;
        Fri, 23 Nov 2018 21:50:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Greg Hurrell <greg@hurrell.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: update diff-format.txt for removed ellipses
References: <20181122160154.GA28192@sigill.intra.peff.net>
        <20181123090908.43445-1-greg@hurrell.net>
        <20181123090908.43445-2-greg@hurrell.net>
Date:   Sat, 24 Nov 2018 11:50:24 +0900
In-Reply-To: <20181123090908.43445-2-greg@hurrell.net> (Greg Hurrell's message
        of "Fri, 23 Nov 2018 10:09:08 +0100")
Message-ID: <xmqqwop32npr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B294152C-EF93-11E8-8CD4-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for a patch.

Greg Hurrell <greg@hurrell.net> writes:

> Commit 7cb6ac1e4b made the diff format omit ellipses by default, but
> there is still this place in the documentation where we show examples of
> output with ellipses.

We prefer to cite an existing commit with its title and date these
days, not just with its object name.

    Since 7cb6ac1e ("diff: diff_aligned_abbrev: remove ellipsis after
    abbreviated SHA-1 value", 2017-12-03), the "--raw" format of diff
    does not add ellipsis in an attempt to align the output, but...

or something like that.  Note that saying this is about the raw format
is quite essential thing to tell the readers to explain this hange.

> The GIT_PRINT_SHA1_ELLIPSIS environment variable can be used, for now,
> to bring back the old output format, but that is already documented in
> git.txt, so I am not mentioning it here.

Yeah, I do not think it makes sense to use the workaround that is
planned for removal, which will later make us revise the example in
the documentation again, to end up with the text that you have right
now.  I do not think this three-line paragraph needs to be in the
log message, either, though.  Perhaps below the three-dash line.


Also please sign-off your patch here (see
Documentation/SubmittingPatches).

> ---

Thanks.

>  Documentation/diff-format.txt | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
> index 706916c94c..cdcc17f0ad 100644
> --- a/Documentation/diff-format.txt
> +++ b/Documentation/diff-format.txt
> @@ -26,12 +26,12 @@ line per changed file.
>  An output line is formatted this way:
>  
>  ------------------------------------------------
> -in-place edit  :100644 100644 bcd1234... 0123456... M file0
> -copy-edit      :100644 100644 abcd123... 1234567... C68 file1 file2
> -rename-edit    :100644 100644 abcd123... 1234567... R86 file1 file3
> -create         :000000 100644 0000000... 1234567... A file4
> -delete         :100644 000000 1234567... 0000000... D file5
> -unmerged       :000000 000000 0000000... 0000000... U file6
> +in-place edit  :100644 100644 bcd1234 0123456 M file0
> +copy-edit      :100644 100644 abcd123 1234567 C68 file1 file2
> +rename-edit    :100644 100644 abcd123 1234567 R86 file1 file3
> +create         :000000 100644 0000000 1234567 A file4
> +delete         :100644 000000 1234567 0000000 D file5
> +unmerged       :000000 000000 0000000 0000000 U file6
>  ------------------------------------------------
>  
>  That is, from the left to the right:
> @@ -75,7 +75,7 @@ and it is out of sync with the index.
>  Example:
>  
>  ------------------------------------------------
> -:100644 100644 5be4a4...... 000000...... M file.c
> +:100644 100644 5be4a4a 0000000 M file.c
>  ------------------------------------------------
>  
>  Without the `-z` option, pathnames with "unusual" characters are
> @@ -100,7 +100,7 @@ from the format described above in the following way:
>  Example:
>  
>  ------------------------------------------------
> -::100644 100644 100644 fabadb8... cc95eb0... 4866510... MM	describe.c
> +::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	describe.c
>  ------------------------------------------------
>  
>  Note that 'combined diff' lists only files which were modified from
