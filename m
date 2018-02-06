Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67A9E1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 16:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeBFQXb (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 11:23:31 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:53197 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbeBFQX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 11:23:29 -0500
Received: by mail-wm0-f49.google.com with SMTP id g1so4849466wmg.2
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 08:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0i/uipL3DWO4fjId65Jq8sXPzVXOoBm6Y9sUyjIOPQ0=;
        b=dybSBVfawvL1eMypsDceicSPzU+i3gP4YVEWShmyFWbzpGRGAxuIwaubRX7kghTvrM
         3BJnujpx6KO162U1I1ZW05FP+ngC9mLpajza0lsv/U6lvIAccqljVqeFQu2SMeH/6GRS
         F20PxrsmMsJ0JtYnLRSd+hNhSwFvHdM4AjfSrdgwGwjm4PFAWHbi/HvOvcv/Vn4ATp2i
         pHlv5tiMpu7+v2YLBVr8flcZloYb7/tvVqsAZUGuZjamo4kl/LgxQss2PanDYcSQP9FG
         HO2mZb9dLcePCvaWYhiROwlGIyRIlUPJDyax/TUKoo2gXm05CVybNDx8dbt7NIFtixL7
         W3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0i/uipL3DWO4fjId65Jq8sXPzVXOoBm6Y9sUyjIOPQ0=;
        b=rFqhHqUqx7aVAP4DZIXM5km53Ox9QoCTvAW7wr/iBZ/w7CIvm2X5WMlpL3JS9uPtvL
         re/imUatA/z+BUjyTFuYxXvxIEf0VSkEAWsf6FNX+KIsbbwoMaE0fSY58c9cY3ymbDWL
         TuAFd3vJlfBam9nHdgyMtBNlXurST04U5svZrcsfXDGWQS3ZtAzi+9EeygJ3ubF4M5jB
         6mGUonGIKwMNK9iB41d8rcp+nVLSlc5sLqmP6S5pWByMO9omgJ9uSgqualwOIshw5BoE
         7hKPCE/DfllJbLGnWLeZFFuTDPpjulFVylbexJvz00XsnP8OgHAKLdugcwOHPkWzQx27
         gPtw==
X-Gm-Message-State: APf1xPAoS5T83k+ESWAtr7r74qJ2vylQKRNkG+g1LB52tNH+UJsZ/5ym
        agtZvDKjrgUtowQzN4bPsQN36p8O
X-Google-Smtp-Source: AH8x227obiFEnnyre2Idvp46ZKyKRp5rOnpROyu4ihN9zkhekkvRgNTNJbGgo3XQbfFTIFsGRKy0dw==
X-Received: by 10.80.142.194 with SMTP id x2mr4609471edx.274.1517934207465;
        Tue, 06 Feb 2018 08:23:27 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id f5sm8905184edb.65.2018.02.06.08.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Feb 2018 08:23:26 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/11] document & test fetch pruning & add fetch.pruneTags
References: <20180121000304.32323-1-avarab@gmail.com> <20180123221326.28495-1-avarab@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180123221326.28495-1-avarab@gmail.com>
Date:   Tue, 06 Feb 2018 17:23:25 +0100
Message-ID: <87h8quytmq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 23 2018, Ævar Arnfjörð Bjarmason jotted:

> I'm now just skipping quoting things like +refs/... on the
> command-line, which as grepping the rest of the test suite shows is
> fine, this eliminated the need for "fetch tests: double quote a
> variable for interpolation" so I've ejected it.

There's a segfault bug in 11/11, which wasn't found because the test
suite doesn't test `git fetch <url>` just `git fetch <named>` and this
is handled differently.

I'll send a fix soon, but don't merge this down from pu for now.

In order to test for that I brought that cmdline quoting patch back, I
can't find a better way to do that, and in addition I have this similar
WIP patch:

    diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
    index 2f5bd966be..8fe4f3c13b 100755
    --- a/t/t5510-fetch.sh
    +++ b/t/t5510-fetch.sh
    @@ -549,13 +549,39 @@ set_config_tristate () {
     }

     test_configured_prune () {
    +	test_configured_prune_guts "$@" "name"
    +	test_configured_prune_guts "$@" "link"
    +}
    +
    +test_configured_prune_guts () {
     	fetch_prune=$1
     	remote_origin_prune=$2
     	expected_branch=$3
     	expected_tag=$4
     	cmdline=$5
    -
    -	test_expect_success "prune fetch.prune=$1 remote.origin.prune=$2${5:+ $5}; branch:$3 tag:$4" '
    +	mode=$6
    +
    +	if ! test -e prune-guts-setup
    +	then
    +		test_expect_success 'prune_guts setup' '
    +			git -C one config remote.origin.url >one.remote-url &&
    +			git -C one config remote.origin.fetch >one.remote-fetch &&
    +			touch prune-guts-setup
    +		'
    +	fi
    +
    +	if test "$mode" = 'link'
    +	then
    +		remote_url="file://$(cat one.remote-url)"
    +		remote_fetch="$(cat one.remote-fetch)"
    +		cmdline_setup="\"$remote_url\" \"$remote_fetch\""
    +		if test "$cmdline" != ""
    +		then
    +			cmdline=$(printf "%s" "$cmdline" | sed -e 's! origin! "'"$remote_url"'"!g')
    +		fi
    +	fi
    +
    +	test_expect_success "$mode prune fetch.prune=$1 remote.origin.prune=$2${5:+ $5}; branch:$3 tag:$4" '
     		# make sure a newbranch is there in . and also in one
     		git branch -f newbranch &&
     		git tag -f newtag &&
    @@ -563,7 +589,7 @@ test_configured_prune () {
     			cd one &&
     			test_unconfig fetch.prune &&
     			test_unconfig remote.origin.prune &&
    -			git fetch &&
    +			git fetch '"$cmdline_setup"' &&
     			git rev-parse --verify refs/remotes/origin/newbranch &&
     			git rev-parse --verify refs/tags/newtag
     		) &&

It'll be amended a bit more, but the general idea is there, because of
how this whole quoting mess looks like I have to resort to the above
hack outside of the test setup.
