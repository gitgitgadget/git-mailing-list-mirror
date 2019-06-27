Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F7271F461
	for <e@80x24.org>; Thu, 27 Jun 2019 20:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfF0U6S (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 16:58:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44801 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfF0U6R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 16:58:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so1543741pgp.11
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hu4l12rrvkxJFKPP7GlH0UjXGTCBH+ny12uWKTSA9+w=;
        b=M2J8o8Tp+R1yHLx/NJ3q2/pChQ7EBxGH4AA3aoD/XCucvypgP5A54FcfzTlRtSoP71
         GdR9yvUAAIE0RFtoaYRmGOfziEjxEg5FklBQEZDTAPvis50nfYztWhtvlAEamb26FqN0
         3Ljct2a497pbjKk9zwwRhwClSAKWDoEBHDgD4OfVs0qwEQKUzsZl8UqKFwRH/nsl80SX
         rAKTFJOXB5pNaaR0Dy2BT4V3PX2zHBi/hgSPEKT5bEU/xHbEEujpUY/3MAfccEcYNVUF
         taV9CAY7dmRp7T8JECNUuKTL+edtt8kbMP81jlJwAjVISf2vh8aWV1u24PZatKgLedj3
         WuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hu4l12rrvkxJFKPP7GlH0UjXGTCBH+ny12uWKTSA9+w=;
        b=M9mA9n1TvaGeZtY7v6dITzzA9pcv1fwc3D1ulDIfmWoWZQ58g0vBrXUc04+/AFuX2T
         uYubL97i4mO3c7wfZjbunTklc4cZKF6M1GCaJjH46rytzytpvXBeFgl+GI5aEGg2LIOH
         O97d7KijI6oDLaoc57pNVR3lr61S/IiFgz+4WO1lmL1OSxysIcVMEKdTqRt1I+f2XPyY
         lXe8mwHGpBDQVvcCKfK7nZsNzOLf8dQBTznXSwpjHSUQqoYxHYkZEPPwK6OqtvR9Bp4W
         0/UWcWEqGSgYIut3qcVFEJKTDN8VmjvWykb+SuEvo2x/BswGwiijhPtddwMc0yUbhKCK
         8f1w==
X-Gm-Message-State: APjAAAUi432trs5A71ZpnsSy0Ur6A7G/c7cgd1wHVHQSQyCu8sYeHHqK
        +z+kPHpEr5gyfY8OXXb47Tx+dyFwmjc=
X-Google-Smtp-Source: APXvYqxLqzkrjU47Necu6Bmthmab/xqfjHarnpnl9zZqEbonbwIG4BhKE+WbYYKMz/PdxVDIDHBk8w==
X-Received: by 2002:a17:90a:c596:: with SMTP id l22mr8592172pjt.46.1561669096606;
        Thu, 27 Jun 2019 13:58:16 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id d123sm4044695pfc.144.2019.06.27.13.58.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 13:58:15 -0700 (PDT)
Date:   Thu, 27 Jun 2019 13:58:11 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH v2 07/13] walken: filter for authors from gmail
 address
Message-ID: <20190627205811.GE245941@google.com>
References: <20190626235032.177551-1-emilyshaffer@google.com>
 <20190626235032.177551-8-emilyshaffer@google.com>
 <CAPig+cQQCXA-WsbQrC6XoejjF-roqhmcB7iVH1nA+zUDYTN3vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQQCXA-WsbQrC6XoejjF-roqhmcB7iVH1nA+zUDYTN3vQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 01:20:25AM -0400, Eric Sunshine wrote:
> On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > In order to demonstrate how to create grep filters for revision walks,
> > filter the walk performed by cmd_walken() to print only commits which
> > are authored by someone with a gmail address.
> > [...]
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > diff --git a/builtin/walken.c b/builtin/walken.c
> > @@ -60,6 +59,10 @@ static void final_rev_info_setup(int argc, const char **argv, const char *prefix
> > +       /* Add a grep pattern to the author line in the header. */
> 
> This sounds as if we are adding something to the author line, which is
> confusing. Maybe say instead:
> 
>     /* Apply a 'grep' pattern to the author header. */
> 

I also s/author/'&'/; thanks.

> > +       append_header_grep_pattern(&rev->grep_filter, GREP_HEADER_AUTHOR, "gmail");
> > +       compile_grep_patterns(&rev->grep_filter);
