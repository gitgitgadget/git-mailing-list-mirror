Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5830B202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 15:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbdKTPVI (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 10:21:08 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:43126 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbdKTPVH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 10:21:07 -0500
Received: by mail-pg0-f51.google.com with SMTP id r12so7603300pgu.10
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 07:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+PP8zXY1N2JaSJRnARwj9q0HZoReB9aPEy5cmDo0bx4=;
        b=PoMlMod07yv2/eqxIH2kdEnQAiHq3mHO7/9l1k5K1Q066XqyutOflE8fddB9DIvZ78
         SmhszJeHXpgISjK3eM7Z8Qhq9+KPMum31xCZv6zzFpTAy5MuzsNFoVu/If6vb+MwHJ8y
         FUdjO8x0Z4T7frfc6MjLJnoVenc+KG0/LBYGLG/miIZaM41uDm3c22dcgqBFGU4aJG/f
         GVOBXQ0Ozb7pVXI7CY0imYDhwku8jkM54w4fOb+2ibtMelHCNl2hYY13hYVqMVKdkeMU
         kF104bIAsyCJVBh04fc0yFsZvquSkcM6IRUtZoWOsYAc7Vqnj1XANjOSbOpb2fOfvhFK
         EytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+PP8zXY1N2JaSJRnARwj9q0HZoReB9aPEy5cmDo0bx4=;
        b=gIlVMgzT1ZN0e2YqeqxEjLTxwECvkGU86GlJleBGHNTQbSuLTTGJUyNXMPGW4knqed
         4e/YJkAA07MJh6S5P2yCdkbU4sAUi/vth+tMfD0USLWYBSqfb8p4h2V+VxFAXuxc7lyU
         Cx+/qZCHR4e4m6Q9FBkoNDreJormvF0S8uBy46nuOvaVwcNbwSBYsMECDerklXPaJbVU
         oWaWxfTULSOkDp7kUIP1hzHWDGHUlM67UMyGAU4mZTdE71WebbDojOuTvJHeobratQJC
         S6fwPN714aYqq+I9s55KXfsiqFl2jkyh9FYHCOz2raWuvIFUeiJF/p/QLN9ybu6AjHT7
         ThIg==
X-Gm-Message-State: AJaThX5780s+6ehOU+nlcxfblE7lntH0nWCkTKlIRC+qtLdm60N367FS
        NCqXhSVzFfYk1qFCMKP5l1jDdoU/
X-Google-Smtp-Source: AGs4zMaXauuht6vcI9ZcpKsTYgLC8f5bNj7HAYFc8e5C2I1t2LQexwfgfhUIk3wCmD7XzWlBN/nsoA==
X-Received: by 10.98.87.13 with SMTP id l13mr11922785pfb.193.1511191266350;
        Mon, 20 Nov 2017 07:21:06 -0800 (PST)
Received: from [192.168.43.71] ([157.50.8.247])
        by smtp.gmail.com with ESMTPSA id t4sm18064088pfd.110.2017.11.20.07.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 07:21:05 -0800 (PST)
Subject: Re: [PATCH] docs: checking out using @{-N} can lead to detached state
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <20171119175411.13570-1-kaartic.sivaraam@gmail.com>
 <xmqqpo8dn1jd.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <52a6a1e5-c444-0bad-2558-e326ae170a3c@gmail.com>
Date:   Mon, 20 Nov 2017 20:48:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqpo8dn1jd.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 20 November 2017 07:39 AM, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
> After the first paragraph explains what happens during "checkout
> <branch>" and goes from the normal case where <branch> is really a
> branch name to an arbitrary commit (where "detaching" needs to be
> mentioned), a commit before 75d6e552a added mention of @{-N} and
> made it appear as if it were a reference to a commit (i.e. not a
> branch name) and that was why it said "As a special case" and
> mentioned "detaching".  The problem lies in a lot older one,
> 696acf45 ("checkout: implement "-" abbreviation, add docs and
> tests", 2009-01-17).
> 

Thanks for the analysis. Just to be sure, I referred to 75d6e552a just 
to back up my claim, was that intention clear in my log message? Also, 
should I mention the old commit (696acf45) also in the log message?


> 
> So perhaps we should start from dropping that "As a special case".
> 
>      You can also use the `"@{-N}"` syntax to refer to the thing the N-th
>      last "git checkout" operation checked out; if it was a branch, that
>      branch is checked out, and otherwise the HEAD is detached at the
>      commit.  You may also specify `-` which is synonymous to `"@{-1}"`.
> 
> or something like that.  If we do so, we'd further need to tweak "As
> a further special case", as this rewrite makes it clear that "@{-N}"
> is not a special case at all (instead it is merely a different way
> to spell <branch> or <commit> that is already covered).

Good point. I did use your rewritten message but with some modification,

     You can also use the `@{-N}` syntax to refer to the N-th last
     branch/commit checked out using "git checkout" operation. You may
     also specify `-` which is synonymous to `@{-1}`.

I tweaked the first part of the first sentence and dropped the last part 
of it just to avoid redundancy with the paragraph above it. Hope that 
sounds good. If it seems to need some modification, let me know.


Thanks,
Kaartic
