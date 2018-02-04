Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F66C1F404
	for <e@80x24.org>; Sun,  4 Feb 2018 19:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeBDTAF (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 14:00:05 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53214 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeBDTAB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 14:00:01 -0500
Received: by mail-wm0-f66.google.com with SMTP id g1so22119962wmg.2
        for <git@vger.kernel.org>; Sun, 04 Feb 2018 11:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=4zABfpLsrjbKeshUggmjIAGsWhI5y9+CmxxQzAJhzPA=;
        b=mhOlTmGkqTBh142fhFxjJplFNJvPF7+n2eDJ2u/t5Rwlm7ADrmpPTxaRkcRbQQzGVp
         MD+YAM8buGmly9VAtyecWPCSxUmIGY3WmdMKtaOX8U5RuwFOyRLtpymycommcfS5raFt
         iQMfKkj86EdDkJNqySa6LdNFkaGkwB/3J1mdcgcTWv/PzFiBwfgciYkiB6R2nr2MK+BJ
         E55RWS+Z+qNYEh40llL+lOH7Te07cCji+pwudxxtewBWW8HZSitCcKE9HyroHOtD0jiS
         Rvi/im137EZwohACVdaHbkXhMn+WPQEAK2rz4BL1BQR798H7EVS6FVREm/f02eWYgmmM
         G8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=4zABfpLsrjbKeshUggmjIAGsWhI5y9+CmxxQzAJhzPA=;
        b=YBmUsTTcU0pOUePcZ6szPbIrdKb1ZnnjH/4W3uygsBhapI1UqSKF7O4QGoCfFcXT5t
         YmhqptJkRLGAXxdV2jNu5B4MS/iFm9NdvBAGnTCwV0b7qUiorQ1OGWL8T1SW3Ved2f4N
         DdQy6yT6SwMBPxuu2dXrBxoxQ3U5nEolSB4JKSJ2pwspHhccHfx7NCHQI0zkSFEwKNdU
         9F18Q6QWr7DG3ERPTU6dm5tj1SmcxNUhL3/bx/2VDL0MMcU+SMx5yGYUduN931ExKDst
         5odrxEmSTCMX5qOwOTvqykTW+TUd9t7onCfE+Fg+0DxaB8gvLPD8ysonkyZ+55BR2v8G
         cROw==
X-Gm-Message-State: AKwxytcum8xMIcNg7RvbHzd5zlvVeHRbDmxMA6bgAmG64C1gdFaMRFf8
        Y6/0Tz/U3hzL9mQ8bCs967QjOaEj
X-Google-Smtp-Source: AH8x226gZEqIrSuIysQjGJGBisuACLu9Ccp90W4sRxb0LXj1Cle9jBAYgfBIR07CjGoTBIEfDt7KsQ==
X-Received: by 10.80.207.141 with SMTP id h13mr76412894edk.119.1517770800106;
        Sun, 04 Feb 2018 11:00:00 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id z7sm6597759edb.45.2018.02.04.10.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Feb 2018 10:59:59 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Chen Jingpiao <chenjingpiao@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC][PATCH] commit: add a commit.signOff config variable
References: <20180204020318.4363-1-chenjingpiao@gmail.com> <20180204113135.GA28130@flurp.local>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180204113135.GA28130@flurp.local>
Date:   Sun, 04 Feb 2018 19:59:58 +0100
Message-ID: <87zi4olgwh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 04 2018, Eric Sunshine jotted:

> --- >8 ---
> for cfg in true false
> do
>     for opt in '' --signoff --no-signoff
>     do
>         case "$opt:$cfg" in
>         --signoff:*|:true) expect= ;;
>         --no-signoff:*|:false) expect=! ;;
>         esac
>         test_expect_success "commit.signoff=$cfg & ${opt:---signoff omitted}" '
>             git -c commit.signoff=$cfg commit --allow-empty -m x $opt &&
>             eval "$expect git log -1 --format=%B | grep ^Signed-off-by:"
>         '
>     done
> done
> --- >8 ---
>
> A final consideration is that tests run slowly on Windows, and although
> it's nice to be thorough by testing all six combinations, you can
> probably exercise the new code sufficiently by instead testing just two
> combinations. For instance, instead of all six combinations, test just
> these two:
>
> --- >8 ---
> test_expect_success 'commit.signoff=true & --signoff omitted' '
>     git -c commit.signoff=true commit --allow-empty -m x &&
>     git log -1 --format=%B | grep ^Signed-off-by:
> '
>
> test_expect_success 'commit.signoff=true & --no-signoff' '
>     git -c commit.signoff=true commit --allow-empty -m x --no-signoff &&
>     ! git log -1 --format=%B | grep ^Signed-off-by:
> '
> --- >8 ---

I just skimmed this, but just to this question. I don't think we need to
worry about 2 v.s. 6 tests having an impact on Windows performance, it's
just massive amounts of tests like my in-flight wildmatch test series
that really matter.

But if we are worring about 2 v.s. 6 there's always my in-flight
EXPENSIVE_ON_WINDOWS prereq :)
