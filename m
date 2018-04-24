Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ACEE1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 18:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeDXSj3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 14:39:29 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38130 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeDXSj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 14:39:28 -0400
Received: by mail-pf0-f193.google.com with SMTP id o76so8285470pfi.5
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vid/p+ZPFCOtJEicGOtUXBeU9myFf0HKdaIjusDsDuU=;
        b=EXqirHG4yNjoE+muUr8Ga5qumNcIdsHSEFgoaIb8yiXsGPikr0Bwl0KujHRpIyznCd
         sBXX9IXhC4N7E2Dyy0k6hI3xloxNBEKqf6LwrC7SBKo0fIZF+CDgweJYcWPnZW8IAvZU
         ld+IWczrDbx89osfjcuvi4BClxSZTMKV05xcNnRw+6655+7q8SBNtJUZmb3ZPIHxdTHl
         2Ib/MCuSjHLSWUvWmo6mDnOZudslNQVqGAzaGzK6+THbsiliCPKMGMiVMd2b7gl5Iah9
         kXiwx0+A2tpUwXCUtUdgwLldoXXJV1vccOEUUBdwKhl/u5olZ5zicQiySdQGlipL+KCa
         XjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vid/p+ZPFCOtJEicGOtUXBeU9myFf0HKdaIjusDsDuU=;
        b=e6TrhrvGmmBpuS5heSF+6VOnnad3pioysSSU/owFSRWR297n2jXrB7k+8cPxu+7bDb
         0P/V6MF7U3sgd4mrCNfNLKciiHr5IZNcQIJTlYPG6u+xhCS1q5g70xccaHpL7pegEdUL
         QIZiBbPjUxqh8bm0FeejY6l08x5ePKtFzSQ4gxFGMRY/M8ZwGnnAgaTArRv82EK8McFo
         UoBw+jY9wChYauPU6HnV39Cs0SK9aZAFY+tq1GZiWWc5AyL7759a9USE0F9ftL7kHOAh
         EKmSsV8rcT+04ybStvB9H9ZoXFNC+EG7o8PWvtIqMusYw0iTcSZl580EAHJeiG1BT9sF
         j4zA==
X-Gm-Message-State: ALQs6tDGLwW5ad5KogRAbv4P8Jwdx6BWjUWYBbf8mGbM7OcnQl+wagOd
        zUgRgBsfYRqCSgp48ciT2+tyIg==
X-Google-Smtp-Source: AIpwx4/VqbM1XNBIdaXqWX+XGlwpwU662wuipwetf0pj8fIMipbLxUNOatl+0CzQSRGOzEpLQOuEug==
X-Received: by 2002:a17:902:51ee:: with SMTP id y101-v6mr25173309plh.359.1524595167805;
        Tue, 24 Apr 2018 11:39:27 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:3dfa:3e1b:ab89:1ffb])
        by smtp.gmail.com with ESMTPSA id d3sm78814pgc.12.2018.04.24.11.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Apr 2018 11:39:26 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 24 Apr 2018 11:39:25 -0700
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 7/7] contrib/git-jump/git-jump: jump to match column
 in addition to line
Message-ID: <20180424183925.GA13637@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1524545768.git.me@ttaylorr.com>
 <23ea226b544e9e5fcdbbcda3adb5982e2cae2123.1524545768.git.me@ttaylorr.com>
 <CAPig+cTep_WuRy3qVHpZUMstc9Tgt9gFW=F8_0E8CZQQ8Jyq7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTep_WuRy3qVHpZUMstc9Tgt9gFW=F8_0E8CZQQ8Jyq7g@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 01:37:36AM -0400, Eric Sunshine wrote:
> On Tue, Apr 24, 2018 at 1:07 AM, Taylor Blau <me@ttaylorr.com> wrote:
> > Take advantage of 'git-grep(1)''s new option, '--column-number' in order
> > to teach Peff's 'git-jump' script how to jump to the correct column for
> > any given match.
> >
> > 'git-grep(1)''s output is in the correct format for Vim's jump list, so
> > no additional cleanup is necessary.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  contrib/git-jump/git-jump | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Based upon Ævar review[1], I was expecting to see git-jump/README
> modified by this patch, as well. Perhaps you overlooked or forgot
> about that review comment, or perhaps you disagreed with it?

Yes, and thank you for pointing that out. I recall reading his mail and
thought that when I prepared v3 that I had already included his changes,
but I had in fact not done so.

I amended the git-jump's README to prepare for v4, but was somewhat
confused by Ævar's comment when I reread [1]. I believe he was
suggesting updating the example to remove a reference to ag(1)'s
'--column' when configuring jump.grepCmd to 'ag --column'. Since
git-{grep,jump} support this now by default, I changed that line to
simply 'ag', instead of 'ag --column', as such:

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 4484bda410..7630e16854 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -37,3 +37,3 @@ Git-jump can generate four types of interesting lists:

-  3. Any grep matches.
+  3. Any grep matches, including the column of the first match on a line.

@@ -67,3 +67,3 @@ git jump grep -i foo_bar
 # use the silver searcher for git jump grep
-git config jump.grepCmd "ag --column"
+git config jump.grepCmd "ag"
 --------------------------------------------------
@@ -84,3 +84,3 @@ leaving you to locate subsequent hits in that file or other files using
 the editor or pager. By contrast, git-jump provides the editor with a
-complete list of files and line numbers for each match.
+complete list of files, lines, and a column number for each match.

---

Does this look OK?

Thanks,
Taylor
