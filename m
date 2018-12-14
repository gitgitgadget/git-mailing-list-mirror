Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4BD20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 17:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbeLNRiz (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 12:38:55 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44029 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbeLNRiz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 12:38:55 -0500
Received: by mail-io1-f68.google.com with SMTP id l3so5033984ioc.10
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 09:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mNbUKOjXGfLJroMOnxXeCm5EoRuYDMKlORs3IdJbUqQ=;
        b=lsOBlVik1YbAKo/q1JkkwC3ncyvzwYHlntcZjVpkzPIQoA3HlAUVDZp/PqG4B8P4t+
         UQrjDA+mZPQMmR48JEJhO6JkMcVfNmAlFGJQmTy4zLBwt4R/glksmKiEi7myg+q9tWK1
         pE2z8FK8kkroNITJAGl0ZeY2xIzLF2bXghTIVDYWDK+jvTBLU+e9BxBl6MMoTet0nKPK
         amxK+LBCHgx631rVpQfa48rlIp9LrpoZPRa1xyXS74fBtXBkHuuLr8OO9LwIqZ47Wyxd
         Ao0U0axKxtLySyHFVkEITWqicl4m7Fy4hm34E3ZeEmreIlx1TWkqpDN7vdwbz5LjfeA+
         vyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mNbUKOjXGfLJroMOnxXeCm5EoRuYDMKlORs3IdJbUqQ=;
        b=qvM4JhPyTCyXXgKJTocy5xKtiM1svdAVWntn6HyLfeJxZSNF8eJMO/xwgYErbT6XT/
         IBU6esYfxDigE09yY5qFOpArbenHuYUT7X1sJZMLnZfLP6uwmM0ICjOtmigCX61B682r
         zMNkyNgiPvJpkT7lsn/QLj6oztwdeMDNFkd+lBL4+LfjDdLMufiD9NbT1GyouH4jv/qw
         qziB54psZ/zwn+82tAIAg9cEd9cYE1SQ75bB5CLxnCai7KHah9ejrkqo4Ng9WsTqe8UE
         xwC9evM/PTJNiLsflxwmP5rluWLIBUUrxa1njjzzKrvdClstJjV1Ncs/PoPTO3AS/BfJ
         bkWQ==
X-Gm-Message-State: AA+aEWatIxGqvCpesMhfvnAiq1agGpuInOdiHxnNya4IpI5cqz7bmvfH
        qCO+ydjbmHS0NrXzOB8Y2eCiGLGIQxztWJsnWYVVqQ==
X-Google-Smtp-Source: AFSGD/UIJrkw9lnibw3jKgcCCVBfXXI6HmjhmLvXm8/fqnEFY3cDrI2zUJ8zrIe2Jdp8t1zrFp7gWVxK4EsM5Dd/kV8=
X-Received: by 2002:a6b:6f05:: with SMTP id k5mr2827450ioc.282.1544809134596;
 Fri, 14 Dec 2018 09:38:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.100.git.gitgitgadget@gmail.com> <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
 <CACsJy8AsRT+k4kdwC3gGjDOPiDn-L0GJs7-SQHb88Ra_gt4OcA@mail.gmail.com>
 <CANoM8SVMYBRg-nL4r=JJDFU_qZ=grzSmRs-B2nLYUnv5kFc00Q@mail.gmail.com>
 <CACsJy8Bj=8xHp3JA8dLbyM=RwJey7utMK6DTVe_0AjBNVHxJyg@mail.gmail.com>
 <CAGZ79kYnQPhGMStmKSFb5_4Ku-nv54nHwta==jE82ZR4NOPETA@mail.gmail.com>
 <CANoM8SWQTAEYGiUC9PnWi8u9oAJYPcyiE5+5usoRvR7Vw2z0JA@mail.gmail.com>
 <CA+P7+xonxvfuhw4W+FUL87We8CaOwxsndFkN5bcgBhdsnZ5QAg@mail.gmail.com>
 <CACsJy8D9qfBLOUCyca+ws66uHx_tgoFZSTbTBxxW2fRQmyr_Nw@mail.gmail.com> <CA+P7+xoxE0o=5fMQrDoyCgWMQ-By2t1LdApecRDWmoXXCfnFuw@mail.gmail.com>
In-Reply-To: <CA+P7+xoxE0o=5fMQrDoyCgWMQ-By2t1LdApecRDWmoXXCfnFuw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 14 Dec 2018 18:38:28 +0100
Message-ID: <CACsJy8CT8K9SHnTsJT4HrxAK95yTz-x2DnNRBYKkvMyGbBZCgg@mail.gmail.com>
Subject: Re: [PATCH 1/1] worktree refs: fix case sensitivity for 'head'
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Mike Rappazzo <rappazzo@gmail.com>,
        Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 6:22 PM Jacob Keller <jacob.keller@gmail.com> wrote:
>
> On Thu, Dec 13, 2018 at 11:38 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > Even with a new ref storage, I'm pretty sure pseudo refs like HEAD,
> > FETCH_HEAD... will forever be backed by filesystem. HEAD for example
> > is part of the repository signature and must exist as a file. We could
> > also lookup pseudo refs with readdir() instead of lstat(). On
> > case-preserving-and-insensitive filesystems, we can reject "head" this
> > way. But that comes with a high cost.
> > --
> > Duy
>
> Once other refs are backed by something that doesn't depend on
> filesystem case sensitivity, you could enforce that we only accept
> call-caps HEAD as a psuedo ref, and always look up other spellings in
> the other refs backend, though, right?

Hmm.. yes. I don't know off hand if we have any pseudo refs in
lowercase. Unlikely so yes this should work.

> So, yea the actual file may not
> be case sensitive, but we would never create refs/head anymore for any
> reason, so there would be no ambiguity if reading the refs/head vs
> refs/HEAD on a case insensitive file system, since refs/head would no
> longer be a legitimate ref stored as a file if you used a different
> refs backend.
>
> Basically, we'd be looking up HEAD by checking the file, but we'd stop
> looking up head, hEAd, etc in the files, and instead use whatever
> other refs backend for non-pseudo refs. Thus, it wouldn't matter,
> since we'd never actually lookup the other spellings of HEAD as a
> file. Wouldn't that solve the ambiguity, at least once a repository
> has fully switched to some alternative refs backend for non-pseudo
> refs? (Unless I mis-understand and refs/head could be an added pseudo
> ref?)

No I think "pseudo refs" are those outside "refs" directory only. So
"refs/head" would be a "normal" ref.

> Jake



-- 
Duy
