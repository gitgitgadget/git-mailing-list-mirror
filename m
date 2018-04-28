Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B671F404
	for <e@80x24.org>; Sat, 28 Apr 2018 07:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeD1H04 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 03:26:56 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:54016 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753203AbeD1H0m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 03:26:42 -0400
Received: by mail-wm0-f53.google.com with SMTP id 66so5729612wmd.3
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 00:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kFh6vm8o6Oa6FFn4tWloCU9cqvxxEhq8IL8uaeidICU=;
        b=dz9gOvOtTr8va6R5XZ50qAl9hbkrkTNH9+U+8/DAyzEvnhgZukCK4TQ82d2LmMN5Xt
         bHBMir/IBuQo9TnTFeTPckqsYucWccFcg0zrPbxTBeJstvUy3/iToKy/YOq8BW487M/L
         dF/4exXD5upJaOR/ZE1aNBY6ra1U7QnvnFig5KVM/MES844A+Hk/drA0cWbC6RajqK7D
         7+RBxtlnWzaaTIQZylgAmQG9jVxAt/tkPAG2Gpa+vBuwCmc1YsxiTS5hioofApc8qTbJ
         m+WtTOlcdgm2Qjav7F1P0Nl82kFGA0t2Lo7Hk97GImRwdDnzOdVJdvC5LRzLNRQN5XAB
         LgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kFh6vm8o6Oa6FFn4tWloCU9cqvxxEhq8IL8uaeidICU=;
        b=notjy/2C8ZWuFkAtDMSIRD/4se33KrAF3spE3/NPe1kQC2CQKKjES6CCYU/8QYtbwt
         mTKUhQUENSbvDdbAtCjQmX6h1cZkEVgiiH36AL+8FA2skRlZ4vnUXqpnmDxl1XasX8Pe
         BQ1Cial0YkCWkcoY6j77l0ddPOdpalAEuY3PH6whOcv3nyprr7Ygw5owVqGjAaI2vxjZ
         DGQntofR9OqO05qOHbRkujqkjwsldMY/Dzv6a/UQZcQ3LZc7ih4x24P7Z3lVTATcKZQa
         94riGW310EXhwLwMAm3tOYj4rdJkZGQtcFO4gUlGDe0Wx9awhuk7prk6y9n73AHbwTiC
         csDw==
X-Gm-Message-State: ALQs6tCgAdxcgdLr6H9eioyYC45BVJf1OF2RtUKym4zvZwrDDdXtmBfW
        453MyU40RyO6f/S2Uu5QucZilL3Pl8iIfze4UBk=
X-Google-Smtp-Source: AB8JxZoX4B5ib9/YWw9fChIwxmhBtrM7dD/azvrAIea2A1jGzNDMPa0OMk4g+HwEwJklVR4CFUMNOn4gwBqg8g9DD44=
X-Received: by 2002:a50:d002:: with SMTP id j2-v6mr6976336edf.44.1524900400935;
 Sat, 28 Apr 2018 00:26:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Sat, 28 Apr 2018 00:26:20 -0700 (PDT)
In-Reply-To: <CAKk8isqAd11W4DpjNkd9AeMDGi=ESyhVSFXcvwteasTfHMPGLA@mail.gmail.com>
References: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
 <xmqqzi1s3y5h.fsf@gitster-ct.c.googlers.com> <CAKk8isr-7bSVqEv8EjF2UgFfw75D2oVZPJFui30pbY6kWfeL_Q@mail.gmail.com>
 <CAKk8ispWBoG7D+u8x+s+iB+wzXUN=7vpxgmz5wjL67P6XUmw9g@mail.gmail.com>
 <xmqqfu3h1t22.fsf@gitster-ct.c.googlers.com> <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
 <CAKk8isqAd11W4DpjNkd9AeMDGi=ESyhVSFXcvwteasTfHMPGLA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 28 Apr 2018 00:26:20 -0700
Message-ID: <CA+P7+xrs1Dz7evfofrExbg1Pw0C2uR17yNa=yS8XtYBvnK_k4g@mail.gmail.com>
Subject: Re: Fetching tags overwrites existing tags
To:     Wink Saville <wink@saville.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 12:08 PM, Wink Saville <wink@saville.com> wrote:
> On Thu, Apr 26, 2018 at 4:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>
>> Hence (1) we should detect and error out when --prefix-tags is used
>> with mirror fetch near where we do the same for track used without
>> mirror fetch already, (2) detect and error out when --prefix-tags is
>> used with track, and (3) add "+refs/tags/*:refs/remote-tags/$name/*"
>> just once without paying attention to track here.  We may not even
>> want add_remote_tags() helper function if we go that route.
>>
>
> I've replied to the thread using format-email/send-email with the
> subject: "[RFC PATCH v2] Teach remote add the --prefix-tags option",
> but I misspelled Junio's email address :(
>
> I've tried to address the issues pointed out by Junio. But I've choosen
> not to do "(2) detect and error out when --prefix-tags is used with track".
> My thinking is tags are independent of tracking and it seems reasonable
> that they sould be included if requested. If I'm wrong I'll certainly fix it.
>
> The other change was rather than using ""+refs/tags/*:refs/remote-tags/$name/*"
> I've changed it to "+refs/tags/*:refs/remote/tags/$name/*" which seems cleaner.
> Again, if remote-tags is preferred I'll change it back.

The only main concern I have with "remote" is that it is very similar
but not exactly the same as "remotes". Unfortunately, it is not
possible in *every* circumstance to use remotes.

Personally, I'd prefer we used "refs/remote/<remote-name>/tags" rather
than "refs/remote/tags/<remote-name>", and possibly plan to migrate
from refs/remotes/<remote-name>/<branches> to
refs/remote/<remote-name>/heads/<branches>

This is mostly so that future additions of things like notes,
replaces, or really *any* refs would automatically drop into
"refs/remotes/<name>/<full remote ref name with refs prefix removed>",
which is a longer term goal I've had for a while (though i haven't
been able to put much time to it at present). Historically, I proposed
using "tracking" instead of "remote", but I am ok with any name we
choose as long as it doesn't create conflicts.

Thanks,
Jake

>
> One other question, I'm not sure "--prefix-tags" is the best name for
> the option,
> maybe "--sub-tags" or "--nested-tags" or ...
>
> -- Wink
