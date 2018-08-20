Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F5BC1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 17:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeHTUnc (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 16:43:32 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:52039 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeHTUnc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 16:43:32 -0400
Received: by mail-wm0-f48.google.com with SMTP id y2-v6so305266wma.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 10:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xV4muMDyB2rurVlATEO/XWiLo+7hc3ZwlYDa1vIGEsc=;
        b=SJ+YHigcprIUqcLE09jZkh/D1D9UhbJVpUIzczeielo+F1NRIiznYzF8Y9HyBrClMN
         bs13MuAkeXRqu3kWO6gtxNjH6Nc8r73nm/VB4g2O/LcrHNJ5vN2CXIZDVabvnNE4ZJqx
         ub5ofDEo0snnPrRW4bpnBYtWXFIf3yoo7QaibQhoz8/QL0c5yQLCT1xovynlSrbCVEBf
         N410Lvl20Sc0yUm+z33kURGsBr3BLM3hr+08kSbAp+9iV7Zkh6N6k8l5Dd9dKROA2wIN
         lJ7Vfc/kgXr/lxBVxjLY1hEzl1PwDpWo+I+0cidQqhNfGeW5yc5Fv1p6H50N5wBQxM1i
         279w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xV4muMDyB2rurVlATEO/XWiLo+7hc3ZwlYDa1vIGEsc=;
        b=sYgTdEcSUYQd8X6HzsyfZcac7VI9tdsGZ6fE+O3iEtwhK0pnWZQWT2ZQwMlMHyF/Fo
         vakPAf4YmBhaRlfS8/B6+97dKQyPV7UcNnLGHMCOEglHhAMy4xKITv8gpVEvz+nibrZk
         v08qnIGJwyUir6DAz+hwS+ZEWUN1CChGpdwMdyAZxQRNde6AtItqrI8P4lJRdj77C8NW
         dwgwUxI9I0v5twJ1PiU2LsQhw1ZLPTV4D2iK5hSdaJbHfPqEDwzUP7EaadNjqNJZpBam
         mcShCrBqy+fKSyN0aIZ572h9yj7VJyIVPabbxguU5n6VgJ+Ng5NPRICZJofMG7wlAzg5
         opcQ==
X-Gm-Message-State: AOUpUlG6ZzCrREa/xxRU6cHGK9IJ1/LVHCbnL8wVCkdKwsNiLRRjEVRn
        Y4f8IJzSyhi9nbCa0ZG7vD0=
X-Google-Smtp-Source: AA+uWPzU++epvKVXNihLdB7LAzXkLxmy3fQtZ7A9Cre9EE8//hcO0meFXhzJT4p5NDY0IGr9NknTcw==
X-Received: by 2002:a1c:c3c6:: with SMTP id t189-v6mr24717472wmf.59.1534786019384;
        Mon, 20 Aug 2018 10:26:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v124-v6sm196992wma.18.2018.08.20.10.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 10:26:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2018, #04; Fri, 17)
References: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
        <20180818065953.GE241538@aiede.svl.corp.google.com>
Date:   Mon, 20 Aug 2018 10:26:58 -0700
In-Reply-To: <20180818065953.GE241538@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Fri, 17 Aug 2018 23:59:53 -0700")
Message-ID: <xmqqlg91aqzh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> Usually, I refrain from merging larger topics in 'next' down to
>> 'master' when we get close to -rc0, but I am wondering if it is
>> better to merge all of them to 'master', even the ones on the larger
>> and possibly undercooked side, expecting that we collectively spend
>> effort on hunting and fixing bugs in them during the pre-release
>> freeze period.  If we were to go that route, I'd want everybody's
>> buy-in and I'll promise to ignore any shiny new toys that appear on
>> list that are not regression fixes to topics merged to 'master'
>> since the end of the previous cycle to make sure people are not
>> distracted.
>
> Based on what I see in 'next' (midx, range-diff, etc), I quite like
> this idea.

The comment above was about the ones that was marked as "Will merge
to 'master'" that are in 'next', not the ones marked as "Will cook
in 'next'", like the midx ones.  

I am not worried about range-diff, as I do not think it came close
enough to the core-ish code to break other things; the potential
damage is fairly isolated and the worst would be that we'd realize
that we shipped with a new command that was buggy after the release,
which is not the end of the world.  'midx' and 'reachable' are quite
different stories, as bugs in them would in the worst case lead to
an immediate and unrecoverable repository corruption.

So I am still on the fence, even though I am leaning toward merging
them down to 'master'.
