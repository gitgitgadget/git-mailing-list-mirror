Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 558C220248
	for <e@80x24.org>; Sun, 17 Mar 2019 16:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfCQQrL (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 12:47:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37959 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfCQQrL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 12:47:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id e10so7628919edy.5
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 09:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=KbwLvCasN0OGl9fNlQYQoCfQf84kiy++jqeY/G7nveU=;
        b=coT2Iq6OQFT0hq3V+WUNmMAvW91xcUcrHCi3riGm53mXFq24uIP4ayuc+QyLYBnkbx
         uJ/mhh8J5oYrkNvw21Gr2lWVoSzzme7pZqskEWmKUueNk4fvWrHYqZTuO8GnkAEG0iI/
         fgohm2z7JKUJURGqGkgyu77D9dKh+46nI/3V7wBARHY2K7FcdLv1t6McDyKq8UfDS8dF
         YcuE5xUPk7F0eaFRaLaE0H2wNz1zKnaZE77ancUmtBhqihbj4QC6tMRs0uGchQ9iFhnO
         5176ENwv5Yt/egE5JG6Wo2mfgmsumsWtyCWC1BPvULwwDpRNgKXPeihwA3WhqTnvdycZ
         69yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=KbwLvCasN0OGl9fNlQYQoCfQf84kiy++jqeY/G7nveU=;
        b=ra24+Uwjb/bXHqOmhTyfi4p31EilejoGJ8p+wspbp7652MZNYbK10Q09u2f5FJTMSP
         +FHBjeRId73f5JGRQc6IVFHDtNJhE3b2ZM3I5vl4N/8pOd8jBW4gCNXq01PVx0WkyB/P
         xBsGyIogSkMD0nXUkDoUbKXRa/XvOi0fEmKc8gkPTwKPm0vxzE2HPQHoaFcmusHLGM8X
         ZlDjZpFJk1GmE/ydGCaOKlTkHXXe+YQFdKBGiO4EL/Xcsewzom5AwWwvOpP3s436NnoZ
         a9etDvO51BGSLeXl8IMxnEBauGfuNVIPpnNUlqAD396/wiaVN3xTuwGZtbJKFLshoWxv
         9tQA==
X-Gm-Message-State: APjAAAVHXZW6k/LOWNwro0H7kJTHKRK8lNdzB/aLsT7vFPZhnfdTZE+/
        bIOTLXvFRAK1eHTbr5KZtZCdMMI/
X-Google-Smtp-Source: APXvYqzsFeX9/DP6Q1MOg/4/tK64OkTB47QF7tTxvjaZd/1ylAbG7o7XmhND4TWM50pb1P+5jtFo2Q==
X-Received: by 2002:a50:9e6b:: with SMTP id z98mr10169854ede.174.1552841229365;
        Sun, 17 Mar 2019 09:47:09 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id w6sm1829387eja.50.2019.03.17.09.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 09:47:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Chang <ttjtftx@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC][PATCH v3 2/3] t0000: avoid using pipes
References: <cover.1552835153.git.ttjtftx@gmail.com> <5a3c6e24eb901c830e8e43608d81aef5d7b60315.1552835153.git.ttjtftx@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <5a3c6e24eb901c830e8e43608d81aef5d7b60315.1552835153.git.ttjtftx@gmail.com>
Date:   Sun, 17 Mar 2019 17:47:08 +0100
Message-ID: <87imwha1o3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 17 2019, Jonathan Chang wrote:

> The exit code of the upstream in a pipe is ignored thus we should avoid
> using it. By writing out the output of the git command to a file, we can
> test the exit codes of both the commands.
>
> Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
> ---
>  t/t0000-basic.sh | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 53821f5817..47666b013e 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -1118,27 +1118,25 @@ P=$(test_oid root)
>
>  test_expect_success 'git commit-tree records the correct tree in a commit' '
>  	commit0=$(echo NO | git commit-tree $P) &&
> -	tree=$(git show --pretty=raw $commit0 |
> -		 sed -n -e "s/^tree //p" -e "/^author /q") &&
> +	git show --pretty=raw $commit0 >actual &&
> +	tree=$(sed -n -e "s/^tree //p" -e "/^author /q" actual) &&
>  	test "z$tree" = "z$P"

This change is an improvement just changing the "git" invocations. But I
wonder as we're reviewing this / churning this if we couldn't also
modernize this style to just:

    git .. >tmp &&
    sed -n -e <tmp >actual &&
    test_must_be_empty actual

>  '
>
>  test_expect_success 'git commit-tree records the correct parent in a commit' '
>  	commit1=$(echo NO | git commit-tree $P -p $commit0) &&
> -	parent=$(git show --pretty=raw $commit1 |
> -		sed -n -e "s/^parent //p" -e "/^author /q") &&
> +	git show --pretty=raw $commit1 >actual &&
> +	parent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual) &&
>  	test "z$commit0" = "z$parent"

ditto.

>  '
>
>  test_expect_success 'git commit-tree omits duplicated parent in a commit' '
>  	commit2=$(echo NO | git commit-tree $P -p $commit0 -p $commit0) &&
> -	parent=$(git show --pretty=raw $commit2 |
> -		sed -n -e "s/^parent //p" -e "/^author /q" |
> -		sort -u) &&
> +	git show --pretty=raw $commit2 >actual &&
> +	parent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | sort -u) &&
>  	test "z$commit0" = "z$parent" &&
> -	numparent=$(git show --pretty=raw $commit2 |
> -		sed -n -e "s/^parent //p" -e "/^author /q" |
> -		wc -l) &&
> +	git show --pretty=raw $commit2 >actual &&
> +	numparent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | wc -l) &&
>  	test $numparent = 1

And stuff like this to (skipping the wc -l):

    sed -n -e <tmp >actual &&
    test_line_count = 1 actual

>  '
>
> @@ -1147,7 +1145,8 @@ test_expect_success 'update-index D/F conflict' '
>  	mv path2 path0 &&
>  	mv tmp path2 &&
>  	git update-index --add --replace path2 path0/file2 &&
> -	numpath0=$(git ls-files path0 | wc -l) &&
> +	git ls-files path0 >actual &&
> +	numpath0=$(wc -l <actual) &&
>  	test $numpath0 = 1

ditto.

>  '
>
> @@ -1162,12 +1161,13 @@ test_expect_success 'very long name in the index handled sanely' '
>  	>path4 &&
>  	git update-index --add path4 &&
>  	(
> -		git ls-files -s path4 |
> -		sed -e "s/	.*/	/" |
> +		git ls-files -s path4 >actual &&
> +		sed -e "s/	.*/	/" actual |
>  		tr -d "\012" &&
>  		echo "$a"
>  	) | git update-index --index-info &&
> -	len=$(git ls-files "a*" | wc -c) &&
> +	git ls-files "a*" >actual &&
> +	len=$(wc -c <actual) &&
>  	test $len = 4098

Ditto. Maybe the initial author wanted to avoid writing out 4k lines,
but now that we're doing so anyway...
