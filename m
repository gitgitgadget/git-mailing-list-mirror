Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AB9720899
	for <e@80x24.org>; Mon, 14 Aug 2017 21:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbdHNVFH (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 17:05:07 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33195 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752421AbdHNVFG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 17:05:06 -0400
Received: by mail-yw0-f174.google.com with SMTP id p68so62327675ywg.0
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/YwiqIL/vO1WiMzj8b9X5jik488KW/DFGg/3QqDHFw4=;
        b=srrHBGpuuNRfr1laCBWJ0Gtk9Awg0QDSxVW19HFFDgvdeCGKRPZU9HUYcSQ7dhF2e9
         wdlFHspA2svx1eJIoETIsuJVDANggY7pCDbn8j/7AkCW+Ct0+BZzair48mFiRO5F2fTJ
         xto+iP8amlFi0R9iOaXlW/XBNNSVe0eMMUvUaId6bA1tZp3N/C/qHd2lWzUacd78dXvk
         KwZVP7QqgtasRcm9DV/MuVzPb8BGvvEHmrMHttUDdX9SAHnfDZ6MwogHpqfdO0HMf1Pr
         eme3/6ptR6pDb6XXBzVDHnMFsWR8/84hCmtQDWKWJ/aqfT6oMzdwFAOzp84nfRlYMqhJ
         CDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/YwiqIL/vO1WiMzj8b9X5jik488KW/DFGg/3QqDHFw4=;
        b=RM2yzBoN7+JBciflv0Kbm8TdhROjRRErKg4pmOPAN62UHgw7LFgkwBD/YlaqE3Ue8C
         D9gno01SGRjNzD1nXbwedm8SRTq3jvYBIZg38haqtjlalFqGzrcHnqz5tol47FMefAu/
         TJ/GjtTDFbAjZAuIeA6rbxNSGfyRNO/q29Y7U0Z6L9XQNVofkBNsPX0zCCzzqkM5+xN5
         83o4cogg0spM3nCW6OfP+P7djbv00OXPpqEr07Au5+Gljbro99OOBvW6gWxcxFzpiK17
         icgbXKeCi2exfsYY3dRl/YS4j9LQyOXfg7vgursnsUctEVQdRSxs584kDeYmrOrZMXhh
         z0Zw==
X-Gm-Message-State: AHYfb5gwCNPzVUme0TeklsxyFk6yoM+APxjvhY+Xt1gdLvQD+xmIARpB
        LZYy+bhhKZGubKwhtvvhmuUFFHvHUnxw
X-Received: by 10.37.183.130 with SMTP id n2mr10286423ybh.353.1502744705183;
 Mon, 14 Aug 2017 14:05:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.75.3 with HTTP; Mon, 14 Aug 2017 14:05:04 -0700 (PDT)
In-Reply-To: <2bbb1d0f-ae06-1878-d185-112bd51f75c9@gmail.com>
References: <20170810184936.239542-1-jamill@microsoft.com> <20170810184936.239542-2-jamill@microsoft.com>
 <CAGZ79kb8cWR1P=1FSkfZ72Ai63T0WapwtCCN3gwqrWE_=MzOLg@mail.gmail.com> <2bbb1d0f-ae06-1878-d185-112bd51f75c9@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Aug 2017 14:05:04 -0700
Message-ID: <CAGZ79kaxwKrHJ=00w3=R0xteep3Gy6rfExZmOZxNtc3YLijHLw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] dir: teach status to show ignored directories
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Samuel Lijin <sxlijin@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 10:48 AM, Jameson Miller
<jameson.miller81@gmail.com> wrote:
> The set of files listed by "--ignored" changes when different
> values are given to "--untracked-files".  If would be nice to
> be able to make the ignored output independent of the untracked
> settings.  This patch attempts to do that while maintaining
> backward compatibility with the existing behavior.


So after rereading this, maybe we could have
'--ignored[=as-untracked, new-mode]' with as-untracked as default?

This would satisfy your goal, while still maintaining backwards
compatibility.

