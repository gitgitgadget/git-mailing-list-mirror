Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61395C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 04:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D6E1613CC
	for <git@archiver.kernel.org>; Wed,  5 May 2021 04:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhEEEC6 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 5 May 2021 00:02:58 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:37529 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhEEEC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 00:02:57 -0400
Received: by mail-ej1-f41.google.com with SMTP id w3so674893ejc.4
        for <git@vger.kernel.org>; Tue, 04 May 2021 21:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/L5miCbrMhQmuWrMrixXDX6WfhXVMrn2/4/bpwSusS0=;
        b=LZ7wT4oj1aEqe9AFOEdHID8DrLVxdU/sqXFJ1kgFCCnTZ1Xu8iDD87JKP1AcvfXveS
         QPrVTUj/vMts5gEXYsTuFgI5qazwVLQEs4F0FnEYqU0tlMko57TjG74U4dP3yB95cwMj
         ksCfA6mC90zMBpoVQMHVPAtOqJ6YEIeIbw88Gf1BN8WFhwW1LlOAv2/HgVxZEQFUegJe
         sWFpCe+B1smGgMpgrY/93O9naBuE8n+tf2+7E6MlNS6cWzL4Hllum4nGssTJMWhD39yW
         N7arGEeWeBnQtaY3Y89+IEyHqMNx36VoDjFw1nuuz9ajHwGmXEU84+idWFmeJNSU1+AK
         MI8w==
X-Gm-Message-State: AOAM5321QXFI6MSxIZIq5wC6v92TXfRzET8IABip4Pjuhb9F6ACv3V2n
        fSGXAJmtX81zvhZxvEbiNd1OEoOdkX31A1Rc5lc=
X-Google-Smtp-Source: ABdhPJy/l6U1jVBkRs3AnqQFaTs0EAxaWucAs0/2AmfnvFERR2cnjJ2UimbMScwiUCMHe9dhirDvGk7woGpHVOddWPY=
X-Received: by 2002:a17:906:c44d:: with SMTP id ck13mr9553522ejb.371.1620187313313;
 Tue, 04 May 2021 21:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
 <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
In-Reply-To: <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 5 May 2021 00:01:42 -0400
Message-ID: <CAPig+cQHmfTBpa=5nRHD1cceLSucQW8TgxFm3_OyOFpbOOPuig@mail.gmail.com>
Subject: Re: git switch/restore, still experimental?
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?Q?G=C3=A1bor_Farkas?= <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 4, 2021 at 11:47 PM Elijah Newren <newren@gmail.com> wrote:
> On Tue, May 4, 2021 at 3:36 AM Gábor Farkas <gabor.farkas@gmail.com> wrote:
> > the "git switch" and "git restore" commands were released two years
> > ago, but the manpage still says "THIS COMMAND IS EXPERIMENTAL. THE
> > BEHAVIOR MAY CHANGE.".
> >
> > considering that they were released two years ago, could the
> > experimental-warning be removed now?
>
> This probably makes sense.  The author of switch and restore isn't
> involved in the git project anymore.  He decided to work on other
> things, which was and is a big loss for us.  I think others (myself
> included) didn't know all the things that might have been in Duy's
> head that he wanted to verify were working well before marking this as
> good, but these two commands have generally been very well received
> and it has been a few years.  Personally, I'm not aware of anything
> that we'd need or want to change with these commands.

As a point of interest, Duy introduced multiple worktree support
(which eventually became git-worktree) in late 2014, and it's still
marked as experimental in the documentation (though not in loud
uppercase).
