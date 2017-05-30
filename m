Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 102472027C
	for <e@80x24.org>; Tue, 30 May 2017 21:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750993AbdE3ViX (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 17:38:23 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34605 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdE3ViW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 17:38:22 -0400
Received: by mail-pf0-f179.google.com with SMTP id 9so83474547pfj.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 14:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G7YLDPqwTafem44zjTrmuzjPfjSNBrsAXR1FbRZknww=;
        b=XWYTJYYur92VJ/ahgVHQSsLD3XPwmdiNTRXs8MExOTNuOZIrydoh+rnJQNO8NleRBZ
         Gsz4xzEGKN4CbfFAetgQETndowe5uIRWOK6ulkF7DaA+74xwprLf9DY2GdF3QzAF/hje
         aSFgV+ZjoXJLPdKRJf7hdJX9HL3jCxp7RgKm5dS4gHK9j2R5WoTd+Wg7rFsHLTmcKHB6
         N7mPKCFpdDagchRt6ufmxC8i3bIUlfKbj1gtWhcVASamn5MeTqyCGEi+xYRdCXP8dmqO
         VjQquEdAwsJPUQey7zJD62tlkCt2HD2GEcVv+TPuxtttMJF0Np3mRb+Ft52LvDPjiv2r
         QcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G7YLDPqwTafem44zjTrmuzjPfjSNBrsAXR1FbRZknww=;
        b=NYxi3/ZEMWqWK8y7R7MdzTHqqJ/r+/d3kvLuwp3ALqvgdv4STWJxfvz7DqXfj76tqJ
         TMdn1lDXi8VEYkDm0upDRB70QQJknAeZumGgDm7oAxYG5bP5XsV8VTj7YGOnZUgA1iax
         hzXAj1JX97aRWgc0g8VMu3UQlqYvNC5uAV7EjLl3cbUWlVpEIVk2WZcNkQ3tFTuPyWyR
         qsoBUXPqU+jLN1+ap9Rz8GVjAMeQT7Xp1fFNkcjJ54qSt0jnF2cVbvteYPgjxDP10II8
         4j3fI4bO1YJbY82IaeH2O8QmpYbXEx4vw7cu4JRH1GzgsQpYTDpxwFTw4quwBm6dymT9
         60+A==
X-Gm-Message-State: AODbwcC5VsJ2JIxoswnvc58oIn0KiC24iJhwwUNgzPcJQEr+5pG9tD9l
        iCV6WkBfkoIkAXA5U0nAtnWAxdeVSmFM
X-Received: by 10.98.205.65 with SMTP id o62mr25813206pfg.105.1496180301475;
 Tue, 30 May 2017 14:38:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 30 May 2017 14:38:21 -0700 (PDT)
In-Reply-To: <CA+P7+xrFjwUWNA9BQ3V4ad6mizrfXTcU4td+u1-i9GCBshPjfQ@mail.gmail.com>
References: <20170518193746.486-1-sbeller@google.com> <20170523024048.16879-1-sbeller@google.com>
 <CA+P7+xrFjwUWNA9BQ3V4ad6mizrfXTcU4td+u1-i9GCBshPjfQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 May 2017 14:38:21 -0700
Message-ID: <CAGZ79kYiv_t+EEGoPGE5-ZRCXbTEyeodjpNCLMXVMq04sW224Q@mail.gmail.com>
Subject: Re: [PATCHv4 00/17] Diff machine: highlight moved lines.
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2017 at 6:04 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Mon, May 22, 2017 at 7:40 PM, Stefan Beller <sbeller@google.com> wrote:
>> v4:
>> * interdiff to v3 (what is currently origin/sb/diff-color-move) below.
>> * renamed the "buffered_patch_line" to "diff_line". Originally I planned
>>   to not carry the "line" part as it can be a piece of a line as well.
>>   But for the intended functionality it is best to keep the name.
>>   If we'd want to add more functionality to say have a move detection
>>   for words as well, we'd rename the struct to have a better name then.
>>   For now diff_line is the best. (Thanks Jonathan Nieder!)
>> * tests to demonstrate it doesn't mess with --color-words as well as
>>   submodules. (Thanks Jonathan Tan!)
>> * added in the statics (Thanks Ramsay!)
>> * smaller scope for the hashmaps (Thanks Jonathan Tan!)
>> * some commit messages were updated, prior patch 4-7 is squashed into one
>>   (Thanks Jonathan Tan!)
>> * the tests added revealed an actual fault: now that the submodule process
>>   is not attached to a dupe of our stdout, it would stop coloring the
>>   output. We need to pass on use-color explicitly.
>> * updated the NEEDSWORK comment in the second last patch.
>>
>> Thanks for bearing,
>> Stefan
>>
>
> One thing to note when I was playing around with what's on pu right
> now, I noticed that the oldMovedAlternative and newMovedAlternative
> are the first moved colors to be used if there is only one move. (Ie:
> a simple case of literally one section moved) This is a bit weird that
> the alternative colors are used before the "main" colors. I would have
> thought it would be the other way.

While pu is not up-to-date, I double checked with the most recent
implementation and that is no longer the case.

> I noticed this because the default colors do not work well for my
> terminal color scheme and I had to configure but realized that I
> needed to configure the alternative ones to make a difference in the
> simple diff I was viewing.

The v4 that you tested, is the "alternate" scheme in the resend
https://public-inbox.org/git/20170527001820.25214-2-sbeller@google.com/

Thanks,
Stefan
