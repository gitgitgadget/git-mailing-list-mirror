Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A229F1F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 16:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034297AbcIYQct (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 12:32:49 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33336 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034150AbcIYQcs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 12:32:48 -0400
Received: by mail-pf0-f176.google.com with SMTP id 21so57298343pfy.0
        for <git@vger.kernel.org>; Sun, 25 Sep 2016 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DQyLM0QWhcszbMtBaBk2JVFk09/f119uiFaKRrP/kk4=;
        b=GbQk7eAUlkF2X58b8U6E2hrYhnKg3AYwnzOAIUg2pnIYv9ChsChopZWT7vz1heECRm
         R731Bm8PiWMLyRiGEyoOXOErbLoeN86ZL41ltpDmQzOeH0WhKLN3fztNFNzf8rJfkRGp
         BYsZwXXF2CmgS2XqHv5v083QVdEIm/IU/muwE3cpIYTwZ1HjnEWqrkaffOuFjiuKHgrN
         FMfqb8h9WBCLLXnAYvwvBAQX/dr7f6CF8Uu4jR48SCPZprKokxBTaohOYARB07GrbtRn
         sms+/BSyhdQHOBEb+zX+jW+ita4KX19elfCVP9Yr59tCIIjuPWXNbntJckO+quK4K7mr
         NUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DQyLM0QWhcszbMtBaBk2JVFk09/f119uiFaKRrP/kk4=;
        b=GWI+oMlLGhpUP/kVGbxcaqPclG1B9oxrBT78GAC0acETBfvtR8Dzq+ezlhFjdUyUOM
         /vpifBVwqfLrWwIepK4fMPkRmzlyC/KzBAVCvGSP28EahPJvW5hDvl+e7G7+JfdOntBX
         kRRXAYfrpki9eZYUGgV350NKFBm3i/pX0T0658GRCb5FsCpzMn5hdBT1C6cIo2WMITjK
         cUhIs+8xjG8GBYXcZ6QkHnaTWB4sJwleDNxPnQkAJxs/hdxkriu+84ugva+3J6a5yqhS
         rq/jWBnLpAwov9R71BunKGKF+AG//AK8EUfvcPuI5umCCc4SENRCnIS9mXMk+J3viUTX
         quuw==
X-Gm-Message-State: AE9vXwMHD4zzbA7FS6JH8qhlwGjnOWi12ew3nYsUajTuWIgGRv9cZk4bjbj2QwS3B/Y+zWwp
X-Received: by 10.98.79.27 with SMTP id d27mr31237482pfb.127.1474821167408;
        Sun, 25 Sep 2016 09:32:47 -0700 (PDT)
Received: from google.com ([2601:647:5401:1458:653c:74a9:fbd4:6400])
        by smtp.gmail.com with ESMTPSA id d2sm18762809pfe.94.2016.09.25.09.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Sep 2016 09:32:46 -0700 (PDT)
Date:   Sun, 25 Sep 2016 09:32:44 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] recursive support for ls-files
Message-ID: <20160925163244.GB66080@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
 <20160925071744.2qcz7cntc7xxpjqv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160925071744.2qcz7cntc7xxpjqv@sigill.intra.peff.net>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/25, Jeff King wrote:
> On Fri, Sep 23, 2016 at 05:13:31PM -0700, Brandon Williams wrote:
> 
> > After looking at the feedback I rerolled a few things, in particular the
> > --submodule_prefix option that existed to give a submodule context about where
> > it had been invoked from.  People didn't seem to like the idea of exposing this
> > to the users (yet anyways) so I removed it as an option and instead have it
> > being passed to a child process via an environment variable
> > GIT_INTERNAL_SUBMODULE_PREFIX.  This way we don't have to support anything to
> > external users at the moment.
> 
> I think we can still have it as a command-line argument and declare it
> internal. It's not like environment variables cannot also be set by our
> callers. :)
> 
> I don't mind it as an environment variable, though. In some ways it
> makes things easier. I just think "internal versus external" and the
> exact implementation are orthogonal.
> 

We may still want it to be an option at some point in the future.  This
way we can revisit making it an option once we know more about the other
uses it could have (aside from just being for submodules as someone
suggested).

> > Also fixed a bug (and added a test) for the -z options as pointed out by Jeff
> > King.
> 
> Hmm. It is broken after patch 2, and then fixed in patch 3. Usually we'd
> try not to have a broken state in the history. It's less important in
> this case, because the breakage is not a regression
> (--recurse-submodules is a new feature, so you could consider it "not
> working" until the 3rd patch). But I think it's still a good rule to
> follow, because it makes the commits easier to review, look at later,
> etc.
> 
> For that matter, I do not understand why options like "-s" get enabled
> in patch 3. I do not mind them starting as disabled in patch 2, but it
> seems like "pass along some known-safe options" should be its own patch
> somewhere between patches 2 and 3.

I'll keep that in mind for future patches.  I figured that since it was
fixed in the end that would be fine but if things shouldn't be broken at
any state in the patch series I'll make sure to not do that in the
future.

> There are some other options that are ignored (neither disabled nor
> passed along to children). Most of them are related to exclusions, which
> I _think_ are safe to ignore (they do not do anything interesting unless
> you specify "-o", which is explicitly disabled). I'm not sure about
> --with-tree, though (or what it would even mean in the context of
> recursing).

These other features that are disabled now could be enabled in a future
patch.  You're right though I'd have to think about the --with-tree
option a bit more and what it would mean with submodules.

-Brandon
