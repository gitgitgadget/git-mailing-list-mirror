Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E2F81F7D2
	for <e@80x24.org>; Sun,  4 Jun 2017 10:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbdFDKck (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 06:32:40 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:35273 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbdFDKcg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 06:32:36 -0400
Received: by mail-ua0-f172.google.com with SMTP id y4so63529276uay.2
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 03:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8B6TgqhjzXJpDIioM5Zv9f5oU2CkUCfovGk72OqZNko=;
        b=aNG16fuJLRM290bXVO9QgYdAdiiE0/BnajKJc0C85g5hpnVtRofKUQxmRtLIjlkuQ9
         Vftkdj8kqvqUdavPRHgwkvpLYX+2uNP13BsmsKoIbF8uT8QQ5ofInVZgfhyloBUBYEqz
         PGhtgNsg2HSfB5GhsE+a+D+6d9gZaZxjDOO4vE3paesC9fRosn1f6CR7309EkP7tbGwC
         z54WxoZpjzJzQ/Njv03mB6Ps0o+6bEiQCrQtZcjdUJOFuOqeLzk5OKJLfMLVEUfUebEX
         dfSU+khECQKrLP/16WFOVL/CKHjGC1ep5aDiq2LWUeV3vmRsjMAe11Dc2fBf31yrefh9
         H2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8B6TgqhjzXJpDIioM5Zv9f5oU2CkUCfovGk72OqZNko=;
        b=MXebNjRRsN8e8osx9zmas8rM3pf27sfn/Z6H9lxUl0UdrJG+cloDgSo5fb8pQfdUnQ
         GVH3S7SM5RkiJEuvs3HhP0imNj8ERz4LxlKpYtLtAuvgGgxdqzyLGjhNCrWrYLYKEBmn
         UhqL3ttCRFAVX4hBfDYj0i9u6bXrUCi3NhZTruVM+X+8JAF6PVha/qLySm2tKBkDRWv3
         KddsjCDMJTsa7ToDMHd50FBKeMfL5iebOt41B/oyI0njCw+BgJUwpkS5yGEwE8bvKk5+
         Juz9KSVKWviyGy7o+enH/YC3V9IYQ2ifZMzTGtHdeMP1jj1lINoMHPtmSMT0k7jutIag
         xR9A==
X-Gm-Message-State: AODbwcDCRa9y0gfOuW2Prx8k5CWJbdQgkReT1hfO1Qf5KvSmrx1lvxYn
        7w7R9ED8ARM4FZwCCzxPLMzfa713z5X5
X-Received: by 10.176.69.163 with SMTP id u32mr2485280uau.69.1496572349474;
 Sun, 04 Jun 2017 03:32:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.81.205 with HTTP; Sun, 4 Jun 2017 03:32:29 -0700 (PDT)
In-Reply-To: <CAGZ79kbDpyO5uRCPnhCWmaFKhyLEUN7mYO9PhU3xF0f=W35ofw@mail.gmail.com>
References: <48149a4a-c7e3-d70e-7894-369681587372@ramsayjones.plus.com>
 <20170602112428.11131-1-pc44800@gmail.com> <20170602112428.11131-2-pc44800@gmail.com>
 <CAGZ79kbDpyO5uRCPnhCWmaFKhyLEUN7mYO9PhU3xF0f=W35ofw@mail.gmail.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Sun, 4 Jun 2017 16:02:29 +0530
Message-ID: <CAME+mvUSGAFbN5j-_hv7QpAS57hq4wgH+yZ7XJMPuyQN1gALaA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v6 2/2] submodule: port subcommand foreach from
 shell to C
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Christian Couder <christian.couder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 3, 2017 at 7:43 AM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Jun 2, 2017 at 4:24 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
>> This aims to make git-submodule foreach a builtin. This is the very
>> first step taken in this direction. Hence, 'foreach' is ported to
>> submodule--helper, and submodule--helper is called from git-submodule.sh.
>> The code is split up to have one function to obtain all the list of
>> submodules. This function acts as the front-end of git-submodule foreach
>> subcommand. It calls the function for_each_submodule_list, which basically
>> loops through the list and calls function fn, which in this case is
>> runcommand_in_submodule. This third function is a calling function that
>> takes care of running the command in that submodule, and recursively
>> perform the same when --recursive is flagged.
>>
>> The first function module_foreach first parses the options present in
>> argv, and then with the help of module_list_compute, generates the list of
>> submodules present in the current working tree.
>>
>> The second function for_each_submodule_list traverses through the
>> list, and calls function fn (which in case of submodule subcommand
>> foreach is runcommand_in_submodule) is called for each entry.
>>
>> The third function runcommand_in_submodule, generates a submodule struct sub
>> for $name, value and then later prepends name=sub->name; and other
>> value assignment to the env argv_array structure of a child_process.
>> Also the <command> of submodule-foreach is push to args argv_array
>> structure and finally, using run_command the commands are executed
>> using a shell.
>>
>> The third function also takes care of the recursive flag, by creating
>> a separate child_process structure and prepending "--super-prefix displaypath",
>> to the args argv_array structure. Other required arguments and the
>> input <command> of submodule-foreach is also appended to this argv_array.
>>
>
> Is the commit message still accurate?
> You describe the changes between the versions below the --- line,
> that is not recorded in the permanent commit history.
>
> In the commit message is less important to write "what" is happening,
> because that can easily be read from the patch/commit itself, but rather
> "why" things happen, such as design choices, maybe:
>
>     This aims to make git-submodule foreach a builtin. This is the very
>     first step taken in this direction. Hence, 'foreach' is ported to
>     submodule--helper, and submodule--helper is called from git-submodule.sh.
>
>     We'll introduce 3 functions, one that is exposed to the command line
>     and handles command line arguments, one to iterate over a set of
>     submodules, and finally one to execute an arbitrary shell command
>     in the submodule.
>
>     Attention must be paid to the 'path' variable, see 64394e3ae9
>     (git-submodule.sh: Don't use $path variable in eval_gettext string,
>     2012-04-17) details. The path varialbe is not exposed into the environment
>     of the invoked shell, but we just give "path=%s;" as the first argument.
>
>     We do not need to condition on the number of arguments as in 1c4fb136db
>     (submodule foreach: skip eval for more than one argument, 2013-09-27)
>     as we will run exactly one shell in the submodules directory.
>
>     Sign-off-...
>
>>
>> Other than that, additionally the case of no. of arugments in <command>
>> being equal to 1 is also considered separetly.
>> THe reason of having this change in the shell script was given in the
>> commit 1c4fb136db.
>> According to my understanding, eval "$1" executes $1 in same shell,
>> whereas "$@" gets executed in a separate shell, which doesn't allow
>> "$@" to access the env variables $name, $path, etc.
>> Hence, to keep the ported function similar, this condition is also
>> added.
>
> This paragraph would be a good candidate for the commit message, too.
> However as we rewrite it in C, we will spawn exactly one shell no matter
> how many arguments we have (well for 0 we have no shell, but for 1 or more
> arguments we'll spawn exactly one shell?)
>

I was trying to explaing the condition of the code in git-submodule.sh,
before porting. To be more clear, I meant that when we run the command
eval "$1", it runs in the same shell in which the cmd_foreach has been running,
unlike in the case of "$@", in which case, the command in executed in a separate
shell.

>> +       } else if (prefix) {
>> +               struct strbuf sb = STRBUF_INIT;
>> +               char *displaypath = xstrdup(relative_path(path, prefix, &sb));
>> +               strbuf_release(&sb);
>> +               return displaypath;
>
> Note to self (or any other that is interested in long term clean code):
>     I have seen this pattern a couple of times, a strbuf just to appease
>     the argument list of relative_path.
>     (init_submodule, prepare_to_clone_next_submodule,
>     resolve_relative_path in submodule--helper
>     cmd_rev_parse in builtin/rev-parse
>     connect_work_tree_and_git_dir in dir.c
>     write_name_quoted_relative in quote.c
>     get_superproject_working_tree in submodule.c
>     cmd_main in test-path-utils;
>     actually all uses of this function :( )
>     We should really make a relative_path function that can work
>     without the need of a strbuf, maybe just wrap the 3 lines into a new
>     function, or remove the strbuf from the argument list.
>     (The potential memleak is horrible to fix though. But as seen here
>     we could just always return an allocated string and
>     mandate the caller to free it)
>
>> +struct cb_foreach {
>> +       int argc;
>> +       const char **argv;
>> +       const char *prefix;
>> +       unsigned int quiet: 1;
>> +       unsigned int recursive: 1;
>> +};
>> +#define CB_FOREACH_INIT { 0, NULL, NULL, 0, 0 }
>> +
>> +static void runcommand_in_submodule(const struct cache_entry *list_item,
>> +                                   void *cb_data)
>
> As we only ever use list_item->name, we could also change
> the argument list to take a "const char *[submodule_]path".
>
>> +       prepare_submodule_repo_env(&cp.env_array);
>> +       cp.use_shell = 1;
>> +       cp.dir = list_item->name;
>> +
>> +       if (info->argc == 1) {
>> +               argv_array_pushf(&cp.env_array, "name=%s", sub->name);
>> +               argv_array_pushf(&cp.env_array, "sm_path=%s", displaypath);
>> +               argv_array_pushf(&cp.env_array, "sha1=%s",
>> +                                oid_to_hex(&list_item->oid));
>> +               argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
>> +
>> +               argv_array_pushf(&cp.args, "path=%s; %s", list_item->name,
>> +                                info->argv[0]);
>
> In the argc != 1 case we also want to have the env_array filled with
> useful variables. (It seems we do not have tests for that?)
> To test for that we'd need a test similar as in 1c4fb136d,
> just with
>     git submodule foreach echo \$sm_path \$dpath
> for example.
>
> So I think you can move the pushes to the env array outside this condition.
> As we set cp.use_shell unconditionally, we do not need to construct
> the first argument specially with path preset, but instead we can just prepend
> it in the array:
>
>     argv_array_pushf(&cp.env_array, "name=%s", sub->name);
>     ... // more env stuff
>
>     argv_array_pushf(&cp.args, "path=%s;", list_item->name);
>     for (i = 0; i < info->argc; i++)
>         argv_array_push(&cp.args, info->argv[i]);
>
> should do?
>
>
Yes, even I think this is what should be done. But for the given code,

if test $# -eq 1
then
    eval "$1"
else
    "$@"
fi &&

in case when $# is not equal to 1,
the <command> "$@" gets executed in a separate shell and hence could not
access the $name, $path, $toplevel, $sha1 variables.
Infact, it can be observed, that the output of the <command>
echo \$name is something bogus and not the submodule's name.

Also, in the given test suite, the env variables are used only in those
cases where no. of arguments is one.

Hence, to keep the ported code similar to the privious one, such an
additional case of argc == 1 needs to be considered.

Thanks,
Prathamesh Chavan
