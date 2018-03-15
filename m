Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A96D31F404
	for <e@80x24.org>; Thu, 15 Mar 2018 15:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932520AbeCOPvq (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 11:51:46 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:33895 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932496AbeCOPvp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 11:51:45 -0400
Received: by mail-ua0-f175.google.com with SMTP id m43so4671385uah.1
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qeMDVcK+ilEyU57E7dUIArPfnm8ZauL1W4xto447opo=;
        b=ZyfSn4rMlpxTDwoUe3DZkly1hAkDJpBzWy2QkjoxKlwJo0FHXV5ILDDiWUpYS92+is
         SmtvgbWiPN3YnHOdW9CTivVa5SnyDfept7cYTDg8harKbE2K3XNWvdD4GALEyB5xQ8BE
         YVUDPRUIKa5cxtJh9ZQFKkaIX28nMr4ym+IX2aNYov1binx8Dmkm3DLO2UESyiIL+La6
         mGrKIc6Vvwp3gyS+VgPyQbaVotDnMkIoFyNFps3tHoosMnL9y/FCCWdGkm1L6TXmzAe/
         Ncprdnxt0zriIbauibBk5ezXP8ET8leofT/g0w6wTUGoW1WMymOdtFH8TfxQyI40PCrT
         x07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qeMDVcK+ilEyU57E7dUIArPfnm8ZauL1W4xto447opo=;
        b=sIfDwKo1BTs60zaUbAf98uNJZdE9dL//S/+pRrEXwNcwjAVh8zgpgylkDDLvWfLcAw
         GSePNBJAiA6ZXy9WoObIXgjE456xckol4JipyJ2cSDMJ23pvArXPsGaM6lKRrZ0blWiV
         JP7fE+FhHZnfN58yu6LDLtW41G3aKineMeosUZET5XsO5iY4VL7iyqf3xKqsAVyYOp0Y
         IKAeX0UJtD/guecIeLNbMOc/DMVKErqtMtPhJiOFdFwxYiqBYJJDtS8Rjl8rOfo6TFLy
         mvlFG9pRrXrQ1Ejr/7phLby6NlOsSnuxTZW+/jptd39dPSMfmszdxZondd01vYkeCKpf
         nCcA==
X-Gm-Message-State: AElRT7HYKC/WxKOHAC/1CVvCs9ge8m/cAb8TW6sdnEGMN/pTrAYeGIOy
        JCrS2NnWfj8WqFbmhtu12rE8rt3wx2Lhl4WoYxDoVw==
X-Google-Smtp-Source: AG47ELvZvmgpfENDjXqqFunC7ZMHiV3qUiDqB5E+IQHPESK8cuIGRMpcMH9b6XBnOduARGQwt86Hs8tud82FJNlf2us=
X-Received: by 10.159.63.11 with SMTP id h11mr6839693uaj.94.1521129104405;
 Thu, 15 Mar 2018 08:51:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.0.11 with HTTP; Thu, 15 Mar 2018 08:51:43 -0700 (PDT)
In-Reply-To: <20180315140921.GA27748@sigill.intra.peff.net>
References: <7895279B-9FB6-471B-A8BA-53315B265A51@gmail.com>
 <20180314222028.GA20977@sigill.intra.peff.net> <1632E897-B434-4ECC-A236-49C03398DF55@gmail.com>
 <20180315140921.GA27748@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 15 Mar 2018 08:51:43 -0700
Message-ID: <CABPp-BEsTOZ-tCvG1y5a0qPB8xJLLa0obyTU===mBgXC1jXgFA@mail.gmail.com>
Subject: Re: How to debug a "git merge"?
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 7:09 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 15, 2018 at 10:51:27AM +0100, Lars Schneider wrote:
>> Next time I won't stumble over this. I wonder if this is a common enough
>> problem to do something about it? For instance what if `git log` (or just
>> `git show`) has an option `--verify-merges` or `--reenact-merges` or
>> something? This option would perform a "default recursive merge" and
>> show the diff between the actual merge and the default merge?
>>
>> In the most common case there is no diff. If there are merge conflicts
>> then we would just show the conflicting files. If there is no merge
>> conflict for a file *but* a difference then we would show it. I think
>> this would have helped me to realize this kind of problem earlier.
>>
>> Would that option make sense to you?
>
> Yes, it's absolutely a good idea, and a frequent wish-list item. The
> problem is that it's tricky to implement. The only working patches I
> know of were Thomas Rast's "--remerge-diff" from 2014:
>
>   https://public-inbox.org/git/cover.1409860234.git.tr@thomasrast.ch/
>
> The tricky thing is that you have to actually re-run the diff, and we
> don't know what options were used for the original diff (e.g., what
> strategy). And also, merge-recursive really wants to have a valid
> working tree (though I think maybe that has gotten better over the
> years).

merge-recursive's working tree reliance has gotten better, though work
remains.  I'll get back to it, eventually.  :-)

There's also a third issue which I think makes this feature difficult
(though not intractable): some conflict types might be difficult to
represent in such a diff.  For those interested in the details

In particular, at the basic level I'm thinking of conflict types such
as modify/delete, rename/rename(1to2), and directory/file conflicts.
It appears Thomas Rast's series would resolve all of these by doing a
two-way diff against /dev/null for each un-paired but conflicted path.
Perhaps that's good enough, but it does lose a lot of semantic content
(is this conflict because this was an add/add conflict where one side
was an empty file, or did one side of history delete the path, or did
the other side of history rename the path elsewhere, or did one side
have a directory in the way?).  This semantic content isn't stored
anywhere in merge-recursive; it's simply printed with a "CONFLICT"
message to the screen when it runs across the path, so there'd be a
little work involved in re-plumbing that.  Also, directory rename
detection adds implicit renames that add a few more conflict types
that could fall in this set ("Existing file/dir in the way of implicit
rename for path", and "Cannot map more than one path to %s from
implicit renames").  There's also one it adds that maybe could map to
this type of solution but it'd take some work ("directory rename
split").

To make matters worse, there are also multiply-conflicted types that
are possible that may make matters even more difficult for a --remerge
diff.  For example, the files involved in a rename/rename(2to1) could
also be involved in a rename/delete.  Another that came up on the list
yesterday is that both rename/add and rename/delete conflicts can
happen on the same pair.  I think merge-recursive doesn't even detect
these and mis-handles both in the normal case, the --remerge-diff
would just be even more tricky.  There are also a couple new
multiple-conflict-types that are handled fine for the normal merge
case but might make a remerge-diff more complex.  Two examples I can
think of are (1) if a path is involved in a rename/delete, and the
renamed side should get a transitive renaming due to the directory it
getting renamed into having been renamed on the other side of history,
but there's a path in the way of the implicit rename, or (2) if a path
is involved in a modify/delete and should be implicitly renamed due to
a directory rename but there are several paths that need to be
implicitly renamed to the same location.

However, to end on a bit of good news, this week's decision to make
rename/rename(2to1) and rename/add both behave more like add/add will
simplify matters for implementing --remerge-diff.
