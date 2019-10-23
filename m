Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2061F1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 16:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404841AbfJWQfM (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 12:35:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35864 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733188AbfJWQfL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 12:35:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id w18so22294455wrt.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 09:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pUJDmHDV2n/zbwqHBBQuFoDwH5GZza/FNyon7xSCFKU=;
        b=aZDz8PmGLCbA6KZ8f8Kxlz1J25cYpxhXWizDmkZwx+l3p9CGdSKemWhqZe5/LYcSd1
         o5/hiystmWC3Px9FW/4J1MHjBL/DWZM2sovvconVpbOSlvvtigcx2UHe6lBozbnhIkbc
         1k72QilDWWGKnVB8eNmkOzQKwB96mh1BhNc7PcEmDlSMWAl54Ep/sNuJmJoJ65nJhszo
         UICryQ7UUD4I0BnZCpedB3Mc1XjxyAeFHQMZlEoJFI+E1JkV+Srr7XhCULcXY8X8XRT9
         a6sKq9Yy1IuOh/F4dL4CmTr8asGj2It/mcbgtL5k2aX9Z4w76DbqYk5X0eH9EtoZwB8E
         CZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pUJDmHDV2n/zbwqHBBQuFoDwH5GZza/FNyon7xSCFKU=;
        b=EfUVoXpMcfpqG1ToqlK6DEOKYSU5qHdwzG3KzXaGplQz+FifHuaXLe9tpEzNVgd/lK
         UZkS+kUbEKFzQdJjXVXGZ+yuB+7PmgSJ7He9hjBpCszfJcKzzexzuUe5lPJ6zeKx7LNg
         jfGXtNRYG7foL/AubYQe17lacS057iHCdo7PmJotvqIrt8ciMt4tFEPCPtm0DxEY/lHP
         0IR5rmG9AXEXqCGUrZzptYMbAFWOik80i0Jx/hixEOJgr+Ltxl1d6ceD/hbKq4PRzkGo
         GV6hNtF70stoaOhzrw2RkKX6rfU9uhTFoUcmhK226Mhrm+Nul3WrCjuYh14oX7YH85lU
         4IGQ==
X-Gm-Message-State: APjAAAXQOqrixWMO5oNpIQgQvuySHXiOX7L6o6hx7lpc/I33nr6mkBxF
        Sq5DJa5/cE+m6JUfbbFW9wY=
X-Google-Smtp-Source: APXvYqzZXqE+vZZhITlknUB/evbSKhs57JPHMin9w+AEpWdwbvhfSI5mOGMSJnOS4MKo8S0OGVJMNg==
X-Received: by 2002:adf:fe81:: with SMTP id l1mr9061137wrr.165.1571848509370;
        Wed, 23 Oct 2019 09:35:09 -0700 (PDT)
Received: from szeder.dev (x4db97b71.dyn.telefonica.de. [77.185.123.113])
        by smtp.gmail.com with ESMTPSA id v8sm25156019wra.79.2019.10.23.09.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 09:35:08 -0700 (PDT)
Date:   Wed, 23 Oct 2019 18:35:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/1] ci(osx): use new location of the `perforce` cask
Message-ID: <20191023163506.GJ4348@szeder.dev>
References: <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
 <pull.400.v3.git.1571789978.gitgitgadget@gmail.com>
 <9d80e845bf923c4543c49f9947aacb10c59ff6ce.1571789978.git.gitgitgadget@gmail.com>
 <xmqqsgnjhj5b.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsgnjhj5b.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 07:05:04PM +0900, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The Azure Pipelines builds are failing for macOS due to a change in the
> > location of the perforce cask. The command outputs the following error:
> >
> >     + brew install caskroom/cask/perforce
> >     Error: caskroom/cask was moved. Tap homebrew/cask-cask instead.
> > ...
> > In any case, as the error message at the top of this commit message
> > shows, 'brew install caskroom/cask/perforce' has stopped working
> > recently, but 'brew cask install perforce' still does, so let's use
> > that.
> 
> It appears that OSX jobs at Travis are getting hit by this issue.
> Here is what our failed build ends with, for example:
> 
>     +brew install caskroom/cask/perforce
>     Error: caskroom/cask was moved. Tap homebrew/cask-cask instead.
> 
>     cf. https://travis-ci.org/git/git/jobs/601697815
> 
> Today's 'pu' has this topic queued, and it seems to help even the
> builds at Travis ('pu' seems to fail the test for totally different
> reason, though):
> 
>     +brew link gcc@8
>     Error: No such keg: /usr/local/Cellar/gcc@8
> 
>     cf. https://travis-ci.org/git/git/jobs/601697903

Yeah, that's a new one, so we don't get too bored.  We'll need the
patch below as well:

 --- >8 ---

Subject: [PATCH] ci: fix GCC install in the GCC OSX job

A few days ago Travis CI updated their existing OSX images, including
the Homebrew database in the xcode10.1 OSX image that we use.  Since
then installing dependencies in the 'osx-gcc' job fails when it tries
to link gcc@8:

  + brew link gcc@8
  Error: No such keg: /usr/local/Cellar/gcc@8

Apparently 'brew link gcc' works, so let's do that then, and fall back
to linking gcc@8 if it doesn't.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/install-dependencies.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index ce149ed39c..4e64a19112 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -48,6 +48,7 @@ osx-clang|osx-gcc)
 	brew install caskroom/cask/perforce
 	case "$jobname" in
 	osx-gcc)
+		brew link gcc ||
 		brew link gcc@8
 		;;
 	esac
-- 
2.24.0.rc0.502.g7008375535

