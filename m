Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 857791F407
	for <e@80x24.org>; Fri, 15 Dec 2017 18:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755530AbdLOS6U (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 13:58:20 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:45577 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755419AbdLOS6T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 13:58:19 -0500
Received: by mail-wm0-f41.google.com with SMTP id 9so19265539wme.4
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 10:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=udcroEQQ6Z6OCoUfUXDW3z8lPuS4P2Y882ZZnQE+47g=;
        b=KdAo1tkpxDg2eXNY0pKZU71/Nm9rHZckrC/5Ug+mBYHxV+KUmJnSJLCDtJhfwVnasz
         /8ssqyPpHbeqSjsg8lDDSZ/GkG1/kzI9Ow/KnGWHk6jL+1o6XDmT0iyXdY1VXBJKshQX
         GeonBVIZP6poj51y6Gv8HqseUWRryOzNIs1ICOa4z/GWM5/zMq07wPY9aJiW7TI/1wi2
         ztLU3GKsZahvYD3dpbYP72hzhZvh3AOvfFmEKv9QGv8a5U+5otjbcbCD5GVvlocKRhYy
         FAde0glMLS2FsKjT1AqdvumiB65UYcnoR495FHaEEubv04WSjut9y0f8EMBijAOcABXV
         V1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=udcroEQQ6Z6OCoUfUXDW3z8lPuS4P2Y882ZZnQE+47g=;
        b=YIj3IHlHHF0q4CII9qhCKwtNvKkqNw1X3qoGDMNPtxmgWsHl345sFRXFGeAVRrNzei
         DcfJvpyQ8gzDhuyXXAv22KYTX689NP1R72WpOUAbc8VW3pnfYvyEumGIrBE/jSZdAkUP
         wASM/GW854prdEA40dHgXs0uyuvqm/hQdkjiazHiJUH7S22Y6o4/CjVe5qphWLVgZpqQ
         Vfba2lVL8UeFmAwBMV8zxeEDjSJkdQY7cBDUYXnqqk5n2+tNeQ8ZHvlORTEcfVf23u4Y
         5E7EWGSB/hQheaMzmHFUjy1Hon+DAVPApKfGaXEQoYr5y+x5yu1vuEEpfCGKqEfbYgNt
         +JtQ==
X-Gm-Message-State: AKGB3mKtoloiIEBfuM1uDGJRejS4m2pxFWCYKNQpA7pdEi6Mf9ZCyd2G
        5z8VHGcX1TO6/MIuSs8KYbnBOl84
X-Google-Smtp-Source: ACJfBotHFbf8RDT+dIXuixEfCFdWqCgpiWi5UEiNYkjac7GrGYeorGGkn3kw4USXW39c5nIhXxSWZA==
X-Received: by 10.80.206.26 with SMTP id y26mr19283618edi.117.1513364298126;
        Fri, 15 Dec 2017 10:58:18 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id p37sm5912012eda.96.2017.12.15.10.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Dec 2017 10:58:17 -0800 (PST)
Subject: Re: Need help migrating workflow from svn to git.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20171214130933.GA18542@raven.inka.de>
 <xmqqvah8q7cg.fsf@gitster.mtv.corp.google.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <19d67f01-5e7d-3792-52f4-52da86bca5e5@gmail.com>
Date:   Fri, 15 Dec 2017 19:58:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqvah8q7cg.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/12/2017 17:33, Junio C Hamano wrote:
> 
>     $ git fetch <remote> <branch>
>     $ git checkout -m -B <master> FETCH_HEAD

... aaand that`s how you do it[1] without a temporary branch :)

Junio, what about consecutive runs, while merge conflicts are still 
unresolved?

Seeing Josef having a pretty relaxed flow, and his cron job running 
every 15 minutes, would adding something like:

    $ git add -u
    $ git reset

... to the mix, to "silence" actually still unresolved merge 
conflicts, making next script execution possible, make sense?

Yes, `git diff` won`t be the same as if conflicts were still in, but 
it might be worth it in this specific case, conflicting parts still 
easily visible between conflict markers.

Regards, Buga

[1] On 15/12/2017 19:24, Igor Djordjevic wrote:
> 
>     git checkout -b temp &&               #1
>     git fetch &&                          #2
>     git branch -f master origin/master && #3
>     git checkout -m master &&             #4
>     git add -u &&                         #5
>     git reset &&                          #6
>     git branch -d temp                    #7
> 
> Explanation:
>  1. Create temporary branch where we are, switching to it, so we can 
>     update "master" without local modifications
>  2. Fetch latest updates
>  3. Update "master" to fetched "origin/master"
>  4. Switch to updated "master", merging local modifications
>  5. Mark any pending merge conflicts as resolved by staging them...
>  6. ... and unstage them right away
>  7. Delete temporary branch
> 
> Step (4) is what merges your local modifications with remote updates 
> (leaving conflicts, if any), where steps (5) and (6) are not needed 
> for a single run, but in case you don`t resolve conflicts before next 
> cron job executes this script again, step (1) will now fail without 
> them because of (still) unresolved merge conflicts.
> 
> So, as you seem to be pretty at ease with your flow, you might prefer 
> leaving those two steps (5, 6) in.
