Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC28B208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 23:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbeHGBaI (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 21:30:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36642 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733295AbeHGBaI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 21:30:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so7577838pfo.3
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 16:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=10rambT0U7A8kNgnYSCTz9cF0E0rv8sFUkL6icOCAKk=;
        b=s5a0eOfrHEulxj0y8RNjv1llvv2TBbJ299gOgY7BtDzj0XGdwCmWs2xoRRuEy332gj
         A1bF8VvaEMwRkOHB1zyh2IYQzcxwN5tR5V5B9okVPMQMHDlnvLiRPjfqC/7SajRqCfmF
         XVYpxLl4CCb/5PWpRRTbsz0wYAjFXuLvcK/Xt1rzcJjkIEBXXFgkKb+fdWouR2swuKAH
         dTgomBxNqM53C0m5Jj1bzAwZGGmrv2dlBb6rLy9iQE3/XR1IaBDz81sn5UWj3W5yAmyI
         tN6xVSuE4d6IqFhn/VjJ5co9+JPvbnSgDQ6GDn9qS4OEyKZzZICy6+0Zt8oh6fgFdGhw
         KVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=10rambT0U7A8kNgnYSCTz9cF0E0rv8sFUkL6icOCAKk=;
        b=omiDzdZ2v2y9USbVDxkCuuNi4Kggk+dVf+8hSMVel/hSxzTnxKqm2ZBJP0KUiTIXQt
         Ci5d0nyqZIyh822Lw1gnhTg22TsyX+ezic1pnGWEFyo3wlnO53ey38usQ1e5dwQBvgXh
         jjUo3HA1+VqZwBOlRYDuRMZDu/ZaInRjmIRh/pDDwJamwDBNlgGZOfOjAi9OMT6FzuWv
         lyG5N8lnDAmUd6T3LgxU6uWuxkNrctE/bTWr9tV79paoy9E8dfCm9Lo7ZpOAdt05PG4C
         /+91inb74KIPo+whzqaxj6gAf3u8IrFPEpMlV3ZQ/mjA/SZzlg+qcYsotN4IWGyxEzbU
         4s5Q==
X-Gm-Message-State: AOUpUlG5q6Wdoltd0Ftc6YmmHohnnZRNTaJxbAUzVriQvLMRWWitAAhP
        VUI2eJehhKi+VSloBU08uZMk0XKl
X-Google-Smtp-Source: AAOMgpd6mlRX/T0jlppONPn5h6S4ftxh3lz7NBblD7NBXN4k3yAOC4NVb3bCl/z5E4zaDlt4uc4rcg==
X-Received: by 2002:a63:3089:: with SMTP id w131-v6mr15957618pgw.79.1533597525956;
        Mon, 06 Aug 2018 16:18:45 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id q25-v6sm32117033pfk.96.2018.08.06.16.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 16:18:44 -0700 (PDT)
Date:   Mon, 6 Aug 2018 16:18:43 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/diff-options: explain different diff
 algorithms
Message-ID: <20180806231843.GA4117@aiede.svl.corp.google.com>
References: <20180724044051.GA208393@aiede.svl.corp.google.com>
 <20180806222551.132628-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806222551.132628-1-sbeller@google.com>
User-Agent: Mutt/+ (31e72e18) (2018-08-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -91,14 +91,18 @@ appearing as a deletion or addition in the output. It uses the "patience
>  diff" algorithm internally.
>  
>  --diff-algorithm={patience|minimal|histogram|myers}::
> -	Choose a diff algorithm. The variants are as follows:
> +	Choose a diff algorithm. See the discussion of DIFF ALGORITHMS
> +ifndef::git-diff[]
> +	in linkgit:git-diff[1]
> +endif::git-diff[]
> +	. The variants are as follows:

This means outside of git-diff(1), I'd see

	See the discussion of DIFF ALGORITHMS in git-diff(1) .

And in git-diff(1), I'd see

	See the discussion of DIFF ALGORITHMS .

Both don't seem quite right, since they have an extra space before the
period.  The git-diff(1) seems especially not quite right --- does it
intend to say something like "See the DIFF ALGORITHMS section for more
discussion"?

[...]
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -119,6 +119,40 @@ include::diff-options.txt[]
>  
>  include::diff-format.txt[]
>  
> +DIFF ALGORITHMS
> +---------------

Please add some introductory words about what the headings refer to.

> +`Myers`
> +
> +A diff as produced by the basic greedy algorithm described in
> +link:http://www.xmailserver.org/diff2.pdf[An O(ND) Difference Algorithm and its Variations].
> +with a run time of O(M + N + D^2). It employs a heuristic to allow for
> +a faster diff at the small cost of diff size.
> +The `minimal` algorithm has that heuristic turned off.
> +
> +`Patience`
> +
> +This algorithm by Bram Cohen matches the longest common subsequence
> +of unique lines on both sides, recursively. It obtained its name by
> +the way the longest subsequence is found, as that is a byproduct of
> +the patience sorting algorithm. If there are no unique lines left
> +it falls back to `myers`. Empirically this algorithm produces
> +a more readable output for code, but it does not garantuee

nit: s/garantuee/guarantee/

> +the shortest output.

Trivia: the `minimal` variant of Myers doesn't guarantee shortest
output, either: what it minimizes is the number of lines marked as
added or removed.  If you want to minimize context lines too, then
that would be a new variant. ;-)

[...]
> +`Histogram`
> +
> +This algorithm finds the longest common substring and recursively
> +diffs the content before and after the longest common substring.

optional: may be worth a short aside in the text about the distinction
between LCS and LCS. ;-)

It would be especially useful here, since the alphabet used in these
strings is *lines* instead of characters, so the first-time reader
could probably use some help in building their intuition.

> +If there are no common substrings left, fallback to `myers`.

nit: fallback is the noun, fall back is the verb.

> +This is often the fastest, but in corner cases (when there are
> +many common substrings of the same length) it produces bad

Can you clarify what "bad" means?  E.g. would "unexpected", or "poorly
aligned", match what you mean?

> +results as seen in:
> +
> +	seq 1 100 >one
> +	echo 99 > two
> +	seq 1 2 98 >>two
> +	git diff --no-index --histogram one two
> +
>  EXAMPLES
>  --------

Thanks,
Jonathan
