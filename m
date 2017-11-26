Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04BE420A40
	for <e@80x24.org>; Sun, 26 Nov 2017 18:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbdKZSer (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 13:34:47 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:43654 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751519AbdKZSer (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 13:34:47 -0500
Received: by mail-it0-f52.google.com with SMTP id m191so18378154itg.2
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 10:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sfhjQ1T8xSSSZic9a9x8mB1osentxT/YSi6BvwjnryY=;
        b=ChwGtZnVflEIAYGu+FGPvwVGwmljqrHdQuopuehErZgLErxBQHLx5R9XIX/727LfzG
         htLm4EaPeS/fwTmKEAwK/TrIWuaM6y0JwAi/Y1H7GZkRXXe7MnvDkoh/1hvaczx8ciAc
         svv9UeR1YWPjHayHY4807FUMW2oY1GmkmDI41p8T0k8BiNOAw+7BBm9/RsF2bmqJG4xu
         Elc7yzafZXigPMw7nOy57/yyqQjx53ebqzF9CoYVic4K3Aj0eM0I4IuZ9WdGTVHNyOZE
         IeEyJ2VARGk1tbYbaUcu9gYbEKGvJBX8hvcgr+27kFv3jTeQ7ODaraTQZRUwvpfeWNFR
         +8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sfhjQ1T8xSSSZic9a9x8mB1osentxT/YSi6BvwjnryY=;
        b=PM3enZBkbuoVa+HzyDjvkZ8YcX5gUvb8Tabazdc6Aryn+OF3u9zs9hn1oqY6eBshE0
         sTjlFX4W4PO9AdJDD/pzgfbf9VDQixSpH1Kt2BIAG5HRmfQeSwlAy038nM+M+jeYfAu1
         KchgOwvZHVx1b4zqfATNcA9VJv30Nsnge3pik82CzA91Iv/+q6O/B7rBhCPO9mvZcKZc
         ijbTvhT3WvGiEKomjD91bc4t6//DemlRP2+vYtSNRgWKo8K6s1tFVmJvCnhpnHPZV3e/
         M8Uq0FdFGnUWMMxxd6RZxjq+svlcCxyW3Kcb0F2kQC6xM58vecaeCOMERlE8gAxtGAWo
         NFQQ==
X-Gm-Message-State: AJaThX4s5KeGZlnOf2X5aviQFQlYivhfh22hQUH+zNcZH0aEWdGon833
        wVutgsCDec9vzt6o90ndTP+GiMdhF/OwuAslFN8=
X-Google-Smtp-Source: AGs4zMZ7HgH5HXDt/k6aWB3QWzM4nNteY2S65ZNCdHQjPyA/yDeuWivH2H0NaiD+JRRz+rpsdrAXKPd1LecRoOcPKOc=
X-Received: by 10.36.124.197 with SMTP id a188mr25078225itd.63.1511721286159;
 Sun, 26 Nov 2017 10:34:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sun, 26 Nov 2017 10:34:45 -0800 (PST)
In-Reply-To: <be2b6fd3-b405-7537-ba38-60d5eb2b341a@ramsayjones.plus.com>
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
 <CAP8UFD1YY_f4Ds0sYK86OBb7Wyud_YWr2Wx8nx1pdnwSsPgJ8A@mail.gmail.com>
 <xmqqbmjpitl2.fsf@gitster.mtv.corp.google.com> <CAP8UFD2sWE9cZe=OO1UQjf6Boih=Go9xJg=gDgEUzbXNuood5w@mail.gmail.com>
 <be2b6fd3-b405-7537-ba38-60d5eb2b341a@ramsayjones.plus.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 26 Nov 2017 19:34:45 +0100
Message-ID: <CAP8UFD2fH3PP3TeqTNy9+NL4T+ycu26S6qurTrDW2mEEN4WKtQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 26, 2017 at 6:43 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 26/11/17 14:00, Christian Couder wrote:
>> On Sun, Nov 26, 2017 at 4:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Christian Couder <christian.couder@gmail.com> writes:
>>>
>>>> On Mon, Nov 20, 2017 at 6:15 PM, Christian Couder
>>>> <christian.couder@gmail.com> wrote:
>>>>> By default running `make install` in the root directory of the
>>>>> project will set TCLTK_PATH to `wish` and then go into the "git-gui"
>>>>> and "gitk-git" sub-directories to build and install these 2
>>>>> sub-projects.
>>>>
>>>> Has this patch fallen through the cracks or is there an unresolved issue?
>>>
>>> I had an impression that the conclusion was that the existing error
>>> message at runtime already does an adequate job and there is no
>>> issue to be addressed by this patch.  Am I mistaken?
>>
>> This patch is mostly about what happens at the build step. Its goal is
>> not much to improve what happens at runtime, though that is improved a
>> bit too. If the build step was good enough, then I would agree that
>> what happens at run time is adequate.
>>
>> Let's consider only people installing git using "make install" to use
>> it on their machine, as I think I already discussed the case of
>> packagers and added the BYPASS_TCLTK_CHECK variable for them.
>>
>
> I haven't been following this thread too closely, but I have the
> feeling that the best course of action is to simply not fall back
> to using a tcl version of msgfmt in the first place!. ;-)

Well, another possibility would be to try to use the tcl version of
msgfmt in the build of git itself if msgfmt is not available.
This way the build behavior of git and git-gui could be similar.

> If a given platform does not have gettext/msgfmt, then you just
> don't get an i18n-ed version of git. (no need for BYPASS_ ...).

Right now without gettext/msgfmt you get an error unless you set
NO_GETTEXT. If we try to use the tcl version of msgfmt in the build of
git itself, then you could still get an i18n-ed version of git if you
have Tcl/Tk.

But anyway even if this is related, I think it is a different issue.

> Am I missing something?

I still think it is not the best outcome to just install git-gui and
gitk by default when Tcl/Tk is not installed. In general it is best to
fix potential errors at build time rather than at run time (even if
the run time error is adequate).
