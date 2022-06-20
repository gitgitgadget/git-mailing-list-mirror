Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DF6C433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 18:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343552AbiFTSqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 14:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbiFTSqV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 14:46:21 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16530101E8
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 11:46:21 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id t16so12136662qvh.1
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 11:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6rA5Qch4faBohv0p97xQYsaEM4Vy4chiEbQYlCvhk/s=;
        b=i6qKJsNxJLRihBPnJCOnxP5pds5mu0sF+tFTGYu68N10RJnh1Z88drkuQHJWKHp8cY
         j+3BfG3scTDvlH23wyGOhSFzn/LiU70yug/DDyh+b7G8e0eZ5HZySNUk1qQkQYX8b8mf
         EwjClD4YarlIKYcoMs6OYKqbE3q19Z83tkmG+1JnZmYAUcpBeKtbtp5Da2FjwixDI8Ad
         BOhmlgTccDJ2qb2cP0dH2t120KaOLpH1hYMDnIQsvpYc72mv1dDk+kOv0PHOp/nRXKfl
         GnmRmtqhCZuApyOlh0VmOqcXynZtPrzTPHXxfEzBrTC8UzfwB9XO2jlSCKaGwfR6huJT
         J9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6rA5Qch4faBohv0p97xQYsaEM4Vy4chiEbQYlCvhk/s=;
        b=34H72Ajfp+RMyae6Zdn8kQmb2Aaz2dp88TuQ/ht04HQh6MEOjVgs9TO/0zF9LABCT/
         JWMSa/0MXwBMRzYUEvln7VTHYOeSZ876P+KDRqafM/smnD+KLJZEZ9VUAw3+B0wW7d++
         fC13IPUjKyT7yHwbyufUSAx5oAeJ8DRkmaaVdFe0NBidWUOTWcNbD7RRTV8Y7TGUL9hY
         EtoYnjYC9ZhPQn9ikWhWi5MwCr5NuSyMNUPovVVhj7fnYvj4Q4Cri068SUNnG3NlJjDP
         oyqZ6oFgnlLar+mx5egUQzp9p+uUeVNwNCOJtgj6gx0psd6hbDhOn3bS2ZBJOmmTCI85
         lwJg==
X-Gm-Message-State: AJIora8X2x02k2aSRaiB+o+d3RP9t3JfwRIdKVB9J64P7e2mLGF4dq3A
        mLodIiHJFc0R2Mk5c2PEeb1E
X-Google-Smtp-Source: AGRyM1uC+16EPpyFRZKzwZ99Fbj1k34yHzOrAOj6W9ROKmNT2SpyBavcomqvGXLXjJDXFp8zqZZT5w==
X-Received: by 2002:a05:6214:1cc8:b0:46e:1920:70f8 with SMTP id g8-20020a0562141cc800b0046e192070f8mr20125844qvd.6.1655750780151;
        Mon, 20 Jun 2022 11:46:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e19f:4ebb:4dfb:e710? ([2600:1700:e72:80a0:e19f:4ebb:4dfb:e710])
        by smtp.gmail.com with ESMTPSA id d7-20020ac86687000000b00304e47b9602sm10822616qtp.9.2022.06.20.11.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 11:46:19 -0700 (PDT)
Message-ID: <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com>
Date:   Mon, 20 Jun 2022 14:46:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1
Content-Language: en-US
To:     rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
References: <00a401d884d0$32885890$979909b0$@nexbridge.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <00a401d884d0$32885890$979909b0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/20/22 2:04 PM, rsbecker@nexbridge.com wrote:
> Subtests t5510.69, 71, 97, 99, 125, 127, 147, 149, 151, 153, 155, 157, 159, 161, 163, 165, 167, 170 failed in rc1 on the NonStop ia64 platform. These were working in rc0, but after analysis, I do not think that is relevant. Here is what we see for subtest 69:
> 
> expecting success of 5510.69 'link prune fetch.prune=unset remote.origin.prune=unset fetch.pruneTags=unset remote.origin.pruneTags=unset --prune origin refs/tags/*:refs/tags/*; branch:kept tag:pruned':
> ...
>                         git fetch "file:///home/jenkins/.jenkins/workspace/Git_Pipeline@2/t/trash directory.t5510-fetch/." "+refs/heads/*:refs/remotes/origin/*" &&
> ...
>                         git$git_fetch_c fetch --prune "file:///home/jenkins/.jenkins/workspace/Git_Pipeline/t/trash directory.t5510-fetch/." refs/tags/*:refs/tags/* &&
> 
> What seems to be happening is that the test script is computing the wrong parent directory in the second case, cutting the @2. We use Jenkins for our builds and occasional multiple builds run. The @2 is Jenkins way of running in another place. This seems to be confusing the script parsing of the parent, causing the issue. When I rebuilt and test in the primary directory, the failures disappeared because no @2.

Yes, the script is incorrectly computing the remote URL. This
is not a bug in Git, but a bug in the test script.

The issue is this line (some tabs removed):

  new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')

At this point, $remote_url contains the file path including
the @ symbol. However, this perl invocation is dropping
everything starting at the @ to the next slash.

I'm not sure of a better way to accomplish what is trying to
be done here (replace 'origin' with that specific url) without
maybe causing other issues.

This line was introduced by e1790f9245f (fetch tests: fetch
<url> <spec> as well as fetch [<remote>], 2018-02-09).

Thanks,
-Stolee
