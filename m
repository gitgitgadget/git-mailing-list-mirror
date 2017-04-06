Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB01220966
	for <e@80x24.org>; Thu,  6 Apr 2017 00:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756299AbdDFASR (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 20:18:17 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35263 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756260AbdDFASP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 20:18:15 -0400
Received: by mail-lf0-f42.google.com with SMTP id j90so18096126lfk.2
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 17:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0OueAC6fAuRxJAOGMzJLv6gNOsGy8sx1mBhAKIWi2HI=;
        b=k9WYNCCzCGn3rce0L0v1eiF4Njmamnqc1FL8LoJWL1v3zJXD/yKMPs271vjz/NjuXx
         hOnSRpcobYgi7Z/NoaJQTcZXU4OkuuJIQlr2vgfKJxPRomHxBvtROS2qmE8VO34f19QW
         D0TPCUWI4V6zmcVaC1dD/2U3TGhxv6wZ0N8IGu8eXBpBEAhWo2e5EGHal/gdh33hY8bq
         B+EuyDzQAPVjokHrp++VI1gM2eJLF8rkziFxaNj+UeoqR2n6Gg6FPNZQ6I4J1boC61SJ
         7sKDWHmUPcILDLqjtg8RvvnPsy1QQDsO04NA0ShBJHRY6O0U7uK5DwumNWfwZsw6zyyW
         34cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0OueAC6fAuRxJAOGMzJLv6gNOsGy8sx1mBhAKIWi2HI=;
        b=EgLwPkQgySXMfQGq8/ptfO+joayDbme2Trjl5GI49NrXZzpj2LCc4TAN7NeYbCm8Ud
         GcnrakZA6F2gYMBpwPEf75US0VbyLc/P39un2IfD0LcsBapcFtX6keqkbMpRSjqDVQ9n
         U9X5EYI908eNrY5WilsO7y5ZwLXjlFHFa6vXdycrWVSzyA1cLCpX+jIjl4W/p55bACy3
         93QMGwb07c+a4kdPj4xRWZssdPX+JkQg+RL5L0fxcwepNKaWLyf9yEWKjrQXuACagMMZ
         n6O6Sx9q5rI5FHedmD6eRkVmhMlafgWblQNK6Z6xPdxefm3MzKbiL5oOnDckkr+No4gf
         NEEA==
X-Gm-Message-State: AFeK/H1lJUmHNjFFK6ZjO1X/3NvVSRtYcOyVrx173e6eqTJFhqaJnHJUE+kPqFIrpwkl4wmJ5ss5bnwitGZ5lg==
X-Received: by 10.25.77.2 with SMTP id a2mr10939033lfb.143.1491437893640; Wed,
 05 Apr 2017 17:18:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Wed, 5 Apr 2017 17:17:53 -0700 (PDT)
In-Reply-To: <20170401001924.GC8741@aiede.mtv.corp.google.com>
References: <20170331231135.195195-1-bmwill@google.com> <20170331235623.166408-1-bmwill@google.com>
 <20170331235623.166408-3-bmwill@google.com> <20170401001924.GC8741@aiede.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 5 Apr 2017 17:17:53 -0700
Message-ID: <CA+P7+xq58Bc2KVb2ewBPWPj8Zyf82tJWgQeq=oFvbs0ACysvLQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] push: propagate push-options with --recurse-submodules
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 5:19 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Brandon Williams wrote:
>
>> Teach push --recurse-submodules to propagate push-options recursively to
>> the pushes performed in the submodules.
>
> Some time in the future we may want "push --recurse-submodules" to do a
> dry run pass before doing the final push, so that if it is known that
> some of the pushes wouldn't succeed (e.g. due to not being
> fast-forward, or the server not being reachable, or the server not
> supporting push options) then git could stop early instead of some
> succeeding and some failing.
>
> But that's a larger and separate change from this one.  Users of push
> --recurse-submodules today know they are effectively asking for
> multiple pushes that are not guaranteed to succeed or fail together.
>

If you want it to be truly atomic it will require more effort than the
above. Suppose that you do a dry-run first, and then find out
everything will succeed. After this, you do the real pushes. But in
between these two commands something could have changed, and you could
still end up with a non-atomic set of pushes.

I think that's ok and better than before, but it should be noted that
you stll don't guarantee that all the pushes succeed or fail together.

I'm really not sure if you even can make these pushes work atomically
considering they are going to different hosts.

Thanks,
Jake
