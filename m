Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C761F404
	for <e@80x24.org>; Sat, 27 Jan 2018 13:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeA0NKC (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 08:10:02 -0500
Received: from mail-pl0-f52.google.com ([209.85.160.52]:46103 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751904AbeA0NKB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 08:10:01 -0500
Received: by mail-pl0-f52.google.com with SMTP id 36so666987ple.13
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 05:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eHz1JF9N+QxfUlWwj2tabvGsBbKHGBe2+/oBlckLZSg=;
        b=G6K9nPoGdmMLR/XWLDSthGKrpge6djTNkkBXRnU0X6uerWPNSgkquynWfCTEIWqZms
         F+354ut/uHaHjomAikqL7dSw+v2wcOStIBaWRHxPj+M6el1s+JF4JRYBBODZAnYYQWaD
         QxQd8CXL6WbETiAHGpFbqbFexIyoNAC0ByZCFm2yu/QMmM1uqN6wgNZRDHw219YaSnnO
         Od+moHLd1kXbt1ZN2s3uoxRY5rpH/OUsI16JPy4LnTgK3KuyARul+Qkju897j0YFUHsT
         svyr9BH/p7akaY7iYX0I67rTfxTJY2l8Mn0Huj+sdf9D82+GTfcHsRQsL5XXuwHS970C
         sClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eHz1JF9N+QxfUlWwj2tabvGsBbKHGBe2+/oBlckLZSg=;
        b=EPCp73U072K84LLjrXaLjYrIp7KWnwm7SugJ2OxTgwjMjQZisxHNSiLPL4QCUUsH9S
         FJgTGPbuK4VuqCAmgajRJcnLoeh88Z6F1NahGelrtUlihJss4/hlyu5y6VCSdQNEc1tA
         aTUnrXncvEKn89lHuwqlv8+DH6zG4KJ4JkABfX1G0OnYJSOffWkhEFXPnPpCUF5645pt
         VPaZIQRKmios/gQh2QG9xAnOnu+NNU0S8mEKiJA97RN7FtMKiGq0z08A4qR9nXteBqks
         1LsvDn5p5GyN0oZlabQ7MfB7INxlnNqkQ3/8HJApfw6X2ers7jRlWBIFS8PCUlJ9g9Ry
         NAkw==
X-Gm-Message-State: AKwxytdy4P5IAbdEMO2LOMWwQmcTT9ehp0YX2GnMPtOHuQ7kJgqdEAtL
        xEy+MAYjZ8l/XXmNWQHGTgM=
X-Google-Smtp-Source: AH8x227Qlw7+XY6A3SMbgl5RyqtpvstYdcdK+jvckO12upxMgH7mAkgbK1mJ4r/nirxGBAngLM++LA==
X-Received: by 2002:a17:902:624:: with SMTP id 33-v6mr16532265plg.327.1517058600778;
        Sat, 27 Jan 2018 05:10:00 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id w2sm11071043pgm.59.2018.01.27.05.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jan 2018 05:09:59 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 27 Jan 2018 20:09:54 +0700
Date:   Sat, 27 Jan 2018 20:09:54 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Some rough edges of core.fsmonitor
Message-ID: <20180127130954.GA19922@ash>
References: <87efmcw3fa.fsf@evledraar.gmail.com>
 <CACsJy8BpO0s6facg+zcKC9icijpefkipM326n6xOArjn=ZW6+w@mail.gmail.com>
 <87bmhfwmqa.fsf@evledraar.gmail.com>
 <CACsJy8CJtW3LZ+4Z_06uM4rJO88FXsNvcw+zzVqdFpsQUKrvrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8CJtW3LZ+4Z_06uM4rJO88FXsNvcw+zzVqdFpsQUKrvrg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 27, 2018 at 07:39:27PM +0700, Duy Nguyen wrote:
> On Sat, Jan 27, 2018 at 6:43 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> > a) no fsmonitor
> >
> >     $ time GIT_TRACE_PERFORMANCE=1 ~/g/git/git-status
> >     12:32:44.947651 read-cache.c:1890       performance: 0.053153609 s: read cache .git/index
> >     12:32:44.967943 preload-index.c:112     performance: 0.020161093 s: preload index
> >     12:32:44.974217 read-cache.c:1446       performance: 0.006230611 s: refresh index
> >
> > ...
> >
> > b) with fsmonitor
> >
> >     $ time GIT_TRACE_PERFORMANCE=1 ~/g/git/git-status
> >     12:34:23.833625 read-cache.c:1890       performance: 0.049485685 s: read cache .git/index
> >     12:34:23.838622 preload-index.c:112     performance: 0.001221197 s: preload index
> >     12:34:23.858723 fsmonitor.c:170         performance: 0.020059647 s: fsmonitor process '.git/hooks/fsmonitor-watchman'
> >     12:34:23.871532 read-cache.c:1446       performance: 0.032870818 s: refresh index
> 
> Hmm.. why does refresh take longer with fsmonitor/watchman? With the
> help from watchman, we know what files are modified. We don't need
> manual stat()'ing and this line should be lower than the "no
> fsmonitor" case, which is 0.006230611s.

Ahh.. my patch probably does not see that fsmonitor could be activated
lazily inside refresh_index() call. The patch below should fix it.

But between your normal refresh time (0.020 preload + 0.006 actual
refresh) and fsmonitor taking 0.020 just to talk to watchman, this
repo seems "too small" for fsmonitor/watchman to shine.

I'm still a bit curious that refresh index time, after excluding 0.020
for fsmonitor, is stil 0.012s. What does it do? It should really be
doing nothing. Either way, read index time seems to be the elephant in
the room now.

-- 8< --
diff --git a/read-cache.c b/read-cache.c
index eac74bc9f1..d60e0a8480 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1367,12 +1367,21 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	unsigned int options = (CE_MATCH_REFRESH |
 				(really ? CE_MATCH_IGNORE_VALID : 0) |
 				(not_new ? CE_MATCH_IGNORE_MISSING : 0));
+	int ignore_fsmonitor = options & CE_MATCH_IGNORE_FSMONITOR;
 	const char *modified_fmt;
 	const char *deleted_fmt;
 	const char *typechange_fmt;
 	const char *added_fmt;
 	const char *unmerged_fmt;
-	uint64_t start = getnanotime();
+	uint64_t start;
+
+	/*
+	 * If fsmonitor is used, force its communication early to
+	 * accurately measure how long this function takes without it.
+	 */
+	if (!ignore_fsmonitor)
+		refresh_fsmonitor(istate);
+	start = getnanotime();
 
 	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
 	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
-- 8< --
