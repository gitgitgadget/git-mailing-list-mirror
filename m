Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B50431F855
	for <e@80x24.org>; Thu,  4 Aug 2016 23:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934718AbcHDX3f (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 19:29:35 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36782 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934670AbcHDX3e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 19:29:34 -0400
Received: by mail-vk0-f50.google.com with SMTP id n129so179211464vke.3
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 16:29:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/x5QXE+q3edN34rJ7XVn1rXQEyVdJhvEn5Xeg4+Cniw=;
        b=EI16GdnICtUOIFj3TjRJphwEa32wMhlv8tWTn0ycuyT9VEaAJa2XipuMufpDJvalwm
         UQ3zjMeY4xGv27eIvHpF90X4K+udt9yTRngRlq6F0RHCftm0a8GDz9NAflOPstxWYc60
         VDNt1sn2h90D391rTIh05Gc4I5CIHbW9ddaWHfu6OdObP5vBoF1Y7uwe/j1CSQa/Y7Wf
         xyjeMEc2eP7YZOKGzUH5Xu77+qkaAFodpPOfpVAxX4nPU9eBz24d5Pd3UWGEdXXY7Nf4
         3fgKNxwTiZH5eoVS7Aba5cJZj3JtEaPSwiyaCNXXNIp+jAggf/6V36/9KlgH31sZVC6d
         7CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/x5QXE+q3edN34rJ7XVn1rXQEyVdJhvEn5Xeg4+Cniw=;
        b=ZWDsTGypj71kLKiqkKHg5wUJrWAxFQ1VPpIxF77dgYYDtXRCkBG976wGMfqOz6YfAG
         ufqWBL9MaaIp9ios2cBorJ4V/f7W5yVYpAwEgwQUzH3nY8IQMp+A7vyCMpisumKcwUfX
         h4co/+1ixAXZ7X25+UEhLId47lcL7t9yVm3hpgJR2MaO2q6+a1aBJ4FfRwP8sJN3rHyv
         BI+0IdYDThsmALm3UOj17dsQMobFmeQ0oK1DwbrN3BdPqHSz8T8SAAOHdQTV5MFWA3ce
         +6fRzehRp+e58tM9McJcjNXyiqXw2d0KM5CX0mPZXnWnJX0LrbbnmQ8UHFLHo6GNfTkA
         RqHg==
X-Gm-Message-State: AEkoousQVpeWCf+nWk5gCdYOFc12FQEiIAwOGjiahTgdBrMpLZ8Sxyr6/8HrNyauRkSRstqSiPhqHVCUWlr9aQ==
X-Received: by 10.31.169.148 with SMTP id s142mr34620979vke.39.1470353373764;
 Thu, 04 Aug 2016 16:29:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.10.69 with HTTP; Thu, 4 Aug 2016 16:29:32 -0700 (PDT)
In-Reply-To: <xmqqinvidgyo.fsf@gitster.mtv.corp.google.com>
References: <CABEd3j8VLbpeWbA6BfHYp5aLPEy0PesqYoHM9u4OM=b7Qm=LDg@mail.gmail.com>
 <xmqqinvonwxc.fsf@gitster.mtv.corp.google.com> <CABEd3j-MW--YSC9=nwcgHzxd6cqmUY+ky3-wLxMiMmbBGsvS7Q@mail.gmail.com>
 <CABEd3j--sxCwv6fWmNxTtdpgwU0_YKbfiFONX6TsQFZGn79yuQ@mail.gmail.com>
 <CAP8UFD118RdB5dX2-wEm5VnKud7sirHhdC9kvWmXV0eAQHvfsA@mail.gmail.com>
 <xmqq7fc0jmhx.fsf@gitster.mtv.corp.google.com> <CAP8UFD315CgntwYiC9g-R7KN0XiL9635Vwv_y8yi4n-uj8o90A@mail.gmail.com>
 <xmqqwpk0f5jr.fsf@gitster.mtv.corp.google.com> <CABEd3j_6DNgs1u5AdkkzWt7U=J2fZ4a-2jewVjkfExt0KPvWiQ@mail.gmail.com>
 <xmqqinvidgyo.fsf@gitster.mtv.corp.google.com>
From:	Oleg Taranenko <olegtaranenko@gmail.com>
Date:	Fri, 5 Aug 2016 01:29:32 +0200
Message-ID: <CABEd3j9J-fULWygXnSR0oY9g_m0vWukjAE4aeb6QmiQ1u5FOyw@mail.gmail.com>
Subject: Re: git bisect for reachable commits only
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 2, 2016 at 11:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Oleg Taranenko <olegtaranenko@gmail.com> writes:
>
>> First, assuming the common ancestor is GOOD based on the fact that
>> some descendant given as GOOD is pretty bad idea.
>
> What you claim is fundamentally incompatible with the way "bisect"
> works as a O(log(n)) operation.  It is likely that your definition
> of Good for the purpose of your bug-hunting needs to be rethought if
> you want to take advantage of "bisect".

Without context it sounds a bit silly, agree. Context was, maybe not
explicit stated, based on previous discussion:

If we looking in direct path G..B, of course bisect should show its
power O(log(n));
BUT, assuming that any predecessor (G~1/G~2...)...is good if this
commit G~n has direct path to B,  but not via G, (as git does now) is
wrong.
This is my concern. Ever G~1 may have not feature we are looking for,
then we must treated it as BAD in current git bisect session. To be
sure we require additional evidence and just opening a new bisect
roundrips in case G~n is GOOD.
If G~n confirmed as BAD, we need to stop looking in this path (no need
to find transition BAG -> BAD) and switch to another possible common
ancestor (or next octopus parent)
In merge-based development (opposite to rebased one) this can happen very easy


>> I have another request to get git bisect more user-friendly, regarding
>> rolling back last step or steps, if accidentally 'git bisect bad' or
>> 'good' was wrong entered, but I think it worth for another thread.
>
> Are you aware that you can check $GIT_DIR/BISECT_LOG and replay it
> to recreate any previous state of the bisection?  That would
> probably help.

git bisect log / replay is not convenient. First we need to find place
where to keep log file (not forget its name), then edit it. If I'm not
sure how many steps I did a mistake the troubles doubles,
What are obstacles to implement git bisect back ?
or git bisect back --steps=2
I don't think it will be significant change in code.

It would be a great help especially if hunting in multiply logically
loose-coupled repos. Say searching bug in application, possible caused
elusive changes on several dependent libraries.
