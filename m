Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6148820A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 18:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeLLSbo (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 13:31:44 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43923 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeLLSbj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 13:31:39 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so16383558eds.10
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 10:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=8Ul6M0PFIf+idDEiVdj7XSSVY4e0rAZ2ISpjznqR0KA=;
        b=k1AJNl7h6hetNiUbm80DeWa20OEOmmMVu5axu8cNziF2ZuxVb3OUCOvgKnxJMU18/D
         SS/XIR7LinveTRRHmDG5YGX/aLK75hdNOJ7NI59GGtdLZGfvP+KF4ZVz5vBARdv3jmuY
         RWPgikjVrZMFrNVCVJdIufFAWfulZhPXOa4HNv+uGuufZHww0Dy8WUsP5Aic4ZO/dPgs
         8yo7qzyilG4yIO8E2NXeILanv6qA4MkiibxEucQM8a3smtLZk2pY7k1puDoQcQK2VXPV
         aFmXc+lyJxODCm6ETAJ01Pz6lxymkfNOm73oqddpIsXKW1Gr2RqdvZNhZABpivBNIAGC
         dv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=8Ul6M0PFIf+idDEiVdj7XSSVY4e0rAZ2ISpjznqR0KA=;
        b=N1ik0UEuvqNcQxMj+dbc7Ir6cxD45mU/0t6kKjBUjgWL447jnnGf+GecomlAI7nssg
         RATughtb63nAT/0TU8oKG8okd4cc27B066pXb13aDqToI3OxS3MpQ2TGn7S6egQsAVBX
         fOyah90TxDILizyCRDbxhCr/IvjiHk3/atm5r8+enLyHvCT15icTIoH78qh+yRq9jPcx
         3p918Qd53Qotu65R3jao8p+2CedwDcyAbgDG2u8eypyeyzEpuR2HmILCBzhloSTkKpCp
         ghHKYejUTTnv7EAwCSgdw4UhNB0jIRoMVQMDx5pwwQuw6cATrFc2NNNwYtoal/wzQJTf
         BEOA==
X-Gm-Message-State: AA+aEWbTgKsALWxQjc/hvvcvq+FyQt3yPlKZ9+FctFUcAoGuQvKpXKyn
        Om+55ll5G6u1HcNYUvVmHdvwUPVlhCM=
X-Google-Smtp-Source: AFSGD/VRsjPHOQ4+6tumLldrt7eKrSX/dutoYw8nAjWk7uTpQ7p1VP4vq1EpqT4paGn31Ha05Sy6zw==
X-Received: by 2002:a50:86b7:: with SMTP id r52mr19016956eda.227.1544639495937;
        Wed, 12 Dec 2018 10:31:35 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id n23-v6sm2675361ejx.57.2018.12.12.10.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 10:31:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     CB Bailey <cb@hashpling.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] shortlog: pass the mailmap into the revision walker
References: <20181212164134.12922-1-cb@hashpling.org> <20181212171052.13415-1-cb@hashpling.org>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181212171052.13415-1-cb@hashpling.org>
Date:   Wed, 12 Dec 2018 19:31:33 +0100
Message-ID: <87va3ymwai.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 12 2018, CB Bailey wrote:

> From: CB Bailey <cbailey32@bloomberg.net>
>
> shortlog always respects the mailmap in its output. Pass the mailmap
> into the revision walker to allow the mailmap to be used with revision
> limiting options such as '--author'.
>
> This removes some apparently inconsistent behaviors when using
> '--author', such as not finding some or all commits for a given author
> which do appear under that author in an unrestricted invocation of
> shortlog or commits being summarized under a different author than the
> specified author.
>
> Signed-off-by: CB Bailey <cbailey32@bloomberg.net>
> ---
>
> Resending with omitted s-o-b.
>
>  builtin/shortlog.c |  2 ++
>  t/t4203-mailmap.sh | 28 ++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 88f88e97b2..a6fb00ade8 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -188,6 +188,8 @@ static void get_from_rev(struct rev_info *rev, struct shortlog *log)
>  {
>  	struct commit *commit;
>
> +	rev->mailmap = &log->mailmap;
> +
>  	if (prepare_revision_walk(rev))
>  		die(_("revision walk setup failed"));
>  	while ((commit = get_revision(rev)) != NULL)
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 43b1522ea2..9bee35b06c 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -383,6 +383,34 @@ test_expect_success 'Shortlog output (complex mapping)' '
>
>  '
>
> +test_expect_success 'Shortlog output (complex mapping, filtered)' '
> +
> +	printf "     1\tA U Thor <author@example.com>\n" >expect &&
> +
> +	git shortlog -es --author="A U Thor" HEAD >actual &&
> +	test_cmp expect actual &&
> +
> +	printf "     1\tCTO <cto@company.xx>\n" >expect &&
> +
> +	git shortlog -es --author=CTO HEAD >actual &&
> +	test_cmp expect actual &&
> +
> +	printf "     2\tOther Author <other@author.xx>\n" >expect &&
> +
> +	git shortlog -es --author="Other Author" HEAD >actual &&
> +	test_cmp expect actual &&
> +
> +	printf "     2\tSanta Claus <santa.claus@northpole.xx>\n" >expect &&
> +
> +	git shortlog -es --author="Santa Claus" HEAD >actual &&
> +	test_cmp expect actual &&
> +
> +	printf "     1\tSome Dude <some@dude.xx>\n" >expect &&
> +
> +	git shortlog -es --author="Some Dude" HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
>  # git log with --pretty format which uses the name and email mailmap placemarkers
>  cat >expect <<\EOF
>  Author CTO <cto@coompany.xx> maps to CTO <cto@company.xx>

Makes sense. Not saying this is how it should be, just an equivalently
working patch that I came up with on top while poing at this:

    diff --git a/builtin/shortlog.c b/builtin/shortlog.c
    index a6fb00ade8..ad84d70d07 100644
    --- a/builtin/shortlog.c
    +++ b/builtin/shortlog.c
    @@ -188,10 +188,9 @@ static void get_from_rev(struct rev_info *rev, struct shortlog *log)
     {
     	struct commit *commit;

    -	rev->mailmap = &log->mailmap;
    -
     	if (prepare_revision_walk(rev))
     		die(_("revision walk setup failed"));
    +	rev->mailmap = &log->mailmap;
     	while ((commit = get_revision(rev)) != NULL)
     		shortlog_add_commit(log, commit);
     }
    diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
    index 9bee35b06c..74a269052d 100755
    --- a/t/t4203-mailmap.sh
    +++ b/t/t4203-mailmap.sh
    @@ -384,17 +384,6 @@ test_expect_success 'Shortlog output (complex mapping)' '
     '

     test_expect_success 'Shortlog output (complex mapping, filtered)' '
    -
    -	printf "     1\tA U Thor <author@example.com>\n" >expect &&
    -
    -	git shortlog -es --author="A U Thor" HEAD >actual &&
    -	test_cmp expect actual &&
    -
    -	printf "     1\tCTO <cto@company.xx>\n" >expect &&
    -
    -	git shortlog -es --author=CTO HEAD >actual &&
    -	test_cmp expect actual &&
    -
     	printf "     2\tOther Author <other@author.xx>\n" >expect &&

     	git shortlog -es --author="Other Author" HEAD >actual &&

I.e. we just need the assignment after prepare_revision_walk() and the
first 2x tests were things that passed before this change.

So that's not a "let's squash that on top" but "I was poking at this and
here's stuff that I fiddled with or surprised me slightly".
