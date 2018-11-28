Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E4AA1F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 00:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeK1LAY (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 06:00:24 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:50980 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeK1LAY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 06:00:24 -0500
Received: by mail-it1-f181.google.com with SMTP id z7so1569594iti.0
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 16:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fWwAQZzJ3WAl1Wt62I8noLZZ4OJgupIqOfIlYOYs26A=;
        b=wCrZM867/DxWrvrplD74MjcF/LkkwgVeec+G9yliaeJHG+D7Em6/G1ghW4d6s9XtZ2
         LFjcmCtOxfnAny4yO6voFq4Irvxq19pgPigFk4ekgxJLFtmAl8kAEkS55u2h3Chp2RtA
         Wm856swBVBbXtAgmVPGNkNl68Xi95Z8B0GELsZ+bcGU3IzWd045zSA+A7eI1zOciuegT
         ixJOHbIXZm6zB3IVB+2a17jkK1+5ZbhZVt2zeeAcKd8GFr98au9Rnv9FN9nIOE1ZsfIy
         clrx9L0JfKm9+zIndlEIn82Rb301BzbS+Xr2Y3/TYqWOTvTjOol2/3XLSOPZKJLauiY5
         5/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fWwAQZzJ3WAl1Wt62I8noLZZ4OJgupIqOfIlYOYs26A=;
        b=CA9tHqzgFUxeA706rNLvg5aWs/xsu0lNUrywMS98238/g3wJa4an/s0Q95tKznXl/V
         xiV4AwFE2Epv3e3F4doiZfcZOfz6Ak6PH9GAh7o2Q+WQGBOegkOvPWu3/RvodpOhx2SU
         F+SFoRxZhJOfS8xtcHK7oUpH86gN3k9Juq6BXUUVe8c9MyvD3rebsfocvTwr2EeyHvtS
         PR/f6MfI2/unTr5MHLWA4tmD7dXJrEtHOnbwZNKaFQLKFj2Vz+DQ2dn060mHuX88ZtRx
         a9u0seKlKYjHQkwlM0p4CplRzBWgAih64+eTg6URoBpyWyEUjM/xThHBXEBQWvKJ4wpg
         WD5g==
X-Gm-Message-State: AA+aEWYk2v8n+U77RTxFFvS2NpuPQFhzAeIhHrQPxUo2lGQtk1Hq5/eV
        84cdrSP4pxCqBnG28JAVJK89PMeVNc4nII7OT6hvwyo+dkw=
X-Google-Smtp-Source: AFSGD/U1FeP1n77hFQidyRo5pp4F1naEoJEcxOafoCVX1sIRUz2tqBwSKdBi7FvoZHyqGcuFSKgIs4mSce5P7opcd3M=
X-Received: by 2002:a24:cfc1:: with SMTP id y184mr972935itf.72.1543363248782;
 Tue, 27 Nov 2018 16:00:48 -0800 (PST)
MIME-Version: 1.0
References: <CAGyf7-F6BiqSa7LOWxvHZPfO+UaohQR78rCgvN9En+1P4du2Nw@mail.gmail.com>
 <87efb6ytfj.fsf@evledraar.gmail.com>
In-Reply-To: <87efb6ytfj.fsf@evledraar.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 27 Nov 2018 16:00:37 -0800
Message-ID: <CAGyf7-F-zs9Xyx623HizpOrv80y3PydReFYw-64w3T7Xfr3CNg@mail.gmail.com>
Subject: Re: Forcing GC to always fail
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 3:47 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Nov 27 2018, Bryan Turner wrote:
>
> >
> > Is there anything I can set, perhaps some invalid configuration
> > option/value, that will make "git gc" (most important) and "git
> > reflog" (ideal, but less important) fail when they're run in our
> > repositories? Hopefully at that point customers will reach out to us
> > for help _before_ they corrupt their repositories.
>
> You could fix this and so many other issues by just hanging up a "Is
> This Good For The Company?" banner up in Atlassian offices .

Not sure I understand what this means, or what your goal was in saying
it. No one inside Atlassian is running these commands. I'm trying to
help save administrators from themselves, which reduces real world
end-user pain that comes from decisions made without fully
understanding the consequences. It feels like this comment is mocking
my earnest desire to help, and my genuine question looking for any
insight people more familiar with the code might be able to offer.
Perhaps I'm just missing the joke, but if it's an Office Space
reference it feels like it's in pretty poor taste.

>
> But more seriously:
>
>     $ stahp=3D'Bryan.Turner.will.hunt.you.down.if.you.manually.run.gc' &&=
 git -c gc.pruneExpire=3D$stahp gc; git -c gc.reflogExpire=3D$stahp reflog =
expire
>     error: Invalid gc.pruneexpire: 'Bryan.Turner.will.hunt.you.down.if.yo=
u.manually.run.gc'
>     fatal: unable to parse 'gc.pruneexpire' from command-line config
>     error: 'Bryan.Turner.will.hunt.you.down.if.you.manually.run.gc' for '=
gc.reflogexpire' is not a valid timestamp
>     fatal: unable to parse 'gc.reflogexpire' from command-line config

Thanks for that! It looks like that does block both "git gc" and "git
reflog expire" without blocking "git pack-refs", "git repack" or "git
prune". Fantastic! The fact that it shows the invalid value means it
might also be possible to at least provide a useful hint that manual
GC is not safe.

I appreciate your help, =C3=86var.

Bryan
