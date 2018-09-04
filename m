Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D57A1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 18:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeIDXIX (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 19:08:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36304 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDXIX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 19:08:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so4078294edq.3
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 11:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iB1SCv36fG097eZxH2VzBMHfE5Nnj7OYAZ+enS2gE2g=;
        b=K1zy1n3PUQAuBuDz7kdraDRjysVz8exSc/3mEfq6m2wR/h22PkybeGG0cRWMQRSB7p
         lz0aBgkn70bdnAaZouMupbIxw1AUZJ15ZGoDNNVufTH43SJnBaLGFyIaDxU28d/4BdOG
         aaJMGg5s5z0xOpKsJp+XoXHE3VKAS/cU2lNQ2QGsVCFd8Jxulvbfn4vGNCPjSfQtREhu
         fqMk9JwguT6NAjGQdoJzUj86TJByduR/wt7hFHphbF+PO1z8Q/ZudNXJj3Dwn4/7OiW2
         +eBBJy0MRQ/VtqZTDbEG5Y3wg+mk5YeT5j1fGwQdYN5RZioziGPArrp2SgSOQltzJj+w
         I6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iB1SCv36fG097eZxH2VzBMHfE5Nnj7OYAZ+enS2gE2g=;
        b=mgSslWRsrhAM7+XT1Err8XuYLOvl3a+ZHy/TvoADAeoe57CFD/0C3eUtf9MDtWd7R5
         NKgW5uzMKazppQKtNlzeXSzSehvnU7X2hjcagFFmd5mL5YlKwywnyKu609l/HYMHRwvE
         q6axXfzLEnCPdZAFBLbChWSsr2arKhY4h1sj9niFlnJOIrrresDngRxGNrz/O9WawAix
         w9dncMy5J+lOvAlTPDdXG35lLo5fjXGH7SNoACO+apN/qOAIRxmJkG0c1TsbsY2aWhrV
         i9ReKn5lj7af77P0LuOYpTMM24P2e9QHsvAgzg+TxOgs2AS8hQiKb21wgfQWu/tPz0lw
         EwAw==
X-Gm-Message-State: APzg51C+jjG2dedcg2XmIQFp6FIVfP7jyMmZlzbd+nB/TntKDb9NmuRu
        1Zx8pS1tKWZAB7E9LRL/hq6kP2bjPcMUZ1Sx09K3tg==
X-Google-Smtp-Source: ANB0VdZsBLfJhwkyLWTAFzqb3ZmJ8k6h4YxYXarK25JfV2Z+g++mFMeg1oCTwPNvLzeV3Um42WmRAKv+zFV/kOEGfPU=
X-Received: by 2002:a50:ae62:: with SMTP id c89-v6mr36995697edd.128.1536086520160;
 Tue, 04 Sep 2018 11:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1536081438.git.matvore@google.com>
In-Reply-To: <cover.1536081438.git.matvore@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Sep 2018 11:41:49 -0700
Message-ID: <CAGZ79kbhXQPQ87kAw_bOd0L0k8W4q=nPX0ymLPNnaEnpKZyesw@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] filter: support for excluding all trees and blobs
To:     Matthew DeVore <matvore@google.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 4, 2018 at 11:06 AM Matthew DeVore <matvore@google.com> wrote:
>
> I made the following changes since v6 of the patchset:
>  - (suggested by Duy Nguyen) add a new commit which replaces uses of die() with
>    BUG() in list-objects-filter.c wherever it corresponds to a coding error.
>  - Replace die() with BUG() in new code.
>  - Replace test_line_count = 0 with test_must_be_empty in new tests since the
>    trend seems to be, based on other RFCs in progress, that we are standardizing
>    on that phraseology. See:
>    https://public-inbox.org/git/20180819215725.29001-1-szeder.dev@gmail.com/
>
> As asked in the last "What's cooking in git.git" post, the status of this patch
> is:
>  - The original reviewer, Jonathan Tan, is on vacation and will be back later
>    this week.
>  - Stefan Beller has been reviewing the patchset in Jonathan's absence, and
>    stated that it's a good read despite not being familiar with the code:
>    https://public-inbox.org/git/CAGZ79kaWcGbyc2S5gOCU7NdvT4fN46jq4xK9MvTLAFBGhyuo2A@mail.gmail.com/

and this still holds.

Thanks,
Stefan
