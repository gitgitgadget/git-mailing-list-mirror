Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26C3D1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 20:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933505AbeFUUdo (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 16:33:44 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41062 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933179AbeFUUdm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 16:33:42 -0400
Received: by mail-vk0-f67.google.com with SMTP id 128-v6so2660288vkf.8
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 13:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t70+HSDy/G7uiQaH1nFCF+GxcDA41ZzifEPH7Eja+is=;
        b=b5idKhbgYlH69KApUw6n1kqz5d2FBiEMVLDI2xqMhOTJV2+PitB6pWGaNUdj3fpwyh
         33iB/KynXzhy2pwHrjVMulscoUBMh7sVEUgP/orT0GyeVDcqQz1q9q6RFkFUtfCRLaM5
         nk2/jOvaVMmM6wfXc76BbYAKR5X/NuYASlXfUXuUxyKmdcIakiCatGir2T6ndYdIuqXx
         Y5ncQZUfqM8X9ZccNRLxCyBP0bGUCkGOtNvg8ywnwf91KRl6OJdA99049xV0y+qvj1sM
         VV60exZz8rOxMY0dk4ky7Qkk7t7iTZF7W6E7Ps+fl5pWLy420eI12qXFuG3BdemzEwcw
         f/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t70+HSDy/G7uiQaH1nFCF+GxcDA41ZzifEPH7Eja+is=;
        b=MLnl+qtFmNW9/m7ocBm0qHjjQ4hqgDC9F4uH03+5Rr7ofmDtSIsA2lS4IsoauC78TV
         bnEnApRaU0Yl2QZy6Qz2bnHOXiCYxATIwfYrI7kD75/guphOIxCI2NqMpVfJGkPuxoLi
         RUFkZP5OXRbW0xhMl8e9IA6DT1ckwcfzeBPBvUWCyZPF8lf/vQSCI+oG8s2bHnrTYOC1
         OdSCLzDdWQ4SDoF86EAnE7U20OLTP5PoiZP4TPqSJpFcnPXTlgRr3LfiGMJyXUVPi+Ea
         /lKq36JBOP5GTJmxRdgfvzzqTPoMEOBxbAqzj7O4lmLjym1dPnny39oAB8P1qAH4UOVu
         zB9g==
X-Gm-Message-State: APt69E0WIwTIrFgDzCnYwJatv0SE9tIFm2fIZK2i+yz7MVhQkxNf9i/i
        GJ/GFHJRvS0G7jr0yhyaPwBXmr2ligtCNtb1nH8=
X-Google-Smtp-Source: ADUXVKKn/nwoySNtXNCflEx+TiiJZiTetHD2DZBRPQIfRvwEh88RvroKRgrv9reaDczGGNMQmMxJnXniCgE78OEnvcU=
X-Received: by 2002:a1f:4e81:: with SMTP id c123-v6mr14841918vkb.184.1529613221663;
 Thu, 21 Jun 2018 13:33:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 13:33:41
 -0700 (PDT)
In-Reply-To: <xmqq4lhvudjt.fsf@gitster-ct.c.googlers.com>
References: <20180617055856.22838-1-newren@gmail.com> <20180621150023.23533-1-newren@gmail.com>
 <20180621150023.23533-2-newren@gmail.com> <xmqq4lhvudjt.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Jun 2018 13:33:41 -0700
Message-ID: <CABPp-BGjCVAdUd0EDz3CNH=ymZYv1a29sER2zHHrVoOgJ38bBw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] git-rebase.txt: document incompatible options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 21, 2018 at 12:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> @@ -280,8 +286,10 @@ other words, the sides are swapped.
>>  +
>>  Because 'git rebase' replays each commit from the working branch
>>  on top of the <upstream> branch using the given strategy, using
>> -the 'ours' strategy simply discards all patches from the <branch>,
>> +the 'ours' strategy simply empties all patches from the <branch>,
>
> I think overall the direction this series takes, and especially what
> this step does---clarify what the current code & design does first
> before attempting to improve the status quo, makes sense, but I had
> trouble justifying this change.  Do you want to emphasize that the
> operation discards the changes but still leaves empty commits, and
> "discards all patches" imply there won't be any commits left on top
> of the "onto" point?

Yes, is there an alternative wording that you'd find more clear?

(Also, I'd like to push to make rebase -i/-m behave the same as
am-based rebase with empty commits, meaning they are just discarded by
default rather than halted at.  But I haven't gotten to that point...)

>> @@ -487,6 +510,52 @@ recreates the topic branch with fresh commits so it can be remerged
>>  successfully without needing to "revert the reversion" (see the
>>  link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details).
>>
>> +INCOMPATIBLE OPTIONS
>> +--------------------
>> +
>> +git-rebase has many flags that are incompatible with each other,
>> +predominantly due to the fact that it has three different underlying
>> +implementations:
>> +
>> + * one based on linkgit:git-am[1] (the default)
>> + * one based on linkgit:git-merge-recursive[1] (merge backend)
>> + * one based on linkgit:git-cherry-pick[1] (interactive backend)
>> +
>> +Flags only understood by the am backend:
>> +
>> + * --committer-date-is-author-date
>> + * --ignore-date
>> + * --whitespace
>> + * --ignore-whitespace
>> + * -C
>> +
>> +Flags understood by both merge and interactive backends:
>> +
>> + * --merge
>> + * --strategy
>> + * --strategy-option
>> + * --allow-empty-message
>> +
>> +Flags only understood by the interactive backend:
>> +
>> + * --[no-]autosquash
>> + * --rebase-merges
>> + * --preserve-merges
>> + * --interactive
>> + * --exec
>> + * --keep-empty
>> + * --autosquash
>> + * --edit-todo
>> + * --root when used in combination with --onto
>> +
>> +Other incompatible flag pairs:
>> +
>> + * --preserve-merges and --interactive
>> + * --preserve-merges and --signoff
>> + * --preserve-merges and --rebase-merges
>> + * --rebase-merges and --strategy
>> + * --rebase-merges and --strategy-option
>> +
>>  include::merge-strategies.txt[]
>
> It is a bit unclear what these lists want to say.  If --ignore-date
> is only understood by "rebase" and not "rebase -i", wouldn't that
> make "--interactive and --ignore-date" an incompatible flag pair?
> Or do you mean the "Other incompatible" list to enumerate the ones
> that are explicitly rejected, as opposed to getting silently
> ignored?

Yes, --interactive and --ignore-date are an incompatible flag pair but
I didn't want to list all 65 of those pairs explicitly.  Anything that
only works by being passed to git-am is incompatible with anything
that implies the --merge or --interactive backends.

The list becomes simpler once we nuke git-rebase--merge.sh,
implementing it atop git-rebase--interactive.sh (which comes in a
separate series that depends on this one).

> In any case, I'll need to read through the remainder of the series
> to come to any conclusion, but given that -p is getting killed by
> its primary author, with help from others to split out its
> implementation from the --interactive codepath, it might be a bad
> time to do this series.  Thanks for working on this topic.

This series doesn't conflict with ag/rebase-p at all; it merges
cleanly with next and pu.  The follow-on work to nuke
git-rebase--merge.sh, however, does conflict so I'm waiting on
(re-)sending it.
