Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC661F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 15:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfJZPbF (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 11:31:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33406 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfJZPbE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 11:31:04 -0400
Received: by mail-io1-f67.google.com with SMTP id z19so5850759ior.0
        for <git@vger.kernel.org>; Sat, 26 Oct 2019 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UydPvDdQCG2ofUoJfYBAWzH/jNGgrY43RELu7BK1kNg=;
        b=kuV9CoG3HsbehisEAN1cKxssOrzQY0GBmCdMRNa3ogo2dG1LTnsSO9zvmKmpXJkmJT
         SzNNWe8Ja4/QFYw4d0McliYMb/gBEGg3B+SsqnCWSjRR/EpafABLmBv9ddnrSThFOXDz
         4ZJw8hcVun6qKhmmbcYijF6h1etxOPJs1RmC2CnMDFu9k9GuiuPQG7Ty1inrv3IWGEV9
         LLLVhKw/yVl0RWbH8cz+zgWENBVxY/vfAZQNZuJPGr1HynVo3OjpRanlFrfYzS7Bz5Vj
         toAlFlge0Um0OSihs4ZxZdYerFSIBpnUuMxsV7GdLh9DYEmNa2ojsmJnJ2P7VOYjRxBZ
         M10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UydPvDdQCG2ofUoJfYBAWzH/jNGgrY43RELu7BK1kNg=;
        b=gP3GvAUwW47jpVmMpwcxB414FyqxFpQ3J+3k+26P0lQR4HYgAn/TEkXKKA8mpyZtoe
         8ASI7PUnXmk3bjLRAWYzcv7ieAKwL/nqMMEt5jo63hUXYesYUdhdUmolfX9S+ob/vwtm
         6utPklNxIMIDdaYp7xDzT7sXgQF9YU2ODqukuLN9XOtpxhEJ8mxqAJIWqBTr/pbVM5PH
         JkuiEva8M8RnCY8kudIWCHhZezZT81/uE2uRhQlEW6HGlcJxrFLi8XNT3BG+vyUViyHV
         xh4H+0ocXrSdEed6k3plDDNdKWKqNU872lFSKd23PEL+lCNU6XeFUc61K1ilCsTTnr14
         Acow==
X-Gm-Message-State: APjAAAWL6vWqmGg4bZXi3ZuSR8kF52ax652wiOShy1a7pE5KfcMVznBC
        duMeFpHLLFZxqtwKmsSC/QshNJG/RlECnGbz7nM=
X-Google-Smtp-Source: APXvYqz75XX7mGfUf8bv+SREx0D0/DylayJcM+fEUY29qDN+NjL2EHAHI+LgIMYbBOtQ7vZHxEw+YK97lFA5S4XOAZA=
X-Received: by 2002:a5d:8447:: with SMTP id w7mr9040167ior.127.1572103862637;
 Sat, 26 Oct 2019 08:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191024092745.97035-1-mirucam@gmail.com> <20191024114148.GK4348@szeder.dev>
 <xmqqmudpee57.fsf@gitster-ct.c.googlers.com> <CAN7CjDB9mRTNRKRoE8XfLz4in5gV6pxrKrqcjLPfthDHaf20nA@mail.gmail.com>
 <xmqqzhhpb1nx.fsf@gitster-ct.c.googlers.com> <CAP8UFD1_vnjApobt+aN3M12g8mLqOZJGyvr4oqqTax5=cmLhsg@mail.gmail.com>
 <CAN7CjDC169rv8p9ZJcoLMeisXh7eMVcE4_-bpz8XFiYUsWAakQ@mail.gmail.com>
In-Reply-To: <CAN7CjDC169rv8p9ZJcoLMeisXh7eMVcE4_-bpz8XFiYUsWAakQ@mail.gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Sat, 26 Oct 2019 17:30:51 +0200
Message-ID: <CAN7CjDDr0vDBDi+RKA0BMTHSaVQofc=GTCEuy1mAOaQmVqhJXA@mail.gmail.com>
Subject: Re: [Outreachy][PATCH] abspath: reconcile `dir_exists()` and `is_directory()`
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,
there is already a static function called path_exists() in archive.c
so project does not compile.

Maybe we could change the name of this static function and its
reference in archive.c like archive_path_exists() for example, or some
other you find more suitable.

Best,
Miriam

El vie., 25 oct. 2019 a las 17:23, Miriam R. (<mirucam@gmail.com>) escribi=
=C3=B3:
>
> Ok! Thanks to everyone.
>
> Best,
> Miriam
>
> El vie., 25 oct. 2019 a las 16:48, Christian Couder
> (<christian.couder@gmail.com>) escribi=C3=B3:
> >
> > On Fri, Oct 25, 2019 at 11:43 AM Junio C Hamano <gitster@pobox.com> wro=
te:
> > >
> > > "Miriam R." <mirucam@gmail.com> writes:
> > >
> > > > Ok, then after discussion, finally the issue tasks would be:
> > > >
> > > > - Add path_exists() that will work same as file_exists(), keeping f=
or
> > > > now the latter.
> > > > - Use path_exists() instead of dir_exists() in builtin/clone.c.
> > >
> > > Sounds about right.
> > >
> > > > And also:
> > > > - Rename is_directory() to dir_exists(), as it is the equivalent to
> > > > path_exists()/file_exists(), isn't it?
> > >
> > > I wouldn't go there in the same series, if I were doing it.  I'd
> > > expect that such a patch would be more noisy than it is worth if
> > > done in a single step.  In order to avoid becoming a hindrance to
> > > other topics in flight, an ideal series to do so would support the
> > > same functionality with both old and new names, convert code that
> > > use the old name to use the new name, possibly in multiple patches
> > > to avoid unnecessary textual conflicts (i.e. some of these patches
> > > made to areas that are seeing active development will be discarded
> > > and need to be retried later when the area is more quiet) and then
> > > finally the function wither the old name gets removed.
> > >
> > > You would not want to mix the first two bullet points that are
> > > relatively isolated with such a long transition.
> >
> > Yeah, and for a micro-project it is more than enough if you only work
> > on the first two bullet points.
