Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 487631F461
	for <e@80x24.org>; Mon, 26 Aug 2019 09:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfHZJKb (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 05:10:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34832 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730525AbfHZJKb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 05:10:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id k2so14551828wrq.2
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 02:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oPc/kzEhrpjRgwO3OnKfweHCVwdkoMubCPPoXM0aWV4=;
        b=Q/O6M6Fy8WxC1f6btvtd3hI8PG8dvV4UKQhc8eWCyyFKc3KpFQjK+EFDA/eW5ociFa
         k5G/EbTl0BKSdeU+aSHohCrP/fI8yDRg71ydbhoo3mkN9xHcyCAa0sqezbWqIyAdYQcc
         xhAhzU9aY9YC/uhXcuZhjI7OBK8PtXI/XMfdZa8gpSZXQYhlIrphKdHCcL3Ltm4ouL7a
         NQnjGO3ZEF9yB4tw6mWKbqZAvVvm2gim/3RF1Hvr1IWtNYZJGl210MilY0OhpZkI5RSd
         WJNhRWt+o2KB8kLKTyeVCOH8ZGFLnzdumz8jVzSPHBZfYAJagR+rFxRHgRcE8xliNVRT
         kHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oPc/kzEhrpjRgwO3OnKfweHCVwdkoMubCPPoXM0aWV4=;
        b=BOmkXUx2pm42am7AyHOqtKkLnFzqtfDQkqkosPIjDHV9bwdd0jhxahlwRFBvHTOW4x
         YIOa6FpbNYakP4hdtzYvu9stKMmGJjvF3QUDZf2bQ37yeCHh18300CF2BeVGTXz8aRZg
         S8XQuY+5dHo6DY/FrI1mtY5/g3HY8+h3X6DBhuEB4Mtd8aZZqS5Nx6naiCECTNjWMF/Y
         CQzv2KlX+qauOJoN6ZunAqVeLTOdjoqq1GvybyMEJI80lEJKr14IwKBiUxf6hJa4xOHV
         CB8AL1qRcs8shqWLxPrLO1pT+UH7cji+qF4Fl0TPll+3NF8SIELJsHkKteoO7PBgaJ4Q
         2qrw==
X-Gm-Message-State: APjAAAV0Qk+HKuiUOBXOfk5oa1XWkz38V053OmhmdeJO8yZ3dkRD4GId
        hT4CCW4qhj7OY/I2QPlj8W2wQow2
X-Google-Smtp-Source: APXvYqzzDgyVY/Jjx16zGLvUx65LBREM6VqRtllpZkGHYaJEr743AgiZMM6sTszk6faPOcoHq/ZM6A==
X-Received: by 2002:a05:6000:1186:: with SMTP id g6mr21697932wrx.17.1566810628639;
        Mon, 26 Aug 2019 02:10:28 -0700 (PDT)
Received: from szeder.dev (x4db5125e.dyn.telefonica.de. [77.181.18.94])
        by smtp.gmail.com with ESMTPSA id a142sm18775500wme.2.2019.08.26.02.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 02:10:27 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:10:25 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Cesar Eduardo Barros <cesarb@cesarb.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 20/23] .gitignore: touch up the entries regarding
 Visual Studio
Message-ID: <20190826091025.GQ20404@szeder.dev>
References: <pull.287.git.gitgitgadget@gmail.com>
 <pull.287.v2.git.gitgitgadget@gmail.com>
 <dc4a9cc6205afac03d1154ca935e4334536fa693.1564430879.git.gitgitgadget@gmail.com>
 <20190825120741.GM20404@szeder.dev>
 <9eed02e7-7e2d-4ae3-6c08-ab17b3c92fb6@iee.email>
 <20190825190957.GN20404@szeder.dev>
 <e221aaf8-7d0b-6feb-3f58-1e9e4382939b@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e221aaf8-7d0b-6feb-3f58-1e9e4382939b@iee.email>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 11:21:23PM +0100, Philip Oakley wrote:
> >>>>diff --git a/.gitignore b/.gitignore
> >>>>index e096e0a51c..e7bb15d301 100644
> >>>>--- a/.gitignore
> >>>>+++ b/.gitignore
> >>>>@@ -230,6 +230,7 @@
> >>>>  *.ipdb
> >>>>  *.dll
> >>>>  .vs/
> >>>>-/Debug/
> >>>>-/Release/
> >>>>+*.manifest
> >>>This new line ignores the tracked file 'compat/win32/git.manifest'
> >>>that was added fairly recently in fe90397604 (mingw: embed a manifest
> >>>to trick UAC into Doing The Right Thing, 2019-06-27).
> >>>
> >>>I wonder whether that's intentional or accidental.
> >>>
> >>>I'm inclined to think that it's merely accidental, because, as far as
> >>>I understand, this is an old-ish patch from times when there wasn't
> >>>any 'git.manifest' file in tree, and simply noone noticed that in the
> >>>meantime we got one.  But I have no idea about how a Git build with
> >>>Visual Studio is supposed to work, so it doesn't really matter what
> >>>I'm inclined to think :)
> >>>
> >>At the time, it was just one of the many non-source files that were
> >>generated by Visual Studio that cluttered the status list and also could
> >>accidentally added to the tracked files.
> >>
> >>The newly added .manifest file does appear to be there to 'trick' the
> >>Windows User Access Control (UAC) which otherwise can be an annoyance to
> >>'regular' users.
> >Sorry, I'm not sure how to interpret your reply, and can't decide
> >whether it tries to justify why that tracked file should be ignored,
> >or explains that ignoring it was accidental.
> >
> >Anyway, ignoring that tracked file apparently triggered a nested
> >worktree-related bug in 'git clean', which can lead to data loss:
> >
> >https://public-inbox.org/git/20190825185918.3909-1-szeder.dev@gmail.com/
> >
> Basically manifests are a build artefact from Visual Studio [1], so it was
> just another file to be ignored, from a _source_ control control viewpoint.

I understand that manifest files, in general, are build artifacts.
But does Visual Studio overwrite the existing
'compat/win32/git.manifest' file in particular?  Yes or no? :)

