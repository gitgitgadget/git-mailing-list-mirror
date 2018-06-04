Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26861F403
	for <e@80x24.org>; Mon,  4 Jun 2018 14:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbeFDO0G (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 10:26:06 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:42046 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753357AbeFDO0F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 10:26:05 -0400
Received: by mail-ot0-f173.google.com with SMTP id 92-v6so2973068otw.9
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ljYkrAL3h9QHA2acCNDpj31fDPCCe0Bf8Bi+rfYArkk=;
        b=K4AXaN7OWXknxxlnI/njCEWq71k+Gx9wDhbVM79DQ96h1xlAsJyG/zvkWHtdC/e5Uq
         WeYpGoAOaPVLjmuYlYVTbSEDJ2NDG8zTmNslPXWrMioB33C9HymhYoD8gEM2pOzy7jdY
         FDQqPeiS0L2vNxMqnhY45vFOP+5Jyr62x12o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ljYkrAL3h9QHA2acCNDpj31fDPCCe0Bf8Bi+rfYArkk=;
        b=WoB8Gm59pfJ5YFjRCwObpGLVD066qKKcLzaUWDx236YKCXlNvhxIx5F3PhKK1k4F0n
         DBQP81pJS4jErG1DNcL3nb3P3tkK4w4EgoW6d0dmfTb6yxLRIkGezdNxZd+/G/abMF5d
         NjTMgoHNBmYYILajyHzkaQnK7YCypSLQRNbCKH1uOLMbZ3tTvCz6fR1SKa8KgoXsnHNP
         c4fNXMaqxyt6ZpAXNrFwyZj5LcsetTZYtOB/Mk6rwHnmgF7zoeCtOs8Eov70MvoMo0Fc
         kCYnLYwOzFD7ScUIh9qIBN7n7FOCKw0p8YvDazk9i9Bdsq+Hy+PNK2IXWrnIWLLvGGDi
         JuUg==
X-Gm-Message-State: ALKqPwdLHtqCV0nFewQxOYwhm1ktKyRhuUqkunyrh0VRPS9csZxcTf/Y
        DrMxySv2l1n8iLBx1wkQQMumorX0wksAOlU+iffxvC+v
X-Google-Smtp-Source: ADUXVKIw7NGWMSsu/h+gw7LjuqyfbhIAdUTw7WXS14VceWyPW2P/mKtcqwQuMgOOO24Tc3iZHChbTJrGTlVrf8Fq6nY=
X-Received: by 2002:a9d:c41:: with SMTP id 59-v6mr14124087otr.255.1528122365339;
 Mon, 04 Jun 2018 07:26:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2f8e:0:0:0:0:0 with HTTP; Mon, 4 Jun 2018 07:26:04 -0700 (PDT)
In-Reply-To: <xmqqr2lm4pth.fsf@gitster-ct.c.googlers.com>
References: <xmqqr2lm4pth.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 4 Jun 2018 15:26:04 +0100
Message-ID: <CAE5ih7_RuL=VVN+HZj_m+nAxi3q48pCMuahANpUgPJKVDAmA6g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2018, #02; Mon, 4)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>, Merland Romain <merlorom@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4 June 2018 at 14:57, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
> Generally I try to avoid sending issues of "What's cooking" report
> in close succession, but as I plan to go offline for most of the
> remainder of the week, here is how the tree looks like as of
> tonight, just after tagging 2.18-rc1.  Hopefully we'll have another
> rc next week and then the real thing a week after that.
>
> You can find the changes described here in the integration branches
> of the repositories listed at
>
>     http://git-blame.blogspot.com/p/git-public-repositories.html
>



>
> * rm/p4-submit-with-commit-option (2018-05-21) 1 commit
>  - git-p4: add options --commit and --disable-rebase
>
>  Needs sign-off.

I think the signed-off version was sent in just last week:

http://lists-archives.com/git/925692-git-p4-add-options-commit-and-disable-rebase.html

Thanks,
Luke
