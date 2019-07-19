Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7361F4B6
	for <e@80x24.org>; Fri, 19 Jul 2019 11:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfGSLAu (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 07:00:50 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:42462 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfGSLAo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 07:00:44 -0400
Received: by mail-lf1-f48.google.com with SMTP id s19so21452847lfb.9
        for <git@vger.kernel.org>; Fri, 19 Jul 2019 04:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MLGBaB5uiHMvQehPxzGxLQlBRvOfOzfZSvzY9VXxeg0=;
        b=U77hh1Qh3SgtvHa/nplJHRKz+iL3D0i/7flZqNFitOMWJa8x2BCYjq1PxRCMxTfbrn
         MoS7x9OAXbJHTkzAevJP5ZmiCTohA0cfMcQg/X1pkq3rUnhLN2UzMYib1lp7iwORDcD+
         ShEcIkw+vSUXEGc+6gW4ZXjBlmz9Ydk2qsZUhWC/SMjGKddCbofqpolgI1SYJocpJA94
         pKk/E5nUK2kCCvWWfdBNdUzIzjkGp02cFKXezEpx01k/3DSQKJBfXvmFvoLB7gq9ht3X
         QDNob5D6Jcv/blpxFmS2BLTa6pa57lNTJMDid/j/gFvD4zHlccFH9/576E3Y5Tg/f/Is
         2eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=MLGBaB5uiHMvQehPxzGxLQlBRvOfOzfZSvzY9VXxeg0=;
        b=ga9vA0fxEpZmKbV1AIgRwilTkFNPiL1QzMYe3aSL6Wx/8mmXEMYFrhBCY6ySDpm32W
         RgP30tJTSmX0qrbC49US6TSjwhtnlG1TQySdzIJziI3bFKoydSxXo52AvAQlo9COdjyP
         Lb7RSJTUF2yoVosxw2I/8vy5BR3s2rFODNkGajkUA2fPULddR9bNWAsysC6REFVfCnaA
         YxNzIyShUgrl/D6f9XQHjYeQ4WW+K1uZsbCqAA8in9/oX7q2C3sF7SJt1CIgyjzy3aMm
         hueBfSUesqMlWGyzhkxQWvY+eJyfnt/m1JLY7z+2tSGUcBtjB4U7zb3/NXkOVT/RmbW1
         55dw==
X-Gm-Message-State: APjAAAXZyLhS6gxFQ7IEgWy9MmFY1g4amUBec2ZGKolrJjxbBzna9Edi
        yc6pvrwTCl+0Lz1KGKKVzjTydamz
X-Google-Smtp-Source: APXvYqwNcyx8zWezPqgN5P/fO3Dm8Ie0EcK/BGNmdkOIc1Hktu6jYfeiqNPH5fEg8V8K2jWLnrc7YQ==
X-Received: by 2002:a19:f711:: with SMTP id z17mr23769065lfe.4.1563534041937;
        Fri, 19 Jul 2019 04:00:41 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id l24sm5640291lji.78.2019.07.19.04.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 04:00:41 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Elijah Newren <newren@gmail.com>, usbuser@mailbox.org,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
References: <423596682.8516.1562665372094@office.mailbox.org>
        <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com>
        <1152121968.7459.1562688927235@office.mailbox.org>
        <CABPp-BHpkcOSkTrNDPGWRgSJgbqkc0PRqMqmesg7tQdS5TfMDA@mail.gmail.com>
        <275487563.12198.1562691633735@office.mailbox.org>
        <CABPp-BGPLxR7NgXRHppLy_W0c=Odhhns2RjcQ4iWKKQMz+SpDQ@mail.gmail.com>
        <CAGyf7-FW-_4AbWE735-=7WjZAaTLHOT_QuWOoHKAjOzZCbWhFA@mail.gmail.com>
        <xmqqtvbtu9uo.fsf@gitster-ct.c.googlers.com>
        <87sgrdf91j.fsf@osv.gnss.ru>
        <xmqqftncsdv4.fsf@gitster-ct.c.googlers.com>
        <87blxz9xbh.fsf@osv.gnss.ru>
        <xmqqh87rp0gy.fsf@gitster-ct.c.googlers.com>
        <874l3nzcpo.fsf@osv.gnss.ru>
        <xmqqtvbn44mx.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 19 Jul 2019 14:00:40 +0300
In-Reply-To: <xmqqtvbn44mx.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 15 Jul 2019 09:57:42 -0700")
Message-ID: <87r26me1bb.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Sergey Organov <sorganov@gmail.com> writes:
>>>
>>> But the point is, if M and N are equally well tested before
>>> publication, they may still have bugs resulting from subtle
>>> interactions between A and F..X that is not discovered during that
>>> testing.  And N loses the information that would help diagnosing
>>> what went wrong, which does not happen if you published M.
>>
>> I see your point.
>>
>> My point is that it's still a /choice/ between more information and
>> history simplification.
>
> I actually fail to see that point.

I'm sorry you do. Let me try again.

>
> If we are not constrained by that "first merge of a topic must be a
> redundant fast-forward merge", a topic that originally had two
> commits A and B, merged to the mainline to produce M and then
> further corrected with a commit C before it gets merged back at O to
> the mainline would leave this history:
>
>           A-----------B-------C
>          /             \       \
>     o---F---o---o---X---M---o---O---
>
> If you enforce the "first merge of a topic must be a redundant
> fast-forward merge" rule, you'd end up with a history like this:
>
>           A-----------B
>          /
>     o---F---o---o---X-------N---o---P---
>                      \     /       /
>                       A'--B'------C
>
> Is the latter materially simpler than the former?  I do not think
> so.

I think it is. To see it clearly, let's cut common parts, and then cut
irrelevant parts as well from the pictures you gave:

           A-----------B
          /             \
     o---F---o---o---X---M

                  ---X-------N---
                      \     /
                       A'--B'

There is both qualitative and quantitative difference here.

1. The qualitative difference.

In the former case we have outdated topic branch and a merge commit that
simultaneously serves two purposes: gives a recipe to bring outdated
branch up to date, and records the fact that the topic in now merged to
mainline.

In the letter case we have up to date topic branch and a merge commit
that servers exactly one one purpose: it records the fact that the topic
in now merged to mainline.

This is exactly the "material" part of the simplification I mean.

2. The quantitative difference.

In the latter case the horizon to reason about the topic branch and its
adoption to mainline is at commit X, while in the former case it is at
commit F.

The quantitative difference that we have here is proportional to the
size of diff between X and F, and once we aim at decreasing this
difference (i.e., not accepting very outdated branches), it's only
logical to get rid of this difference entirely, once again ending up
with the latter case.

Finally, please also notice that ability to reference outdated version
of the topic branch (or even multiple of them), provided there is actual
reason to, is still there:

$ git checkout topic
$ git pull --rebase
$ git merge -s ours topic@{1} # keep reference to original
$ git checkout mainline
$ git merge --no-ff topic

> I was preparing myself to say "we rejected the combination because
> it would encourage wrong workflow, but perhaps over the years people
> like you and usbuser may have found good use patterns different from
> what we considered back then, and these use patterns may not
> encourage wrong workflows.  It may not be a bad idea to introduce a
> new optional behaviour if that is the case", but what I heard so far
> does not convince me that we have good use patterns.
>
>>> About the docs easily getting misinterpreted, I think Elijah covered
>>> it pretty well.
>>
>> Yeah, sure, the docs should better be fixed.
>>
>> Anyway, bare "git --no-ff" is still there, and I can live with no safety
>> belt that '--ff-only' could easily have been, it's just that it's a pity
>> to see lost opportunities in the design.
>
> Lost opportunities to add an option to encourage bad workflow?  
>
> No, thanks ;-)

I dunno what is that "bad workflow" you have in mind, sorry.

-- Sergey
