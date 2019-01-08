Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 983231F803
	for <e@80x24.org>; Tue,  8 Jan 2019 18:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfAHSNp (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 13:13:45 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42060 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHSNp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 13:13:45 -0500
Received: by mail-oi1-f195.google.com with SMTP id w13so4078375oiw.9
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 10:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dqxtech-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UVdFd5iI9OKNbZdWSMM5XOdwuFX3YdmVZAzmB5Mg4SU=;
        b=X6ug3RXlOG+U8Kh7zX43MztHehJjN0RE7P4xdAbXcF4KPl8/LkizucbhGLhvO/o2wP
         2nElQPMODcv4Jx1iuaEKPppMQ9ItgXTZELDZa3X1RkEzwgE3Ln9LsGpWcRRgiilzvRIK
         5pFHdiJZUjDvuV6I69rI5OfZTYHS2BbJEZBUkyc62Sd9NAo85Ef/7X2B5cEXt/XdMqU6
         Q074VVfdKp9za2pHPub7RaM/8ZeLEtkR+tTJRQDn0Nzbk2adBeB0pgv85yLAxmJHa8qP
         r8BhsNmyVMTFLzjVEGpExJBBMhz15kCGRM6g5qsKzneQqcmfL+ebXmEyjRulz1gpkwBt
         L56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UVdFd5iI9OKNbZdWSMM5XOdwuFX3YdmVZAzmB5Mg4SU=;
        b=hb1khNeEdf+3xz1KMWrUlwRJUzC1J+5aEorcbz7jHJk8DjeADfG234M8uo/orRPKFa
         aIoX7N+2Mv2N3G4goQAV6zOLNvZ9DJqP2lg7ryB2ZEklJv4twT249QOJFSzYnJncYGSz
         yHBHB0AD29ujl52BOYx4/m9eJAp5jyWPxEwyeQDbMrYx2ckPlulcakPJpzadtodbgppr
         GFDQBsYKv1W6zK8SFvtoW0+0hKRbwfOKzpf1afYkSRd6mhcVp5t4Xuk4TByZJhfrPxZC
         VK8nk41U3jBVP3r1t4vb7ODeIRBcDwPj62K9h8Pe864oGMeBnaIBY8YSu2Uo6gnpJTsP
         cuVg==
X-Gm-Message-State: AJcUukft0likFUpmV9dfNv/46l7eVkobL1q0Otmdre55U1gB1mTSYyJv
        ggOCMIrF2SKn+QuhTA1Iu+xg2kaQ1OM=
X-Google-Smtp-Source: ALg8bN7bRETfGjouIr4K9X9CYLt7SyIdd8Z34i+hjq44WbZOfvjT0iN5klcFlnuBEGg9PkG4+NsM5w==
X-Received: by 2002:aca:c186:: with SMTP id r128mr1916883oif.52.1546971224405;
        Tue, 08 Jan 2019 10:13:44 -0800 (PST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.googlemail.com with ESMTPSA id 14sm740692otg.68.2019.01.08.10.13.42
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:13:43 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 32so4298589ota.12
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 10:13:42 -0800 (PST)
X-Received: by 2002:a9d:4b15:: with SMTP id q21mr1927981otf.30.1546971222585;
 Tue, 08 Jan 2019 10:13:42 -0800 (PST)
MIME-Version: 1.0
References: <CAH0Uv3Eu7bGSVaJKu6kDjp0BPRe0yROucDfJ8QHV3X_ZjNJT7g@mail.gmail.com>
 <xmqq36q4berk.fsf@gitster-ct.c.googlers.com> <CAH0Uv3FRq0JiXWx9Ow1EhKrYB4OTM-9Fpox7FvZ3tC6J6toEsw@mail.gmail.com>
In-Reply-To: <CAH0Uv3FRq0JiXWx9Ow1EhKrYB4OTM-9Fpox7FvZ3tC6J6toEsw@mail.gmail.com>
From:   Andreas Hennings <andreas@dqxtech.net>
Date:   Tue, 8 Jan 2019 19:13:31 +0100
X-Gmail-Original-Message-ID: <CAH0Uv3F4q0oPG2O58eTV5n+5eZcxHK9acGMX+4F4LTm1JATfhg@mail.gmail.com>
Message-ID: <CAH0Uv3F4q0oPG2O58eTV5n+5eZcxHK9acGMX+4F4LTm1JATfhg@mail.gmail.com>
Subject: Re: Feature request: --preserve-merges to add "exec git merge ..."
 instead of "pick ..."
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I tried this option after upgrading my git.
Unfortunately, no matter which variation I use, it still attempts to
rebase most or all of the feature branches before merging them.
Possibly depending on their ancestry.


On Mon, 7 Jan 2019 at 22:12, Andreas Hennings <andreas@dqxtech.net> wrote:
>
> It sounds good!
> I was using git version 2.7.4 all the time. I should have checked
> before posting here :)
> Now trying 2.20.1
>
> From "git help rebase":
>
>            By default, or when no-rebase-cousins was specified,
> commits which do not have <upstream> as direct ancestor will keep
> their
>            original branch point, i.e. commits that would be excluded
> by gitlink:git-log[1]'s --ancestry-path option will keep their
>            original ancestry by default. If the rebase-cousins mode is
> turned on, such commits are instead rebased onto <upstream> (or
>            <onto>, if specified).
>
> I am not sure if this criterion (which ancestors it has) will always
> produce the behavior I am looking for.
> I will have to experiment a bit.
>
> Thanks for now, I will post again with new thoughts once I have done
> some experiments.
>
> On Mon, 7 Jan 2019 at 17:42, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Andreas Hennings <andreas@dqxtech.net> writes:
> >
> > > This means we need a rebase operation where:
> > > - The commits of the acceptance branch itself are being replaced.
> > > - The commits of the feature branches remain as they are.
> > >
> > > A "git rebase --preserve-merges" almost does this, but not really.
> >
> > This wished-for feature sounds to me more like the "first-parent"
> > mode that has been discussed a few times in the past but never
> > materialized.
> >
> > The preserve-merges mode is getting abandoned by the original author
> > as unsalvageable.  Have you tried the rebase-merges mode?  That may
> > let you choose replaying only the merge commits on the acceptance
> > branch without touching the tips of the feature branches getting
> > merged.
