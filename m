Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA1E1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 19:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbdBMTZH (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 14:25:07 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34846 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdBMTZG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 14:25:06 -0500
Received: by mail-ot0-f195.google.com with SMTP id 65so13125218otq.2
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 11:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LjCNP4DnKJYsirwNaz96IF5gPgGhCWqhvC429i4CizA=;
        b=cEb5B1fdrq8a+XZsy1cOQte4jQZRkACinPse+X+EV7W31YELo7/4g3xzaeFzBqrdbI
         2m7SARMEcljgOMvj+jEmMy1iE9qCgN3EkX8Ry5YBvAliJjUiRKHUxycdjQwNqz8Q/mtK
         oqxqLUoyLoTvmo4o4cUC7+0Ua/a1Q3X5L06766qdQHk9ns3wHDf4savu9jZEk3CmoY8Y
         HjJsc01D4P5HeeqOUIzziaTCTy0Lolhr0z5mK7NNTah4lFB54nY/HkliJ2biYjK3IexX
         XncTU6Hjv+USX+We+jBbCWvBPjUOKeG6BKW+ESOikLBV5I+JWuVI96z5FX8LIVM06NEv
         34FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LjCNP4DnKJYsirwNaz96IF5gPgGhCWqhvC429i4CizA=;
        b=XEou6co3UAnN3yC7DyE/XvxYge2HtCrU2hACTVXtBkF+c+WrdYCVK3kV4W1Lbt7GyS
         jpS/Ldy3m4ICJJsSjaMBsYs6Gp6Ill21zs0Bvhmg3kdcXd8PWLNMHSam1mS36lyQWOJ0
         G97sMGmrAkCLCxBg6GM0lARG1u5VaLlTAgt+PDDMx0A7S3G6IAk9Po84pdNe3HDtWnOA
         DHdKmonGRKT/0PIa3OCYuWvgKtwiit+3yWBrjzjGbDhbtqWYdX1KV3whh/De19yHWz6/
         pPnT1WKYmSc8edjiKOtdi5Ite0a6Y8JE6dS0qmdbHiQLSBcxwP+zsvmgN+hq00lfAJp4
         lktg==
X-Gm-Message-State: AMke39kLaMgBXduwTosimJRJx7dewCLJLHU4VxA6nvwZ1DiaCHkbKQBgQcb8QqiLN2huYQ==
X-Received: by 10.98.210.3 with SMTP id c3mr27578033pfg.7.1487013905442;
        Mon, 13 Feb 2017 11:25:05 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id w76sm22407522pfd.74.2017.02.13.11.25.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 11:25:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     hIpPy <hippy2981@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Incorrect pipe for git log graph when using --name-status option
References: <CAM_JFCwYAKCWrHqCtcwid27V1HvhuSmp4QpbNpgyMzrzWUNYog@mail.gmail.com>
Date:   Mon, 13 Feb 2017 11:25:03 -0800
In-Reply-To: <CAM_JFCwYAKCWrHqCtcwid27V1HvhuSmp4QpbNpgyMzrzWUNYog@mail.gmail.com>
        (hIpPy's message of "Sun, 12 Feb 2017 18:49:23 -0800")
Message-ID: <xmqqa89pevw0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hIpPy <hippy2981@gmail.com> writes:

> The `git log` command with `graph` and pretty format works correctly
> as expected.
>
> $ git log --graph --pretty=format:'%h' -2
> * 714a14e
> * 87dce5f
>
>
> However, with `--name-status` option added, there is a pipe
> incorrectly placed after the commit hash (example below).
>
> $ git log --graph --pretty=format:'%h' -2 --name-status
> * 714a14e|
> | M README.md

Is it a --name-status, or is it your own custom format, that is
causing the above issue?

 - What happens if you stop using --pretty=format:%h and replace it
   with something like --oneline?

 - What happens if you keep using --pretty=format:%h but replace
   --name-status with something else, e.g. --raw or --stat?

