Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6146200B9
	for <e@80x24.org>; Fri,  4 May 2018 02:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbeEDCfk (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 22:35:40 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39126 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeEDCfj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 22:35:39 -0400
Received: by mail-qt0-f195.google.com with SMTP id f1-v6so25640569qtj.6
        for <git@vger.kernel.org>; Thu, 03 May 2018 19:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Zg8H9I3fVYj0+/IRxKnvUC5aRF/Z2dFrYU6QDxjo/24=;
        b=fdxU/VrY63r0sF8iGZCWiEjA1WDJYe2Y6xLvT/31j1z/PbVyqOWok4u1dJEw1t031f
         JoNG8r61LuhG511JLvnWMjz3C2P7/d2vn/pH6MhweHyQoRL2IDHyJBdHwkqV94X301Ke
         0f1j6tq4NzJQxXXEfHD9hcqQBEuRSxzs3y3m016FbLDEC7CiJHOhq6vzP017m4TShAZ0
         OV66TV8LOMl0M/QL7a5A1ZETBAZu7J2kRGCzR47oiYO3QCUBDN9CjRk7NX/XvPgtfgFv
         TVAa3PIFzTjnZic+VIGLGXxOu3Nq3+FcW0XzxRE+Ai23dj6OASx3T1KA5gr7DqUvUvvY
         6Ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Zg8H9I3fVYj0+/IRxKnvUC5aRF/Z2dFrYU6QDxjo/24=;
        b=lJeN0rKn2/c2EKSDPyzoUoagA6qydWnF580OaaM5pl6gJBMvJpV+lFj85pz/PM++qA
         d+PPM0+xNPdh26RvF3DE+iSloZUTLVzz57JLZUnDeYQRyyFsSVXikYwfMcONZVw16mDi
         70l/InndXzddXSyJG5qZhUKokAqjOyjv4ZSmjCp0LlmwwE0UVVmhiRDGiP7aa5825s+V
         G4rLEkkQRnz9gqhYF5kHYSOlmvirKwEP01Iqj4FRCtyhPALWWEIXA3KseFU5v2sberZ/
         bYrCVG+KwzaV54FALylbhToxYMZn8NA5OqEHuHr5qPyV8oHgmf9so8cUUBjAVGWEorra
         v+sA==
X-Gm-Message-State: ALQs6tDwAvnTbo68Hr7OtJt48QxQbInEfm8CU6tLyDNRGRhZbuYzTCw0
        BtNczqn4A0VmJegRCG+PUJdaE4fbQFudNYiBBPM=
X-Google-Smtp-Source: AB8JxZpK8mAqtRQ+0W0UO96rmwqigOIfM2QMyC6YSdFFpOGQky6cENGjTxtezssVMbVwQ/OJz7tve8X2L3yDCrYZLBs=
X-Received: by 2002:aed:26a4:: with SMTP id q33-v6mr21296323qtd.165.1525401339105;
 Thu, 03 May 2018 19:35:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Thu, 3 May 2018 19:35:38 -0700 (PDT)
In-Reply-To: <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 3 May 2018 22:35:38 -0400
X-Google-Sender-Auth: 2GpjCWRk8HggPnNhw2I87pit6Ys
Message-ID: <CAPig+cQv7tNCNhDdThhhDYEE=XmB0xO35Qjvpw+-MgCg0W3ovQ@mail.gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 11:30 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> This builtin does not do a whole lot so far, apart from showing a usage
> that is oddly similar to that of `git tbdiff`. And for a good reason:
> the next commits will turn `branch-diff` into a full-blown replacement
> for `tbdiff`.
>
> At this point, we ignore tbdiff's color options, as they will all be
> implemented later and require some patches to the diff machinery.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
> @@ -0,0 +1,40 @@
> +static const char * const builtin_branch_diff_usage[] = {
> +       N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
> +       NULL
> +};

The formatting of "<options>" vs. "base" confused me into thinking
that the latter was a literal keyword, but I see from reading patch
3/18 that it is not a literal at all, thus probably ought to be
specified as "<base>".