> We want to see the paths that explicitly match an ignore pattern.
> This means that if a directory only contains ignored files, but the
> directory itself is not explicitly ignored, then we want to see the
> individual files. This is slightly different than the current behavior
> of "--ignored".
>
> I am open to suggestions on how to present the options to control
> this behavior.

I would strongly favor not introducing yet another flag to tweak the
behavior of another command line option. (The UX of Git is already
bloated, IMHO. But that is just my general stance on things)

So we'd have two proposals:

(1) The current patch proposes --show-ignored-directory that modifies
    the behavior of other flags
(2) extend an already existing option to take another mode (which I
    propose)

Strong arguments for (1) would be if the flag is orthogonal and apply
to the other flags in a uniform way, i.e.:
    status --no-ignored --untracked=no --show-ignored-directory
would make sense and produce an output that a user doesn't
find confusing.

Arguments for (2), are
* less documentation for users (see below)
* if the two flags are truly orthogonal, test effort is decreased
* no exposure of an API that may yield strange results when the user
  gives strange input.

>>> This
>>> change exposes a flag to report all untracked files while not showing
>>> individual files in ignored directories.
>>
>> By the description up to here, it sounds as if you want to introduce
>> mode for --untracked, e.g. "normal-adjusted-for-ignored" (it's a bad
>> suggestion)? However the patch seems to add an orthogonal flag,
>> such that
>>
>>    status --no-ignored --untracked=no --show-ignored-directory
>>
>> would also be possible. What is a reasonable expectation for
>> the output of such?
>
>
> The current patch does add another flag. This flag only has meaning if
> the "--ignored" and "--untracked=all" flags are also specified. Another
> option I had considered is to let the "--ignored" flag take an argument.

I would think that is a better solution, as then untracked and ignored
files (and their parameters) will be orthogonal in the long run.
Things like

  --untracked=all --ignored=none
  --untracked=none --ignored=only-dirs
  --untracked=reasonable-default --ignored=other-reasonable-default

will be possible and eventually the default for ignored files may be
independent of untracked settings.

> Then, we could express this new behavior through (for example) a
> "--ignored=exact" flag to reflect the fact that this new option
> returns paths that match the ignore pattern, and does not
> collapse directories that contain only ignored files.

Yes, and we would not need to worry about how the new
flag interacts with other flags. I would prefer that solution as it
seems the API will be cleaner that way.

Less things depend on each other, e.g. as a user I do not need to
know about the 'other' flag, be it ignored or untracked to solve my
problem. If we'd go with this third flag, we'd need to (a) document it,
but (b) also have to add a sentence to untracked and ignored flag
    "In the corner case of also having the third flag, we change
    behavior once again"
which I'd dislike from a users perspective.

>>> Commands:
>>>   1) status
>>>   2) status --ignored
>>>   3) status --ignored --untracked-files=all
>>>   4) status --ignored --untracked-files=all --show-ignored-directory
>>> (2) is --untracked-files=normal I'd presume, such that this flag
>>> can be understood as a tweak to "normal" based on the similar size
>>> between 2 and 4? (The timing improvement from 2 to 4 is huge though).
>
> (2) is --untracked-files=normal. Although the count of ignored
> files similar between 2 and 4, I consider this flag more of a
> tweak on 3, as we want the untracked files reported with
> the "--untracked=all" flag. The counts between 2 and 4 are
> similar in this case because most of the ignored files are
> contained in ignored directories.
>
> Our application calls status including the following flags:
>
> --porcelain=v2 --ignored --untracked-files=all --ignore-submodules=none
>
> This means we have bad performance compared to just "git status"
> when there is a large number of files in ignored directories
> With this new behavior, our application would move from case 3 to
> case 4 for this repository.
>
> You also point out the timing difference between case 2 and 4. I
> think there is an optimization we can make when running "git
> status --ignored" logic that will improve the the timing
> here. Currently, the logic in dir.c is iterating over all files
> contained in an ignored directory to see if it is empty or
> not. This is not necessary - we should be able to stop after
> finding any file. I plan to follow up on this in a different
> patch.

Thanks!
