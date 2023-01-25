Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93EDC27C76
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 21:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbjAYVmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 16:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjAYVmj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 16:42:39 -0500
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55051BE5
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 13:42:37 -0800 (PST)
Received: by mail-pg1-f179.google.com with SMTP id 143so892471pgg.6
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 13:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/pJCep11yjdzQ35w9QB+SuBjOk1CD/c1SmiaImU8/4=;
        b=kNBHd+I6z9aMO8WEmNml0xZXEP4ek13OveGbxR4cxHjFojbTmnKRZg7WLRbquwaUUT
         0t3zVBeqiM9J/Zdse0lzouulFB2wHc/VjqkSLNH7Lg+NUhdUqcY7W5c7dH7nVlY5yg1W
         Yxu4dyIfhuUtBd2vHjlI2fk0LPreZCw+iCMPxjuWE9afRMPbP1OtzW7C6XnemHirm+sA
         3fFk2whZx2A5p/RnzaSa4a9w10qyBsFCH1VpqrpirTcNCkcFD4ZR6m2ZuCAIc5WGAXJk
         gPXla6MTuQul/dSx8yry979J1Z3w9F+9X1XzWSpBPUKED2Yxcb5xclXVzPLu/9SKW5oi
         acyg==
X-Gm-Message-State: AFqh2krfeoYUKSQrFVnm1v0tdOcOtprS7HBPksMaLlH6YuPEBy96jCBQ
        jYAwNPYwvvxQFwGQPXZgIHGAmZi8EbtZHegk7EnXAob6
X-Google-Smtp-Source: AMrXdXvP4wYSasP1bcx4rSxHUsNTTXrm0a7surW8Z1LZF9mskHTtIEhgBsdTiynvFVmV6fyvrOP1Jn48QinVbm90RQk=
X-Received: by 2002:aa7:8653:0:b0:58b:c7e4:960c with SMTP id
 a19-20020aa78653000000b0058bc7e4960cmr3802457pfo.67.1674682957316; Wed, 25
 Jan 2023 13:42:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
 <pull.1270.v2.git.git.1674573972087.gitgitgadget@gmail.com>
 <xmqq1qnjhlbf.fsf@gitster.g> <CAEroKagUY5PfuC2CDn=pTJ=brPsjPy6MVz54mH1tvN8E-Pvk7g@mail.gmail.com>
In-Reply-To: <CAEroKagUY5PfuC2CDn=pTJ=brPsjPy6MVz54mH1tvN8E-Pvk7g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Jan 2023 16:42:26 -0500
Message-ID: <CAPig+cTNk1RvfdFembKcxTOUs0UsiXmz8rsEnab-0fQp-QE3Lg@mail.gmail.com>
Subject: Re: [PATCH v2] ssh signing: better error message when key not in agent
To:     Adam Szkoda <adaszko@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Adam Szkoda via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2023 at 8:05 AM Adam Szkoda <adaszko@gmail.com> wrote:
> On Tue, Jan 24, 2023 at 6:52 PM Junio C Hamano <gitster@pobox.com> wrote:
> > > Range-diff vs v1:
> > >
> > >  1:  0ce06076242 < -:  ----------- ssh signing: better error message when key not in agent
> > >  -:  ----------- > 1:  03dfca79387 ssh signing: better error message when key not in agent
> >
> > This is a fairly useless range-diff.
> >
> > Even when a range-diff shows the differences in the patches,
> > mechanically generated range-diff can only show _what_ changed.  It
> > is helpful to explain the changes in your own words to highlight
> > _why_ such changes are done, and this place after the "---" line
> > and the diffstat we see below is the place to do so.
> >
> > Does GitGitGadget allow its users to describe the differences since
> > the previous iteration yourself?
>
> No, I don't think it does.   It got generated automatically without
> giving me an opportunity to edit.

Yes, the user can describe the differences since the previous
iteration by editing the pull-request's description. Specifically,
when ready to send a new iteration:

(1) force push the new iteration to the same branch on GitHub

(2) edit the pull-request description; this is the very first
"comment" on the pull-request page; press the "..." button on that
comment and choose the "Edit" menu item; revise the text to describe
the changes since the previous revision, then press the "Update
comment" button to save

(3) post a "/submit" comment to the pull-request to tell GitGitGadget
to send the new revision to the Git mailing list
