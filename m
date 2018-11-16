Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 236EA1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 21:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbeKQHuy (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 02:50:54 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40066 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbeKQHuy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 02:50:54 -0500
Received: by mail-qk1-f194.google.com with SMTP id y16so39838025qki.7
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 13:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CzWAeTLOHV/0vWWPPPnNhpiX2EGTPbqduaWJcATnuOA=;
        b=jJc1ViRt8KsFDqP5N/iJY+IwCSPjj9oHxF+K4tL/GGYeprmQXGrKEAkQpmxne6Fs3h
         1cP6BDPp0RubbUvBpxvfAzb+6PP2bsdp0oLRDCDQE9DmO6bRYjDsuhHw/s+HiT27t8qM
         FPPq/+4PEdjKOXvuxwccm2FRrJMKEJHVMTgseTlHoJtyqYTmFn5ugyFS7DpkK1HHSTW2
         SCsBko3LjZEqU1bqGbrPXKHrDwKQ/Orso6R+NgeW8Cu4jb67uLU1zzL9S8ONPw8PQjem
         3/bCgl0pkqH0TZQ/J9A3gIt1BPKhs9Tjd43KhK2CTuFGvy85eHLb94g7eFXOq5NeWEkl
         uJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CzWAeTLOHV/0vWWPPPnNhpiX2EGTPbqduaWJcATnuOA=;
        b=D90jAJyFb+BStTbBi4dfJ2jrnO0r/VEsZ/POyptb9j0vG49eJ7phYXGR3dXNSR3zZz
         npeCcYBXHBAblwPi+jJN8iCUuOzz2jt2EiY4KkWodKb30Pv/ZU6TH0ayDaTvG3LdWvCO
         I6hGudL00yTtET+YvEA1D/rck/i/GHVEFO1L3p0QyvUdLxYRObXe4dqh14rJjbKcItca
         oOAENPbzL0Ks3cBwW+VInv9IlnHzdvEO7mIcRSz+kkrNpa3aD8mZdkgFXn2WWtCQZjSU
         hUYgQX3y5+6zyUGLLlO6L/Kf2J4+PwmmNUerTfzP73s8Qz4YIUkXcbTbks6eeEOs2PM+
         CfGg==
X-Gm-Message-State: AGRZ1gK28yOHrTbklDtRMlnENxY7PZtop4YYttPY6/STpbkX0m8LEZ+b
        OB5h+DeopA5p6wi5RsihqB0=
X-Google-Smtp-Source: AJdET5dm7nWgzUXzbGeBHApLoOjghNcJC1JVz1IBlk+090ICFimtqouEotG93feSifk/wEO4a3mkHg==
X-Received: by 2002:a0c:95b5:: with SMTP id s50mr12104750qvs.64.1542404208196;
        Fri, 16 Nov 2018 13:36:48 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:346d:9155:7c29:417f? ([2001:4898:8010:0:1da3:9155:7c29:417f])
        by smtp.gmail.com with ESMTPSA id f19sm17092623qkh.20.2018.11.16.13.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 13:36:47 -0800 (PST)
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
To:     sxenos@google.com, git@vger.kernel.org
Cc:     sbeller@google.com, jrn@google.com, jch@google.com,
        jonathantanmy@google.com, carl@ecbaldwin.net, dborowitz@google.com
References: <20181115005546.212538-1-sxenos@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <09ae3330-b6ba-3c42-7183-a40fe7aaf816@gmail.com>
Date:   Fri, 16 Nov 2018 16:36:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181115005546.212538-1-sxenos@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/14/2018 7:55 PM, sxenos@google.com wrote:
> From: Stefan Xenos <sxenos@google.com>
>
> This document describes what an obsolescence graph for
> git would look like, the behavior of the evolve command,
> and the changes planned for other commands.

Thanks for putting this together!

> diff --git a/Documentation/technical/evolve.txt b/Documentation/technical/evolve.txt
...
> +Git Obsolescence Graph
> +======================
> +
> +Objective
> +---------
> +Track the edits to a commit over time in an obsolescence graph.

The file name and the title are in a mismatch.

I'd prefer if the title was "Git Evolve Design Document" and this 
opening paragraph
was about the reasons we want a 'git evolve' command. Here is my attempt:

   The proposed 'git evolve' command will help users craft a 
high-quality commit
   history in their topic branches. By working to improve commits one at 
a time,
   then running 'git evolve', users can rewrite recent history with more 
options
   than interactive rebase. The core benefit is that users can pause 
their progress
   and move to other branches before returning to where they left off. 
Users can
   also share progress with others using standard 'push', 'fetch', and 
'format-patch'
   commands.

> +Background
> +----------

Perhaps you can call this "Example"?

> +Imagine you have three dependent changes up for review and you receive feedback
> +that requires editing all three changes. While you're editing one, more feedback
> +arrives on one of the others. What do you do?

"three dependent changes" sounds a bit vague enough to me to possibly 
confuse readers. Perhaps
"three sequential patches"?

> +- Users can view the history of a commit directly (the sequence of amends and
> +  rebases it has undergone, orthogonal to the history of the branch it is on).

"the history of a commit" doesn't semantically work, as a commit is an 
immutable Git object.

Instead, I would try to use the term "patch" to describe a change to the 
codebase, and that
takes the form as a list of commits that are improving on each other 
(but don't actually
have each other in their commit history). This means that the lifetime 
of a patch is described
by the commits that are amended or rebased.

> +- By pushing and pulling the obsolescence graph, users can collaborate more
> +  easily on changes-in-progress. This is better than pushing and pulling the
> +  changes themselves since the obsolescence graph can be used to locate a more
> +  specific merge base, allowing for better merges between different versions of
> +  the same change.

(Making a note so I come back to this. I hope to learn what you mean by 
this "more specific
merge base".)

> +
> +Similar technologies
> +--------------------
> ... It can't handle the case where you have
> +multiple changes sharing the same parent when that parent needs to be rebased

Perhaps this could be made more concrete by describing commit history 
and a specific workflow
change using 'git evolve'.

Suppose we have two topic branches, topic1 and topic2, that point to 
commits A and B,
respectively.Suppose further that A and B have a common parent C with 
parent D. If we rebase
topic1 relativeto D, then we create new commits C' and A' that are newer 
versions of commits
C and A. It would benice to easily update topic2 to be on a new commit 
B' with parent C'.
Currently, a user needs to knowthat C updated to C', and use 'git rebase 
--onto C' C topic2'.
Instead, if we have a marker showing thatC' is an updated version of C, 
'git log topic2'
would show that topic2 can be updated, and the 'gitevolve' command would 
perform the correct
action to make B' with parent C'.

(This paragraph above is an example of "what can happen now is 
complicated and demands that
the user keep some information in their memory" and "the new workflow is 
simpler and helps
users make the right decision". I think we could use more of these at 
the start to sell the
idea.)


> +and won't let you collaborate with others on resolving a complicated interactive
> +rebase.

In the same sentence, we have an even more complicated workflow 
mentioned as an aside. This
could be fleshed out more concretely. It could help describing that the 
current model is for
usersto share "!fixup" commits and then one performs an interactive 
rebase to apply those
fixups inthe correct order. If a user instead shares an amended commit, 
then we are in a
difficult state toapply those changes. The new workflow would be to 
share amended commits
and 'git evolve'inserts the correct amended commits in the right order.

I'm a big proponent of the teaching philosophy of "examples first". It's 
easier to talk
abstractlyafter going through some concrete examples.

>   You can think of rebase -i as a top-down approach and the evolve command
> +as the bottom-up approach to the same problem.

This comparison is important. Perhaps it is more specific to say 
"interactive rebase splits
a plan torewrite history into independent units of work, while evolve 
collects independent
units of workinto a plan to rewrite history."

> +
> +Several patch queue managers have been built on top of git...
> +
> +Replacements (refs/replace) are superficially...

These two paragraphs could be moved lower, under a "Semi-Related Work" 
section,
because they describe things that are a bit similar, but are unable to 
help us solve the
problem at hand.

> +
> +Goals
> +-----
> +Legend: Goals marked with P0 are required. Goals marked with Pn should be
> +attempted unless they interfere with goals marked with Pn-1.

I like the prioritization here.

> +P0. Any commit that may be involved in a future evolve command should not be
> +    garbage collected.

I wonder about the priority here. If we GC'd commit A but still have the 
newer A', I can
either thinkthat

1. We will no longer need to run 'git evolve', or
2. We run 'git evolve' on something that can reach A', but A' already 
contains all the
    informationwe need to produce a "final" commit A''.

I apologize that I'm not able to read the whole thing right now, and I 
will pick up reading
from here again soon. Hopefully the feedback above is constructive in 
the mean time.

Thanks,
-Stolee
