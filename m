Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52F6C207D2
	for <e@80x24.org>; Fri, 23 Jun 2017 22:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbdFWWUN (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 18:20:13 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36469 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbdFWWUM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 18:20:12 -0400
Received: by mail-pf0-f195.google.com with SMTP id z6so452114pfk.3
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 15:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BcKiqcTnpEoAubeYfHhZdptQT3zrcvThD6Ox101Czio=;
        b=Djvz7WPl/afbHpsH11GmkexSwSU8cr8CViX+JMjaal4KtUtntPKYDbeYdFZ6SLPDhP
         PyZktFkKfdYvNXY+m4R9aCms5ikGDMmJVq1vc9ykeJyZEdl06OvC6GnJ7Q0pE0k574MM
         PBgtVZzFvb003kW3YnzJQIuQsxwV8c22U1f7nFPdFI2Yvik+jjjs5W1p9wIZ06Nj+XXh
         SU91b6X5yjNe7ky8k7Y5CYDE6tF5dUhSCu3aGzal/kRuPEZA5drMZhXxrt1RkE2HL6nT
         w4haSP1pqYsSyz1fBAq3MFrBXrXhT7tnCMIJAYiXvr95dgyLILrl1eK5/vZQaA4Vv8pn
         3xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BcKiqcTnpEoAubeYfHhZdptQT3zrcvThD6Ox101Czio=;
        b=CURc6cQMjkyrWowm0+lwW98nqlo05OOEXGu+AFvY1WXK12OOqhnqXZvRoD/Ni7FIN0
         7CPwntRWzLiJm5wlMmcuu2WXj/0TB5zNZwuJN8Dfp4GxD8Ftw1fvfwkAqMlWcZYM6mLd
         I6da7LqswpNrrJeXuEw3A2hX9yu3vjZiUx9efmVPO8gumKxyioXepzKzth7Izu8e9WOV
         J0qIjzhxr5iaTDZxJTE1DcJM1DW/UNyboFyAk3UdCQuhOfz92+mHZMC7XY+LCzRiDZI7
         6xijmcXhlg1RZeYaOSnovBZ2yi7xYRJTELi3N1ZuT1mLer/tpuCIW+yTKmDyeBnLwa50
         opqQ==
X-Gm-Message-State: AKS2vOxS9wlcqTlQbn2FrtHdyF8dgTVSOamth0fzoCqW1v4uabDUQ9oo
        9wXSxn2a0SA8WyGfQPAEuw==
X-Received: by 10.84.241.141 with SMTP id b13mr2385888pll.107.1498256411663;
        Fri, 23 Jun 2017 15:20:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id f72sm11831123pfe.4.2017.06.23.15.20.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 15:20:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/3] t1700: make sure split-index respects core.sharedrepository
References: <20170623151640.24082-1-chriscool@tuxfamily.org>
        <20170623151640.24082-3-chriscool@tuxfamily.org>
Date:   Fri, 23 Jun 2017 15:20:10 -0700
In-Reply-To: <20170623151640.24082-3-chriscool@tuxfamily.org> (Christian
        Couder's message of "Fri, 23 Jun 2017 17:16:40 +0200")
Message-ID: <xmqqwp82bb39.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Add a few tests to check that both the split-index file and the
> shared-index file are created using the right permissions when
> core.sharedrepository is set.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t1700-split-index.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index af3ec0da5a..2c5be732e4 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -370,4 +370,21 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"
>  	test $(ls .git/sharedindex.* | wc -l) -le 2
>  '
>  
> +while read -r mode modebits filename; do

Style.

	while read -r mode modebits filename
	do

> +	test_expect_success POSIXPERM "split index respects core.sharedrepository $mode" '
> +		git config core.sharedrepository "$mode" &&
> +		: >"$filename" &&
> +		git update-index --add "$filename" &&
> +		echo "$modebits" >expect &&
> +		test_modebits .git/index >actual &&
> +		test_cmp expect actual &&
> +		newest_shared_index=$(ls -t .git/sharedindex.* | head -1) &&
> +		test_modebits "$newest_shared_index" >actual &&
> +		test_cmp expect actual
> +	'

Running this twice in a loop would create two .git/sharedindex.*
files in quick succession.  I do not think we want to assume that
the filesystem timestamp can keep up with us to allow "ls -t" to
work reliably in the second round (if there is a leftover shared
index from previous test, even the first round may not catch the
latest one).

How about doing each iteration this way instead?  Which might be a
better solution to work around that.

    - with core.sharedrepository set to false, force the index to be
      unsplit; "index" will have the default unshared permission
      bits (but we do not care what it is and no need to check it).

    - remove any leftover sharedindex.*, if any.

    - with core.sharedrepository set to whatever mode being tested,
      do the adding to force split.

    - test the permission of index file.

    - test the permission of sharedindex.* file; there should be
      only one instance, so erroring out when we see two or more is
      also a good test.

The last two steps may look like:

	test_modebits .git/index >actual && test_cmp expect actual &&
	shared=$(ls .git/sharedindex.*) &&
	case "$shared" in
	*" "*)
		# we have more than one???
		false ;;
	*)	
		test_modebits "shared" >actual &&
		test_cmp expect actual ;;
	esac

> +done <<\EOF
> +0666 -rw-rw-rw- seventeen
> +0642 -rw-r---w- eightteen
> +EOF
> +
>  test_done
