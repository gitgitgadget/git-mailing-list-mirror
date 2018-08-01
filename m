Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31C741F597
	for <e@80x24.org>; Wed,  1 Aug 2018 10:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbeHAMJY (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 08:09:24 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:48566 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387723AbeHAMJX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 08:09:23 -0400
Received: from [192.168.2.240] ([92.22.30.174])
        by smtp.talktalk.net with SMTP
        id koIhftBFqpXFjkoIhfWoVm; Wed, 01 Aug 2018 11:24:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533119056;
        bh=PuVVdDi3AF5HEif3PtLb4Bic1G24bSHO69bwr3krLwA=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BRVvNGZVdu0ztwOwwB0rP24CtcBXUMN74XlRpZCzr7w23LXQXKKrcpbP5peN9SRdR
         XkeD4u8kCl5yeHvei2kBaMUuwOxIkfcbQktvCxEL/vsqhff/9LN1wTdLpI8XtPGc0W
         y8muikAUuNiDeyuE26VHO9KFnfQ1I5wT6AMmyMu8=
X-Originating-IP: [92.22.30.174]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=2xfjePbNG5I+/HyESt+5YA==:117
 a=2xfjePbNG5I+/HyESt+5YA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=A1X0JdhQAAAA:8 a=5rxgeBVgAAAA:8 a=BCjA09oAAAAA:8 a=evINK-nbAAAA:8
 a=Z3erzKvndqz3Wo2g1dsA:9 a=ey6Lr-eOs8tbhO5-:21 a=3yhO4u0h5hjlo2bF:21
 a=QEXdDO2ut3YA:10 a=Df3jFdWbhGDLdZNm0fyq:22 a=PwKx63F5tFurRwaNxrlG:22
 a=jYKBPJSq9nmHKCndOPe9:22 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] sequencer: fix quoting in write_author_script
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180731111532.9358-1-phillip.wood@talktalk.net>
 <20180731111532.9358-3-phillip.wood@talktalk.net>
 <CAPig+cR5VHP8muo5_A_9t7OPZam8O_uPb0nd73B15Ye92n+p7Q@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <22f98273-f7f4-adf3-1a8b-b0e4ec6029b3@talktalk.net>
Date:   Wed, 1 Aug 2018 11:24:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cR5VHP8muo5_A_9t7OPZam8O_uPb0nd73B15Ye92n+p7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKeoEqkZPluWCy73I+pFnCSzlzgx9QSF1ygvfkqmx38jPF2uxLg/0HGN8k5cdrXeGDxzLs4/1w6YKKPrsGNuz1evb1KUfWuTtbk5/YIP9yJ4YDAfWcpp
 IICVjed+bYHITupJOWWxLpNgtTgxpYNuNb3CHEEvBrjYoSWq6+eR7VJ8M5Dc0y5VKuaTWuqzIQZvZ2bt6sNlTfFQJVFbWixMBLdM073+y/jvopTv5oOVWNoA
 KOlsjuUw19PZLdCXIcoiq7wY8mNdW9NjS0aUwi97b+sIWgeOBHxflX8Dm4hT7pZbU4uLsOKtZA6xSjH7Q9bsWQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

On 31/07/18 22:39, Eric Sunshine wrote:
> On Tue, Jul 31, 2018 at 7:15 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>> Single quotes should be escaped as \' not \\'. Note that this only
>> affects authors that contain a single quote and then only external
>> scripts that read the author script and users whose git is upgraded from
>> the shell version of rebase -i while rebase was stopped. This is because
>> the parsing in read_env_script() expected the broken version and for
>> some reason sq_dequote() called by read_author_ident() seems to handle
>> the broken quoting correctly.
> 
> Is the:
> 
>      ...for some reason sq_dequote() called by read_author_ident()
>      seems to handle the broken quoting correctly.
> 
> bit outdated? We know now from patch 2/4 of my series[1] that
> read_author_ident() wasn't handling it correctly at all. It was merely
> ignoring the return value from sq_dequote() and using whatever broken
> value came back from it.

