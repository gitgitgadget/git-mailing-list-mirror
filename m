Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BE891F462
	for <e@80x24.org>; Tue, 21 May 2019 14:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfEUOs3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 10:48:29 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:43370 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUOs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 10:48:29 -0400
Received: by mail-ua1-f42.google.com with SMTP id u4so6699709uau.10
        for <git@vger.kernel.org>; Tue, 21 May 2019 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJfy1fIF3CnnQzc4F6lvc471ZHlH5QMihdRhLxrMKS8=;
        b=p0AUgrkUeiD9/qCdwDNI8rX3XrPs/JysnlUMthrAE1vtBSBjb7PbluiGgZlph7tG6d
         2gS3wn9wfYydWYNj5NYQGvYDTbEG6sStp019oiFVRmsVrZQ3OudQNw5hdFlaxkt/bIyw
         eiiwALFS+3VaPD+OmNL4L/Jji0SUV1rvubE7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJfy1fIF3CnnQzc4F6lvc471ZHlH5QMihdRhLxrMKS8=;
        b=EV9e84GZ7ftNUtvYOwpQW38zO+vq4Ge1xecFX/rPFiY4+YMNMIhnyKAbBQkmu0wP51
         1rWSt9+/qpDe3LDanWFcKji9VUC0YZKhfSunkLISCM14jFB1p4/LGQ06+xi93CrYTHqd
         IEhjFsvX1qz3fGVyy8CeDc+x5h+gCcK4Q/H3OkJQ0IkWXwyDTa7YmDDq2LnOdL0xTYeF
         fCTDDqVwYu5p06JKZGlzE2Uyw7MW9YSHtPAlbqeMiF+KYGy5GsLrpydDH4M1J/0agzx7
         gSp2Bh7aMa7+qycsQmH3Omn0nHKUCyDjyaPQkxHxU6juXAsRNBDT8EXIC1TBOOhjiUSJ
         qzTg==
X-Gm-Message-State: APjAAAUuRSVjQHeRJf7CPoHR/ApVha9SH7ykr+uCGeqlj70HtlKOTpUH
        NwaL/HQBR1bOU1t5Ahdtj2cAkgfEQW40hkY71G8YXg==
X-Google-Smtp-Source: APXvYqzpwS1YS28JpbEQXZn+LcawGbnh6e51MbUGK1TZpBQW7UbgX80H58RZtR5YKNOLX234aaL169D0ON3f4ks+wAs=
X-Received: by 2002:ab0:1407:: with SMTP id b7mr8252179uae.112.1558450107504;
 Tue, 21 May 2019 07:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <01cf52cb-7e90-efde-a06c-f0413f9efc8a@gmail.com>
In-Reply-To: <01cf52cb-7e90-efde-a06c-f0413f9efc8a@gmail.com>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Tue, 21 May 2019 15:47:50 +0100
Message-ID: <CA+kUOa=N5GuKoLjNh=8JkTBnpcdxQ2-OLZbOFAGUhBkZ9dVH4A@mail.gmail.com>
Subject: Re: Cygwin Git Performance
To:     Nathan and Ila Reynolds <nathanila@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 21 May 2019 at 15:34, Nathan and Ila Reynolds wrote:
>
> I am not sure if this is the right mailing list.  If not, please
> redirect me to the right place.
>
> I have Cygwin's git (2.21.0) and Git for Windows (2.21.0) installed on
> my Windows 10 machine.  I run the following command with each binary
> "git push --all" on a simple 2 line change to 1 file.  If I use Cygwin's
> git, then the operation takes almost 5 minutes.  If I use Git for
> Windows, then the operation takes almost 20 seconds.  I tried using
> --verbose to figure out why Cygwin's git is so slow but it does not
> reveal anything to me as to why.  What can I do to figure out why
> Cygwin's git is so slow? I am hoping that we can get to the bottom of
> this and it can be fixed to help all users.

Re which mailing list to use: are you using the version of Cygwin Git
that gets installed when using Cygwin's setup-x86/setup-x86_64
installer? If so, you'll probably have better luck reporting on the
Cygwin mailing list per https://cygwin.com/lists.html. If it's
something you built yourself, it's less clear, because it depends
where things are going wrong. In either case, I'm the maintainer for
the Cygwin Git package, so I'm probably a good person to at least take
a first pass at the problem.

It is expected that Cygwin's Git is slower than Git for Windows, as
they're both running on the same hardware, operating system and file
system, but Cygwin has a heavier interface layer between the Git code
and the OS. However I'd expect that difference to be basically
unnoticable the vast majority of the time; 20 seconds to 5 minutes is
significantly more than I'd consider typical.

My immediate thoughts are around (a) PATH handling and (b) third-party
dependencies like what SSH library is being used. So I can rule those
out, can you give me (a) the standard Cygwin diagnostic package from
running "cygcheck -s -v -r > cygcheck.out" in a Cygwin terminal
(off-list, if you prefer), and (b) details of the remote repository
you're pushing to?

Cheers,

Adam
