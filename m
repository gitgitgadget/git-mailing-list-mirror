Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 358C81F51C
	for <e@80x24.org>; Mon, 21 May 2018 18:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbeEUSxf (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 14:53:35 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34516 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbeEUSxe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 14:53:34 -0400
Received: by mail-wr0-f194.google.com with SMTP id j1-v6so6037383wrm.1
        for <git@vger.kernel.org>; Mon, 21 May 2018 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=y4fsjhbbIdzV6WmVz9NFO7If2s9wWt7LT0WOZPvEOVg=;
        b=Rup+iyt/sK9dynN/6cr2Pw9sPPr32GuSGPnxkXULkRYGD3P2IVuSC4O9/m30U7NYp7
         xkuj04KDD8R46UNzEprJBW7Q4kdRxdjCa2pgnOJhmWdYQb3o/AWUo+JjTm1o6t7Xbz9H
         DbSG+p//IcSAvDrvE0+02FvpXV9RBepEXQC3+XwzBcsJsOQCrMEa5u2WeKeV7Hso0jjx
         cEErgGG8euND4X680lgw8btEQ+8KRvfLcbKBnSVm+u762pm3DLhnoZV7z/rn4f55AmMc
         R3K0sRMD99vH3nxILmef5fIAFLeb4ox5v+hE6GKmeBQSMQDQ1WUe+fa2vRrVly7tWsM/
         ekug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=y4fsjhbbIdzV6WmVz9NFO7If2s9wWt7LT0WOZPvEOVg=;
        b=VKw+ZtaAAS+QByh+J34603M+OOE6e7+DwMZw9dW590No2MOSG+KErVmZl65lkxLNSm
         jsdNmIwrcd6aFTfLOse7ckkwCRPf6/35U+v9JheQ8Glm5Yl2mHujr55cJVGCgvJNOq5X
         aDOO/Lgc5XbRk6tHY/CNPn4DAOLiweKawfhNH7Aps67A7/WIUEj6MoLQo1Lh3+wa84Gn
         XTT2effly5ujuSPk+H98Ufjh0cbF+sM/dxA10uj88c2w0c/OUFlqaFjR5U3nD5DC8JTY
         tyaRnYb7gal5jPWQk4F9jyuOWIXU3KeAtyQKzwX8/wBZHfgfN7sQKX0PEDoJNrpB7u0C
         er/Q==
X-Gm-Message-State: ALKqPweVbDtepvux+LKByz9E1xZtBRIkSw8sRcuBDKNaKXfiG0UxUjZy
        wC9fZkMRatuzNpd2E9oYAo8=
X-Google-Smtp-Source: AB8JxZrLQSPpgie+2QNuZB5sE1+uZtgUnpj+UwpDqAP3bbJ96Tn2PwVvLgb2ZKUgcXz2h0hlyKSZPw==
X-Received: by 2002:adf:8f25:: with SMTP id p34-v6mr15737105wrb.193.1526928812690;
        Mon, 21 May 2018 11:53:32 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abpl225.neoplus.adsl.tpnet.pl. [83.8.53.225])
        by smtp.gmail.com with ESMTPSA id a185-v6sm13419023wmf.30.2018.05.21.11.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 11:53:31 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH v2 03/12] commit-graph: test that 'verify' finds corruption
References: <20180510173345.40577-1-dstolee@microsoft.com>
        <20180511211504.79877-1-dstolee@microsoft.com>
        <20180511211504.79877-4-dstolee@microsoft.com>
Date:   Mon, 21 May 2018 20:53:29 +0200
In-Reply-To: <20180511211504.79877-4-dstolee@microsoft.com> (Derrick Stolee's
        message of "Fri, 11 May 2018 21:15:17 +0000")
Message-ID: <86wovwdemu.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> Add test cases to t5318-commit-graph.sh that corrupt the commit-graph
> file and check that the 'git commit-graph verify' command fails. These
> tests verify the header and chunk information is checked carefully.
>
> Helped-by: Martin =C3=85gren <martin.agren@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t5318-commit-graph.sh | 53 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 6ca451dfd2..0cb88232fa 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -240,4 +240,57 @@ test_expect_success 'git commit-graph verify' '
>  	git commit-graph verify >output
>  '
>=20=20
> +# usage: corrupt_data <file> <pos> [<data>]
> +corrupt_data() {
> +	file=3D$1
> +	pos=3D$2
> +	data=3D"${3:-\0}"
> +	printf "$data" | dd of=3D"$file" bs=3D1 seek=3D"$pos" conv=3Dnotrunc
> +}

