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
	by dcvr.yhbt.net (Postfix) with ESMTP id A0D0D1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 17:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbfACRW2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 12:22:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53576 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730229AbfACRW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 12:22:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so29885815wmb.3
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 09:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rxh5Z8y+rbg5JWOqlDWHbbfhfQ6pS8gojY6hcj2vEEk=;
        b=kOzbZr9pSFtuvuQic1lEI8H3XhEi8ujiQklxw0j81a7uqclvZng/9i9hJw1JLKoPvv
         kHXjkj2W2BVVCsOi1cEP9EWY/5CGYY3C+kDDg5+DsDviEq4fdYKoer8JB6SA8RV/cDm2
         Aq43dZZ4diUt813LZhliBiqOegRgguwuSJAOTW4boxNjZjM8/BLLd1sJqv4wI2vcjTS4
         aPL5RJ2s3TRG9R8sk5CmsNxNdvz4DDGXb2amQvW7BzU52favzOFxlncUBjUwzT0S0I/A
         IAala0OpsYkQZMD1Hp+83pwGPaM5bqkdgTgqE2Lhb+LdR1fs0cH2NdoulGC1ZqW4U/PF
         ipoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rxh5Z8y+rbg5JWOqlDWHbbfhfQ6pS8gojY6hcj2vEEk=;
        b=fcwsROL4rI1yIcLA4gyiZ5aMyYJZT3DmSTSMD8LGfS0EjfGowBYFB/1j2A+TVxtk1f
         ulFutgnxikgX1PdE1lAtxYrXP2LMKcsVtuNZM0LX/Lq+CrNQDVyFrfLxWGNnkAUlZGBY
         vuVds2A+xEw7ioMADU0EAlRuklImcga3A4XKaLs5swgVTKfm9ULAbqX/pryDA2M8MPpg
         fu/RwcY0ePbCaSPGYNsHBOgxqwSZQPUWX1TnUToJbQXZjpQBJdHaySpC7PsbS6p8wTw1
         PCynlMznAM1x0kKfUvL/rFReaisQYg32O4yeD9tSJUnE6eKrIsCq3QHeqof9dembJLR1
         aPuA==
X-Gm-Message-State: AA+aEWa41GP8h4GBFG6Sd+Ayunh6/uaQz6Vx4fZT1DoDiOnO/21YXF0H
        iG95W2mwQaiQvo4tp4AL7Sc=
X-Google-Smtp-Source: AFSGD/UR24VnE10V2b7gYIoJcJ4tVsXAo+jCqTjC974K6HfdJDTYhuPzrYjKzvuFO1y4I5v890zSKQ==
X-Received: by 2002:a1c:c10f:: with SMTP id r15mr39466683wmf.27.1546536144915;
        Thu, 03 Jan 2019 09:22:24 -0800 (PST)
Received: from szeder.dev (94-21-23-250.pool.digikabel.hu. [94.21.23.250])
        by smtp.gmail.com with ESMTPSA id p4sm38746751wrs.74.2019.01.03.09.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 09:22:24 -0800 (PST)
Date:   Thu, 3 Jan 2019 18:22:21 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 3/4] t3502: validate '-m 1' argument is now accepted
 for non-merge commits
Message-ID: <20190103172221.GB4673@szeder.dev>
References: <cover.1544762343.git.sorganov@gmail.com>
 <ccfe8ae38301b6ee1b0924fbf00eb5d20242ea5d.1544764226.git.sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ccfe8ae38301b6ee1b0924fbf00eb5d20242ea5d.1544764226.git.sorganov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 07:53:51AM +0300, Sergey Organov wrote:
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  t/t3502-cherry-pick-merge.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
> index b160271..3259bd5 100755
> --- a/t/t3502-cherry-pick-merge.sh
> +++ b/t/t3502-cherry-pick-merge.sh
> @@ -40,12 +40,12 @@ test_expect_success 'cherry-pick -m complains of bogus numbers' '
>  	test_expect_code 129 git cherry-pick -m 0 b
>  '
>  
> -test_expect_success 'cherry-pick a non-merge with -m should fail' '
> +test_expect_success 'cherry-pick explicit first parent of a non-merge' '
>  
>  	git reset --hard &&
>  	git checkout a^0 &&
> -	test_expect_code 128 git cherry-pick -m 1 b &&
> -	git diff --exit-code a --
> +	git cherry-pick -m 1 b &&
> +	git diff --exit-code c --
>  
>  '
>  
> @@ -84,12 +84,12 @@ test_expect_success 'cherry pick a merge relative to nonexistent parent should f
>  
>  '
>  
> -test_expect_success 'revert a non-merge with -m should fail' '
> +test_expect_success 'revert explicit first parent of a non-merge' '
>  
>  	git reset --hard &&
>  	git checkout c^0 &&
> -	test_must_fail git revert -m 1 b &&
> -	git diff --exit-code c
> +	git revert -m 1 b &&
> +	git diff --exit-code a

You need disambiguaion here, otherwise this test fails on
case-insensitive file systems:

  ++git diff --exit-code a
  fatal: ambiguous argument 'a': both revision and filename
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'
  error: last command exited with $?=128
  not ok 8 - revert explicit first parent of a non-merge

>  
>  '
>  
> -- 
> 2.10.0.1.g57b01a3
> 
