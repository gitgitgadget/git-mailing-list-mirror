Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 779D81F428
	for <e@80x24.org>; Thu, 16 Aug 2018 14:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390699AbeHPRnK (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 13:43:10 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:37487 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387920AbeHPRnK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 13:43:10 -0400
Received: by mail-yb0-f176.google.com with SMTP id r3-v6so697489ybo.4
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 07:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ocLvOeRBXII3XttlgCgOxWwVD9ujoEPyGiKfpiz/d8=;
        b=YGA9yg9XCJ4FDAIQi38B++1bsPH19Kd1x0N6A0Y+gudpBJ0ZqU4N5JSHym16Doo8kG
         CodD7TlzDrVuQgkLNObefj1gdM2h4YCvpXEwCOq8ECF5Lw0k/WVpGoP21cwXwN/UOenj
         rxQFUBToG79i4Df7TG8uOlYNCZMRpBkbukREz1dSi2WK2cNeXe5d9lnMUjE1eoAnmfD6
         LiGcGHgOGRjiFnEqt2/hlqW0vI18U22m4OfjXtrFwAfbYw8LICif84boy00t7kk1OByH
         MKGRLo1a9p6IE4RD3qFZ5j+Ydysxav7MLywtdd3Ju+DxtEzLIXLu+keal4IuT8loA4OE
         bWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ocLvOeRBXII3XttlgCgOxWwVD9ujoEPyGiKfpiz/d8=;
        b=FG+G8cJ2o8n4TIuNie9AxvuHubqC4+ebWaWcOZYO2M9If6/JnosBdQO8COHQopyiFs
         JSPGZGpYFSc1dvBqRNOEAb+YHDtsmNwl7pceViEkHWWvDdOCc2nPoHid91TQ6BodCa0W
         npA9fBzcMrrWHl9W1boVrsIKYHvwYaRyn1woUfMWC77fk2+oN8Rilq+2ZCrNrOCa+cQ2
         Tej6H4nNvelmhr8r+03fJVvFylEaGxPolart5QsFuOyfNWcrNXO6nN/UnZgkGt2vaiMe
         ggiqsNzL3CQBPicxNS6YadKsjWtZDm5GnTpP+BFFwdE3wgFRt+5MdunoEsOuIpOCDoP/
         2v8A==
X-Gm-Message-State: AOUpUlFSGi944T/bnvB3+gTqqiNZ11ZU5QSR9pHFTx7DFcpa+AaDQ4AO
        tAP1LkIdyqQWPWREFYVqM9hvMQoyR8TkbhRKhW9/EQ==
X-Google-Smtp-Source: AA+uWPwXMr+QyJHBEKZf7kvpD/iN5yejt57ILnJV+ZjoWZBUQADWR+H8XktSCmO02frdGw10Tw9ULRaLjpJywlBjb58=
X-Received: by 2002:a5b:a87:: with SMTP id h7-v6mr16473189ybq.521.1534430650145;
 Thu, 16 Aug 2018 07:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqpnyjgroj.fsf@gitster-ct.c.googlers.com> <85c6eb4c-a083-4fb7-4860-b01a8ce9fa4f@gmail.com>
In-Reply-To: <85c6eb4c-a083-4fb7-4860-b01a8ce9fa4f@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 16 Aug 2018 07:43:58 -0700
Message-ID: <CAGZ79kZ3PzqpGzXWcmxjzi98gA+LT2MBOf8KaA89hOa-Qig=Og@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #03; Wed, 15)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 6:15 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/15/2018 7:01 PM, Junio C Hamano wrote:
> > * ds/commit-graph-with-grafts (2018-07-19) 8 commits
> >    (merged to 'next' on 2018-08-02 at 0ee624e329)
> >   + commit-graph: close_commit_graph before shallow walk
> >   + commit-graph: not compatible with uninitialized repo
> >   + commit-graph: not compatible with grafts
> >   + commit-graph: not compatible with replace objects
> >   + test-repository: properly init repo
> >   + commit-graph: update design document
> >   + refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback
> >   + refs.c: migrate internal ref iteration to pass thru repository argument
> >
> >   The recently introduced commit-graph auxiliary data is incompatible
> >   with mechanisms such as replace & grafts that "breaks" immutable
> >   nature of the object reference relationship.  Disable optimizations
> >   based on its use (and updating existing commit-graph) when these
> >   incompatible features are in use in the repository.
> >
> >   Perhaps eject and replace with another reroll when it comes.
> >   cf. <a3640919-95cf-cca4-d552-4715a031dd7f@gmail.com>
> >   cf. <86bmap7l7a.fsf@gmail.com>
>
> Yes, I am working on a re-roll. Feel free to eject in the meantime.
>
> For one, I need to base it on jk/core-use-replace-refs. This is not
> hard, as it is already in master.
>
> For two, I was waiting for resolution on the way to handle arbitrary
> repositories in for_each_replace_ref. Stefan had a few proposed patches,
> but they don't seem to have completed. Can someone fill me in on the
> status there? I could re-roll with the two simple patches that I have,
> which send the struct repository pointer into the 'void *' data parameter.

Yeah, I was exploring the design space there and IIRC these two patches
are the best for the commit graph to do for now IMHO.
I might resend [1] to remove the first repository argument to make the API
cleaner again.

As Duy says in [2], we should
(A) change the construction of ref stores to not take a gitdir path, but
    a repository argument, which is stored internally
(B) change the signature of all the callback functions to take a ref store
    as a first argument, and then we can have a function
      get_repo_from(ref store)
    or put the repo in the callback cookie as you do in this series.

Wth this we do not treat the repository argument any special in the
refs code and only if we have the pressing need to have it always
available we might want to implement the get_repo_from_refstore
instead of treating it just like any other data passed through the cb
cookie.

[1] https://public-inbox.org/git/20180730194731.220191-3-sbeller@google.com/
[2] https://public-inbox.org/git/CACsJy8DwaLCxY-ryV+=OwRytzwwQZCfVmfXo0z91z9YRMMT0VA@mail.gmail.com/

tl;dr: please keep these two patches for now, I'll send patches on top
if that is where I'll go next.

Thanks,
Stefan
