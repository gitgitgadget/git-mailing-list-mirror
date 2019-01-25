Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_BLACK,URIBL_DBL_SPAM,URIBL_RED shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D853211B5
	for <e@80x24.org>; Fri, 25 Jan 2019 23:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfAYXFL (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 18:05:11 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45986 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfAYXFL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 18:05:11 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so8583183edb.12
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 15:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Ep9qAUseawmcN1Nuyf9+lz2AHMVexKXQotMV4CSFhdA=;
        b=k23DB2P/8d2vptjuSVkAvAbN/Kc711arv2HrKIV/Rw/SINFwoj4rATtnYk6ge/ZQPx
         FbWOFfPdnBJgTfQrS28xySpPo3MNaFNuSuSBxy+bmYOsFSa0bcGDeQTi8nDgxS2P/Ie8
         1e/cZPWc0NKEJdQBn9S88omX7OxRUR6Gyiu1LcyAMs+zTgjNwVvviQhH8G2HP7gt7HF5
         Vk2p9ucO3IkjNWM4cx8Nnhs+a1kvEc0xzXfjuaFNOqoLJmQmhPtgB4tu1euCUJAD195i
         /ZTkna7YTQNo8czYMpdutvY7SuHIHYBL5mOmgqaSZIovz3cK2yMArM3r5PpJkugiMUR5
         4dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Ep9qAUseawmcN1Nuyf9+lz2AHMVexKXQotMV4CSFhdA=;
        b=rQV5FjQjaSsRMbvg19FGzrVNOch679F7pWJSdKTUUqm00ydDFBU22esiob1p8HPI9H
         aov95kBVjzMM+3/vhhN3/gNK4T0PJ7kcuXtgG5sI3DO6rEB10lY0Uhhr6BG/7XZKN14u
         P5mXGvmkRZSiYyNzuxio+bOvV/nzRcm4Im/p14XU/yP7D1lxE4x97yC4x803BKwH41cT
         KNCy37bqzfljHLwdIGsAZDdw75S1/8bqn6l7JVldZEKD82nU2JgtT5QUl3Pa5JGfoCHJ
         bJiHH4HT0Znw2y8nYdKv2pBv94WwzVzeOSmDF/TI2Ixlzy2DG60OwGxKD+cixpxJMBKS
         y+Ow==
X-Gm-Message-State: AJcUukeW9fLpUpc70CbnbrKtIywrslK0rQj8Glgr3Wqa4172VUjceRgX
        qXYHrOQ+8F7PNLHp8euvbNuBGtgl
X-Google-Smtp-Source: ALg8bN6DHZ83/DeJTwldvAGSO0CeVOU4MCbBRpTxjNnyxCtv1lnOuNnvICV+3EoH8c8FRvhFkCO1AA==
X-Received: by 2002:aa7:ca0d:: with SMTP id y13mr12096443eds.285.1548457509498;
        Fri, 25 Jan 2019 15:05:09 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id c12sm11570484edi.52.2019.01.25.15.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 15:05:08 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     William Hubbs <williamh@gentoo.org>
Cc:     git@vger.kernel.org, chutzpah@gentoo.org
Subject: Re: [PATCH v2 2/2] tests: add test for separate author and committer idents
References: <20190125215955.30032-1-williamh@gentoo.org> <20190125215955.30032-3-williamh@gentoo.org>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190125215955.30032-3-williamh@gentoo.org>
Date:   Sat, 26 Jan 2019 00:05:08 +0100
Message-ID: <875zuc49uj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 25 2019, William Hubbs wrote:

> Signed-off-by: William Hubbs <williamh@gentoo.org>
> ---
>  t/t7517-per-repo-email.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
> index 231b8cc19d..06c7c0fb78 100755
> --- a/t/t7517-per-repo-email.sh
> +++ b/t/t7517-per-repo-email.sh
> @@ -85,4 +85,21 @@ test_expect_success REBASE_P \
>  	test_must_fail git rebase -p master
>  '

Let's include this in the main patch. We don't split up tests into their
own patches like this.

> +test_expect_success \
> +	'author and committer config settings override user config settings' '

This can just be on one line. We're not strict about 79 characters in
tests.

> +	sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
> +	sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&

Fine, but FYI sets these variables for the rest of the test.

But more importantly there should be a test for how the various override
interactions between the config & env variables work. I.e. whether
GIT_COMMITTER_NAME set in the env will override "user.email" etc.

> +	git config user.name user &&
> +	git config user.email user@example.com &&
> +	git config author.name author &&
> +	git config author.email author@example.com &&
> +	git config committer.name committer &&
> +	git config committer.email committer@example.com &&

This should use "test_config" so it'll be unset after this test.

> +	test_commit config-names &&
> +	[ "$(git log --format=%an -1)" = "author" ] &&
> +	[ "$(git log --format=%ae -1)" = "author@example.com" ] &&
> +	[ "$(git log --format=%cn -1)" = "committer" ] &&
> +	[ "$(git log --format=%ce -1)" = "committer@example.com" ]

Should use something like test_cmp so that on failure we see what the
difference is. I'd just do:

    cat >expected <<EOF... &&
    git log --format="an:%an%nae:%ae[...]" -1 >actual &&
    test_cmp ...

> +'
> +
>  test_done
