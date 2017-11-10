Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24AC51F43C
	for <e@80x24.org>; Fri, 10 Nov 2017 10:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbdKJK6k (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 05:58:40 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:53235 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752710AbdKJK6j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 05:58:39 -0500
Received: by mail-wr0-f171.google.com with SMTP id j23so8236125wra.9
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 02:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1avN7gbWOSDdOqTnkhHdHUily5SI+xqdR6iju+Dh7SM=;
        b=vjBFHtmCpvzA7m6R3OcEE8nckvQp43F9myYqbfTy721p35sLJf6hJB4xWoSl5HkCwl
         XCkMndppHq+rnr3sh7D+okrn+aHy+w5H9w28TrJOQJl0ahyphI5jUy47PVAeIS5Tcm6B
         dZ4x3pv+J/CcCeCt7vZmrfe0vld27CfpoigME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1avN7gbWOSDdOqTnkhHdHUily5SI+xqdR6iju+Dh7SM=;
        b=h863QTmRK1hvOWl4W6a0UUf/mo6psEH9mGBCdFecHNlFbdujdzW08KqB77kRvwmMd6
         JfF6n3qznJicwD1QMh+h1WGAA2G9GZIi3CLpFdyERp5vjHBAfv/DYA6833mT1QFgh/vv
         QJwj90aEobtCkhsrI1uq5+k13P0zsvmoh3Qtfc5RCO2qlCfN33ZGOt4oYjiU50MowD1W
         RjXsSlFxHN+i9nXyOWtLDpxt216i2WZ9eObdv4/Ou9GAQj2KVQ3w9TV+npoBBTNGhk/k
         bvNfLPe+0kiEo6tErSd7lamX8YhNxGCuvNfGPBkml46Nm3F9vkf7jb0U49POG6iusSyN
         3eYw==
X-Gm-Message-State: AJaThX5B1iSB+IbQDCmuc0m9euCdQVyNNd54S/JCxDow7e2PQDQX9xgb
        QptfCxDFLL6CYvXqSmub39/jikiAzuA=
X-Google-Smtp-Source: ABhQp+Rs7MTneMGj5VJ/ZUaAgDftmqGVm3veBJt2R4xI05IvDmeDQttjbskvsOWmBYMbA3msx0gQ5g==
X-Received: by 10.223.169.21 with SMTP id u21mr2871675wrc.30.1510311518290;
        Fri, 10 Nov 2017 02:58:38 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id 19sm1778638wmn.15.2017.11.10.02.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2017 02:58:37 -0800 (PST)
Date:   Fri, 10 Nov 2017 10:58:34 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Johan Herland <johan@herland.net>
Subject: Re: [PATCH] notes: add `rm` and `delete` commands
Message-ID: <20171110105834.GI20681@dinwoodie.org>
References: <20171109134617.65244-1-adam@dinwoodie.org>
 <CAPig+cRq7thrPtzS0V6o-wMhHyYWKeWg-xOQhnWCO5sLE=kDcw@mail.gmail.com>
 <xmqq1sl6j04b.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1sl6j04b.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday 10 November 2017 at 12:14 pm +0900, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > or against the change:
> >
> >     - synonym bloat; balloons documentation
> >     - steals command verbs from potential future features
> >     - ...
> 
> I tend to agree with these two (and if I were to replace the "..."
> with something concrete, this change is not desirable because it
> will force us to add all these three when we introduce "remove"
> elsewhere in the system).
> 
> Having said that, this remids me of an age-old topic we discussed in
> a distant past but stalled due to lack of strong drive, which is:
> 
>     Some git subcommands take command verb (e.g. "git notes 'remove'")
>     while others take command mode flags (e.g. "git branch --delete"),
>     and the users need to remember them, which is not ideal.
> 
> I think the consensus back then, if we were to aim for consistency
> by uniformly using only one of the two, is to use the command mode
> flags, simply because existing commands that have the primary mode
> and take an optional command mode flag [*1*] cannot be migrated to
> the command verb UI safely and sanely.
> 
> And then, if we are not careful when we standardize all subcommands
> to take command mode flags, we might end up with a situation where
> some subcommand say "--remove" while other say "--delete", and some
> users will wish to rectify that situation by adding an alias defined
> for these flags---I view this patch as a part of that possible
> future topic ;-).

My motivation was entirely "these were the commands I tried before I
tried `remove` when I wanted to delete a note."  I think both have
precedence in Git with the likes of `git rm` and `git branch --delete`,
although you're entirely correct that I should have at least added that
justification in the commit message.

The matter of which verbs and which flags work where is clearly a much
broader concern.  However at the moment Git uses `rm`, `remove` and
`delete` with no apparent (at least to me) logic about which is used
where, and it seems to me that adding each as synonyms of the other
across the entire suite would improve usability.

In particular, I don't think I buy the argument that it steals verbs: I
can't imagine wanting to use multiple of those verbs in the same context
with different meanings, as that seems liable to cause significant
confusion.

That said, I do get the argument about UI and documentation bloat.  From
my perspective, the cost of that is less than the benefit of having a
more consistent interface, and this is something we can do to have a
more consistent interface *now* without waiting for a larger future
consistency project, but YMMV, and I'm very willing to bow to everyone
else's expertise on this.
