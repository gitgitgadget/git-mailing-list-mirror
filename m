Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40B681F404
	for <e@80x24.org>; Thu, 16 Aug 2018 18:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbeHPVT3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 17:19:29 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34025 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeHPVT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 17:19:29 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so4662639ioj.1
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sIMKeAW7GQVJsDIjSSOkVUeKfVBUYQK6aJfWcuWM1fE=;
        b=dykyp9tJkaJdzbcKpROkBn/ili87wrgYuba4OO9cenMhEVLT0Q52ZwyLnComRxUbUG
         ohDOdhla/NiCVx83szBbO/t6QvqmAEaCoOPakIkl/A5kVEVB8+rgZxjrXN7Ld4laZ2uY
         /QXgAORfZu8CXPgcBhFRukfVIW2dL7AmCZLS6DulmqE0zuWkzuD67rfhByWDzUgxEqlV
         v201sMcW51pSHAQf9YQ5TM03YSqJsAnSUDZGDFrYjLB7M8wuqATOf4QPp5LJp5XH4s27
         OduNiFSXPSZD7cGintCRqgE1fOLa95rbjE0GfbwrYXokjBRCMgXP9BsJBDH03+ojm0f+
         ssQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sIMKeAW7GQVJsDIjSSOkVUeKfVBUYQK6aJfWcuWM1fE=;
        b=sWCPLsV29QDwK2CvICIvWG8+V81XtHx238qxXF3X7zPpjbqrNfrF5qg5GDrebQwhgV
         xHyhxo7/xOJN8LaugvZddczuldBwXFyYUX+wCL1F8pplq1dFE9IMqQNVaQWe5HPR+7/i
         5pi91HaP564QQod8HNEx2b7OILkXWjot839QvvH5B8wl8baB/j1hIjR8IET3N9sQuO1v
         JhXbK5bs2zbgBlFpaTNdKn3bulbMpbh3lVmO94zZm82xrzXGZG5K763LcmvvQdQKe3pF
         Su3b7yHfVETS53EjrHEq+DJTW/2ZyZfHckUPBUBcKhLeMVr2k5XtMCY1e9Knlr39vtdj
         TFFQ==
X-Gm-Message-State: AOUpUlEza2OJ4zAdOyf3h8OoezJWjGkYbge+IiH8hQizh6dS79Xl6l1C
        /IC9gvxvwk9qmZLbGa1QYcC7M05DPIIPATwcPZc=
X-Google-Smtp-Source: AA+uWPzXZK89J5rBzqIxc/fGMuWsqERM8H/wK4QoF1kWegGDoC8AvxtdKiJpbM2j4iLoBVvGAiC4kLKaYzf4CpkSzE0=
X-Received: by 2002:a6b:8f4b:: with SMTP id r72-v6mr26645527iod.118.1534443567669;
 Thu, 16 Aug 2018 11:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8AYQL3oDLyt14eJ1emynngqKQv9GXju56gU9u4mHrFHOg@mail.gmail.com>
 <20180816155647.10459-1-pclouds@gmail.com> <xmqqin4afdoj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqin4afdoj.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 16 Aug 2018 20:19:01 +0200
Message-ID: <CACsJy8C2r5y0m88yrRQHQ-_QNXemy2pfcjxYK0zSd0J3fFy3rQ@mail.gmail.com>
Subject: Re: [PATCH] config.txt: clarify core.checkStat = minimal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 7:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > The description of this key does not really tell what 'minimal' mode
> > checks exactly. More information about this mode can be found in the
> > commit message of c08e4d5b5c (Enable minimal stat checking -
> > 2013-01-22).
> >
>
> While I agree that we need to do _something_, I am not sure if this
> change adds sufficient value.  I _think_ those who wonder if they
> want to configure this want to know what are _not_ looked at
> (relative to the "default") more than what are _still_ looked at,
> partly because the description of "default" is already bogus and
> says "check all fields", which is horrible for two reasons.  It is
> unclear what are in "all" fields in the first place, and also we do
> not look at all fields (e.g. we do not look at atime for obvious
> reasons).
>
> So perhaps
>
>         When this configuration variable is missing or is set to
>         `default`, many fields in the stat structure are checked to
>         detect if a file has been modified since Git looked at it.
>         Among these fields, when this configuration variable is set
>         to `minimal`, sub-second part of mtime and ctime, the uid
>         and gid of the owner of the file, the inode number (and the
>         device number, if Git was compiled to use it), are excluded
>         from the check, leaving only the whole-second part of mtime
>         (and ctime, if `core.trustCtime` is set) and the filesize to
>         be checked.
>
> or something?

Perfect. I could wrap it in a patch, but I feel you should take
authorship for that one. I'll leave it to you to create this commit.
--=20
Duy
