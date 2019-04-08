Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B94CA20248
	for <e@80x24.org>; Mon,  8 Apr 2019 15:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfDHPrw (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 11:47:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39067 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfDHPrw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 11:47:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so17020230wrn.6
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w9sbCqn6HTh+hKqMPdZfHcvu+gljTQtppKJHCvtqzXQ=;
        b=HS6Fo3NwiDvHl2/fCQxDWO5MddMh1kyVcA7k/m/x806uYnwtgG69T89PhMIC3L3nHF
         hs+WDAG8dci4eTilCYSu8389mG7XEUjAnmEprx12KcBli5mRkEwMDhmCpJZVkxxVXF1W
         duQfylCEOYVzBt0zYlZmu4p8qcu8wCFMWp24Tg/55ty0Hf22Uz9gKbdlynXtvsqDWE/d
         GyMZGkxa87W2L46BAA6AZ/cG+Q5K0XFMQRlhtI2QzbE9JotC/l8QqrjPDYamIWwdsfer
         j2iAHOczZWbsYzsCToXX52/7LhoNT+JHTJS0fvTdE4xHgNzxgkOjaVJ60ryapTehgnx3
         SVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=w9sbCqn6HTh+hKqMPdZfHcvu+gljTQtppKJHCvtqzXQ=;
        b=JkzDoECzj/G2DSqKqn41JHMbAkHMzucIBvDa9J6Xi3MJ7/+dwB5J9NW/nvD301JbLB
         WjeZgu4wjm0XWjX8eAewOzYRNXvK84jXBP10dGZOkvb4FLZ6Pnjk0eCAlEoh6Q/kvSWU
         tvKDEs6j50FIZZhhfNrvDnICkPvuGS88rHiOQs4JLb6BES7lh8FubEvKXJuJwShDZa+X
         XgqOvh6r9T6bGyc1FaFHX5HmQJZ2U39arxexfe0SPBcNghRaVzLyZc2b2Fnl/G7f7XvY
         c4nHJwree4kOKlGHR/gUSt3Lmk8UxuWTIqUfzr7D9Zk6B8NHGE/khSkOabJ26BmOkand
         pV+A==
X-Gm-Message-State: APjAAAUznNYXygIzKYA0tCa+zK4mnGFHI8msQSX0ArHcd1CD3ENtCmu4
        3/YAGQJ+/HLvWNMd0xD6rZK7W6Sjll4=
X-Google-Smtp-Source: APXvYqws2IcHIihNoE//C37s9DGm9uskj5S/ANTeurBeMd1EKR4a7HEqxH3DWtqHtWCg227gScOhcQ==
X-Received: by 2002:a5d:63c5:: with SMTP id c5mr20221407wrw.82.1554738470541;
        Mon, 08 Apr 2019 08:47:50 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-29-11.as13285.net. [92.22.29.11])
        by smtp.gmail.com with ESMTPSA id v1sm43037169wrd.47.2019.04.08.08.47.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:47:49 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] commit/reset: try to clean up sequencer state
To:     Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
References: <20190329163009.493-1-phillip.wood123@gmail.com>
 <20190329163009.493-2-phillip.wood123@gmail.com>
 <CACsJy8D3tH0K8wNLighuNtjUtv3K3TGNMGgx3T5j5sCxok8hbQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9f3ec8b3-f2c4-63b8-3350-a37d42bebd47@gmail.com>
