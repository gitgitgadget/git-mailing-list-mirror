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
	by dcvr.yhbt.net (Postfix) with ESMTP id E21CA1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 09:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfG2Jje (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 05:39:34 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37445 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfG2Jjd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 05:39:33 -0400
Received: by mail-wr1-f44.google.com with SMTP id n9so35961831wrr.4
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KteUGlY++1znoeMCjdCJE0hGR822St3yRo4UYroANLA=;
        b=kFeGiPvSEIyM+XvbntEuFUURH5GYXnfY3niAGd/CPCvspPQQrED+rV6b61IwvPSetx
         boHMYdcv2MWJ9vxZ6u9bVuXkFid5i4xqC9fUbhfnYqx/iNSTGW2yNVDxOSabfdwMqGlU
         PLWQ8nKcxFtLJHkyFZ7OEDPIgur3DPnrZPr1wE9ZNzgTXWKs831hCXh3eyImPhsxlXOv
         GB8e3Zm7M5klxxt6EPsvoHZE0MVe4PQiYjY2h1gPtL9GuNuqNMfQhSTxVPy+3/GppE71
         0sAkOxAx+ROkcYtSB+36cQ8VzzMXemiBnAxyOG6kviOfpB1N6NQQGP86XvjdXqgX5jG0
         E5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KteUGlY++1znoeMCjdCJE0hGR822St3yRo4UYroANLA=;
        b=TBLNZeNYE2mgbNAd0nrP7fsQ7LLqX4B3gLILOEG2b2yTKnxOfjqheWJ56EZ7nDKkd6
         FJOdr+mofHiSEpcPCqavW3oPiEMbaNvZ2zNmv6FWlLkzNLGxdD5e1jNySefnF0iyHLLw
         XJgxKTR11eEvn4Ur34ayHW8krtcwfPbKNvCNvN4bRFXl8BUvm+B8db51cRk7cOoj+pCz
         OAtFdncrVZH5ugh7CSGGg74ub5NEU9dnqj/oBfAZb9Kp0pRWh3Njn4P8KyO+1amQfevO
         r2beYMMsYvUnJZrY4fPtFV8lTMyfq0uRjXRHrYwHsOTOuguKyiHYHQAKnhGcPU00sYHp
         Pa3w==
X-Gm-Message-State: APjAAAWNPbBOAEu8Mp8SiVeZjHPGsbMmHrpRQ8L0rGv5VgzqiOv7Qc+3
        hdLgCOCXwtWGvHX8Hl3SPw8=
X-Google-Smtp-Source: APXvYqxg1rUDm1mhiusVNfId6W+o3RFalusC7hExDeH9EBmxTn0YIDLduLnpL4Ooem4QojMY9jX9kA==
X-Received: by 2002:a5d:428a:: with SMTP id k10mr1070180wrq.329.1564393172128;
        Mon, 29 Jul 2019 02:39:32 -0700 (PDT)
Received: from szeder.dev (x4dbd8f4e.dyn.telefonica.de. [77.189.143.78])
        by smtp.gmail.com with ESMTPSA id q18sm73459672wrw.36.2019.07.29.02.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 02:39:31 -0700 (PDT)
Date:   Mon, 29 Jul 2019 11:39:28 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Olivier Bornet <olivier.bornet@puck.ch>
Cc:     git@vger.kernel.org
Subject: Re: Problem with fsck and invalid submodule path in history
Message-ID: <20190729093928.GP20404@szeder.dev>
References: <9C668779-15AC-4099-AAFA-7FFF519D426F@puck.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9C668779-15AC-4099-AAFA-7FFF519D426F@puck.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 29, 2019 at 09:58:52AM +0200, Olivier Bornet wrote:
> I have a git repository with an error in a submodule path in the history.
> The submodule path is “-f”, which is not allowed. But for some reason, it’s in the history of the git, and I’m trying to find a way to manage it without having to rewrite the full history on the main gitlab (if possible)...
> 
> To reproduce this unwanted history:

> After that, even if the git is working correctly, we have a “bad” history if we check with fsck:
> 
>     $ git fsck
>     Checking object directories: 100% (256/256), done.
>     error in blob 19a97d3b70760c74b780c8134e33f5392292c2e6: gitmodulesPath: disallowed submodule path: -f
> 
> Is it possible to correct it? Must git handle this kind of errors?

To correct without rewriting history, no.

However, you can tell 'git fsck' to ignore it using the
'fsck.skipList' configuration variable (see 'git help config'; for
some reason it's not included in 'git fsck's documentation):

  $ cat <<EOF >.git-fsck-skiplist
  > # invalid submodule path
  > 19a97d3b70760c74b780c8134e33f5392292c2e6
  > EOF
  $ git config fsck.skipList .git-fsck-skiplist
  $ git fsck
  Checking object directories: 100% (256/256), done.

It may or may not be worth committing this file, I'm not quite sure
what the best practice is.  By committing it others don't have to
maintain such a skiplist file themselves, though they still have to
set the config variable.  OTOH, if anyone sets this config variable
and attempts to run 'git fsck' while on a branch that doesn't contain
this file, then they will get a 'fatal: could not open object name
list: .git-fsck-skiplist' error.

And it won't help anyone cloning the repository with
'fetch.fsckObjects' enabled.

