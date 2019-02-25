Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D79120248
	for <e@80x24.org>; Mon, 25 Feb 2019 20:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfBYUkz (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 15:40:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40910 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfBYUky (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 15:40:54 -0500
Received: by mail-ed1-f66.google.com with SMTP id 10so8753235eds.7
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 12:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rR0g8IkmO0ITrF4s8bL43VwnIUDIAJY4crTtKent3so=;
        b=QR/pfRpe7XdYxMrqhB3pTe+R+HkklSYSwPBfHDLYBKXiArgOWuLm9eYWslmEQuO2G6
         uPU3ODRLVo1neSZP6IIwDRAmfHXIeUmfGyScgvkH72A9MHBpU83rFbsMsppPijLsrM6c
         c626mU8C45GLGeYGAupS/a3TBL7Asl+Gmkcp3TQ+Jdk/T7nIxgY3eve8RWkPaPd5GJnT
         1eL6WWqoKS49kz5Vyb8hLdJChGduW6XwcxhhukAr9mNI99Q+2J7MbVZoRDD3JCdVPIKt
         skDkcm5BkEtSk922RQsbcnnLluHfq3Wy1R9CXEPpJUbQWx7fwv9U2ADMS2mM1RGcU77G
         xbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rR0g8IkmO0ITrF4s8bL43VwnIUDIAJY4crTtKent3so=;
        b=aBA8/TsSYeTW9h4rojmJSjOWxIkZzrwpimygRNgv1rEQk0qG/sL8UHBX8RWMXMTMFD
         0I13nuYzHqaGEJT2WIpinClSFC6rQC4QB8Il2EcvkQXq83FKLeqc2EFzxinqD9ehH1xL
         vDU+GsfaKGlMzFw/vd0csWF7VGm/Rqr5Lbgx955Y9HhddLsx0BPXTSnCBaFhtu1b1ZuV
         k7t3SILcyWKzUVEKuQnniLmrmHVHXncJJgpL3kGXKS7yFjs80hN/tLj6WwqDX3nDL3I+
         4CK5As7B1d+DqjF1Qqs82bKrxfApvgvJ14sC4xMFFWZiKTvTK3CAgRf+gpZAg/Sz6Kq7
         joXg==
X-Gm-Message-State: AHQUAuZJT3L9l20N6ps6FAjwzznjQ9EhelW7Oj2wXZUse84ioPOiEPN7
        CBtaPpDodW+F38CBxHigxhuh6lCWl9ZLxsSBm7I=
X-Google-Smtp-Source: AHgI3IaruQ8EDrc5MCf0wLCTScdV5YhJI8bIADNFQAN1L++8HC54cff3ofiP/fiCf0XSHhqB3R7RGUARikIsHzxvHSE=
X-Received: by 2002:a17:906:52d5:: with SMTP id w21mr14282314ejn.172.1551127252620;
 Mon, 25 Feb 2019 12:40:52 -0800 (PST)
MIME-Version: 1.0
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
 <20190223190309.6728-4-matheus.bernardino@usp.br> <87va1a3z8e.fsf@evledraar.gmail.com>
 <CAP8UFD2LLL+V54k3XmHzmg5t1zanpAvY_=7GqXL43vLPTTmuww@mail.gmail.com>
 <CAHd-oW4P-aAKH0_kKrOJeprWmvPCUfa++X3pSNYSQisAV-25HA@mail.gmail.com> <87zhqk5fnf.fsf@evledraar.gmail.com>
In-Reply-To: <87zhqk5fnf.fsf@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 25 Feb 2019 21:40:40 +0100
Message-ID: <CAP8UFD2xrfMHNxcmeYf8G+d53SL26N07FFAoDP+e0h3r-tvKQw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 3/3] clone: use dir-iterator to avoid explicit dir traversal
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 25, 2019 at 11:25 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Feb 25 2019, Matheus Tavares Bernardino wrote:
>
> > Hi, Christian and =C3=86var
> >
> > First of all, thanks for the fast and attentive reviews.
> >
> > I am a little confused about what I should do next. How should I
> > proceed with this series?
> >
> > By what was said, I understood that the series:
> > 1) Is indeed an improvement under --local, because it won't deference
> > symlinks in this case.
> > 2) Don't make --dissociate any better but as it is already buggy that
> > would be some work for another patchset.
> > 3) Makes git-clone copy hidden paths which is a good behaviour.
> > 4) Breaks --no-hardlinks when there are symlinks at the repo's objects
> > directory.
> >
> > I understood that even though git itself does not create symlinks in
> > .git/objects, we should take care of the case where the user manually
> > creates them, right? But what would be the appropriate behaviour: to
> > follow (i.e. deference) symlinks (the way it is done now) or just copy
> > the link file itself (the way my series currently do)? And shouldn't
> > we document this decision somewhere?
> >
> > About the failure with --no-hardlinks having symlinks at .dir/objects,
> > it's probably because copy_or_link_directory() is trying to copy a
> > file which is a symlink to a dir and the copy function used is trying
> > to copy the dir not the link itself. A possible fix is to change
> > copy.c to copy the link file, but I haven't studied yet how that could
> > be accomplished.
> >
> > Another possible fix is to make copy_or_link_directory() deference
> > symlink structures when --no-hardlinks is given. But because the
> > function falls back to no-hardlinks when failing to hardlink, I don't
> > think it would be easy to accomplish this without making the function
> > *always* deference symlinks. And that would make the series lose the
> > item 1), which I understand you liked.
>
> I don't really have formed opinions one way or the other about what
> these specific flags should do in combination with such a repository,
> e.g. should --dissociate copy data rather than point to the same
> symlinks?
>
> I'm inclined to think so, but I've only thought about it for a couple of
> minutes. Maybe if someone starts digging they'll rightly come to a
> different conclusion.

And maybe one day we will find a very good way to take advantage of
symlinks in .git/objects/ when Git is used normally, but that will go
against what we have decided now, though we have no real need at all
to decide now.

That's why I think it can actually be a good thing not to decide
anything now, and to let us free to decide later.

It's kind of the same as with short options versus long options. It's
a good idea not to use up all your short options too soon (in the name
of current ease of use), and instead wait until people really want a
short option for one option they use really often before attributing
it to this option.

> Rather, my comment is on the process. Clone behavior is too important to
> leave to prose in a commit message.

The same argument could be made to say that what happens in
.git/objects/ when cloning and there are symlinks is too important a
still free design option we have left to give it up right now for no
good reason.
