Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDD3D1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 19:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeKDET4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 00:19:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41842 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeKDET4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 00:19:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id c25-v6so4332850edt.8
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 12:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=f9QZPOLoFRENGzspfsXJQkvcbQurycoeZrN5LVCHnjU=;
        b=vRpxR2hzgVfltBdmwRL+PhVa4y4tk2SRRc0LFJol+zBkWJT7Kk5pqjJE9UNmZG9IyU
         1xA8lJQaER0jW7IewbBLwhgAwwODHwIOI9FVlk3oVhuM1CdVUOHRMnt7nRlrVKuC6E1V
         Nj5sRh+vbWIiHurM/JaRHzjy5z+EuAbWGGdWDomo7DGpKaYclx2fytnOLZYO8yEcKNX3
         jLJgPmsMewx53pYw2JfHusRVSHaJFDD4ZlHe+k2lpO7+k8cBVQ4jOEQnIwsJaEc1RhsN
         SfjBM7k+caAME8MHjgAqVIifTKBim36irS0A08ugvqn+S6E9DH4aPFFmOiblRLL62iaY
         Hy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=f9QZPOLoFRENGzspfsXJQkvcbQurycoeZrN5LVCHnjU=;
        b=IniFdhKY/QLAT8i5xpjIjHjEjR3xUh/LfxJ54vtlP6cPGjD7+K/9a0zY7xH588LcP9
         U32+jYpD9GTYZhkfQg+aZX6an3CVxyYVsoQIonShdDDN0LEwMDsABvLbxGUJBIqX7cIg
         4j4ti7E397klEdnE23Yd790dgEI4bcoD2p802G+24e2p3LHfyCBR9lcCKZu8uf3exBdQ
         oVDMqvMDQoL6POxYfi7tSWyXqOGPtnxuCQFLuVZmzHLmySDjtA5i5oK8spNzaHBm0gEh
         qvBPXE33XLKltFgRScoC9qQemcHccnXZ4OHn9yFbBQgsZkVXGqeiaBMBB4W9ZU+x1gni
         8wvQ==
X-Gm-Message-State: AGRZ1gIBucCBocssd2Cd66+mzZynA4JJNCozkCS5ALNKHRB4ySImvtaM
        Naz6j/e1V8h5VIoGjOtvgBM=
X-Google-Smtp-Source: AJdET5fKzYoUWgNkrVq/xlolq5O+6MTzCYJ9f0aTSJLUy2QDcARnHmHDgTvvn58Va8QuYYK2l2PqSQ==
X-Received: by 2002:a17:906:5842:: with SMTP id h2-v6mr10070923ejs.33.1541272065793;
        Sat, 03 Nov 2018 12:07:45 -0700 (PDT)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id i33-v6sm5740820edc.81.2018.11.03.12.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 12:07:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     tanushree27 <tanushreetumane@gmail.com>
Cc:     pclouds@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v3] commit: add a commit.allowEmpty config variable
References: <CACsJy8DttJ2EBcN8Kq-yECY0Pvp3vd0Vx45=szWD0cBW0Mcixw@mail.gmail.com> <20181103151205.29122-1-tanushreetumane@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181103151205.29122-1-tanushreetumane@gmail.com>
Date:   Sat, 03 Nov 2018 20:07:43 +0100
Message-ID: <87d0rm7zeo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 03 2018, tanushree27 wrote:

> +commit.allowEmpty::
> +	A boolean to specify whether empty commits are allowed with `git
> +	commit`. See linkgit:git-commit[1].
> +	Defaults to false.
> +

Good.

> +	if (config_commit_allow_empty >= 0)  /* if allowEmpty is allowed in config*/
> +		allow_empty = config_commit_allow_empty;
> +

This works, but != -1 is our usual idiom for this as you initialize it
to -1. I think that comment can also go then, since it's clear what's
going on.

> +# Tests for commit.allowEmpty config
> +
> +test_expect_success "no commit.allowEmpty and no --allow-empty" "
> +	test_must_fail git commit -m 'test'
> +"
> +
> +test_expect_success "no commit.allowEmpty and --allow-empty" "
> +	git commit --allow-empty -m 'test'
> +"
> +
> +for i in true 1
> +do
> +	test_expect_success "commit.allowEmpty=$i and no --allow-empty" "
> +		git -c commit.allowEmpty=$i commit -m 'test'
> +	"
> +
> +	test_expect_success "commit.allowEmpty=$i and --allow-empty" "
> +		git -c commit.allowEmpty=$i commit --allow-empty -m 'test'
> +	"
> +done
> +
> +for i in false 0
> +do
> +	test_expect_success "commit.allowEmpty=$i and no --allow-empty" "
> +		test_must_fail git -C commit.allowEmpty=$i commit -m 'test'
> +	"
> +
> +	test_expect_success "commit.allowEmpty=$i and --allow-empty" "
> +		test_must_fail git -c commit.allowEmpty=$i commit --allow-empty -m 'test'
> +	"
> +done

Testing both 1 and "true" can be dropped here. Things that use
git_config_bool() can just assume it works, we test it more exhaustively
elsewhere.

Your patch has whitespace errors. Try with "git show --check" or apply
it with git-am, it also doesn't apply cleanly on the latest master.

But on this patch in general: I don't mind making this configurable, but
neither your commit message nor these tests make it clear what the
actual motivation is, which can be seen on the upstream GitHub bug
report.

I.e. you seemingly have no interest in using "git commit" to produce
empty commits, but are just trying to cherry-pick something and it's
failing because it (presumably, or am I missing something) cherry picks
an existing commit content ends up not changing anything.

I.e. you'd like to make the logic 37f7a85793 ("Teach commit about
CHERRY_PICK_HEAD", 2011-02-19) added a message for the default.

So let's talk about that use case, and for those of us less familiar
with this explain why it is that this needs to still be optional at
all. I.e. aren't we just exposing an implementation detail here where
cherry-pick uses the commit machinery? Should we maybe just always pass
--allow-empty on cherry-pick, if not why not?

I can think of some reasons, but the above is a hint that both this
patch + the current documentation which talks about "foreign SCM
scripts" have drifted very far from what this is actually being used
for, so let's update that.
