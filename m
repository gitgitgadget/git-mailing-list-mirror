Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AF1E1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 15:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfFCPqt (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 11:46:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39411 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfFCPqt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 11:46:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so12629237wrt.6
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CxVmmnn73P1MB0M2HAORVfdhBaEuLYbkYgFL55r5T1c=;
        b=CUA9HCHri5ucBRmxhDvr5wg8H3qIvzo32fPDIG0mnYvu9ZNv19J9BXaLXT7QyVfmgB
         ACjfxIgEJ/ZcXYCX5zzxBch5ctGccUAlDCQJRqWaEdcW/V4Jye9SavSm9w/uk6u5+ZqO
         6vTkq57eCCKDbyVKEHeTh1f/K3amdVaEh2QMpSieLMJtr2UayBcjBG5wka5M+1yW6MVM
         okgrjMbFeV/lHqLNiI+EoO/Q/PVASAtMTg0vFyy2FEM5Wh+5lY4/QyEHugUGQxMh3tPG
         eDas9XNfs4iU3ufxVY3/iRUfBa29HyL+0ssRCT6W34amKpQuYNYbzm/6d0zy9WQxUFQw
         MGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CxVmmnn73P1MB0M2HAORVfdhBaEuLYbkYgFL55r5T1c=;
        b=UdZ6M+DR6vr/5e0g5UuK6htUENkc5gn0jdROrkq84rgl8BxY5/B3fhcNysUgfUOizB
         rLUr8BSn2OLZDFthXAGv1XbNChAV8G4Zwn8yvMFFFoUOOc07seeIec1dTTPU3zDMXpe7
         uIahrril/N+tIMxlHHDMXiF5LWuYVeBUbFCsfhMg8UgVsSJvfHR79KXDvP3bBWL8DPph
         x9AboINSE+Wf47dRwbXkey6dRZzXEmrG/shOTES48pmyR6ZH9NCKdeK6Y3Eb3GqiDt9H
         gIUfXg4ezV01SIKehnC60WYl+KnonZZr5pQTRLPbgD6tGcJP9eGHjtJHL8hFf8JdKSSm
         lZ8Q==
X-Gm-Message-State: APjAAAWeWpWDjQqiWnABiUHzca2fwp+LJsyEtLqLVrHrY0+/9rMex81n
        g1bSpu8Zb3dh1yZ5yVwhgnZPXr6u
X-Google-Smtp-Source: APXvYqyjT9+R4QsVQ+RvR5cdrD+5GaMXbQ2nUBCtCm/Jtng9bw6Rco3GF3lmncie5knTSh5KWT8mSQ==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr16820931wrq.28.1559576807474;
        Mon, 03 Jun 2019 08:46:47 -0700 (PDT)
Received: from szeder.dev (x4dbd37ab.dyn.telefonica.de. [77.189.55.171])
        by smtp.gmail.com with ESMTPSA id w14sm2512282wrk.44.2019.06.03.08.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 08:46:46 -0700 (PDT)
Date:   Mon, 3 Jun 2019 17:46:44 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] am: add --check option
Message-ID: <20190603154644.GQ951@szeder.dev>
References: <20190603142523.3826-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190603142523.3826-1-sir@cmpwn.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 03, 2019 at 10:25:23AM -0400, Drew DeVault wrote:
> ---
>  Documentation/git-am.txt |  7 ++++++-
>  builtin/am.c             | 13 +++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index fc3b993c33..bc01e87d85 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -9,7 +9,7 @@ git-am - Apply a series of patches from a mailbox
>  SYNOPSIS
>  --------
>  [verse]
> -'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
> +'git am' [--signoff] [--keep] [--check] [--[no-]keep-cr] [--[no-]utf8]
>  	 [--[no-]3way] [--interactive] [--committer-date-is-author-date]
>  	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
>  	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
> @@ -44,6 +44,11 @@ OPTIONS
>  --keep-non-patch::
>  	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
>  
> +--check::
> +	Instead of applying the patch(es), see if they are
> +	applicable to the current working tree and/or the index
> +	file and detects errors.

Note that in "real" patch series a later patch quite often depends on
the changes made in earlier patches, and this option should somehow
account for that.  I'm not sure how to do that without actually
applying the patches, though...

  # Create two patches, each modifying the same line in the same file.
  $ echo 0 >file
  $ git add file
  $ git commit -m initial
  [master 956965a] initial
   1 file changed, 1 insertion(+)
   create mode 100644 file
  $ echo 1 >file
  $ git commit -m one file
  [master fd65db1] one
   1 file changed, 1 insertion(+), 1 deletion(-)
  $ echo 2 >file
  $ git commit -m two file
  [master 1b878f1] two
   1 file changed, 1 insertion(+), 1 deletion(-)
  $ git format-patch -2
  0001-one.patch
  0002-two.patch

  # This shows that the second patch is applicable on top of the
  # first:
  $ git checkout HEAD^
  HEAD is now at fd65db1 one
  $ git apply --check 0002-two.patch ; echo $?
  0

  # But 'git am --check' reports that the two patches can't be
  # applied on the initial commit, because it attempts to apply the
  # second patch on the initial commit as well, instead on top of the
  # first:
  $ git checkout HEAD^
  Previous HEAD position was fd65db1 one
  HEAD is now at 956965a initial
  $ ~/src/git/bin-wrappers/git am --check 0001-one.patch 0002-two.patch
  Applying: one
  Applying: two
  error: patch failed: file:1
  error: file: patch does not apply
  Patch failed at 0002 two

  # Though, of course, they can be applied just fine:
  $ ~/src/git/bin-wrappers/git am 0001-one.patch 0002-two.patch
  Applying: one
  Applying: two

