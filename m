Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0725F1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 09:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfBQJcY (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 04:32:24 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50684 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfBQJcY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 04:32:24 -0500
Received: by mail-it1-f194.google.com with SMTP id m137so4638837ita.0
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 01:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DlEzlLAMdUb5vmMUGAm7bk/27hNR3nqCJmPPvouRZL0=;
        b=g9vgNgulkIjLRkMkgRV7d9XHq/eboVNFroe/5LVdUqj0IH1XLtT7w9JMfcoWlF3/Nf
         rwQ/9V8OAmsB0OPYRIio5PiRCbn2LGBokJYujwVbuBsuAthJjdJ2Bih4D6MP1pYAhtql
         AIa48Jm7Ljb3V6N7Oibrewd8n7u+7e4EXk7J2lFHnEEsmNh6Xj5oMVqzP4iyJ1zEP3Vy
         /BGTK2pTz0UDkbdm/NoYipK0PNNJuYekSbfnoX0v8bH/Xxg5eENi1IK55pqFRw2E6tFO
         uuB9eIB+92VsnlwfIfdGeI9k9Hi2zUgT6WAiewa3AlY7Zr6DtrQEqGzIuxrZwSevoRg/
         pYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DlEzlLAMdUb5vmMUGAm7bk/27hNR3nqCJmPPvouRZL0=;
        b=T0eo1ADSLfAqa1PIntefZ5yXMpRfwqDXb5qtkSyFGuzseuZMHbLXLnTevpHImAzdR/
         r3DJDlTmaW/nviAABTkwZofhqcrVtN1fiJGdeqF4530lPtncLuNWySqNTbweqOe1SIR6
         dxcVtb8rhxWoBsL3GKIGQ+/bKfNF3RPGeJHYAisSEESudlT06Ltv4KjP4WgNU26i9nIG
         v32R95qUvmJ/ahBUZme2A9khutg3SPw5OmtKioKe2Q/TY5QJxLoOvlM8UDWYSrD871Wc
         Y6gNx0GLGctHufgMHuYxT1fbtlccUqKGJj/ogd/lw8FVO4qxaQPNQgdti0Nzl6Jhzkk+
         xtMQ==
X-Gm-Message-State: AHQUAuac3ol3m747AlNxiB6I+ILUAykNB0gBuKjyebtM40P9KUId358S
        mLhpV23mAtJdq+yPlTECU9gTkJ3bO6xzA/wuBrc=
X-Google-Smtp-Source: AHgI3IZ60wp8cMCRrT3E8jXGWlaKfbbct2cXsYUPeabHXzjkbBlKTVYBtrPiX6wanHlRwVJGRC7Ilcb+mKYwlqdtdbA=
X-Received: by 2002:a5e:8416:: with SMTP id h22mr9861749ioj.118.1550395943203;
 Sun, 17 Feb 2019 01:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20190216114938.18843-1-pclouds@gmail.com> <20190216114938.18843-2-pclouds@gmail.com>
 <87wolzo7a1.fsf@evledraar.gmail.com>
In-Reply-To: <87wolzo7a1.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 17 Feb 2019 16:31:56 +0700
Message-ID: <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Introduce "precious" file concept
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 17, 2019 at 2:36 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sat, Feb 16 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> [Re-CC some people involved the last time around]
>
> > A new attribute "precious" is added to indicate that certain files
> > have valuable content and should not be easily discarded even if they
> > are ignored or untracked.
> >
> > So far there are one part of Git that are made aware of precious
> > files: "git clean" will leave precious files alone.
>
> Thanks for bringing this up again. There were also some patches recently
> to save away clobbered files, do you/anyone else have any end goal in
> mind here that combines this & that, or some other thing I may not have
> kept up with?

I assume you mean the clobbering untracked files by merge/checkout.
Those files will be backed up [1] if backup-log is implemented. Even
files deleted by "git clean" could be saved but that might go a little
too far.

[1] https://public-inbox.org/git/20181209104419.12639-20-pclouds@gmail.com/

> My commentary on this whole thing is basically a repeat of what I said
> in https://public-inbox.org/git/87wop0yvxv.fsf@evledraar.gmail.com/
>
> I.e. we have a definite problem here somewhere, and there is some
> solution, but this patch feels a bit like navigating that maze in the
> dark without a map.
>
> We had users report that the likes of "pull" were eating their data, but
> now with this iteration of "precious" only impacting "clean" the only
> problem anyone with the current semantics is still left unaddressed. My
> memory (I may be wrong) is that "clean" was just brought up (by you?) as
> a "what about this other related case?" in that whole discussion.
>
> So as noted in the E-Mail linked above I think the first step should be
> to enumerate/document/test the cases where we're now eating data
> implicitly, and discuss how that relates to the semantics we desired
> when the data-eating behavior was first introduced (as noted in E-Mails
> linked from the above, my own preliminary digging seems to reveal there
> isn't much of a relationship between the two).
>
> Only when we have that list of XYZ cases we're supporting now, and can
> see that XYZ is so important to maintain backwards compatibility for
> that we can't change it should way say "we eat your data by default
> because XYZ is so useful/backcompat, set 'precious' ...".
>
> But right now we don't even have the list of XYZ or tests for them (as
> my RFC "garbage" attribute patch revealed). So this whole thing still
> feels like jumping three steps ahead to me in terms of addressing *that*
> issue, but perhaps you have some orthogonal use-case in mind for this?

I'm not addressing the accidentally losing data in this patch. My
answer for that would still be backup-log, if it ever gets merged. But
this patch is about _known_ files that I want to keep when doing "git
clean", no more.
--=20
Duy
