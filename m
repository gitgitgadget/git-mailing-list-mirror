Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB068C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 18:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9342F2075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 18:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vWoD5Y6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391536AbgAXSpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:45:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64869 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388041AbgAXSpj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 13:45:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C1504117A;
        Fri, 24 Jan 2020 13:45:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ALhnzmVYgz9ZMlVO1cQJSHO0Ct0=; b=vWoD5Y
        6iCbH+I24+sWObuk6WwfUqgprhjUAc6rXtJDshNsTVomzFYdRj5T3oLRNI04fEFt
        W3N4HXA763KU9LDNNthxo97kl62lzm3rL6WHnngo6GK2+Wv/kZUEKyg8Jwq3RwBF
        tTAR4XJ1Z1MdiPEs/E7qvSjKzbgLWax2xEn8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cs+joEbBjPXTsVyDdOMDx+E3FH3flX2k
        lBGOIi037rDzSlmcRydoJtC3nPmRXtehH2vgTR7kDcL/Jk5NhGxf4t+kq62OOx6j
        Z99DGIl3OH3VBZdb/yIUlJeN1syHRqsBTvrSs4ZAM3bKWP3579TnMLKCJR3oT8yb
        roSXi4KE9MA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E04541179;
        Fri, 24 Jan 2020 13:45:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C12141178;
        Fri, 24 Jan 2020 13:45:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v4 3/6] t1300: create custom config file without special characters
References: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
        <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
        <9d19794dfd667b3f9752f0e8118dc9eb0c8f59f1.1579825267.git.gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 10:45:32 -0800
In-Reply-To: <9d19794dfd667b3f9752f0e8118dc9eb0c8f59f1.1579825267.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Fri, 24 Jan 2020
        00:21:03 +0000")
Message-ID: <xmqq5zh01ynn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3F9DB04-3ED9-11EA-8E4E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matthew Rogers <mattr94@gmail.com>
>
> Tests that required a custom configuration file to be created previously
> used a file with non-alphanumeric characters including escaped double
> quotes.  This is not really necessary for the majority of tests
> involving custom config files, and decreases test coverage on systems
> that dissallow such filenames (Windows, etc.).
>
> Create two files, one appropriate for testing quoting and one
> appropriate for general use.

Nicely done.

>
> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> ---
>  t/t1300-config.sh | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index e8b4575758..e5fb9114f6 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1710,18 +1710,23 @@ test_expect_success '--show-origin getting a single key' '
>  '
>  
>  test_expect_success 'set up custom config file' '
> -	CUSTOM_CONFIG_FILE="file\" (dq) and spaces.conf" &&
> +	CUSTOM_CONFIG_FILE="custom.conf" &&
>  	cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
>  	[user]
>  		custom = true
>  	EOF
>  '
>  
> +test_expect_success !MINGW 'set up custom config file with special name characters' '
> +	WEIRDLY_NAMED_FILE="file\" (dq) and spaces.conf" &&
> +	cp "$CUSTOM_CONFIG_FILE" "$WEIRDLY_NAMED_FILE"
> +'

OK.

>  test_expect_success !MINGW '--show-origin escape special file name characters' '
>  	cat >expect <<-\EOF &&
>  	file:"file\" (dq) and spaces.conf"	user.custom=true
>  	EOF
> -	git config --file "$CUSTOM_CONFIG_FILE" --show-origin --list >output &&
> +	git config --file "$WEIRDLY_NAMED_FILE" --show-origin --list >output &&
>  	test_cmp expect output
>  '
>  
> @@ -1747,7 +1752,7 @@ test_expect_success '--show-origin stdin with file include' '
>  	test_cmp expect output
>  '
>  
> -test_expect_success !MINGW '--show-origin blob' '
> +test_expect_success '--show-origin blob' '
>  	blob=$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
>  	cat >expect <<-EOF &&
>  	blob:$blob	user.custom=true
> @@ -1756,9 +1761,9 @@ test_expect_success !MINGW '--show-origin blob' '
>  	test_cmp expect output
>  '
>  
> -test_expect_success !MINGW '--show-origin blob ref' '
> +test_expect_success '--show-origin blob ref' '
>  	cat >expect <<-\EOF &&
> -	blob:"master:file\" (dq) and spaces.conf"	user.custom=true
> +	blob:master:custom.conf	user.custom=true
>  	EOF
>  	git add "$CUSTOM_CONFIG_FILE" &&
>  	git commit -m "new config file" &&

Nice to see these cleaned up.
