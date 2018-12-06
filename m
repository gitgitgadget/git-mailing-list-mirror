Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C304211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 18:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbeLFSL1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 13:11:27 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:43262 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeLFSL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 13:11:27 -0500
Received: by mail-ed1-f52.google.com with SMTP id f9so1531129eds.10
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 10:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88Z6zGWyQVQndaJ0BBbBqyqpjUR6Y8liwO6vyWqFpX4=;
        b=XcS1Vxi5Lta4hgTp+EikNNsQlZc71/CfDuri2OBhaCymDk9SfoiboVaL3SDbsx1BQa
         eQXe1c8U6gAidRczcLuuBXPXPOuCypDQDuWuaZV8Z59WzmHCHtblPw3tonMJTze0KcOp
         c5RX3JslDXHpEG8k5GvR5V6s5pytLgmfhB7wTe5uvph0LH0ugQH83HraeN1r76tuGH7j
         GiF/3FuB3+mGs6vcbiugtehBUwVJcgmU4sj5vcTI29IWnRSEgTBuMrKHXrEOFQPiMYwe
         vAi0ZMu8Sps5bgLYwRl/WOsCRKgFeogv70I9s+hBgQNu9FQ1VjgE21KY4ICiK+YjzP+G
         ZWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88Z6zGWyQVQndaJ0BBbBqyqpjUR6Y8liwO6vyWqFpX4=;
        b=OUaa+5sULBvLG5Bk28IZaTslXijkEG2rfJJOMJc3L0nc60/WRXMbnuXxlK+scO5O4o
         NP2iaohCUjdlZFu9Yhuc6Tj2TJCs0irHgwfx5DqQDMqchdZz1XdCms/06Dq9J8SOKLFH
         Jayk2bKTjbM6wjKsn54zSsECKEm2NA9pvfhaFPt4LnFPKie8Gwmof/DN25lACreo7SUK
         BI3DH0ub0A+vKVdRO3GQNOWzjPL9l5SMJUb50U/I6aKQ93yQx10iLRieczOIUesP4bOm
         J+plU5l3kj/1kNj+hfa8lX0t1mUGuldatIZVdr8Af1ojd41XkP9yEQltNxYg7aVHN3RJ
         3Mjg==
X-Gm-Message-State: AA+aEWaj7HPI9BkG38Z/Oof7osMpbBEPlRyqwV3WOoQH1O5ELETlj1k2
        7RBELLWJCMqR865eEoFY4kYNWdy/yEEHZqWTPCAZXGGMGDo1MQ==
X-Google-Smtp-Source: AFSGD/V2WXhrGK8CrbTdyDOv2zUiFlv3FvBfHVGUpxr7Rmm/TNUFGnSYNYKHSLntb5iWVG45lm5WYzigIxmKAX+iFn4=
X-Received: by 2002:a50:bac6:: with SMTP id x64mr26177671ede.191.1544119884844;
 Thu, 06 Dec 2018 10:11:24 -0800 (PST)
MIME-Version: 1.0
References: <87zhtiyd45.fsf@evledraar.gmail.com> <b23422fa-8a1d-e508-a008-a2fe27b7b49f@talktalk.net>
In-Reply-To: <b23422fa-8a1d-e508-a008-a2fe27b7b49f@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Dec 2018 10:11:13 -0800
Message-ID: <CAGZ79kZVfMNELXuir+t9U8bSg2PVF=oX8aya-OqmRaP0gHRgFw@mail.gmail.com>
Subject: Re: A case where diff.colorMoved=plain is more sensible than
 diff.colorMoved=zebra & others
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 6, 2018 at 6:58 AM Phillip Wood <phillip.wood@talktalk.net> wrote:

> > So is there some "must be at least two consecutive lines" condition for
> > not-plain, or is something else going on here?
>
> To be considered a block has to have 20 alphanumeric characters - see
> commit f0b8fb6e59 ("diff: define block by number of alphanumeric chars",
> 2017-08-15). This stops things like random '}' lines being marked as
> moved on their own.

This is spot on.

All but the "plain" mode use the concept of "blocks" of code
(there is even one mode called "blocks", which adds to the confusion).

> It might be better to use some kind of frequency
> information (a bit like python's difflib junk parameter) instead so that
> (fairly) unique short lines also get marked properly.

Yes that is what I was initially thinking about. However to have good
information, you'd need to index a whole lot (the whole repository,
i.e. all text blobs in existence?) to get an accurate picture of frequency
information, which I'd prefer to call entropy as I come from a background
familiar with https://en.wikipedia.org/wiki/Information_theory, I am not
sure where 'frequency information' comes from -- it sounds like the
same concept.

Of course it is too expensive to run an operation O(repository size)
just for this diff, so maybe we could get away with some smaller
corpus to build up this information on what is sufficient for coloring.

When only looking at the given diff, I would imagine that each line
would not carry a whole lot of information as its characters occur
rather frequently compared to the rest of the diff.

Best,
Stefan
