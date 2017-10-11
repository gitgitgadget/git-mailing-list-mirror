Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF15220372
	for <e@80x24.org>; Wed, 11 Oct 2017 09:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbdJKJSt (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 05:18:49 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:56268 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbdJKJSq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 05:18:46 -0400
Received: by mail-qt0-f182.google.com with SMTP id x54so3174701qth.12
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 02:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Id9buQf0EkyTioJIycvkb2uYT1lkevf3rxAmPLIGulI=;
        b=kvaQgw0d8eLDdBARRGJ+VaPPdDMOSdjGJCtUaAMgTCoKXBa5f+ipXOIk77J1JbtUcX
         Tr+CcNcEJSwB8R5NwTuafBNJZWqQSJZsJuQe9DAe19QAxcgQjqZD9gSLovJCT4FW+2uU
         9LYlMxAdDGGncyKZqdRNjNfHFg4LKASM0i5LnH+yVWVdOWS9ex3yKhJ2paiCDc7mfJRy
         wIx53jVQoeIEUkjTV2RRcwqcp3V02cg8BwNBtab/lOiamsOJqf9rnZE5fAm/CspVbCCl
         6J5ishmphmqrvhd9d2gZXOQjTZIN+etXmxrjx0S4P09IzUWgGKj7egD2rd7bNrExkXuB
         jkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Id9buQf0EkyTioJIycvkb2uYT1lkevf3rxAmPLIGulI=;
        b=busZcFLCETFDyeupF8cKwOMtsQebvqPNgOBPvwGjdctOBwoD0OecfcGnUZQ0K4mKeX
         dDb5LuO8P5NbHRMJLue/P+DwHRmcOvjbF6JtpPXQrzRomBRmNvR+qJPpyJYc2JSIbeyi
         MYKv7LIoMElu2X06fKLRjRTBMV5aTKT0CpBV6AWI4eG+cgX0GKmNuUp5CI5fJGle3r4x
         F+m2OMRmoXHjDnojt6sTi+gslUONqU5OYhIz65tRW/ns4kSM9OirPvgeAtPfcST7ZQMD
         +ulxC7moL13RkouQhqO59uB8uyDA2gsPM0Ijq6q4jntzsSBPszrYBzX2YnEFwU3vGRn6
         0FvQ==
X-Gm-Message-State: AMCzsaUhCi9IloEk033veCMoS6YNGB/piGlvgrComODhgSOHxon46Wmd
        tn5u/vGKtN4uXuq/JL7IDDHSgSc2QR8u8nf9Sa6f/0GS
X-Google-Smtp-Source: AOwi7QB0VZQhuLEf7Ai+CHo6I8dZxsrhwsRD5emnuA1BIF/Ype4TOZhjZPLAn6p/BRwJihqgL77uj76TUD8re3lnxjI=
X-Received: by 10.237.42.43 with SMTP id c40mr22101113qtd.322.1507713525915;
 Wed, 11 Oct 2017 02:18:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.101.178 with HTTP; Wed, 11 Oct 2017 02:18:45 -0700 (PDT)
In-Reply-To: <CAK7vU=22W9mYdSnw_LP2uWYyKZuTzF0JgTVWCX+nMhUnLjQ_Cw@mail.gmail.com>
References: <CAK7vU=0ztEwMPsGO4Cd1A5JEnxmwkF57QPKjjvjD8rBUB79dRA@mail.gmail.com>
 <CAGZ79kaBJnXW=rSiKuHpds79mXVL0Aoo+PBa0a5V-C_bop=Kbg@mail.gmail.com>
 <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com> <CAK7vU=22W9mYdSnw_LP2uWYyKZuTzF0JgTVWCX+nMhUnLjQ_Cw@mail.gmail.com>
From:   Marius Paliga <marius.paliga@gmail.com>
Date:   Wed, 11 Oct 2017 11:18:45 +0200
Message-ID: <CAK7vU=0tRu=MAtBWHaQ6pGOGMfYdEorNd_930jq_3n_tLY2hsg@mail.gmail.com>
Subject: Re: Enhancement request: git-push: Allow (configurable) default push-option
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Found one possible issue when looking for duplicates, we need to use
  "unsorted_string_list_has_string" instead of "string_list_has_string"

-                       if (!string_list_has_string(&push_options,
item->string))
+                       if
(!unsorted_string_list_has_string(&push_options, item->string)) {

New (fixed) patch follows...


Signed-off-by: Marius Paliga <marius.paliga@gmail.com>
---
 Documentation/git-push.txt |  3 +++
 builtin/push.c             | 11 ++++++++++-
 t/t5545-push-options.sh    | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3e76e99f3..133c42183 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -161,6 +161,9 @@ already exists on the remote side.
     Transmit the given string to the server, which passes them to
     the pre-receive as well as the post-receive hook. The given string
     must not contain a NUL or LF character.
+    Default push options can also be specified with configuration
+    variable `push.optiondefault`. String(s) specified here will always
+    be passed to the server without need to specify it using `--push-option`

 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
diff --git a/builtin/push.c b/builtin/push.c
index 2ac810422..ab458419a 100644
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
@@ -467,6 +469,8 @@ static int git_push_config(const char *k, const
char *v, void *cb)
 {
     int *flags = cb;
     int status;
+    const struct string_list *default_push_options;
+    struct string_list_item *item;

     status = git_gpg_config(k, v, NULL);
     if (status)
@@ -505,6 +509,12 @@ static int git_push_config(const char *k, const
char *v, void *cb)
         recurse_submodules = val;
     }

+    default_push_options = git_config_get_value_multi("push.optiondefault");
+    if (default_push_options)
+        for_each_string_list_item(item, default_push_options)
+            if (!unsorted_string_list_has_string(&push_options, item->string))
+                string_list_append(&push_options, item->string);
+
     return git_default_config(k, v, NULL);
 }

@@ -515,7 +525,6 @@ int cmd_push(int argc, const char **argv, const
char *prefix)
     int push_cert = -1;
     int rc;
     const char *repo = NULL;    /* default repository */
-    struct string_list push_options = STRING_LIST_INIT_DUP;
     const struct string_list_item *item;

     struct option options[] = {
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 90a4b0d2f..575f3dc38 100755
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
+        git -c push.optiondefault=default push up master
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
+        git -c push.optiondefault=default1 -c
push.optiondefault=default2 push up master
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
+        git -c push.optiondefault=default push --push-option=manual up master
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

2017-10-11 9:14 GMT+02:00 Marius Paliga <marius.paliga@gmail.com>:
> Including proposed patch...
>
>
> Signed-off-by: Marius Paliga <marius.paliga@gmail.com>
> ---
>  Documentation/git-push.txt |  3 +++
>  builtin/push.c             | 11 ++++++++++-
>  t/t5545-push-options.sh    | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 3e76e99f3..133c42183 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -161,6 +161,9 @@ already exists on the remote side.
>      Transmit the given string to the server, which passes them to
>      the pre-receive as well as the post-receive hook. The given string
>      must not contain a NUL or LF character.
> +    Default push options can also be specified with configuration
> +    variable `push.optiondefault`. String(s) specified here will always
> +    be passed to the server without need to specify it using `--push-option`
>
>  --receive-pack=<git-receive-pack>::
>  --exec=<git-receive-pack>::
> diff --git a/builtin/push.c b/builtin/push.c
> index 2ac810422..4dd5d6f0e 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -32,6 +32,8 @@ static const char **refspec;
>  static int refspec_nr;
>  static int refspec_alloc;
>
> +static struct string_list push_options = STRING_LIST_INIT_DUP;
> +
>  static void add_refspec(const char *ref)
>  {
>      refspec_nr++;
> @@ -467,6 +469,8 @@ static int git_push_config(const char *k, const
> char *v, void *cb)
>  {
>      int *flags = cb;
>      int status;
> +    const struct string_list *default_push_options;
> +    struct string_list_item *item;
>
>      status = git_gpg_config(k, v, NULL);
>      if (status)
> @@ -505,6 +509,12 @@ static int git_push_config(const char *k, const
> char *v, void *cb)
>          recurse_submodules = val;
>      }
>
> +    default_push_options = git_config_get_value_multi("push.optiondefault");
> +    if (default_push_options)
> +        for_each_string_list_item(item, default_push_options)
> +            if (!string_list_has_string(&push_options, item->string))
> +                string_list_append(&push_options, item->string);
> +
>      return git_default_config(k, v, NULL);
>  }
>
> @@ -515,7 +525,6 @@ int cmd_push(int argc, const char **argv, const
> char *prefix)
>      int push_cert = -1;
>      int rc;
>      const char *repo = NULL;    /* default repository */
> -    struct string_list push_options = STRING_LIST_INIT_DUP;
>      const struct string_list_item *item;
>
>      struct option options[] = {
> diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
> index 90a4b0d2f..575f3dc38 100755
> --- a/t/t5545-push-options.sh
> +++ b/t/t5545-push-options.sh
> @@ -140,6 +140,54 @@ test_expect_success 'push options and submodules' '
>      test_cmp expect parent_upstream/.git/hooks/post-receive.push_options
>  '
>
> +test_expect_success 'default push option' '
> +    mk_repo_pair &&
> +    git -C upstream config receive.advertisePushOptions true &&
> +    (
> +        cd workbench &&
> +        test_commit one &&
> +        git push --mirror up &&
> +        test_commit two &&
> +        git -c push.optiondefault=default push up master
> +    ) &&
> +    test_refs master master &&
> +    echo "default" >expect &&
> +    test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
> +    test_cmp expect upstream/.git/hooks/post-receive.push_options
> +'
> +
> +test_expect_success 'two default push options' '
> +    mk_repo_pair &&
> +    git -C upstream config receive.advertisePushOptions true &&
> +    (
> +        cd workbench &&
> +        test_commit one &&
> +        git push --mirror up &&
> +        test_commit two &&
> +        git -c push.optiondefault=default1 -c
> push.optiondefault=default2 push up master
> +    ) &&
> +    test_refs master master &&
> +    printf "default1\ndefault2\n" >expect &&
> +    test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
> +    test_cmp expect upstream/.git/hooks/post-receive.push_options
> +'
> +
> +test_expect_success 'default and manual push options' '
> +    mk_repo_pair &&
> +    git -C upstream config receive.advertisePushOptions true &&
> +    (
> +        cd workbench &&
> +        test_commit one &&
> +        git push --mirror up &&
> +        test_commit two &&
> +        git -c push.optiondefault=default push --push-option=manual up master
> +    ) &&
> +    test_refs master master &&
> +    printf "default\nmanual\n" >expect &&
> +    test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
> +    test_cmp expect upstream/.git/hooks/post-receive.push_options
> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
>
> --
> 2.14.1
>
>
> 2017-10-04 17:20 GMT+02:00 Marius Paliga <marius.paliga@gmail.com>:
>> Hi Stefan,
>>
>> I will look at it.
>>
>> Thanks,
>> Marius
>>
>>
>> 2017-10-03 18:53 GMT+02:00 Stefan Beller <sbeller@google.com>:
>>> On Tue, Oct 3, 2017 at 3:15 AM, Marius Paliga <marius.paliga@gmail.com> wrote:
>>>> There is a need to pass predefined push-option during "git push"
>>>> without need to specify it explicitly.
>>>>
>>>> In another words we need to have a new "git config" variable to
>>>> specify string that will be automatically passed as "--push-option"
>>>> when pushing to remote.
>>>>
>>>> Something like the following:
>>>>
>>>> git config push.optionDefault AllowMultipleCommits
>>>>
>>>> and then command
>>>>   git push
>>>> would silently run
>>>>   git push --push-option "AllowMultipleCommits"
>>>
>>> We would need to
>>> * design this feature (seems like you already have a good idea what you need)
>>> * implement it (see builtin/push.c):
>>>  - move "struct string_list push_options = STRING_LIST_INIT_DUP;"
>>>   to be a file-static variable, such that we have access to it outside
>>> of cmd_push.
>>>  - In git_push_config in builtin/push.c that parses the config, we'd
>>> need to check
>>>   for "push.optionDefault" and add these to the push_options (I assume multiple
>>>   are allowed)
>>> * document it (Documentation/git-push.txt)
>>> * add a test for it ? (t/t5545-push-options.sh)
>>>
>>> Care to write a patch? Otherwise I'd mark it up as part of
>>> #leftoverbits for now,
>>> as it seems like a good starter project.
>>>
>>> Thanks,
>>> Stefan
