Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28FB51F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 12:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502389AbfJQMe7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 08:34:59 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33385 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfJQMe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 08:34:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id x134so1700871qkb.0
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 05:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cjqetd8rMxntq4QmPvsuKKZSV3V5oFQaS5tv5T0F95w=;
        b=c7Ld7En0C8y5xvdUXMI+VxxvZGY+RtMXzEKRxs/ExjYIRQP5d9p2cUPy2B+xEQIu1T
         jpQ506z5fWCeYL1tbmJRIVNTqB2pffcZ7iq1FBuMJHVb8D4H7GDv3FmrRvm1o8Zdtu9S
         6jIkCEqNdNav9Ft9NiiMDwXugl6eHtFiNJYZAmTicnDJETx9lw8i/k0qORhWUFE6Nz1o
         938DIsOGBKjkge02ex/oG7XwGw3vQU1NnVBAnLqjM3LJwdrJSimy2hCMYd1UfSkce94u
         06oTW4x1QIXkfS84MSmMZEg5+0vjPeNoeWX/lT6ZLHVT3czWyNPh5qWOX+718yZXpzaQ
         mNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cjqetd8rMxntq4QmPvsuKKZSV3V5oFQaS5tv5T0F95w=;
        b=q/b4J0usWW0TUvFXKc+12HBczm8SDt414xNjzoH+oWtRCyaGG4QnKno8Vt23bQeGHR
         +woNmQe9xpOfSvMKTr32fiFLC2vfulUnSmvtNJUrBOLmirgA9QvLG5ZH2pZokhEPj+hK
         8NsNtsiWCATjKSzDoWi025jT6qii5J6ky7/i0sbKJ9k09FL4v24AE47IdRhWc5qsPw5h
         oRdoNjHZbFM0ARhts7bmgYaq1vqzndOHMovckrRc5WH9iptc0bJ925z4/PbZQV0Kabpr
         AHaKGp3gWpVvqEesSjrSRf8WZgFRnX787AP4YD+rZdzHyqA0iBnI5CQU9vQMPcCnvAwB
         ut1A==
X-Gm-Message-State: APjAAAX1+xtaHhymXeJhK/UvsUwQzrr0CllVWb8BTinEfdkdlSuyqpa7
        LjPlbvhLyGgq/1q9JRyGOWs=
X-Google-Smtp-Source: APXvYqwp0I850X8rM5keZTugr4lJqH9zb2sSUWcDmzPMvbgiKKQiE88ulnIac2VRxpnmPUukefxxwA==
X-Received: by 2002:a37:84c3:: with SMTP id g186mr3015786qkd.398.1571315697354;
        Thu, 17 Oct 2019 05:34:57 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bc90:dbe5:6d1f:a2b3? ([2001:4898:a800:1012:6dc4:dbe5:6d1f:a2b3])
        by smtp.gmail.com with ESMTPSA id t40sm1226957qta.36.2019.10.17.05.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 05:34:56 -0700 (PDT)
Subject: Re: [PATCH v3 08/13] graph: tidy up display of left-skewed merges
To:     Junio C Hamano <gitster@pobox.com>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, James Coglan <jcoglan@gmail.com>
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
 <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
 <c34a5eb160310613cbde6313cda6cff753d6d7fd.1571183279.git.gitgitgadget@gmail.com>
 <xmqqsgnt8hlh.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <863fb1b9-8829-64db-d355-56a97e979427@gmail.com>
Date:   Thu, 17 Oct 2019 08:34:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <xmqqsgnt8hlh.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/16/2019 12:00 AM, Junio C Hamano wrote:
> "James Coglan via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This effect is applied to both "normal" two-parent merges, and to
>> octopus merges. It also reduces the vertical space needed for pre-commit
>> lines, as the merge occupies one less column than usual.
>>
>>         Before:         After:
>>
>>         | *             | *
>>         | |\            | |\
>>         | | \           | * \
>>         | |  \          |/|\ \
>>         | *-. \
>>         | |\ \ \
> 
> Looking at these drawings reminded me of a tangent that is brought
> up from time to time.  We do not do great job when showing multiple
> roots.
> 
> If you have a history like this:
> 
>       A---D---E
>          /
>     B---C
> 
> drawing the graph _with_ the merge gives a reasonable representation
> of the entire topology.
> 
>     * 46f67dd E
>     *   6f89516 D
>     |\  
>     | * e6277a9 C
>     | * 13ae9b2 B
>     * afee005 A
> 
> But if you start drawing from parents of D (excluding D), you'd get
> this:
> 
>     * e6277a9 C
>     * 13ae9b2 B
>     * afee005 A

I hit this very situation recently when I was experimenting with
'git fast-import' and accidentally created many parallel, independent
histories. Running "git log --graph --all --simplify-by-decoration"
made it look like all the refs were in a line, but they were not.
(The one way I knew something was up: the base commits also appeared
without a decoration. That was the only clue that the histories did
not continue in a line.)

> 
> and the fact that B and A do not share parent-child relationships is
> lost.  An easy way to show that would be to draw the bottom three
> lines of the full history output we saw earlier:
> 
>     | * e6277a9 C
>     | * 13ae9b2 B
>     * afee005 A
> 
> either with or without the vertical bar to imply that A may have a
> child.
The natural extension of this would be multiple columns:

 | | | | | *
 | | | | *
 | | | *
 | | *
 | *
 *

This does not appear too cumbersome, and such a situation should
be rare.

> This is not something that has to be done as part of this series,
> but I am hoping that the internal simplification and code
> restructuring that is done by this series would make it easier to
> enhance the system to allow such an output.

I agree. An excellent idea for a follow-up.

Thanks,
-Stolee

