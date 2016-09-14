Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B47207DF
	for <e@80x24.org>; Wed, 14 Sep 2016 10:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758398AbcINKzq (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 06:55:46 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34991 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755489AbcINKzp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 06:55:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id c131so1973214wmh.2
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 03:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8EF+XOKtSTq+a/WI0SFQPiB//qzqtLkmo2qTvVGMB0U=;
        b=KP63hWv70Z/urmKsvQREjEMXfaSlbgCjCF+ZZbFXf0EzLpHdWSUA4bBn0ssetdxuEk
         JO24STdEsa5JvNDthof63VSPb0LLzMP+73U6ZeCEsqBF24mBDcdi6ubOdGAxlrrh0S5d
         Ia7CLObmthP4szvMGgNUtCP1LRZvuXQ4IHsO3Zum9PiCaNBnBNTQ2h7NR5G7VdwBnUFV
         JRDtK+/+1NlxIKh3mWO8o0EZnXhK9Xlb0zCbhB0p1oahwUASmPbMqiQKhumz1uL6+Q1r
         3dsPkconvy/dtwIGlWfPNh4rCbRz+Jzo7NETJYtA8fynPenZ3JqPY6Wn23YwrjswO47I
         x05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8EF+XOKtSTq+a/WI0SFQPiB//qzqtLkmo2qTvVGMB0U=;
        b=BLVaGCIl0HOHRTqSYLLRMldmiAmDF5tK35xfO9vLlGpYJzIQMgGYfRubIMHW4kPWvk
         HP5uB1ROwb6xdZuGmwQtrYKbS042j4zpbIDXJqolxtL7JHno4M7Tl9A0X04PQZtcMhJc
         3iPsnGsfCa2/GEUqb8X15+f6ENokyGm5k6fQeCLaYNWR2W8s0r7X05ZFodbMWg7cuxf/
         Tf8YQeAwGAbcdATSSu9bla6kA62nnp2zMTMQYl2jXHOiKyV2VFB+yvM7TEcBj8GaPpZO
         gD956pqqV56Nl/b9Mc25cqq/YkCLH4w6a5fz5sLBT9EPEdiaqUBbVBd0XYF14SGk6X6Q
         TC7w==
X-Gm-Message-State: AE9vXwMga8S2OFnLXR8Nw82z7uwtLLkkB7Z6yTQYFtl88ZRFzep10RBl0NeGl1zPLQxFJg==
X-Received: by 10.28.26.147 with SMTP id a141mr10151297wma.8.1473850543252;
        Wed, 14 Sep 2016 03:55:43 -0700 (PDT)
Received: from [10.156.63.164] (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id u129sm277076wmb.11.2016.09.14.03.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Sep 2016 03:55:42 -0700 (PDT)
Message-ID: <1473850541.30531.18.camel@kaarsemaker.net>
Subject: Re: [PATCH 0/16] fix config-reading in non-repos
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>
Date:   Wed, 14 Sep 2016 12:55:41 +0200
In-Reply-To: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On ma, 2016-09-12 at 23:22 -0400, Jeff King wrote:

> The motivation for this series is to fix the regression in v2.9 where
> core.logallrefupdates is sometimes not set properly in a newly
> initialized repository, as described in this thread:
> 
>   http://public-inbox.org/git/c46d36ef-3c2e-374f-0f2e-ffe31104e023@gmx.de/T/#u
> 
> The root of the problem is that we are overly eager to read and use
> config from ".git/config", even when we have not established that it is
> part of a repository. This is especially bad for git-init, which would
> not want to read anything until we've created the new repo.
> 
> So the two interesting parts of the fix are:
> 
>   1. We stop blindly reading ".git/config" when we don't know there's an
>      actual git directory. This is in patch 14, and is actually enough
>      to fix the v2.9 regression.
> 
>   2. We are more thorough about dropping any cached config values when
>      we move into the new repository in git-init (patch 16).
> 
>      I didn't dig into when this was broken, but it was probably when we
>      switched git_config() to use cached values in the v2.2.0
>      time-frame.
> 
> Doing (1) required fixing up some builtins that depended on the blind
> .git/config thing, as the tests demonstrated. But I think this is a sign
> that we are moving in the right direction, because each one of those
> programs could easily be demonstrated to be broken in scenarios only
> slightly more exotic than the test scripts (e.g., see patch 3 for one of
> the simplest cases).
> 
> So I think notwithstanding their use as prep for patch 14, patches 1-13
> fix useful bugs.
> 
> I won't be surprised if there are other fallouts that were not caught by
> the test suite (i.e., programs that expect to read config, don't do
> RUN_SETUP, but aren't covered well by tests). I poked around the list of
> builtins in git.c that do not use RUN_SETUP, and they seem to correctly
> end up in setup_git_directory_gently() before reading config. But it's
> possible I missed a case.
> 
> So this is definitely a bit larger than I'd hope for a regression-fix to
> maint. But anything that doesn't address this issue at the config layer
> is going to end up as a bit of a hack, and I'd rather not pile up hacks
> if we can avoid it.

Agreed with all of the above, this is much better than just fixing the
symptom on the mailinglist thread that started this.

> I've cc'd Dennis, who helped investigate solutions in the thread
> mentioned above, and Duy, because historically he has been the one most
> willing and able to battle the dragon of our setup code. :)
> 
>   [01/16]: t1007: factor out repeated setup
>   [02/16]: hash-object: always try to set up the git repository
>   [03/16]: patch-id: use RUN_SETUP_GENTLY
>   [04/16]: diff: skip implicit no-index check when given --no-index
>   [05/16]: diff: handle --no-index prefixes consistently
>   [06/16]: diff: always try to set up the repository
>   [07/16]: pager: remove obsolete comment
>   [08/16]: pager: stop loading git_default_config()
>   [09/16]: pager: make pager_program a file-local static
>   [10/16]: pager: use callbacks instead of configset
>   [11/16]: pager: handle early config
>   [12/16]: t1302: use "git -C"
>   [13/16]: test-config: setup git directory
>   [14/16]: config: only read .git/config from configured repos
>   [15/16]: init: expand comments explaining config trickery
>   [16/16]: init: reset cached config when entering new repo

Couldn't find anything to comment on, and I've tested that this does
indeed fix the symptoms we saw.

Reviewed-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net

