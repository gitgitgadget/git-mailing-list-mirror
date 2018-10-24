Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476481F453
	for <e@80x24.org>; Wed, 24 Oct 2018 14:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbeJXXSG (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 19:18:06 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36238 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeJXXSG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 19:18:06 -0400
Received: by mail-it1-f195.google.com with SMTP id h14-v6so528802itf.1
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QSvcTbst72c2AWmjWNDeSvXBlSvzpRc4Youiuz9rNKE=;
        b=L2XxhD1cGjtOuZXVrBqaHh6j4jzeDIxgFx/+928vPnm4nWY3aWRkhQBnt0DEhZBUvs
         Zil6ui7wN5A0l/RQfo5T4KybdKkfgsucQlfSl4PyZZWiL4xbL/+Gyw9cS8OQNYBKYosn
         FWXJOBgW/yuhG/Pp2dlSv9Wtae75UdN0UitK7EInWG0PkSLM8Hiuz5Qi4vYwztykvCGL
         g6ll6V1755JE8bipDhBzhckAd+S+h6yZkLC9ahgRkJEr3fRhcZ5nODsT2WpqlkOc9DnH
         jxCCnkBkKRgk2HHHocbhc2kq79QI7Vq2qHaAVyWSsHXvJ44J9W+pHLlNPmfEeVgj6GmJ
         r8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSvcTbst72c2AWmjWNDeSvXBlSvzpRc4Youiuz9rNKE=;
        b=rFUb8QTtGhnIYIVl0MHY4Tdtfd3Nk5uwy7gqGttCzlN90jnR+oZWFODq2YNM94RgM+
         CZ6p2lpFYak/kmJH7iHMfOEY+t42v4yx6tOkaIS3mm08hpXSUQvzYI4gXsRrls66N53x
         mQkYF0dK+qm3v7INoS4UDS7oY8+h++BGG6JsL+57ZLi6ju+zrq0hzIgGy4mswo+CSnZL
         PTnx2ppFv25KYUdQAh436qUTABg8EplsIWZhJdoiy3+VI4Dh7s5sjFRnxBIjZjPfR01W
         oeYuRcrUN2MOfbbV9P9VU9HF7s4ADNi7kM//0mdhKIzzJZOtmKDHdakxa0DPLEcGGcmR
         WX+Q==
X-Gm-Message-State: AGRZ1gJQ0vvaXDRGG6QvuNlfADNjfJhbDgFWEC7l73/vPTHso0tXCCBQ
        z13UI0nwGPvLMXOKbRkJuvIRi0VxoPCIgwlmbTM=
X-Google-Smtp-Source: AJdET5erQNINZMNwgY0Io1O9+QevLVDt9YdGbP8hjk8IQHB/DXZV6wYtHHuzdBP+J2qTwZyBUoqQmKfiHSpPZFRJsJ4=
X-Received: by 2002:a24:cd02:: with SMTP id l2-v6mr1770330itg.70.1540392582039;
 Wed, 24 Oct 2018 07:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181017164021.15204-1-peartben@gmail.com> <20181022131828.21348-1-peartben@gmail.com>
 <20181022131828.21348-3-peartben@gmail.com> <CACsJy8Dcf8OknyMaSZxOaib54jLSSt71XXjTZD3UjgnH6J7QFA@mail.gmail.com>
 <e1f50b07-b3bf-0805-fcc9-692331dd170a@gmail.com>
In-Reply-To: <e1f50b07-b3bf-0805-fcc9-692331dd170a@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 24 Oct 2018 16:49:14 +0200
Message-ID: <CACsJy8AKWp859cGMwh0_tRwODPCAQ+Rmkaz6HQcy8UQOgMH-og@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] reset: add new reset.quiet config setting
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 8:47 PM Ben Peart <peartben@gmail.com> wrote:
>
>
>
> On 10/22/2018 10:45 AM, Duy Nguyen wrote:
> > On Mon, Oct 22, 2018 at 3:38 PM Ben Peart <peartben@gmail.com> wrote:
> >>
> >> From: Ben Peart <benpeart@microsoft.com>
> >>
> >> Add a reset.quiet config setting that sets the default value of the --quiet
> >> flag when running the reset command.  This enables users to change the
> >> default behavior to take advantage of the performance advantages of
> >> avoiding the scan for unstaged changes after reset.  Defaults to false.
> >>
> >> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> >> ---
> >>   Documentation/config.txt    | 3 +++
> >>   Documentation/git-reset.txt | 4 +++-
> >>   builtin/reset.c             | 1 +
> >>   3 files changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/config.txt b/Documentation/config.txt
> >> index f6f4c21a54..a2d1b8b116 100644
> >> --- a/Documentation/config.txt
> >> +++ b/Documentation/config.txt
> >> @@ -2728,6 +2728,9 @@ rerere.enabled::
> >>          `$GIT_DIR`, e.g. if "rerere" was previously used in the
> >>          repository.
> >>
> >> +reset.quiet::
> >> +       When set to true, 'git reset' will default to the '--quiet' option.
> >> +
> >
> > With 'nd/config-split' topic moving pretty much all config keys out of
> > config.txt, you probably want to do the same for this series: add this
> > in a new file called Documentation/reset-config.txt then include the
> > file here like the sendemail one below.
> >
>
> Seems a bit overkill to pull a line of documentation into a separate
> file and replace it with a line of 'import' logic.  Perhaps if/when
> there is more documentation to pull out that would make more sense.

There are a couple benefits of having all config keys stored in the
same way (i.e. in separate files). Searching will be easier, you
_know_ reset.stuff will be in reset-config.txt. If you mix both ways,
you may need to look in config.txt as well as searching
reset-config.txt. This single config key also stands out when you look
at the end result of nd/config-split. The config split also opens up
an opportunity to include command-specific config in individual
command man page if done consistently.
-- 
Duy
