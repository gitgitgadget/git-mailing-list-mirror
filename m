Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A8661F403
	for <e@80x24.org>; Thu, 14 Jun 2018 21:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755490AbeFNVb7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 17:31:59 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33833 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755348AbeFNVb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 17:31:58 -0400
Received: by mail-yb0-f193.google.com with SMTP id n23-v6so2791237ybg.1
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 14:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACnQ9AfNmkPFmvfY1DnmZa+h80bScdwGLo2Mmt4gCi4=;
        b=oOLx+gplSnRE8rjppd2DKVyKP9gbcwCQm6sECe3tvOSEy0dXIN8pCYV/LxHWtVTK2y
         J7suCBjcxx8CPKghDVsLvLTrZ2S2gI9TYmGt8qlQ2898bPG3/LnZ6Zn8ddQeSY/2GK/a
         zO9JT65A4M6fS0OiLc3gGWIUQ5ZnAs7e7QvM1TyNc5F4JRigz1yUnkrdxIt3tEHbu/ut
         BML20/4/xcyx4WX6OdeAEqrF0RZxiuHG/5Veb2soww7K5h40tMt61JazQs3H4de2QDPd
         kT9h5dfZ2NeJ0SMYX6wjZLEODM/TKyBzhKPf3J1RyLnn9ysf6YKINGFqivpBvZpPDFYa
         x4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACnQ9AfNmkPFmvfY1DnmZa+h80bScdwGLo2Mmt4gCi4=;
        b=Fw4jZTxDhBXB9eirATiPGeaCwh7USnsuqf56X/vmo9EiFeykNI5rfi4o3ostKFh816
         qCXfsDOM8gbTnOWH4N+fmVpaC0NBwtvrS1TQSpWJpTdxl2LNVNT4ay3/UQKzcu1Hhxuc
         O9kq3U9mumVaK2Fxl1RsHh/UCdDo1ExV92q+SQ7C30z2nNx15hYZBBKQzo/5d+cpeLP9
         noSD3DriYgq7AAcTCz+OGvuF7jBjqd3Sf6M/FGT2DQLrVc/aD39mWy84m/UX+dPtYNCM
         DrU5/gl3SS7AD7Fgsw6LAoRmfxw/PIVlbjsC6fCH1o7fXwjcD7bggdOJr7i3Rz8HfdS0
         HRKQ==
X-Gm-Message-State: APt69E3h8Wy55eamLxdC+hI6omCFY9/DyEChvDc+Ej9FMGK+xt4R9JUw
        xnoLQ99VnnuSrPbxj1aW1E+WCFIATCx/sDfmGRxFDA==
X-Google-Smtp-Source: ADUXVKKBq4BS0OQe2gbLtEKgTjywVsrwNZ2Cz0jKOoFXnBtPRxX9hf96cWhsCOvY3bVsRj0KMh61ghU6Q7k1luccuxk=
X-Received: by 2002:a25:b308:: with SMTP id l8-v6mr2345932ybj.515.1529011917579;
 Thu, 14 Jun 2018 14:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
 <20180613230522.55335-6-sbeller@google.com> <fcb052e0-2308-31bd-aa90-d6d3327642c0@gmail.com>
 <709bd61c-70fc-a925-efba-58ab9be265c9@gmail.com>
In-Reply-To: <709bd61c-70fc-a925-efba-58ab9be265c9@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 14 Jun 2018 14:31:46 -0700
Message-ID: <CAGZ79kaQ-smyCz6WmzybgLoS_NFxw5d2q_oxeWVHYnJxEn=mAQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/31] tree: add repository argument to lookup_tree
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 12:33 PM Derrick Stolee <stolee@gmail.com> wrote:
> > The 'tree' member of 'struct commit' was renamed to 'maybe_tree'.
>
> Resolving the merge was not very simple. I have a working merge
> available on GitHub [1] as commit 99a899f7c12ef73840dbe79c71acb11034d707dd.

Thanks for pointing this out and resolving the merge.
ds/generation-numbers seems to be cooking in next for longer already, so
I might just rebase this series on top of that as well.

Thanks for the heads up!
Stefan
