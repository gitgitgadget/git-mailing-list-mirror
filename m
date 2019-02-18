Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 478511F453
	for <e@80x24.org>; Mon, 18 Feb 2019 10:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfBRKPO (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 05:15:14 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40269 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfBRKPN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 05:15:13 -0500
Received: by mail-it1-f193.google.com with SMTP id i2so39746916ite.5
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 02:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9X3WL77pTzFhpoNnSmIcmxxn8aRd/josZwekHNhOd8o=;
        b=LhuF5rFYVcqL2PGmZl+tL4QyhLM1rfnOPFSohqiaoDTmLDzPso1MYzG8w89tiIQMos
         /leeTgqF4/hI7QUCnJIU87RgPwujjy7EA+ceR7gxksRlj8hnCWkDxaSwnnsCwRca7Y5w
         6T/fwrkdcK46Yo9sryjBcuxrCky4S0aDN1URun1o4R5CJOTXRres1Jd7jn7ZfvUZ2bX0
         85okxpFiLsAeS3vFe2eGthDRjXehtAG7x2HshxZ6jOCG576n+d+UqcEjdiIqtrOg1ITG
         mO5yOP2NmIL8jiTBFfx+o/6bX4oeSi2QfMBajf7o/1xz73WDE/JnNthy7DpeKxv7FJ8E
         LyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9X3WL77pTzFhpoNnSmIcmxxn8aRd/josZwekHNhOd8o=;
        b=YWibL6ZedS+v39h45jZ15Nv0Rasp0O1BjvGHb8tG7c/c5p74xSfGxD6MAPqgN/QeY4
         VvOx5VX8Yc1+f4Ib/GCVP8iEZ3/hUhyzskLmyeajgtGhhYF6KtHsDKKHCEkvnZ7Bi+JV
         tdeMgwZvJvJIBuiz8BCCg1GKeY+O1CCUvkBxFJLN63MMHaLihYOM431dbxETDKQlEik4
         HYKD5Y6uN0KPCs2rag6RA/z/7PsHrTPKpFuwSKy3Y2kkjUxIPjHmYkNGE1U72/cK3tnI
         L81NoIDscsi9dNoatis+AHh1J8EZk17iUG6iGXWauYIHPK+6fvyhSl529vgF8ioog4qg
         coOQ==
X-Gm-Message-State: AHQUAubI0GHDoDK1iPPTOLKjKzgfbVvHh7BxvjhXnwcoV4zJET1u7A9c
        QG1kNEnZfSREouD5a4unA8BsPcZLmaeXF/ZF5Uw=
X-Google-Smtp-Source: AHgI3IZGUUVBrFrkcxeFwNYcAoWT7a/U1JO5w8upVk0sO8xpB1yji9/xSF9iM7/be1M+ruOf+x1hG3Sf/sZoJrVX4yA=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr11452838ioc.282.1550484912674;
 Mon, 18 Feb 2019 02:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20190216114938.18843-1-pclouds@gmail.com> <20190216114938.18843-2-pclouds@gmail.com>
 <87wolzo7a1.fsf@evledraar.gmail.com> <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com>
 <87va1ho222.fsf@evledraar.gmail.com>
In-Reply-To: <87va1ho222.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 18 Feb 2019 17:14:46 +0700
Message-ID: <CACsJy8CpRWNzHBk4qGf-5BVBUDuE4HpuKvftvh3E1DC_pNcBKA@mail.gmail.com>
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

On Mon, Feb 18, 2019 at 4:53 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sun, Feb 17 2019, Duy Nguyen wrote:
>
> > On Sun, Feb 17, 2019 at 2:36 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >>
> >> On Sat, Feb 16 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> >>
> >> [Re-CC some people involved the last time around]
> >>
> >> > A new attribute "precious" is added to indicate that certain files
> >> > have valuable content and should not be easily discarded even if the=
y
> >> > are ignored or untracked.
> >> >
> >> > So far there are one part of Git that are made aware of precious
> >> > files: "git clean" will leave precious files alone.
> >>
> >> Thanks for bringing this up again. There were also some patches recent=
ly
> >> to save away clobbered files, do you/anyone else have any end goal in
> >> mind here that combines this & that, or some other thing I may not hav=
e
> >> kept up with?
> >
> > I assume you mean the clobbering untracked files by merge/checkout.
> > Those files will be backed up [1] if backup-log is implemented. Even
> > files deleted by "git clean" could be saved but that might go a little
> > too far.
>
> And I suppose if we have some mechanism for "don't backup but error out
> if it was detectes as needed" we'll have the equivalent of inverting the
> merge/checkout --force behavior now (& my "garbage" patch), i.e. we'd
> stall on potential clobbering and need to carry on with --force.

Yes that's another way to go.

> > [1] https://public-inbox.org/git/20181209104419.12639-20-pclouds@gmail.=
com/
> >
> >> My commentary on this whole thing is basically a repeat of what I said
> >> in https://public-inbox.org/git/87wop0yvxv.fsf@evledraar.gmail.com/
> >>
> >> I.e. we have a definite problem here somewhere, and there is some
> >> solution, but this patch feels a bit like navigating that maze in the
> >> dark without a map.
> >>
> >> We had users report that the likes of "pull" were eating their data, b=
ut
> >> now with this iteration of "precious" only impacting "clean" the only
> >> problem anyone with the current semantics is still left unaddressed. M=
y
> >> memory (I may be wrong) is that "clean" was just brought up (by you?) =
as
> >> a "what about this other related case?" in that whole discussion.
> >>
> >> So as noted in the E-Mail linked above I think the first step should b=
e
> >> to enumerate/document/test the cases where we're now eating data
> >> implicitly, and discuss how that relates to the semantics we desired
> >> when the data-eating behavior was first introduced (as noted in E-Mail=
s
> >> linked from the above, my own preliminary digging seems to reveal ther=
e
> >> isn't much of a relationship between the two).
> >>
> >> Only when we have that list of XYZ cases we're supporting now, and can
> >> see that XYZ is so important to maintain backwards compatibility for
> >> that we can't change it should way say "we eat your data by default
> >> because XYZ is so useful/backcompat, set 'precious' ...".
> >>
> >> But right now we don't even have the list of XYZ or tests for them (as
> >> my RFC "garbage" attribute patch revealed). So this whole thing still
> >> feels like jumping three steps ahead to me in terms of addressing *tha=
t*
> >> issue, but perhaps you have some orthogonal use-case in mind for this?
> >
> > I'm not addressing the accidentally losing data in this patch. My
> > answer for that would still be backup-log, if it ever gets merged. But
> > this patch is about _known_ files that I want to keep when doing "git
> > clean", no more.
>
> Indeed. My concern is that we're making incremental steps without a
> clear idea of the end state, and once we get there we might find that
> some steps along the way box us in or weren't what we wanted to solve
> the overall UX issue.
>
> More so in the CL / commit message not describing where we are overall,
> where this patch fits in (backup log, etc.) than this whole thing
> (backup log is already 24 patches) needing to be sent as one giant
> series...

Not seeing the overall picture is probably because I don't have any.
Both backup-log and this precious attribute are more at plumbing level
that could be combined to make something, but no I don't have the
whole final UX worked out. The end game for backup log may be "git
undo" (or just --undo option across commands). The "precious"
attribute does not exactly have any role in "git undo" picture. It's
just refining the file classification (untracked, tracked, ignored)
that we have although it could be used as hints for "git undo". That's
all I got.
--=20
Duy
