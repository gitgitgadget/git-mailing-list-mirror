Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD4391F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 18:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeJFBuz (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 21:50:55 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:45133 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbeJFBuy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 21:50:54 -0400
Received: by mail-wr1-f41.google.com with SMTP id q5-v6so14524865wrw.12
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YQNNCX+scFkwAXePIfeAMwmHWZ6Y/GQSSGU7PODXQ1U=;
        b=Y1dMu/MW4zRY9XEUmIztBRvOtWaomInzlgKsk3bnSXBpOm1lGE3ac7dOa3X/vuGil9
         7/VOSb9nIVmKsjByJ+lvHILJ0W+dQWegjcKEirewQxlrWHMSeELWc5KAxR7didpkUhgv
         c37XxRkVP6ThXYsjN6KdkJ09X1r/yyFa5Q0rz6SLEPhTdgaNiQvWpjRPv7BUeNP1E/3Z
         D5xIK+9GWsP6+nlfhhk+sRTzJG5glx5ELgulF4Y4HPHqQGTesHiriqpEgGRDnWgMim/N
         witjGUYAKZ/owbJgYN1u7sc9FJzd6RcP47xXTReooYS+7uRSVTml0rx5ecIynlkVxffW
         J8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YQNNCX+scFkwAXePIfeAMwmHWZ6Y/GQSSGU7PODXQ1U=;
        b=kqQA40bvcWAcuypWsbaMEZG3f8e/mQQoOsofLERAbZ4KaUtuDHO7m6fybW2uXmtsJm
         EbzYrwcFyB9xfCIDA9SXQharJLGEvP7O9+Fa0U+5434iGOc5PG9PzxhYNS6qYuPyV6jM
         DqgJR93H5zwbzWpClAUuZ9zHvYvV6osyEiedXQVT57Xj/6Uw+UXVqj4Cd6yDPlWtvFzE
         7VhSkDPbFOLydoglmpXw4tdBrL07YkwfgQjL8zE7Hekj0W2BIwMJFpB8u4OJTxKA/sEr
         9ah7sU8ON6KoNwByLGV9PfL9Qki9kXIH42/t12r1h3kWFncmrSf87ySi/51oZAzZwnt6
         HFPA==
X-Gm-Message-State: ABuFfoj80EHtHaxowaQ62sbpuSdbh93RzxV9Ckux5U4IKk/XVAictYfx
        c+LgXwUK8/65RCB+eBw2EQk=
X-Google-Smtp-Source: ACcGV63mn9RQbGYMReTMmWrxb3xdgJ/h2w8cMAw2gfjWWPTF22lFikfDDDQVD/sR34r0LIvr4uo9IQ==
X-Received: by 2002:adf:ab13:: with SMTP id q19-v6mr8875049wrc.62.1538765453442;
        Fri, 05 Oct 2018 11:50:53 -0700 (PDT)
Received: from localhost (x4d0c6f69.dyn.telefonica.de. [77.12.111.105])
        by smtp.gmail.com with ESMTPSA id k93-v6sm11800802wrc.89.2018.10.05.11.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 11:50:52 -0700 (PDT)
Date:   Fri, 5 Oct 2018 20:50:50 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3] coccicheck: process every source file at once
Message-ID: <20181005185050.GW23446@localhost>
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
 <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
 <20181005124048.GT23446@localhost>
 <20181005162517.GB11254@sigill.intra.peff.net>
 <02874ECE860811409154E81DA85FBB5884CCBED2@ORSMSX115.amr.corp.intel.com>
 <20181005165901.GE11254@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181005165901.GE11254@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 12:59:01PM -0400, Jeff King wrote:
> On Fri, Oct 05, 2018 at 04:53:35PM +0000, Keller, Jacob E wrote:
> 
> > > Are we OK with saying 1.3-1.8GB is necessary to run coccicheck? That
> > > doesn't feel like an exorbitant request for a developer-only tool these
> > > days, but I have noticed some people on the list tend to have lousier
> > > machines than I do. ;)
> > > 
> > > -Peff
> > 
> > It's probably not worth trying to make this more complicated and scale
> > up how many files we do at once based on the amount of available
> > memory on the system...
> 
> Yeah, that sounds too complicated. At most I'd give a Makefile knob to
> say "spatch in batches of $(N)". But I'd prefer to avoid even that
> complexity if we can.

But perhaps one more if-else, e.g.:

  if test -n "$(COCCICHECK_ALL_AT_ONCE)"; then \
      <all at once from Jacob>
  else
      <old for loop>
  fi

would be an acceptable compromise?  Dunno.

