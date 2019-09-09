Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7FE1F461
	for <e@80x24.org>; Mon,  9 Sep 2019 10:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfIIKox (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 06:44:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38918 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbfIIKox (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 06:44:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id q12so14072340wmj.4
        for <git@vger.kernel.org>; Mon, 09 Sep 2019 03:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vX9F5OLa8PP+P/V7Nru8Mq88CkydTSMrfb+TF0DwIJA=;
        b=LAAJ7gmQU6O42xfAPKNR65qr45vIWqrCHAxt6GAQMdHtYsQXyH7Rf8Ylx7RVNYoc3B
         DxrLxCTas1odWEevKRn+/E+6O7u/dC8LoK+tzhE5tQDY54OqEMOXKDJx+0KizXQ9fOR6
         eMYqf464gyXTtDqQhCkbSxxRnHpuApeQP2Spdoy9QR0EGql+1QuA1XEvlAX0IrDvF34s
         NBFDuPiMci9G7MWEzDPgTxulgLZCASs2YbsbIKJBWdYerS4jpHscHah2L5ifHjmR/6ej
         KhaHoLqE2Ml6ongEfc8ll4UJboz+4zfF2lwsMmF/IgZBZ48yPjxYMaYUmO1SaRZ+47xE
         YuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vX9F5OLa8PP+P/V7Nru8Mq88CkydTSMrfb+TF0DwIJA=;
        b=tP6HHLCALhgrbqv6Vb3swYS1+vhzPSHghS/X8CuTEuMFCQNnqeTygMUhQPjtraUkAa
         Hl2+47rnCTUtqDx95XPbf9X0SuFMcfxephNETRUCtCJHbckpB3siUogymNl2FAjV6kef
         UBLG2PeGr3AyclP9by/ZbUZ5WYHBpEIjyfzCc0y9J+PKM3lR5xCfNm3blV7sETM24aeh
         +E+/4LGPrUWuzUhxAA3f/qgTD3VmE2R/00tzGSHE7Tk77nIw6wMeCly5EwgZZJ2QgceZ
         5xS6CEJecfsonxCESWYkLnUIQakzjxUSWJMkvyISLNRd+QxmBDaZKaSfOk5s5zX3q4FZ
         Muxw==
X-Gm-Message-State: APjAAAXK3kHL8cd0ChUr+ZNUGxpjLb9uOo0Ga4cHjWvEr4XiOUOj0I00
        sDRkunMZkAeVDgkzkdVDBCw=
X-Google-Smtp-Source: APXvYqxIzwF+okKEWD0USF8/u9Iv5acUHiGrn07EYpg/6JvEVBoheHm4yp0Lew9wtemiwmcr1YOIlw==
X-Received: by 2002:a1c:1f44:: with SMTP id f65mr17790183wmf.11.1568025890620;
        Mon, 09 Sep 2019 03:44:50 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-0-86.as13285.net. [92.22.0.86])
        by smtp.gmail.com with ESMTPSA id h12sm11650777wrt.16.2019.09.09.03.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 03:44:50 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] rebase: introduce --update-branches option
To:     Warren He <pickydaemon@gmail.com>, johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, wh109@yahoo.com
References: <nycvar.QRO.7.76.6.1909031345330.46@tvgsbejvaqbjf.bet>
 <20190907234413.1591-1-wh109@yahoo.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <31a37eb1-8a75-40f7-7d1c-a8b7b9d75f92@gmail.com>
Date:   Mon, 9 Sep 2019 11:44:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190907234413.1591-1-wh109@yahoo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Warren

On 08/09/2019 00:44, Warren He wrote:
> Everyone in this thread, thanks for your support and encouragement.
> [...]
>> It should not really imply `--interactive`, but `--rebase-merges`.
> 
> `imply_interactive` doesn't fully switch on `--interactive`, i.e., causing the
> editor to open. It only selects the backend, which I think we're saying is the
> right thing. I've dropped the `-i` from the test description.
> 
> And we don't really have to imply --rebase-merges, in case someone would prefer
> to linearize things, which who knows? Running that non-rebase-merges command in
> the example scenario from my original post should give something like this:

I think it would probably be less confusing to default to preserving 
merges and having an option to turn that off - people are going to be 
surprised if their history is linearized.

