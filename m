Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA0A11F462
	for <e@80x24.org>; Sat, 25 May 2019 10:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfEYKXW (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 May 2019 06:23:22 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35837 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfEYKXW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 May 2019 06:23:22 -0400
Received: by mail-it1-f196.google.com with SMTP id u186so17447684ith.0
        for <git@vger.kernel.org>; Sat, 25 May 2019 03:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AuNeg7U9VrcFBfV8ZRmXAYb47V4TifQomw06wF9UkZo=;
        b=kPL1HLc5brB04qZn8AB6XU8zs+3Bhh6y4u8BVpQ32KuVk3SF2niZyHzUzzPJPsoxXn
         20W2cAk6I9ujo9wBPKvUcTHpzcFja+fUhHSUmgH8J4soqEYrCLeNRemh0hS/tJKilcpH
         uusN6gTF3j9nkXwughv+254mcjGMYBI2W+6wYFHD9uUwd309cdJ9IQRkHxyvTzC/X3T6
         RDUB9Lkxy/RuWqyso7DR0dkRPcNGVTf7Y2QMXLdEAf6PgABHdxLbr5mMJzgcnX7h+97y
         rt0pP+/Dae6YD8d7Tne5HGLPOJ/lqeDG19Bw+Wlalk1lejayk3AlhTZZkDh3dcNLMelW
         T3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AuNeg7U9VrcFBfV8ZRmXAYb47V4TifQomw06wF9UkZo=;
        b=f/iqgH1DZXB3ZDN+DBWw45j03rxrOBk17rOlN0R2JGJEnwARtlbVZflbJOOhldqWDk
         vKw7WfRzg9+k3GL6ufRm4ar+6wys9Y3itcdQ+7j4DeCNbBGSeKTOCObqHbaO7ZJmtquB
         bY8b/G3Sg99meOCgOcam5vgPTnMjfNzXlFgiSdg1ex2y8zzmdGCzRxhVmI4P93iv6eno
         +fc9Dvl0VogY4KqiCzkI+iJ/QujMaX9Q8u2QGidxuu6jRxIJyCMYjaw1QAsuZa9Q2Wy5
         JAcMvgLF50wNNFRvIQJ4Ooh6+nTBylrJaRq1smLBH+ruS1b/Drl7FNRo0JEK5ANtvI+j
         uWFw==
X-Gm-Message-State: APjAAAUPVwJWttHGoQph1fwONBdQpaiRsk8qfIXifhENjngNtz2ulqDB
        o9IlLt0wNFg25/0myoHXNhqFvmPFKuMuVDgT404=
X-Google-Smtp-Source: APXvYqxvYs4y3dko2DltXAqq03Oqz9JCj6aHsRDDderZY9XDu2DArBvyozjFFRaBeH4Xd5Ros+Ue9t8IcGWY3DnmMmM=
X-Received: by 2002:a24:194c:: with SMTP id b73mr21018041itb.157.1558779801376;
 Sat, 25 May 2019 03:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190524092442.701-1-pclouds@gmail.com> <20190524173642.GQ3654@pobox.com>
In-Reply-To: <20190524173642.GQ3654@pobox.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 25 May 2019 17:22:54 +0700
Message-ID: <CACsJy8AgstSQKnAVf7Krg8yn03ewBw0mhOWq=CgYER-6tA8ptw@mail.gmail.com>
Subject: Re: [PATCH 0/3] fix diff-parseopt regressions
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bryan Turner <bturner@atlassian.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 25, 2019 at 12:36 AM Todd Zullinger <tmz@pobox.com> wrote:
>
> Hi,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > This should fix the diff tests failure on s360x. It's a serious problem
> > and I plan to do something to prevent it from happening again.
>
> Thanks for looking at this!
>
> I applied this on top of master/2.22.0-rc1 and see a number
> of compiler errors using gcc-9.1.1 with fedora's standard
> compiler options for rpm builds.

That last patch 4/3 is not meant to be applied. Yes I've seen similar
compiler errors too. We have some cleaning up to do in order to build
with the last one. But I think there are no other serious errors
spotted by the last patch (there's one in builtin/column.c, but I
think nobody uses it much, so we can fix it alter)
--=20
Duy
