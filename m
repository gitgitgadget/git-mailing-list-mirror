Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DACFB1F404
	for <e@80x24.org>; Sat,  1 Sep 2018 11:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeIAQHQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 12:07:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52902 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeIAQHP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 12:07:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id y139-v6so7376899wmc.2
        for <git@vger.kernel.org>; Sat, 01 Sep 2018 04:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=twVeTd0egua74S8SutXMQcfPn79E6bq1p5bbO+5Kq9c=;
        b=QizPumzJFbKAua1k9jdbeiXE8VGLikG0srdyZ5fSISv8WtVdj91x3or7aemzJfJtG2
         URZeo25G04HoldiMz1PV6Cih0h7nbUYg8IDDK3tI6M7DWWhkBG5eiN7+YPH263dFmMMf
         jLk7XK0xa/R5ZIWEu5q6651JJCuSOMjCIdT5vTtEW3zbOG+UxFBqdBa0Gb8NvUerDqnF
         J6/SUjMlbWEnb/HT26EBCd8FO3MIIsSakRCve0ANCDqMxcIg0p4GXyYt/hvA+z/701my
         F4saDHTtqCTku+5EQh8vJZw5oCSKhN02sGZQE1R74SWfVzV0HDT91nxuYxAXSlrt+89Z
         3SlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=twVeTd0egua74S8SutXMQcfPn79E6bq1p5bbO+5Kq9c=;
        b=LM6pTuuooODlVofTHAySCYfcmR8g5D1O6/HRriY5D0h0t+pTf4+6znX39IPSLePIuf
         qQ3IWIcSDbhjGcJGMvHn6cZps0AUWssKkplSaJ5oSbCB+4XV0b6y2MdquxExoNNUUTEC
         0ozU6ShddIyIA31QymV2bqW1wynptlJNouKC/Lwzl7o5MMB+HD5hroIdb5Qp9//mwvDn
         Wq6+yWiWE8NdORbDTFX1FBrYPeKCK8+HDkDiKY4bJCf2zkMTWqsohfAiQiSp2p5fHjMC
         6fbfq9b9e9tPqg6ZCx58UNlrcfHTnAXH6Xh/08ru3/eKAxHoXjLJZNXWK+SNvKJWzubJ
         HODw==
X-Gm-Message-State: APzg51A6QpWQ6ouiQ/pwbdyCbX/90UIrXAmBm6wqJgrZJvgxxonDPu6a
        /TO+0d7/OE3Rj0RvuircShM=
X-Google-Smtp-Source: ANB0VdbONH3TFxMMiM0vpTvhYAzv1Q1YeuRideCSbIUF1cNzph8dOyhwxtlNNlhE2YcFDOeupWgdAA==
X-Received: by 2002:a1c:ba84:: with SMTP id k126-v6mr573543wmf.96.1535802927665;
        Sat, 01 Sep 2018 04:55:27 -0700 (PDT)
Received: from localhost (x4db10b5b.dyn.telefonica.de. [77.177.11.91])
        by smtp.gmail.com with ESMTPSA id d22-v6sm12612848wra.80.2018.09.01.04.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 04:55:26 -0700 (PDT)
Date:   Sat, 1 Sep 2018 13:55:21 +0200
From:   SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] Add test for commit --dry-run --short.
Message-ID: <20180901115521.GA18536@localhost>
References: <20180831053921.8083-1-ischis2@cox.net>
 <20180831053921.8083-3-ischis2@cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831053921.8083-3-ischis2@cox.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 10:39:20PM -0700, Stephen P. Smith wrote:
> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> index 810d4cea7..fc69da816 100755
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -682,4 +682,14 @@ test_expect_success '--dry-run with conflicts fixed from a merge' '
>  	git commit -m "conflicts fixed from merge."
>  '
>  
> +test_expect_success '--dry-run --short with conflicts fixed from a merge' '
> +	# setup two branches with conflicting information
> +	# in the same file, resolve the conflict,
> +	# call commit with --dry-run --short

I think the last line of the comment is unnecessary: it doesn't say
anything that is not obvious from the test's last line.

> +	rm -f test-file &&
> +	touch testfile &&

That filename should be 'test-file', i.e. with a dash, shouldn't it?

Anyway, if you want to truncate the file, then please use '>test-file'
instead of 'rm' and 'touch'.

> +	git add test-file &&
> +	git commit --dry-run --short
> +'
> +
>  test_done
> -- 
> 2.18.0
> 
