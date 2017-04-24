Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F1A5207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 20:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1173846AbdDXUDP (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 16:03:15 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34186 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162569AbdDXUDM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 16:03:12 -0400
Received: by mail-pf0-f177.google.com with SMTP id c198so17085679pfc.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ksnMGPLfmy4a4uit+WmcWVf65DOmiCwH4E+56TcohjU=;
        b=ShjzDFS/FwAmo/PuTt/djbHli90aZWimG+apoP/PsKFMcY/5QWkp+e6yNlplIbhPx5
         XyFAAAAdpC/+wrxmb4eVvGBAcDHe7BZ2+pV8WR/x4Yg2bdnNEXupjdRu2Vdy+rLaLaj9
         +IuAyGLgQH6znOSnYSVrOyugiCKf0jy9h4yDYaXrWcV/aByu0G7GGoAtogQ/ucux5z/u
         av6sCf3P/L8WyUa4lDZu8lhwa1R0UuxUQzhPmkvFhXHE5DQZFzpXCmPiTcq8geKdevu4
         O0iovRDhlAx9CWzaMNGGPAt9t/BSLL2cQjXudbjGp7pBfwzHG2MwpIGMhPxRhBgj5eeH
         T50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ksnMGPLfmy4a4uit+WmcWVf65DOmiCwH4E+56TcohjU=;
        b=pr4HpDYr+aNnJ0b4Imk1rMlXDyIusFpa08fKkTND3REx5oaIZmlK3bGpPPqmTH4ZwH
         SpTpK6Z5JXYqGUWzFqYI//3f86Oh9NekcobcehuDXxWXF2FMNQSJmxekWVb6v9TQ3J1z
         98y8+FQQ4A7gqphbuYE2h0geoQlkI+XB8AIREkTRPwX15MR4+IV+thgLobfDTx7daefq
         S7uyLCehFzN5iLPa2SbhqgjLpA18d1ljF5csZTgwjymrELvFyEoxpXqetnhcOHQW76GC
         MbFB3VVL0yv4XpIdYriAnync17QlZa8eL7hdjE3Iht82UPIZtdWPCZs2FaZwjgl0QU/3
         TnFA==
X-Gm-Message-State: AN3rC/5wLGVvJFEgxrSYoDM4nglmZ6wKtSjdGJHzkkfRzq9xqsuyvix0
        Q4WUI6trm3gS+BRyY0D5fAijc8fPwcwO
X-Received: by 10.84.248.76 with SMTP id e12mr22067716pln.76.1493064191766;
 Mon, 24 Apr 2017 13:03:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 24 Apr 2017 13:03:11 -0700 (PDT)
In-Reply-To: <20170422195804.18477-1-pc44800@gmail.com>
References: <CAGZ79kYmRe+NURkgxRQM2QsGQEqtp+oGas5H0ryfztx8s2chwA@mail.gmail.com>
 <20170422195804.18477-1-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Apr 2017 13:03:11 -0700
Message-ID: <CAGZ79kb1CR3qKOzByFC_wy7+Fh7cofFT1urhA06RuBK_3vGKmg@mail.gmail.com>
Subject: Re: [GSoC][RFC/PATCH v2] submodule: port subcommand foreach from
 shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The First function module_foreach first parses the options present in

s/First/first/

> The second function also takes care of the recursive flag, by creating
> a saperate child_process structure and prepending "--super-prefix displaypath",

 s/saperate/separate

> Additional env variable $sm_path was added, since it was used in
> test '"submodule foreach" from subdirectory' in t7407.
> I preferred adding this, instead of changing the test case, since
> in the case of git-submodule.sh, this env variable was accessible.

Makes sense. Though this explanation could go into the commit message as well.

> I checked-out the commit 1c4fb136db (submodule foreach: skip eval for
> more than one argument, 2013-09-27), which explains that why for
> the case when argc>1, we do not use eval. But since, we are calling the
> command in a separate shell itself for all values of argc, hence IMO,
> this case need not be considered separately.

Makes sense. Though this explanation could go into the commit message as well.

> I have observed that when we recursively run a command foreach
> submodule from a subdirectory, the $path variable as finally obtained
> by this patch differs with the $path variable as observed by the
> existing git-submodule code for a nested submodule.

Uh, then the recuring is still a bit broken.

> I'll again mention that I have based my branch on
> gitster/jk/ls-files-recurse-submodules-fix, since while
> using --super-prefix in recursively calling the foreach

Oops, missed that part. (Later in the reply I hint at the patch not
applying correctly, disregard that part.)

> Also, in the function foreach_submodule, we call gitmodules_config()
> to read values from the worktree .gitmodules and then look up
> the information (in this case only the sub->name) by using
> submodule_from_path funciton. Since we don't want to
> overwrite the null_sha1 entry, only loads from .gitmodules
> and avoid overlaying with .git/config.

The null_sha1 entry is there nevertheless.

> (also, since this whole process is required only to get the value
> og submodule's name, is there some other way by which we may obtain
> the value so as to avoid this step?)

Unfortunately this is the only way to get the name. But that's right, for
just getting the name we do not need the .git/config overlay as that
is not supposed to overwrite name/path mappings.

> As currently finally exams are going on in my college, I was unable to
> work on it much and the submission got delayed.

Good luck with the finals. :)

+
+ /* Only loads from .gitmodules, no overlay with .git/config */
+ gitmodules_config();

We should do the config loading/parsing not
in the inner looping function, but just once outside.

+
+ argv_array_pushf(&cp.env_array, "name=%s", sub->name);
+ argv_array_pushf(&cp.env_array, "path=%s", displaypath);
+ argv_array_pushf(&cp.env_array, "sm_path=%s", displaypath);

