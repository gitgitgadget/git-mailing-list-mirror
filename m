Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CC101F453
	for <e@80x24.org>; Fri, 26 Oct 2018 01:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbeJZJsa (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 05:48:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51766 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbeJZJsa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 05:48:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id 143-v6so3234075wmf.1
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 18:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CqshX4xGRR1T5WCmh9O4t/1/Z8g85T145o7pNNcYGK8=;
        b=SawpHg0m9kqVsqwajw0t+imPjJTcD9oTaU9vdcYdhCn2HJqvpwqURxzlPChCvAEWSD
         qfg4z4wgTWxEigIjfMzTbd3Q1yOzM7XYVSog0Y8R9DV8XuF1PwlzZSlCiaw7sll7s5b9
         JmIW16gJZtgaROhtHRZHlfOSW5eIloRx5WKJ8ti0yIeLZQcq2ku6+rG4quRKEQ4zj2qn
         ScGmQv85r/q5mX3gW39w3DkKl/zM7QePilvUnneiv3lneAnfyLWEUZqvC8r76vGITFpU
         71nG6J7sR2Aiv24PndyoCVR+giRB/OYO+kxIcyFBziEXq32SxfYUU3eSGs6AmdhJlVvN
         Kgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CqshX4xGRR1T5WCmh9O4t/1/Z8g85T145o7pNNcYGK8=;
        b=WZ0dYpJw0Q9IaZidLI0c1yN1UHVEouevIGRLURczUhY7qMtTSrTaxRggnrpeLfXWjv
         1oeRvyB+wYcP5Ypnhmp4NeJiCe1Wb4vnRVol2ROJ+GI0h8b/LKSueC1lBSikmSoBeZCs
         nLdh+ai8H+ko6b6W/8+ZNQNNumDpDe6PPB6gOMzLKDySdo/oy0jEhJcosDxWbB2EoU5T
         7qFvXcHfVe61KbBQBwkP1hd0DtToDBTr3Jww+hQqYX3fRztt/dg+BcZsOo15Ovz+Fjye
         bXi/8zWfiGY+6prGIwGb5QkBZEVVAVsQQpMJXL8QClD+zgUXR7VTzMaVIh/ncUNbDffB
         qDkQ==
X-Gm-Message-State: AGRZ1gIWrabTFsGZWLNzGlAca+nv52Uer2YipmAeFhKR+b/ttNRfrym+
        WIMc138JnZ+RYM0FLw78VJM=
X-Google-Smtp-Source: AJdET5dGguVDrIRxIIoH7JTJwCUD3fQkR8CAJG8qLbGauNPDxyNAdqn1N6ED6NWpNjH7YHPIoHpSqg==
X-Received: by 2002:a1c:9609:: with SMTP id y9-v6mr3583067wmd.67.1540516412810;
        Thu, 25 Oct 2018 18:13:32 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g4-v6sm6867233wrr.95.2018.10.25.18.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 18:13:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Slavica Djukic <slavicadj.ip2018@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        Slavica <slawica92@hotmail.com>
Subject: Re: [PATCH v3 1/3] [Outreachy] t3903-stash: test without configured user name
References: <cover.1540494231.git.slawica92@hotmail.com>
        <9ea38cd8e98890b8264696dfd647c1f9e709ae9e.1540494231.git.slawica92@hotmail.com>
Date:   Fri, 26 Oct 2018 10:13:31 +0900
In-Reply-To: <9ea38cd8e98890b8264696dfd647c1f9e709ae9e.1540494231.git.slawica92@hotmail.com>
        (Slavica Djukic's message of "Thu, 25 Oct 2018 21:20:45 +0200")
Message-ID: <xmqqa7n1fr2c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Slavica Djukic <slavicadj.ip2018@gmail.com> writes:

> From: Slavica <slawica92@hotmail.com>

Please make sure this matches your sign-off below.

> This is part of enhancement request that ask for 'git stash' to work
> even if 'user.name' and 'user.email' are not configured.
> Due to an implementation detail, git-stash undesirably requires
> 'user.name' and 'user.email' to be set, but shouldn't.
> The issue is discussed here:
> https://public-inbox.org/git/87o9debty4.fsf@evledraar.gmail.com/T/#u.

As the four lines above summarize the issue being highlighted by the
expect-failure rather well, the last two lines are unnecessary.
Please remove them.  Alternatively, you can place them after the
three-dash lines we see below.

> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
> ---
>  t/t3903-stash.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 9e06494ba0..ae2c905343 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1156,4 +1156,18 @@ test_expect_success 'stash -- <subdir> works with binary files' '
>  	test_path_is_file subdir/untracked
>  '
>  
> +test_expect_failure 'stash works when user.name and user.email are not set' '
> +    test_commit 1 &&

Just being curious, but do we need a fresh commit created at this
point in the test?  Many tests before this one begin with "git reset"
and then run "git stash" without ever creating commit themselves,
instead relying on the fact that there already is at least one
commit created in the "setup" phase of the test that a "stash"
created can be made relative to.  I do not think this test is all
that special in that regard to require its own commit.

> +    test_config user.useconfigonly true &&
> +    test_config stash.usebuiltin true &&
> +    sane_unset GIT_AUTHOR_NAME &&
> +    sane_unset GIT_AUTHOR_EMAIL &&
> +    sane_unset GIT_COMMITTER_NAME &&
> +    sane_unset GIT_COMMITTER_EMAIL &&
> +    test_unconfig user.email &&      

There are trailing whitespaces on the line above.  Please remove.

Also, Don't be original in the form alone---all other tests in this
file indent with a leading HT, not four SPs.  Please match the style
of surrounding code.

> +    test_unconfig user.name &&
> +    echo changed >1.t &&
> +    git stash
> +'
> +
>  test_done

Thanks.  Please do not reroll the next round at too rapid a pace.