> ```
>   A - B              (master)
>         \
>           F          (feat-f)
>             \
>               E      (feat-e)
>                 \
>                   H  (my-dev)
> ```
> 
> So for now I haven't moved the implementation into `make_script_with_merges`.
>
 > [...]>
>> [handling `fixup`/`squash` chains]
> 
> I've moved `todo_list_add_branch_updates` to run before
> `todo_list_rearrange_squash`. The rearranging pulls fixups out, causing the
> branch update to "fall" onto the items before, and reinserts them between a
> commit and its branch update, casing them to be included in the updated branch.
> which is my opinion of the right thing to do. I've added a test about this with
> the following scenario:
> 
> ```
>   A - B  (master)
>     \
>       I - J - fixup! I                 (fixup-early)
> 		      \
> 			K - fixup! J  (fixup-late)
> ```
> 
> which results in the following todo list with `--autosquash`:
> 
> ```
> pick 9eadc32 I
> fixup 265fa32 fixup! I
> pick a0754fc J
> fixup e7d1999 fixup! J
> exec git branch -f fixup-early
> pick c8bc4af K
> ```

That makes sense I think

>> I'd like to suggest [`test_cmp_rev`] instead
> 
> I've updated the test to use `test_cmp_rev`. It's not with your suggested
> invocation though. We don't update the `C` tag. I've referred to the rebased `C`
> with `test_cmp_rev linear-early HEAD^` and similar for the other checks.

That sounds right

> * * *
> 
> And then there's the discussion about using `exec git branch -f`. To summarize
> the issues collected from the entire thread:
> 
> 1. the changes aren't atomically applied at the end of the rebase
> 2. it fails when the branch is checked out in a worktree
> 3. it clobbers the branch if anything else updates it during the rebase
> 4. the way we prepare the unprefixed branch doesn't work right some exotic cases
> 5. the reflog message it leaves is uninformative
> 
> For #4, I think we've lucked out actually. The `load_ref_decorations` routine we
> use determines that a ref is `DECORATION_REF_LOCAL` under the condition
> `starts_with(refname, "refs/heads/")` (log-tree.c:114, add_ref_decoration), so
> `prettify_refname` will find the prefix and skip it. But that's an invariant
> maintained by two pieces of code pretty far away from each other.
> 
> For #5, for the convenience of readers, the reflog entry it leaves looks like this:
> 
> ```
> 00873f2 feat-e@{0}: branch: Reset to HEAD
> ```
> 
> Not great.
> 
> I haven't made any changes to this yet, but I've thought about what I want. My
> favorite so far is to add a new todo command that just does everything right. It
> would make a temparary ref `refs/rewritten-heads/xxx` (or something), and update
> `refs/heads/xxx` at the end.

I think that's the best way to do it. If we had a command like 'branch 
<branch-name>' that creates a ref to remember the current HEAD and saves 
the current branch head. Then at the end rebase can update the branches 
to point to the saved commits if the branch is unchanged. If the rebase 
is aborted then we don't end up with some branches updated and others not.

Side Note
   I'd avoid creating another worktree local ref refs/rewritten-heads/.
   Either store them under refs/rewritten/ or refs/worktree/

Best Wishes

Phillip

> 
> I agree that requiring a separate update-ref step at the end of the todo list is
> unfriendly. Manually putting in some branch update commands and then realizing
> that they weren't applied would be extremely frustrating. I don't see the option
> of using existing tools as the easiest-to-use solution.
> 
> I'm reluctant to combine this with the existing `label` command. So far it
> sounds like we generally want to be more willing to skip branch updates while
> performing the rebase, with aforementioned scenarios where something else
> updates the branch before we do, or if the branch becomes checked out in a
> worktree. We don't want to mess up the structure of a `rebase -r` as a result of
> skipping some branch updates. I think it would be conceptually simpler and
> implementation-wise less tricky if we didn't combine it with the `label` and
> `reset` system.
> 
> Warren He (1):
>    rebase: introduce --update-branches option
> 
>   Documentation/git-rebase.txt      |  9 ++++
>   builtin/rebase.c                  | 11 ++++-
>   sequencer.c                       | 58 +++++++++++++++++++++++-
>   sequencer.h                       |  6 ++-
>   t/t3431-rebase-update-branches.sh | 94 +++++++++++++++++++++++++++++++++++++++
>   5 files changed, 173 insertions(+), 5 deletions(-)
>   create mode 100755 t/t3431-rebase-update-branches.sh
> 
