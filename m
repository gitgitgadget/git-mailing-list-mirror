Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31F682036D
	for <e@80x24.org>; Tue, 21 Nov 2017 17:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbdKUR6u (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 12:58:50 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:40339 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdKUR6t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 12:58:49 -0500
Received: by mail-io0-f180.google.com with SMTP id d123so4286928iog.7
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 09:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rXbBl55cH9/ZdeIvQ+t++1LedPLQlzx2g4HaUlglw8g=;
        b=GxKVaIRLKy4R5HB/JTiOUlnv6+H0WDoCY4muhRbDtRN38RSo+t9QyJuj8G4fKYDgzG
         ply5B2Y4yVUTRNMd8EUQ3ZoqCoqdbo8imSkWbswG0LqZavZEVgKxcUXjsKrqGH2wHf4/
         3fTVOm6fFo85Wm9cEcJCE3f+/cRxToRAYUkQxZbc/uUlpL4XgWK281OfJZsJniab448b
         8H3/kU140q1ujPEnbXyX/5vG4d+3Uz4lJL0h3IsAawVJ08wACHrdLIZsXhtsi/8iIxcr
         57/7+AQIPIip2brN8c2r36rVLukoC4Ed8jTwpL8qb7SD9uNLbxjwmPcNgozKwqYduCRo
         eZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rXbBl55cH9/ZdeIvQ+t++1LedPLQlzx2g4HaUlglw8g=;
        b=REBHiPZxoWIiV6/8nSXpLPy0xcuDUBBStMhrbW3N7/ijhGC1J6ugFDUG1/z9FMbc9K
         23mSPP3F4bEq8ERgDAEczmcHhxPfxPOviV5LAEGjLmcShcfAvVoH+li+unoUKBM8mHVc
         4kLAR+xhX7zttFYph4/hnZlkLqfotUGWH2pJ3zt1y7qocA9RwwOoCNauserDo7AcaHB3
         DOac6iEltPNyluGPZRMkNxfFrGwL1Nyn+qdZkDYoqmyfN2PRvGyGAweoeea/gJXar9VT
         JI6TZDHbATCjJxqK4qjchwKIwEcYKtw7ozE4ckSiipFNd27WNveMH6kWuxiG7nMLenRa
         5vGQ==
X-Gm-Message-State: AJaThX5494HBCuVfqQWXPQQN3L4jAtb64JXaT78VLUPcKMXPEQoT21I1
        I0Ajg/xJlbi+Gw1ijoT9+mqBKBvt
X-Google-Smtp-Source: AGs4zMaApeoR9DhRbsoiH32pdsspeNxuAegLBoSmtZwtqrFt/3BKtyo6WAyPSSfs6xruQEqyxo9SlQ==
X-Received: by 10.107.169.152 with SMTP id f24mr18796527ioj.219.1511287128467;
        Tue, 21 Nov 2017 09:58:48 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g187sm905006itb.29.2017.11.21.09.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 09:58:48 -0800 (PST)
Date:   Tue, 21 Nov 2017 09:58:46 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] notes: fix erroneous "git notes prune [-n | -v]" message
Message-ID: <20171121175846.GB27041@aiede.mtv.corp.google.com>
References: <alpine.LFD.2.21.1711211156110.10397@DESKTOP-1GPMCEJ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1711211156110.10397@DESKTOP-1GPMCEJ>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Robert P. J. Day wrote:

> It seems clear that the man page SYNPOSIS and the usage message
> referring to:
>
>   git notes prune [-n | -v]
>
> is incorrect, as "-n" (dry run) and "-v" (verbose) are not
> alternatives, so fix both places to refer to:
>
>   git notes prune [-n] [-v | -q]
>
> to match the rest of the man page.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> ---

Hm.  What does "git notes prune -q" do?

The docs describe what --dry-run and --verbose do for "git notes prune"
but its description of --quiet seems to be specific to "git notes
merge".  Should the usage summary be

 git notes [--ref=<notes-ref>] prune [-n] [-v]

instead?  That would also be consistent with "git notes prune -h":

  $ git notes prune -h
  usage: git notes prune [<options>]

      -n, --dry-run         do not remove, show only
      -v, --verbose         report pruned notes

Thanks,
Jonathan