First, if we do this that way (and not by adding a test helper), the use
of this function should be, I think, protected using appropriate test
prerequisite.  Not everyone has 'dd' tool installed, for example on
MS Windows.

Second, the commit-graph file format has H-byte HASH-checksum of all of
the contents excluding checksum trailer.  It feels like any corruption
should have been caught by checksum test; thus to actually test that
contents is verified we should adjust checksum too, e.g. with sha1sum if
available or with test helper... oh, actually we have t/helper/test-sha1.
Unfortulately, it looks like it has no docs (beside commit message).

> +
> +test_expect_success 'detect bad signature' '
> +	cd "$TRASH_DIRECTORY/full" &&

This 'cd' outside subshell and withou accompanying change back feels a
bit strange to me.

> +	cp $objdir/info/commit-graph commit-graph-backup &&
> +	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> +	corrupt_data $objdir/info/commit-graph 0 "\0" &&

So 'CGPH' signature is currupted into '\0GPH'.

> +	test_must_fail git commit-graph verify 2>err &&
> +	grep -v "^\+" err > verify-errors &&

Minor nit: redirection should be cuddled to the file, i.e.:

  +	grep -v "^\+" err >verify-errors &&

A question: why do you filter-out lines starting with "+" here?

> +	test_line_count =3D 1 verify-errors &&
> +	grep "graph signature" verify-errors

If messages from 'git commit-graph verify' can be localized (are
translatable), then it should be i18n_grep, isn't it?

> +'
> +
> +test_expect_success 'detect bad version number' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	cp $objdir/info/commit-graph commit-graph-backup &&
> +	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> +	corrupt_data $objdir/info/commit-graph 4 "\02" &&

All right, so we replace commit-graph format version 1 ("\01") with
version 2 ("\02").  First, why 2 and not 0?  Second, is "\02" portable?

> +	test_must_fail git commit-graph verify 2>err &&
> +	grep -v "^\+" err > verify-errors &&
> +	test_line_count =3D 1 verify-errors &&

The above three lines is common across all test cases; I wonder if it
would be possible to extract it into function, to avoid code
duplication.

> +	grep "graph version" verify-errors
> +'
> +
> +test_expect_success 'detect bad hash version' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	cp $objdir/info/commit-graph commit-graph-backup &&
> +	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> +	corrupt_data $objdir/info/commit-graph 5 "\02" &&

All right, so we change / corrupt hash version from value of 1, which
means SHA-1, to value of 2... which would soon meen NewHash.  Why not
"\777" (i.e. 0xff)?

> +	test_must_fail git commit-graph verify 2>err &&
> +	grep -v "^\+" err > verify-errors &&
> +	test_line_count =3D 1 verify-errors &&
> +	grep "hash version" verify-errors
> +'


Note: all of the above tests check in load_commit_graph_one(), not the
one in verify_commit_graph().  Just FYI.

> +
> +test_expect_success 'detect too small chunk-count' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	cp $objdir/info/commit-graph commit-graph-backup &&
> +	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> +	corrupt_data $objdir/info/commit-graph 6 "\01" &&
> +	test_must_fail git commit-graph verify 2>err &&
> +	grep -v "^\+" err > verify-errors &&
> +	test_line_count =3D 2 verify-errors &&
> +	grep "missing the OID Lookup chunk" verify-errors &&
> +	grep "missing the Commit Data chunk" verify-errors

This feels too implementation specific.  We should have at least two
chunks missing (there are 3 required chunks, and number of chunks was
changed to 1), but commit-graph format specification does not state that
OID Fanout must be first, and thus it is two remaining required chunks
that would be missing.

> +'
> +
>  test_done

One test that I would like to see that 'git commit-grph verify'
correctly detects without crashing is if commit-graph file gets
truncated at various lengths: shorter than smallest possible
commit-graph file size, in the middle of fixed header, in the middle of
chunk lookup part, in the middle of chunk, just the trailer chopped off.

Best regards,
--=20
Jakub Nar=C4=99bski
