Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52EB820756
	for <e@80x24.org>; Fri, 13 Jan 2017 20:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbdAMUKm (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 15:10:42 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:33936 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbdAMUKl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 15:10:41 -0500
Received: by mail-io0-f178.google.com with SMTP id l66so52018016ioi.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 12:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GLZjl3nSxGNICcU3SSF6bDjUuk44gTJVw5h7Fh6mhlw=;
        b=NtKBQDj5Yk+BES6niAub13QsT9sY3h84t3i0YaQkViWGgaeZ7KZhqLCGd/ZuJBSWzC
         Wnj61vBfn4QV+sQA1TtRiY/ssc8evKHonwz0tfH59GvNxMpC4yt9zsgl32GxUsovo7BB
         eKAKAejhL4ombAKu/OIobUsC1BxI9mp1YMYawYQ8J51/nsG1QkOB0mrzGAi62toXpE+x
         XZNw4l90+0UU5E4WpbBdCfr/Dxi1BSkY6g8Yc9xsp2qSD1l69BiyCim0o+wsS2/SoVf8
         sOzFxuBR1ZwXS38PnmDzq3IwYTaiHfZi1yPN2B9mlUhsqWkXFs43G7hEq8/gojfnglwX
         3quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GLZjl3nSxGNICcU3SSF6bDjUuk44gTJVw5h7Fh6mhlw=;
        b=lZ6+PX0LSxHtc1dSYT9AgfmcOt7Cv9b8okheVxJWxdSCHKNh+HC7ku0CGKAvdwgMwJ
         mA4jtgFNKLUOqbDaeKLlz22kPMJrJV8zpP0PmA9GvEnv4cub6bG0qtQE8hM/8k2yTSJ8
         lrhrmkjzQde+zEu5XQP0GkH9FhllXl6kXs8TWkukqHXG028s0aikPsXkFU0vJ4keZqRh
         q/A9qfp+XedUQMU9y/UTs6P+hAJaxhnr6h+YUCKGcZhDrJJ5+aabE1qeu7mvgxM921LR
         HAkC4nRJ4cXmzVPuwmCMZNKzbxi1hFHJ3/waJxBq/It6OWXVksIr0Tpq/jeHRvA5gGT0
         0Q/w==
X-Gm-Message-State: AIkVDXLTSxXU1tAJcS50tcgcc70V3FbzQFIUEiPL3hAK8z3/SHgTzA5y700K4NRI8T0HHFNlGao7ZliyFYBVTUnk
X-Received: by 10.107.3.160 with SMTP id e32mr20174459ioi.52.1484337678464;
 Fri, 13 Jan 2017 12:01:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Fri, 13 Jan 2017 12:01:18 -0800 (PST)
In-Reply-To: <xmqqa8auhgzt.fsf@gitster.mtv.corp.google.com>
References: <20170111184732.26416-1-sbeller@google.com> <xmqqtw92hkgc.fsf@gitster.mtv.corp.google.com>
 <xmqqa8auhgzt.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 13 Jan 2017 12:01:18 -0800
Message-ID: <CAGZ79kayLoH7EURQ9aKGh+FzDz_BegJRjB2175qo53beLZDYog@mail.gmail.com>
Subject: Re: [PATCH] lib-submodule-update.sh: drop unneeded shell
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2017 at 11:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> In modern Git we prefer "git -C <cmd" over "(cd <somewhere && git <cmd>)"
>>> as it doesn't need an extra shell.
>>
>> There is a matching '>' missing.  The description is correct (I am
>> not sure if there actually is "preference", though), but I found the
>> title a bit misleading....
>
> It turns out that there were two missing '>' ;-)  It tentatively has
> become like this in my tree.

Thanks for fixing up locally. I had resent as
"[PATCH] lib-submodule-update.sh: reduce use of subshell by using git -C <dir>"
but you can ignore that now.

Thank,
Stefan
