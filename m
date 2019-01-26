Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_BLACK,URIBL_DBL_SPAM,URIBL_RED shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FCD41F453
	for <e@80x24.org>; Sat, 26 Jan 2019 08:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAZIxW (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 03:53:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36188 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfAZIxW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 03:53:22 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so9173827edb.3
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 00:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=f4edixwqoYhNHuh/TV++3umie84c6WCE/2MQr96rJok=;
        b=bTYOkkgHYPSS1/Cmsanlwwx1fzis3ZzvSDPvZGk61ANH3ocNuLI0tff7y4DInDbSYn
         0YiCA6hZ5YvGgu7hWVWkHCeloyF/FZo7UMP2rlPs9/uBRvBkT53gWANusnju+bAZFdk6
         IZ/BrjqhJkaMgg0W3eEifk/A2X5uPRYCaCrCGX/h6plqZ0Xv3xXi6aGiRLBhKzYuAsJs
         dHywZ0zzfBNVd12w/jTmlvVJ2hXO1HaPJTs4OWeDbV9N4zF6sESqBOo7muOzBj+fogBz
         wJPdF2KbnVKdrW8ng0g/30V9PSDIvEAUw56LM6gs18cigVlNjZXwz1cuRXTh8vr71W/d
         bQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=f4edixwqoYhNHuh/TV++3umie84c6WCE/2MQr96rJok=;
        b=mZjAfVcanBmW3JsUDgBVURzxu2DwADqEbAvYoHFzPOu/MezjJ+fZ4tn1NF30eqNNRa
         vzwDzJtIeeRx5w/wtc0nTb3P7zzlrj20rOub4qYzn5V+g2Kt4yqhrwLlRUrJ7RZVvYsI
         x+LdrvMpMQ0nG2kAoJf2+tNIHgrqUHuc4mmg0OCFTtoRIbtH24pUefDY862G7LYZ+0Ks
         hil9c5+zlLBU4NrgkKoAvFxyoXTnaGhS00ZHjS4Th2a0REw4pGukZ8SpwyXezHDWmHPA
         K9MOVYmBNw9EMZaOayEqNrHzgyN7XAWzj3Y5+lwhZVfoOG3Kq/cs9PDRPmSUUC3NqcBx
         Qh3w==
X-Gm-Message-State: AJcUukdojqzK3zCCaY1VvylNZEXLoshU9IC0sdzwnOOQev917HuCresF
        VyIYZXkIY4KiSU9pQHaAiEFhzC/r
X-Google-Smtp-Source: ALg8bN7Vvql075ngBGSKF9/7/S1/SSJxqUb2FzcwJ9UKfeefjuYI6DbEbIT1sxVDJ8FGaL/RSGEizQ==
X-Received: by 2002:a50:8689:: with SMTP id r9mr13204787eda.227.1548492799889;
        Sat, 26 Jan 2019 00:53:19 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id r18-v6sm6811562ejz.22.2019.01.26.00.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 00:53:19 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     William Hubbs <williamh@gentoo.org>
Cc:     git@vger.kernel.org, chutzpah@gentoo.org
Subject: Re: [PATCH v2 2/2] tests: add test for separate author and committer idents
References: <20190125215955.30032-1-williamh@gentoo.org> <20190125215955.30032-3-williamh@gentoo.org> <875zuc49uj.fsf@evledraar.gmail.com> <20190126010632.GA4000@whubbs1.gaikai.biz>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190126010632.GA4000@whubbs1.gaikai.biz>
Date:   Sat, 26 Jan 2019 09:53:18 +0100
Message-ID: <874l9v4x6p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 26 2019, William Hubbs wrote:

> On Sat, Jan 26, 2019 at 12:05:08AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Fri, Jan 25 2019, William Hubbs wrote:
>
> ...
>
>> > +	sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
>> > +	sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
>>
>> Fine, but FYI sets these variables for the rest of the test.
>
> I'm not quite sure what you mean by this. I want the environment
> variables to be *unset*. I don't want them to override anything in the
> config file for this test.
>
> Are you saying they will not be set for the test unless I set them,
> so I don't need the SANE_UNSET calls?

Sorry for not being clear. I just meant that unlike "test_config" the
"sane_unset" function won't reset the state at the end of the
"test_expect_success".

Right now it doesn't matter in practice since this is the last test
before "test_done", but as tests are added we tend to leak state between
them, which is why we use these "unset at the end" helper functions.

But unlike with config that doesn't matter in this case, since we want
these unset anyway.

Which, looking at this again, you'd only want if a previous test in the
file was leaking its state. That's not the case, so this isn't needed
and you can just apply this on top:

    diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
    index 06c7c0fb78..e5845b0b86 100755
    --- a/t/t7517-per-repo-email.sh
    +++ b/t/t7517-per-repo-email.sh
    @@ -87,8 +87,6 @@ test_expect_success REBASE_P \

     test_expect_success \
            'author and committer config settings override user config sett=
ings' '
    -       sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
    -       sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
            git config user.name user &&
            git config user.email user@example.com &&
            git config author.name author &&

You don't need to be paranoid and unset these, we already unset GIT_*
variables that aren't on a whitelist in test-lib.sh, see 'A call to
"unset"' there.
