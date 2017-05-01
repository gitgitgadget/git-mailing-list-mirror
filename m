Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07D641F790
	for <e@80x24.org>; Mon,  1 May 2017 10:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2993264AbdEAKfC (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 06:35:02 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35398 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2992797AbdEAKfA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 06:35:00 -0400
Received: by mail-io0-f195.google.com with SMTP id d203so21153905iof.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 03:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cohf5/LSIOjfgk4Z9KRKIlkQmZ7ThFikPrDwSiyS5Pc=;
        b=pTOcRtQ+13aNjOBxp12TCs4cdVhPajnnQjN6Gp94Dz4wWy77vpLjsrGGOaDEIzfcbC
         vio/lSx+9ooTCny26jEt6xL/XWZ4NMqS+F6k0tFvPgldNINPxXhdwxQKOK5eOsZXvxN+
         lMOAzXnWAfzIkSzRuvTJrBxKfxKrdtjvOay+0GV+NA97hYDrV2x7NPG2StsDZghF4zxV
         KghBmVvpoOmnBeetAjU+R4Dznl1I1dPu47r7CfvcIu0q2PLtpqSYC1ItCKV+wHZFM5+y
         ErSdK1bpJG6D0taOzdj0u6rmLVVluLwvEZXNzZiqJsCUeLpqM3TvIYTjjZ86yPYbvJ+/
         AoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cohf5/LSIOjfgk4Z9KRKIlkQmZ7ThFikPrDwSiyS5Pc=;
        b=f4sLjGnpXZSzCeR1eOeJxtfGAKsemCCYUOh6LiMEVvzExCa9WPfQdb+LKBHFypSaGr
         MbxecScEbX1BLjthS+1S2zFRM/2tFWfbPUQ/NprIbPbNTO1Cvk3hUdQXVvaUjD9MU1kg
         cjp33BHITas9rYAIn1DdNbqezpClNDzmsAovu/YP+GZOQrPoXLy+Fv/6hxrPr8VyPBtM
         nmKGDyOdd1nMr6hppvn5JxAlFkRkqjLp7HmhsMduzcYt3LPNlBoUj5+mNNL4yIE/Cfp0
         lXo+VQz7Eo705fbxwgcdz0HQfQ3w5+GO/0XN+BJGz9BNDWfUGxwzB19i0VoUNIs1pnGD
         IeJA==
X-Gm-Message-State: AN3rC/4YXot5C9Lhg3TX+uHLNr5S68qgT9WJO1Wc5CT2rt483bW34d5h
        5SwCEck+5w/enyouIkmSb9FB9bpmOg==
X-Received: by 10.107.178.129 with SMTP id b123mr20999763iof.50.1493634899252;
 Mon, 01 May 2017 03:34:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Mon, 1 May 2017 03:34:38 -0700 (PDT)
In-Reply-To: <20170428220450.olqitnuwhrxzg3pv@sigill.intra.peff.net>
References: <19607a03-71e0-440b-7213-64d25f6fa8da@xiplink.com>
 <20170427205037.1787-1-marcnarc@xiplink.com> <CAGZ79kbUqVfz+6Y0XkTL7FCZfaD+2YRMZ_v0vP8-DOFhWc+ELw@mail.gmail.com>
 <20170428220450.olqitnuwhrxzg3pv@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 1 May 2017 12:34:38 +0200
Message-ID: <CACBZZX5f81HKCjRjTDyXzNMVuef9Z_ECS+0SVk2xpbwXudgxCw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Make diff plumbing commands respect the indentHeuristic.
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 29, 2017 at 12:04 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 28, 2017 at 10:34:15AM -0700, Stefan Beller wrote:
>
>> > So instead I chose to make the indentHeuristic option part of diff's basic
>> > configuration, and in each of the diff plumbing commands I moved the call to
>> > git_config() before the call to init_revisions().
>> [...]
>>
>> The feature was included in v2.11 (released 2016-11-29) and we got no
>> negative feedback. Quite the opposite, all feedback we got, was positive.
>> This could be explained by having the feature as an experimental feature
>> and users who would be broken by it, did not test it yet or did not speak up.
>
> Yeah, if the point you're trying to make is "nobody will be mad if this
> is turned on by default", I don't think shipping it as a config option
> is very conclusive.
>
> I think a more interesting argument is: we turned on renames by default
> a few versions ago, which changes the diff in a much bigger way, and
> nobody complained.
>
>   As a side note, I do happen to know of one program that depends
>   heavily on diffs remaining stable. Imagine you have a Git hosting site
>   which lets people comment on lines of diffs. You need some way to
>   address the lines of the diff so that the annotations appear in the
>   correct position when you regenerate the diff later.
>
>   One way to do it is to just position the comment at the n'th line of
>   the diff. Which obviously breaks if the diff changes. IMHO that is a
>   bug in that program, which should be fixed to use the line numbers
>   from the original blob (which is still not foolproof, because a
>   different diff algorithm may move a change such that the line isn't
>   even part of the diff anymore).
>
>   I'm not worried about this particular program, as I happen to know it
>   has already been fixed. But it's possible others have made a similar
>   mistake.
>
>> So I'd propose to turn it on by default and anyone negatively impacted by that
>> could then use the config to turn it off for themselves (including plumbing).
>>
>> Something like this, maybe?
>
> Yeah, as long as this is on top of Marc's patches, I think it is the
> natural conclusion that we had planned.
>
> I don't know if we would want to be extra paranoid about patch-ids.
> There is no helping:
>
>   git rev-list HEAD | git diff-tree --stdin -p | git patch-id --stable
>
> because diff-tree doesn't know that it's trying for "--stable" output.
> But the diffs we compute internally for patch-id could disable the
> heuristics. I'm not sure if those matter, though. AFAIK those are used
> only for internal comparisons within a single program. I.e., we never
> compare them against input from the user, nor do we output them to the
> user. So they'll change, but I don't think anybody would care.

I have a few-million row table with commit_id as one column & patch_id
as another. I.e. a commit -> patch_id mapping.

This is used for an hourly reporting system of sorts, i.e. you can see
that you were working on commit X on Friday. It uses the patch-id to
de-duplicate that commit against some commit Y you may have pushed to
a topic branch, and already used for filling in hours.

I.e. it's a thing do DWYM in a rebase-heavy workflow where the commit
ids change, and where you're too lazy to have deleted the topic branch
afterwards (because they get pruned anyway).

It's fine for me if the patch-id changes, for most diffs it'll be the
same, and if not it'll auto-adjust eventually since the records I'm
inserting will all use the new algorithm.

But as the diff algorithm changes this system will start presenting
both X and Y in the UI as not-duplicate, because it'll have computed
the patch id of X with an older version of git, and the id of Y with
the new one.

I'm surely not the only one who's written something like this. Just
wanted to point out that systems like this do exist, I don't know of
any easier way with git to get a "is this rebased commit the same"
than patch-id, and for performance reasons you may be comparing patch
ids across git versions.
