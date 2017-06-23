Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A873E207D2
	for <e@80x24.org>; Fri, 23 Jun 2017 21:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754578AbdFWVan (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 17:30:43 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36190 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbdFWVam (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 17:30:42 -0400
Received: by mail-lf0-f43.google.com with SMTP id h22so37314875lfk.3
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IQiZMXjrgTMePREtTLIQ+mvB7x+XhOnfioCdtGKHryw=;
        b=Z8VTNabArSnlg/jYRw1Ky1pImJGO/8S38h+BHJ2T4qqMATA2LUlzJhC3HOxpJZ3+pP
         IWmyge49p66jWHZ0dS9b+K/m0eLOeFsYRMsIucWGh3zZ2EudIsUTaJk6wdG8pi6xNmV0
         G02u+6jKrJ2OydmVgUXX8yVVW4G4AQHyEqRunGqh4ZBKvdG/gOcd3PqOgZIjhsCwTv1U
         CeKJKFo+Ms6fPekqBw+nfup4fBeyNv9KvspKmVGnbTvu72GNLYa4MbW2YO3aEIMEcRF+
         XI0C8xHhAMBWPmIoto+9Rdck7bCzrTGtv9KcHXN6abZkPmppAhLjAWNVm9v2ZTqzlFpM
         aNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IQiZMXjrgTMePREtTLIQ+mvB7x+XhOnfioCdtGKHryw=;
        b=Em4A6kVKPlImBOuEG/eiLqkk0pYV3t0YNC2ky6X3FN7WJJ2qHxG2lq+6DaXgS/oSam
         Mrix4smg8w+lNjeptF2C9XpbBqXvtd9rQ8Pn63XDHKWvH6RKA7tIiPjR0Ojyqd01G/Tg
         R95N7bU8WCvOpS7B5PUQHO/p+moNQ1YhEoM5m3b7LaFWY1aqjTR92OfujRlqEtVbZUMg
         4I+LNQcH65Q8mUDa/Qz+HhJButHf+/8kvKt7oD/tfE0R0PB6tMJMkNsRDMUxWSicda9g
         oHK7YWd3+V65SXyZlOFwU9WFUgPH8g2svsYaoxMHMSe5kmful4KfAHq3P4NnKaTjVZ42
         C1fg==
X-Gm-Message-State: AKS2vOxQOrYlMDgkKoDVIi33rKNCCKPvq+OTnS0EUbqcl3VvvcaZ9w9g
        s2DexqD6aHFqGh5p7B+DSXmYWUKB2Q==
X-Received: by 10.46.9.4 with SMTP id 4mr3172487ljj.23.1498253440473; Fri, 23
 Jun 2017 14:30:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.79.17 with HTTP; Fri, 23 Jun 2017 14:30:19 -0700 (PDT)
In-Reply-To: <xmqqvanmctmb.fsf@gitster.mtv.corp.google.com>
References: <20170623135230.10534-1-jacob.e.keller@intel.com> <xmqqvanmctmb.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 23 Jun 2017 14:30:19 -0700
Message-ID: <CA+P7+xoohKiCvZWQmGmEzWahEevg2KEuFRiM0mmYN6vtnrrnkA@mail.gmail.com>
Subject: Re: [RFC PATCH] proposal for refs/tracking/* hierarchy
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 1:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> Instead, lets add support for a new refs/tracking/* hierarchy which is
>> laid out in such a way to avoid this inconsistency. All refs in
>> "refs/tracking/<remote>/*" will include the complete ref, such that
>> dropping the "tracking/<remote>" part will give the exact ref name as it
>> is found in the upstream. Thus, we can track any ref here by simply
>> fetching it into refs/tracking/<remote>/*.
>
> I do think this overall is a good goal to aim for wrt "tracking",
> i.e.  keeping a pristine copy of what we observed from the outside
> world.  In addition to what you listed as "undecided" below,
> however, I expect that this will highlight a lot of trouble in
> "working together", i.e. reconciling the differences of various
> world views and moving the project forward, in two orthogonal axes:
>

I agree, I think this is definitely a problem that we'd want/have to solve.

>  - Things pointed at by some refs (e.g. notes/, but I think the
>    ".gitmodules equivalent that is not tied to any particular commit
>    in the superproject" Jonathan Nieder and friends advocate falls
>    into the same category) do not correspond to the working tree
>    contents, and merging their contents will always pose challenge
>    when we need to prepare for conflict resolution.

This is part of why I started by looking at notes, since there is
already some code for notes merge, it just doesn't have a standard
place to store "remote" notes. I've wanted that ability to enable more
ease of sharing.

>
>  - Things pointed at by some other refs (e.g. tags/) do not make
>    sense to be merged.  You may locally call a commit with a tag
>    "wip", while your friends may use the same "wip" tag to point at
>    a different one.  Both are valid, and more importantly, there is
>    no point even trying to reconcile what the "wip" tag means in the
>    project globally.
>
> For the former, I expect that merging these non-working tree
> contents will all have to require some specific tool that is
> tailored for the meaning each hierarchy has, just like "git notes
> merge" gives a solution that is very specific to the notes refs (I
> do not know how well "notes merge" works in practice, though).

Agreed. That's also part of why I'm looking at doing it as a partial
"one hierarchy at a time" proposal, I've got a somewhat better format
for that coming Soon(TM)

>
> For the latter, having a separate tracking hierarchy is a strict
> improvement from "tracking" point of view, but I think "working
> together" also needs a well designed set of new look-up rules, and a
> new convention.  For example, some tags may not want to be shared
> (e.g. "wip" example above) even though they should be easy to access
> by those who already have them (e.g. "git log ..wip" should work
> without having to say "git log ..refs/local-tags/wip", even if we
> decide to implement the "some tags may not want to be shared"
> segregation by introducing a new hierarchy).  And also a shared tag
> that is copied to "refs/tracking/origin/tags/v1.0" would need a way
> better than "git log tracking/origin/tags/v1.0" for this mechanism
> to be useful in everyday workflow.
>
> Thanks.
>

My thoughts on tags are sort of the following:

keep the default semantics of tags get copied into our local
refs/tags, (if we're fetching them). However, create some mechanism
for easily showing when you have a local tag with the same name as a
remote tag which don't point at the same thing, by using the
refs/tracking. Possibly, any time you grab a tag, check and see if the
remote version is different and "do something" like complain, or show
both, or give some advice (possibly with a new tool to "pull in the
remote tag if you verify it's accurate, etc".

This way, you generally work with tags the same way but get added
protection for knowing when your local tags differ from what remotes
show?

Thanks,
Jake
