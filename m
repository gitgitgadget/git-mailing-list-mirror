Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C797F1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 16:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfJKQuJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 12:50:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34797 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfJKQuI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 12:50:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id j11so12707439wrp.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ibtABbXoECQRPuBIxHjPhQgrWekJwNGSd7qXOqssnvI=;
        b=FBV3y9ac07YD9fl00bHkTm5UV1JobxQKulGi/XrbaZWNCarNsnGACH+z40651QLspz
         Iv39GhHFSbg8sJdkFgl7Gi5sdHxwM0gUW+kWRIYW4rL2SzZQfOgOg1ceMi85ETQBSZfs
         PjoOzgMq0rDOXnhTLhLtnMXEOnWFdOxV5GYjwQe8TcgqO8D0LIkhDDR30UwH5f1tpyCj
         3rr0g4XQN2dBnvD8Exq5CDF6GMrYjFSeZAbGgZzyQcYxiJ1ghe1bi2iLtxGUpJ7L4RhY
         C5n8yzmMcQiElxyXrjo0Pxm/Zpg+kXMKXFV2IhfGEgNoe5Lx77zuhR+wWRzqTLzyAqOL
         PlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ibtABbXoECQRPuBIxHjPhQgrWekJwNGSd7qXOqssnvI=;
        b=K4dX6WN1Bp7E8dJspfRpmka7/tEuV4Lef076s5qe+OsrQk2pWQy+BSIaJc7GddfDl6
         TvA3IHaCbhx9NXzKcO4A+uxI/gp0nStv5LXqpe+3MsB7Gh9aCTufbYZjVOa5HP6gCtZR
         7viJ/45a5aqZ7gcx2PEh1Ta7wmJdjcq7PrCQSRyMWjzD5jhZo+0RLItqLQD05NtwfzSZ
         GeZfK1b9wi7UwPp+FN1g24uouGygHEMt9AFj42fUsfppySyb6Mj3qJxjrvOxbmdxqtS0
         2ILKmt9ijLSt9Od5hjUAmoM66g3URXaoGbAp3vJDSTkKWErYOcJ0sJz65ONHYvDQfX+3
         VvXQ==
X-Gm-Message-State: APjAAAWGvCPRHK3a3n8aRYUMQc8tjZtYYFHnfzLxzSctmGAn1l4yiLsM
        2gtj4Y8acg8welweuqx7Bbzw3El1yL8=
X-Google-Smtp-Source: APXvYqz0CqRzlfeJToQin5Tc8yTH7LU3KYs7e7OIWfcC+3n56dLVXEgscLz7PUb24P6oaU48onuUGQ==
X-Received: by 2002:a5d:67c5:: with SMTP id n5mr9755787wrw.72.1570812606659;
        Fri, 11 Oct 2019 09:50:06 -0700 (PDT)
Received: from liskov.home (host109-157-47-110.range109-157.btcentralplus.com. [109.157.47.110])
        by smtp.gmail.com with ESMTPSA id o70sm12712572wme.29.2019.10.11.09.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 09:50:05 -0700 (PDT)
Subject: Re: [PATCH 06/11] graph: tidy up display of left-skewed merges
To:     Derrick Stolee <stolee@gmail.com>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.383.git.gitgitgadget@gmail.com>
 <12c0916cb1ef033f917dc065cc1f18c0477296b8.1570724021.git.gitgitgadget@gmail.com>
 <5c688030-6351-93a3-89bd-e666d02d12d9@gmail.com>
From:   James Coglan <jcoglan@gmail.com>
Message-ID: <494a92ba-00ab-b5d8-ee66-4007647f8483@gmail.com>
Date:   Fri, 11 Oct 2019 17:50:04 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <5c688030-6351-93a3-89bd-e666d02d12d9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2019 18:19, Derrick Stolee wrote:
> On 10/10/2019 12:13 PM, James Coglan via GitGitGadget wrote:
>> +++ b/t/t4215-log-skewed-merges.sh
>> @@ -0,0 +1,42 @@
>> +#!/bin/sh
>> +
>> +test_description='git log --graph of skewed merges'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup left-skewed merge' '
> 
> 
> Could you skew this example to include a left-skewed octopus merge
> (and use fewer Git processes) with the following:
> 
> 	git checkout --orphan _a && test_commit A &&
> 	git switch -c _b _a && test_commit B &&
> 	git switch -c _c _a && test_commit C &&
> 	git switch -c _d _a && test_commit D &&	git switch -c _e _b && git merge --no-ff _c _d E &&
> 	git switch -c _f _a && git merge --no-ff _d -m F &&	git checkout _a && git merge --no-ff _b _c _e _f -m G
> and I think the resulting output will be:
> 
> *-----.   G
> |\ \ \ \
> | | | | * F
> | |_|_|/|
> |/| | | |
> | | | * | E
> | |_|/|\|
> |/| | | |
> | | |/  * D
> | |_|__/
> |/| |
> | | * C
> | |/
> |/|
> | * B
> |/
> * A

At this point in the history, commit E won't render like that -- this is before the change that flattens edges that fuse with the merge's last parent. I think the display of this history at this point will be:

	*-----.   G
	|\ \ \ \
	| | | | * F
	| |_|_|/|
	|/| | | |
	| | | * |   E
	| |_|/|\ \
	|/| |/ / /
	| | | | /
	| | | |/
	| | | * D
	| |_|/
	|/| |
	| | * C
	| |/
	|/|
	| * B
	|/
	* A

Is there a particular reason for wanting to include this test case? What particular combination of states is it designed to test? (My guess is that it includes an octopus merge where the original test does not.) I'd be happy to add it at the appropriate point in the history if it's adding coverage not provided by the other tests.
