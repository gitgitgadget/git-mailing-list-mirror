Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90F081FC46
	for <e@80x24.org>; Thu,  9 Feb 2017 10:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbdBIK5Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 05:57:16 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36753 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752051AbdBIK5M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 05:57:12 -0500
Received: by mail-lf0-f46.google.com with SMTP id z134so99053634lff.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 02:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XNQqJpTROWcKh8TqNnQq2dsNC0fJDVeIGRcnayu5CRs=;
        b=HZI9DEfcUmHfXrRA0ZCkI9n1+vQHr223v3WBdO+d3wX18VGPfSHfhMRhtfeLmI4nIE
         pQfzodZuJtF+PEcSFXA37gTqQnK8EIMVfWbzwUaOwbEWVN17h8+/4aod1oG+4Mhg4PKC
         1QIFLC6oSsVoxfOIUoF0GgOJXyvbhO9Ok9e3w9saf6VKrU/InjKWlrohFgitJkV2xAV8
         +r0Abl8z06hzWnBptm6Mp3TjFqvImqpwY5Gx9u5uuLyCUhZ7kTOYs1dCEEDIrFd0ho9b
         ryvJU7BNdN7NgrvxiGsU+U7JNygwoCUt3D0+Pa2vzu0Cv7zL6GoYlHuEyAOBN1WphX5D
         b6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XNQqJpTROWcKh8TqNnQq2dsNC0fJDVeIGRcnayu5CRs=;
        b=ryaY48zctXaLFgJRSNOm+LUJoPVoFhuplJOYHevZr+L21ria07mJtPqQkUMbNKfCte
         BXve5o3Hi9bJpYXuwhY59Zyh6p781fALH5a31F3l+5BN6sIv+xBZOKp8nBbeCOhSbHoP
         D4S5rGt2A1MP4iV366V0sFhKLVL5azr13uCT4iS1bmshcfay//2S1GrPbXpVluJn//V/
         1iZnaJVg9UXwqJ6bWj6o35HfEtYOnoqZC0qO59YdnmpSdVQFbbbO4ZvJ8gxxf9hxOP+N
         SJXKfSdleh/m11A/m6YNTkSx8kgBXHUFbmRmd/wehEPrsFQg2z3hCWXYzvwtS3si05wx
         d6ZA==
X-Gm-Message-State: AMke39mWvFJPlaRH1cEujN43wXytyji/a7+kFZHWoFpxh5hRrp1+hIt19U6Up+b10tOzGItIYjUfYUecv7jXtw==
X-Received: by 10.25.25.8 with SMTP id 8mr888286lfz.164.1486637388637; Thu, 09
 Feb 2017 02:49:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Thu, 9 Feb 2017 02:49:48 -0800 (PST)
In-Reply-To: <CAN-3QhotVm-LmOJ4cuKCa2txYxFJMHY1aqbX1GznieQx57AR+A@mail.gmail.com>
References: <vpq1svtstud.fsf@anie.imag.fr> <20170125204504.ebw2sa4uokfwwfnt@sigill.intra.peff.net>
 <vpq37fowx5q.fsf@anie.imag.fr> <CAP8UFD3aygSf5U2abnpCfRzEf-hH5fSNuzFBBtgCjSQC3F8c5A@mail.gmail.com>
 <vpqzihvpt41.fsf@anie.imag.fr> <CAN-3QhotVm-LmOJ4cuKCa2txYxFJMHY1aqbX1GznieQx57AR+A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 9 Feb 2017 11:49:48 +0100
Message-ID: <CAP8UFD0BvN7y5uKb_saM8qu4jfyyQbrTYrg1r9HdkG=mq_MCVg@mail.gmail.com>
Subject: Re: GSoC 2017: application open, deadline = February 9, 2017
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 11:28 AM, Siddharth Kannan
<kannan.siddharth12@gmail.com> wrote:
> On 9 February 2017 at 15:45, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>>
>> A non-quoted but yet important part of my initial email was:
>>
>> | So, as much as possible, I'd like to avoid being an org admin this
>> | year. It's not a lot of work (much, much less than being a mentor!),
>> | but if I manage to get some time to work for Git, I'd rather do that
>> | on coding and reviewing this year.
>>
>> and for now, no one stepped in to admin.
>
> I would like to point everyone to this reply from Jeff King on the
> original post: [1]
> (In case this was lost in the midst of other emails) It sounds like
> Jeff King is okay
> with taking up the "admin" role.
>
>     I do not mind doing the administrative stuff.  But the real work is in
>     polishing up the ideas list and microprojects page. So I think the first
>     step, if people are interested in GSoC, is not just to say "yes, let's
>     do it", but to actually flesh out these pages:

Yeah it was also my impression based on the above that Peff would be
ok to take up the admin role.

Now if he doesn't want for some reason to take it, then I am ok with
us not applying, but again it would have been better to be clearer
about that before the eve of the deadline.