Yes you're right, when I tested it before I must of had GIT_AUTHOR_NAME 
set to the name with the "'" in it when I ran the rebase because it 
appeared to work, but actually sj_dequote() was returning NULL and so 
commit_tree() just picked up the default author. I've just changed the 
test you added to

test_expect_success 'valid author header after --root swap' '
	rebase_setup_and_clean author-header no-conflict-branch &&
	set_fake_editor &&
	git commit --amend --author="Au ${SQ}thor <author@example.com>" 
--no-edit &&
	git cat-file commit HEAD | grep ^author >expected &&
	FAKE_LINES="5 1" git rebase -i --root &&
	git cat-file commit HEAD^ | grep ^author >actual &&
	test_cmp expected actual
'

and it fails without the fixes to write_author_script().

> 
> [1]: https://public-inbox.org/git/20180731073331.40007-3-sunshine@sunshineco.com/
> 
>> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>> diff --git a/sequencer.c b/sequencer.c
>> @@ -664,14 +664,25 @@ static int write_author_script(const char *message)
>>   static int read_env_script(struct argv_array *env)
>>   {
>>          if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
>>                  return -1;
> 
> This is not a problem introduced by this patch, but since
> strbuf_read_file() doesn't guarantee that memory hasn't been allocated
> when it returns an error, this is leaking.

I can fix that

>> +       /*
>> +        * write_author_script() used to fail to terminate the GIT_AUTHOR_DATE
>> +        * line with a "'" and also escaped "'" incorrectly as "'\\\\''" rather
>> +        * than "'\\''". We check for the terminating "'" on the last line to
>> +        * see how "'" has been escaped in case git was upgraded while rebase
>> +        * was stopped.
>> +        */
>> +       sq_bug = script.len && script.buf[script.len - 2] != '\'';
> 
> I think you need to be checking 'script.len > 1', not just
> 'script.len', otherwise you might access memory outside the allocated
> buffer.

Good catch, Johannes's original was checking script.buf[script.len - 1] 
which I corrected but forget to adjust the previous check.

> This is a very "delicate" check, assuming that a hand-edited file
> won't end with, say, an extra newline. I wonder if this level of
> backward-compatibility is overkill for such an unlikely case.

Yes, it is a bit fragile. Originally the patch just unquoted the correct 
and incorrect quoting but Johannes was worried that might lead to errors 
and suggested this check. The check is aimed at people whose git gets 
upgraded while rebase is stopped for a conflict resolution or edit and 
so have the bad quoting in the author-script from the old version of git 
which started the rebase. Authors with "'" in the name are uncommon but 
not unheard of, I think when I checked there were about half a dozen in 
git's history. I'm not sure what to do for the best.

>>          for (p = script.buf; *p; p++)
>> -               if (skip_prefix(p, "'\\\\''", (const char **)&p2))
>> +               if (sq_bug && skip_prefix(p, "'\\\\''", &p2))
>> +                       strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
>> +               else if (skip_prefix(p, "'\\''", &p2))
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> @@ -75,6 +75,22 @@ test_expect_success 'rebase --keep-empty' '
>> +test_expect_success 'rebase -i writes correct author-script' '
>> +       test_when_finished "test_might_fail git rebase --abort" &&
>> +       git checkout -b author-with-sq master &&
>> +       GIT_AUTHOR_NAME="Auth O$SQ R" git commit --allow-empty -m with-sq &&
>> +       set_fake_editor &&
>> +       FAKE_LINES="edit 1" git rebase -ki HEAD^ &&
> 
> Hmph, -k doesn't seem to be documented in git-rebase.txt. Is it needed here?

-k is short for --keep-empty which is needed as the test creates an 
empty commit to check the author (I think that is to avoid changing the 
tree  - Johannes wrote that bit).

Thanks for your comments, I'll do a reroll

Phillip
