Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66BD41F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 13:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbcG3NbL (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 09:31:11 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34855 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbcG3NbI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 09:31:08 -0400
Received: by mail-lf0-f47.google.com with SMTP id f93so88283414lfi.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 06:31:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HbxMaDQQS1r0nxmF2Zzu0Pfw1uOMdxQF6cmMgrkI3A0=;
        b=jmHlOBGTztr5rwnEO5aP5UeDe0Svixq9/9LmQGgy6WW2/4JpcdEjPohKezS/Fv7O5W
         hJuXuyx5LfUYI4CwaUIk4I7ft5ragiOfw1Lz7HbbFI3AxymRTAJPquy3+co/KpMBGVmx
         WQySCy6ONz6FGpBTLGVIgiRCRoULbDIGjgnxOEUl7VuULqVTr4Ivat4PFKM6nH6pmdHC
         Glgj7lxfLjYONn2Im8wDG3uGxJkiSY7v0G9N3so5nkZ8qG9fk08iogvT30k1GWS6zGeK
         rKckxBTfgqRCySCDfR5D7gQBknI8wiXYyuCC7mOfbmbBskapW/cyS0/cgYdBBqbjmBgY
         17SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HbxMaDQQS1r0nxmF2Zzu0Pfw1uOMdxQF6cmMgrkI3A0=;
        b=jXU/gaNksos/OXJsmfA9oOvuQdSlI6YerZ/uQT+IjDV9ItL8+rm1ltTay6pqirGj9U
         Pc1o0247YQ4aVMhaL1HwxMa0yJI0TIbVNM7GYdGkD4hQmWamCJaZ5wQCZ1jKBSELAp/7
         1YUl4gsCVC4AVp6OftNcE5ky3qC0lw17AFnLqqA4j+lJJoR9e3idQPBxnxA0AIxJqb1N
         Db9A/z2Q0Z+ho8JrB9Z5bZYlN2QSmfzd4IanRvApAWE0GzdaxlZib57bn1J+sm/5jayq
         dPlGbyWwQKqc8HWMuB/RDPe2bFn3ofBEilKXHDEmfvyJXRB2F5xaN05YSPc71q3vUyuF
         5mig==
X-Gm-Message-State: AEkoouvJQTXZ8+z4wbK1BLlzY2G0Tbk6aI1m05Fjm+FkrKm/UDsHKLdvDphsr4UU+4ZgDQ==
X-Received: by 10.46.71.69 with SMTP id u66mr15590056lja.14.1469885466273;
        Sat, 30 Jul 2016 06:31:06 -0700 (PDT)
Received: from duynguyen (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id r196sm3553091lfd.41.2016.07.30.06.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jul 2016 06:31:05 -0700 (PDT)
Date:	Sat, 30 Jul 2016 15:31:03 +0200
From:	Duy Nguyen <pclouds@gmail.com>
To:	Eric Wong <e@80x24.org>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	David Turner <novalis@novalis.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: t7063 failure on FreeBSD 10.3 i386/amd64
Message-ID: <20160730133102.GA4871@duynguyen>
References: <20160718223038.GA66056@plume>
 <20160718225424.GA813@plume>
 <CACsJy8CRHsyT8YLPYoHZnxCuMvF1W=S5iayy2eoHZhbSe_qmDg@mail.gmail.com>
 <CACsJy8D9Cy1bjzXddCTOOT7X3smBBB3xccEg7CHaOKAZruHVag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8D9Cy1bjzXddCTOOT7X3smBBB3xccEg7CHaOKAZruHVag@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 07:33:17PM +0200, Duy Nguyen wrote:
> On Tue, Jul 19, 2016 at 6:12 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Tue, Jul 19, 2016 at 12:54 AM, Eric Wong <e@80x24.org> wrote:
> >> Oops, forgot to Cc some folks who worked on this :x
> >>
> >> Filesystem is ufs and it fails regardless of whether
> >> soft-updates is enabled or not.
> >
> > Nothing stands out to my eyes, so I'm going to install freebsd this
> > weekend. I hope ufs does not have any nasty surprise for me. Stay
> > tuned.
> 
> The good news is it looks like a false alarm due to a racy test (and
> it happens on ext2 too, zfs not tested), no big flaw or anything
> (phew!). The bad news is, I still have no idea what's happening and
> why is_racy_stat() returns true in this particular case. It'll take
> some more time...

I give up. FreeBSD behaves so weird in this case.

The code of interest is this

    test_expect_success 'test sparse status with untracked cache' '
    	: >../trace &&
    	avoid_racy &&
    	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
    	git status --porcelain >../status.actual &&
    	...
    '

For some reason mtime of current directory is always latest time when
git makes the stat call. Even if I make avoid_racy sleep longer,
several seconds, mtime of "." will be the latest time.

But cwd stat info is _not_ supposed to change! We haven't touched it
while avoid_racy is running. avoid_racy is just a wrapper of
sleep. And sleep does not change cwd's mtime from the shell prompt. I
tried running the script with bash too (suspecting problem with
default shell) and replaced avoid_racy with /bin/sleep. Nothing.

Does our test framework run something in background??? No, it
can't be.

If a stat call is made before avoid_racy, then mtime is pinned down
and does not change anymore. So a "fix" is something like this. I
tried a minimal program that just does "stat" to make sure it's stat
that does it, not some side effect from 'ls'.

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 38b3890..fd199a0 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -421,6 +421,7 @@ test_expect_success 'create/modify files, some of which are gitignored' '
 
 test_expect_success 'test sparse status with untracked cache' '
        : >../trace &&
+       ls -d . &&
        avoid_racy &&
        GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
        git status --porcelain >../status.actual &&

--
Duy
