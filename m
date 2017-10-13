Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 403511FF32
	for <e@80x24.org>; Fri, 13 Oct 2017 08:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757463AbdJMIpJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 04:45:09 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:56203 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbdJMIpE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 04:45:04 -0400
Received: by mail-qk0-f174.google.com with SMTP id x82so4166511qkb.12
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qAJ//8hSYZ+O1RVsWpsNEbEF/nVv/RNl9GMqPTki4QU=;
        b=p7VXiiSIBgENmpI9kMk300gBe1JUI2vxnA0oK3XgeKptC1ZyqPU2a+ZBPAUXdwp4qu
         TdVim1fSXSXSoWW/oalZv5rWcxHF/j5UBkAqIZ844g936q2NovjGtBuZzbivIKbuoUTF
         VcAZQ64GgiuFyrRKRNID9uSygrlKS3GwnjGcYiDvmJSlD8uM4664JTPDwHFlx/B1Z3LI
         hVxnBK0/zr0So6/odNNmk7suuOu0eYMtxqkZieR/NqkGwykswR0ur7dNoQ0inDMnaoOg
         H2faN1bRWiNZMufjqvKia2hSTWSMCpWtX8cqDmNhBoa+F2Z9UsUS+BJQ84Cugy95JrII
         xfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qAJ//8hSYZ+O1RVsWpsNEbEF/nVv/RNl9GMqPTki4QU=;
        b=Xy2S+oMrUqfSgtjLf/nwpWcX5+YzfiNrVXMB7Dwf3xCeapEKiQnvKdSOicYFNpsHlN
         bzICfjHdY+yukCMihdDhmavXUGlJqE9lP3Ue7Q5UFeY0Kspfn03mbeqlDbeb7Gv6MtEs
         bOP4tr9lEAKDv8qg9vNVF5wTcXc+nBE5isMygWtMdBvFCsFS0GqwI6+YD6nkfBcgew4J
         iFMiQ9NZXnmyOUhfRbzj4UGaFDoIotCwB1zn6jXurmD+KJE5gQ7yqtxsaKuXf2VFUVVr
         WCOTyaZXbJIGwTkEo9/ILGL0+eN++vJr1CQzlJm7q292i9Zon9O6/2WlBheFN5MuCxTK
         jmLQ==
X-Gm-Message-State: AMCzsaXZsiB3zTKuOF4S+cShboeuHD0QlTP8yu3bl7gJHdPBkh3lohbb
        AEHCvYN9zO2d99dOiwyvcX0MJfgotHH7RcrkyBA=
X-Google-Smtp-Source: AOwi7QCiYtCS+Vdq4K5T2mTLNLlaroWFwz3tUF9nkF2Yu/XuLeqlt0gsC8NSsIUxJhoAz5msO7hYe/PjkMdGlxbs1ao=
X-Received: by 10.55.79.85 with SMTP id d82mr835097qkb.5.1507884303570; Fri,
 13 Oct 2017 01:45:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.101.178 with HTTP; Fri, 13 Oct 2017 01:45:02 -0700 (PDT)
In-Reply-To: <xmqq1sm7yjav.fsf@gitster.mtv.corp.google.com>
References: <CAK7vU=0ztEwMPsGO4Cd1A5JEnxmwkF57QPKjjvjD8rBUB79dRA@mail.gmail.com>
 <CAGZ79kaBJnXW=rSiKuHpds79mXVL0Aoo+PBa0a5V-C_bop=Kbg@mail.gmail.com>
 <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
 <CAK7vU=22W9mYdSnw_LP2uWYyKZuTzF0JgTVWCX+nMhUnLjQ_Cw@mail.gmail.com>
 <xmqqh8v5ls8i.fsf@gitster.mtv.corp.google.com> <CAK7vU=0wbGsFCXmwmCc-XX9K07UF_OZ7tFa4_GVb-H7fxakssg@mail.gmail.com>
 <xmqq1sm7yjav.fsf@gitster.mtv.corp.google.com>
