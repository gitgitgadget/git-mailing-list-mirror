Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FE681F453
	for <e@80x24.org>; Fri,  1 Feb 2019 15:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfBAPEz (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 10:04:55 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:42913 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbfBAPEz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 10:04:55 -0500
Received: by mail-ed1-f46.google.com with SMTP id y20so5655850edw.9
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 07:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xZCXpzFaS+gIAv7vpUfpHLWeo2NyJeM9oLmlJyyFUyo=;
        b=evkBMkP/uVp68PnGzTxxOjBGSFPw5alYOQxv0QDoJZHWl+erZtgvbff60Im1Lk/E4I
         Tyzp6b5ZWUgQYpejFbvkRxpSfbu9rcZTIWCV40NBz2UUJ5j8lFALicya+Rk5kmAj1qk2
         mu6xPN8V5VBcKo/AwUZZ6YPm0Msdl1v18JMvrY8rCuqkxe1PEEz+SQgMGM63j4cIvF0U
         V31j0H0nFsj+PyxWFcXegIIUO814tTEf94ZlMR4ywL9FHJ4/ucAKekbkDADrVNzGRmaR
         bp14ECNxoB1P/wioFP9YLvEmgbbAmj0MaaBIdqAMjmZPpQ4DqWkzOtckq/Hr+5D+Bhf0
         pptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xZCXpzFaS+gIAv7vpUfpHLWeo2NyJeM9oLmlJyyFUyo=;
        b=oFmNbF/7XAGohokQOB4TG8vYoQ9E9M8uFVkPG2aLjJElY1OYiRDecD7PcFP29z8a9G
         cLqmjHfQ+l1xEfO7ZXYQZMFPWQavu8LYxj8Ixus4oSrXzU+FGqGoCmqL6UnaW0zhhfuP
         FATwDs2o5W6jPByzNo2SrPyb6BysqUoKF9I8W/txSL1BdDOF89w5tE1YEICQjNrGTcMv
         A5NL5Ff8DozED441MZXUPolP9ciSl7LXlmMdd+M00Q0VrQybbieYVHodERYvqzMlOKdv
         q9At+wiPxR+TfnAlsuWH5HBza+Ka2rH44NhIU8/YAMR14WWTeDLWqrUhS3YduB8X1BUm
         fN0g==
X-Gm-Message-State: AJcUukcun9HrdLCtUabWNulV87IX2Ia61ur8qt9tEw5iZcc1hC/ICps9
        PS93/TDT9KVEwP/rugCjZzqYovf9d5SMqLewEQ88JGupvZS3dbiD
X-Google-Smtp-Source: ALg8bN6v97IRN6IQmJDKIMPhNBSEuDmBUFPdpx2T1H/hpyxQS8GyekK1h0Y+Rldy/K4Nn/0Hq9m3WzO4X/UMoe2y1ag=
X-Received: by 2002:a05:6402:121a:: with SMTP id c26mr38292795edw.104.1549033493226;
 Fri, 01 Feb 2019 07:04:53 -0800 (PST)
MIME-Version: 1.0
References: <CAKQS2drF+CQTiKtXD6Kx1ZbH9ZTekWmbfiiHTCJV_BrT5-gAFQ@mail.gmail.com>
 <CAKQS2dqx9Nux11ot7a-Wxd2qpcdAAWw-e7Li+X3bw7TxJS=Kyw@mail.gmail.com>
In-Reply-To: <CAKQS2dqx9Nux11ot7a-Wxd2qpcdAAWw-e7Li+X3bw7TxJS=Kyw@mail.gmail.com>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Fri, 1 Feb 2019 16:04:26 +0100
Message-ID: <CABUeae8=SLzSiT+UDdPeEbSUJNhU5xVF0-7hGK++v4sHsQWA8w@mail.gmail.com>
Subject: Re: Submodules & worktree
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 1 Feb 2019 at 15:00, Ole Pinto <olepinto@gmail.com> wrote:
>
> Adding a worktree from a working copy with submodules doesn't work.
>
> In the config file I have
>     [submodule]
>         recurse = true
>

FYI, https://git-scm.com/docs/git-worktree#_bugs

"Multiple checkout in general is still experimental, and the support
for submodules is incomplete.
It is NOT recommended to make multiple checkouts of a superproject."

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
