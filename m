Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 087AB1F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 18:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfJZSmq (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 14:42:46 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35304 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfJZSmq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 14:42:46 -0400
Received: by mail-io1-f67.google.com with SMTP id h9so6168588ioh.2
        for <git@vger.kernel.org>; Sat, 26 Oct 2019 11:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IZ+kGt7nchMidys38U+rW7FA1wmsGfc8zcYV8HQ7tWk=;
        b=uM9tRwWP3xbJPxGNaYOoKnyHcFSO3PSLgIs84mHleJ8w11ZVuqC1NP0wt7KsSL1NXa
         GiIEM3FbpGyINCAr4E+GvNeJGMWWf7aXoZI0lBXD/k9FLJSF/s1Of/AGkE1J9mbTEq9R
         mUFZbP3LBw3mvygwDT6gssxq4rlVWTuYkexiLcnXxQ6fIDyAYUuEffaboJuuEk0+t7vj
         +WxQtzwrICOjaqmSi/sWGYTNeOuDsGZ64rndOxsh7DIADADAZBDgEZa4WK3Yyf9cCGcc
         6RDA0E163blZ4R6W0dU7pRLJQ5ceb2q2yKh+99Y17Qyqc0YEcYroRKsaBZh22cXrJb8y
         35cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=IZ+kGt7nchMidys38U+rW7FA1wmsGfc8zcYV8HQ7tWk=;
        b=U0c4/q/TPEsRlGsCFKsXHh6JCWr1s+nb5WyYR/cL5n6L47e73uioayt55kot+E1NR0
         BaXb3YoLROmotMTEcHDsf+sKHc7liEeaBlQXGqWiKOnOiEOI36IR81CUt5JJP0L5grO7
         JWebsEm7CCGQmb0SRXvtt85lNkMLbPhBTq8Xo/LH3Y0rxGz5geq3SPLEjiFdv0S6+nOm
         EmSlwlIN66k0moGeG6yMPqgQRE9/KyDRHPlwFbgnAVwXafS8HovkNHgMTpQgKqbh4Np8
         xirO3Dc1PTD/cmhJ0ZvW8ZH9cD2eQiJykj6dXX3N+tRXvkp9hSj4juLqVG31kWW7KtpC
         1ukA==
X-Gm-Message-State: APjAAAXLDEv5hOpl/w1gU6iNtO8FGLrCxxqIqmR8rXxXxUDKTXN0inV+
        LzSZZ6SXTtuVzYzOs+9QUOruDZAbd3h5TD6pv3E=
X-Google-Smtp-Source: APXvYqyJcREKytCFMx9VBun3HxKvJ3CNpk+od4Wfk7tz0yrFM/wIVF22Lz6a0F9HaANsrZe6xFFyaMONXqmRj01K5j0=
X-Received: by 2002:a6b:9089:: with SMTP id s131mr10702157iod.107.1572115365592;
 Sat, 26 Oct 2019 11:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191024092745.97035-1-mirucam@gmail.com> <20191024114148.GK4348@szeder.dev>
 <xmqqmudpee57.fsf@gitster-ct.c.googlers.com> <CAN7CjDB9mRTNRKRoE8XfLz4in5gV6pxrKrqcjLPfthDHaf20nA@mail.gmail.com>
 <xmqqzhhpb1nx.fsf@gitster-ct.c.googlers.com> <CAP8UFD1_vnjApobt+aN3M12g8mLqOZJGyvr4oqqTax5=cmLhsg@mail.gmail.com>
 <CAN7CjDC169rv8p9ZJcoLMeisXh7eMVcE4_-bpz8XFiYUsWAakQ@mail.gmail.com>
 <CAN7CjDDr0vDBDi+RKA0BMTHSaVQofc=GTCEuy1mAOaQmVqhJXA@mail.gmail.com> <CAP8UFD3pOL27VEO_42mXP_mfM689hRWLBU3KR0zJLgQKrX9ZPA@mail.gmail.com>
In-Reply-To: <CAP8UFD3pOL27VEO_42mXP_mfM689hRWLBU3KR0zJLgQKrX9ZPA@mail.gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Sat, 26 Oct 2019 20:42:34 +0200
Message-ID: <CAN7CjDCS3MNgdFd8NBkNEt3E+hfNgWiKizpEkQ1xjPbEkNrC3g@mail.gmail.com>
Subject: Re: [Outreachy][PATCH] abspath: reconcile `dir_exists()` and `is_directory()`
To:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El s=C3=A1b., 26 oct. 2019 a las 20:05, Christian Couder
(<christian.couder@gmail.com>) escribi=C3=B3:
>
> Hi Miriam,
>
> On Sat, Oct 26, 2019 at 5:31 PM Miriam R. <mirucam@gmail.com> wrote:
> >
> > Dear all,
> > there is already a static function called path_exists() in archive.c
> > so project does not compile.
> >
> > Maybe we could change the name of this static function and its
> > reference in archive.c like archive_path_exists() for example, or some
> > other you find more suitable.
>
> Yeah, I think renaming the function archive_path_exists() in a
> preparatory patch would be a good way to move forward on this.
>
> Best,
> Christian.

Great!
Thank you, Christian.
