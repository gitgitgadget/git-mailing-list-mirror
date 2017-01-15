Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A12962079E
	for <e@80x24.org>; Sun, 15 Jan 2017 14:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbdAOOvO (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 09:51:14 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34542 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbdAOOvN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 09:51:13 -0500
Received: by mail-lf0-f53.google.com with SMTP id v186so66363256lfa.1
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 06:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jPJKmTiq2yKNxaKwHzeyFb2FksHOAelDRngeDuvr8Vs=;
        b=H2aa/z9pM/OBExzgqpP9FZlZMka+9Onq2+eBrQiMNAjUUcWQLEMUVt6dVZpvi22rB3
         QJFO/tAej7aZjq/DeHvi8sO/IlbzAMt86lR0LQSLGmGT1gayMAp2rlEch6vN8m2pFUl/
         Ir6tk8tF2uVifW3ji1o2IAuO8UOdIRJaGYP2WkT3DKrWnGbQ95HV0Z6M46cVioN8gJxS
         hTsbYdpvr3W4sZDPIPUx1na+muISBjrJf3hxvhSnItrmidLEVzjhj0Jay9VJGGMRJ5xe
         qw6tHTnDz/qiiciVld3NC9AWunKeDy59iLJQ35Jtj9oQTSsliqkcTIMDtaEyMEVemzWK
         +X/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jPJKmTiq2yKNxaKwHzeyFb2FksHOAelDRngeDuvr8Vs=;
        b=mENoPHcG6kmEGRSeJ7JWoHsr1Sr7WwmhJRZSctZi4RrvVW4VerHewFAqh4V7ofWVrO
         M0R/jr9K4xdjXPcrvoGl21EkKx49nkTjJLQBYRLDxE0hoQBef7RFyQzAp0F7tQT3uBXb
         jKsPSYhmXh6/noHXWSOKlyzb5K38TVvewoHPwcSnF7s2MFlPsnDnJU0/35kQ6SOKN2b+
         CeXe9cQLDW52FNHa5jFkvzTYul2y3GObkUJF9nbiIablZeks9IoeKAeXVAr7SlIdvE20
         51GZ/7YSOgflQ3fBHg4xqEEFN8uEtozsDKqngT8Tn6zbx2QIV7g9ss1sHIUPc6IF9t4C
         hYrg==
X-Gm-Message-State: AIkVDXJsMVImTjKAzVw3DjbC0jOK4BD6AGPhvs3BhYssjpoXvCK/UphjqDG+Z86m/bj2X2dTMLHTesnjx94t2Q==
X-Received: by 10.25.210.79 with SMTP id j76mr1712250lfg.129.1484491871652;
 Sun, 15 Jan 2017 06:51:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Sun, 15 Jan 2017 06:51:11 -0800 (PST)
In-Reply-To: <xmqqinpihiwz.fsf@gitster.mtv.corp.google.com>
References: <20170113144405.3963-1-chriscool@tuxfamily.org> <xmqqinpihiwz.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 15 Jan 2017 15:51:11 +0100
Message-ID: <CAP8UFD31Hb_4phoHPL51Rq0bfW3_xnL9LMosdH-0h=JX3Uwyvw@mail.gmail.com>
Subject: Re: [PATCH] Documentation/bisect: improve on (bad|new) and (good|bad)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Manuel Ullmann <ullman.alias@posteo.de>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2017 at 8:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> The following part of the description:
>>
>> git bisect (bad|new) [<rev>]
>> git bisect (good|old) [<rev>...]
>>
>> may be a bit confusing, as a reader may wonder if instead it should be:
>>
>> git bisect (bad|good) [<rev>]
>> git bisect (old|new) [<rev>...]
>>
>> Of course the difference between "[<rev>]" and "[<rev>...]" should hint
>> that there is a good reason for the way it is.
>>
>> But we can further clarify and complete the description by adding
>> "<term-new>" and "<term-old>" to the "bad|new" and "good|old"
>> alternatives.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  Documentation/git-bisect.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Thanks.  The patch looks good.
>
> A related tangent.
>
> Last night, I was trying to think if there is a fundamental reason
> why "bad/new/term-new" cannot take more than one <rev>s on the newer
> side of the bisection, and couldn't quite think of any before
> falling asleep.
>
> Currently we keep track of a single bisect/bad, while marking all the
> revs given as good previously as bisect/good-<SHA-1>.
>
> Because the next "bad" is typically chosen from the region of the
> commit DAG that is bounded by bad and good commits, i.e. "rev-list
> bisect/bad --not bisect/good-*", the current bisect/bad will always
> be an ancestor of all bad commits that used to be bisect/bad, and
> keeping previous bisect/bad as bisect/bad-<SHA-1> won't change the
> region of the commit DAG yet to be explored.
>
> As a reason why we need to use only a single bisect/bad, the above
> description is understandable.  But as a reason why we cannot have
> more than one, it is tautological.  It merely says "if we start from
> only one and dig history to find older culprit, we need only one
> bad".
>
> I fell asleep last night without thinking further than that.
>
> I think the answer to the question "why do we think we need a single
> bisect/bad?" is "because bisection is about assuming that there is
> only one commit that flips the tree state from 'old' to 'new' and
> finding that single commit".  That would mean that even if we had
> bisect/bad-A and bisect/bad-B, e.g.
>
>                           o---o---o---bad-A
>                          /
>     -----Good---o---o---o
>                          \
>                           o---o---o---bad-B
>
>
> where 'o' are all commits whose goodness is not yet known, because
> bisection is valid only when we are hunting for a single commit that
> flips the state from good to bad, that commit MUST be at or before
> the merge base of bad-A and bad-B.  So even if we allowed
>
>         $ git bisect bad bad-A bad-B
>
> on the command line, we won't have to set bisect/bad-A and
> bisect/bad-B.  We only need a single bisect/bad that points at the
> merge base of these two.
>
> But what if bad-A and bad-B have more than one merge bases?  We
> won't know which side the badness came from.
>
>                           o---o---o---bad-A
>                          /     \ /
>     -----Good---o---o---o       /
>                          \     / \
>                           o---o---o---bad-B
>
> Being able to bisect the region of DAG bound by "^Good bad-A bad-B"
> may have value in such a case.  I dunno.

I agree that there could be improvements in this area. Though from my
experience with special cases, like when a good commit is not an
ancestor of the bad commit (where there are probably bugs still
lurking), I think it could be tricky to implement correctly in all
cases, and it could make it even more difficult, than it sometimes
already is, to explain the resulting behavior to users.
