Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1716520960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755610AbdDMSfn (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:35:43 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33637 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755829AbdDMSfi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:35:38 -0400
Received: by mail-lf0-f45.google.com with SMTP id h125so33693966lfe.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2bZZZqnAzrSpfiKx98isSdt8qzvf4PpaCfETxR4JvzI=;
        b=rSMAS9QCau8Yx6MMfOHikdefRffTzLAkqn8xSA+HlKiYTRGU52XtRcMFu41cUgCNgJ
         Q1hQL+VjPe3KeULAA3dz++Wyw4litYiJ7v4SCHe3OJF7rjxvlozdiKMcEBFMbcPeMFs5
         z1/fBvGhW6ib3gE5LYRJ0VKgmZSDy/DwhFWy7M8GFROQwFfj33XcFF85STgFeb+aiIsJ
         Ck3O9Tu9S2U0IwoBP+lcGDXKNflgUWj46wes30TXoJ+INnZi6Vp/syU1Hyv1j9J3K5D1
         B0KGjy/6Hfxw6OXvGwmFHoF6RDeQN90PgvDJtwJORGxg5y/9VXOJJ7zqnMXzp4yG4FAn
         dszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2bZZZqnAzrSpfiKx98isSdt8qzvf4PpaCfETxR4JvzI=;
        b=Uul79EFuRzAdjX7G+0luamOrvtFY8eCok4wrQ1bznYKv9giJiNc4xZQTdVJveMYWbR
         IOafJlKAk7s6rqyz71fsVNpJIPxj+zOOfCxDK5XfVZ7qZLfO/kH4jwg1P0nzrDLlmilB
         rMtQ1InKYD6JYgK1gbUQ+9Xa9FKGEmGSMxOnrr3wixwk7hjt5DG41x6c6DLIDQB2VyjD
         pQf00selAaZKqRBHcZlZbcJqu5Dl9gGCoOtPQLp5F6lW/2qHUue/A5Td0Pc7fbPDi2HA
         CukQ7zPJuQMY36nlVx1wkxHr5mPCzm+EJ36IzuFjDCyH3w5lpazMV+xmTrL9Svhifgnv
         cB7Q==
X-Gm-Message-State: AN3rC/5b2jyCu5sWa6NE5Yuno5nQTc4Z0iqxMRVAA5TEOyOFWqxRCI4w
        3IiVAbpoJUVvyBZHUL8dfh86y/1dGg==
X-Received: by 10.25.77.2 with SMTP id a2mr1769815lfb.143.1492108536540; Thu,
 13 Apr 2017 11:35:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Thu, 13 Apr 2017 11:35:16 -0700 (PDT)
In-Reply-To: <1492108087.1527.82.camel@novalis.org>
References: <1492104698.1527.79.camel@novalis.org> <CA+P7+xo4mwA8DMeObq_T9=P9m7tG1d6afDS_Md56_EnhuXLVgw@mail.gmail.com>
 <10832632.7AIzXehjUi@mfick1-lnx> <1492108087.1527.82.camel@novalis.org>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 13 Apr 2017 11:35:16 -0700
Message-ID: <CA+P7+xoQtGyWpuUKFDQzy1RhdzT7mhES+VOczNSSQceiQUkDbw@mail.gmail.com>
Subject: Re: Simultaneous gc and repack
To:     David Turner <novalis@novalis.org>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Git mailing list <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 11:28 AM, David Turner <novalis@novalis.org> wrote:
> On Thu, 2017-04-13 at 12:08 -0600, Martin Fick wrote:
>> On Thursday, April 13, 2017 11:03:14 AM Jacob Keller wrote:
>> > On Thu, Apr 13, 2017 at 10:31 AM, David Turner
>>
>> <novalis@novalis.org> wrote:
>> > > Git gc locks the repository (using a gc.pid file) so
>> > > that other gcs don't run concurrently. But git repack
>> > > doesn't respect this lock, so it's possible to have a
>> > > repack running at the same time as a gc.  This makes
>> > > the gc sad when its packs are deleted out from under it
>> > > with: "fatal: ./objects/pack/pack-$sha.pack cannot be
>> > > accessed".  Then it dies, leaving a large temp file
>> > > hanging around.
>> > >
>> > > Does the following seem reasonable?
>> > >
>> > > 1. Make git repack, by default, check for a gc.pid file
>> > > (using the same logic as git gc itself does).
>> > > 2. Provide a --force option to git repack to ignore said
>> > > check. 3. Make git gc provide that --force option when
>> > > it calls repack under its own lock.
>> >
>> > What about just making the code that calls repack today
>> > just call gc instead? I guess it's more work if you don't
>> > strictly need it but..?
>>
>> There are many scanerios where this does not achieve the
>> same thing.  On the obvious side, gc does more than
>> repacking, but on the other side, repacking has many
>> switches that are not available via gc.
>>
>> Would it make more sense to move the lock to repack instead
>> of to gc?
>
> Other gc operations might step on each other too (e.g. packing refs).
> That would be less bad (and less common), but it still seems worth
> avoiding.

It sounds like your original solution would work, though I wouldn't
use "force" and I would either not document or document with "this is
only meant to be used by git-gc internally"

Thanks,
Jake
