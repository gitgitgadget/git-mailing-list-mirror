Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A9BA1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 21:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeJWGGn (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:06:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39173 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeJWGGm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:06:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id e67-v6so10692692plb.6
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UblCeQTMrm40bgObrfIzeBCUF++tc8PbOia+qrmbFO0=;
        b=AK+pR0356HUVasKzmv3tXw2GQl0Nn63MT2whpCHAPDw/4J6MKXi1dijkFNqgTcd7mU
         htAQmp313qZFi3mI1jXP+SGAoKGIE27mN1wW1fBP2afheMv5k0zjBHF0sprLeflls9tI
         YS4Idz3S59GiK1sGXNEIs3TjGhKgPNM1iydhZ59AUDgKwRRqJ7R65FNWDmIUIbuVPZcH
         +TLdTaSLHkaOq+Bf63+TQ6etpWxgU4EGaTCD/n1elqPgf6IsWde3IxmEdupXwsjCRy2Q
         m9HhviorEDigbdERH7B2BOk9/1N0Z3IJPBmREiM5wZJ2tA78FTyj4KZ80QfEHYrdy996
         cR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UblCeQTMrm40bgObrfIzeBCUF++tc8PbOia+qrmbFO0=;
        b=rQZrPYIlBNFAHcCptGd3pcz7JGl0Efb2ze88b/xXpeMO8ieOGtLn2bg6i42DakZJJH
         PRPo6KlRVY79xa6BgI2HbvJdPwM1ImqdWv+HE493VDu6wU39JaMkLLYCJ4afzXKMlwou
         +UjztNQ5PVmq2k0xDHQG08Vezpj4TtEtDVHceQaRE3Kh+Ptl0kZxFSsJn6Wlub+t5X0l
         jwIr4HYyup3ygY7DXVn5drZZjRySDzDTeMba9ZWwau+wx5TCpC9V2NeLNjdEMC1webh9
         6+RcEjuKYWGMnFo10E+Zscn3vbOnkFXnPxF/TXbnxvbiqCy5fmtAaD2H98pYbF0zySKa
         jPrA==
X-Gm-Message-State: ABuFfogDI06kwWxn4IXOVlbJfPzo+D5npkkx4gydb0U44+ia9e30RplR
        /8xQi7pyuI4UuDnxroFAhELBvGKTSGBZrA==
X-Google-Smtp-Source: ACcGV61mY7DbanYBSmxVRE0DZ9orr3nIZ91I4r2YchPPtToquc2QZobT2G31ijR4KXFc0rPY4ZdunQ==
X-Received: by 2002:a17:902:e185:: with SMTP id cd5-v6mr44653919plb.224.1540244782947;
        Mon, 22 Oct 2018 14:46:22 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id a79-v6sm46303402pfa.124.2018.10.22.14.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 14:46:21 -0700 (PDT)
Date:   Mon, 22 Oct 2018 14:46:17 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix format detection when archiving remotely
Message-ID: <20181022214617.GB233961@google.com>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <cover.1539990488.git.steadmon@google.com>
 <20181019234126.GA7326@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181019234126.GA7326@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.10.19 19:41, Jeff King wrote:
> On Fri, Oct 19, 2018 at 04:19:27PM -0700, steadmon@google.com wrote:
> 
> > Currently, git-archive does not properly determine the desired archive
> > format when both --output and --remote are provided, because
> > run_remote_archiver() does not initialize the archivers prior to calling
> > archive_format_from_filename(). This results in the remote archiver
> > always returning a TAR file, regardless of the requested format.
> > 
> > This patch initializes the TAR and ZIP archivers before calling
> > archive_format_from_filename(), which fixes format detection.
> 
> It seems like some of this content could be in the commit message of the
> actual patch.

Ack. I'll be sending v2 shortly, please let me know if I've missed
anything that should be included.

> > Steps to reproduce:
> > 
> > ∫ git version
> > git version 2.19.1.568.g152ad8e336-goog
> > ∫ cd ~/src/git
> > ∫ git archive --output ~/good.zip HEAD
> > ∫ file ~/good.zip
> > /home/steadmon/good.zip: Zip archive data, at least v1.0 to extract
> > ∫ git archive --output ~/bad.zip --remote=. HEAD
> > ∫ file ~/bad.zip
> > /home/steadmon/bad.zip: POSIX tar archive
> 
> And this could be in a test script in the actual patch. :)

Done.
