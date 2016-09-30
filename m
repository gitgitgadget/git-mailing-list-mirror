Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DDB5207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 19:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933477AbcI3TmL (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 15:42:11 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36330 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933418AbcI3TmK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 15:42:10 -0400
Received: by mail-qk0-f194.google.com with SMTP id m184so6935860qkb.3
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4Do7oUWK8SrV5+7lu/x02Z3m4g5eeVyzPmkhGd67cCk=;
        b=aasC54l1lp4+Lq8udFJuS78suW9YvrixwoiOmFSpSu59ds6Cg/pPSNnakvmQTKbZg5
         0TZK+uZtLXWd4iujcUI+Tkx8K55nB0u1NGMMdRIK+9I0ak4a1fqX3sU5W6XPkHWY5dfG
         gjsU/leQM1/KuXt8z/29pzu6az0VIefT7s0CHnK31eDXqN05GK0N22Olhp8rEMLwtHOF
         gz/DyJXUShatphOI9++HGdxv10tt6Z2zkhhd7SSDYmuYr0pdMfEaZdadOcw/qnbamm8e
         Uuv3hrK8KyrMxjJMshFjeV+gKKNEmZ0QZtiATDMk3WGL9vNwRrkslsZFpK1RZKCvQD2/
         pTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4Do7oUWK8SrV5+7lu/x02Z3m4g5eeVyzPmkhGd67cCk=;
        b=CzeaJJEfiG1PrBSU30AOH0cjBGisAB+D6kGFv6goHTBICrKNqOowvLyqvw1J/Lkf2f
         FWbsBUEZ+W7LO+mQDZjyMWnghFnV3cMBQQIotT+HlPdsztqU6lTS6hpEsk2fy9P1Fq5/
         3fheDc5LS6NzC8bGWKLw12bVOHaJoYYPk8bNB9kRj5s4Pvte2kXeG6H9Sl01garnZ7Yg
         RehRfOR9dI8XHHooFPZkqA15Hpih6oqeHlnvaxY1d2/1XK1Ls+5RNgQrboXrC+ErsIBx
         rOctu3JTHK10/AiPVpA4B1mgDtTmJZA2Wef2YpaPWmkifSF+7yv2umZzRg9Ec9au518I
         M6XA==
X-Gm-Message-State: AA6/9RkykTIu34rxaZriU6GSAay842tK02dtvLjQs8QrbdA8myI8XQgEvKjuerGTOIBh2y3WQN2jBqFl29J26g==
X-Received: by 10.55.77.201 with SMTP id a192mr5601334qkb.198.1475264529616;
 Fri, 30 Sep 2016 12:42:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.87.133 with HTTP; Fri, 30 Sep 2016 12:41:48 -0700 (PDT)
In-Reply-To: <CA+55aFzjTB0peMDPoPA6JyeUy90x=Lh4qdfiYLNf6RQU3ey9Hg@mail.gmail.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com> <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org> <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
 <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
 <CA+55aFx9Utm9yDZceks+5q9c8ydc2QMYshWwJ0G0GHWWLwSsXQ@mail.gmail.com>
 <20160930005638.almd66ralshknoxa@glandium.org> <CA+55aFzjTB0peMDPoPA6JyeUy90x=Lh4qdfiYLNf6RQU3ey9Hg@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 30 Sep 2016 21:41:48 +0200
Message-ID: <CACBZZX4p8KEHnkDQ-c2La-1rkgiBs47T+dCNOfpji3tKs3YhVA@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2016 at 3:01 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Sep 29, 2016 at 5:56 PM, Mike Hommey <mh@glandium.org> wrote:
>>
>> OTOH, how often does one refer to trees or blobs with abbreviated sha1s?
>> Most of the time, you'd use abbreviated sha1s for commits. And the number
>> of commits in git and the kernel repositories are much lower than the
>> number of overall objects.
>
> See that whole other discussion about this. I agree. If we only ever
> worried about just commits, the abbreviation length wouldn't need to
> be grown nearly as aggressively. The current default would still be
> wrong for the kernel, but it wouldn't be as noticeably wrong, and
> updating it to 8 or 9 would be fine.
>
> That said, people argued against that too. We *do* end up having
> abbreviated SHA1's for blobs in the diff index. When I said that _I_
> neer use it, somebody piped up to say that they do.
>
> So I'd rather just keep the existing semantics (a hash is a hash is a
> hash), and just abbreviate at a sufficient point that we don't have to
> worry too much about disambiguating further by object type.

I work on a repo that's around the size of linux.git in every way
(commits, objects etc.), and growing twice as fast.

So I also see 8 or 9 digit abbreviations on a daily basis, even with
the current defaults core.abbrev, but I still think growing it so
aggressively is the wrong thing to do.

The fact that we have a core.abbrev option at all and nobody's talking
about getting rid of it entirely means we all acknowledge the UX
convenience of short SHA1s.

I don't think it's a good idea for such UX options to have defaults
that really only make sense for repositories at the very far end of
the bell curve, which is the case with linux.git and the repo I work
on.

Either way you're going to waste somebody's time. I think it's a
better trade-off that some kernel dev occasionally has to look at
Peff's new disambiguation output, than have the wast hordes of
everyday Git users have less screen real estate, need to recite longer
sha1s over the phone during outages (people do that), and any number
of other every day use cases.

I think if anything we should be talking about making the default
shorter & then have some clever auto-scaling by repository size as has
been discussed in this thread to deal with the repositories at the far
end of the bell curve.
