Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1E521F404
	for <e@80x24.org>; Tue, 13 Mar 2018 21:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeCMV1N (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 17:27:13 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:39822 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbeCMV1M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 17:27:12 -0400
Received: by mail-pl0-f45.google.com with SMTP id s13-v6so552411plq.6
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 14:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1z5aIGi9HuD4m73PbsAhx7nvkXFgt6y5cLQo2YTRTdM=;
        b=Q11MUNLdzZFVciZxrvjeZ2oXW54R1eJbTeTOiuPPtLgZJBrWsWooxGsNuvw0boDPbG
         oEeNxy2l9JEzaL0+dnWWf2izxVZWPnkg69HMvOSIAsngisMPgF0t3k4sUN7WKKINkJg4
         Kcldl7aYwMmCa6/P0O1wG4DS75Ff3ef8GIJclfqle2/0wc9CXq3nC/B2nGneFoWjEw8X
         s0Vpm5eEZC6rNXneHjNqtnIIXlCSOhsL67m8cqqysNJDP5TaV2ytfqAKXkTMIo5q0pOe
         W/tHkFxu5XtsTBbALx5ESDGaXlp+D28/3AxJofRDT7O8LEs4+zVE44u5MTXE+Frt0SrE
         GECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1z5aIGi9HuD4m73PbsAhx7nvkXFgt6y5cLQo2YTRTdM=;
        b=X0PVt9RElTPvbKNFygbCYdYqm3Vrexa5Ql6v7XGJ29jyKwar+ZX7Gg0z/vZOkLcFUY
         Qg+iGyjwMRY6AOyzyIsv1aZQ/FLD4/IkGJTfJ6FEuH5r38rRZA0x7iKOXfTtvUu+NTP4
         IesyYy+E0e9OiafXNEhli3M+yMYIHvQOUsyraMWVVfSDu2WqJYADebrpypLVd5f2cdrN
         2TWewMEPi1wmSTrWoqx1v89PQLkxf23QNIXrvplZ01n/4DEUOGVzAUmTWy2I8jYBPVP9
         f+yVO9fRBRMGiOqGyysaDIU0T3AjtUGXeZVzj5k0YxlADjAyGBRRFaETf3f5pUt5UThW
         oa3w==
X-Gm-Message-State: AElRT7EfeK3YvnOj8dyChN/2Khr5qw/V1+Sz/6/vxiDKdNDmqm1p7l5A
        tdNWXNKly1pCNx4QlyRlhZWwJepIrCY=
X-Google-Smtp-Source: AG47ELuyw6AEAACveHD5Zj8Q61e6wCANPvvl9GOANy3a9+dPdIkyhjfQxR58avt98FKZoQ4YMkHm3A==
X-Received: by 2002:a17:902:d81:: with SMTP id 1-v6mr1805440plv.324.1520976431980;
        Tue, 13 Mar 2018 14:27:11 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id o3sm1600167pgp.18.2018.03.13.14.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 14:27:11 -0700 (PDT)
Date:   Tue, 13 Mar 2018 14:27:10 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 13/35] ls-refs: introduce ls-refs server command
Message-ID: <20180313212710.GD7638@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-14-bmwill@google.com>
 <xmqqmuzqb2ph.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmuzqb2ph.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/02, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > + ls-refs
> > +---------
> > +
> > +`ls-refs` is the command used to request a reference advertisement in v2.
> > +Unlike the current reference advertisement, ls-refs takes in arguments
> > +which can be used to limit the refs sent from the server.
> 
> OK.
> 
> > +Additional features not supported in the base command will be advertised
> > +as the value of the command in the capability advertisement in the form
> > +of a space separated list of features, e.g.  "<command>=<feature 1>
> > +<feature 2>".
> 
> Doesn't this explain the general convention that applies to any
> command, not just ls-refs command?  As a part of ls-refs section,
> <command> in the above explanation is always a constant "ls-refs",
> right?
> 
> It is a bit unclear how <feature N> in the above description are
> related to "arguments" in the following paragraph.  Do the server
> that can show symref and peeled tags and that can limit the output
> with ref-pattern advertise these three as supported features, i.e.
> 
> 	ls-refs=symrefs peel ref-pattern
> 
> or something?  Would there a case where a "feature" does not
> correspond 1:1 to an argument to the command, and if so how would
> the server and the client negotiate use of such a feature?

I mention earlier in the document that the values of each capability are
to be defined by the capability itself, so I'm just documenting what the
value advertised means.  And a feature could mean a couple things and
doesn't necessarily mean it affects the arguments which can be provided,
and it definitely doesn't mean that each argument that can be provided
must be advertised as a feature.  If you look at the patch that
introduces shallow, the shallow feature adds lots of arguments that a
client can that use in its request.

> 
> > +    ref-pattern <pattern>
> > +	When specified, only references matching one of the provided
> > +	patterns are displayed.  A pattern is either a valid refname
> > +	(e.g.  refs/heads/master), in which a ref must match the pattern
> > +	exactly, or a prefix of a ref followed by a single '*' wildcard
> > +	character (e.g. refs/heads/*), in which a ref must have a prefix
> > +	equal to the pattern up to the wildcard character.
> 
> I thought the recent concensus was left-anchored prefix match that
> honors /-directory boundary, i.e. no explicit asterisk and just
> saying "refs/heads" is enough to match "refs/heads" itself and
> "refs/heads/master" but not "refs/headscarf"?

I don't think there was a consensus at the time, but in the next
revision I'll have them be prefixes instead of containing wildcards.

-- 
Brandon Williams
