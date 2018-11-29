Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9DD3211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 23:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeK3K0N (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 05:26:13 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:33588 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbeK3K0N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 05:26:13 -0500
Received: by mail-ed1-f41.google.com with SMTP id r27so3369610eda.0
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 15:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WZLJy85W4FPQoOvPcG9PTPvCSPUP9SUro/i+VLYQbvw=;
        b=DFEqrf/XUdQCADj3Aco4nZgfiAvkAr6FOTYvR4z1wqvr4am/Htd4GW7hf4sjotdHox
         JfBv6mB9oT/lfKSm+W/UroKPTXztWmhMhYiTtRxSh8dnqOY4ORGYpGuGcwK8bfeTldnW
         OzGllVTUB0TDNzVllzENSp+3qC7OWNnlpQ/fR8FsyHHlT8kXhIuwwjlLl90A6o3rw4YR
         P6RRCp+D9LFH1vyWAeyDJBg3X/mpSXQqhC3Yb2OMeBzIOZQdym2ZV6oB5K5A5pmhbBS1
         zlBszhNJLRbavfIQgqxqZyTuCgzKNl74AHR+GT2rI1OhnuHQrqyrKhVG+CgsM6qIcGFy
         Q6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WZLJy85W4FPQoOvPcG9PTPvCSPUP9SUro/i+VLYQbvw=;
        b=UOOYcoINmQDmdu6ZTiYYbIhan1v6B269wq32eLyG+OpmJ5OT+FsIbyorrK6tU2bmKQ
         YHckG/i6aBaBeqmq4x6sLp2fnsgUg1idcjkw8V5lN2W/d965NwaqFFJO9np8toS8o7oc
         oPiog6o46VALstiUSl8k7nyS9llxpHNH7NB4Xo8VWA5RwI0s6rhYCCuL+gOr7lxn7KUB
         bjW0FDgbnda7jHltfAEOLs4yVoSBrF8TW1rfHYlVp0Gk+bt+USHk5nBCb2c9ZQt5SHjD
         +1PafGeVpscTDsQ7XLlmxZE5L/Be8pffenQYsZvqKXjZsaL4U+XaFCljvjlm3xIjwlLT
         8tlQ==
X-Gm-Message-State: AA+aEWbcseITKP8IS8TwqfE7on6ZDeuWe82M1BkAgwrc+8f4+StGL+RP
        N60rFQQJF+lEwnB3C5c17BjvpLVP
X-Google-Smtp-Source: AFSGD/XQEiXuL8Pmrl7VoqTGFySVKbtLbU1W8c9prrAL8r+SMcZ3ULQj/+bu7iFH+bIO5XV6W78TuA==
X-Received: by 2002:a17:906:3193:: with SMTP id 19-v6mr3024996ejy.134.1543533540192;
        Thu, 29 Nov 2018 15:19:00 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id t26sm982058eda.22.2018.11.29.15.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:18:58 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        t.gummerer@gmail.com, sxenos@google.com,
        Elijah Newren <newren@gmail.com>,
        Dan Fabulich <dan@fabulich.com>,
        Santiago Perez De Rosso <sperezde@csail.mit.edu>,
        Daniel Jackson <dnj@csail.mit.edu>
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com> <87pnunxz5i.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87pnunxz5i.fsf@evledraar.gmail.com>
Date:   Fri, 30 Nov 2018 00:18:57 +0100
Message-ID: <87o9a7xyji.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 29 2018, Ævar Arnfjörð Bjarmason wrote:

> On Thu, Nov 29 2018, Nguyễn Thái Ngọc Duy wrote:
>
>> v3 sees switch-branch go back to switch-branch (in v2 it was
>> checkout-branch). checkout-files is also renamed restore-files (v1 was
>> restore-paths). Hopefully we won't see another rename.
>>
>> I'll try to summarize the differences between the new commands and
>> 'git checkout' down here, but you're welcome to just head to 07/14 and
>> read the new man pages.
>>
>> 'git switch-branch'
>>
>> - does not "do nothing", you have to either switch branch, create a
>>   new branch, or detach. "git switch-branch" with no arguments is
>>   rejected.
>>
>> - implicit detaching is rejected. If you need to detach, you need to
>>   give --detach. Or stick to 'git checkout'.
>>
>> - -b/-B is renamed to -c/-C with long option names
>>
>> - of course does not accept pathspec
>>
>> 'git restore-files'
>>
>> - takes a ref from --from argument, not as a free ref. As a result,
>>   '--' is no longer needed. All non-option arguments are pathspec
>>
>> - pathspec is mandatory, you can't do "git restore-files" without any
>>   pathspec.
>>
>> - I just remember -p which is allowed to take no pathspec :( I'll fix
>>   it later.
>>
>> - Two more fancy features (the "git checkout --index" being the
>>   default mode and the backup log for accidental overwrites) are of
>>   course still missing. But they are coming.
>>
>> I did not go replace "detached HEAD" with "unnamed branch" (or "no
>> branch") everywhere because I think a unique term is still good to
>> refer to this concept. Or maybe "no branch" is good enough. I dunno.
>
> I finally tracked down
> https://redfin.engineering/two-commits-that-wrecked-the-user-experience-of-git-f0075b77eab1
> which I'd remembered reading and couldn't find again in these
> discussions. Re-reading it while one may not 100% agree with the
> author's opinion, it's an interesting rabbit hole.
>
> I also didn't know about EasyGit, or that Elijah Newren had written
> it. I haven't seen him chime in on this series, and would be interested
> to see what he thinks about it.
>
> Re the naming question in
> https://public-inbox.org/git/87o9abzv46.fsf@evledraar.gmail.com/ &
> seeing that eg-switch exists, I wonder if just s/switch-branch/switch/
> makes more sense.
>
> Assuming greenfield development (which we definitely don't have), I
> don't like the "restore-files" name, but the alternative that makes
> sense is "checkout". Then this "--from" argument could become "git
> checkout-tree <treeish> -- <pathspec>", and we'd have:
>
>     git switch <branchish>
>     git checkout <pathspec>
>     git checkout-tree <treeish> -- <pathspec>
>
> Or maybe that sucks, anyway what I was going to suggest is *if* others
> think that made sense as a "if we designed git today" endgame whether we
> could have an opt-in setting where you set e.g. core.uiVersion=3 (in
> anticipation of Git 3.0) and you'd get that behavior. There could be
> some other setting where core.uiVersion would use the old behavior (or
> with another setting, only warn) if we weren't connected to a terminal.
>
> I.e. I'm thinking of this as step #2 in a #3 step series. Where this is
> the fully backwards compatible UI improvement, but someone who'd
> e.g. use EasyGit or didn't have backwards compatibility concerns could
> enable step #3 and opt-in to a mode where we'd fixed a bunch of UI warts
> in a backwards-incompatible way.
>
> What would that mode look like? I'd to work on piling that on top of
> this :)

(Digging some more)

There's also more interesting prior art at https://gitless.com/ (CC'd
authors) and 2x research papers linked at the bottom of that page which
were briefly discussed on-list before:
https://public-inbox.org/git/20160930191413.002049b94b3908b15881b77f@domain007.com/

The "gitless" UI has a "gl checkout" which just takes paths as I was
musing about above (and that Redfin post also suggests).
