Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7687CC433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 13:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiF2NCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 09:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbiF2NC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 09:02:29 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A72139B9A
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 06:02:28 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z16so7055712qkj.7
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 06:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KSlXUvsjyHquC1J+wwe9KHMk5VxWhL0dnV/D7AfpNY8=;
        b=CwV2vsR14ZdN3kQqKBTvvnsyCGFgJnGiGsDz67TXcMMuyPgA81eYsgTib2ZlEr0pz/
         J5AJrrXhTScyaFCkQ5UyggLOjquMbLWrWYZCyxT7NVwR327GbyAzSUT6PqMIF87g/A3V
         c2XF34kY+Pt/LBbzAORr//TlNakBH5OgTlbmL1WFkuS0O1hIzmVA6AHGm6L+iqHyLGeJ
         Y0IZj6qpkWGucBX0QZTvL+N12XkTZc5Tx6syCI84YqhSwrhYNeRr3vf4vhrcADYIYgLZ
         kXfzazW3P0cvY0eH/OTfuyszKcF9DjUawN2nimOfqQHYYqPwzT/S6Kt64hcWgXggpUb9
         EO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KSlXUvsjyHquC1J+wwe9KHMk5VxWhL0dnV/D7AfpNY8=;
        b=lEtMYat/ITq6o9jfeiLQyJE78y3jx76LhMkhR1qFEc1SYbaz3JNhnCKQxEw7EInexD
         5qGJHK5U2FWaLMXfeWgdFK/4kYsW4e67PeI7AZMwrLnqWH2l5uFIFgUXj+DxDtF+VnOv
         yEQyF8F93RKd+n/6tw1wiPOapmSTf45YuvMmxWYGOrs3LkZ8P/BwxLPUctjVtpsthvAi
         WgouiTH5t4HQw0H/RxTpE8Gvs8Tmwgf7VoYNj0G9FSzkkusrtYNcPvjzHo56R26yKave
         HSQ9e6YdTSI/FNwDH/dv3/GjUbZUwZfdrz+Kz/J10kgrllEZMIdY4qqPG6Sa7fuOFpeQ
         LEKQ==
X-Gm-Message-State: AJIora9awopgtuH6pzzf16tIvteGRLWohfmTU9xdrqK93DPcoWnybnZB
        N8wwM0PzVufdnwzTAbdLT3wA
X-Google-Smtp-Source: AGRyM1v0N10/ovqysiHUgWOHM1+E+CmxFbXrDL0Vanwc/0dm+2LDYk7tRusYB80oARfRgJlJUp1jmw==
X-Received: by 2002:a37:a147:0:b0:6ae:eaea:e04 with SMTP id k68-20020a37a147000000b006aeeaea0e04mr1810041qke.133.1656507746621;
        Wed, 29 Jun 2022 06:02:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d803:95aa:58b0:8205? ([2600:1700:e72:80a0:d803:95aa:58b0:8205])
        by smtp.gmail.com with ESMTPSA id u3-20020a05620a454300b006aef6a244a4sm14216535qkp.129.2022.06.29.06.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 06:02:26 -0700 (PDT)
Message-ID: <eb4345ce-8e1c-2f5f-7dfb-41979a89491a@github.com>
Date:   Wed, 29 Jun 2022 09:02:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/8] rebase-interactive: update 'merge' description
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <669f4abd59e7dbb13281e85144d085180934fd15.1656422759.git.gitgitgadget@gmail.com>
 <xmqqletgijul.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqletgijul.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/22 5:00 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The 'merge' command description for the todo list documentation in an
>> interactive rebase has multiple lines. The lines other than the first
>> one start with dots ('.') while the similar multi-line documentation for
>> 'fixup' does not.
>>
>> The 'merge' command was documented when interactive rebase was first
>> ported to C in 145e05ac44b (rebase -i: rewrite append_todo_help() in C,
>> 2018-08-10). These dots might have been carried over from the previous
>> shell implementation.
> 
> The text indeed does come literally from the block removed by that
> commit.  I wondered if the shell "gettext" in git-i18n.sh had some
> magic in it, but it does not seem to have anything, and po/git.pot
> around that time has these lines with leading dots, so I suspect
> that they were quite deliberately added, not for the reasons of
> formatting machinery (e.g. preventing somebody in the dataflow from
> losing leading indentation), but to show them to the end users.
> 
> Unfortunately, the offending commit 4c68e7dd (sequencer: introduce
> the `merge` command, 2018-04-25) does not justify them X-<.
> 
>> Looking at the output in an editor, my personal opinion is that the dots
>> are unnecessary and noisy. Remove them now before adding more commands
>> with multi-line documentation.
> 
> I personally do not mind having them in the UI, but I can also be
> happy to see them go.  It is unlikely that any program is consuming
> these strings, so I would say this is a fairly safe clean-up.

Perhaps I should be a bit clearer that these are appearing in the
comment section of the todo-file when presented to the user for editing:

# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup [-C | -c] <commit> = like "squash" but keep only the previous
#                    commit's log message, unless -C is used, in which case
#                    keep only this commit's message; -c is same as -C but
#                    opens the editor
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
# .       create a merge commit using the original merge commit's
# .       message (or the oneline, if no original merge commit was
# .       specified); use -c <commit> to reword the commit message
#
# These lines can be re-ordered; they are executed from top to bottom.
#

This does not appear to be used anywhere else.

Thanks,
-Stolee
