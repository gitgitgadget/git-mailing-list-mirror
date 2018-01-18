Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 852F91FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 15:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755301AbeARPA0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 10:00:26 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39855 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754941AbeARPAV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 10:00:21 -0500
Received: by mail-pg0-f65.google.com with SMTP id w17so8595243pgv.6
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 07:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=f8MgY5rCv29K46n9Yj4LYII1LadmfuwKdK8hjVZvRC0=;
        b=kVDL3G+uoIDmewW5dyPXBj1DjntUi6lAh/w5nQC+n93Z5Uk1eirFQdZT4A5uOJjSkM
         9lvIa4qD+P8EyzD6rJYQxo6Xza6YLHxrUkIGaju0iEzwCw0F0n4tH9PQhrPuZaDm8A4c
         WpQ9YBo45SxHiQ6bfQLcznMCnyx+UZ8GrdneFsnS/8Aq2cusWxAAc32ZmNK5+2z4fu1h
         M2NYdVGDaqar3/nF8zRv75PFe5KGKc7cFzyPDzoKn4RjnME6mLwsYo2KR9HX9I5Zh8fY
         Td1t+Q113XOD5h13jQ3B5zmIWiFdqrtkELmT0PJc2LFtGZaJv+AG2bhjbjSFROSHe4Uh
         qb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f8MgY5rCv29K46n9Yj4LYII1LadmfuwKdK8hjVZvRC0=;
        b=fuR5o3M1e10Biz0ImmUK9clIGLCYC//rXQHvwNx69c3Z6pI/clQmAql/k2DU+JT34P
         jTQ8N9ZwnbMvIMly5FHFkUsWJLhvkjMe+gpDaZ7mUxCrQt1Nv5gsiH/LYopFn7hdVLDG
         DifpBjl8iHXd7j7FnOpx64b0B4HZwVTq3P0tAJX7pCF7T0cnMQ92oByr7fMvjFJbjxgY
         qhjghPJ/aeEHO8luZIkAu9oAFbN2gfQkOt10XwJSrM+0EBLTW7uJYCEGP/oS7Js9mUVu
         XI81RjzlQ5cwDNhtxC7tCvjQ1a7a6jbTReLC/6rMWk/28CZMhRGsh13fId/eQeirocRj
         T1FQ==
X-Gm-Message-State: AKGB3mJnkqlacvW6pdXhAXM3FcUK47pCa+Aa9kGY+IZyPJvp07hAWCCG
        Chyfm0mm8AIFtuEsf2KvWeA=
X-Google-Smtp-Source: ACJfBovALxZwBBBWfAuIhrSR/e0REnAJQ4cAc3+zZYt3TWz8/eiqo2dHKM49nAOe5uf/nxw03Kyr/g==
X-Received: by 10.98.97.3 with SMTP id v3mr42911526pfb.124.1516287620503;
        Thu, 18 Jan 2018 07:00:20 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id m24sm14292364pfj.184.2018.01.18.07.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 07:00:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 18 Jan 2018 22:00:14 +0700
Date:   Thu, 18 Jan 2018 22:00:14 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] read-cache: don't write index twice if we can't
 write shared index
Message-ID: <20180118150014.GA2097@ash>
References: <CACsJy8A_moFProjfPAJFn2aP52w5qdYdOu4Ygox1qMMitNUHLg@mail.gmail.com>
 <20180114101820.4273-1-pclouds@gmail.com>
 <20180114101820.4273-3-pclouds@gmail.com>
 <CAM0VKjmGo5gjUBpTQp9M+pvZzBMDAmYYCu-5VfG-8LYRxU7i0Q@mail.gmail.com>
 <CACsJy8BBXQ9KErfiuf2ty_4szE2fiHLDiKvMig1LbSefzf-o7w@mail.gmail.com>
 <20180118132931.GA21914@sigill.intra.peff.net>
 <CACsJy8BkJXeaG3mYNEsfVK4N_-WxwU2Pk2pa1FThH1sMEW2yxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8BkJXeaG3mYNEsfVK4N_-WxwU2Pk2pa1FThH1sMEW2yxA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 08:36:32PM +0700, Duy Nguyen wrote:
> On Thu, Jan 18, 2018 at 8:29 PM, Jeff King <peff@peff.net> wrote:
> > On Thu, Jan 18, 2018 at 07:47:50PM +0700, Duy Nguyen wrote:
> >
> >> I may need help getting that log (or even better the trash directory
> >> of t1700). I tried -m32 build, then valgrind on amd64 (because it
> >> didn't work with my 32 build), running the tests with dash and even
> >> the linux32 docker version that comes with "ci" directory. Everything
> >> worked for me.
> >
> > It fails for me locally if I run it in the linux32 docker environment.
> > Here's the end of the "-v -x" output:
> >
> >   + GIT_INDEX_FILE=/usr/src/git/t/trash directory.t1700-split-index/new-index git -C ro update-index --split-index
> >   + chmod -R u+w ro
> >   + rm ro/.git/sharedindex.bbdf63f5a51242904dba2ea929ea4f56fcc340b6
> >   + GIT_INDEX_FILE=new-index git ls-files
> >   fatal: .git/sharedindex.bbdf63f5a51242904dba2ea929ea4f56fcc340b6: index file open failed: No such file or directory
> >   error: last command exited with $?=128
> >   not ok 23 - graceful handling splitting index is not allowed
> >
> > I don't know if the trash state will be helpful, but it's attached.
> 
> Thanks. Somehow my way of forcing mks_tempfile() to fail, well..
> failed in this environment. I see the same output if I remove "chmod
> -R u-w ro". I think I have enough to continue from here.

The test suite was run as root, no wonder why my removing write access
has no effect. I got the test to pass with this, but then it fails
with

    Can't write .prove (Permission denied) at /usr/share/perl/5.22/App/Prove.pm line 542.

Some more chown'ing or chmod'ing is required....

-- 8< --
Subject: [PATCH] ci: don't accidentally run the test suite as root

This script assigns and adds a user named "ci" in a subshell so the
outer CI_USER is not affected. For some reason, CI_USER is actually
empty on Travis linux32 builds. This makes the following "su" useless
and the test suite is run as root.

Some tests may expect file/dir permissions to be respected. But root
rules all and ignores all. That could make tests fail.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 ci/run-linux32-build.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index c19c50c1c9..92b488ff27 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -21,8 +21,8 @@ linux32 --32bit i386 sh -c '
 # If a host user id is given, then create a user "ci" with the host user
 # id to make everything accessible to the host user.
 HOST_UID=$1 &&
-CI_USER=$USER &&
-test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER) &&
+CI_USER=${USER:-ci} &&
+test -z "$HOST_UID" || useradd -u $HOST_UID $CI_USER &&
 
 # Build and test
 linux32 --32bit i386 su -m -l $CI_USER -c '
-- 
2.16.0.47.g5ff498d35b

-- 8< --
