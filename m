Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93711FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 18:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbdFHSyR (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 14:54:17 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36664 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdFHSyP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 14:54:15 -0400
Received: by mail-pf0-f172.google.com with SMTP id x63so20092945pff.3
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AHgzV/o2tYyQrfURIGdCQf0dSy/iYE9VhsVoCEKGjTU=;
        b=k17zh6xH5n7eZKROsyRQueXDka+y70YGzxcDsF2AOZZbcJInGL9srJoqlpy5t0vUWT
         pg6HI5x9o7MYOGV7ksIVkjOLqH5dbSDLI020GW/Qw7rkGuvQTzH+s68b7/0jKt48C34L
         SQz79XeF5DHh42paxnhPJ07y6U39HdPah8LSYDKr/9Zret+yr3TnhXYwsKiZJpzMNwpT
         XV6wNLyUUdZOuOu9aQe/kwapSsiKMY1D5aiExrpm9rWBapJLFImQhFjIMtKpicVVuVC8
         rmW8GL8EwjVdd0X9ECIIBT0+iVvDqv0tNtGZeMG0szFuSOMnk6rIYJyba1/smi4QSmGz
         OSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AHgzV/o2tYyQrfURIGdCQf0dSy/iYE9VhsVoCEKGjTU=;
        b=HSpoJWlIhT66/gwRMiy0QoyBFa8P7Omx9gEa2alCIcgZ2CuGqH1E1yVQ5r6O9rvcRa
         f9jdt3RCKdQ2l00GH8NeKVh/k3ZP9O8A/uDZYlGsZOzxcdUO3J+mhRh2VLxZFP49LPbO
         ZR0es32b2CkwG4TSGugXamTuHQ6KUP2YLOByM+keyLUsHG9MaTpOOzzVd0b5cGGOp1HV
         zEDi54A50RyIE2+M+wbLM6avFZgCqBHwcvsZsKJWZzLqoz2etJjdn+uotKupq+AR9dEb
         iT5CUR0Z/0U67+XvjAFK05M1r/FK0WV3zlAZv8VQeEHY7YNILEKuPyab64r9QLEjQqiB
         N+3A==
X-Gm-Message-State: AODbwcCHazBu09kP0y6XTbgHRkv7Y5mAJah3yqlc1qGWNjRkzMVRFdLY
        KUVeo3Qf66vK/+DQ
X-Received: by 10.84.197.131 with SMTP id n3mr36162534pld.170.1496948054830;
        Thu, 08 Jun 2017 11:54:14 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:4d0d:6f3d:27f:3a24])
        by smtp.gmail.com with ESMTPSA id t198sm10065241pgc.33.2017.06.08.11.54.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 11:54:13 -0700 (PDT)
Date:   Thu, 8 Jun 2017 11:54:12 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/9] read_early_config(): optionally return the
 worktree's top-level directory
Message-ID: <20170608185412.GA41637@google.com>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
 <6d339785a007c2805bdc17c4e24da713a5996703.1496851544.git.johannes.schindelin@gmx.de>
 <20170607181333.GD110638@google.com>
 <alpine.DEB.2.21.1.1706081204330.171564@virtualbox>
 <20170608144628.GH110638@google.com>
 <alpine.DEB.2.21.1.1706081729450.171564@virtualbox>
 <20170608163230.GK110638@google.com>
 <alpine.DEB.2.21.1.1706082052040.171564@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706082052040.171564@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/08, Johannes Schindelin wrote:
> Hi Brandon,
> 
> On Thu, 8 Jun 2017, Brandon Williams wrote:
> 
> > On 06/08, Johannes Schindelin wrote:
> > > 
> > > On Thu, 8 Jun 2017, Brandon Williams wrote:
> > > 
> > > > On 06/08, Johannes Schindelin wrote:
> > > > 
> > > > > Back to the worktree_dir variable.
> > > > > 
> > > > > I think part of the confusion here is that it may be left alone even
> > > > > when there is a worktree. For example, if we are already in the
> > > > > top-level directory. Or if the worktree somehow points to a different
> > > > > directory than the one containing the .git/ directory.
> > > > > 
> > > > > Therefore, I renamed this variable to `cdup_dir` to reflect the fact
> > > > > that it is only touched if Git determines that it is in a subdirectory
> > > > > of the directory containing the .git/ directory.
> > > > 
> > > > Ok, maybe I'm just not following but just from reading the variable name
> > > > I can't really understand what 'cdup_dir' means.
> > > 
> > > My idea would be that this is in line with the
> > > 
> > > 	git rev-parse --show-cdup
> > > 
> > > incantation.
> > 
> > Ah ok, 'cdup' just doesn't really mean much to me.  Is it supposed to
> > stand for something?
> 
> Yes, it stands for "change directory up", as in `cd ../../`. ;-)

Thanks for clearing that up! I was reading it as 'c-dup' and not 'cd-up' XD

-- 
Brandon Williams
