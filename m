Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 366061F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 06:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbfJYGSa (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 02:18:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53935 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfJYGSa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 02:18:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 856F124507;
        Fri, 25 Oct 2019 02:18:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=wKYWfTV0IKj5ZCCuHyu+4amsbi4=; b=qkWABimao7Ulsdo0dvqW
        UKermcgbgw9pT5bLgW/PvfP4grTcFrtlhB/sTMOKbZkFtcJociR7z54I4w9PQDdE
        /PNeE+OlCD7DBHEUmusKRITDYMgIGCf76U6LL6DEibpM+cZB+GQqzuU89QxuJI6t
        TJ/ZXPtzDxrQt2jrRbmNeaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=rdzGVyiehRVKGpokZ6krcKakRAReqVFY5wSK8iOBZvR752
        00GTTZMHeCuxPYfZqfYEVf+W634RZbKavZ/Z684MjhLBRdx+9N5wpVL2h8s88rUT
        oG/gGZ6AaY5Hra1s0x/lLEq41dIvuSzSsRq8odcn65M1R1JLpyLV+QX1ysvgc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DC6A24505;
        Fri, 25 Oct 2019 02:18:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B734A24504;
        Fri, 25 Oct 2019 02:18:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 2/3] t4203: Use test-lib.sh definitions
References: <20191024233617.18716-1-prarit@redhat.com>
        <20191024233617.18716-3-prarit@redhat.com>
Date:   Fri, 25 Oct 2019 15:18:25 +0900
Message-ID: <xmqq4kzxcpqm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 417A946A-F6EF-11E9-B9E9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prarit Bhargava <prarit@redhat.com> writes:

> Use name and email definitions from test-lib.sh.
>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>  t/t4203-mailmap.sh | 94 +++++++++++++++++++++++-----------------------
>  1 file changed, 47 insertions(+), 47 deletions(-)
>
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 918ada69eb96..e8f9c0f5bc8c 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -13,8 +13,8 @@ fuzz_blame () {
>  }
>  
>  test_expect_success setup '
> -	cat >contacts <<-\EOF &&
> -	A U Thor <author@example.com>
> +	cat >contacts <<- EOF &&
> +	$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
>  	nick1 <bugs@company.xx>
>  	EOF
>  
> @@ -33,19 +33,19 @@ test_expect_success 'check-mailmap no arguments' '
>  '
>  
>  test_expect_success 'check-mailmap arguments' '
> -	cat >expect <<-\EOF &&
> -	A U Thor <author@example.com>
> +	cat >expect <<- EOF &&
> +	$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
>  	nick1 <bugs@company.xx>
>  	EOF
>  	git check-mailmap \
> -		"A U Thor <author@example.com>" \
> +		"$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" \
>  		"nick1 <bugs@company.xx>" >actual &&
>  	test_cmp expect actual
>  '
>  
>  test_expect_success 'check-mailmap --stdin' '
> -	cat >expect <<-\EOF &&
> -	A U Thor <author@example.com>
> +	cat >expect <<- EOF &&
> +	$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
>  	nick1 <bugs@company.xx>
>  	EOF
>  	git check-mailmap --stdin <contacts >actual &&

Strictly speaking, the above is different from the ones that appear
in the rest of this patch and the ones in step 1/3.

The reason why you need to expect "author@example.com" in the output
of check-mailmap is only because the same hardcoded string is used
in the setup step of this test.

The remainder of this file and step 1/3 are quite different and are
all good changes.  The commit the data comes from gets created with
the value that happens to be set to GIT_AUTHOR_NAME in test-lib---if
the assigned value changes over there, the tests that expect
hardcoded "author@example.com" would break, and that makes the step
1/3 and the remainder of this patch good changes.

In any case, I think all of 1/3 and 2/3 taken together are good
preparatory steps for 3/3.

Thanks, will queue.

