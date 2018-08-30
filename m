Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88ED51F404
	for <e@80x24.org>; Thu, 30 Aug 2018 14:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeH3Syi (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 14:54:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34979 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbeH3Syi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 14:54:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so6758098edq.2
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+tvROwLL+DacYTYALACtun1H7XYZ46NKStyXKHRnQsg=;
        b=RWBtCYMKEZzTxbWKlULYwjseWCjuRd3+v1dJKt638Zu2R3yc5yGj4OWQPaM4uZ2n0d
         m5IN9AjGhPGKd/q0n5YLK+lVo7tSTL1Xbxeq/F1HrA2hSlKuxtCXtOV86eFe9vlqPG94
         VYu3iOWibdan9OCUubo08Vtq3YtzJrVT2uQchk9DQThBu1yFKvUoUEMP7Q5O94ibRS3f
         sdIc8WAnys1LrG6lZ2kEBc68jUOciL6IwhgW9TMZDanC89ityB/mj5JLNM9CnkSgMr5C
         M3v63vBNEJi5Tw9tvB25LuH5BudykovsoFzsd8Oc7OZgHxQBerKlC55o63X5i/wvCkmK
         z9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+tvROwLL+DacYTYALACtun1H7XYZ46NKStyXKHRnQsg=;
        b=qVn0hGzTDctxwSi1D0ZHmLgkaUgOnl4+aMbNULRZXVmerTDdQc8UbWT6V3/Rs5Jk0h
         EKTW8UYDK2XgUv2hC9eQTdQFWf1pJi4GB8Pvyd3gjA2KX79jjyM0BrR7v8hjN2lDGX5i
         SjeZVtfg5W5a++14ztMo5qOxl9AnNxItHQvAKwKlGBHibPA1MT9aLRBpp9y9wLz9kSd/
         FttCB4RgnHZCOrIlpeW0D8F34K9d4Z8dagiBuGRHP75Sh/SX/hihCBrSz0cAGUI9d3YF
         KFgDg4fJl7GulifaVrl5A8mlXQhLsp4qQ/JjXIKJlDhLxlAOgUuqgyvYFctRWK0AMC0m
         IXTg==
X-Gm-Message-State: APzg51B2xX2V9TP0ibj8ivXd9lCb70Cs+jS0dW+rgscxITkGaoPtzuIy
        Kd612MOssZ3Hfa+h/c7UP5Q=
X-Google-Smtp-Source: ANB0VdbBoMD2WBYQnH1tHoYP1XV2uux5cdPAhCUpRvSMUQutQ9qmKkPdyrDLyN/5dSgBchMApwhFTA==
X-Received: by 2002:a50:8b65:: with SMTP id l92-v6mr13403262edl.44.1535640725474;
        Thu, 30 Aug 2018 07:52:05 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id x48-v6sm3772230edm.18.2018.08.30.07.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 07:52:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2 06/10] push doc: correct lies about how push refspecs work
References: <20180429202100.32353-1-avarab@gmail.com> <20180731130718.25222-7-avarab@gmail.com> <xmqq8t5rcnhg.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqq8t5rcnhg.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 30 Aug 2018 16:52:03 +0200
Message-ID: <87o9djdi0c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 31 2018, Junio C Hamano wrote:

I'm finally getting to re-rolling this. Just some inline comments.

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>>  The <src> is often the name of the branch you would want to push, but
>> -it can be any arbitrary "SHA-1 expression", such as `master~4` or
>> -`HEAD` (see linkgit:gitrevisions[7]).
>> +it can be any arbitrary expression to a commit, such as `master~4` or
>> +`HEAD` (see linkgit:gitrevisions[7]). It can also refer to tag
>> +objects, trees or blobs if the <dst> is outside of `refs/heads/*`.
>
> "It can also refer to..." is a good addition, but do you really want
> to make it part of this series to change/deprecate "SHA-1 expression"
> (which would certainly involve discussion on "then what to call them
> instead, now we are trying to refrain from saying SHA-1?")?

I won't change that.

>> +on the remote side. Whether this is allowed depends on where in
>> +`refs/*` the <dst> reference lives. The `refs/heads/*` namespace will
>> +only accept commit objects, and then only they can be
>> +fast-forwarded. The `refs/tags/*` namespace will accept any kind of
>> +object, and any changes to them and others types of objects will be
>> +rejected. Finally, it's possible to push any type of object to any
>> +namespace outside of `refs/{tags,heads}/*`,
>
> All sound correct.
>
>> but these will be treated
>> +as branches for the purposes of whether `--force` is required, even in
>> +the case where a tag object is pushed.
>
> I am not sure what "will be treated as branches" exactly means.
> Does it mean "as if they were in refs/heads/* hierarchy?"  Or
> something else?

I'll clarify this. Have rewritten most of this.

>> That tag object will be
>> +overwritten by another tag object (or commit!) without `--force` if
>> +the new tag happens to point to a commit that's a fast-forward of the
>> +commit it replaces.
>
> Yup, and that is something we want to fix with a later part of this
> series.
>

For what it's worth this is not at all what I'm fixing. The new docs
describe this better, but what I'm talking about here is that you can
push a tag like git.git's v2.18.0 to refs/blah/my-tag, then you can push
v2.19.0-rc0^{} to refs/blah/my-tag and it'll be allowed as a
fast-forward, and then v2.19.0-rc1 etc.

I.e. the non-refs/{tags,heads}/* update logic treats all updates to
tags/commits as branch updates. We just look at the tag v2.18.0, see you
want to replace it with the commit v2.19.0-rc0^{} and see "oh, that's a
fast-forward".

Arguably that should be changed, but I won't do that in this series.

>> +By having the optional leading `+` to a refspec (or using `--force`
>> +command line option) you can tell Git to update the <dst> ref even if
>> +it is not allowed by its respective namespace clobbering rules (e.g.,
>> +it is not a fast-forward. in the case of `refs/heads/*` updates).
>
> This gives an impression that with "--force" you can put non-commit
> inside refs/heads/* hierarchy.  Is that correct (if so we probably
> would want to fix that behaviour)?

I'll fix the wording, but nope, luckily you can't do that.

>> +This
>> +does *not* attempt to merge <src> into <dst>.  See EXAMPLES below for
>> +details.
>
> That is not wrong per-se, but would normal people expect a merge to
> happen upon pushing on the other side, I wonder?
>
> Thanks for cleaning up our longstanding mess.

Will fix/reword.
