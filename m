Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08942027C
	for <e@80x24.org>; Tue, 30 May 2017 13:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751331AbdE3NS5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 09:18:57 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36187 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbdE3NS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 09:18:56 -0400
Received: by mail-qk0-f178.google.com with SMTP id u75so67871691qka.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 06:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cIYna2tljTt5Gk6lkAYyMPI1NUUFO8EuCt0zBHeAwT0=;
        b=sAOP/lGnE6KDPiF7nHz9TKRqwTmS62PUcA4TLKchEBi5fgY7zCKe1UbTFF/uP85UWE
         1CIKm0gv46b9XN6N6iv75DXhRiUXsGLtc9+Zc1Q11jhr2FLwfQqkt6+sOVozuGjZ55Lp
         OZMCOR2NG0KZ8wkg6nHiWfwTQc3X7Zhx3WgWtJmHdQTxIF+T1DQ1ojJXWqRgH0yXaE1E
         yDvo5hDCjogmB7nA15DHk1BKw9kShEjB68TfmxY3AEJU8tULehEpwj2HQdaOowWx3HYh
         Uzqp3n+cO7eq6aGjjoni9YR3foU80jqHjyJjfujEVMw3feHSYZFbiCk2Rq6DGzCpIicO
         eNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cIYna2tljTt5Gk6lkAYyMPI1NUUFO8EuCt0zBHeAwT0=;
        b=pp4iL27dKIr822vJjisdLqioBiPoydFweq4ocu/PRKg0HIGXWrT/FM7WJkSlbhFevY
         5Mn2sry1wL22YwAOdrJrF5yhDvWgmEIP44c49fUSg3orpbwAgNunsRH4fpIjJ0i8UB+T
         5GENdiodhdLXbqMYhad6Rrno8Hjgdb29pi9YYWI2T3a/2qEcUn6D39S/hbU8E1gOxLtH
         xCXzlKa8S2lqrjduWkcys3viecwhdq6CEh0DHvRMeCHzruqFVy2EEsBRkXmJ6PMc9oV+
         tHbTBXq8xq0/1E6K0vpGnNR3FXx/0PRlCw9h1d4LrYwr9zaa8KtEkDDEi7DkujA6zzmw
         Es/w==
X-Gm-Message-State: AODbwcDFLHK9pkfvo/2/Movbmc0plauJJ9s8u1OGHibRBwQSTCwwmbdv
        sEtg2Q/OpvYxUYZb20/rxpya7kAVhgyx
X-Received: by 10.55.116.133 with SMTP id p127mr21597183qkc.154.1496150330514;
 Tue, 30 May 2017 06:18:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Tue, 30 May 2017 06:18:49 -0700 (PDT)
In-Reply-To: <20170525183612.3128-5-benpeart@microsoft.com>
References: <20170525183612.3128-1-benpeart@microsoft.com> <20170525183612.3128-5-benpeart@microsoft.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 30 May 2017 15:18:49 +0200
Message-ID: <CAP8UFD0OEUogQYL5Eo1kBy_1B=dBcdEJyc4B_qAUOU=2XnrxxA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] fsmonitor: add test cases for fsmonitor extension
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 25, 2017 at 8:36 PM, Ben Peart <peartben@gmail.com> wrote:

[...]

> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> new file mode 100755
> index 0000000000..395db46d55
> --- /dev/null
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -0,0 +1,158 @@
> +#!/bin/sh
> +
> +test_description='git status with file system watcher'
> +
> +. ./test-lib.sh
> +
> +clean_repo () {
> +       git reset --hard HEAD
> +       git clean -fd
> +       rm -f marker
> +}

Maybe link all the commands in the function with "&&".

> +dirty_repo () {
> +       : >untracked
> +       : >dir1/untracked
> +       : >dir2/untracked
> +       echo 1 >modified
> +       echo 2 >dir1/modified
> +       echo 3 >dir2/modified
> +       echo 4 >new
> +       echo 5 >dir1/new
> +       echo 6 >dir2/new
> +       git add new
> +       git add dir1/new
> +       git add dir2/new
> +}

Idem.

> +# The test query-fsmonitor hook proc will output a marker file we can use to
> +# ensure the hook was actually used to generate the correct results.
> +
> +test_expect_success 'setup' '
> +       mkdir -p .git/hooks &&
> +       write_script .git/hooks/query-fsmonitor<<-\EOF &&
> +       if [ $1 -ne 1 ]
> +       then
> +               echo -e "Unsupported query-fsmonitor hook version.\n" >&2
> +               exit 1;
> +       fi
> +       : >marker
> +       printf "untracked\0"
> +       printf "dir1/untracked\0"
> +       printf "dir2/untracked\0"
> +       printf "modified\0"
> +       printf "dir1/modified\0"
> +       printf "dir2/modified\0"
> +       printf "new\0""
> +       printf "dir1/new\0"
> +       printf "dir2/new\0"

Maybe something like the following to save a few lines and remove some
redundancies:

       printf "%s\0" untracked dir1/untracked dir2/untracked \
                             modified dir1/modified dir2/modified \
                             new dir1/new dir2/new

