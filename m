Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90CF202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 15:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965203AbdKQPf2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 10:35:28 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:40243 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964860AbdKQPf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 10:35:26 -0500
Received: by mail-io0-f177.google.com with SMTP id 71so9120210ior.7
        for <git@vger.kernel.org>; Fri, 17 Nov 2017 07:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GjDO2shmhkOMcjhU0GAvTyrqy04cmRvDiFnhfl+9rME=;
        b=mEEshaodY8oLXheXuNFVSFDKskfi7kwAyDqjso8d/gU6NaFgLQKxLN8WvtOmKnCBzn
         tCfRPsvEv57r0jIMGiWJBy5FeucZpZ6bQDQoa2CUjmYWR2e2kv/KTXyA23F9f7Ix6WjK
         Tu+iy4jKNU0eXlFPyHicNwJyczsPkDsJGHyCK86jq/iOPIFgeeRoCOLusaG2zabTIFVA
         NuPxszZr4sMeI0+OykwRdoiEv7k7WC8aICb516UZgH2moyBfij+qzf5HgQV9Uzdk7z6e
         zDVxku69nPEU5vedIyen2E8T+ZMY/q75aSpMERU6aIx8eJkScqtSda/9IsjGbB57qtH3
         vgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GjDO2shmhkOMcjhU0GAvTyrqy04cmRvDiFnhfl+9rME=;
        b=sGSM1FPjXQknpc7q7rNcla5pmtygdZS0O766rpkfFTxBRFFT7lM2im2470h0BZkbYg
         Oleqrh47IFJ0YuSoRKZqLogSr/6/SNlIGr1cdscWhB+jRXzW31kILmigYa7PpVIxINAQ
         8/rqPkbuXgZJ3Hz2PUhfSACKooI9nuDif68jvGMHzfqvd+5qHvDdUJ+fJDymF/lEM1a6
         7+bWiGJNm/8/T9eu/gmmlq+iVBfMavfrQ/arZH3dpryu2Ks7jpp3vCzfSAIYqHO5siSr
         nRH93PDui/bOYxZGLYlT2hRy2qP8CPHBahk8xvN/WdjFMuEBgn35/0IOLNgkWNft/i9H
         vvqA==
X-Gm-Message-State: AJaThX7IZuO293nZZ+37nI9HJpbMt1xza8Vmq72tEkAwUju4wk6FCtfw
        U3yrO3jlUJrCCLUeQX5TOoVW0h9hijBUHIprSLM/nIo3
X-Google-Smtp-Source: AGs4zMbuX03CBcDVi7BtvnkNLvVFTXCj2+3fop2LxY7H87hzxROjnaUs/tGzUrdHOEHBr/T1V08p3+3Dm6I+luTXO9E=
X-Received: by 10.107.39.207 with SMTP id n198mr2991736ion.180.1510932924673;
 Fri, 17 Nov 2017 07:35:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Fri, 17 Nov 2017 07:35:23 -0800 (PST)
In-Reply-To: <xmqqbmk3xaxg.fsf@gitster.mtv.corp.google.com>
References: <20171115125200.17006-1-chriscool@tuxfamily.org> <xmqqbmk3xaxg.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 17 Nov 2017 16:35:23 +0100
Message-ID: <CAP8UFD1hcFLMvNsXONPNbxZhTbHVzSMdRgCB9m=ZGeSTpMsYew@mail.gmail.com>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Dominik Mahrer <teddy@teddy.ch>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 16, 2017 at 2:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> To improve the current behavior when Tcl/Tk is not installed,
>> let's just check that TCLTK_PATH points to something and error
>> out right away if this is not the case.
>>
>> This should benefit people who actually want to install and use
>> git-gui or gitk as they will have to install Tcl/Tk anyway, and
>> it is better for them if they are told about installing it soon
>> in the build process, rather than if they have to debug it after
>> installing.
>
> Not objecting, but thinking aloud if this change makes sense.
>
> If you are building Git for your own use on the same box, which is
> presumably the majority of "build failed and I have no clue how to
> fix" case that needs help, if you want gui tools, you need to have
> tcl/tk installed anyway, whether you have msgfmt installed.  This
> seems to be the _only_ class of users this patch wants to cater to.
>
> I wonder if we are hurting people who are not in that category.
>
>  - To run gui tools, tcl/tk must be available at runtime, but tcl/tk
>    is not necessary in the packager's environment to produce a
>    package of Git that contains working git-gui and gitk that will
>    be used on an end-user box with tcl/tk installed, as long as the
>    packager's environment has a working msgfmt.
>
>  - To process .po files for the gui tools in the packager's
>    environment without msgfmt, tcl/tk is required.
>
> I suspect that this change will hurt those who package Git for other
> people.

Maybe a little bit, but in my opinion it should not be a big problem
for them to install Tcl/Tk and its dependencies on the build machine.

> It used to be that, as long as they have msgfmt installed, they only
> needed to _know_ what the path on the users' box to "wish" is, and
> set it to TCLTK_PATH, and if they are distro packagers, most likely
> they already have such an automated set-up working.  Now with this
> change, they are forced to install tcl/tk on their possibly headless
> box where tcl/tk is useless, and worse yet, an attempt to install it
> may bring in tons of unwanted stuff related to X that is irrelevant
> on such a headless development environment.

Yeah, but if they build gitk and git-gui, there is a significant
chance that they build other graphical software too, and that this
will require installing stuff related to X anyway.

> I doubt that this is quite a good trade-off; it feels that this
> burdens packagers a bit too much, and we may need a way to override
> this new check further.

I am ok to let packagers override this new check. For example they
could set a flag like BYPASS_TCLTK_CHECK and the new check would be:

ifndef NO_TCLTK
      ifndef BYPASS_TCLTK_CHECK
             has_tcltk := $(shell type $(TCLTK_PATH) 2>/dev/null)
             ifndef has_tcltk
$(error "Tcl/Tk is not installed ('$(TCLTK_PATH)' not found). Consider
setting NO_TCLTK or installing Tcl/Tk")
             endif
      endif
endif

Of course BYPASS_TCLTK_CHECK would have to be documented at the same
place where NO_TCLTK and TCLTK_PATH are already documented.

In general I think packagers are much more able to deal with those
kinds of problems than most regular developers who want to hack on
Git.
So asking packagers to either set NO_TCLTK or BYPASS_TCLTK_CHECK or to
install Tcl/Tk would not burden them much, especially compared to what
regular developers have to deal with these days when trying to build
Git.

> I think "If I cannot run either wish or
> msgfmt, then barf and give an error message" might at least be
> needed.  Am I misinterpreting the motivation of the patch?

I'd rather add a separate check for msgfmt than mixing the 2 issues,
because I think that unless it has been explicitly told to do so, Git
should not try to build git-gui and gitk in the first place if there
is a big chance that those tools will not work.
