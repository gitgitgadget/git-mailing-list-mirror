Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CCDC433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 17:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbhKTReM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 12:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhKTReL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 12:34:11 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A0AC061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 09:31:07 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w1so56749148edc.6
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 09:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iok6+76CU0WFkSKTGhrV+TADzdjDMYyi9GBWccBs9+k=;
        b=IztlqkxTZQqR5ej1w/mvROfYb7vPEQSVnMr6+3QGF30WvzyAq+pxQpZs9+0qAR+zQq
         u2rdNOpuLcpzahyRmejnLHKwkOtsO5JEUfqy99z8fTcQTxxsI6AMAgr/wPrNN7tW4RTj
         2VCeadNNVx+d/8qTzYoZ9kbCSx5u50FGnreqWk3qPXfKJHKM2UFdhg7JJa1AgZcpMEYO
         Fu43qqwEp42YQLgjCPDyxRmtyH36UYWWHO4RUXLXC1nfZctUYnCTAGBArkOe55aPuzjm
         OiUebE9he0zsAeUFVKuZDSGWmZaeMGt0pxRL25FepYVh1kTVKfMNZkhg3lrnNbz0upfl
         X3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iok6+76CU0WFkSKTGhrV+TADzdjDMYyi9GBWccBs9+k=;
        b=Q5xC5OcjcPwDqCAa2pLiZgHlnN2w2qDlZ1FSsP8pryX8VbDEw8hLUveZCVZsTxcz0W
         jvrveCsYvmi3W60oHMuyFdPXzJvUzSXFcnlGj8vQ6YTyerahYQocTMIzSaCsrFUo9bkr
         8xjg1ai/juDPbDWGHC+h88YTZLTxHu3fGJsND8QnGlSaiU4kwI/lgZXImwwi1MRrLLmX
         MJTXj9GxnDYD1SCn8rlZrRsMhbMkan6mPcYn+5y+ECZYEXxC3uSOR6p6GLPTameST3kH
         l5KYvB3vFsWIjXT4Fx7XEzo/fXOXJdLWTsigAS30nOInCum7z2zqYxsztj+9bznDIOCY
         xxvQ==
X-Gm-Message-State: AOAM5317ORduhri6UVBUjBS9V1PVVRL4BGBgMr5U5WTRuQVyzGrMVv3q
        8rDobWIIZFH8DFJvFLva4cwZVDJY2g5+pGy3+G4=
X-Google-Smtp-Source: ABdhPJwbACZt7JGXCPAXGskhHi9zc3iO5ZCeaSstIM9bqOH4S3Lbq0iPielKPe/cbBq2vMWEdO/G6S29KpjpMER+90M=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr21047746eji.434.1637429466288;
 Sat, 20 Nov 2021 09:31:06 -0800 (PST)
MIME-Version: 1.0
References: <xmqqa6hznvz1.fsf@gitster.g>
In-Reply-To: <xmqqa6hznvz1.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 20 Nov 2021 09:30:55 -0800
Message-ID: <CABPp-BESjJpe6uqP2J54uvvn8+gA_fu0HGN5GZTSKkkQZ5_guQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #05; Fri, 19)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 11:53 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/zdiff3 (2021-09-20) 2 commits
>  - update documentation for new zdiff3 conflictStyle
>  - xdiff: implement a zealous diff3, or "zdiff3"
>
>  "Zealous diff3" style of merge conflict presentation has been added.
>
>  What's the status of this thing?

Submitted a v4 this week at
https://lore.kernel.org/git/pull.1036.v4.git.git.1637028785.gitgitgadget@gmail.com/,
and finally removed the RFC label.

As a side note, the zdiff3 work also spurred a separate (independent)
series from Phillip that you picked up at
pw/xdiff-classify-record-in-histogram.  (An intermediate version of
zdiff3 between v3 and v4 had a bug where it only worked with histogram
diffs.  Phillip went digging and not only fixed the zdiff3 bug, but
found a nice performance win for histogram diffs.)
