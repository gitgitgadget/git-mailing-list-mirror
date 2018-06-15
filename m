Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 575EA1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 04:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755526AbeFOEUi (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 00:20:38 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35544 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbeFOEUh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 00:20:37 -0400
Received: by mail-pg0-f68.google.com with SMTP id 15-v6so3869564pge.2
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 21:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K57ANBsbNWJMEp7oUsSGgN3RXiV3TkxJDlfyEJfGu1E=;
        b=PlqlDBNaA1Desj+EsXkNHawELkFT8YkmqI3dH3eXx81KsEi5gdKOvGTm/J7jzTEQy6
         nhJsAhsQnemyYHSTH9jJhVPHr4YIn833X745HMHBH509QviAWVwGD16YK4im3saKLIdi
         LpDLQcjzfAFSrIAGlw8gr4ZBwDQMy6PfwIX5ya94slEyzSTg4CfkI4lopLUxyLJvdgtv
         PYpTfizT97/Y+kbFKoKUAziZBv/YAPbPYAO9cQKoJXkvqA2xQi6f9x/ExpOppeKHd0q/
         uASspjptF5iznglSTAovRQeCiJx/bZcfhSLc6p+OPhZspnZhAA8eR5Pp3cELYnni6iKM
         Hoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K57ANBsbNWJMEp7oUsSGgN3RXiV3TkxJDlfyEJfGu1E=;
        b=phQL56RZiKFC9KDhM3JujZBNjNEgDFaYiG/TLPK6OwqWQ4H95WQTD9w8imoleu1Ff1
         YQxOmgZR9/tp4auf4piZnEgTG1sepr/nJyA511FGQsjRLNXsa/E0FD1vQMWoQjXLDrhM
         SKHAo9Skyj0NXZHDsYGNVNNm6WGgjQAcAhs4Sh1mv3psCj076NVuIQv0fOTJL5q7akPY
         tKay5Br1LhbWi+jsysMjsZs/o3RkC1L8PnRXTTsD4ir2z7OqgCbuAOVEnKGP1yZpzK8k
         vtfgLOAhAk2Wf+LahyQXV5w7np4MLfl0KuTMKOvtbBEEg8f0XvqOv95Da/Ij9uH5oUd8
         u9hg==
X-Gm-Message-State: APt69E3hykdVgkvbf5Dbbwkhk01GWngS4kNqowP9pwBXFLdOqzZoQEpi
        cpq4L9RVjQTAFhg51rHInrc=
X-Google-Smtp-Source: ADUXVKIQz7Z86x6GOj0TN9PNM1R7JEWSg+Bg2oXmTnvEvpVYi5ragdr0P72m9IRfUH7KjQfNUYgPIg==
X-Received: by 2002:a63:83c3:: with SMTP id h186-v6mr62879pge.298.1529036436311;
        Thu, 14 Jun 2018 21:20:36 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t67-v6sm15058518pfg.51.2018.06.14.21.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 21:20:35 -0700 (PDT)
Date:   Thu, 14 Jun 2018 21:20:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bryan Turner <bturner@atlassian.com>,
        Brandon Williams <bmwill@google.com>,
        Ben Humphreys <behumphreys@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
Message-ID: <20180615042033.GB255581@aiede.svl.corp.google.com>
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
 <CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com>
 <20180103053516.GB87855@aiede.mtv.corp.google.com>
 <20180608045028.GA17528@sigill.intra.peff.net>
 <xmqqzi009deu.fsf@gitster-ct.c.googlers.com>
 <20180614183018.GA1911@sigill.intra.peff.net>
 <20180614185522.GA255581@aiede.svl.corp.google.com>
 <20180614193943.GA2226@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614193943.GA2226@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Thu, Jun 14, 2018 at 11:55:22AM -0700, Jonathan Nieder wrote:

>> Do you mean that it doesn't pass "-G" through, or that when using old
>> versions of openssh that doesn't support "-G" the probing fails?
>
> It just doesn't pass "-G" through.

Thanks.

>> If the former, then detecting the wrapper as something other than
>> "ssh" is intended behavior (though we might want to change what that
>> something is, as discussed in the previous thread).  If the latter,
>> then this is https://crbug.com/git/7 which I consider to be a bug.
>
> I certainly see the argument that "well, if it doesn't do '-G' then it's
> not _really_ openssh". My counter to that is that we don't actually
> _care_ about -G (and never did before recently). It's just a proxy for
> "do we understand -p", which my script does understand. My wrapper might
> eventually break if we depend on new options (like "-o SendEnv")

Exactly: what we want to detect is not whether the script happens to
support the OpenSSH options we use today, but whether it is a thin
wrapper around OpenSSH that supports *all* options.

This wrapper definitely does not qualify.  As we start to use more
OpenSSH options, we are likely to break it.  As you say,

> the worst case there is generally no different before or after your
> patch: the command barfs.

but as a caller, Git has no way to know that: it is easily possible
that the wrapper would ignore the new option we want to pass, for
example.

In other words, I think your response is based on the interface that
we previously, foolishly advertised: "We will pass exactly these
options to your wrapper".  Except those options changed over time,
multiple times.  It was a terrible interface.

What we've switched to is a versioned interface.  By setting
GIT_SSH_VARIANT=simple, you are asking Git to promise to pass exactly
<x> options.  If Git has a new option it wants to pass (like the "-o
SendEnv" thing) but can live without it, then it can avoid breaking
your wrapper and continue to follow this new promise.

The trouble is that GIT_SSH_VARIANT=simple is too... simple.  You
would like a variant that passes in [-p port] [-4] [-6] as well.  We
didn't implement that because we didn't have the attention of any
wrapper writer who wanted it; in absence of a potential user, we
decided to wait for a user to propose the interface they want.  Now we
can celebrate, since that day has come.

How would you like your ssh variant to work?  Some possibilities to
get the thought process going:

 A. Would you want to set a variable 'GIT_SSH_SUPPORTS_OPTIONS=p46'
    to inform Git about what options you support?

 B. Alternatively, what about a 'GIT_SSH_VARIANT=capabilities' variant
    that calls "your-ssh-variant --capabailities" to get a
    machine-readable list of capabilities it supports?

 C. Alternatively, would you like all parameters to come in on stdin,
    credential helper style?

 D. Other ideas?

[...]
> But again, I'm just describing what makes sense to me. If you feel
> strongly about requiring the variant to be explicitly specified, I can
> certainly live with that.

I think I do feel strongly.

If you were using an old version of OpenSSH, this would be a reason to
revive the old patch, but I'm tempted to stall longer just to get more
use cases like this to come out of the woodwork.

Of course that's a dangerous thought process.  Probably by tomorrow
I'll think better of it and revive the patch.  In the meantime I would
be happy to see your answers to the questions above.

Sincerely,
Jonathan
