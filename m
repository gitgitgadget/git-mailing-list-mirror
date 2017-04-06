Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD0171FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 20:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754028AbdDFUss (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 16:48:48 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33169 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbdDFUsq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 16:48:46 -0400
Received: by mail-vk0-f44.google.com with SMTP id d188so54245341vka.0
        for <git@vger.kernel.org>; Thu, 06 Apr 2017 13:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m1BeKA4fZrmIbTI6B1iM5zsOKzdK/2KDELyTBME6PM0=;
        b=k7nu1qizGpBGXBrbghJfMlnIpeIvzGH/Udnm0ylOeyMZjT/BppfEC8MoD/7HX3I2r6
         RxOKzQ2Lqzqf1e1vj75ouMtViQkI8dUe2vAk1iD6JBO8LyXrxSH9VlK69cdQ6HaRwzCQ
         o/KRxnRAAJIH+bRopKKAkKIATnkq3w2FebGXGXCvCCGDWnwMjNuLh1bu3XGn0EYlOMeN
         dFwKxTEhMa29IuCoLR4pPQTL8+l6lm+v1spDEQK246Y4dNgvs8ceTfI5JyJW0wS1iepg
         9RRVA32BH3kOLdyg//JVtoZheuEoTLsioCahBdIYh4rrJPI/ugUFG05GCmdmySsb1YFN
         vHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m1BeKA4fZrmIbTI6B1iM5zsOKzdK/2KDELyTBME6PM0=;
        b=lgb3Y6Bbd4x7eCQWpPg7ko/N9OdgIq3ZWYpBVnp4ETWKTg6yo0NQTQZUqZqYVQWgy9
         IHYWNYxbWuzqwz9iERLan+xwD++rNxLiDLCkIhRqcfPEbXeMQ6eTqVBdxGTxDf1CKvoD
         mdAUpKfGUqg9fnvGZ6xJs+1Gd50873CpqMtEdy48kFHQF3kqEwEvY4mIaVYF6kvAKBxK
         s5iWNIwyOuaNmq5di86BZgMjodjR5U1P0kD16vlYWh3QUSLjnCWTohcazZcJKncbb9sW
         wR0uy96fgFtEy9slh7iF/er0SBZeb+pVIiGGNnEq3XTBNMtZOG+XOKmDH8FVb1Y4kyMk
         mLhg==
X-Gm-Message-State: AN3rC/7xTDZAQhdNuNy/2TtRcb6kVM+ydTxuYoYaNn3o0PNlL5AgkHgwGx/OdnnD6Dlcpx2d4rTfYFvBBaeQpw==
X-Received: by 10.159.36.39 with SMTP id 36mr2063259uaq.84.1491511725413; Thu,
 06 Apr 2017 13:48:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.0.193 with HTTP; Thu, 6 Apr 2017 13:48:45 -0700 (PDT)
In-Reply-To: <CAGZ79kYULEaVYFX6_HGJi=CEA1E3Z8i4sKw+8bMaVsqiyWsuGw@mail.gmail.com>
References: <20170406060053.4453-1-pc44800@gmail.com> <CAGZ79kYULEaVYFX6_HGJi=CEA1E3Z8i4sKw+8bMaVsqiyWsuGw@mail.gmail.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Fri, 7 Apr 2017 02:18:45 +0530
Message-ID: <CAME+mvXbhW9Ya=FZEA8AmWihdn5ROVx6zAbsNYCEUEBY9p-wVQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v1] Disallow git commands from within unpopulated submodules
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> A couple of weeks back I floated a similar proposal of a patch[1], but
> as far as I remember Peff hinted that it is a bad UI to do it on such a
> generic early level[2]. And you also mention here that we'd not affect
> git-diff or other commands that do not have RUN_SETUP set.
>
> [1] https://public-inbox.org/git/20170119193023.26837-1-sbeller@google.com/
> [2] from the same thread as [1]:
>   https://public-inbox.org/git/20170120191728.l3ne5tt5pwbmafjh@sigill.intra.peff.net/
>
> And I agree with Peff here that this high level catching is not the best way to
> go. Rather we'd have to go through each command, e.g. in git-status I could
> imagine it could look like: (white space mangled):
>
>     diff --git a/builtin/commit.c b/builtin/commit.c
>     index 4e288bc513..e3c44d4ac4 100644
>     --- a/builtin/commit.c
>     +++ b/builtin/commit.c
>     @@ -1328,6 +1328,23 @@ static int git_status_config(const char *k,
> const char *v, void *cb)
>          return git_diff_ui_config(k, v, NULL);
>      }
>
>     +static void print_warning_inside_submodule(int status_format,
> const char *prefix)
>     +{
>     +    switch (status_format) {
>     +    case STATUS_FORMAT_UNSPECIFIED: /* fall through */
>     +    case STATUS_FORMAT_NONE:     /* fall through */
>     +    case STATUS_FORMAT_LONG:
>     +        printf(_("\n\nWARNING: \n\nIn uninitialized submodule
> '%s'\n\n\n"), prefix);
>     +    case STATUS_FORMAT_SHORT:
>     +        printf(_("WARNING: In uninitialized submodule '%s'\n"), prefix);
>     +    case STATUS_FORMAT_PORCELAIN:
>     +        /* cannot encode the warning in porcelain v1. */
>     +        break;
>     +    case STATUS_FORMAT_PORCELAIN_V2:
>     +        printf("# WARNING prefix in submodule\n");
>     +    }
>     +}
>     +
>      int cmd_status(int argc, const char **argv, const char *prefix)
>      {
>          static struct wt_status s;
>     @@ -1380,6 +1397,9 @@ int cmd_status(int argc, const char **argv,
> const char *prefix)
>          read_cache_preload(&s.pathspec);
>          refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
> &s.pathspec, NULL, NULL);
>
>     +    if (prefix && check_prefix_inside_submodule(prefix))
>     +        print_warning_inside_submodule(status_format, prefix);
>     +
>          fd = hold_locked_index(&index_lock, 0);
>
>          s.is_initial = get_sha1(s.reference, oid.hash) ? 1 : 0;
>
Yes, even after finishing my patch and finding out that it doesn't work
for various commands, high level catching doesn't seems correct. Also
after you mention in the status command itself, as we don't expect it to
error out in every case, hence making the change in every command
individually will be an appropriate choice. Also in this way, we can also
include the case of git-diff and also for the non-bultin commands.

>>
>> +#define MODULE_LIST_INIT { NULL, 0, 0 }
>
> I'd keep this initializer macro near the definition, i.e. in the header
> (compare to STRBUF_INIT or STRING_LIST_INIT_* for example),
> as this can then be used where ever we can use the data structure.
>
I was a little confused about its location too. But I agree with you
that as it can be used where ever we can later, keeping it in
header will be more appropriate.

>> +void check_prefix_inside_submodule(const char *prefix)
>
> I think we'll need this function in returning way, i.e.
>
>     int check_prefix_inside_submodule(const char *prefix)
>     {
>         ... do check ...
>         return result;
>     }
>
>> +{
>> +       struct module_list list = MODULE_LIST_INIT;
>> +       int i;
>> +
>> +       if (read_cache() < 0)
>> +               die(_("index file corrupt"));
>> +
>> +       for (i = 0; i < active_nr; i++) {
>> +               const struct cache_entry *ce = active_cache[i];
>> +
>> +               if (!S_ISGITLINK(ce->ce_mode))
>> +                               continue;
>> +
>> +               ALLOC_GROW(list.entries, list.nr + 1, list.alloc);
>> +               list.entries[list.nr++] = ce;
>> +               while (i + 1 < active_nr &&
>> +                       !strcmp(ce->name, active_cache[i + 1]->name))
>> +                        /*
>> +                         * Skip entries with the same name in different stages
>> +                         * to make sure an entry is returned only once.
>> +                         */
>> +                       i++;
>> +       }
>
> The code up to here seems to be partially duplicate of
> submodule--helper.c#module_list_compute().
>
> At first I tried coming up with a nice code deduplication (i.e. put
> the essential parts as a function somewhere), but I think this doesn't
> make sense from an algorithmic point of view, because this runs in O(n)
> of active_cache.
>
> active_cache is sorted by (1st) alphabet and (2nd) the index stage.
> The second sorting is why we have the while loop with the comment
> in the code.

Sorry, I was unaware about the active_cache being sorted, hence went
for linear search.

>
> The problem we are trying to solve here, is "Does the active_index contain
> prefix?", which can be done in O(log n) with a binary search, because
> active_index is sorted by alphabet.
>
> So I am not sure how much code we can reuse here. nevertheless:
>
>> +       for(i = 0; i < list.nr; i++) {
>
> Style nit: We prefer a whitespace between a control statement
> (for, if, while) and the opening parens, i.e. "for (i = .."
>
>> +               if(strlen((*list.entries[i]).name) ==  strlen(prefix)) {
>
> (*list.entries[i]).name
>
> can be simplified. The dereference *, combined with an access
> of the struct member can be done as ->.
> (*foo).bar is equal to foo->bar.
>
>> +               }
>> +               else if(strlen((*list.entries[i]).name) ==  strlen(prefix)-1) {
>
> The Git coding style prefers to have the closing brace and the else
> on the same line:
>
>         ..
>     } else if (..) {
>         ..
>

Sorry for being sloppy with the coding style. In all my future patches
I'll make sure I learn from all the mistakes I made so far and also
be more careful.

>
>> +                       const char *out = NULL;
>> +                       if(skip_prefix(prefix, (*list.entries[i]).name, &out)) {
>> +                               if(strlen(out) == 1 && out[0] == '/')
>
> The strlen operation can take quite long potentially (O(n) with n the
> length of out).
> So you could put the cheaper operation first, or the following would
> check the same
> without having to compute the length:
>
>     if (out && out[0] == '/' && !out + 1)
>         ..
>
>> +                                       die(_("command from inside unpopulated submodule '%s' not supported."), (*list.entries[i]).name);
>
> Once we have this function inside each command, we can be more precise
> the error message. :)

Thanks for all the advices on this patch. I'll implement the above changes
in a new patch series.
The approach that I'll take will be as follows:
1. Create function check_prefix_inside_submodule which returns value
   accordingly. Also this function is implemented by checking the active_cache
   list and checking if it prefix is present in active_cache[i]->name,
   using binary search.
   Also is there some other way which is more quicker than searching
   for the prefix in the cache?
2. Individually call this in each command after the git environment is set
   and options are parsed.
3. Apply this change for appropriate options only, as suggested above for
   the status command.
This will ensure more accuracy.
I have also mentioned to work on this BUG in my git proposal as well, but I
kept it in my wishlist section. Hence, I'll continue to work on this as my time
permits. Currently, I'm also working on converting the git-submodule
subcommand 'foreach' from script to builtin, by first converting it
to a function in submodule--helper.c and then later converting it
to builtin.

Thanks,
Prathamesh Chavan
