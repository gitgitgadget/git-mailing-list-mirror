Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B4A207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 22:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035925AbdD1WOQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 18:14:16 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32981 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164243AbdD1WNh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 18:13:37 -0400
Received: by mail-pg0-f46.google.com with SMTP id y4so15594119pge.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9TzyEgWnmEqRbFQhHA70E6b2uzhDE9hQ3aQnQVwsQCU=;
        b=HI1YaUmn8zG8dQsBVoCW+wJypYLed8rXiT2pJB+DthLu/zW982iOfgv9IbCEzB6aqJ
         6YdmlEtOgwLE1ybz/mqyqCQcIiQpUiaFrBF5KvJRGv2Nk5vwipZVf0HSlikh3Uc4cTJ/
         lgnC2DgUWDoZGCRwmiQ+6vU4qdbM5UUScZwLwN+OKnfqsIUgn9+h1KmJL5TpR5/gSVOz
         hVpfoLhUMdpRnl0b0Jmx+lhSqLtHiEjYKdJslrqRMrO3JCEysPN9zilA8GY+B6rqoGyG
         Enpjur2QgMVXf25ouqFtN6WtQqKHX23cS0l5EPbTgCWezjFYeMdZYL4zloJNqSd3uVCz
         WF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9TzyEgWnmEqRbFQhHA70E6b2uzhDE9hQ3aQnQVwsQCU=;
        b=ngLJnqMl6LvyorV1XkKfun64+YfrKTTeJOKjmDvk9/AG2NdaAV52tfBJgjqCILYlN2
         M4kvzEI/bN7JpzGQe/6uFbT9I6mzDr2MuI8nes8uySU+05692WniUnGD7ohIfm3tGdjU
         J3cYPwo5GFqcZIAtXRQVI14ogLpP6pXqCwjTjKjE706j71mtzRGqqA7jycwS2JtPFEFx
         UCTaQNwf2MtexYbHDF7W2DtNGwskNWpteQMNs20MkwmCC3DJHkCTXkWpiEUFsz9jgRNb
         ZTB0X2+/jhfxLzA3z1zfnL/w3Av0xUANcU+OAtOyHU6LYzN6ti8c/QupCwYQl8m+F4Lc
         KCCw==
X-Gm-Message-State: AN3rC/6UdNKiPyb5YslAF6TYEFLPaB4aFbmgvzM0vIwUBpps77ZPXswX
        kFPFEwDobCbZL1tbY4+zBvG5K13rQ6GKs2g=
X-Received: by 10.99.107.198 with SMTP id g189mr14230764pgc.162.1493417616852;
 Fri, 28 Apr 2017 15:13:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Fri, 28 Apr 2017 15:13:36 -0700 (PDT)
In-Reply-To: <20170428220450.olqitnuwhrxzg3pv@sigill.intra.peff.net>
References: <19607a03-71e0-440b-7213-64d25f6fa8da@xiplink.com>
 <20170427205037.1787-1-marcnarc@xiplink.com> <CAGZ79kbUqVfz+6Y0XkTL7FCZfaD+2YRMZ_v0vP8-DOFhWc+ELw@mail.gmail.com>
 <20170428220450.olqitnuwhrxzg3pv@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 28 Apr 2017 15:13:36 -0700
Message-ID: <CAGZ79kZsddmxmMFbD7NQXw=j56WKgaFaz90_zC4Lm++9Lj887w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Make diff plumbing commands respect the indentHeuristic.
To:     Jeff King <peff@peff.net>
Cc:     Marc Branchaud <marcnarc@xiplink.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 3:04 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 28, 2017 at 10:34:15AM -0700, Stefan Beller wrote:
>
>> > So instead I chose to make the indentHeuristic option part of diff's basic
>> > configuration, and in each of the diff plumbing commands I moved the call to
>> > git_config() before the call to init_revisions().
>> [...]
>>
>> The feature was included in v2.11 (released 2016-11-29) and we got no
>> negative feedback. Quite the opposite, all feedback we got, was positive.
>> This could be explained by having the feature as an experimental feature
>> and users who would be broken by it, did not test it yet or did not speak up.
>
> Yeah, if the point you're trying to make is "nobody will be mad if this
> is turned on by default", I don't think shipping it as a config option
> is very conclusive.
>
> I think a more interesting argument is: we turned on renames by default
> a few versions ago, which changes the diff in a much bigger way, and
> nobody complained.
>
>   As a side note, I do happen to know of one program that depends
>   heavily on diffs remaining stable. Imagine you have a Git hosting site
>   which lets people comment on lines of diffs. You need some way to
>   address the lines of the diff so that the annotations appear in the
>   correct position when you regenerate the diff later.
>
>   One way to do it is to just position the comment at the n'th line of
>   the diff. Which obviously breaks if the diff changes. IMHO that is a
>   bug in that program, which should be fixed to use the line numbers
>   from the original blob (which is still not foolproof, because a
>   different diff algorithm may move a change such that the line isn't
>   even part of the diff anymore).
>
>   I'm not worried about this particular program, as I happen to know it
>   has already been fixed. But it's possible others have made a similar
>   mistake.

Thanks for this enlightenment. :)

>> So I'd propose to turn it on by default and anyone negatively impacted by that
>> could then use the config to turn it off for themselves (including plumbing).
>>
>> Something like this, maybe?
>
> Yeah, as long as this is on top of Marc's patches, I think it is the
> natural conclusion that we had planned.

That is what I was trying to hint at with the commit message given.

> I don't know if we would want to be extra paranoid about patch-ids.
> There is no helping:
>
>   git rev-list HEAD | git diff-tree --stdin -p | git patch-id --stable
>
> because diff-tree doesn't know that it's trying for "--stable" output.
> But the diffs we compute internally for patch-id could disable the
> heuristics. I'm not sure if those matter, though. AFAIK those are used
> only for internal comparisons within a single program. I.e., we never
> compare them against input from the user, nor do we output them to the
> user. So they'll change, but I don't think anybody would care.
>
> -Peff

Well, I think as long as we have a reasonable easy way to undo
the default (hence keeping the option), we can proceed with caution
here, too.

Thanks,
Stefan
