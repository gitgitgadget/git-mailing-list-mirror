Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 704E01F453
	for <e@80x24.org>; Mon, 11 Feb 2019 15:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbfBKPsF (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 10:48:05 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:34459 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731398AbfBKPsD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 10:48:03 -0500
Received: by mail-ua1-f45.google.com with SMTP id c24so3575331uak.1
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 07:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3O5jHijb1sgqal4/bqlN2jrGxOHpRGROVR9YDvlZpgU=;
        b=Pp/P29TVklYOQ3m3epMg7R6V1zsYlpct/zxWb3k/Nwl4zRz54SP8GuetKsJxyjHkxA
         egMPfQh7sRi2qBbtSVNu/zdeG2op4SQo+YerfrhJRWnyCuM9KQaBrCDdcxUQ1N5t3gEs
         wMIDO6oNSJrotPCPi5lH4Y3SqPUpXTOhhcR2l0VfKXTS5Tek2JUduI9v0iLL3nuyALuc
         VXCu4qABYj/MmGlPOZh0yx161BUkivIoPx0t7O3pQO3AYZe8RZdW+O04pEGrfiw+iTTG
         lXmPi2tsnwm145x+QhZXAccB7YVdFw9HA0yfpNSBf3Kq1E4Jpx5SpzBC7TIwMu81rth3
         zz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3O5jHijb1sgqal4/bqlN2jrGxOHpRGROVR9YDvlZpgU=;
        b=edCHnBf3qBK0IwQwHYdQ9Rydh/hJ1BPr93qOkmkm/TRpbMewZ2nlH9G0VIap99d5lm
         rjU3CmNHSlJUnlD264NDqxrAaqYXYPX06JxWDOJYqfyFtEaRyar2neTTAQpOfvFad4/y
         bZOqGqwNjo9Ol6YznFreMscf5DJQMFzZeH7C4sI8V0HBBKPQXGXRAQN3VNpxxkjcvgIJ
         ipIe3pV0R2r8z91NFJytN1cwVhIkVY8KH5W0Mh8wnc4trG4DWQEyNDn4Rm2Vrbveuwge
         YMuBJhz7VUh2znioTHFt1yWTQbXKsCYO+SwcPV1ZCtvqCx6yXgkgAKyoihDKB8B6C62L
         K0ZA==
X-Gm-Message-State: AHQUAuYfwAlsLHXsbeep3qlagaSiAQvb7bQejkDrcoWcMZXBYOGudV0C
        qLCryz86AvsBLU+HoKW3+UzdquaIzsARmYPQHt+uLY20
X-Google-Smtp-Source: AHgI3IaYcX+DIg3UTMxxDhfbivkJSb7YwI1JYkSwbwMXMyRLQiOv3XDw7oZvIXxeHax0OPMGY2kUVimojGHwH4D33jQ=
X-Received: by 2002:ab0:2b93:: with SMTP id q19mr4987208uar.130.1549900082946;
 Mon, 11 Feb 2019 07:48:02 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com>
 <875ztukt77.fsf@evledraar.gmail.com>
In-Reply-To: <875ztukt77.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Feb 2019 07:47:51 -0800
Message-ID: <CABPp-BEPw0ZrK8o+T74uuA3q2hgpqiy+VDHo1x3zTtYzuH7fwA@mail.gmail.com>
Subject: Re: New command/tool: git filter-repo
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On Fri, Feb 8, 2019 at 10:53 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Jan 31 2019, Elijah Newren wrote:
>
> > What's the future?  (Core command of git.git?  place it in contrib?  ke=
ep it
> > in a separate repo?)  I'm hoping to discuss that at the contributor sum=
mit
> > today, but feedback on the list is also welcome.
>
> Some of this I may have mentioned at the summit, but here for the list:
>
> * I think it should be a candidate for a core (not "just contrib")
>   git.git command, given that we have someone willing to maintain it &
>   deal with bugs etc. I'm not worried about that given the author.
>
> * It's unfortunate in terms of API we need to support going forward that
>   this obligates us to support a fairly intricate python API going
>   forward, so it's similar (but more detailed) to Git.pm (which I also
>   tried to get rid of as an external API a while ago).
>
>   However, as you correctly note that's the only way a command like this
>   can be really fast, we already have the "no special API" command with
>   git-filter-branch, and that's horribly slow.
>
>   But perhaps there's ways we can in advance deal with a potential
>   future breaking API change. E.g. some Pythonic way of versioning the
>   API, or just prominently documenting whatever (low?) stability
>   guarantees we're making.
>
>   I imagine if we need to make breaking changes in the future that'll
>   less big of a deal than in other cases, since we'd expect the API use
>   to be one-off migration scripts, although maybe it'll get used for
>   all-the-time exports (e.g. mirroring internal->external repos with
>   filtering).
>
> * The rest of our commands are hooked up to the i18n framework. I don't
>   think this should be a blocker, but it's worth thinking about what the
>   plan for this is.
>
>   Are we going to need the equivalent of Git::I18N for Python (which
>   presumably will be a run-time dependency on something needing the
>   Python API that links to gettext).
>
>   Or perhaps we could do the translated strings in C, by making the
>   program you're invoking be a C command, invoking the Python part as a
>   helper (which would need to re-invoke a helper if it prints its own
>   messages).
>
> Thanks for working on this!

Good points.  I'll dig in to the i18n story.  As you point out, the
API stability may be tricky, but you may be right that we just need to
prominently document whatever guarantee we want to make and that it's
designed more for one-off migration scripts than continuing exports.
