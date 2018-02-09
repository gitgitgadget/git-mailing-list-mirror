Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EE781F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbeBIUFI (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:05:08 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:44861 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeBIUFF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:05:05 -0500
Received: by mail-wr0-f172.google.com with SMTP id v65so2609524wrc.11
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Xgp7BI7hsTDU35fd9TvqAwj7BLYNg9bZ7cMEN22tM6k=;
        b=Xdp7YPY0tEPO7hyRZhuJHLi7xneW/PYaV9WS7UxasOv50zQBDiA1+zJgorZVi58Fqc
         RfvCaRJqMez63WYodgmWJ/v98fMGMheBkKlQPxGIDKy9PIwYDrReBPviT8SFj+eMgFuq
         +UnRz2/bpOQIfk1OWxm/s+USYKWqXpalV0VLxeRsrtmVXzrHp6mFNmlALWxKbqTdcq/+
         MXIfRF2t/hnVlf/YEfsV6lyulVpJU/rBq3NSafNs5Kl1yZdVb7wvr9L8IfQgg4/RvmHo
         F0dNx2kZd99gG1mm4kBFcJLVoLKRDRj58Kp4SkHD/3CalFAtIS+YX6KWeJk52l9b0Bnu
         EIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Xgp7BI7hsTDU35fd9TvqAwj7BLYNg9bZ7cMEN22tM6k=;
        b=OS+jpixjWiOXC+G41y7mPlnuau+AefaRthGhlLgj2V6l69mAfcmfhay1ArRuwZ/lh4
         Zv1tnWISLAVcE9gApsYvD87c67IsOlYnaYOY3qFdhtMGOMtyiJKEC1Q23IoCaF3zNNLf
         z69MfmwRCZPivsOyIdl8tk0ZFQo0P9QC2DBxE/Hp6jiTerHUv/3PiAmR3GrS2se0u3dU
         MpXrUn2t0aO0xPPwonFlCE0FYZS5g5F6/2FD5dY8XTFEA5pxLqo5nKXh/scpqc9cBb0F
         CVW2Re2GFZMQmsDkWgQpo9nYNt/DWrXgIwSTpwhr6n5lEe2yJ7iehLNQtYLZCAG78kSB
         0drQ==
X-Gm-Message-State: APf1xPAJvUfdabnkqDXhNeIwzuERgm9ruC6uB4R13uu081UH8hszMV6y
        PlShd0O6fjPEEpvqmg0Sw/7ftiaO
X-Google-Smtp-Source: AH8x225UHMWybnwtkP0HopfOXM/OBgEstPf2Ys52glSwXUH+RItXigT1PWEHbpRt6pikN6uhMDYoQA==
X-Received: by 10.223.164.148 with SMTP id g20mr3587892wrb.49.1518206704061;
        Fri, 09 Feb 2018 12:05:04 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id a6sm6193502wri.10.2018.02.09.12.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 12:05:03 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 11/17] fetch tests: fetch <url> <spec> as well as fetch [<remote>]
References: <20180123221326.28495-1-avarab@gmail.com> <20180208161936.8196-1-avarab@gmail.com> <20180208161936.8196-12-avarab@gmail.com> <CAPig+cS4xhyYSnUHXshB=2SPYELe_HXUwxL-OGU4zx=PMFXdqg@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <CAPig+cS4xhyYSnUHXshB=2SPYELe_HXUwxL-OGU4zx=PMFXdqg@mail.gmail.com>
Date:   Fri, 09 Feb 2018 21:05:00 +0100
Message-ID: <87zi4ikjyr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 09 2018, Eric Sunshine jotted:

> On Thu, Feb 8, 2018 at 11:19 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> When a remote URL is supplied on the command-line the internals of the
>> fetch are different, in particular the code in get_ref_map(). An
>> earlier version of the subsequent fetch.pruneTags patch hid a segfault
>> because the difference wasn't tested for.
>>
>> Now all the tests are run as both of the variants of:
>>
>>     git fetch
>>     git -c [...] fetch $(git config remote.origin.url) $(git config remote.origin.fetch)
>>
>> I'm using -c because while the [fetch] config just set by
>> set_config_tristate will be picked up, the remote.origin.* config
>> won't override it as intended.
>>
>> Work around that and turn this into a purely command-line test by
>> always setting the variables on the command-line, and translate any
>> setting of remote.origin.X into fetch.X.
>> [...]
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> @@ -548,18 +548,52 @@ set_config_tristate () {
>>         *)
>>                 git config "$1" "$2"
>> +               key=$(echo $1 | sed -e 's/^remote\.origin/fetch/')
>
> Faster (thus more Windows-friendly) assuming that $1 always starts
> with "remote.origin":
>
>     key=fetch${u#remote.origin}

Tests fail with this and I'm not excited to be the first user in git's
test suite to use some novel shell feature, no existing uses of
${u[...].

I also think stuff like this is on the wrong side of cleverness
v.s. benefit. I can't find any reference to this syntax in bash or dash
manpages (forward-search "${u"), but echo | sed is obvious, and it's not
going to make a big difference for Windows.

>> +               git_fetch_c="$git_fetch_c -c $key=$2"
>>                 ;;
>>         esac
>>  }
>>
>> +test_configured_prune_type () {
>>         fetch_prune=$1
>>         remote_origin_prune=$2
>>         expected_branch=$3
>>         expected_tag=$4
>>         cmdline=$5
>> -
>> -       test_expect_success "prune fetch.prune=$1 remote.origin.prune=$2${5:+ $5}; branch:$3 tag:$4" '
>> +       mode=$6
>> +
>> +       if ! test -e prune-type-setup-done
>> +       then
>> +               test_expect_success 'prune_type setup' '
>> +                       git -C one config remote.origin.url >one.remote-url &&
>> +                       git -C one config remote.origin.fetch >one.remote-fetch &&
>> +                       remote_url="file://$(cat one.remote-url)" &&
>> +                       remote_fetch="$(cat one.remote-fetch)" &&
>
> Is there a reason that these values need to be captured to files
> (which are otherwise not used) before being assigned to variables?
> That is, wouldn't this work?
>
>     remote_url="file://$(git -C one config remote.origin.url)" &&
>     remote_fetch="$(git -C one config remote.origin.fetch)" &&

Nope, I'll just do that. This was cruft left over from an earlier
version which I didn't clean up.

>> +                       cmdline_setup="\"$remote_url\" \"$remote_fetch\"" &&
>> +                       touch prune-type-setup-done
>
> Why does "prune-type-setup-done" need to be a file rather than a
> simple shell variable (which is global by default even when assigned
> inside test_expect_success)?
>
> Also, since the purpose of this code seems to compute 'cmdline_setup'
> just once, can't you do away with 'prune-type-setup-done' altogether
> and change:
>
>     if ! test -e prune-type-setup-done
>
> to:
>
>     if test -z "$cmdline_setup"
>
>> +               '
>> +       fi

Yup, that's much simpler. Thanks.
