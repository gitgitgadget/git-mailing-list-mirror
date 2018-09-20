Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D58811F453
	for <e@80x24.org>; Thu, 20 Sep 2018 18:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388085AbeIUAlm (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 20:41:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45181 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIUAlm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 20:41:42 -0400
Received: by mail-io1-f65.google.com with SMTP id e12-v6so8978295iok.12
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 11:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o9icwjDqRp+EMA1tMzpDr+xFPU469Yaa3Jco4Wi0u4Q=;
        b=FsYywXdwpbZE3/7IdE3OfyIrqw3sWqEeNITpFpz8+7gG92/3SUqAn7J+reTFa1Y0qH
         fmGv9jNB5uEQBsYKLDuCAclG+ofjjiu8HmsFr34XxGXBdnQCFX1zksfgwDqvNXerJwQs
         gB2YUzCeKo1P962U5zsY41g5ZiwbzTx9r71loMy/snc9vgaRQuutkVi1BSkyea3WLLvq
         ORCkXwb8XSvlFyWic4fZGtvJe98aGtMlJOn4FMq5N97bDyLbngw8ineQJ1/VxmMamgmi
         0+96gVp0D8dcEd7u6l/LHNabTStTqbW3vNIejiFkZo5jqmfDkhRbf6xASUWSO7mBf47u
         deIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o9icwjDqRp+EMA1tMzpDr+xFPU469Yaa3Jco4Wi0u4Q=;
        b=pP5OeAdeEPD/IUX5soP6itZ2MPrgZElhkF2f/DRIpnEaRlAn+A3gA38UAQiyVesdGF
         gFO5RkMVZhIDLh+c698Bfunm0h/k9xbF2+5tLprymuLJjtcE9l7VK/5XQw6Cmz+WTfqU
         8YS2HixN4jro6vtNnw6f7R7z2EyBALFSLxwX5ff5JzOW5rShLhL6Ge2dvBtGcfBmKZy/
         i+xKNGjAfQeNkSgVEaZ+3Qcw2hmhl7xbteQcyjdjvoGzM+bchg1IFYo32yzZBz+YR5Kk
         EKvctMQZ/mwO7MFqoijgnJIGvnkMCXQV0joR3IFVzNoEomoCUazgRCCRZ7Wcr6qU+KyS
         TA1A==
X-Gm-Message-State: APzg51CLXr1fWXehNpMN7xUWZQ4cBZEGR6ibCL+lYkHEF9AnnLEIHNFT
        GhqA7AZFhoemV/vILWaBFLlrAQ==
X-Google-Smtp-Source: ANB0Vda5pY8ZJyMqOXeOJupY/U5vQ46RW3I3la+s9KfgnUhHH+Vf75a3eGP6hSwp7ASi1HTyyX2qQQ==
X-Received: by 2002:a24:f846:: with SMTP id a67-v6mr771693ith.13.1537469807969;
        Thu, 20 Sep 2018 11:56:47 -0700 (PDT)
Received: from localhost ([173.225.52.219])
        by smtp.gmail.com with ESMTPSA id z2-v6sm7780657iom.25.2018.09.20.11.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 11:56:46 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Thu, 20 Sep 2018 14:56:44 -0400
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Filter alternate references
Message-ID: <20180920185644.GA72694@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <CAGZ79kYv-n_x_Z3K=zsiTAQ9RCFMVE=6ZYCWRQMgioGRPnhVOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYv-n_x_Z3K=zsiTAQ9RCFMVE=6ZYCWRQMgioGRPnhVOQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, Sep 20, 2018 at 11:35:23AM -0700, Stefan Beller wrote:
> > To make the reference advertisement manageable even with a large number
> > of references, let's allow the fork to select which ones it thinks might
> > be "interesting", and only advertise those. This makes the advertisement
> > much smaller, and lets us take advantage of the ".have" references, even
> > when the upstream contains more references than we're advertising.
> >
> > This series implements the above functionality by means of
> > "core.alternateRefsCommand", and "core.alternateRefsPrefixes", either a
> > command to run in place of "git for-each-ref", or arguments to be
> > appended to "git for-each-ref".
> >
> > The order of precedence when listing references from an alternate is as
> > follows:
> >
> >   1. If the fork configures "core.alternateRefsCommand", run that.
> >
> >   2. If the fork configures "core.alternateRefsPrefixes", run 'git
> >      for-each-ref', limiting results to references that have any of the
> >      given values as a prefix.
> >
> >   3. Otherwise, run 'git for-each-ref' in the alternate.
> >
> > In a previous version of this series, I taught the configuration
> > property to the alternate, as in "these are the references that _I_
> > think _you_ will find interesting," rather than the other way around. I
> > ultimately decided on what is attached here so that the fork does not
> > have to trust the upstream to run arbitrary shell commands.
>
> Would it make sense to estimate the value of each .have before
> advertising them and then advertise only the <n> most valuable
> .haves ?
> (e.g. if a .have is only one small commit ahead of origin/master,
> it may not bring a lot of value as the potential savings are small,
> but if that .have contains history between master..TIP that has lots
> of big blobs or objects in general, this may be valuable to know)

I think that this sort of filtering should be theoretically possible
by configuring "core.alternateRefsCommand", perhaps to execute a script
like:

  cd "$1" &&
  git for-each-ref --format="%(objectname) %(refname)" |
  while read objectname refname; do
    total_size="$(git rev-list --objects master...$objectname \
      | awk '{ print $1 }' \
      | git cat-file --batch-check='%(objectsize)' \
      | awk '{ sum+=$1 } END { print $sum }')"

    if [ "$total_size" -gt "$minimum_size" ]; then
      echo "$objectname $refname"
    fi
  done

But that's quite inefficient to compute, since you're walking the same
parts of the graph over and over again.

Perhaps we could teach Git to do something better? I suppose that just
"core.alternateRefPrefixes" could do this by default (or with another
knob) to further optimize the simpler case. But I think that we'd be
equally OK without it, since push over V2 obviates the need for this
sort of optimization (as you noted in the unquoted part of this
response).

My inclination is to avoid teaching this to Git, and let callers
script it into their "core.alternateRefsCommand" if they really desire
it.

Does that seem OK?


Thanks,
Taylor
