Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C5951F404
	for <e@80x24.org>; Tue, 26 Dec 2017 17:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbdLZRuB (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 12:50:01 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:40866 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbdLZRuA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 12:50:00 -0500
Received: by mail-wm0-f52.google.com with SMTP id f206so35814073wmf.5
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 09:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=G+wTyZHDrFudtW8w5gCO+E2AutcIzt3uZqeOsHESJN0=;
        b=cE61eq1qb3u3s+rgFWVmvvYPUN5MybcP0gTffwFTvAFCmKVxZ0Xk364Y7AD8tuIatw
         P+vK/tJyYqAtm+fOwWV/OCsZE5ccEsp1qVAWHxiVSTCjC45LKoOPsqnV2yfep316WLYK
         RFoygQ7o/IbPy06jHJsG2flhH+JkH1t/8cOzj6Ure3Gqq14G34juECZEfL0cSTFEj+WL
         7QVF8hSw/kzndw6cX01+ckfdcodpGqoONcgpqsjYTKpsGaRoz1BeGoUAAYagMMDlIjcC
         Xz2MvUpvk0Ak3YNoMeoaI6dcW6QpchDsXzarLs1TxT7ksuImKnpHHWHL+uQ6cAlzodQv
         o3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=G+wTyZHDrFudtW8w5gCO+E2AutcIzt3uZqeOsHESJN0=;
        b=NpUDbYN4+wHfu08UFp9sv5Z30BXaI+KcJUEZ2WZbikXyDIxr4S8gWrb3QKQi2f2vC+
         p4j7iL/JrdQp1lxwsGa4ItN8SlVOEvcD8hx4NUgOrPUj5fqeTZMvXBV6pqFJpwPgI8wJ
         AqME7qvB2zeYbRh0hB6fOb4DAwceMmaMvelEo6ZdmD1en/MlIsTHIjSJdzxeMTKvhBxs
         WphOCYYp3Fa1YrKbg25cgCsTH359fkHiK2HvZDFKczynhepVHtMVCKC322noIEwbg0oV
         rqIRKS6FWM70JDMtTAhqMaxwBUfja4BnfPRlznF8t2Uv8NOognTgSZNDiTZuRcd8jvlf
         t0/w==
X-Gm-Message-State: AKGB3mJxizrt2xVZLY5hiR9SHmx9/4Xy5R1ODsI5068Kg1dwbZQ7oRo/
        isku435beEeX5ITzk2XbwWfWqIX9
X-Google-Smtp-Source: ACJfBosx8rpv1jo8S6lwTjKtL8nWzg+S5ZsMhddxo96aggv315iHtN0mSCZPHgn2VRp/p/1iud9Aog==
X-Received: by 10.80.179.233 with SMTP id t38mr31017654edd.267.1514310598951;
        Tue, 26 Dec 2017 09:49:58 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id y1sm27258347edl.39.2017.12.26.09.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Dec 2017 09:49:57 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carl Baldwin <carl@ecbaldwin.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com> <877etds220.fsf@evledraar.gmail.com> <20171223210141.GA24715@hpz.ecbaldwin.net> <87608xrt8o.fsf@evledraar.gmail.com> <20171226001622.GA16219@Carl-MBP.ecbaldwin.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171226001622.GA16219@Carl-MBP.ecbaldwin.net>
Date:   Tue, 26 Dec 2017 18:49:56 +0100
Message-ID: <87vagtqszf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 26 2017, Carl Baldwin jotted:

> On Sat, Dec 23, 2017 at 11:09:59PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> >> But I don't see why you think this needs a new "replaces" parent
>> >> pointer orthagonal to parent pointers, i.e. something that would
>> >> need to be a new field in the commit object (I may have misread the
>> >> proposal, it's not heavy on technical details).
>> >
>> > Just to clarify, I am proposing a new "replaces" pointer in the commit
>> > object. Imagine starting with rebase exactly as it works today. This new
>> > field would be inserted into any new commit created by a rebase command
>> > to reference the original commit on which it was based. Though, I'm not
>> > sure if it would be better to change the behavior of the existing rebase
>> > command, provide a switch or config option to turn it on, or provide a
>> > new command entirely (e.g. git replay or git replace) to avoid
>> > compatibility issues with the existing rebase.
>>
>> Yeah that sounds fine, I thought you meant that this "replaces" field
>> would replace the "parent" field, which would require some rather deep
>> incompatible changes to all git clients.
>>
>> But then I don't get why you think fetch/pull/gc would need to be
>> altered, if it's because you thought that adding arbitrary *new* fields
>> to the commit object would require changes to those that's not the case.
>
> Thank you again for your reply. Following is the kind of commit that I
> would like to create.
>
>     tree fcce2f309177c7da9c795448a3e392a137434cf1
>     parent b3758d9223b63ebbfbc16c9b23205e42272cd4b9
>     replaces e8aa79baf6aef573da930a385e4db915187d5187
>     author Carl Baldwin <carl@ecbaldwin.net> 1514057225 -0700
>     committer Carl Baldwin <carl@ecbaldwin.net> 1514058444 -0700
>
> What will happen if I create this today? I assumed git would just choke
> on it but I'm not certain. It has been a long time since I attempted to
> get into the internals of git.

New headers should be added after existing headers, but other than that
it won't choke on it. See 4b2bced559 when the encoding header was added,
this also passes most tests:

    diff --git a/commit.c b/commit.c
    index cab8d4455b..cd2bafbaa0 100644
    --- a/commit.c
    +++ b/commit.c
    @@ -1565,6 +1565,8 @@ int commit_tree_extended(const char *msg, size_t msg_len,
            if (!encoding_is_utf8)
                    strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);

    +       strbuf_addf(&buffer, "replaces 0000000000000000000000000000000000000000\n");
    +
            while (extra) {
                    add_extra_header(&buffer, extra);
                    extra = extra->next;

Only "most" since of course this changes the sha1 of every commit git
creates from what you get now.

> Even if core git code does not simply choke on it, I would like push and
> pull to follow these pointers and transfer the history behind them. I
> assumed that git would not do this today. I would also like gc to
> preserve e8aa79baf6 as if it were referenced by a parent pointer so that
> it doesn't purge it from the history.

It won't pay any attention to them if "replaces" is something entirely
new, what I was pointing out in my earlier reply is that you can simply
*also* create the parent pointers to these no-op merge commits that hide
away the previous history the "replaces" headers will be referencing.

The reason to do that is 100% backwards compatibility, and and only
needing to make minor UI changes to have this feature (to e.g. history
walking), as opposed to needing to hack everything that now follows
"parent" or constructs a commit graph.

> I'm currently thinking of an example of the workflow that I'm after in
> response to Theodore Ts'o's message from yesterday. Stay tuned, I hope
> it makes it clearer why I want it this way.
>
> [snip]
>
>> Instead, if I understand what you're actually trying to do, it could
>> also be done as:
>>
>>  1) Just add a new replaces <sha1> field to new commit objects
>>
>>  2) Make git-rebase know how to write those, e.g. add two of those
>>     pointing to A & B when it squashes them into AB.
>>
>>  3) Write a history traversal mechanism similar to --full-history
>>     that'll ignore any commits on branches that yield no changes, or
>>     only those whose commits are referenced by this "replaces" field.
>>
>> You'd then end up with:
>>
>>  A) A way to "stash" these commits in the permanent history
>>
>>  B) ... that wouldn't be visble in "git log" by default
>>
>>  C) Would require no underlying changes to the commit model, i.e. it
>>     would work with all past & future git clients, if they didn't know
>>     about the "replaces" field they'd just show more verbose history.
>
> I get this point. I don't underestimate how difficult making such a
> change to the core model is. I know there are older clients which cannot
> simply be updated. There are also alternate implementations (e.g. jgit)
> that also need to be considered. This is the thing I worry about the
> most. I think at the very least, this new feature will have to be an
> opt-in feature for teams who can easily ensure a minimum version of git
> will be used. Maybe the core.repositoryformatversion config or something
> like that would have to play into it. There may also be some minimal
> amount that could be backported to older clients to at least avoid
> choking on new repos (I know this doesn't guarantee older clients will
> be updated). Just throwing a few ideas out.

Sure, it could be opt in, be a new format etc. But you haven't explained
why you think a feature like this would need to rely on an entirely new
parent structure and side-DAG, as opposed to just the more minor changes
I'm pointing out above, and which I think will give you what you need
from a UX level.

> I want to be sure that the implications have been explored before giving
> up and doing something external to git.
