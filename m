Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 747BC1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 21:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391494AbeIVCyv (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 22:54:51 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40748 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391328AbeIVCyv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 22:54:51 -0400
Received: by mail-oi0-f66.google.com with SMTP id l202-v6so12549626oig.7
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 14:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=End9Vj4xuSXgQav9pg5BbxkJiPiD+9cqdAOiuVx/qWc=;
        b=MQwsa+TwMGRfNQG9yoUbl+3DHzmQVU7e/VnrqeThYz/yu4wg7c0dqj9FHnxa2azWFC
         EJ2deuWlSgv8LajafXXGswsJTe3km3/Cvq7jd8uv+Zfv1WjnTxem69/LtH3L11tj0Ubu
         +y3wFvB7eXhJmMGGT/NP8kl1N+6ZWfvv6yZvvjHDL6BJ3Y8B464t0WAcYZYIqbLHlZVb
         xRI5F0uT0iv1LpbCAdg1hZSlnF98RUSw83IDWo2jC2CstK57Py2oEocAQ4ChKFc6XfiF
         IrmEVt9/zMsTqzsCFgWXdDOZVGN43N6KIlKFc2pgszE7eGx+iCJ2A3/YGZ4lsjKYVOBp
         pCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=End9Vj4xuSXgQav9pg5BbxkJiPiD+9cqdAOiuVx/qWc=;
        b=ShmxFac0elsfxZ7rdI6quVAokZd4vkkuTyDJ0cSjBGXIwnCVhIQSd4rn+ZCrzRb+CH
         3IZN6LgM7fsi5sX2vnxVEJmXZwakNXWkQ0VLupj5Ym5tKn3Cvgimuu1qrvefwd0wsuPi
         wFNXdRAHdLJ8RU+f2q2u8gTmCPLutBuOlz2WLNjJ+/51kte81Ligz/eVMKIBsBzkIgBv
         E+TLHGOb5/ZgVkMhHXGsXgGWUq/WN6HgEf3XAGTXYQvlQdBXQAnw4n+TNvWc8OxwxAN0
         qOdZ7kGyt407snFC6Vj35SsXcArMIBeRi7e2UXA+rnFrk+1H5NKje7yeWva+/3j6GKIN
         fZ5A==
X-Gm-Message-State: APzg51COiA9WPqRW8RVkKNUm8+Ln2Hq1IA07ghbyiwRDqteyGhgCBSRG
        uFq4xfA/p+LrJY5SD5CufR8p6mdg0NJuJEGxup37
X-Google-Smtp-Source: ANB0Vdaj9LFfI/NrUyZ7JWScBaEbNq/qwhDx3McN8AJ7pjokoV7Wpa6cIoQw3UOp3Ui1QbZQ6seuYW67VQ8xd9CM8BI=
X-Received: by 2002:aca:5397:: with SMTP id h145-v6mr189638oib.188.1537563852731;
 Fri, 21 Sep 2018 14:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537493611.git.matvore@google.com>
 <7dd9a1120726dee34aeebdfa4bf45a232c185500.1537493611.git.matvore@google.com> <CAPig+cT2qMvT2LW482cXQpGnTmNw8KWsH3d0bW4t0vgJ3p59SQ@mail.gmail.com>
In-Reply-To: <CAPig+cT2qMvT2LW482cXQpGnTmNw8KWsH3d0bW4t0vgJ3p59SQ@mail.gmail.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Fri, 21 Sep 2018 14:03:59 -0700
Message-ID: <CAMfpvhJX-KJa7aoGvNLLzQOJQq=BOxQubrUhO1mXpP+6Je6WAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] CodingGuidelines: add shell piping guidelines
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 20, 2018 at 7:06 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Thu, Sep 20, 2018 at 9:43 PM Matthew DeVore <matvore@google.com> wrote:
> > Add two guidelines:
>
> Probably s/two/three/ or s/two/several/ since the patch now adds three
> guidelines.
>
> >  - pipe characters should appear at the end of lines, and not cause
> >    indentation
>
> The "not cause indentation" bit is outdated since the added guideline
> no longer says this.
>
> >  - pipes should be avoided when they swallow exit codes that can
> >    potentially fail
>
> And:
>
>     - $(git ...) should be avoided ...

Thank you for pointing this out - I obviously forgot to update the
commit message. Here is the revised message:

CodingGuidelines: add shell piping guidelines

Add the following guidelines:

 - pipe characters should appear at the end of lines, not the beginning,
   and the \ line continuation character should be omitted
 - pipes and $(git ...) should be avoided when they swallow exit codes
   of processes that can potentially fail
