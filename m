Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B2921FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 22:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753822AbeARWJL (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 17:09:11 -0500
Received: from mail-yw0-f171.google.com ([209.85.161.171]:38855 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbeARWJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 17:09:09 -0500
Received: by mail-yw0-f171.google.com with SMTP id m84so12525146ywd.5
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 14:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CoiBDulxErWLxMvDd5dntDEG0o2OGZjulrTfLw1ymRA=;
        b=LpavaRvJIJOZHvk7oD4l/WRY8xl60+HeSXzXzzZ92qgz6CPGeiZncHKFN3dyMMNo0R
         ZMx/gyF4pqUhoEM1gNJxM26uc89Gbt3iWZDy5+rZg0Lw4uC/Z/QDlTFuxeoN8hfRUIwW
         wWB1KW3VDXMjcXH8otDwdp5iw9jxtFkEHl/8F7sjToiYYYfnwGWJraQMHH616wq/3XkO
         wvEEF+jIhKuComEg8WVW9meBAhIjgF3OdlUxjk4Rzt1sp7mtbHM/Lzp1KuKu/F63FshU
         sqt6ZdqYotMp86OHY9BdXftvohmRHfwj32/0gOPolhvBXct/bNYCoazrOSJxfy799PL9
         9KEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CoiBDulxErWLxMvDd5dntDEG0o2OGZjulrTfLw1ymRA=;
        b=sY8wZdEwUr/DCO5yFE0kDhtu0wWhdcIkpG7K0mDDeKpoXJML559Cx+Iqbe1/WObq+r
         XlxVDjHzQS79LGinMwBxMfDS6qul2DWEhOEJwfyd5m9TChKo/wD56I3L6yp0DmGuxNGG
         W/eno5x5KNpAPkp7TkmWeHTTHiNn8jnwI4vXshlzhyTi1ntKaYhjiuOiCHgpcwhUC0lp
         6sgezd/8jWemCRIkEBwvkQ7DVkukc6o9C8gq9C/G6J8XJUG/YHnJMSqgcTHkA68arNvU
         na7bX8ndytnU6vk3sNnokaaV9uAQbVgk3gVxkxBN85blyoczCOwVh5rArPP/qS+fMHhH
         5pdA==
X-Gm-Message-State: AKwxytdr1S3cGqsIiRiETgkajirSGL45H3BhpErZVtkIt0r+uCDphMnC
        6MZtTboSwDr7IsizitLgmloXYEgmj8Cra179zhSqYg==
X-Google-Smtp-Source: ACJfBosLD4DPAGma8LIeGUAyrIGV+CbFULnjLXLOxtc/Oo9+OSmk0P8G+c8nJGiG7N3165ddGBH96Qah2N4GQvQcUCc=
X-Received: by 10.129.122.73 with SMTP id v70mr7354677ywc.156.1516313348385;
 Thu, 18 Jan 2018 14:09:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.134.197 with HTTP; Thu, 18 Jan 2018 14:09:07 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801182254470.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <20180118183618.39853-1-sbeller@google.com> <20180118183618.39853-3-sbeller@google.com>
 <nycvar.QRO.7.76.6.1801182254470.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 Jan 2018 14:09:07 -0800
Message-ID: <CAGZ79kYn5cuuJ6YJSUcEBjpRHJU4fy+PQPB3haF-92cRO87dFQ@mail.gmail.com>
Subject: Re: [PATCH 10/8] [DO NOT APPLY, but improve?] rebase--interactive:
 introduce "stop" command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 2:00 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

>> +     TODO_STOP,
>
> I see that your original idea was "stop", but then you probably realized
> that there would be no good abbreviation for that, and changed your mind.
>
> Personally, I would have called it `break`...

I was looking at a synonym list of stop to find a word that contained a letter
which was not already taken. 'break' would allow for 'a', or 'k', assuming 'bud'
takes 'b' (or can that go to 'u'? Are there people out there with muscle memory
on these letters already?)

Any word (of stop, break, stay, control) sounds good to me, though 'break' might
be the clearest.

>
>> @@ -2407,6 +2415,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>>                               /* `current` will be incremented below */
>>                               todo_list->current = -1;
>>                       }
>> +             } else if (item->command == TODO_STOP) {
>> +                     todo_list->current = -1;
>
> That is incorrect, it will most likely write an unexpected `done` file.
>
> Did you mean `return 0` instead?

I guess. I did not compile or test the patch, I was merely writing down enough
to convey the idea, hopefully.

While talking about this idea of exploding the number of keywords,
maybe we can also have 'abort', which does the same as deleting all lines
(every time I want to abort I still get shivers if I just drop all
patches instead
of aborting, so maybe typing 'abort-and-restore' as the first thing in the file
would convey a safer feeling to users?)

Thanks for taking these additional considerations into mind while I don't
review the actual patches,

Stefan
