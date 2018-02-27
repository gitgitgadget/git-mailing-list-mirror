Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F00B11F404
	for <e@80x24.org>; Tue, 27 Feb 2018 05:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbeB0FaX (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 00:30:23 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37420 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbeB0FaX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 00:30:23 -0500
Received: by mail-wm0-f52.google.com with SMTP id 139so8184942wmn.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 21:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3mzfGpBMun8kPVMvLqJjpUeHLFDOpmnck5RHSmJ6cOk=;
        b=DWipBGqviA+/za04PZdoiyLtN6GmAu/qRGJmtsdGxXqd1bgJMnb3YqnWv+CwO2BOUk
         UTR9yurwDEC1P7eki8KRWnjy+A7JJAgnog+9lNBq8+iXoYovSmOzSYIKm6BgYQ0xlewo
         GVAJACRL2H+M+3rcqEFHxcJOP980mPlCUmbnmL70ReArWjbQd69xHteitQ0PkX8CqcNJ
         BnSenamu/vv3AfYNjMLZNpkrpV/msUBMHxkK7n1N56yijrhp8C8q0xQY/aW2FQQloyvt
         5+IenWhK/r5nilVOPXmt+Vn5KfouWMaoBUr2WIPzznr2Ifg8NDbqq1XX6mxYQKonSvQj
         hCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3mzfGpBMun8kPVMvLqJjpUeHLFDOpmnck5RHSmJ6cOk=;
        b=SC+tXy/Qkj6V8ByRk4NlBveJahCI2SO4XsU0Z38n++NO8vPhpHsCGh1U3S4xhPQ0Ls
         WN7HS6ucPw/w0BPmjwutxmipex2Tv6EcHA9ISVB2HwSsnproIwH5nO+4SwjYFFbH5MwA
         vWK3y5tZxJVOTwSisdrkrGEnBaiRYgOsYOWUeBaMDPUyyy9Zey3Cnlj9GStPCeYkAxvV
         JlYzwFfY5dc/uJ+gZjwhr/mjR2VJOr/VHnlpP0iPohUSv7wF4kPDyF7LseUySwMF2Rcs
         vlYsKZydnNt0n8zKQIBstTuuRftzrYrdDVhekRxuvFbFG9Qf4Eb1JBNMCovhJoglbl8x
         YvHw==
X-Gm-Message-State: APf1xPBbGpmGWEwmStsi45jbhqrZX94Zu8U0v+GcBbREcbazd7xPdR+2
        Lqv0eVLqL5Pa4T4ZmJBBktQHDcG3LUS/FmhGTzU=
X-Google-Smtp-Source: AG47ELtgwgoLmENCUKaCgItsTDfYTZBiZVursq+V3PuPSwGPgCS95cVVU+OoyZxhkSG0/aCWPnzzkrtuYHWvEh4viHk=
X-Received: by 10.80.149.68 with SMTP id v4mr9502944eda.236.1519709421756;
 Mon, 26 Feb 2018 21:30:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.139.133 with HTTP; Mon, 26 Feb 2018 21:30:01 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 26 Feb 2018 21:30:01 -0800
Message-ID: <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 4:07 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Buga,
>
> On Tue, 20 Feb 2018, Igor Djordjevic wrote:
>
>> I`m really interested in this topic, which seems to (try to) address the
>> only "bad feeling" I had with rebasing merges - being afraid of silently
>> losing amendments by actually trying to "replay" the merge (where
>> additional and possibly important context is missing), instead of really
>> "rebasing" it (somehow).
>
> If those amendments are what you are worried about, why not address them
> specifically?
>
> In other words, rather than performing the equivalent of
>
>         git show <merge>^! | git apply
>
> (which would of course completely ignore if the rewritten <merge>^2
> dropped a patch, amended a patch, or even added a new patch), what you
> really want is to figure out what changes the user made when merging, and
> what merge strategy was used to begin with.
>
> To see what I mean, look at the output of `git show 0fd90daba8`: it shows
> how conflicts were resolved. By necessity, this is more complicated than a
> simple diff: it is *not* as simple as taking a diff between two revisions
> and applying that diff to a third revision. There were (at least) three
> revisions involved in the original merge commit, and recreating that merge
> commit faithfully means to represent the essence of the merge commit
> faithfully enough to be able to replay it on a new set of at least three
> revisions.  That can be simplified to two-way diffs only in very, very
> special circumstances, and in all other cases this simplification will
> simply fall on its nose.
>
> If the proposed solution was to extend `git apply` to process combined
> diffs, I would agree that we're on to something. That is not the proposed
> solution, though.
>
> In short: while I am sympathetic to the desire to keep things simple,
> the idea to somehow side-step replaying the original merge seems to be
> *prone* to be flawed. Any system that cannot accommodate
> dropped/changed/added commits on either side of a merge is likely to be
> too limited to be useful.
>


The reason Sergey's solution works is because he cherry picks the
merge using each parent first, and then merges the result of those. So
each branch of the merge gets one, and then you merge the result of
those cherry-picks. This preservers amendments and changes properly,
and should result in a good solution.

I agree that making "git apply" work with combined diffs could also be
another solution, but it may be trickier.

If this *doesn't* work, a test case showing that it doesn't work would
be appreciated. I'm hoping to be able to put together something soon,
but I haven't had time due to $dayjob.

> Ciao,
> Johannes
