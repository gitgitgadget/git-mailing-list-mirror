Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0C311FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 03:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbdJFDNH (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 23:13:07 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:54628 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751450AbdJFDNH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 23:13:07 -0400
Received: by mail-pg0-f53.google.com with SMTP id c137so9271146pga.11
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 20:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GDcUWqTW6rmONva0l75kwX4g4WfcXQ609Ln7qVfcoh8=;
        b=MpoYdWomCH3Wfp7bnOQ2WUMSN6Jj6aWGyh1uIjpOAj9z+ggeZyACJC5DRQQF/Zkmoo
         7KEROEcdOkuoo+V9LOPds3vv/WVmIek8teqaY79xDc6kICOiOGYW/BnPct4gBe3o8Dgz
         eoPZ6INuzi7jLxoj7bBKAfC2q4eyrgJuJiHQ/TuwCycP20Z4J8f40sWN4LGH5vTGfmvW
         ryBmBKOXPxNvb14IIL4z9wpkPVPQzvrD/ePLZa28QjJWpIr9mnhb6bZrh3fekgO655a5
         eu27rRNjmZ6Mhc5YoqdxPZbdu9gpewyfbll5e5WZH9sbmcL8/0matS/N3mB6I+Txecfi
         vpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GDcUWqTW6rmONva0l75kwX4g4WfcXQ609Ln7qVfcoh8=;
        b=H27ZKeoGJ2lMVX6h0aTRSIlr82Xh5p2FeMTXHxZ8oSWh/S6LpTc8f8yiGdVyZiL+Gb
         a+Rgjf3o4dPgqFI/oQ46Oa0z81wGKDPOKx7YbqQj5l9Z3caE7qrOICCMJH9X8k7gXUMv
         Y02PCrKCRd5WZnrO4jzTQLN3INrHtCwneUoMMH76nG1bw/VoysfKc2kVP6m1k+WMPJUF
         lwypYismnktyPe19SMnzhekQQ0VtT+eEbRh7K9gJ2WossTjiQMOZ0UdgdQCqWveW/+Kg
         WhHjzt+qE5wHOt6+3GmwtyjWIM/vhhf3N7lZZ614D4zcPcYh7uv7z30TEVqW+csYUsUN
         rROw==
X-Gm-Message-State: AMCzsaXdL5v2ZxWEeynHj6uQnfoDpRWT8f8/+FqUy4tWRWNsC50Zcy47
        LLYED/JnWXqh42aNFMYCqKa1prFB
X-Google-Smtp-Source: AOwi7QDC4hHNCqeJn0yEtdiGJARjhvu52LQexPBwTwzjQd+HjJ3hYcMMy/gRt25rxOOsdxEG8REMvA==
X-Received: by 10.99.42.72 with SMTP id q69mr661815pgq.379.1507259586275;
        Thu, 05 Oct 2017 20:13:06 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:78c3:3d0d:a9b5:4320])
        by smtp.gmail.com with ESMTPSA id r81sm552456pfj.106.2017.10.05.20.13.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 20:13:05 -0700 (PDT)
Date:   Thu, 5 Oct 2017 20:13:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Reporting index properties
Message-ID: <20171006031303.GB134987@aiede.mtv.corp.google.com>
References: <alpine.DEB.2.10.1710051625430.812@alexmv-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1710051625430.812@alexmv-linux>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Vandiver wrote:

> As part of gathering some automated performance statistics of git, it
> would be useful to be able to extract some vital properties of the
> index.  While `git update-index` has ways to _set_ the index version,
> and enable/disable various extensions, AFAICT there is no method by
> which one can ask for reporting about the current state of them --
> short of re-implementing all of the index-parsing logic external to
> Git, which is not terribly appealing.

Aside: git-update-index(1) says

	Version 4 is relatively young (first released in 1.8.0 in
	October 2012).

My first reaction is to wonder if it is time to introduce a config
option to use index format version 4 by default, since after 5 years
it is not relatively young any more.

My second reaction is to notice that the index.version configuration
already exists.  Probably git-update-index(1) ought to point to it.

JGit still doesn't support index format 4, so 4 is still not a good
default for `index.version` for a user that hasn't explicitly
configured it, but the moment JGit gains that support I think it will
be. :)

> I hesitate to propose adding a flag to `git update-index` which reads
> but does no updating, as that seems to make a misnomer of the
> command.  But this also doesn't seem worthy of a new top-level command.

The existing scripting command that inspects the index is
"git ls-files".

It doesn't go into this kind of low-level detail about the index
format, though.  In the same spirit, I don't think we have an existing
command in this spirit for analyzing packfiles, either.

So I agree with Junio that this would be a good debugging aid to put
in t/helper/ for now, and then once we've had experience with it we'd
end up in a better position to come up with a stable, public-facing
interface, if one is needed.

Thanks and hope that helps,
Jonathan