or perhaps:

       for f in untracked modified new
       do
              printf "%s\0" "$f" "dir1/$f" "dir2/$f"
       done

> +       EOF
> +       : >tracked &&
> +       : >modified &&
> +       mkdir dir1 &&
> +       : >dir1/tracked &&
> +       : >dir1/modified &&
> +       mkdir dir2 &&
> +       : >dir2/tracked &&
> +       : >dir2/modified &&
> +       git add . &&
> +       test_tick &&
> +       git commit -m initial &&
> +       dirty_repo
> +'
> +
> +cat >.gitignore <<\EOF
> +.gitignore
> +expect*
> +output*
> +marker*
> +EOF

This could be part of the previous setup test.

> +# Status is well tested elsewhere so we'll just ensure that the results are
> +# the same when using core.fsmonitor. First call after turning on the option
> +# does a complete scan so need to do two calls to ensure we test the new
> +# codepath.
> +
> +test_expect_success 'status with core.untrackedcache true' '

If this test is using untracked cache, it should perhaps first check
that untracked cache can be used on the current file system.
t7063-status-untracked-cache.sh does that with the following:

test_lazy_prereq UNTRACKED_CACHE '
    { git update-index --test-untracked-cache; ret=$?; } &&
    test $ret -ne 1
'

if ! test_have_prereq UNTRACKED_CACHE; then
    skip_all='This system does not support untracked cache'
    test_done
fi

> +       git config core.fsmonitor true  &&
> +       git config core.untrackedcache true &&
> +       git -c core.fsmonitor=false -c core.untrackedcache=true status >expect &&

I don't understand why there is " -c core.untrackedcache=true" in the
above command as you already set core.untrackedcache to true on the
previous line.

> +       clean_repo &&
> +       git status &&
> +       test_path_is_missing marker &&
> +       dirty_repo &&
> +       git status >output &&
> +       test_path_is_file marker &&
> +       test_i18ncmp expect output
> +'
> +
> +

Spurious new line.

> +test_expect_success 'status with core.untrackedcache false' '
> +       git config core.fsmonitor true &&
> +       git config core.untrackedcache false &&
> +       git -c core.fsmonitor=false -c core.untrackedcache=false status >expect &&

Again core.untrackedcache is already set to false on the previous line.

> +       clean_repo &&
> +       git status &&
> +       test_path_is_missing marker &&
> +       dirty_repo &&
> +       git status >output &&
> +       test_path_is_file marker &&
> +       test_i18ncmp expect output
> +'
> +
> +# Ensure commands that call refresh_index() to move the index back in time
> +# properly invalidate the fsmonitor cache
> +
> +test_expect_success 'refresh_index() invalidates fsmonitor cache' '
> +       git config core.fsmonitor true &&
> +       git config core.untrackedcache true &&
> +       clean_repo &&
> +       git status &&
> +       test_path_is_missing marker &&
> +       dirty_repo &&
> +       write_script .git/hooks/query-fsmonitor<<-\EOF &&
> +       :>marker
> +       EOF
> +       git add . &&
> +       git commit -m "to reset" &&
> +       git status &&
> +       test_path_is_file marker &&
> +       git reset HEAD~1 &&
> +       git status >output &&
> +       test_path_is_file marker &&

You already checked that "marker" exists 3 lines above, and as far as
I can see nothing could remove this file since the previous test, as
the hook can only create it.
So I wonder if something is missing or if this test is redundant.

> +       git -c core.fsmonitor=false status >expect &&
> +       test_i18ncmp expect output
> +'
> +
> +# Now make sure it's actually skipping the check for modified and untracked
> +# files unless it is told about them.  Note, after "git reset --hard HEAD" no
> +# extensions exist other than 'TREE' so do a "git status" to get the extension
> +# written before testing the results.
> +
> +test_expect_success 'status doesnt detect unreported modifications' '

Maybe:

test_expect_success "status doesn't detect unreported modifications" '

> +       git config core.fsmonitor true &&
> +       git config core.untrackedcache true &&
> +       write_script .git/hooks/query-fsmonitor<<-\EOF &&
> +       :>marker
> +       EOF
> +       clean_repo &&
> +       git status &&
> +       test_path_is_missing marker &&
> +       : >untracked &&
> +       echo 2 >dir1/modified &&
> +       git status >output &&
> +       test_path_is_file marker &&
> +       test_i18ngrep ! "Changes not staged for commit:" output &&
> +       test_i18ngrep ! "Untracked files:" output &&
> +       write_script .git/hooks/query-fsmonitor<<-\EOF &&
> +       :>marker
> +       printf "untracked%s\0"

Why is there a %s in the above?

> +       printf "dir1/modified\0"
> +       EOF
> +       git status >output &&
> +       test_path_is_file marker &&
> +       test_i18ngrep "Changes not staged for commit:" output &&
> +       test_i18ngrep "Untracked files:" output
> +'
> +
> +test_done
> --
> 2.13.0.windows.1.9.gc201c67b71
>