You mention keeping 'sm_path' in the notes after the commit message. I would
add that part to the commit message, to explain why we have multiple variables
that have the same value. Maybe even a comment in the code:

    /* Keep sm_path for historic reasons, see tests in 091a6eb0fee. */
    .. sm_path ..

+ argv_array_pushf(&cp.env_array, "sha1=%s", sub_sha1.buf);
+ argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
+
+ cp.use_shell = 1;
+ cp.dir = path;
+
+ for (i = 0; i < argc; i++)
+ argv_array_push(&cp.args, argv[i]);
+
+ strbuf_addstr(&file, path);
+ strbuf_addstr(&file, "/.git");

This could be oneline as:
        strbuf_addf(&file, "%s/.git", path);
+
+ if (!quiet && !access_or_warn(file.buf, R_OK, 0))
+ printf(_("Entering '%s'\n"), displaypath);
+
+ if (!access_or_warn(file.buf, R_OK, 0))

I do not think we'd want to warn about a missing .git file (which is what the
or_warn part does).

Instead I'd rather use the abstract function 'is_submodule_populated_gently'.

+ run_command(&cp);
+
+ if(recursive) {
+ struct child_process cpr = CHILD_PROCESS_INIT;
+
+ cpr.use_shell = 1;
+ cpr.dir = path;
+
+ argv_array_pushf(&cpr.args, "git");
+ argv_array_pushf(&cpr.args, "--super-prefix");
+ argv_array_push(&cpr.args, displaypath);
+ argv_array_pushf(&cpr.args, "submodule--helper");

No need for the 'f'ormat version of pusing strings if there is no formatting
going on. An alternative would be to push them all at once:

    argv_array_pushl(&cpr.args, "git", "--super-prefix", displaypath,
                     submodule--helper, NULL);

(The 'l' version of pushing accepts an arbitrary number of arguments until the
final NULL)


+ if (quiet)
+ argv_array_pushf(&cpr.args, "--quiet");
+
+ argv_array_pushf(&cpr.args, "foreach");
+ argv_array_pushf(&cpr.args, "--recursive");


+
+ for (i = 0; i < argc; i++)
+ argv_array_push(&cpr.args, argv[i]);
+
+ run_command(&cpr);

I'd think we'd need to react to the exit code here (and above), and even
stop early just as the shell version does. (To find out how it does so,
I used gitk, and followed the error line
  die "$(eval_gettext "Stopping at '\$displaypath'; script returned
non-zero status.")"
and right clicked on that line "Show origin of that line". There is a lot of
noise going on, e.g. i18n, path issues being fixed, and such, until you'd find
19a31f9c1a (git-submodule - Add 'foreach' subcommand, 2008-08-10), which
outlines more clearly its basic functionality:

    cmd_foreach()
    {
        git ls-files --stage | grep '^160000 ' |
        while read mode sha1 stage path
        do
            if test -e "$path"/.git
            then
                say "Entering '$path'"
                (cd "$path" && eval "$@") ||
                die "Stopping at '$path'; script returned non-zero status."
            fi
        done
    }

Note the && || operators, that act as
https://en.wikipedia.org/wiki/Short-circuit_evaluation


I do not think we would need the following block of code:

+ if (prefix) {
+ const char *out = NULL;
+ if (skip_prefix(prefix, list.entries[i]->name, &out)) {
+ if (out && out[0] == '/' && !out + 1)
+ return 0;
+ }
+ }

because 'module_list_compute' was given the 'prefix', such that the list only
contains list submodules within the 'prefix' area. However with the early
return inside, I wonder what this code is about? (If this is not about
scoping to the directory with prefix, maybe a comment could clarify?)

+ foreach_submodule(argc, argv, list.entries[i]->name,
+  list.entries[i]->oid.hash, prefix,
+  quiet, recursive);

As Junio suggests, the name of foreach_submodule can be improved.
Also as I think further about it, we may actually want to have 3
(instead of 2) functions:

* The outer-most function is what we have here except the for-loop.
  (i.e. it is the front-end function for "submodule--helper foreach")
* the actual looping function, as that can be re-used later from within
  C, then we would not need to spawn an extra submodule--helper, but
  could directly call the
    foreach_submodule(<list>, <function ptr>, <data ptr>)
* The inner-most function is what is currently named 'foreach_submodule'
  it "does one thing", in this case runa process in each submodule.

An example of such an approach is seen with the functions:
  'for_each_string_list(list, string_list_each_func_t, cb_data);'
  (not the macro ending in _item)
  'for_each_*' as found in cache.h

    int for_each_string_list(struct string_list *list,
                 string_list_each_func_t fn, void *cb_data)
    {
        int i, ret = 0;
        for (i = 0; i < list->nr; i++)
            if ((ret = fn(&list->items[i], cb_data)))
                break;
        return ret;
    }

That way we'd have a nice helper function in the future to iterate
over submodules with a given list.

--

The following hunk changed in upstream, which is why I could not apply
the patch.
The colliding commit is cf9e55f494 (submodule: prevent backslash expantion in
submodule names, 2017-04-07), which added just a "-r" to the "while
read mode..."

So if you'd rebase your work on top of the latest master, this will produce
a conflict as well for you.

+ git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix
"$prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet}
${recursive:+--recursive} "$@"

- toplevel=$(pwd)
-
- # dup stdin so that it can be restored when running the external
- # command in the subshell (and a recursive call to this function)
- exec 3<&0
-
..

Thanks,
Stefan
