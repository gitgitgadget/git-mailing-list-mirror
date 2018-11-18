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
	by dcvr.yhbt.net (Postfix) with ESMTP id 088491F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 14:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeKSAjZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 19:39:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55390 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeKSAjY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 19:39:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so2811094wmc.5
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 06:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QABy3FS7BoSTZ0q+jFFAk7/DAptwamHhn2FlAHZN4zg=;
        b=ZaOaI9Fo2nyDatyOhZHYGJv0IYr9/nCiTVJlA3CyEo7ZTuSHN+0wUCKaglf4Wc9FLc
         wIub676dNah9YwMVG+X1wVGPoir3q9SwlckZa9xRp/iENjEDlw2nJnTT1LEmJOrEApcr
         cCSRleWtaIw7LL/LOkzBs2mkeMWY35k6gX4dQY5N7lLxDUBix89IbuJ1lWAwsUNDHqUV
         aP6AYB95CvA5ScC0JXSev0OQsiGmnI0hf2Wlp6CG7GFy+AX2u/OxWB3Y62NYgRJeL+fb
         RfWr81jOYAyyQG22wu8BJzWkQ6ibwNDrPNYvI5jpSdonxJ2s++c/9YkjKLH3ojBgkkDn
         yTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QABy3FS7BoSTZ0q+jFFAk7/DAptwamHhn2FlAHZN4zg=;
        b=YqGYuqs3pE4ScA7rFHDkNrRkFAFqvs+R4x9N9auwrfcg9+gdPfHkSmtE03H2hwIflt
         H94iZ7N6c9UVngAaDpr/oTN4y3ppQSze0icnrG/Z+C49yoX8DuFelbl9vV2LX0qgWbdH
         +S92NOcelIZuAWmwfVoTB6ffBYpcd1alYcUJpaIZR3bfQQIbnVU597x3jtrX3mKMAC94
         OEdEc6Gs5uMpci63nxIhdsnhiFAHt2r+tc7kI4bGDgEjS49w0OyjCns1KHZSNBCz0Lag
         WIKnXk0hjAEu4LdpGZmrJcBAZj9+MqBKPF/I7eBbgPnQp8h52bCuM6kKsKzcXuwp2YWm
         g1Dg==
X-Gm-Message-State: AGRZ1gIoRvF7yv1a6+OJSFxvsK5E9A1KqpX+/vAzivyqo6n4HtUgL8Lf
        pQhbRqSWIOkjro0s5Mg+kP+6jZ6G
X-Google-Smtp-Source: AFSGD/UxRWBQh7OcgUNlYDTVlWEV+fif55hbrhpJnorWc8QpJ4uYu1wmjnlI/UDOvg7DLhsZy9+HMg==
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr4514493wmc.31.1542550736362;
        Sun, 18 Nov 2018 06:18:56 -0800 (PST)
Received: from szeder.dev (x4dbe3c9c.dyn.telefonica.de. [77.190.60.156])
        by smtp.gmail.com with ESMTPSA id i7-v6sm41155435wrb.3.2018.11.18.06.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 06:18:55 -0800 (PST)
Date:   Sun, 18 Nov 2018 15:18:53 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 1/1] merge: add scissors line on merge conflict
Message-ID: <20181118141853.GR30222@szeder.dev>
References: <cover.1542380929.git.liu.denton@gmail.com>
 <cover.1542496915.git.liu.denton@gmail.com>
 <5c1aa82794da23077ef4ec4e836ee221c64162ef.1542496915.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c1aa82794da23077ef4ec4e836ee221c64162ef.1542496915.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 17, 2018 at 06:32:33PM -0500, Denton Liu wrote:
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 106148254d..0d3db34f08 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -247,6 +247,54 @@ test_expect_success 'merge --squash c3 with c7' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
> +	git config commit.cleanup scissors &&
> +	git reset --hard c3 &&
> +	test_must_fail git merge c7 &&
> +	cat result.9z >file &&
> +	git commit --no-edit -a &&
> +
> +	{
> +		cat <<-EOF
> +		Merge tag '"'"'c7'"'"'
> +
> +		# ------------------------ >8 ------------------------
> +		# Do not modify or remove the line above.
> +		# Everything below it will be ignored.

Note that these two lines of advice text are translated; see the
consequences below.

> +		#
> +		# Conflicts:
> +		#	file
> +		EOF
> +	} >expect &&

The {...} block is unnecessary, because there is only a single command
in there.

> +	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&

Please don't run git commands upstream of a pipe, because the pipe
hides their exit code.  Furthermore, put the sed script inside double
quotes, because the whole test is already in a single-quoted block.

I presume you wrote the test this way because you simply followed suit
of the previous test 'merge --squash c3 with c7', which did all the
same.  Bonus points for a preparatory patch that cleans up the
previous test ;)

> +	test_cmp expect actual

But most importantly, here 'test_cmp' compares translated advice text
as well, which fails in the GETTEXT_POISON build.  Use 'test_i18ncmp'
instead.

> +'
> +
> +test_expect_success 'merge c3 with c7 with --squash commit.cleanup = scissors' '
> +	git config commit.cleanup scissors &&
> +	git reset --hard c3 &&
> +	test_must_fail git merge --squash c7 &&
> +	cat result.9z >file &&
> +	git commit --no-edit -a &&
> +
> +	{
> +		cat <<-EOF
> +		Squashed commit of the following:
> +
> +		$(git show -s c7)
> +
> +		# ------------------------ >8 ------------------------
> +		# Do not modify or remove the line above.
> +		# Everything below it will be ignored.
> +		#
> +		# Conflicts:
> +		#	file
> +		EOF
> +	} >expect &&
> +	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
> +	test_cmp expect actual

Likewise.

> +'
> +
>  test_debug 'git log --graph --decorate --oneline --all'
>  
>  test_expect_success 'merge c1 with c2 and c3' '
> -- 
> 2.19.1
> 
