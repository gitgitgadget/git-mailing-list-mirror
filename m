Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2BFA20985
	for <e@80x24.org>; Thu, 15 Sep 2016 15:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbcIOP0Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 11:26:25 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35707 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbcIOP0X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 11:26:23 -0400
Received: by mail-qk0-f173.google.com with SMTP id t7so56994535qkh.2
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UMqh/oBxiAV5lCCkTIv4JngWWJTELrQ6lAfbOygfmbw=;
        b=TnMSlO0EcSKd016g/sozIkfmYwTKgsEJCxbSvuDtdjIQI8Q921BzdXQECHqY7nWges
         HaH/zav5LhMOFNLj08EIXAbs5ycfTGjuDV82Jecl5Nd30A8jK0aOzAZbR8db2u6D8fGI
         4p6Pp31tmzY1rpq0HNSXl77CbT0lDTO9yBNBixu7D9u1MQtKYbyp3NWOvVCt9sLxj1cQ
         jIGiJykVTuwkgKKlXCnJ+yfUmHmtHcWlWnxusaLZ2KJDEU5GWs1O58yeweap6JJn3JH3
         i75taF1Hr9YG/5JUG2FRFKr9T/rpClNlZQk/epmW85qsID5D89B+AUKRSmyTUQ9DdB4j
         HERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UMqh/oBxiAV5lCCkTIv4JngWWJTELrQ6lAfbOygfmbw=;
        b=MrTyjY57bXEHnFaWE5H+jmR/dt0ZNaAOcae+jFKtzTYX1nMvA68tx03+c/HfvC0x0H
         R/+7KKjM2ouRuq904g7kidUl6Tbzu1EeuuWYyHgvV9b8aMBI4QQ82wp77hE5z2TWI7Vq
         PNyNrXuXU1XAJtiMwBY38MFjIfLUjpDta9Qe2OG1FqsLQdNGHc+5MVRpNz5CtvjkUmbH
         Bz26iZzM8KnGi15wSnPOyF/+U15o9gEZKU+hGhePVUnevZot2H1J2+hsVCg09xgH9yFg
         WzdoAT+HiFyx/Wf9nKVwfC9w4Q3i+fv+xqWMxV5jJl31vj+c8GiAIu4N98PYp8G8zQoc
         32LA==
X-Gm-Message-State: AE9vXwM+xIVKiO8sHNy8o9tTdKLbw/j1KrjUHe9a3ldGgU7Vz7mIxnqZbNPaS4tISSwDEdNtJlqf5hplJFjpcVAW
X-Received: by 10.194.164.102 with SMTP id yp6mr8548730wjb.50.1473953182666;
 Thu, 15 Sep 2016 08:26:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.69.25 with HTTP; Thu, 15 Sep 2016 08:26:22 -0700 (PDT)
In-Reply-To: <20160915115752.GA37903@book.hvoigt.net>
References: <1473897473-154528-1-git-send-email-bmwill@google.com> <20160915115752.GA37903@book.hvoigt.net>
From:   Brandon Williams <bmwill@google.com>
Date:   Thu, 15 Sep 2016 08:26:22 -0700
Message-ID: <CAKoko1rtEydwbWoEq9MBW41qqa10Bm+x0d6zS+Bptk51RjMOMA@mail.gmail.com>
Subject: Re: [RFC] extending pathspec support to submodules
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Jens Lehmann <jens.lehmann@web.de>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2016 at 4:57 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>
> The problem when you do that is that the child is not aware that it is
> actually run as a submodule process. E.g.
>
>    git grep --recurse-submodules foobar -- sub/dir/a
>
> would report back matches in 'dir/a' instead of 'sub/dir/a'. From the
> users perspective this will be confusing since she started the grep in
> the superproject.
>
> So what I would suggest is that we make the childs aware of the fact
> that they are called from a superproject by passing a prefix when
> calling it. E.g. like this
>
>    git grep --submodule-prefix=sub foobar -- sub/dir/a
>
> Whether we pass the full or stripped path is now a matter of taste or
> ease of implementation, since we could either preprend or strip it in
> the child. But the important difference is that we have information
> about the original path.
>
> Another approach could, of course, be to omit passing the prefix and
> parse the output of the child and try to substitute, paths but that
> seems quite error prone to me.
>
> Cheers Heiko

You're right that seems like the best course of action and it already falls
inline with what I did with a first patch to ls-files to support submodules.
In that patch I did exactly as you suggest and pass in the prefix to the
submodule and make the child responsible for prepending the prefix to all of
its output.  This way we can simply pass through the whole pathspec (as apposed
to my original idea of stripping the prefix off the pathspec prior to passing
it to the child...which can get complicated with wild characters) to the
childprocess and when checking if a file matches the pathspec we can check if
the prefix + file path matches.

-Brandon
