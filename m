Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 202AA1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 14:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbdFMOnU (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 10:43:20 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34467 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbdFMOnU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 10:43:20 -0400
Received: by mail-pf0-f181.google.com with SMTP id s66so924397pfs.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HY9tLkd+ryWzLpnEv9eBIXsL+IKWgeRml1IAAu4eWM4=;
        b=NAJN4yYGAgxvYeDXE0wJiKrcc6Q//o2gUmBYRJebO9p9ulfRztCCXgTgS0es0AbTyA
         F249k/WByGYrzPASMVIXyGCDitnV73nDBHltsf6eo5556oUlB2Shrs85SgTIvswkzX8U
         1F8gwNeRTJTSd9TW35wFYdRwdxvZpCfBY7/EZGbKg6FlhCgodVQ/cCQnIkkEBSNYaWUl
         SPtyTH2x/MIBkJOoFDrDkUDKG7yPYE91b2BQ4T+QsJg7ykWtpTSbti7aVDVCcSBB6CTf
         1D8oaIHFABQGbt52lWLqCDlvmv2kAml8r2a7R7cHC1gcywEflLR8pUrAKIz2xhbYTsQc
         neXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HY9tLkd+ryWzLpnEv9eBIXsL+IKWgeRml1IAAu4eWM4=;
        b=Mau6K12zeC0103tnPKj7hsbIFU1JLWqDnjFWIDEsyjoU8hBLk+ybK7Tixpax4PGech
         m3+mTqQL0aK+YTwo1Qm0Sr9ydVZVPsdsW6VYrGS1lOVmhJnSWn3ef6Ydgj7ImRoS0ELG
         83pR8bIwz6my/Dv9T+G6tYGhttDHMv5Y9rz0Lef6s8bK0vzBJelU915wfJpPa8LC3LkD
         3djB25Jrb0hDQNQNIUdF9exNtWZoU5FOuB+zJu5tlefsDk9cBKinP6v/nprRwB9zzmlv
         E/uK45dip1cGaG8MubtkVwg57uJWaw+Q5xBR1EU/S4OU4hk75fnP3E1/fLuNEIbTAwWy
         1XnA==
X-Gm-Message-State: AKS2vOzscOW1lM8l8sPPpZcpTmzQcQD+YF0zKi4YZiS+VAzT7dI0Az+F
        GdfjErDdLx8xh/ko
X-Received: by 10.84.131.1 with SMTP id 1mr214337pld.232.1497364999260;
        Tue, 13 Jun 2017 07:43:19 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:dd0d:448e:29f9:5e86])
        by smtp.gmail.com with ESMTPSA id a187sm22114800pgc.37.2017.06.13.07.43.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 07:43:18 -0700 (PDT)
Date:   Tue, 13 Jun 2017 07:43:16 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 4/4] config: don't implicitly use gitdir
Message-ID: <20170613144316.GK154599@google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170612213406.83247-5-bmwill@google.com>
 <20170613010518.GB133952@aiede.mtv.corp.google.com>
 <20170613012337.GH154599@google.com>
 <20170613013817.GE133952@aiede.mtv.corp.google.com>
 <20170613025945.v54vrza2n23tk5pw@sigill.intra.peff.net>
 <20170613061627.GJ154599@google.com>
 <20170613070813.v3vthqlqsga7djgz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613070813.v3vthqlqsga7djgz@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/13, Jeff King wrote:
> On Mon, Jun 12, 2017 at 11:16:27PM -0700, Brandon Williams wrote:
> 
> > > > *puzzled* Why wasn't this needed before, then?  The rest of the patch
> > > > should result in no functional change, but this part seems different.
> > > 
> > > Now I'm puzzled, too. The original that got filled in lazily by the
> > > config functions was always get_git_dir(). I can buy the argument that
> > > this was a bug (I'm not familiar enough with worktree to say one way or
> > > the other), but if it's a fix it should definitely go into another
> > > patch.
> > 
> > Well actually... in do_git_config_sequence 'git_path("config")' is
> > called which will convert gitdir to commondir under the hood.  you can't
> > use vanilla gitdir because the config isn't stored in a worktree's
> > gitdir but rather in the commondir as the config is shared by all
> > worktrees.
> 
> Sorry, I missed the fact that there were two sites changed on the first
> read.

Well I missed that fact when I first wrote these patches too :)

> 
> > So maybe we actually need to add a field to the 'config_options' struct
> > of 'commondir' such that the commondir can be used to load the actual
> > config file and 'gitdir' can be used to handle the 'IncludeIf' stuff.
> 
> On reflection, I suspect that probably is the case. If you have a
> workdir in ~/foo, you probably want to match IncludeIf against that
> instead of wherever the common dir happens to be.

K I'll look into adding that then.  I will say keeping track of
'commondir' vs 'gitdir' does get slightly confusing.

-- 
Brandon Williams
