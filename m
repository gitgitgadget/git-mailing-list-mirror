Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 842CF2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 23:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdGZX5D (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 19:57:03 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34488 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdGZX5C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 19:57:02 -0400
Received: by mail-pg0-f54.google.com with SMTP id 123so90388782pgj.1
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 16:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zt0CvEatikTP2kLynwdnNyaNq0R3Ug2GW4QbCjqILdY=;
        b=uW0uVbT8i9Q6H6NdbHKVgBgx2j5Gr9oW+S1Wr8m04ohXuiSwenA+wdpHAiFCHfsi56
         3eUagJ1SN3V+yrvviZHs+N2cm/IQGyrcWDAND+1TGoSIm4CLHN81t4AWpuCklRI8U/ZC
         acXajmKFEfSei5sEaf3PlqE0q2hUgit61d2KSxfNuhtbI6cOrBVRBF6eeuqLzDoDJ0vF
         YcwFHA+3ivGPc4cb0Ps2JWKZPqwQ/i0wvpPFaCUTU3P2mpadqI2LOcNusxTwoVCGEU13
         JSOVQYGbaOofxDELjCSjKr4mX8CeIOwQH41PORDu1lwkYvHugQ0WkWIjHQV21Bsxo4Qv
         0DsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zt0CvEatikTP2kLynwdnNyaNq0R3Ug2GW4QbCjqILdY=;
        b=smQSIJ+HjNB4p9DPi0q0c6LijXeq+PT+C93+1C3HDCcc12uJTTW/78hvM5+c5PTUEn
         J6T41dU/GOL+CKKPff4K3j87pEk4fSD/MPbnm2qrlgDf2ps1U652Qkdzikk8eJVPzfkO
         bQE4RawDvLaQ0TS+7R1lOjH0tYX04X4HJ/txnt87UxXP3XpcPBz+D2aB/WgLq7xecgkh
         Fb45eqJBABHxTwAcsx8EnsMDDwXlLe1lqyLP8FVoQ6SgcgyJabEL/PJpSe3H9m2bpfZe
         ncKydpU1143BPZkZqqKw34nVXlGxIfWbYJvIPprxFMlUrD+MV1+VuHcuG2CKrfnbU5Ho
         yQeQ==
X-Gm-Message-State: AIVw110D8hruEQRn5xp8wSKC0LfbPDTHLOhtmejai7/nBq8YeEi3of2o
        SpEnT8XY4rcaMzQADxF+ZfZYAQnkcW8HeupBew==
X-Received: by 10.84.217.16 with SMTP id o16mr2434190pli.31.1501113421833;
 Wed, 26 Jul 2017 16:57:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Wed, 26 Jul 2017 16:57:01 -0700 (PDT)
In-Reply-To: <xmqqwp6uojzr.fsf@gitster.mtv.corp.google.com>
References: <20170613023151.9688-1-sbeller@google.com> <20170726230425.24307-1-sbeller@google.com>
 <xmqqwp6uojzr.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Jul 2017 16:57:01 -0700
Message-ID: <CAGZ79kZ5x8p7CE6zGQ2HOJFPV_8_XKsENKt70ETACvvYZYKp2Q@mail.gmail.com>
Subject: Re: [PATCHv2] builtin/blame: highlight interesting things
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 26, 2017 at 4:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> When using git-blame lots of lines contain redundant information, for
>> example in hunks that consist of multiple lines, the metadata (commit name,
>> author) are repeated. A reader may not be interested in those, so darken
>> (commit, author) information that is the same as in the previous line.
>>
>> Choose a different approach for dates and imitate a 'temperature cool down'
>> for the dates. Compute the time range of all involved blamed commits
>> and then color
>>  * lines of old commits dark (aged 0-50% in that time range)
>>  * lines of medium age normal (50-80%)
>>  * lines of new age red (80-95%)
>>  * lines just introduced bright yellow (95-100%)
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>   I played around with it a bit more, using a different color scheme
>>   for dates, http://i.imgur.com/redhaLi.png
>
> I do agree with what this one tries to do, in that a block of lines
> tend to share the same metainfo as they come from the same commit
> and it is distracting to see them repeatedly---doing something to
> make their "these are in one group" nature stand out will give us a
> much better presentation.

Well, we could also try a "zebra"  as in sb/diff-color-move to show blocks
with the same fancy border detection.

> But does this particular implementation work well for people who use
> black in on white background?  "Darken to make it less distracting"
> may not work on both white-on-black and black-on-white users.

correct. Once we have a shared understanding what the
"interesting things" are and how to handle them, I would add
color.blame.<slot> options to make it configurable.

> "Show the background only by replacing the letters with SP for
> metainfo that are same as previous line" would work for folks from
> either camp, I would imagine.  And that should be a single feature,
> that can be enabled independently from the age based coloring.

True, I had that as the very first step of this experiment, I lost the
patch for it, but could redo it for presentation and discussion.

My impression was that this would remove _too_ much, e.g. if
a commit spans more than one screen, you may not see the first
line, but only blank space.

> The age coloring is much harder to make it work for folks from both
> camps at the same time with the same color selection.  Yellow on
> white would be terribly unreadable for black-on-white folks, for
> example.

Configuration is key here, I would think, both in the color space, as well
as in the selection space. One could imagine that other people would
rather have a defined time span, e.g. hard coding "2 weeks/one quarter/
more than a year" or relate that time span to the project history instead
of the file history.

> If you make "make it less distracting by blanking them out (not
> 'darken them')" feature without the age coloring, that can be usable
> immediately by folks from both camps, even if you cannot find a way
> to do the age coloring that would satisfy both groups.  One group
> can just leave the knob off and not use the age coloring, while the
> other group can use it and people from both camps will be happier
> than the status quo.

ok.

Thanks,
Stefan
