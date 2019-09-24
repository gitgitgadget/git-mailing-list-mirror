Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF1B1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 09:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfIXJCG (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 05:02:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53226 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfIXJCF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 05:02:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id x2so1253678wmj.2
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 02:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gJj7qk5Ld/uALbY5DPA0E5dmXYsu+2yLZqQAS1VEaYo=;
        b=ib1/gfPZ820XmYPCbFKXEXTw1o4goJReOP4nghrHXe3Hl9nUr7qQr3MGj2dJneu9Yx
         UWVOZ1EiA7S/VrYQ62h/VtfeUoo1Ct6MDAfG1Fm1ayvawojp4DCv1MzLTpyf+EhmNfvL
         wn3gflj5TGz4pkJamhFohkfAsTWVpZeqcWEEaL1+hCAR+WtLRt70cxy1MrJNLUft5WPf
         Yd2q3dlQZhHTjLe7303PSoauWHCskMgMO55S3mjy39xp4TW3TD8N1AZqeHNFR+36GC6d
         2LP21jSOIRf54t49YcO36bNPatDS9Dlq4nOBzPTgIz2IfUwjx0FGWtP7VIMIIZVV5lg5
         4BUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gJj7qk5Ld/uALbY5DPA0E5dmXYsu+2yLZqQAS1VEaYo=;
        b=kRlwlzeTfPbb4COow+1ZsAZvyTBMEssn1jg04WX6EyDha8iU3fnh1053fL2hKG+J4T
         lza9eYuiAZdDM8U5iOZkc3mRNgmMrF/akTfMFv02GC6QKui7lV5KXJKYEr4ZDWSD9/uf
         nT3EYggDfel83cN8NWe/89Qolb7UtV167jF8ZH+oAqX2fu9qBEM97ce0VkjfDdAeXOaB
         u0GhCJxP6vA8Nu/zEG5eerE1pTH3/C1Wql8I/XHE6rAdRoT3RnIlXEztLEDfEwPk9dMK
         mt0TPMce+yKX5gFtuw5QZF7jDaQAtbUc2S7ZvjMf+zi6/RSE2zdILNHd6npc2BDhBLCQ
         t9Tw==
X-Gm-Message-State: APjAAAVrDNDQcDDW0ednDSpzAhlnKwcsbxLTgB820qGUvfC7cb1aNfzx
        AAnRQSDRuZtE0YdvgQnjYkE=
X-Google-Smtp-Source: APXvYqzcuqDnKkjdjtcx2a2Sp4cBC+3saJwcYNHBxQeCX3wypFcxwiuS3Pg8CFD2GaChRJYf2UGZdw==
X-Received: by 2002:a1c:4384:: with SMTP id q126mr1926413wma.153.1569315723351;
        Tue, 24 Sep 2019 02:02:03 -0700 (PDT)
Received: from szeder.dev (x4dbd468e.dyn.telefonica.de. [77.189.70.142])
        by smtp.gmail.com with ESMTPSA id o14sm1181836wrw.11.2019.09.24.02.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 02:02:02 -0700 (PDT)
Date:   Tue, 24 Sep 2019 11:01:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, git@sfconservancy.org,
        Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [PATCH] add a Code of Conduct document
Message-ID: <20190924090152.GA7209@szeder.dev>
References: <20190924064454.GA30419@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924064454.GA30419@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 24, 2019 at 02:44:54AM -0400, Jeff King wrote:
> We've never had a formally written Code of Conduct document. Though it
> has been discussed off and on over the years, for the most part the
> behavior on the mailing list has been good enough that nobody felt the
> need to push one forward.
> 
> However, even if there aren't specific problems now, it's a good idea to
> have a document:
> 
>   - it puts everybody on the same page with respect to expectations.
>     This might avoid poor behavior, but also makes it easier to handle
>     it if it does happen.
> 
>   - it publicly advertises that good conduct is important to us and will
>     be enforced, which may make some people more comfortable with
>     joining our community
> 
>   - it may be a good time to cement our expectations when things are
>     quiet, since it gives everybody some distance rather than focusing
>     on a current contentious issue
> 
> This patch adapts the Contributor Covenant Code of Conduct. As opposed
> to writing our own from scratch, this uses common and well-accepted
> language, and strikes a good balance between illustrating expectations
> and avoiding a laundry list of behaviors. It's also the same document
> used by the Git for Windows project.
> 
> The text is taken mostly verbatim from:
> 
>   https://www.contributor-covenant.org/version/1/4/code-of-conduct.html
> 
> I also stole a very nice introductory paragraph from the Git for Windows
> version of the file.
> 
> There are a few subtle points, though:
> 
>   - the document refers to "the project maintainers". For the code, we
>     generally only consider there to be one maintainer: Junio C Hamano.
>     But for dealing with community issues, it makes sense to involve
>     more people to spread the responsibility. I've listed the project
>     committee address of git@sfconservancy.org as the contact point.
> 
>   - the document mentions banning from the community, both in the intro
>     paragraph and in "Our Responsibilities". The exact mechanism here is
>     left vague. I can imagine it might start with social enforcement
>     (not accepting patches, ignoring emails) and could escalate to
>     technical measures if necessary (asking vger admins to block an
>     address). It probably make sense _not_ to get too specific at this
>     point, and deal with specifics as they come up.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Obviously related to the discussion in:
> 
>   https://public-inbox.org/git/71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com/
> 
> After some poking around at various CoC options, this one seemed like
> the best fit to me. But I'm open to suggestions or more discussion. It
> seems to me that the important piece is having _some_ CoC, and picking
> something standard-ish seems a safe bet.

We are decent people, and know how to behave properly and treat each
other with respect.  It is my fundamental assumption that all future
contributors are decent and respectful human beings as well.  A CoC
like this, which is "explicit about the behavior we want to model"
(quoting the original discussion starter) inherently insinuates that
we aren't decent, and can't behave without being told how to do so.
Frankly, I find this borderline insulting to me, to my parents, to all
fellow contributors, and to future contributors as well.

There are locations, nationalities and cultures, where the avarage
wide-spread CoCs, like Contributor Covenant and its derivatives, are
perceived as (paraphrasing) too "American", politically overcorrect,
corporate BS, etc., which are forced upon open-source projects.
Consequently, such CoCs are often found rather discouraging, and
announcements about their adoption in open-source projects generally
get negative reaction.

Less is more.  Much-much more.  A concise CoC that treats its readers
as responsible, well-behaved human beings is met with much approval.

Take, for example, the TrueOS Rules of Conduct, which in just a few
short sentences covers everything that's worth covering:

  https://www.trueos.org/rulesofconduct/

If diversity and inclusion of other cultures is indeed a priority,
then we should carefully consider that some potential contributors
will rather choose not to contribute because of a CoC like this.


> If people are on board with this direction, it might be fun to pick up a
> bunch of "Acked-by" trailers from people in the community who agree with
> it. It might give it more weight if many members have publicly endorsed
> it.

Because of the above I'm leaning towards NACK.

