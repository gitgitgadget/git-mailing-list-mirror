Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C131F403
	for <e@80x24.org>; Tue, 12 Jun 2018 00:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933673AbeFLABA (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 20:01:00 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:39971 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933097AbeFLAA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 20:00:59 -0400
Received: by mail-yw0-f195.google.com with SMTP id p129-v6so6924748ywg.7
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 17:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mwnw7itauFT9E4XCCwe8FmFj5agHBwZY74zK5NFjoYc=;
        b=QhnBkUU/+PC+J4XNTGk56POz77/M1b/G/Yj2wOd3UiVuiReLKb7HsktK5DMYwHR4T9
         47fiSUAthuyaKEmOnn6CHbERCI+QHEXxBcn+6kgP87dS7WL26wXall2oL7sLH3S2R8yX
         W0xQpBTsnCxqFQ3+n0Tr0jxqb2dVW+XUmt5AFe1a5A049Q207R6Nc5EPlWuMgTW3PUZw
         TwjyTsAusvGkNoe/eG3nOXKr8CvMQLGqfJHV3xAUluENo9sBSWky4Fu/P40HDiASSabc
         pWq4rq36aqkhymFH78Hunus+rRmpkzBsZpBdHAOAqwZNknZHI0diC2gP5x+6LA7lNnTv
         mBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mwnw7itauFT9E4XCCwe8FmFj5agHBwZY74zK5NFjoYc=;
        b=Zir+aiAuK2Jih6jCbqLgyCGU2k2B5wj/23S+cuu/ZaUoGgrVQGqFIyMga2PeXS1dp8
         vQ5X7WclzkPtyu50b55vNKerrGh2+E/xlTkhtNPwm8qwwbASZ247Iy2BMtYkFsAIdTkc
         cuj0t8ysE3C4JwHyvV7f4YzxwVDAISveDdGQM+9Eq/vyHry6EDX1qYn81obCvpiAvyCV
         bFwO1tHC92P6VGtC7S6bZSb/8e5GsftnzBVr1DahUWUSEuB2AG1IECO5RVsl+8WSoLwJ
         HCAy7Q1CNpNZccy8TcZnNZQwhY6jZDYWwthuP3Ds1jg08Cl0vQ17AT0pS1j9mFK94Rsq
         WB2w==
X-Gm-Message-State: APt69E1wlocT7wMkpoFJ63+YQ7Y4GNxRiFDVGstbv3p39D+oMyZ/1DKJ
        nb34xbQ/39QWH20ULRuhOhF1IzuT/dnYRU8D8tOSNQ==
X-Google-Smtp-Source: ADUXVKI6SxeTrxIOO7D/ZgYH8U6edZIa+UKOtOe3jFHVOK7ymN0XXYbtwbABAAemMKdA8XUswgJKHmIzQ1X4er20dEw=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr580631ywf.238.1528761658859;
 Mon, 11 Jun 2018 17:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528397984.git.jonathantanmy@google.com>
In-Reply-To: <cover.1528397984.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 11 Jun 2018 17:00:47 -0700
Message-ID: <CAGZ79kbeB_ppTY6cqvxSPsmFghfYaXypS+fjyDr9Ukxax5jz2Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Object store refactoring: make bitmap_git not global
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 12:04 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> This is a continuation of the object store refactoring effort.
>
> We cannot truly free an object store without ensuring that any generated
> bitmaps are first freed, so here are patches to drastically reduce the
> lifetime of any bitmaps generated. As a bonus, the API is also improved,
> and global state reduced.
>

Thanks for writing this series, I have no comments on it.

Thanks,
Stefan
