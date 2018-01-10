Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0898D1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 19:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754035AbeAJT16 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 14:27:58 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:46040 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753814AbeAJT0J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 14:26:09 -0500
Received: by mail-pg0-f42.google.com with SMTP id c194so91014pga.12
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 11:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WjztE+oYFa+tldRNMmX0GaAGRSa5Z2gT/itX+YHHGMQ=;
        b=BU/TBAaJf7SZepDiq8ZV2YEIaE2e9AkT4ZamROy7ZXJKM/UYQL1yokPfh6iFjVqvic
         amjKyV/pLgLbklCBCJGqIafFE0wBDU3a3rF/X5VVt4Z9+sJa9bWKid+qlxAhVAWc0i3n
         BrRn6hhRh87l0dKtrGLXmZ7xeh3O0DsRQfXe/5uMfAkDZaCXTSUDCZEb4N6xJSaKWXze
         PY2z87ofCVNNWew69Y/KJ687fTuFstA67bWNQyoAsS50k4Rqjto6YFqml3FuUwdOxu8r
         Vw6P6MJzA4VPEsFmuQuFQQQjXv2ZNsjEu+vYMTAqn23dYmdewOwcwYIlcuxT2AfVRK3p
         If1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WjztE+oYFa+tldRNMmX0GaAGRSa5Z2gT/itX+YHHGMQ=;
        b=VBPfWMvDsIe+0WTUTYmb/qQDP/ocBTN1fQc7XmZHDUdGLLpUX9onfcW4E6kmWR87yJ
         EPHC7tCzL1w30gxQA+i+95Aw7qHsU74NBaY4mTfVujdbRTixOqmdBmBRG0E0WG7JC2V/
         6VqT4D8ZFbbamuEBT4FKz7VTOMKaQwKnT3q62MxJp8WyD8UjYmv990G1K/9yH/JxnZT5
         Oaa1apA+7UKVG6D4ZzgAhJuJV1EGOBRk77PZw/rvun9xHefLCow6EI0Zt4r6FMxoGcPw
         lLQRlG4werJv8ZpX+Xoam0IZOIxKXJr3ucqt/LBHwwJd+ucnDr3YEZeiBwMw6SahaCNH
         2lWA==
X-Gm-Message-State: AKwxytesR1dTT6+eD9ADS7kl20jyWHqUmbPkfwtuCFalzmJDgRvoGKfg
        geKxM8fmqTBPka/4xOPQenZu6Q==
X-Google-Smtp-Source: ACJfBotJ8yIvGNDV3hkr5A+IDySbJDv9fD4gkxIc/lgWCHOFfRxMFbHAy2vfUi8xBFhSdYLLIw6iqg==
X-Received: by 10.98.130.5 with SMTP id w5mr5224119pfd.117.1515612368839;
        Wed, 10 Jan 2018 11:26:08 -0800 (PST)
Received: from google.com ([2620:0:100e:422:d157:f909:10c:5e57])
        by smtp.gmail.com with ESMTPSA id s73sm39681200pfi.167.2018.01.10.11.26.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 Jan 2018 11:26:08 -0800 (PST)
Date:   Wed, 10 Jan 2018 11:26:06 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] run-command.c: print env vars when GIT_TRACE is set
Message-ID: <20180110192606.GB53941@google.com>
References: <20180110104835.22905-1-pclouds@gmail.com>
 <20180110180945.GA53941@google.com>
 <CAGZ79ka0mhPy776fRYtvnaqd5P1dwvuaeONozEWpaJVZxSneiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79ka0mhPy776fRYtvnaqd5P1dwvuaeONozEWpaJVZxSneiA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/10, Stefan Beller wrote:
> On Wed, Jan 10, 2018 at 10:09 AM, Brandon Williams <bmwill@google.com> wrote:
> > At first when i read this I was under the impression that the whole
> > environment was going to be printed out...but i now realize that this
> > tracing  will only print out the delta's or the additions to the
> > environment that the child will see.  Maybe this should be called out
> > more clearly in the commit message?
> 
> It only adds newly set variables, I wonder why deletions are noisy?
> I could not find an example of a removal of environment variables
> specific to submodules that would be noisy.

Deletions are noisy because we append local_repo_env anytime we kick
off a child process (ok maybe not all the time, but a lot of the time)
which is just a list of ~15 deletions.

-- 
Brandon Williams
