Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 864A5215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 21:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755235AbeD3Vjd (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 17:39:33 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:53975 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeD3Vjc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 17:39:32 -0400
Received: by mail-it0-f42.google.com with SMTP id f65-v6so7635211itd.3
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eiuVacIvv/iN/8q5T2WJVXqb+JM91dEIhMs0rPrVDG0=;
        b=No6XhNMkscCMkn7PAkpOYiUcZnJXWvkUpra9wl6t6xB/kaOitrwq6snOXxJk6lNhN3
         E8eNmZwyYYv6PqQOINhTahV2nGojAlx5vNG6V3r0XxDMiy0tMIPWN6CzJcG1IJcOnSzR
         vQFIeT5xuaxk6mJH/3Sf0YVUKap1W32QquRJsiqXBqUwwJmDeFWAp78xTalGh944LvRb
         zbmtyQqnFJBn3cQy0GAkiJ6EtcZDW//CHOQHM9YQm1HHvG42bvZlxOFLJ5Ce8Hrwnegv
         JNLq1NZsjBcPHfZFPiyle5WUGoxwB0jc+dmmmEnVTrDcyzs72JLvvr9LsGt3VSjR5Jkx
         VXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eiuVacIvv/iN/8q5T2WJVXqb+JM91dEIhMs0rPrVDG0=;
        b=TLWGK8bfy8GpsMePraqRQla0vgYFyolKrb8cFhePJ/zjuejN2bbRIHZQfL/QvRmS/i
         5B1iF+g97WcsfRKG8KH0SzkygqC2iZqO7lT+CAgbjLD4FekjmNnpcGmcYDsrpHW/f5Yg
         Hkl7pDtUCeDBGCd7XCi3rVrgdo94gx2evDOu3G0JQyXVfeQ9dZ5TBPgxlGuRIMLHpvzv
         K0lfhHj3JAWCHnnelM7MnEUmLFV9rDmp8S9eobpE77O/SFPtAkzteBB91pq80ZOGRxUy
         4QpEzyfNspGPTkTDwuSdHPyeUyStOZ4fxdVsjSvH2S9f3U9FfV7Hjd+V5J4k1VgFYWm2
         q9RQ==
X-Gm-Message-State: ALQs6tC176aERZidPHLAIoFUzuoMRXtE/nTr/wA5bN3n5AO2twdykzIw
        noYb1nIoPon9wYRhRSzH4W1vT03jFe3qMtpxsW4=
X-Google-Smtp-Source: AB8JxZpscu0P+HC/86cUOyDlZGds7C2hhwfBP4Mwoju0b6GU19yH1ssrZTa8mUny31JSL8s5lMzjnu/KvBnqxixUAfU=
X-Received: by 2002:a24:5fca:: with SMTP id r193-v6mr12754666itb.89.1525124371731;
 Mon, 30 Apr 2018 14:39:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:7c91:0:0:0:0:0 with HTTP; Mon, 30 Apr 2018 14:39:31
 -0700 (PDT)
In-Reply-To: <CAGZ79kZQ3ce8QTJy2Siiuoz=pa6qWweNc8GTpoygkvKuoFXaAA@mail.gmail.com>
References: <CAEp-SHXo2fnyUSMDqJnfOkh_R21R2FjFUtQ14u9s6-tV039tHg@mail.gmail.com>
 <CAGZ79kZQ3ce8QTJy2Siiuoz=pa6qWweNc8GTpoygkvKuoFXaAA@mail.gmail.com>
From:   Casey Fitzpatrick <kcghost@gmail.com>
Date:   Mon, 30 Apr 2018 17:39:31 -0400
Message-ID: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
Subject: Re: git-submodule is missing --dissociate option
To:     Stefan Beller <sbeller@google.com>, avarab@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sure, I'll take a crack at it and submit a patch.

On Mon, Apr 30, 2018 at 2:19 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Apr 30, 2018 at 1:29 AM, Casey Fitzpatrick <kcghost@gmail.com> wrote:
>> This seems to be a hole in the git feature set. I believe it is fairly
>> easily worked around, but it would be best to provide the option for
>> ease of use (and maybe performance?).
>>
>> git clone has both a --reference feature and a --dissociate option,
>> with dissociate allowing for a reference to *only* speed up network
>> transfers rather than have the resulting clone rely upon the reference
>> always being there (creates an independent repo).
>
> With the advent of git-worktree, I claim that --reference without further
> --dissociate is dangerous, such that the combination of these two are
> not the best UX, you could wish for.
>
>> But git submodule only allows for --reference, so there isn't a an
>> option to make a speedy independent submodule clone in one shot:
>> https://git-scm.com/docs/git-submodule
>> I checked the latest online documentation (currently at 2.16.3) and
>> the documentation in the latest sources (almost 2.18):
>> https://github.com/git/git/blob/next/Documentation/git-submodule.txt
>>
>> As far as I am aware this can be worked around with 'git repack -a'
>> and manual removal of the objects/info/alternates file afterward.
>> Though I don't know if this results in a less speedy clone than
>> dissociate would.
>
> That is an interesting workaround!
> I agree we should have the --dissociate option available for submodules.
> Care to implement it?
>
> Thanks,
> Stefan
