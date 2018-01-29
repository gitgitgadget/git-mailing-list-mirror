Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E52031F576
	for <e@80x24.org>; Mon, 29 Jan 2018 09:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbeA2Jkn (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 04:40:43 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42138 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeA2Jkl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 04:40:41 -0500
Received: by mail-pf0-f194.google.com with SMTP id b25so4559329pfd.9
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 01:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QVph7lxW4ex7Ze1ZeDIDWNyp3uzEBa3oO7ib5ghClvU=;
        b=aV/qO729Adw0tHL5z7fKpKT1ocLjlDVFs6TzAoVIGortj2Rx4lU5QJwlfIPlSC4LPr
         4LpkB/XKx9h7xUQpvfcPfkfJQwPkN4ofGiyGuZYcWaRQqJpFG5l8GiPjLb3bRFUdoGhN
         N6wVF0RORsyenUt6xiC0p5F5jjB4fM72VsYo6fxbGrsbZ7buQKhQm0tFKSbV1XJeVG4f
         MjDGMHVnjn/llWs6P3y4bSWMTXXO7l4cxnK5cTt/OVraYlZicJIgI2l7kU0tj87cGWtf
         iIk6LxpOAAzMljX7z65pcM8dJW/Vl9rTPRsj/HyCg2fy6OHML6TodpnoQw9pSL42yYrd
         a5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QVph7lxW4ex7Ze1ZeDIDWNyp3uzEBa3oO7ib5ghClvU=;
        b=GhGcny2yRRf5sNILnCdbcTIISoB6GQTqbmtlOXpjryKVsxzXgga94gbe0+TePRa76D
         4JdC92MpxitB0XczVuqS75LUOsrxqKAzjg+b4geADm7mMiHMxzoDOKC/Ki5O3urZLERl
         TJ55vdNrzgL5v7YObfPaaOCnjLF+/F6C8dkkCzCaTQdWMeA0DzYc2pTWfGz9t451L98R
         foy7dwnMK7+aEMCSlGkDaFe+bV4BSkUUVDfHHzTW0TlqYR1VOl9c2tLVVY6cGve8Gx/a
         3gHsfY6EqHurz3RdUgazTBDRwEtNA0kulotLtgFT/i/5MjJMJ4KLWETB2YK8V99+pOFl
         1h9g==
X-Gm-Message-State: AKwxytfWHEP/1Fsk3SBk1PXu/I8ppWbAVA2mRfP0Plx2fXvklgL8J50b
        aqRHQD2A4WuXQIAPeU+iFn4=
X-Google-Smtp-Source: AH8x22746C5gi2wWFf5udPCMhv4Skbz24XEbyLCbIV2m52t4Prz/PtrLv9oB7uE2rfJPrQquIQl0Vw==
X-Received: by 2002:a17:902:3064:: with SMTP id u91-v6mr21109498plb.421.1517218841080;
        Mon, 29 Jan 2018 01:40:41 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id c29sm33732768pfd.172.2018.01.29.01.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jan 2018 01:40:40 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 29 Jan 2018 16:40:34 +0700
Date:   Mon, 29 Jan 2018 16:40:34 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Some rough edges of core.fsmonitor
Message-ID: <20180129094033.GA8670@ash>
References: <87efmcw3fa.fsf@evledraar.gmail.com>
 <CACsJy8BpO0s6facg+zcKC9icijpefkipM326n6xOArjn=ZW6+w@mail.gmail.com>
 <87bmhfwmqa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bmhfwmqa.fsf@evledraar.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 27, 2018 at 12:43:41PM +0100, Ævar Arnfjörð Bjarmason wrote:
> b) with fsmonitor
> 
>     $ time GIT_TRACE_PERFORMANCE=1 ~/g/git/git-status
>     12:34:23.833625 read-cache.c:1890       performance: 0.049485685 s: read cache .git/index

This is sort of off topic but may be interesting for big repo guys. It
looks like read cache's time is partially dominated by malloc().

This is the performance breakdown of do_read_index()

$ GIT_TRACE_PERFORMANCE=2 ~/w/git/t/helper/test-read-cache
0.000078489 s: open/mmap/close
0.038915239 s: main entries
0.018983150 s: ext TREE
0.012667080 s: ext UNTR
0.000005372 s: ext FSMN
0.001473470 s: munmap
0.072386911 s: read cache .git/index

Reading main index entries takes like half of the time (0.038 vs
0.072). With the below patch to take out hundred thousands of malloc()
we have this, loading main entries now only takes 0.012s:

$ GIT_TRACE_PERFORMANCE=2 ~/w/git/t/helper/test-read-cache
0.000046587 s: open/mmap/close
0.012077300 s: main entries
0.020477683 s: ext TREE
0.010259998 s: ext UNTR
0.000010250 s: ext FSMN
0.000753854 s: munmap
0.043906473 s: read cache .git/index

We used to do less malloc until debed2a629 (read-cache.c: allocate
index entries individually - 2011-10-24) but I don't think we can
simply revert that (not worth the extra complexity of the old way).

Now "TREE" and "UNTR" extensions become a bigger problem.

-- 8< --
diff --git a/read-cache.c b/read-cache.c
index d60e0a8480..88f4213c99 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1622,7 +1622,12 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
 						   const char *name,
 						   size_t len)
 {
+#if 0
 	struct cache_entry *ce = xmalloc(cache_entry_size(len));
+#else
+	static char buf[1024];
+	struct cache_entry *ce = (struct cache_entry *)buf;
+#endif
 
 	ce->ce_stat_data.sd_ctime.sec = get_be32(&ondisk->ctime.sec);
 	ce->ce_stat_data.sd_mtime.sec = get_be32(&ondisk->mtime.sec);
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 48255eef31..e1d21d17a3 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -8,7 +8,9 @@ int cmd_main(int argc, const char **argv)
 	setup_git_directory();
 	for (i = 0; i < cnt; i++) {
 		read_cache();
+#if 0
 		discard_cache();
+#endif
 	}
 	return 0;
 }
-- 8< --
