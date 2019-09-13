Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798C61F463
	for <e@80x24.org>; Fri, 13 Sep 2019 22:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404128AbfIMWg1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 18:36:27 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:41394 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404041AbfIMWg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 18:36:27 -0400
Received: by mail-io1-f41.google.com with SMTP id r26so65923041ioh.8
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 15:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HmO2ryStEXDI6CJbduqI4baBGW+foteq0gcFfQQQIA=;
        b=X5iY9j/qotUP+egjPzYKT5JDEmkcLEM5u23q+jQbT4un5yj8bV8/AaDinMV8/s5Zcj
         mn6Q95Hx73qw1snRCa0q//YbwQRHfIwJkL0poHlmPbIU4SmIDqOICqVetwsfZsqds9ff
         +Ju/HOINJMg07DYFoX9WzrMysKZq65q1yFDzAT8WN6id7NFOZtPK53BFobpdiiMQye1a
         clpNdMtB5NKFlLgkPadZE0fZoywv8kjEXUD1ykgqVcqDNMKw7DMkMmQl2WAZbApx79eI
         o4EyV6gbrUs+tI7/Mje26v9cGc0UST1LXGtGbya3kDJfD7JHR1ddAPJ9sckxK6JOmftD
         V4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HmO2ryStEXDI6CJbduqI4baBGW+foteq0gcFfQQQIA=;
        b=kRgXkcMHYFpBsQDDK/FWTWRY0cQTq7cgkeaavIqRjEDTGNuAYvrupw0R6LW5kR1yZJ
         SPB8VYK/55S6qPN7D1u0Uqkf6Fy+TIrRemc1r8Uq5qjcpQDorUIml97uOsoCaEZhNvSO
         eGHvltm97k6DB93aZaD6AnckR1KimNwCn67F/7FqLOGN41m6Xw+DsL4yfjjVm6xlwFeD
         Dy2hzK/HQUlZP6Hz71oHWBEhGtL4MPVCsy297FI+tpabU3T3ycqf+M6SwwiVTvocOlax
         og+otJ32qY2u9m+C8Rc6L5D+PMjoZerk9qazdvFkPEfOpH2QhbT3f+z5LSEW1Jn0nMn8
         brTQ==
X-Gm-Message-State: APjAAAUEPnPz5M4u7Fzpfozb2/8Xs7wFkd9o61R84p2fVkBoHl1nx11F
        1U6GvJdvJW4xvSP70P077ahfxiymrX7bYpBU6ucD3w==
X-Google-Smtp-Source: APXvYqxF7t1HEBFKoSJiHTtFWvGKzJb6TkCtjTDx8LCQ7Hdcrjp+BwRKV5t8NV/rFaFNd60UwkRjC9sTwMMX9eryHJU=
X-Received: by 2002:a5d:96c5:: with SMTP id r5mr2533298iol.274.1568414186567;
 Fri, 13 Sep 2019 15:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499BT35jvPtsuD9gfJB0HJ=NxtzyQOaiD7-=sHJbFYhphpg@mail.gmail.com>
In-Reply-To: <CAHd499BT35jvPtsuD9gfJB0HJ=NxtzyQOaiD7-=sHJbFYhphpg@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 13 Sep 2019 15:36:15 -0700
Message-ID: <CAGyf7-F95A848hdM-CWPZvuvaSHF7p4qEftGoXMHNM5nyfDkeg@mail.gmail.com>
Subject: Re: diff.renames not working?
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 1:24 PM Robert Dailey <rcdailey.lists@gmail.com> wrote:
>
> 2. `diff -M` doesn't actually work either. It should, though. In fact,
> I expected it to work as `--follow` does. But it doesn't.

Just a small point of clarification: Is -M really what you mean here?
Given you indicated you have "diff.renames=copies", wouldn't you need
-C? -M only detects renames, not copies.

(I haven't looked too deeply into the rest, but this detail caught my eye.)

Best regards,
Bryan Turner


> 3. The `diff.renames` config doesn't seem to be working here, when it should.
>
> Can someone explain the behavior I'm seeing? I really am confused
> about all this...
>
> [1]: https://git-scm.com/docs/git-diff
