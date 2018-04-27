Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C9DC1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 20:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759218AbeD0UXX (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 16:23:23 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:34037 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759087AbeD0UXW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 16:23:22 -0400
Received: by mail-ua0-f176.google.com with SMTP id f22so1957767uam.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zIba3CocEpobE+ozAA8pHSTzVrcSUB5RR5XXt9VuRjQ=;
        b=ChKbG1bMBEOgYLLMyuUUJybVG3hKi67sJ87C6ksUKwd5Vejw4l3Z3hKYTiawGYwhag
         Z7fNIF08ETH/GGB7fHeklDjmGzUOJ8Z79VuBEl/myeSrD1tw0Tr+VVjWPEBBQwW5hZ05
         QRTOE9D4NBZKV3Jg4wXc6BWmqb3XXv6yIXQ+JghgJqmBp9HuevLrNdUWWH0v4sXY7z5X
         mtQlWdlkD7Wzkury+fl5uDeFoXtq4aZmksiMwjsK0KoV/5qzkGFohsrTzydU2RE/4psS
         WOIFbRWTI2ybnJHMJrbTOFLdzcq7nLCnFofMEA6UPLVe2K0RnKIm444VDUXIZ2oAOhCG
         Fycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zIba3CocEpobE+ozAA8pHSTzVrcSUB5RR5XXt9VuRjQ=;
        b=Td24MLWbESZyc0YuRuWQv5OYa5VrU9rcKoF5cOqwhWEkDqrtWN8KmDUXmkTvva4izW
         zlew26WpcA1t5e36M7clz5g703wTeRFiqx0lhn0PLnO3LvJA9NUmWiKCGJJqCPmQsg99
         Z6WpcLA1l6VeUUaQFdE02lM4pjtfrvXGLgNcDB1lsOT08myDVA2mF/xR9F1SLkkYcEvs
         uNKvh9DixKvD9HnfvwWN1G4ArcsuE32T1GuN9RhOyetraFxxhUav4j8BgkaUFkZNQgHQ
         H9Z627+uubczL0w04hjQR3WcaiVOLCVT5HnbahjJ567wGjUzjvgzxTQQkMPQvT930eU8
         cGYw==
X-Gm-Message-State: ALQs6tDD56In6bhSvFy7KabEo2HYgRu5QBgmN7UYx7H7k/bJ3FwsnXV3
        JqfM61VDPLD+dL5a8Id1wBIZ8dzHp4uC/cvnIco=
X-Google-Smtp-Source: AB8JxZqN++VZZFKHevqJDJHx/vckjFaPjYZlnS12jZE4J8rVdv1ZOK14LFbSb91cAGrLPSTH9sVJwtkWINhaE8hKpts=
X-Received: by 10.176.30.139 with SMTP id o11mr2552949uak.154.1524860601392;
 Fri, 27 Apr 2018 13:23:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 27 Apr 2018 13:23:20 -0700 (PDT)
In-Reply-To: <20180427183752.GA2799@esm>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180426205202.23056-1-benpeart@microsoft.com> <20180426205202.23056-3-benpeart@microsoft.com>
 <CABPp-BE29rwZCDqFHH-nzrDub6MMdtoiorj0jv3K6B6cmfcaLA@mail.gmail.com>
 <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com> <xmqqy3h9z8sj.fsf@gitster-ct.c.googlers.com>
 <20180427183752.GA2799@esm>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Apr 2018 13:23:20 -0700
Message-ID: <CABPp-BHwM1jx2+VTxt7hga7v-E6gvHuxVNPqm-MPRXYe5CDVtA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] merge: Add merge.renames config setting
To:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 11:37 AM, Eckhard Maa=C3=9F
<eckhard.s.maass@googlemail.com> wrote:
> On Fri, Apr 27, 2018 at 11:23:56AM +0900, Junio C Hamano wrote:
>> I think demoting from copy to rename-only is a good idea, at least
>> for now, because I do not believe we have figured out what we want
>> to happen when we detect copied files are involved in a merge.
>
> Does anyone know some threads concerning that topic? I tried to search
> for it, but somehow "merge copy detection" did not find me useful
> threads so far. I would be interested in that topic anyway, so I would
> like to know what the ideas are that floated so far.
>

I doubt it has ever been discussed before this thread.  But, if you're
curious, I'll try to dump a few thoughts.  Let's say we have branches
A and B, and:
   A: modifies file z
   B: copies z to y

Should the modifications to z done in A propagate to both z and y?  If
not, what good is copy detection?  If so, then there are several
ramifications...

- If B not only copied z but also first modified it, then do we have
  potential conflicts with both z and y -- possibly the exact same
  conflicts, making the user resolve them repeatedly?

- What if A copied z to x?  Do changes to z propagate to all three of
  z and x and y?  Do changes to either x or y affect z?  Do they
  affect each other?

- If A deleted z, does that give us a copy/delete conflict for y?  Do
  we also have to worry about copy/add conflicts?  copy/add/delete?
  rename/copy (multiple variants)?  copy/copy?

- Extra degrees of freedom may mean new conflict types:

  - The extra degrees of freedom from renames introduced multiple new
    conflict types (e.g. rename/add, rename/rename(1to2),
    rename/rename(2to1)).

  - Directory rename detection added more (rename/rename/rename(1to3),
    rename/rename(Nto1), add/add/add, directory/file/file, n-fold
    transitive rename, etc.), -- and forced us to specify various
    rules to limit the possibility space so that conflicts could be
    representable in the index and understandable by the user.

  - I suspect adding copies would add new types of conflicts we
    haven't thought of yet.

The more I think about it, the more I think that attempting to detect
copies in a merge algorithm just doesn't make sense.  Anything I can
think of that someone might attempt to use detected copies for would
just surprise users in a bad way...and it'd open up a big can of edge
and corner case problems as well.
