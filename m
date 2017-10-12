Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D17320372
	for <e@80x24.org>; Thu, 12 Oct 2017 16:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755575AbdJLQcN (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 12:32:13 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:49411 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755476AbdJLQcL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 12:32:11 -0400
Received: by mail-qt0-f178.google.com with SMTP id k31so14680211qta.6
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R95Zb8JTQArJhgFJ28r/hr+SswZkY7w58ytUX5nJKMc=;
        b=UPSmYWYptjP9QS+YkQjz2ZJnoK6rujCHzjnAvYfwIqzF2ShEhVC5oziJqPHqtMj30j
         jkpFA8P7svzaM6QGl8qp6MDsrxMzCYDs3kRXuP5kaO1JqK9wTmfPHgzLNf1xHner17P0
         FSfPup/3BKsT0CZ6aMCdS2iNw1J7SeEmAUgm5wz0hNKtwBqwiXhN5+0nGpL5jo5CS8sf
         Vx2XeMKBhE8NEeEp/NUGAhw8rltHFKFkxKIN1kxUynRXXizfLcwyZTXUfXsv0DmGXJ60
         iTyyeXuCW3HQ3OTgfw6kn0U5TOzVAlbJfwcyizklHPs69+wO0opmwizT1PRGTJZI47lu
         OYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R95Zb8JTQArJhgFJ28r/hr+SswZkY7w58ytUX5nJKMc=;
        b=o6kyscrnqtOWTT6iRz9b9EBkoLn2NNQwmhQ04/g3yWsdBk9dczKdodJAoWBFkwdzsT
         cexkKYr1ZoAy5CeO5vCUJYWb7/HNtOfIQeWqw70iYpe+FV5dJwMIkYQkW7/Mdjpzrm6K
         5WwLgS2AywxGRUHguxdTNsUPsu1Qx5hQjHDvTDXOB0ngzZRqv2pIFEdwTmEoePai8LB0
         yctURYfb//hNshtSshf0EYNoO1KwNYo1iRlu8D53egPSR3WPqERAEYfc9ypPEmYyl3dx
         SMQo4mVsvNuJ5fNo9IQsH9UnXrqOFlZBeGmSqD/8VR0T3fiLvJFFK5FQWR9RPDQ25oNL
         588A==
X-Gm-Message-State: AMCzsaUqDZPgo83LBqL+fl0iqJ7tQDmBx7dEfG/+LOjWG3v9liTW4Hpg
        cTXHf38UFam7iIr1PY/rjfBDWvAznFprR9lII2o=
X-Google-Smtp-Source: AOwi7QBfscLbYr/4izFs9uO/iO3yTnh+o9amk3SZAU8DQcfvJaL4jdqMEZ1I4g3iHNBfAhY2fqtrsKZ0imBQMlcgA78=
X-Received: by 10.200.15.183 with SMTP id b52mr4639139qtk.45.1507825929937;
 Thu, 12 Oct 2017 09:32:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.101.178 with HTTP; Thu, 12 Oct 2017 09:32:09 -0700 (PDT)
In-Reply-To: <CAK7vU=0wbGsFCXmwmCc-XX9K07UF_OZ7tFa4_GVb-H7fxakssg@mail.gmail.com>
References: <CAK7vU=0ztEwMPsGO4Cd1A5JEnxmwkF57QPKjjvjD8rBUB79dRA@mail.gmail.com>
 <CAGZ79kaBJnXW=rSiKuHpds79mXVL0Aoo+PBa0a5V-C_bop=Kbg@mail.gmail.com>
 <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
 <CAK7vU=22W9mYdSnw_LP2uWYyKZuTzF0JgTVWCX+nMhUnLjQ_Cw@mail.gmail.com>
 <xmqqh8v5ls8i.fsf@gitster.mtv.corp.google.com> <CAK7vU=0wbGsFCXmwmCc-XX9K07UF_OZ7tFa4_GVb-H7fxakssg@mail.gmail.com>
From:   Marius Paliga <marius.paliga@gmail.com>
Date:   Thu, 12 Oct 2017 18:32:09 +0200
Message-ID: <CAK7vU=0A_nf2bAgV6dQyiesLJ3HHs5guyfNSNTwzYzgS2+YeWg@mail.gmail.com>
Subject: Re: Enhancement request: git-push: Allow (configurable) default push-option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        christian.couder@gmail.com, peff@peff.net,
        thais.dinizbraz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject: [PATCH] Added support for new configuration parameter push.pushOption

builtin/push.c: add push.pushOption config

Currently push options need to be given explicitly, via
the command line as "git push --push-option".

The UX of Git would be enhanced if push options could be
configured instead of given each time on the command line.

Add the config option push.pushOption, which is a multi
string option, containing push options that are sent by default.

When push options are set in the system wide config
(/etc/gitconfig), they can be unset later in the more specific
repository config by setting the string to the empty string.

Add tests and documentation as well.

Signed-off-by: Marius Paliga <marius.paliga@gmail.com>
---
 Documentation/git-push.txt |  3 +++
 builtin/push.c             | 11 ++++++++++-
 t/t5545-push-options.sh    | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3e76e99f3..da9b17624 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -161,6 +161,9 @@ already exists on the remote side.
     Transmit the given string to the server, which passes them to
     the pre-receive as well as the post-receive hook. The given string
     must not contain a NUL or LF character.
+    Default push options can also be specified with configuration
+    variable `push.pushOption`. String(s) specified here will always
+    be passed to the server without need to specify it using `--push-option`

 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
diff --git a/builtin/push.c b/builtin/push.c
index 2ac810422..f761fe4ba 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -32,6 +32,8 @@ static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;

+static struct string_list push_options = STRING_LIST_INIT_DUP;
+
 static void add_refspec(const char *ref)
 {
     refspec_nr++;
@@ -503,6 +505,14 @@ static int git_push_config(const char *k, const
char *v, void *cb)
         int val = git_config_bool(k, v) ?
             RECURSE_SUBMODULES_ON_DEMAND : RECURSE_SUBMODULES_OFF;
         recurse_submodules = val;
+    } else if (!strcmp(k, "push.pushoption")) {
+        if (v == NULL)
+            return config_error_nonbool(k);
+        else
+            if (v[0] == '\0')
+                string_list_clear(&push_options, 0);
+            else
+                string_list_append(&push_options, v);
     }

     return git_default_config(k, v, NULL);
@@ -515,7 +525,6 @@ int cmd_push(int argc, const char **argv, const
char *prefix)
     int push_cert = -1;
     int rc;
     const char *repo = NULL;    /* default repository */
-    struct string_list push_options = STRING_LIST_INIT_DUP;
     const struct string_list_item *item;

     struct option options[] = {
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 90a4b0d2f..2cf9f7968 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -140,6 +140,54 @@ test_expect_success 'push options and submodules' '
     test_cmp expect parent_upstream/.git/hooks/post-receive.push_options
 '

+test_expect_success 'default push option' '
+    mk_repo_pair &&
+    git -C upstream config receive.advertisePushOptions true &&
+    (
+        cd workbench &&
+        test_commit one &&
+        git push --mirror up &&
+        test_commit two &&
+        git -c push.pushOption=default push up master
+    ) &&
+    test_refs master master &&
+    echo "default" >expect &&
+    test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+    test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
+test_expect_success 'two default push options' '
+    mk_repo_pair &&
+    git -C upstream config receive.advertisePushOptions true &&
+    (
+        cd workbench &&
+        test_commit one &&
+        git push --mirror up &&
+        test_commit two &&
+        git -c push.pushOption=default1 -c push.pushOption=default2
push up master
+    ) &&
+    test_refs master master &&
+    printf "default1\ndefault2\n" >expect &&
+    test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+    test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
+test_expect_success 'default and manual push options' '
+    mk_repo_pair &&
+    git -C upstream config receive.advertisePushOptions true &&
+    (
+        cd workbench &&
+        test_commit one &&
+        git push --mirror up &&
+        test_commit two &&
+        git -c push.pushOption=default push --push-option=manual up master
+    ) &&
+    test_refs master master &&
+    printf "default\nmanual\n" >expect &&
+    test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+    test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd

-- 
2.14.1


2017-10-12 16:59 GMT+02:00 Marius Paliga <marius.paliga@gmail.com>:
> Thank you for your coments and explanation.
>
> Just one thing:
>
>>  - After parse_options() returns to cmd_push(), see if push_options
>>    is empty.  If it is, you did not get any command line option, so
>>    override it with what you collected in the "from-config" string
>>    list.  Otherwise, do not even look at "from-config" string list.
>
> The idea is that there are default push options (read from config) that are
> always sent to the server and you can add (not overwrite) additional by
> specifying "--push-option".
> So I would rather concatenate both lists - from command line and from-config.
>
>> By the way, I really hate "push.optiondefault" as the variable
>> name.  The "default" part is obvious and there is no need to say it,
>> as the configuration variables are there to give the default to what
>> we would normally give from the command line.  Rather, you should
>> say for which option (there are many options "git push" takes) this
>> variable gives the default.  Perhaps "push.pushOption" is a much
>> better name; I am sure people can come up with even better ones,
>> though ;-)
>
> In the light of the above the "default" may be correct, but I don't
> have a problem
> with any name.
>
> Marius
>
>
> 2017-10-11 15:38 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
>> Marius Paliga <marius.paliga@gmail.com> writes:
>>
>>> @@ -505,6 +509,12 @@ static int git_push_config(const char *k, const
>>> char *v, void *cb)
>>>          recurse_submodules = val;
>>>      }
>>>
>>> +    default_push_options = git_config_get_value_multi("push.optiondefault");
>>> +    if (default_push_options)
>>> +        for_each_string_list_item(item, default_push_options)
>>> +            if (!string_list_has_string(&push_options, item->string))
>>> +                string_list_append(&push_options, item->string);
>>> +
>>>      return git_default_config(k, v, NULL);
>>>  }
>>
>> Sorry for not catching this earlier, but git_config_get_value* call
>> inside git_push_config() is just wrong.
>>
>> There are two styles of configuration parsing.  The original (and
>> still perfectly valid) way is to call git_config() with a callback
>> function like git_push_config().  Under this style, the config files
>> are read from lower-priority to higher-priority ones, and the
>> callback function is called once for each entry found, with <key, value>
>> pair and the callback specific opaque data.  One way to add the
>> parsing of a new variable like push.optiondefault is to add
>>
>>         if (!strcmp(k, "push.optiondefault") {
>>                 ... handle one "[push] optiondefault" entry here ...
>>                 return 0;
>>         }
>>
>> to the function.
>>
>> An alternate way is to use git_config_get_* functions _outside_
>> callback of git_config().  This is a newer invention.  Your call to
>> git_config_get_value_multi() will scan all configuration files and
>> returns _all_  entries for the given variable at once.
>>
>> When there is already a callback style parser, in general, it is
>> cleaner to simply piggy-back on it, instead of reading variables
>> independently using git_config_get_* functions.  When there isn't a
>> callback style parser, using either style is OK.  It also is OK to
>> switch to git_config_get_* altogether, rewriting the callback style
>> parser, but I do not think it is warranted in this case, which adds
>> just one variable.
>>
>> In any case, with the above code, you'll end up calling the
>> git_config_get_* function and grabbing all the values for
>> push.optiondefault for each and every configuration variable
>> definition (count "git config -l | wc -l" to estimate how many times
>> it will be called).  Which is probably not what you wanted to do.
>>
>> Also, watch out for how a configuration variable defined like below
>> is reported to either of the above two styles:
>>
>>         [push]  optiondefault
>>
>>  - To a git_config() callback function like git_push_config(), such
>>    an entry is called with k=="push.optiondefault", v==NULL.
>>
>>  - git_config_get_value_multi() would return a string-list element
>>    with the string set to NULL to signal that one value is NULL
>>    (i.e. it is different from "[push] optiondefault = ").
>>
>> I suspect that with your code, we'd hit
>>
>>         if (strchr(item->string, '\n'))
>>
>> and end up dereferencing NULL right there.
>>
>>> @@ -515,7 +525,6 @@ int cmd_push(int argc, const char **argv, const
>>> char *prefix)
>>>      int push_cert = -1;
>>>      int rc;
>>>      const char *repo = NULL;    /* default repository */
>>> -    struct string_list push_options = STRING_LIST_INIT_DUP;
>>>      const struct string_list_item *item;
>>>
>>>      struct option options[] = {
>>
>> Also, I suspect that this code does not allow the command line
>> option to override the default set in the configuration file.
>> OPT_STRING_LIST() appends to the &push_options string list without
>> first clearing it, and you are pre-populating the list while reading
>> the configuration, so the values taken from the command line will
>> only add to them.
>>
>> The right way to do this would probably be:
>>
>>  - Do not muck with push_options in cmd_push().
>>
>>  - Prepare another string list, push_options_from_config, that is
>>    file-scope global.
>>
>>  - In git_push_config(), do not call get_multi; instead react to a
>>    call with k=="push.optionsdefault" and
>>
>>    - reject if "v" is NULL, with "return config_error_nonbool(k);"
>>
>>    - otherwise, append "v" to the "from-config" string list--do not
>>      attempt to dedup or sort.
>>
>>    - if "v" is an empty string, clear the "from-config" list.
>>
>>  - After parse_options() returns to cmd_push(), see if push_options
>>    is empty.  If it is, you did not get any command line option, so
>>    override it with what you collected in the "from-config" string
>>    list.  Otherwise, do not even look at "from-config" string list.
>>
>> By the way, I really hate "push.optiondefault" as the variable
>> name.  The "default" part is obvious and there is no need to say it,
>> as the configuration variables are there to give the default to what
>> we would normally give from the command line.  Rather, you should
>> say for which option (there are many options "git push" takes) this
>> variable gives the default.  Perhaps "push.pushOption" is a much
>> better name; I am sure people can come up with even better ones,
>> though ;-)
>>
