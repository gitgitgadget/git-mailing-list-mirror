Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11A0E1F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 22:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbdAaWJ2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 17:09:28 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:34378 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbdAaWJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 17:09:27 -0500
Received: by mail-io0-f176.google.com with SMTP id l66so143144753ioi.1
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 14:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JM0kwo4rRM7eRxURr0dQtGOb4MSubKhSCCcmwmHsxT4=;
        b=k3NEY46V3d2hjohLI4oqXlKn/9r3TmA6/Q8ibvB4sMB5ktnvC8ykm4gipZ/xsqSliA
         Y1Bsibop7fzdqG7ILPEkWnm0eZn1UUUHLWioZdsL8GEg1ygkNhIJvfmUmyqMChz4yxuF
         3zDPnufppNuBGHTcuGzLphzOVBbHex5CKBsl/GZ4KEyf1YAZusPwpFnsjK9xb4gCifVr
         0a1EjyCrAEMoNidJiDH2WtJvR1kynPMWb7CpAvi27xjbHVISsfXu7pACqs7/vHCgKPo0
         HtOPax5h9dEHpxLmTGk40MWRAINLA3SxzJHgRCJ8VxmZXYnhIpjiac7wzuaH04ECf57u
         YKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JM0kwo4rRM7eRxURr0dQtGOb4MSubKhSCCcmwmHsxT4=;
        b=tY/+Pigdnpa8mixYiygWrZSbYYyq+XgfA/0oCHXMfGyRifOkAhyS9I5FWa0HMvdrS8
         b9DXwMkTc0OkGgnrQzjylAYQZTHKe6CALC3+1+UnSWU98WpYh3ipGbqppi7s3oMZ0wf7
         /34/gRSX+LAjm6VwD5AHw+pH+OHCZ5FrlKCHoWGJPLsy6bscf1rT2pqIiWFrxohrxBTz
         6xD66Dxgjx3TF96OY4Wnh8VH+HNXyx3AqTp47ntbq3RIs68lFX8LGdN2W39hIjOnV16f
         /c+8YhpxYR0Agmz0BGc4N+ijfPpde3WG15Qn/LCKWZOP8PAVNijCwdZueMzv2uS89gbJ
         t9QQ==
X-Gm-Message-State: AIkVDXJtgFctQwFIxgAzSE7rzRsiIZdFUbQPEx6zI1OMXcUkg4Q6H4qmdQe0sb9j1ndNBP9S9b+cU8ce37uW3uI7
X-Received: by 10.107.3.160 with SMTP id e32mr115019ioi.52.1485900521480; Tue,
 31 Jan 2017 14:08:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 31 Jan 2017 14:08:41 -0800 (PST)
In-Reply-To: <xmqqvasxwee1.fsf@gitster.mtv.corp.google.com>
References: <20170129203348.1a8c0722@hikaru> <xmqqvasxwee1.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 31 Jan 2017 14:08:41 -0800
Message-ID: <CAGZ79kbCfKVDq+9Pr5LmOtT=+uB+u+EMQg1=FUNS2umCvtvHhg@mail.gmail.com>
Subject: Re: git push failing when push.recurseSubmodules on-demand and git
 commit --amend was used in submodule.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Wood <carlo@alinoe.com>, Heiko Voigt <hvoigt@hvoigt.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 29, 2017 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Carlo Wood <carlo@alinoe.com> writes:
>
>> there seems to be a problem with using 'git commit --amend' in
>> git submodules when using 'git push --recurse-submodules=on-demand'
>> in the parent.
>>
>> The latter fails, saying "The following submodule paths contain changes
>> that can not be found on any remote:" for such submodule, even though
>> the submodule is clean, pushed and reports 'Everything up-to-date'
>> when trying to push it.
>>
>> I believe that the reason has to be that the parent repository thinks
>> that the comment that was amended, but not pushed, must be on the remote
>> too, while the whole point of amend is that this commit is not pushed.
>
> I am not super familiar with the actualy implementation of the
> codepaths involved in this, so CC'ed the folks who can help you
> better.
>
> I suspect the submodule folks would say it is working as intended,
> if \
>
>  - you made a commit in the submodule;
>  - recorded the resulting commit in the superproject;
>  - you amended the commit in the submodule; and then
>  - you did "push, while pushing out in the submodule as needed" from
>    the superproject.

Yes, for the current state of affairs, this is it.

>
> There are two commits in the submodule that are involved in the
> above scenario, and the first one before amending is needed by the
> other participants of the project in order for them to check out
> what you are trying to push in the superproject, because that is
> what the superproject's tree records.  You somehow need to make that
> commit available to them, but after you amended, the original commit
> may no longer be reachable from any branch in your submodule, so
> even if you (or the "on-demand" mechanism) pushed any and all
> branches out, that would not make the needed commit available to
> others.  If you push your top-level superproject out in such a
> situation, you would break others.

In the long term future, we may want to reject non-fastforward
submodule updates. (Not sure if that is feasible)

>
> I think you have two options.
>
>  1. If the amend was done to improve things in submodule but is not
>     quite ready, then get rid of that amended commit and restore the
>     branch in the submodule to the state before you amended, i.e.
>     the tip of the branch will become the same commit as the one
>     that is recorded in the superproject.  Then push the submodule
>     and the superproject out.  After that, move the submodule branch
>     to point at the amended commit (or record the amended commit as
>     a child of the commit you pushed out).
>
>  2. If the amend is good and ready to go, "git add" to update the
>     superproject to make that amended result the one that is needed
>     in the submodule.

yup.