Date:   Mon, 8 Apr 2019 16:47:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8D3tH0K8wNLighuNtjUtv3K3TGNMGgx3T5j5sCxok8hbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/04/2019 11:09, Duy Nguyen wrote:
> On Fri, Mar 29, 2019 at 11:32 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When cherry-picking or reverting a sequence of commits and if the final
>> pick/revert has conflicts and the user uses `git commit` to commit the
>> conflict resolution and does not run `git cherry-pick --continue` then
>> the sequencer state is left behind. This can cause problems later. In my
>> case I cherry-picked a sequence of commits the last one of which I
>> committed with `git commit` after resolving some conflicts, then a while
>> later, on a different branch I aborted a revert which rewound my HEAD to
>> the end of the cherry-pick sequence on the previous branch. Avoid this
>> potential problem by removing the sequencer state if we're committing or
>> resetting the final pick in a sequence.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   branch.c                        |  7 +++++--
>>   builtin/commit.c                |  7 +++++--
>>   sequencer.c                     | 23 +++++++++++++++++++++++
>>   sequencer.h                     |  1 +
>>   t/t3507-cherry-pick-conflict.sh | 19 +++++++++++++++++++
>>   5 files changed, 53 insertions(+), 4 deletions(-)
>>
>> diff --git a/branch.c b/branch.c
>> index 28b81a7e02..9ed60081c1 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -5,6 +5,7 @@
>>   #include "refs.h"
>>   #include "refspec.h"
>>   #include "remote.h"
>> +#include "sequencer.h"
>>   #include "commit.h"
>>   #include "worktree.h"
>>
>> @@ -339,8 +340,10 @@ void create_branch(struct repository *r,
>>
>>   void remove_branch_state(struct repository *r)
> 
> This function is also called in git-am, git-rebase and git-checkout.
> While the first two should not be affected, git-checkout can be
> executed while we're in the middle of a cherry-pick or revert. I guess
> that's ok because git-checkout is basically the same as git-reset in
> this case?

Yes that's right

>>   {
>> -       unlink(git_path_cherry_pick_head(r));
>> -       unlink(git_path_revert_head(r));
>> +       if (!unlink(git_path_cherry_pick_head(r)))
>> +               sequencer_post_commit_cleanup();
>> +       if (!unlink(git_path_revert_head(r)))
>> +               sequencer_post_commit_cleanup();
>>          unlink(git_path_merge_head(r));
>>          unlink(git_path_merge_rr(r));
>>          unlink(git_path_merge_msg(r));
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 2986553d5f..422b7d62a5 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1657,8 +1657,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>                  die("%s", err.buf);
>>          }
>>
>> -       unlink(git_path_cherry_pick_head(the_repository));
>> -       unlink(git_path_revert_head(the_repository));
>> +       if (!unlink(git_path_cherry_pick_head(the_repository)))
>> +               sequencer_post_commit_cleanup();
>> +       if (!unlink(git_path_revert_head(the_repository)))
>> +               sequencer_post_commit_cleanup();
>>          unlink(git_path_merge_head(the_repository));
>>          unlink(git_path_merge_msg(the_repository));
>>          unlink(git_path_merge_mode(the_repository));
>> @@ -1678,6 +1680,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>          if (amend && !no_post_rewrite) {
>>                  commit_post_rewrite(the_repository, current_head, &oid);
>>          }
>> +
>>          if (!quiet) {
>>                  unsigned int flags = 0;
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 0db410d590..028699209f 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2220,6 +2220,29 @@ static ssize_t strbuf_read_file_or_whine(struct strbuf *sb, const char *path)
>>          return len;
>>   }
>>
>> +void sequencer_post_commit_cleanup(void)
>> +{
>> +       struct replay_opts opts = REPLAY_OPTS_INIT;
>> +       struct strbuf buf = STRBUF_INIT;
>> +       const char *eol;
>> +       const char *todo_path = git_path_todo_file();
>> +
>> +       if (strbuf_read_file(&buf, todo_path, 0) < 0) {
>> +               if (errno == ENOENT) {
>> +                       return;
>> +               } else {
>> +                       error_errno("unable to open '%s'", todo_path);
> 
> _() the string to make it translatable.

Well spotted, thanks

>> +                       return;
>> +               }
>> +       }
>> +       /* If there is only one line then we are done */
>> +       eol = strchr(buf.buf, '\n');
>> +       if (!eol || !eol[1])
>> +               sequencer_remove_state(&opts);
> 
> Should we say something to let the user know cherry-pick/revert is
> finished? (unless --quiet is specified)

I'd not thought of that, at the moment we don't say anything about 
removing CHERRY_PICK_HEAD etc when they are removed by reset or 
checkout, I'm not sure this is much different to those cases - but maybe 
they should be printing some feedback as well.

Best Wishes

Phillip

>> +
>> +       strbuf_release(&buf);
>> +}
>> +
>>   static int read_populate_todo(struct repository *r,
>>                                struct todo_list *todo_list,
>>                                struct replay_opts *opts)
