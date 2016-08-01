Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93F161F855
	for <e@80x24.org>; Mon,  1 Aug 2016 20:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbcHAUhT (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 16:37:19 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36249 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbcHAUhP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 16:37:15 -0400
Received: by mail-wm0-f48.google.com with SMTP id q128so384304150wma.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 13:36:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RG4Nk9c5WdejU+4suU0z9UUBDpym9b86aaFHFebejKg=;
        b=cb7bIh54HA8tYu+JgyEPV9eEqThiHiM13FKpuUhRjJIGCtr4V21fPS1EGYUbEmCjMd
         X0hw3TsZOVhNTCaouDxCXZECm/iDqub5JMdnZoZTT12ui7RXKUOQ7tYcamYA91MyRPm+
         bODvmM4RM/yRq+dQQwAp50DZLyaa4mDj78m7WmM5sACLnoPvYuR0MzcMdDDcgmIa/nQ/
         Bi6/pJTO2iSHAIpJyuNY1CEYoy+Wgc3SRCbg87uiEB2vJPLLcD4rqGOgM/n1q4xuGV04
         sOMPMeVPSBb2r3hlRltwfi4bpG5XlrAqutWSJ37rl6bH3Dn44QLqnzoa4K0TJSjjUM22
         izHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RG4Nk9c5WdejU+4suU0z9UUBDpym9b86aaFHFebejKg=;
        b=XRWYIdE4YB/ULay5U2dSPeTKaEW0Wb3Xh85ci9yq4i/9E48ZLz7Wp+hLdzsrXcNoeU
         /UcMCRNFSRhJFoPFht0NgOhvgyMjNmwNIHMSmrfaWJ3IIsgDWUKZTYEKdjKakBICDxJJ
         XTNq4Mdcw6RFY2sFq2B2HBzAWW2Xo8SfIpghuBsPyrNIY9AxPOF90FtyR3RGWnEhpz8m
         vUkQ75jonyV4f/qOrTWqWYcUEXbJ2eLdn1lQLp8YkXYvxdzr1UCipGwRtZpoX5tM0P0J
         qFNuPzv/wryBSKwMB4eeUsUUloUi48FJQVYA932pN+4PLtjxrJbyz0J56gpo3FJC/FTn
         pMoQ==
X-Gm-Message-State: AEkooutC7E7P8emIphL2jzK+dyKvWcjxaSJ90P+cH5ZvKpZiqVwKH+3uKt2wctcqlWaZZtp8dZ0dLj1QPTt3OA==
X-Received: by 10.194.87.101 with SMTP id w5mr57413923wjz.94.1470083767576;
 Mon, 01 Aug 2016 13:36:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Mon, 1 Aug 2016 13:36:06 -0700 (PDT)
In-Reply-To: <xmqq7fc0jmhx.fsf@gitster.mtv.corp.google.com>
References: <CABEd3j8VLbpeWbA6BfHYp5aLPEy0PesqYoHM9u4OM=b7Qm=LDg@mail.gmail.com>
 <xmqqinvonwxc.fsf@gitster.mtv.corp.google.com> <CABEd3j-MW--YSC9=nwcgHzxd6cqmUY+ky3-wLxMiMmbBGsvS7Q@mail.gmail.com>
 <CABEd3j--sxCwv6fWmNxTtdpgwU0_YKbfiFONX6TsQFZGn79yuQ@mail.gmail.com>
 <CAP8UFD118RdB5dX2-wEm5VnKud7sirHhdC9kvWmXV0eAQHvfsA@mail.gmail.com> <xmqq7fc0jmhx.fsf@gitster.mtv.corp.google.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Mon, 1 Aug 2016 22:36:06 +0200
Message-ID: <CAP8UFD315CgntwYiC9g-R7KN0XiL9635Vwv_y8yi4n-uj8o90A@mail.gmail.com>
Subject: Re: git bisect for reachable commits only
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Oleg Taranenko <olegtaranenko@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 1, 2016 at 9:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Yes, and the reason is that all the ancestors of a good commit are
>> considered good.
>> That's because git bisect supposes that there is only one transition
>> from good to bad.
>> Otherwise we would need a more complex algorithm to find all the
>> transitions from good to bad, and that is not generally needed.
>
> It may be debatable if that is generally needed or not, but by
> definition "bisect" is about having a history that has a SINGLE
> point that changes from good to bad (or old to new, or "have sugar"
> to "no sugar"), and that single-ness is what allows us to BIsect the
> graph.  So even if it may be a good thing to have to be able to find
> multiple transitions, that is outside the scope of how the current
> "git bisect" was designed to be used.

Yeah, this is a better version of what I wanted to say.

>> I haven't looked at your previous issue much, sorry I have been busy these days.
>
> I think the "previous issue" was that we can ask the user to ask to
> check one of 'x' or 'y' when given Good and Bad points in a graph like
> this:
>
>         x---y---y---o---B
>          \         /
>           x---G---o
>
> while a more natural expectation by a user would be that we only
> need to check one of these two 'o'.

Yeah, I reproduced the steps described in the Google Groups discussion:

https://groups.google.com/forum/#!topic/git-users/v3__t42qbKE

and I think that is indeed the "previous issue".

> Thinking about it again, I actually think it makes sense to ask the
> user to check 'y'; there is no good reason to believe that 'y' can
> never have introduced the badness we are hunting for, and limiting
> the search to --ancestry-path (which is to ask only for 'o') would
> stop at the merge 'o' if one of the 'y' were bad, which would
> prevents us from knowing the exact breakage.

I agree.

> There however is no excuse if we asked to check 'x', though.  They
> are ancestors of a Good commit, and "git bisect" should be able to
> assume they are Good.

I think it does. When I reproduced the steps in the "previous issue",
it did assume they are good.