From:   Marius Paliga <marius.paliga@gmail.com>
Date:   Fri, 13 Oct 2017 10:45:02 +0200
Message-ID: <CAK7vU=2ePR3jQsgu=RxSMrxytAAHqxC0SFrN5YozLzQzP2ZT2A@mail.gmail.com>
Subject: Re: Enhancement request: git-push: Allow (configurable) default push-option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, thais.dinizbraz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated patch and added tests:
(feel free to modify Documentation)

---

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
 Documentation/git-push.txt |  3 ++
 builtin/push.c             | 12 ++++++++
 t/t5545-push-options.sh    | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

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
index 2ac810422..10e520c8f 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -32,6 +32,8 @@ static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;

+static struct string_list push_options_from_config = STRING_LIST_INIT_DUP;
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
+                string_list_clear(&push_options_from_config, 0);
+            else
+                string_list_append(&push_options_from_config, v);
     }

     return git_default_config(k, v, NULL);
@@ -562,6 +572,8 @@ int cmd_push(int argc, const char **argv, const
char *prefix)
     packet_trace_identity("push");
     git_config(git_push_config, &flags);
     argc = parse_options(argc, argv, prefix, options, push_usage, 0);
+    if (!push_options.nr)
+        push_options = push_options_from_config;
     set_push_cert_flags(&flags, push_cert);

     if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL |
TRANSPORT_PUSH_MIRROR))))
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 90a4b0d2f..463783789 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -140,6 +140,83 @@ test_expect_success 'push options and submodules' '
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
+test_expect_success 'push option from command line overrides
from-config push option' '
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
+    echo "manual" >expect &&
+    test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+    test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
+test_expect_success 'empty value of push.pushOption in config clears
the list' '
+    mk_repo_pair &&
+    git -C upstream config receive.advertisePushOptions true &&
+    (
+        cd workbench &&
+        test_commit one &&
+        git push --mirror up &&
+        test_commit two &&
+        git -c push.pushOption=default1 -c push.pushOption= -c
push.pushOption=default2 push up master
+    ) &&
+    test_refs master master &&
+    echo "default2" >expect &&
+    test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+    test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
+test_expect_success 'invalid push option in config' '
+    mk_repo_pair &&
+    git -C upstream config receive.advertisePushOptions true &&
+    (
+        cd workbench &&
+        test_commit one &&
+        git push --mirror up &&
+        test_commit two &&
+        test_must_fail git -c push.pushOption push up master
+    ) &&
+    test_refs master HEAD@{1}
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd

-- 
2.14.1


2017-10-13 2:37 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Marius Paliga <marius.paliga@gmail.com> writes:
>
>> Thank you for your coments and explanation.
>>
>> Just one thing:
>>
>>>  - After parse_options() returns to cmd_push(), see if push_options
>>>    is empty.  If it is, you did not get any command line option, so
>>>    override it with what you collected in the "from-config" string
>>>    list.  Otherwise, do not even look at "from-config" string list.
>>
>> The idea is that there are default push options (read from config) that are
>> always sent to the server and you can add (not overwrite) additional by
>> specifying "--push-option".
>
> I can imagine that sometimes giving a base from a configuration and
> then adding more for specific invocation may be useful.
>
> But I do not think of any --command-line-option and config.variable
> pair whose configured value cannot be overriden by the command line
> option; we should strive to avoid making --push-option a special
> case that the users need to aware of, and more importantly, users
> other than you who expect the more usual "command line overrides"
> behaviour should get that.
>
> Your "I wanted to accumulate, so I made so and made it impossible to
> override" won't fly as a justification.  The default should be
> "command line overrides", and if you need a way to allow command
> line to add without overiding, that should be added as an optional
> feature.
>
>         [alias]
>                 mypush = push --push-option=foo --push-option=bar
>
> may give you a set of push-options that are always in effect (they
> are not even "by default") and cannot be overriden.
>
