Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 451C11F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 15:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbdFLPQ3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 11:16:29 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36216 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751331AbdFLPQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 11:16:28 -0400
Received: by mail-pg0-f43.google.com with SMTP id a70so46386541pge.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7yLADQD1DTcamF+qvxHwR6tYrZV+qh0kxptTt1JQ5SI=;
        b=hDgM4a9AuHYpi/6k6Ve8Vul4Zz1KVUy8l/QaIw4eLQqubxvJV7RXx5v0D9l5XwIdQn
         cYIsBL0UuNzA/97VX6KPlffRy10Av504i9SFSdZKO95pv1W7eDI4WcZbG/dDS1RJe+hN
         3pCDgqCXa5hztn0QwLoOKbEkV4KuWL2YHwGm3iq1lFeHvBKXll/Wr3nJcupvllek7K/v
         XqHTVgoSApBIeHzuGpO0ax2Uh3LB9II/Llfs1yY8mzSg/pQfE8tgK+ZaAj18zLcPY106
         Q6eiKxznkiM1NduLZleJ9Gw0Kh3Rfa/J39Ka2G8XTljbd4IWHsUvAvSnCN21FKiM88wT
         gxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7yLADQD1DTcamF+qvxHwR6tYrZV+qh0kxptTt1JQ5SI=;
        b=B0Ae8PPubSVZVR27nhco2OIs9GUWigLr0Ylcy1zmfvsj3gQQAIiL+Klz9gJFmvH7Zk
         /4zGititUVZ+lcLEJtxdaBkyMHCM9nR6q8drw/XuBpglNzVn5cgs5yt4yabs4+3soY+X
         nOSj0z2NsRcAH9WDDXk9gJD5FPgal9iWq45BJYbafrqLcQlYEEWZWiVXlyzGBIgr8Gmd
         78tqzF3cANQENNG49TPpyqV2W/h6wNvaD4bEUPSh8yrLMke+Nb6ZiOp0i3i0thhT7bKf
         Jby21gLEGzMLGh5McsAlXzQ7GNeQ0erbtczJu4ZzR+rOJJkEjhsfJ0Vc36AfBSmoSwlZ
         5VOQ==
X-Gm-Message-State: AODbwcBNCKwLHuDEOnXejk53gPARbwTJwzBmnt5FYhs2UqhR9Zjt+dpc
        pMZPd9yJlId2zPiD060=
X-Received: by 10.84.217.206 with SMTP id d14mr56739242plj.59.1497280587822;
        Mon, 12 Jun 2017 08:16:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id o6sm17504092pfb.110.2017.06.12.08.16.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 08:16:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] t3200: add test for single parameter passed to -m option
References: <0102015c7a68c647-372a5a13-5412-4838-921d-66980bac4099-000000@eu-west-1.amazonses.com>
        <0102015c96f631f3-557a7960-2557-4aab-894b-efccf6728f31-000000@eu-west-1.amazonses.com>
Date:   Mon, 12 Jun 2017 08:16:26 -0700
In-Reply-To: <0102015c96f631f3-557a7960-2557-4aab-894b-efccf6728f31-000000@eu-west-1.amazonses.com>
        (Sahil Dua's message of "Sun, 11 Jun 2017 11:42:16 +0000")
Message-ID: <xmqqy3sxp779.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sahil Dua <sahildua2305@gmail.com> writes:

> Add a test for the case when only one parameter is passed to '-m'
> (move/rename) option.
>
> For example - if 'git branch -m bbb' is run, it should rename the
> currently checked out branch to bbb. There was no test for this
> particular case with only one parameter for -m option. However,
> there's one similar test case for -M option.
>
> Add test for making sure HEAD points to the bbb (new branch name). Also
> add a test for making sure the reflog that is moved to 'bbb' retains
> entries created for the currently checked out branch.
>
> Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
> ---
>  t/t3200-branch.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index fe62e7c775da6..720400c0e42af 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -100,6 +100,20 @@ test_expect_success 'git branch -m n/n n should work' '
>  	git reflog exists refs/heads/n
>  '
>  
> +test_expect_success 'git branch -m bbb should rename checked out branch' '
> +	test_when_finished git branch -D bbb &&
> +	test_when_finished git checkout master &&
> +	git checkout -b aaa &&
> +	git commit --allow-empty -m "a new commit" &&
> +	git rev-parse aaa@{0} >expect &&
> +	git branch -m bbb &&
> +	git rev-parse bbb@{1} >actual &&
> +	test_cmp expect actual &&

I think future readers of this test would appreciate if there were
some comment explaining why aaa@{0} and bbb@{1} (not bbb@{0}) are
expected to be the same here.

> +	git symbolic-ref HEAD >actual &&
> +	echo refs/heads/bbb >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'git branch -m o/o o should fail when o/p exists' '
>  	git branch o/o &&
>  	git branch o/p &&
>
> --
> https://github.com/git/git/pull/371

Other than that, looks sensible to me.

Thanks.
