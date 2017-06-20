Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55361FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 05:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750987AbdFTFnk (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 01:43:40 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36359 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbdFTFnj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 01:43:39 -0400
Received: by mail-pf0-f182.google.com with SMTP id x63so64469132pff.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 22:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SqP6W5mDsicpm5X2LgaSPDIHoxQP+tlr0Z6XDt9Hekw=;
        b=a/ARhmxt3v2sanb7K14l0+FGLOvVognNYN1ORxwAtSVSEv7UXL+Z9lXKvNdOfNdwAj
         nAl7zdvXwefwpNwICzclJvd6h+mQkrVv2lq8UlTNhY3Xth4PDADCL6uPnJgGPm4blSEb
         /BzH7/WcJAIgmdYQA/NKDs4LuK9p7R7oJvFVEb3kksJbvJVwb9NaIq2N3JcWqybvY4rC
         tmPiGdjmXN8100Uq9aBTSRPc/CU5IyrKSsiZQSi+NkEJ/FIohTmV7OVkgLYJGYT9lDsR
         GHeWlVFMC2U8l+zGoSsabWJNuPaIMV/Uds+bo7x4vSyaZ+ZrgHAfpw2h0Ve0tlvz1NWJ
         bHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SqP6W5mDsicpm5X2LgaSPDIHoxQP+tlr0Z6XDt9Hekw=;
        b=ktN5pS2sXF8RMIwQ3AiIF+upomK6dEhyTDJksnX4gfPCg3zMdeHigaPu9i/nC9v0+/
         E8UDDcL9m5IGwfiEEFTDKmUwqsyBTDdgWNoa9gUqKNgFg/xXYq1sPRZQbXhRiOo8Wf4J
         uqSNBPwDvr1D5LXB11+XnGADtxy5n+ROHgWd+KoSYeoxH/0+JRQQ4Di7ANX3ZP7TGXKG
         76MFJ2FWRjcmgh2Ly/EviGmgSjBSbl4wtUyoZ0xCnAkqQuoHTqaKq3aAiSXtX9OpNgAh
         df2UdH1YuemtzhZm7I155ODtr0ibiFjtwYNg2Sj3JrjVJNCIGA+UDj7gXT1qSioy7F4Y
         Xznw==
X-Gm-Message-State: AKS2vOx1tupWG/bplbvq3bzT5pR9GMel8Y7Rinq3Jl/dns0YDLoZPhll
        qID4VKlJTqmyrdis2H/RDLARgyX9e3tX
X-Received: by 10.98.63.10 with SMTP id m10mr28579779pfa.19.1497937418074;
 Mon, 19 Jun 2017 22:43:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 19 Jun 2017 22:43:37 -0700 (PDT)
In-Reply-To: <20170619202021.dmomy5ztwoeat3eg@hopa.kiewit.dartmouth.edu>
References: <20170619155924.7ra2vwvaelr2yj2v@hopa.kiewit.dartmouth.edu>
 <CAGZ79kZhj31eBYnboyxDLuFp1ceeqk8kj0nrnQaCmpRJCVFU4w@mail.gmail.com> <20170619202021.dmomy5ztwoeat3eg@hopa.kiewit.dartmouth.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Jun 2017 22:43:37 -0700
Message-ID: <CAGZ79kbVAfhgqug=UVXwriwxtckB0=x7mgxetVnQA2JFA0DYPg@mail.gmail.com>
Subject: Re: in case you want a use-case with lots of submodules
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 1:20 PM, Yaroslav Halchenko <yoh@onerussian.com> wrote:
>
> On Mon, 19 Jun 2017, Stefan Beller wrote:
>
>> On Mon, Jun 19, 2017 at 8:59 AM, Yaroslav Halchenko <yoh@onerussian.com> wrote:
>> > Hi All,
>
>> > On a recent trip I've listened to the git minutes podcast episode and
>> > got excited to hear  Stefan Beller (CCed just in case) describing
>> > ongoing work on submodules mechanism.  I got excited, since e.g.
>> > performance improvements would be of great benefit to us too.
>
>> If you're mostly interested in performance improvements of the status
>> quo (i.e. "make git-submodule fast"), then the work of Prathamesh
>> Chavan (cc'd) might be more interesting to you than what I do.
>> He is porting git-submodule (which is mostly a shell script nowadays)
>> to C, such that we can save a lot of process invocations and can do
>> processing within one process.
>
> ah -- cool.  I would be eager to test it out, thanks!  would be
> interesting to see if it positively affects our overall performance.
> Pointers to that development would be welcome!

The latest from today:
https://public-inbox.org/git/CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com/


>
>> > http://datasets.datalad.org ATM provides quite a sizeable (ATM 370
>> > repositories, up to 4 levels deep) hierarchy of git/git-annex
>> > repositories all tied together via git submodules mechanism.  And as the
>> > collection grows, interactions with it become slower, so additional
>> > options (such as --ignore-submodules=dirty  to status) become our
>> > friends.
>
>> I am not as much concerned about the 370 number than about the
>> 4 layers of nesting. In my experience the nested submodule case
>> is a little bit error prone and the bug reports are not as frequent as
>> there are not as many users of nesting, yet(?)
>
> well -- part of the story here is that we are forced to use/have full
> blown .git/ directories (for git-annex symlinks to content files to
> work) within submodules instead of .git file with a reference under
> parent's .git/modules.   So we can 'slice' at any level and I
> guess that is why may be avoiding some possibly issues due to nesting
> and the "parent has all .git/modules" approach.

That sounds like you either want to configure to have the submodules
git dirs in-place or you want to convince git-annex to learn about the
gitdir pointer files.

>
>> In a neighboring thread on the mailing list we have a discussion
>> on the usefulness of being on branches than in detached HEAD
>> in the submodules.
>> https://public-inbox.org/git/0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de/
>
>> This would not break non-ambiguously, rather it would add
>> ease of use.
>
> that is indeed a common caveat... I am not sure if any heuristic
> approach would provide a 'bullet proof' solution.  I might even prefer a
> hardcoded 'branch-name' to be listed/associated with each submodule
> within .gitmodules.

hardcoded as submodule.NAME.branch, maybe?
https://git-scm.com/docs/gitmodules

>  In the datalad case, detached HEAD is common

So you are accustomed to detached HEADs and would not
gain much from being back on a branch?  That's cool, too.


> whenever someone installs "outdated" (branch of which progressed
> forward) submodule.  In this case we just check if the branch after "git
> clone"  (but before git submodule update) includes the pointed by
> Subproject commit, and if so -- we announce that it must be the branch
> (so far it is always "master" branch anyways ;) )

heh, having just one branch. That is retro-style. :)
