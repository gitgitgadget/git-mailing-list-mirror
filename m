Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30BB1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 12:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfF1Mfb (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 08:35:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38070 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfF1Mfb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 08:35:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so6020133qtl.5
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+O+94vG/g04/4i8z6JoTqZZOTjEEexOXzPZEZILl8zU=;
        b=vXKHr3aczJaGVl87CNv/4agF/aHdWpc8Sfm1eg6n8oQXjrxSvMKfivu6TCiJf/Xbzs
         TGP8HloLKpOhFUc9SubmvNALAox397atLTQCPRvTWJmVu1523PyjXnCVVCJDXMU+Kbyy
         bvinJuU2oWRgu/GakNvexec6kRcHgod95YztbZJB1JQteuotc2ifKkFtcTS+KtUZVEiO
         oqKIptB2iICLgEroy8TeTdSaw8KilltOP+bu/FkbAGg2qCUOxaLECh2o3uldIA9nsWgE
         /Y46cTRF+ez5uNSdsdXC4hmnZ2SK3LQwuOSUwwIxprrbWEgXk/e8/x/WUNJDRQ6342Il
         EjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+O+94vG/g04/4i8z6JoTqZZOTjEEexOXzPZEZILl8zU=;
        b=XuNSXPkwbuuLEDFV5E01YUwNNrprh8I3YY8M3cag1ivSR8xaji0aKQvfMtbcn+wFZz
         AM6t2abPtx6artMq00D1/Ue2M5mAj71E97+5BfbYdUxz0bvmrWK1avhKdpXyVSd1tn5a
         BeAQ6lcUYtt1qtDuHyu4RxpJ4Ypmu2MqFP0GraoSId076n7Qa9wcMmQb/Y5/GsLQQ3Qp
         iF7IiIKXhgUgE/e7JEH/1RWU+1SuIgAV5gw7Qth5ZbXiaD6mY21ow90jwya/Jlv3EwqA
         dF8IpvbRkMC9iv3LCqfNItRGxfRSbx+bP2JEmWZdBoVvGUB+t+zFayd40iw1575uk4WC
         Z7gw==
X-Gm-Message-State: APjAAAWkFGWEiNUIUt+7eZLplvXPnlOLxVKijN3KA+Xk5rHccW29UJHW
        fLTcNuDrV6f48ymqhQaVhcq81ctF
X-Google-Smtp-Source: APXvYqzJ+D4WyDDoqyzFPFGMvYQdmDkNO1QKhzbk8NnIc8t64sZUNX4kYL8d+1nAvWoN8WggdwV+6Q==
X-Received: by 2002:aed:3e1d:: with SMTP id l29mr7866556qtf.175.1561725329739;
        Fri, 28 Jun 2019 05:35:29 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:54b1:2872:57:b107? ([2001:4898:a800:1010:5e7:2872:57:b107])
        by smtp.gmail.com with ESMTPSA id m44sm956907qtm.54.2019.06.28.05.35.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 05:35:29 -0700 (PDT)
Subject: Re: [PATCH 1/6] test-lib: introduce test_commit_bulk
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <20190628093751.GA3569@sigill.intra.peff.net>
 <20190628093911.GA27329@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2d4410a9-fd3e-8b9f-00b5-f8eba4d51b42@gmail.com>
Date:   Fri, 28 Jun 2019 08:35:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190628093911.GA27329@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2019 5:39 AM, Jeff King wrote:
> Some tests need to create a string of commits. Doing this with
> test_commit is very heavy-weight, as it needs at least one process per
> commit (and in fact, uses several).
> 
> For bulk creation, we can do much better by using fast-import, but it's
> often a pain to generate the input. Let's provide a helper to do so.

What a quick turnaround! I'm happy to nerd-snipe you here, and am glad
the result was so positive.

> We'll use t5310 as a guinea pig, as it has three 10-commit loops. Here
> are hyperfine results before and after:
> 
>   [before]
>   Benchmark #1: ./t5310-pack-bitmaps.sh --root=/var/ram/git-tests
>     Time (mean ± σ):      2.846 s ±  0.305 s    [User: 3.042 s, System: 0.919 s]
>     Range (min … max):    2.250 s …  3.210 s    10 runs
> 
>   [after]
>   Benchmark #1: ./t5310-pack-bitmaps.sh --root=/var/ram/git-tests
>     Time (mean ± σ):      2.210 s ±  0.174 s    [User: 2.570 s, System: 0.604 s]
>     Range (min … max):    1.999 s …  2.590 s    10 runs

I ran these tests on my Windows machine, where the process startup time is
a higher cost. The improvement is noticeable from just watching the test lines
pause on the steps creating the commits.

 Before: 30.8-31.2s
  After: 23.5-23.8s

> So we're over 20% faster, while making the callers slightly shorter.

I see about the same relative measurement (~23%). The callers are a bit
cleaner, which is good. They are also slightly less clear of what's
happening, but that's the cost of abstraction. Definitely worth it in
this case!
 
> +# Similar to test_commit, but efficiently create <nr> commits, each with a
> +# unique number $n (from 1 to <nr> by default) in the commit message.
> +#
> +# Usage: test_commit_bulk [options] <nr>
> +#   -C <dir>:
> +#	Run all git commands in directory <dir>
> +#   --ref=<n>:
> +#	ref on which to create commits (default: HEAD)
> +#   --start=<n>:
> +#	number commit messages from <n> (default: 1)
> +#   --message=<msg>:
> +#	use <msg> as the commit mesasge (default: "commit $n")
> +#   --filename=<fn>:
> +#	modify <fn> in each commit (default: $n.t)
> +#   --contents=<string>:
> +#	place <string> in each file (default: "content $n")
> +#   --id=<string>:
> +#	shorthand to use <string> and $n in message, filename, and contents
> +#
> +# The message, filename, and contents strings are evaluated by the shell inside
> +# double-quotes, with $n set to the current commit number. So you can do:
> +#
> +#   test_commit_bulk --filename=file --contents='modification $n'
> +#
> +# to have every commit touch the same file, but with unique content. Spaces are
> +# OK, but you must escape any metacharacters (like backslashes or
> +# double-quotes) you do not want expanded.
> +#

I appreciate all the documentation here!

> +		while test "$total" -gt 0
> +		do
> +			echo "commit $ref" &&
> +			printf 'author %s <%s> %s\n' \
> +				"$GIT_AUTHOR_NAME" \
> +				"$GIT_AUTHOR_EMAIL" \
> +				"$cur_time -0700" &&
> +			printf 'committer %s <%s> %s\n' \
> +				"$GIT_COMMITTER_NAME" \
> +				"$GIT_COMMITTER_EMAIL" \
> +				"$cur_time -0700" &&
> +			echo "data <<EOF" &&
> +			eval "echo \"$message\"" &&
> +			echo "EOF" &&
> +			eval "echo \"M 644 inline $filename\"" &&
> +			echo "data <<EOF" &&
> +			eval "echo \"$contents\"" &&
> +			echo "EOF" &&
> +			echo &&
> +			n=$((n + 1)) &&
> +			cur_time=$((cur_time + 1)) &&
> +			total=$((total - 1)) ||
> +			echo "poison fast-import stream"
> +		done

I am not very good at the nitty-gritty details of our scripts, but
looking at this I wonder if there is a cleaner and possibly faster
way to do this loop. The top thing on my mind are the 'eval "echo X"'
lines. If they start processes, then we can improve the performance.
If not, then it may not be worth it.

In wonder if instead we could create some format string outside the
loop and then pass the values that change between iterations into
that format string.

Thanks,
-Stolee

