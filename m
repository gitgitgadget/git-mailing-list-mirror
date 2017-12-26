Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED9B1F404
	for <e@80x24.org>; Tue, 26 Dec 2017 22:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbdLZWHr (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 17:07:47 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:41193 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdLZWHq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 17:07:46 -0500
Received: by mail-io0-f194.google.com with SMTP id o2so33626656ioe.8
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 14:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2cnu4c67D3cME+/ypDPL2LQaJgLMhntYbl+6P8gORL4=;
        b=SxZEIUQdDXaiuLNpLokf28E7Jaz6EN9BJFZdTmt84yNABbjlh3PKv8xWgjuLKDi8u/
         MsYIZNGLiTEYnDOkXhEaA9+AHzubcdelPZIvr4VD8Irh4Au/79Q29wgsVEXqyCLO6yC6
         JTdwgU2u0rxd+/S6dWMEmXnsFvziBGsMhZ5o+2rkkGrk16k8E8mCDvy2GphKyeyGRA46
         MBqZCoM8Wkg/9p9sJitfOR/BsWvTXjJJUxe1AEbzalHs1ouhYCA46DLTzOXWcq5z8wBs
         uCkFrxDCElrsBzsqRH0/lEYZaWqgRI9jvtkRLlEu9A1WXsNeOHxPzfS42kUg7O+S0qa/
         Wp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2cnu4c67D3cME+/ypDPL2LQaJgLMhntYbl+6P8gORL4=;
        b=oXZ0spkqrs1RPyTw3kN+QbrYkYuK+utwM71wV96v8mPNN1Q5aQcupDv7Yo4VYghEDF
         AHEYqQP0o/n8dtVtW0NGlYWi4rYYqwQVuTE5qVWlUINhEgA6roqfytwGcSYA51oS6kMq
         oYJSkE8cr3fq2ZUQPPxV/PDd6Gy9Ygl7KNYCsCJageT5JBZNAJARHUyFVeNHv25z5TBu
         TQLvNnI1R2PZrtN6BrZPIocDCI+Mri+B4pp+hHTd8GTAeDbJMPfUiRr8AxpPf0+ubklQ
         QJilzhVTW2MF7ksOGKCuT8uB+paFQDqyU+pMqFjMZjdTs3aqE9/s+aGk+PYaA9+A7O6X
         6FLQ==
X-Gm-Message-State: AKGB3mIMBkzmydfIt8eMdSXoZCiIJ6ZPmDmEmRiuxJ9FA8UBQvXjaq2b
        j4tV6eD2nmebv8ZiQyVP7I3W+KvC8smU4ctt9A0bcy3m
X-Google-Smtp-Source: ACJfBosnTxL/tqrf/sJcT9iyqA7/IHxm/AQ/lpT+qLnIAKSQ9o+WK4xeubBnV6tDVB8Z/W0I638Jw7zeYz+VWmr+rZE=
X-Received: by 10.107.59.12 with SMTP id i12mr13523215ioa.67.1514326065587;
 Tue, 26 Dec 2017 14:07:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Tue, 26 Dec 2017 14:07:45 -0800 (PST)
In-Reply-To: <20171226215908.425-1-chriscool@tuxfamily.org>
References: <20171226215908.425-1-chriscool@tuxfamily.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 26 Dec 2017 23:07:45 +0100
Message-ID: <CAP8UFD2ryn_qHDGeoqSKhH+j-EosCPmMezXHDQTP9Us-3rfUyw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Codespeed perf results
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 26, 2017 at 10:59 PM, Christian Couder
<christian.couder@gmail.com> wrote:

> Changes since previous version
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>   - Fixed the way the 'executable' field sent to Codespeed is set in
>     `perf/aggregate.perl` in patch 3/7. We now use `uname -s -m` to
>     which we concatenate the perf.repoName config value if it is set,
>     as suggested by Junio and Eric.
>
>   - Fixed the name of the GIT_PERF_REPO_NAME variable in patches 3/7
>     and 7/7. It was GIT_TEST_REPO_NAME in some places.
>
>   - Fixed how the conf_opt argument is added to the
>     get_var_from_env_or_config() function in patch 4/7. It was added
>     as the last, so fifth, argument, but it is simpler and makes more
>     sense to keep the default value argument as the last argument, so
>     now the conf_opt argument is added as the fourth argument.
>
>   - What patch 4/7 did was previously done in 2 patches in the
>     previous version (patches 4/8 and 5/8), but as we are not doing
>     exactly the same thing (see the above item) it is simpler to do it
>     in only one patch instead of two.
>
>   - We now use the --int type specifier when getting the
>     perf.repeatCount config variable in patch 4/7.

Here is the diff with v1:

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 6e15f62a9e..34d74fc015 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -186,17 +186,16 @@ sub print_codespeed_results {

     my $project = "Git";

-    my $executable;
-    if ($results_section eq "") {
-        $executable = `uname -o -p`;
-    } else {
-        $executable = $results_section;
-        chomp $executable;
+    my $executable = `uname -s -m`;
+    chomp $executable;
+
+    if ($results_section ne "") {
+        $executable .= ", " . $results_section;
     }

     my $environment;
-    if (exists $ENV{GIT_TEST_REPO_NAME} and $ENV{GIT_TEST_REPO_NAME} ne "") {
-        $environment = $ENV{GIT_TEST_REPO_NAME};
+    if (exists $ENV{GIT_PERF_REPO_NAME} and $ENV{GIT_PERF_REPO_NAME} ne "") {
+        $environment = $ENV{GIT_PERF_REPO_NAME};
     } elsif (exists $ENV{GIT_TEST_INSTALLED} and
$ENV{GIT_TEST_INSTALLED} ne "") {
         $environment = $ENV{GIT_TEST_INSTALLED};
         $environment =~ s|/bin-wrappers$||;
diff --git a/t/perf/run b/t/perf/run
index 279c2d41f6..1a100d6134 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -105,8 +105,8 @@ get_var_from_env_or_config () {
     env_var="$1"
     conf_sec="$2"
     conf_var="$3"
-    default_value="$4" # optional
-    conf_opts="$5" # optional
+    conf_opts="$4" # optional
+    # $5 can be set to a default value

     # Do nothing if the env variable is already set
     eval "test -z \"\${$env_var+x}\"" || return
@@ -124,11 +124,11 @@ get_var_from_env_or_config () {
     conf_value=$(git config $conf_opts -f "$GIT_PERF_CONFIG_FILE" "$var") &&
     eval "$env_var=\"$conf_value\"" && return

-    test -n "${default_value+x}" && eval "$env_var=\"$default_value\""
+    test -n "${5+x}" && eval "$env_var=\"$5\""
 }

 run_subsection () {
-    get_var_from_env_or_config "GIT_PERF_REPEAT_COUNT" "perf" "repeatCount" 3
+    get_var_from_env_or_config "GIT_PERF_REPEAT_COUNT" "perf"
"repeatCount" "--int" 3
     export GIT_PERF_REPEAT_COUNT

     get_var_from_env_or_config "GIT_PERF_DIRS_OR_REVS" "perf" "dirsOrRevs"
@@ -137,7 +137,7 @@ run_subsection () {
     get_var_from_env_or_config "GIT_PERF_MAKE_COMMAND" "perf" "makeCommand"
     get_var_from_env_or_config "GIT_PERF_MAKE_OPTS" "perf" "makeOpts"

-    get_var_from_env_or_config "GIT_TEST_REPO_NAME" "perf" "repoName"
+    get_var_from_env_or_config "GIT_PERF_REPO_NAME" "perf" "repoName"
     export GIT_PERF_REPO_NAME

     GIT_PERF_AGGREGATING_LATER=t
@@ -163,7 +163,7 @@ run_subsection () {
     fi
 }

-get_var_from_env_or_config "GIT_PERF_CODESPEED_OUTPUT" "perf"
"codespeedOutput" "" --bool
+get_var_from_env_or_config "GIT_PERF_CODESPEED_OUTPUT" "perf"
"codespeedOutput" "--bool"
 get_var_from_env_or_config "GIT_PERF_SEND_TO_CODESPEED" "perf"
"sendToCodespeed"

 cd "$(dirname $0)"
