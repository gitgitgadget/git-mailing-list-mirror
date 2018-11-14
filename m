Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12EEF1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeKNKC5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:02:57 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44932 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKNKC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:02:56 -0500
Received: by mail-vs1-f65.google.com with SMTP id g68so8448037vsd.11
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iFx7NEWK0NV7e35LjqaVJsIxTGbFwcUE3xku490/mi8=;
        b=kSJvZ8HaKr/viThpWAKiyq4XXiMLZcQ61woJci8hloh9wPvevtXjadrlClkBihrjBy
         ZqelQE1vBQehwTYeBzddIQqWm7i6uixFI/3dpaXW1MIA/k8YSemjG3NS+1RNOluiXKjH
         sQzMm5Fb/llJX334RRG8JYtQITiN1cncc2Tckf04U6K5Z22E77LWOdsiBwxPotjjoOgE
         gNCRyvvCvndiZJNUsjr3Z17HBDllkhSG3W1u3IZ+myEt2nasXSO9gqrirNrIstkxqnMY
         N4vrwwwXmzrAVuz9Ia+B6mAiCK1SKoxAUc1++O1kvTm2djaL0fIdEShbgxzjVcqPVhL0
         Q+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFx7NEWK0NV7e35LjqaVJsIxTGbFwcUE3xku490/mi8=;
        b=kH3A65yL+HNyNSPLYyh+0hb3Zu83VJiEWYLuB9uWV+wrI5ZsTl0304DBBiwenPUeKv
         d1kcn/KCxjfYbp2ezP2oFW0bVAG9NZHnQybZr1g+ZMZgvzM6DM4p2u6UY43BIRj/T5Vo
         0Zy6g0sU5AGI0/DcLJf8UQ1s8f+eP3MQ6Lp7ruChJ1F64Cy2HTCfXlELbTjul3hkT+YV
         y6aI5yr5Mf37mSJKacsZUq14CBQU7yAJo3NDr6HwTKbWp75L7oPY4KrxfYMNON8dcBzF
         Z2GJSldYDrNVZJ/FFkMJNPWfobkQllK7J6iIFOMOJrgJNyPTR8YDOXavHE3kQ7n7e616
         3t6w==
X-Gm-Message-State: AGRZ1gLO4qq+oby3khle3YIrjJB7DidNyZYmzkeWInmoOzcnSWfEhff6
        XJuTecgmt5gwWYNiAmcdTfZiPS7ibrvj9v3/coI=
X-Google-Smtp-Source: AJdET5ehL5t7+kEEsZQ3cwL6CXXi+scgasDw9TZFHsCQsVP4+gUF03FGamm0vEkFaZPXlywvfmpPMgWLZsV1ui8A7yY=
X-Received: by 2002:a67:3edc:: with SMTP id a89mr3331401vsi.136.1542153735527;
 Tue, 13 Nov 2018 16:02:15 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com> <20181111062312.16342-3-newren@gmail.com>
 <20181111063601.GB30850@sigill.intra.peff.net> <CABPp-BHwg2U=b+UGK2SufB7uZPmmiPVKXoTpYt+LuHnLwmwuZQ@mail.gmail.com>
 <CABPp-BFo=UvwbqV06R9PVEJ6JyEsvUCr4pe+3eQw8D2W96D96w@mail.gmail.com> <20181113233952.GA226088@google.com>
In-Reply-To: <20181113233952.GA226088@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Nov 2018 16:02:03 -0800
Message-ID: <CABPp-BGz1QuLkpBAEHFZY7krFdYPoZLZHYmufUH+PodLTN4zpw@mail.gmail.com>
Subject: Re: [PATCH 02/10] git-fast-export.txt: clarify misleading
 documentation about rev-list args
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 3:39 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Elijah Newren wrote:
> > Actually, no, it actually needs to be inconsistent.
> >
> > Different Input Choices (neither backslashed, both backslashed, then just one):
> >   master~9 and master~10
> >   master\~9 and master\~10
> >   master\~9 and master~10
> >
> > What the outputs look like:
> >   master9 and master10
> >   master~9 and master\~10
> >   master~9 and master~10
> >
> > I have no idea why asciidoc behaves this way, but it appears my
> > backslash escaping of just one of the two was necessary.
>
> {tilde} should work consistently.

Indeed it does (well, outside of `backtick blocks`); thanks for the tip.
