Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 888401F453
	for <e@80x24.org>; Fri, 15 Feb 2019 06:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfBOGkR (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 01:40:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46511 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfBOGkR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 01:40:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so4315978pgp.13
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 22:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=6oq/Jl2lNXEs3Iig5ILy5WzLTWcMYK4QADpGgLOfG+8=;
        b=l5mV1lXH6/hzQ/qgBQI99ZtBfOBFXJ3aMNKt5C0unyW/X52c082KtU8DItEn/VJvR+
         CzBJKN/VbeE0oUeURiT+dX5wZCaCA3NNveYu58bX+c5nDLwC48+JrSYZtim4RENkh+cH
         8gq00qudRKFuXsKkhSWhtRzrgtURdbi+kMT9q8ZXtTqBGKmD0hHhZbk3SUMoLjv56AsD
         aPRAQ33H4/zUH0/WQUXj+BiqADtPmTHDi8/PT3uUlG+dFG0dIrpJSphFqFBxiAEyc+5Z
         Femua72dlfO16L1Jj7azuDYg+GTzE/mDhz/n8tBz/CxN+HXWY4K4ByhWIIR9rbVqfnhr
         qWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6oq/Jl2lNXEs3Iig5ILy5WzLTWcMYK4QADpGgLOfG+8=;
        b=QH5Qr2l+zxjJ0liKnf4a/y7ceGJQNdiEitryc95SUFW8TmyEgGFVMlxaATdShlE+WE
         Ay2sKxnKh3hQ9uGqP7QyTCR5Qzyyg4HcZeiGW/G8Ffut6Lk24UostXH0kRwUJekZHwbg
         4Eh7tCdu5GyvcT2GUf2RLzC4BkU9OZow1XjAEHxDFnPLidGt50yd8IXXTFDe+vHw9I6H
         X6Razy0NHd43W4og7beHE1uBvKkZZhV2kmxunn+Qe5/HgSubsLlu3O8gryE0oynkITXH
         EI9RBrkRUvKdKi3I1ELGPWH3hBcuUnebhGT6sjc6SIcibWCroN6t2CtuwckARNVlg6D/
         YVzQ==
X-Gm-Message-State: AHQUAuZ4h+32gjwuJdutEQ8oiT11SbxTBKdueEMZzNcXC03M+1eO562L
        yES0y6Qgnm8SBZ0MjhS61drdFA==
X-Google-Smtp-Source: AHgI3IbX9Z3PINApdGAS2u8pQKaLXpjK5Ao3DhlYGcP5PS/Df4oZueXsLkLrfn/4TdG0CryymlQewg==
X-Received: by 2002:a65:620a:: with SMTP id d10mr3835375pgv.75.1550212816384;
        Thu, 14 Feb 2019 22:40:16 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id y133sm1999331pfb.107.2019.02.14.22.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 22:40:15 -0800 (PST)
Date:   Fri, 15 Feb 2019 12:10:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Elijah Newren <newren@gmail.com>, gitster@pobox.com
Cc:     Git Mailing List <git@vger.kernel.org>, j6t@kdbg.org,
        vincent.guittot@linaro.org
Subject: Re: [Bug report] git diff stat shows unrelated diff
Message-ID: <20190215064013.s7yfkmfvfmwfmepc@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BGstumw1eyZ++0itk-AR0Bk5zd0AchgznBpMq35a6ScUg@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14-02-19, 13:23, Elijah Newren wrote:
> I think you're getting tripped up by double-dot vs triple-dot with
> diff being different than log:
> 
> `git diff D..E` means the same thing as `git diff D E`, i.e. diff the
> two commits D and E.

Right, so both the branches have at least until rc2 (though
pm/linux-next had until rc6), why will the diff D..E show the diff
between rc1 and rc2 ?

> `git diff D...E` means the same thing as `git diff $(git merge-base D E) E`

I get exactly the same result with both .. and ... in this particular
case and that's why I wonder if everything is okay or not.

The problem in this case is:
- PM tree had rc1,2,3,4,5,6 merged earlier into it.
- Then I got merged one of my branches which was based of rc1 into
  pm/linux-next.
- And now I am trying to send pull request for another branch which is
  a merge of the earlier branch (which got merged, based of rc1) and
  second branch that has more stuff over rc2.
- The most recent merge commit common between my branch and
  pm/linux-next becomes the earlier branch which was based of rc1.
- Now I expect ... to return the diff between rc1 and rc2 as it will
  diff against the most recent merge.
- But I expected ... to not include rc1..rc2 diff.

> There are some people for whom this state of affairs makes sense.  I
> am not one of them, and I suspect you aren't either.  The arguments
> made by those who feel this makes sense seem reasonable to me in the
> moment when they present them, but I have never been able to remember
> these arguments longer than briefly.  It just doesn't stick with me.
> The only thing I seem to be able to retain is the following:  "git
> diff D..E is totally useless and should be an error because (1) it
> doesn't do what I expect and (2) for folks that want the behavior
> currently gotten with that syntax can instead just use a space instead
> of a double dot."

Okay but git request-pull uses .. and not ... and that's where I saw
the issue in the first place.

-- 
viresh
