Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C759D1F405
	for <e@80x24.org>; Tue, 18 Dec 2018 15:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeLRPvw (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 10:51:52 -0500
Received: from mail-vk1-f177.google.com ([209.85.221.177]:46656 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeLRPvw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 10:51:52 -0500
Received: by mail-vk1-f177.google.com with SMTP id j23so3771642vke.13
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 07:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=27yAvov3z/VLF454+l8QMEOKx3zkqhxDSC+reIrQzvs=;
        b=l/BlRjjNPAZnnFR1Y0AGdOes7ygpRjSMAz2o4qq3zuYca3el9dywasWIYjyLeAcP83
         SwlZQ2W1paWo2dYQAlhdOp6PGaZniPGauBn+gMrmOhXtTTTqwls8xmK0RX5/MoUD+Wke
         5FzzbaFHPihNo1aG1hpWr82esOHpkY0o2sxZhrTY5iJpL/xI76p59s2oi+rz8FY2eE+t
         YiEeXZyYsElDmO6DBrI9k2ET2k8fPRpUWT/+0GYlckZobQYdI+lvQZYt24CsBIu52o/W
         rGqHQH8BcWxBAFd7FUlLwpdzKyEsw5NGFMoGG7cHRF0erjlG03Oi0M6CbRVYMm/Ra0Oc
         G5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=27yAvov3z/VLF454+l8QMEOKx3zkqhxDSC+reIrQzvs=;
        b=aKktaFB4US4aesNj8rOGxW3BdtqRZSE+AzS+DpY+cH1WFhhQSHuDFwtquNerO/5Pdh
         y31l+8EAzQhQYl9F1V2gj6bgA4bJk1dnFbLTe1f5WaqayYX4Ipm4ulZ2LkGom26zVyWH
         mkZY3IK0ynnfCQ+bPJyXMPrCEyM+8xogbJ9AurtEMTrD66J4r3RThHSwb2qyem7PCaTF
         LZz13cquA/fFwMZjvifuaYKGiiLai9JmvPnjFsMEmJilwHOGcio2U6H1VM4kYw6THCu9
         9kxnu/uODoOSZcKNTkCdZZPD5p9k0qcaBlDjqLLQ3PKhKPEDk7DWMe1MdACYBNdEGUbz
         QZPg==
X-Gm-Message-State: AA+aEWaixZTAeP1K45HNx5T6g6Qw3loQ2Q59N4dle+qWUv16lid7lkfw
        UEU4JnTtLols8D1Tob8/zD78qqC7sQXAbQkxv5o=
X-Google-Smtp-Source: AFSGD/X4jgc7tcqxmE9/lsOmjoi7dkKl5YA+swiZ/QT71WIBq7DrKv7fiCXcGkt1d6N23f3g1YAV58xHKxYbNl0vmkE=
X-Received: by 2002:a1f:e7c5:: with SMTP id e188mr7415592vkh.92.1545148311082;
 Tue, 18 Dec 2018 07:51:51 -0800 (PST)
MIME-Version: 1.0
References: <CAG2YSPzmN5u1uAPVbjsqC3LzVVinFR21-_6wfrkBHdPWhOfMfQ@mail.gmail.com>
 <CACsJy8ANoiWfmLkmO9ACab5H+m2c2y5uhKBJzGNwwxcs9zV0wA@mail.gmail.com>
 <CABPp-BE9+qqVfccwzofD0qFecTGo2EjighNSu0vh-rF_8F5PoA@mail.gmail.com>
 <CACsJy8BFoK4hoXrSUi+P3xB1LumevvFe6XWAM2fLUq-UGNUs8A@mail.gmail.com>
 <CAG2YSPy85YtAv6m5WR4ZrsZ4TRzgcyrC4DNZnOONtFD6MsH=YQ@mail.gmail.com> <20181218131429.GE30471@sigill.intra.peff.net>
In-Reply-To: <20181218131429.GE30471@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 18 Dec 2018 07:51:39 -0800
Message-ID: <CABPp-BG0Urp7aRfcsTAhmpWOR-8K5xuZc=5fGjpowgKw1C8X6Q@mail.gmail.com>
Subject: Re: Can git tell me which uncommitted files clash with the incoming changes?
To:     Jeff King <peff@peff.net>
Cc:     Mark Kharitonov <mark.kharitonov@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 18, 2018 at 5:14 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Dec 17, 2018 at 05:50:31PM -0500, Mark Kharitonov wrote:
>
> > Guys, having git merge --dry-run would be great, but I am OK with git
> > merge for real as long as its output is parseable.

Don't rely on that.  merge output has changed occasionally and will
likely change again in the future multiple times.  The other solutions
provided by Peff and Duy are much better.  If we need to add more
options to provide you with what you need, then that's a route we can
take, but I'll make no guarantees about merge output being stable and
parseable.

All that said...

> > However, somewhere in between git 2.18 and git 2.20 the output of
> > merge changed and now I do not know how to parse it.
> > it used to be something like that:
> >
> > bla bla bla
> > <tab>file name 1
> > <tab>file name 2
> > ...
> > bla bla bla
> >
> > But now, the files are output in one line and given that some files
> > may have spaces in the name I do not see how this can be parsed. If we
> > could have easily parseable output of merge, it would be enough for
> > me.
>
> Interesting. I don't see that behavior at all. E.g., running this:
>
...
> I see:
>
>   error: The following untracked working tree files would be overwritten by merge:
>         one
>         three
>         two
>   Please move or remove them before you merge.
>
> I wonder if it has to do with Windows.
>
> If you can reproduce it at will, can you try bisecting between v2.18 and
> v2.20 to see which commit introduced the change?
>
> -Peff

I see the same as Peff, and I see no changes to
unpack_trees.c:display_error_msgs() since git 2.11 (not even in a
clone of git-for-windows), and as far as I can tell that function is
the place that prints all the files and adds the newlines, so I'm kind
of perplexed how you're seeing things print multiple files on a line.
Bisecting as Peff suggests would help but I'm curious if there's
something special about your setup needed to reproduce and which
changed since you were using 2.18 (e.g. always forcing output through
a pager and having a pager that doesn't understand LF and requires
CRLF to display things correctly??)
