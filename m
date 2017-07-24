Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C60FE203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 19:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932335AbdGXTHv (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 15:07:51 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35668 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932321AbdGXTHt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 15:07:49 -0400
Received: by mail-pf0-f170.google.com with SMTP id h29so15206131pfd.2
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x8XSoQzdJdUZ1U2Kh9pIysqqI/7+DNvPV8ALg8MheLI=;
        b=uTo3IjY3WtAdySdxWeqty+K/fsS5JfDVhUy9FB7u78lGKeh0M+lrT2bqlWwgAxRV3k
         wPOH0IgC+jmlGSoL2aZKYZL535ur+k+ZhUwxT+dnjrMXvyre71vY7nfQjSlEE/ZDdg8k
         4RXhPCCFWLro8jZlEkiNQ9QEoA67VWeNg7WBaKOu/cEK0Q5rJb5csEHXkCsOjojkSkkN
         N5GBZZoh5q3ElaFF1EMGqJPShx9ykicL/nen5UXqR7X59Gs1ocA3iMGCt+5dUVZRi93x
         013Vu5+RvTzPqZ7xY1dWgCz37jAeiinCLpvuTgLYE4sInGG9giuUA64+MDer3HYbm9H7
         a3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x8XSoQzdJdUZ1U2Kh9pIysqqI/7+DNvPV8ALg8MheLI=;
        b=A/F/s27yH7yVOS96TAKXMxQRuo4Uh0gNdDsHhgfBPuwhJ0F+NweDq0p/fSjlCK/tdy
         OYcnsWmrBvWP0PQVQ0UtEoQ/2YwOnSr7CiHX9vcyV39suqjjQ/ELDsI/QU/L3PoJUiZq
         UkKwXFTOCnHIkb24Wa6j5O0n70Ye6Lg+gld1RWxZA9lgwQ4nKbKez+iqMIlTEtFDnRo5
         l9EAwnPdnsMav1sUtXOZY78w3JiE7sMy1Yor1t4jCrRcJtiNI2o8GKcWiQrp8q1tnY6D
         FJkXV5S650hUOrdma8X9+LyDrio9DbBBemlrVyvLmT2HwDKM72AhAaQT3IPClKAnx6Fj
         yjzA==
X-Gm-Message-State: AIVw112AYdl4xpwURFa0Eiq4bfhsfH0u7Gs+xHJqsyJzwnka86Z+JAxe
        HNeDlkJKhFDP4iwJysgF0pJYV9H7FTDi
X-Received: by 10.98.12.145 with SMTP id 17mr16862885pfm.153.1500923268809;
 Mon, 24 Jul 2017 12:07:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Mon, 24 Jul 2017 12:07:48 -0700 (PDT)
In-Reply-To: <20170724180312.GE13924@aiede.mtv.corp.google.com>
References: <20170724173601.19921-1-sbeller@google.com> <20170724180312.GE13924@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Jul 2017 12:07:48 -0700
Message-ID: <CAGZ79kaYzHzSdDZuMpM6UFXLon0SME-nC=9_09PLhLEADfuscw@mail.gmail.com>
Subject: Re: [PATCH] recursive submodules: detach HEAD from new state
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 11:03 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Stefan Beller wrote:
>
>> When a submodule is on a branch and in its superproject you run a
>> recursive checkout, the branch of the submodule is updated to what the
>> superproject checks out. This is very unexpected in the current model of
>> Git as e.g. 'submodule update' always detaches the submodule HEAD.
>>
>> Despite having plans to have submodule HEADS not detached in the future,
>> the current behavior is really bad as it doesn't match user expectations
>> and it is not checking for loss of commits (only to be recovered via the
>> reflog).
>
> I think the corrected behavior doesn't match user expectations,
> either.

Well, what is the user expectation?

>
> Could this patch include some documentation to help users know what to
> expect?

Sure, once we figured out what is reasonable.

>
>> Detach the HEAD unconditionally in the submodule when updating it.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> This is a resend of [1], which did not receive any attention.
>
> Yikes.  Yes, this bug looks problematic.  Thanks for working on it.
>
>> I improved the commit message laying out the current state of affairs,
>> arguing that any future plan should not weigh in as much as the current
>> possible data loss.
>
> Can you elaborate on what you mean about data loss?

Assume we have a submodule 'sub' inside the superproject 'super',
then

    git -C super/sub checkout <my-unrelated-branch>
    git -C super checkout <some-tree-ish>

modifies my-unrelated-branch in the submodule, which is not related
to the superproject in any way.

This patch would detach from that branch and have the HEAD contain
the desired sha1. To think that further we'd still have potential data loss:

    git -C super/sub checkout <my-unrelated-branch>
    git -C super checkout <some-tree-ish>
    # fine so far as sub is in detached HEAD, but:
     ... hack hack hack ... in 'sub'
    git -C super/sub commit -m "work"
    git -C super checkout <other-tree-ish>
    # subs work is only to be recovered via reflog!

However this matches the current behavior of
"submodule update" which also tips, that are
not reachable from any ref.

> At first glance
> it would seem to me that detaching HEAD could lead to data loss since
> there isn't a branch to keep track of the user's work.

yes, but that is the same with "submodule update", which is what
people may have in mind?

>  Are you saying
> the current behavior of updating whatever branch HEAD is on (which,
> don't get me wrong, is a wrong behavior that needs fixing) bypassed
> the reflog?

No, I am not saying that.
I am saying that updating an unrelated branch (which is dragged into
the affair just because HEAD points at it) is very subtle thing, as any
commits on that branch can be considered safe (it is on a branch, right?)
but the detached HEAD is the default unsafe mode we currently have.

Thanks,
Stefan
