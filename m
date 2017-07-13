Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775D12027C
	for <e@80x24.org>; Thu, 13 Jul 2017 21:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752760AbdGMVVg (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 17:21:36 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33836 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbdGMVVf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 17:21:35 -0400
Received: by mail-qk0-f179.google.com with SMTP id d78so61494781qkb.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vY/oxd5wRC5W8IIfzduqyyvuQZfPUYz6HNU+p5oHIpg=;
        b=WRRw9ZBIZJ3sGBnSH2FkNni9gINVuSGMLdlSN+XR60Q3bKRN9KHHQrRt3jBFqFNOZg
         JqrVccNHe6Xd64bjZdquXZShlxmfrECQKr/ItpqIuXTbgwep/UZtHyPgb6JhdINQAMcn
         RtUtWXJEH2DdzIcpdeAyxsybt0MJL04HZWD0gpBGqWkcbBBxbWlma5GVbF3mfpeKsSQv
         lyh9vTPYoeQYZ/zc5Ydi4zC8aYuoKu4t1G0P/SSFYiT/D7j5JJrdsZE81eIhG9fDl2aP
         7x3NHFX/wu5YeG+R7rpFpNtuqVLAZdEpqa4xyL/UN9oI4eFiedMckcDWsIw4YVpLiQQq
         fgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vY/oxd5wRC5W8IIfzduqyyvuQZfPUYz6HNU+p5oHIpg=;
        b=OMM4iTZ8D1Q8YV4j0uFqA5Zm9x0gHYpeZjVkA4Cihg7ZJetZpQR/fp2osvzA9kcC8j
         P4At8MtHauKGiOvgLeG8gioxZXK7pThDgHhlYbySDjcD6PNdBCWP3NOOwEAEFXSeAIjg
         Ywy9+iK9kolXVhDS50PwABEP0YcnqqbSKwiSNeoJW6M3PI1GuUYc5yy/Q1WianRR6gII
         UCpNlv7r4orn2+awVRcnYwRZbFSNhm5hhbL56Sxupf55mAZBkMD8klenjRgxiRoGj6uE
         B9FzyPIFdtedEGkP2xYtm6f6hE9+vdsgCOiS64MIP4he9zXMa/+Dakia20RBsHUApTJG
         T3Pg==
X-Gm-Message-State: AIVw111f0UuEaSKSfZ+Yq8vIZqV7QN97SiDCORhrJBs1pu/1zhdnFwls
        bmRZO3/TFCAJhPe5Xuy6+1KgRqDF5uGr
X-Received: by 10.55.77.13 with SMTP id a13mr6910046qkb.194.1499980894634;
 Thu, 13 Jul 2017 14:21:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.131.67 with HTTP; Thu, 13 Jul 2017 14:21:34 -0700 (PDT)
In-Reply-To: <xmqqeftlz0dv.fsf@gitster.mtv.corp.google.com>
References: <xmqqeftlz0dv.fsf@gitster.mtv.corp.google.com>
From:   Lars Schneider <larsxschneider@gmail.com>
Date:   Thu, 13 Jul 2017 23:21:34 +0200
Message-ID: <CADJMNYmGR8Ti0S77y2ykPdSZB68DrBb8O0wfX6PaezV1+j2bnw@mail.gmail.com>
Subject: Re: Reducing redundant build at Travis?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 1:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I usually try to stay as late as possible to finish all the
> integration branches in order before pushing out the result; it is
> more efficient to be able to batch things (for humans).
>
> I however noticed that This often means we would have multiple build
> jobs at Travis for branches and builds on Windows often fails

The Windows build has some kind of problem since June 22.
Somehow building gitk-git just blocks the build and waits until
the timeout. I had no time, yet, to investigate this further.


> waiting for its response.  Since I tagged the tip of 'maint', and I
> wanted to give all the build a fair chance to succeed without other
> build jobs starving it of resources, I pushed out 'maint' and the
> tag before others, even though I already have all the other
> integration branches ready.
>
> Unfortunately, https://travis-ci.org/git/git/builds/ shows that it
> does not care if it spawned a job to build the tip of 'maint' and
> another for 'v2.13.3' that point at the same thing.

That is indeed suprising and wasteful. Looks like other people
did run into the same issue. How about something like this?
https://github.com/mockito/mockito/blob/release/2.x/.travis.yml#L26-L29


- Lars
