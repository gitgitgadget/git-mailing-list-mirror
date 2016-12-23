Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5361FF40
	for <e@80x24.org>; Fri, 23 Dec 2016 08:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938742AbcLWINl (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 03:13:41 -0500
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35239 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbcLWIMf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 03:12:35 -0500
Received: by mail-yw0-f173.google.com with SMTP id v81so24349085ywb.2
        for <git@vger.kernel.org>; Fri, 23 Dec 2016 00:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TTfG64b+ySL2kHml4LSb5JBkxcY4ikBEEsUa8gZ+dxo=;
        b=m3ET5mE1giot8Q0Pix7SH86+a4ffY5bULNSCr3tghtYNLGb/TWbeCOLwz4LsFnrxDw
         LxljMAxrYCPdhgOYpaHHJ3Jc55OXsS9aF9EgZh0EBuAAeHjXTNMHR9GwDsePfRRYAac+
         8LOPjnpJ5rdTS14aK2eCADGDadiRkSLHWmNgT9mHmP7PujleuNcWHgJDIp9QxrhHhXR0
         ARYFBbr5EVzBkI2UQyGQmlIvZr9Xldmr9Q/2z7WpK/xvUZSzKU0J7Gimvoymsf5mDYha
         qg38n0Pugt3jTTXp2U5EVPScOjfh3uT4WD+yPw8Wsj56L6hVu8BFhukzbdQt4tqcRG5F
         EEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TTfG64b+ySL2kHml4LSb5JBkxcY4ikBEEsUa8gZ+dxo=;
        b=nmkKyQ2jzMBKVerpXQornDRG+wXCV0y2bqc4PuHazB3b9fvnwVEhOuQN2ubre4A97C
         ZzKvLAEP2Wmp8PAgTqaeta9sPOWjzXRWjFZuXNhgUgPBjo65BA4wTbOd11Wwo15wRb80
         Kh41dDtj1BrsW/5OPoPKD+Oiu8uzS/bTB0d6DEJJPKDnWXWR44z9e7HW2hn94geU5Jfw
         7aorqyuQ9HTW4ri1ISwXy0dQ8UBRL/yVr21gFpT4RYuNSgYgttCsfAO5UQwBDRogKVZL
         nBns6SQCXfSLXoidvPqy9DI5DILKstSGx/LGNxUNFcEgvwO/7D74oQHsVXLw4bE+ZjiV
         4Zmw==
X-Gm-Message-State: AIkVDXLoGLhDVG+jaV+BF2YjiAEyQp2DfwtohYbZGiDwEGtCzmGktjaCvmzxsGYYtXoG0LVdp+UHZ1niSi3s8A==
X-Received: by 10.129.102.132 with SMTP id a126mr10847510ywc.160.1482480754326;
 Fri, 23 Dec 2016 00:12:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.177.158 with HTTP; Fri, 23 Dec 2016 00:12:13 -0800 (PST)
In-Reply-To: <20161223072201.zw2lwkdcs6qmb4rp@sigill.intra.peff.net>
References: <20161217005442.5866-1-jacob.e.keller@intel.com>
 <xmqq7f6zqr3i.fsf@gitster.mtv.corp.google.com> <CA+P7+xp=7h7oATwO6vunqO+nfGhvQgiRkwG0P44hC4YLW2MRhA@mail.gmail.com>
 <xmqqinqbfz2r.fsf@gitster.mtv.corp.google.com> <20161223072201.zw2lwkdcs6qmb4rp@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 23 Dec 2016 00:12:13 -0800
Message-ID: <CA+P7+xrWsCkABzpSkYJ4fb2_JijmUx=Sf4Hgsr6Z+k=_GogE_Q@mail.gmail.com>
Subject: Re: [PATCH] diff: prefer indent heuristic over compaction heuristic
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Norbert Kiesel <nkiesel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 22, 2016 at 11:22 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Dec 22, 2016 at 01:12:12PM -0800, Junio C Hamano wrote:
>
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>
>> > I don't think we have too many config options that interact in this
>> > way, so I understand that "last writing of a particular configuration"
>> > makes sense, but interactions between configs is something that would
>> > have never occurred to me. I'll send a patch to drop the compaction
>> > heuristic since I think we're all 100% in agreement that it is
>> > superseded by the new configuration (as no case has been shown where
>> > the new one is worse than compaction, and most show it to be better).
>>
>> If I recall correctly, we agreed that we'll drop the implementation
>> of compaction, but use the name --compaction-heuristics to trigger
>> the new and improved "indent heuristics":
>>
>>     <20161101205916.d74n6lhgp2hexpzr@sigill.intra.peff.net>
>
> FWIW, I was swayed in the other direction by later messages in the
> thread. Especially your noting that the "compaction" name has always
> been labeled experimental, and Michael's argument in:
>
>   http://public-inbox.org/git/8dbbd28b-af60-5e66-ae27-d7cddca233dc@alum.mit.edu/
>
> I.e., we could keep calling it "--indent-heuristic", and probably drop
> the other heuristic entirely as a failed experiment.
>
> I can live with it either way, but since I am being quoted as the source
> of the suggestion, I feel like that's an invitation to add my 2 cents. :)
>
> Liberal quoting below since I am adding Michael to the cc list.
>
> -Peff
>

I actually would prefer that we just say "this is the default now" and
provide some knob "no-indent-heuristic" or "no-compaction-heuristic"
and go with that, I think, since I am pretty sure we're all in
agreement that the heuristic is an improvement in almost every case,
certainly all the ones we've found. It's at least not worse in any
case I've seen, and is usually better.

Thoughts? I don't have a super strong opinion about which name we went
with for the knob.

Thanks,
Jake
