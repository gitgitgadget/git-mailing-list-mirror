Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127E31F404
	for <e@80x24.org>; Fri, 13 Apr 2018 17:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750824AbeDMRxa (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 13:53:30 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:39405 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeDMRx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 13:53:29 -0400
Received: by mail-io0-f170.google.com with SMTP id v13so11158643iob.6
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bTgQMKg27bK0hSs/8klbFuLAq1q7DMTBfquPUPFo/HU=;
        b=aIlOgSYILSRcILrcli1P2QDeOP0vKNI9I80qfb7Pang1aKw8qaHbon4DewBS6f8OqE
         yJd6omYmRvPsmCGE0PF3SNQkYT12zdW5I6VjSF/KfcBW5XnVUtg0A0LE6dZRSKa9tMtq
         RhHs4v71L+vnzoTRN+76pVDVUHaDhJ9wdyqkAv6sUkgurDNWJsNDE4eWZBMfUyi9geJi
         O/89p5sy20T+3ymBSs3vv2NRW9Hf5aircoZ5Coz7/lUcidnsOJRziuQjZeemGGTsNCqW
         iW34c4m+TyROYxN+2NMk1G59w2yUtAsEs0+WyZyA9W/gbZLk4w50oKaY25BCurxH7JLt
         nAxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bTgQMKg27bK0hSs/8klbFuLAq1q7DMTBfquPUPFo/HU=;
        b=D42ur3FVJxtZLtZ8KxKoolJMxBxGVu052aO2r6AU/z8Dk2Q8EpUx/9KZrfdXIcqNZj
         2wMuYZv1hB7hFUg4uMAkYiO2pJhA9uPWEdqjAtSq0OaVETxI9zaGNT9Dk/WjRlMv8uCB
         VZHaF2f8VZJs+c7F0+NztFXOk0FwjvHcyUWsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=bTgQMKg27bK0hSs/8klbFuLAq1q7DMTBfquPUPFo/HU=;
        b=egQB1z3KS7uplvYVXyUxAq6ezMqJgA7SXLH2VPgMApax+D1FWkinQAZ3iYYh+uNDSK
         mj3xqk2yZ95YS7iaDlSBhwU36FrymrOA5hj8RHUmMUiOA7k9xtNGv6ViHtN1BOf88n7d
         FE5Pgv/cOp/LnB12QrSm8eJsj0WFURbKmcSQaGhKqPuFEoEtP8Qk0ar6Hf2NfRvXHhJo
         tx7ZzRPe+vyq0NnTNqpcyRxFN7QLa64YB783u/YpMq9iMP5s2IC0pwOxFQlquhsaFPQ8
         EuD/ywRIFNwFIl1T8/wfBHFiEhLkbqiMqdP1BkyaKXKPejixdY4pNo9XfbuKYxkhPmTg
         NCyA==
X-Gm-Message-State: ALQs6tCi6wjGQwTl1YIQdA5wB5/pt6W0TaVYAD5g7S89WLdM/h8QwFt0
        lfAypKblBewhH2u/57w/vGtJVi0FjTJVJ+lVK9M=
X-Google-Smtp-Source: AIpwx4+z7iA7Khl10rIzV4bL1kpt8e0T8X6AIX+H0nR158P45oe+3irlPNN2uq0wf+JUzM61dpnzYLUhK33hIzVLY4k=
X-Received: by 10.107.138.38 with SMTP id m38mr4352374iod.259.1523642009027;
 Fri, 13 Apr 2018 10:53:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Fri, 13 Apr 2018 10:53:28 -0700 (PDT)
In-Reply-To: <CAGZ79kbs0heVvqMf2cjBtxtYs48CFFaM+9+YzB6gUwzWScvr=A@mail.gmail.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
 <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
 <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
 <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
 <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
 <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com>
 <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com> <CAGZ79kbs0heVvqMf2cjBtxtYs48CFFaM+9+YzB6gUwzWScvr=A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Apr 2018 10:53:28 -0700
X-Google-Sender-Auth: GCK7FhMsvgl2aVh97isaTTyvbQA
Message-ID: <CA+55aFw6okG9=ghsqZwqmet-PMym7WqY9qJr5FfM+yhJv97PAw@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Stefan Beller <sbeller@google.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 13, 2018 at 10:39 AM, Stefan Beller <sbeller@google.com> wrote:
>
> Would s/read/xread/ make sense in working_tree_matches ?

Makes sense, yes.

That patch was really more of a RFD than anything that should be applied.

I would like to see the "might be same" flag pushed down so that we
don't do this comparison when it makes no sense, even if the stat info
makes that less of an issue than it might otherwise be,

And maybe that whole function should be taught to do the "verify CE
against file", and do the proper full cache state check (ie time etc)
instead of doing the read.

So maybe the best option is a combination of the two patches: my
"verify the working tree state" _together_ with the was_tracked()
logic that looks up a cache entry.

Again, the problem with "look up the index state" is about files
possibly being renamed as part of the merge, but if we then check the
index state against the actual contents of the working directory, that
isn't an issue.

              Linus
