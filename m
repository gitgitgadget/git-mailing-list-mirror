Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 527C5202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 18:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbdGMSJo (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 14:09:44 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35356 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751218AbdGMSJn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 14:09:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id q85so8031178pfq.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ITCWFyh3IN1XsfUktABBnNWEtLl/u5lZtyPO7e2nh1w=;
        b=g+lr5x7lh8F6MUKYB/4AUHEWJvdTK9ZQzuAPvberzEDmbW6GBHdfff9Li0/7mVULGS
         9uvtNVQ0fGmfcXtEnrQSYo5zC197X2WV3FY4zw4RprVOz8xBaC+sOuTnIQXUSkA9uLU+
         zAniy+WXmOaUNX4MZkzYeCuipekOW3trvn+4lI4+KUOH+pW96Gi1QHlQEAhxqx9p+c/t
         PyHm7/87fbkzPvdGoyu24Z4W+c8Pw8Ey8+xo6Qdu9psLWk2kGSrxSFF4XpI5m+8bEGqm
         JNiN5z0l/MtQFjTgfRDY5SfaZSYxZiWnZJ+snLDUjOjEHm4ZvuNFc2L5ZxrfqaXl1PzS
         FHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ITCWFyh3IN1XsfUktABBnNWEtLl/u5lZtyPO7e2nh1w=;
        b=nzfIkSIYCKAgifvwzi5oMLlo7e3xvco9v1mgcP8Qt8SpBMgM+hYUMrz9G5Cn5jBkDn
         xlVE6AkzFM8LBZXKtpIY3H+jlX1dKTsHLI/HIy/o0+BU8QA4OePQy9CFabPbVdLO3jtw
         kkhIftF/6BEjFmvMGEmYkRkHb819xwnEVo4Oamvk/162qyhSF34bv7NtMTwUNagejLB6
         zZIIBa98gHDWMX02DTByNeTs8opP8g8yKTog4mvcpHLJxdWs2zetKCtosDD77nISym4f
         bWM/Siu0HltItvKWztxjhWR5CT/JyD4BzurZzdurPI200hQfdUg5lnwM4HYCxUjMc3Gx
         LljA==
X-Gm-Message-State: AIVw112+ySbYdlbQ1IONefBNGxbnG749ZWclH6wOCYez86o6DfaBYW/M
        IBpvv4hM0EmoexzuU4c=
X-Received: by 10.101.86.8 with SMTP id l8mr10432324pgs.271.1499969382037;
        Thu, 13 Jul 2017 11:09:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id h123sm10655714pgc.36.2017.07.13.11.09.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 11:09:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nikolay Shustov <nikolay.shustov@gmail.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: "groups of files" in Git?
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
        <B5FDF25C-ED5A-4CD1-AAD7-04BD8D705C59@gmail.com>
        <6e4096fd-cbab-68f0-7a23-654382cb810e@gmail.com>
        <CAEcERAxRmRh5pp=nXN7X9u=HQsJdSQfsXoedM_5eCDgDWwAkKg@mail.gmail.com>
Date:   Thu, 13 Jul 2017 11:09:40 -0700
In-Reply-To: <CAEcERAxRmRh5pp=nXN7X9u=HQsJdSQfsXoedM_5eCDgDWwAkKg@mail.gmail.com>
        (Nikolay Shustov's message of "Thu, 13 Jul 2017 11:37:20 -0400")
Message-ID: <xmqqmv88xl7f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nikolay Shustov <nikolay.shustov@gmail.com> writes:

> Thank you for the detailed explanation, it looks like merging the
> commits would be helpful in my case. And I think it is a very good
> analogy that Perforce changelists are like multiple pending committs,
> if Git were supporting such.
>
> What it won't be achieving by using commits in this schema is the
> following thing I can do in Perforce:
> In the uncommitted Perforce changelists I can revert the changed file
> to the original state and move the files between the changelists.
> Quite often, while working on something, in the middle I would decide
> to isolate changes to a certain set of files to a separate changelsit
> - but then I might change my mind. It is all flexible until I actually
> commit my Perforce changelist, after which it becomes very much as
> committed changes in any other source control.
> This is actual flexibility I am looking for achieving in Git.

I actually think we already have such a flexibility.  Unlike
Perforce, Git is distributed, and the most important aspect of the
distinction is that what happens _in_ your local Git repository may
be called "committed" in Git lingo, but not visible to the public.

You can consider these commits you make in your repository "pending"
when you think of your workflow in Perforce terms, until you merge
and push out the result, which roughly corresponds to "submitting"
in Perforce lingo.

Once you start treating your local commits that you haven't pushed
out as changes that are still "pending" when observed from the
outside world, you'd realize that you have as much flexibilty, if
not more, to dice and slice them with the local tools like "rebase
-i", "add -p", etc., as you would have in your Perforce workflow,
I would think.


