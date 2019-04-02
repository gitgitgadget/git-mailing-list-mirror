Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0419220248
	for <e@80x24.org>; Tue,  2 Apr 2019 12:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfDBMFn (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 08:05:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37171 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDBMFn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 08:05:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so3378309wmf.2
        for <git@vger.kernel.org>; Tue, 02 Apr 2019 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7EhNLgXQqKveAVVhce8T/lRP1iXEXjNmIOO2sKaBjP4=;
        b=pydz7KWccvgd/+17B1AI5YwmwKrb5yPMHd/L/K7bxrhdrgTa7QbFSCe3VxYoyFza7E
         q3zJnIf6GXSY8vK4qslgwyb8DoDuwIDL4LULSt1IIQ7NIxbNmQLotE2UFTtB++KUWKES
         dvZiUXgGBXLrUyN/LHtljeJWavrQcSiYOCJAMqOBPTM/Z3gxmVbxg71v+Kg1zleppSuh
         9m3o9mFuiK4+/71Ml51rrYqwl44A6sTmiU4rTGsgJeXwX7oYRx5eQgeRnMuBT3uoUKzO
         era+M2daiMKBSqqrKFjbngzeZ3cBwl/3VAllRsk877/dDyxqv+Hq77QzjCO4aKmLemAH
         V75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7EhNLgXQqKveAVVhce8T/lRP1iXEXjNmIOO2sKaBjP4=;
        b=ru0NDKGS8KhMii7Xt2jxzjPgLllUIVfnsGWOZB+ZvgvOEwQY7pv4xQ6UEt75nLKIxA
         dRxWX7270S+7TfCksfCCKu6kiJAQpyue6/JhUzFX06Mu4TkZrnDl1UqGfFm5m9YqKGCw
         mzcj+RWyF9vqjqB18bEkBJ/MxAOz4/b/fHH/EzvmjzZH+Uu+hb34WtXAL1x+z+HlQDfV
         iN+o8Yy1RdsZh7jkcife574D1Tch9gFj27bPLIiDdymd/5Rp30RunCcX7e623kmXYGYA
         SoiV1QxAINl1EDzYKktzLhHuoe8wOYlMDZkB7yaVbucxFXrAdOdELq3dhEwlu/DH5jCi
         HrGw==
X-Gm-Message-State: APjAAAXRBlhlnB06kRhz1aouHbcesJs/vN2NKaVx3SJx2sfYHvvI+/4y
        iQyzGy5dOs09KoS57Y24d6YR6W8v
X-Google-Smtp-Source: APXvYqy3DYkf8CKOFPyDMO12VfPNfvN+qpghN9bhXwoWnBKymEzKKrqqqttKUwMmwPksFv0yuJX+Rg==
X-Received: by 2002:a1c:80c1:: with SMTP id b184mr3402663wmd.109.1554206741058;
        Tue, 02 Apr 2019 05:05:41 -0700 (PDT)
Received: from szeder.dev (x4dbe364d.dyn.telefonica.de. [77.190.54.77])
        by smtp.gmail.com with ESMTPSA id a126sm16052963wmh.4.2019.04.02.05.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 05:05:40 -0700 (PDT)
Date:   Tue, 2 Apr 2019 14:05:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "Mazo, Andrey" <amazo@checkvideo.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Andrew Oakley <aoakley@roku.com>,
        Andrey Mazo <ahippo@yandex.com>
Subject: Re: [PATCH v3 2/8] git-p4: add failing test for "git-p4: match
 branches case insensitively if configured"
Message-ID: <20190402120537.GK32732@szeder.dev>
References: <cover.1553207234.git.amazo@checkvideo.com>
 <cover.1554141338.git.amazo@checkvideo.com>
 <68b68ce1e4782bba552a016867bfc629f0d5e24f.1554141338.git.amazo@checkvideo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68b68ce1e4782bba552a016867bfc629f0d5e24f.1554141338.git.amazo@checkvideo.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio and Andrey,

On Mon, Apr 01, 2019 at 06:02:21PM +0000, Mazo, Andrey wrote:
> diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
> index 6a86d6996b..c48532e12b 100755
> --- a/t/t9801-git-p4-branch.sh
> +++ b/t/t9801-git-p4-branch.sh
> @@ -608,10 +608,102 @@ test_expect_success 'Update a file in git side and submit to P4 using client vie
>  		cd branch1 &&
>  		grep "client spec" file1
>  	)
>  '
>  
> +test_expect_success 'restart p4d (case folding enabled)' '
> +	kill_p4d &&
> +	start_p4d -C1
> +'

There is a semantic conflict between this patch and commit 07353d9042
(git p4 test: clean up the p4d cleanup functions, 2019-03-13) in
'sg/test-atexit' currently cooking in 'pu': this patch adds a new
callsite of 'kill_p4d', but that commit renamed that function to
'stop_and_cleanup_p4d'.  Consequently, t9801 on 'pu' now fails with:

  +kill_p4d
  t9801-git-p4-branch.sh: 4: eval: kill_p4d: not found
  error: last command exited with $?=127
  not ok 28 - restart p4d (case folding enabled)

https://travis-ci.org/git/git/jobs/514513463#L5827

I wonder whether it would be worth amending 07353d9042 to keep
'kill_p4d' around as a wrapper around 'stop_and_cleanup_p4d' for the
time being.


https://public-inbox.org/git/20190313122419.2210-9-szeder.dev@gmail.com/

