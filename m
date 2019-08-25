Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F431F461
	for <e@80x24.org>; Sun, 25 Aug 2019 19:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfHYTKD (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 15:10:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36945 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfHYTKD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 15:10:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so13255241wrt.4
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7+MWIQ3WDUWU6i8OPx2txybaKTdhvO236ksQFFF5I+E=;
        b=ugIg4kwu4ul+33PyC6h7NVH5l/zBXOR1X/hhYN6A5uc7HVVCERsrz4rmaQy8q7/It/
         mvvTZ9iYZDqA0F3HL1j46iMy2Os5mK0iqQJ7xuPzj6pg4Evf2GSQ9HXGm4+/4414s2OX
         WkPzvyo7b/7lLKhli5mYjgkd50BMADF6VhiQMabPa9k6SYfLhA5AGyodkeskhq+CNeZB
         THdr4Vtq5TtMHN8K1Ie0KsdnHsVZfLQXmPWhiZffN9LufpKb7YAml2iev1A+0zUyR+Yf
         Kvc1TZxIuCVTjddNm3a/eoGBMn9CMA3WIxUbuWax0NHhqGe6s5FOiB+oeuJpE842GCrn
         w6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7+MWIQ3WDUWU6i8OPx2txybaKTdhvO236ksQFFF5I+E=;
        b=kMDVorw+XtKrpIlNvvkRGB9lNmYVQvGuNVrSlJ07ZF/S6wLy/AtQq9nnWMByMNM0cU
         tzcG042xUkaxdqDWg4Fu+BLcu9LXRUDc+Tt8hrCBxIeiR/HNeulSb4+LS1EedyEJoLP/
         t1tcsvjFkHHXKaidkubiaTsPE+de5jwb0mPnhKwz64Km1y6yc6k7MyHPzz8GfYey4qf5
         J+csCbtq8WwSTABdjxxtankadlToWQkTcJgdXk8oGvMYYkqe8Rvvi86XkKohNmFqBrX0
         bvSdytctrfm/EZatzbA/CQ8EeLH4xgQ6RQfl3lh5Wtd2RiEnjv+t/le0O3aFrsUKFuoH
         r/FA==
X-Gm-Message-State: APjAAAUiyj+KYFdwRIbA8xnBVrqFEKZKTUWzSbXlL3Jhj723qw9zWHnX
        SSCpcMV50d6qpJF/6JNasUI=
X-Google-Smtp-Source: APXvYqwqju0CTqsnz6b+q+TVFPy9FgdzxwQiXKuNoWMf2QHZAaAoGRd+auSb3y2KUEJ2OvlADDoDog==
X-Received: by 2002:adf:e504:: with SMTP id j4mr17510776wrm.222.1566760200796;
        Sun, 25 Aug 2019 12:10:00 -0700 (PDT)
Received: from szeder.dev (x4db347f6.dyn.telefonica.de. [77.179.71.246])
        by smtp.gmail.com with ESMTPSA id u7sm7547288wrp.96.2019.08.25.12.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 12:09:59 -0700 (PDT)
Date:   Sun, 25 Aug 2019 21:09:57 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Cesar Eduardo Barros <cesarb@cesarb.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 20/23] .gitignore: touch up the entries regarding
 Visual Studio
Message-ID: <20190825190957.GN20404@szeder.dev>
References: <pull.287.git.gitgitgadget@gmail.com>
 <pull.287.v2.git.gitgitgadget@gmail.com>
 <dc4a9cc6205afac03d1154ca935e4334536fa693.1564430879.git.gitgitgadget@gmail.com>
 <20190825120741.GM20404@szeder.dev>
 <9eed02e7-7e2d-4ae3-6c08-ab17b3c92fb6@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9eed02e7-7e2d-4ae3-6c08-ab17b3c92fb6@iee.email>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 02:20:32PM +0100, Philip Oakley wrote:
> Hi Szeder,
> 
> On 25/08/2019 13:07, SZEDER Gábor wrote:
> >On Mon, Jul 29, 2019 at 01:08:14PM -0700, Philip Oakley via GitGitGadget wrote:
> >>Add the Microsoft .manifest pattern, and do not anchor the 'Debug'
> >>and 'Release' entries at the top-level directory, to allow for
> >>multiple projects (one per target).
> >>
> >>Signed-off-by: Philip Oakley <philipoakley@iee.org>
> >>Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >>---
> >>  .gitignore | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/.gitignore b/.gitignore
> >>index e096e0a51c..e7bb15d301 100644
> >>--- a/.gitignore
> >>+++ b/.gitignore
> >>@@ -230,6 +230,7 @@
> >>  *.ipdb
> >>  *.dll
> >>  .vs/
> >>-/Debug/
> >>-/Release/
> >>+*.manifest
> >This new line ignores the tracked file 'compat/win32/git.manifest'
> >that was added fairly recently in fe90397604 (mingw: embed a manifest
> >to trick UAC into Doing The Right Thing, 2019-06-27).
> >
> >I wonder whether that's intentional or accidental.
> >
> >I'm inclined to think that it's merely accidental, because, as far as
> >I understand, this is an old-ish patch from times when there wasn't
> >any 'git.manifest' file in tree, and simply noone noticed that in the
> >meantime we got one.  But I have no idea about how a Git build with
> >Visual Studio is supposed to work, so it doesn't really matter what
> >I'm inclined to think :)
> >
> At the time, it was just one of the many non-source files that were
> generated by Visual Studio that cluttered the status list and also could
> accidentally added to the tracked files.
> 
> The newly added .manifest file does appear to be there to 'trick' the
> Windows User Access Control (UAC) which otherwise can be an annoyance to
> 'regular' users.

Sorry, I'm not sure how to interpret your reply, and can't decide
whether it tries to justify why that tracked file should be ignored,
or explains that ignoring it was accidental.

Anyway, ignoring that tracked file apparently triggered a nested
worktree-related bug in 'git clean', which can lead to data loss:

https://public-inbox.org/git/20190825185918.3909-1-szeder.dev@gmail.com/

