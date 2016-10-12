Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4C02098A
	for <e@80x24.org>; Wed, 12 Oct 2016 17:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755797AbcJLRMz (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 13:12:55 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:33017 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755213AbcJLRMu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 13:12:50 -0400
Received: by mail-qt0-f177.google.com with SMTP id s49so22485407qta.0
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WF+1UEG4QN4dS1EMWPiZZ8OhZI+CY+mGNN5wjGOt6yE=;
        b=QJ0YpNvKu2ujXyHzDfy3w72l1GJ/aknPsR1FX634LO50s2xDuT4+rb3oaQQHgo/iwv
         rHD0xswHcvm6dRKVwLz+7G7IwYhLEr4PCmcSY6owlkMjMRG1D9tqykU3jjdzhStEVeVV
         vpmWKGQAWfE61SW+0QP+9oKVtXta1a1B9afkQCIDj2XxciqiaKmkMMr4tnbsuFfqH2OW
         EN9+o+fY560zShDGPUE9MCmZf6Mx1+GPPKK/qZaPrXZFUu27NAULRaGE+0fpo/2npeD3
         jCFhce9MsgezAlZBEI4wi8en+SUR8jD+wZKh4aWESAS0c2+VI30tGY0bfzTn7nNy1ZOA
         Ycmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WF+1UEG4QN4dS1EMWPiZZ8OhZI+CY+mGNN5wjGOt6yE=;
        b=ebkpnJ6azHWy9Eqb1qnZDMuEBSltFOlff7kTNVNzg/ZBzdKHTDd0sH5bZZo1CQxpaA
         H04QG8ED92FIk4ssxhSy/wTfuCtf3MEDha2lEsZD17IlRnCyXUjuv7qI25v39sbKqvJ1
         s6dZixmnvK+Xyl40t0aIL68q+jZ0GfOMLsILi8zZt6tKRcYVsNIzdBZxvL9CxK+m079E
         B3uR8win4bdNQcRhIDHLqvRrk6WuQcnqGkrm5DEdX87RCVua6Bwsbnqt36XT/kQvqNcK
         8/5QoKnSdWRfgO/Z46LQnbtXBY6vuF5CD/w981l74LJY8CKOYytwQFp8IUQzyP4ud2m7
         dBSQ==
X-Gm-Message-State: AA6/9Rlzl76fkPPRZt/7MHVcXfDPmfXrHzc2o2otjxB007VDvLT1dX957guHiNPGqlsKTxH7S6nJwY1SE1mwk5CW
X-Received: by 10.200.44.162 with SMTP id 31mr2347476qtw.1.1476291982842; Wed,
 12 Oct 2016 10:06:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 12 Oct 2016 10:06:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1610121501390.3492@virtualbox>
References: <20161010175611.1058-1-sbeller@google.com> <alpine.DEB.2.20.1610121501390.3492@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Oct 2016 10:06:22 -0700
Message-ID: <CAGZ79kYDpth7YDbN0VRD0dcpp7aeQ-y4HSEhsmd_c46ggZoXsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] submodule: ignore trailing slash on superproject URL
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 6:30 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Mon, 10 Oct 2016, Stefan Beller wrote:
>
>> Before 63e95beb0 (2016-04-15, submodule: port resolve_relative_url from
>> shell to C), it did not matter if the superprojects URL had a trailing
>> slash or not. It was just chopped off as one of the first steps
>> (The "remoteurl=${remoteurl%/}" near the beginning of
>> resolve_relative_url(), which was removed in said commit).
>>
>> When porting this to the C version, an off-by-one error was introduced
>> and we did not check the actual last character to be a slash, but the
>> NULL delimiter.
>
> It is a NUL delimiter, not a NULL delimiter.

 null character ('\0', called NUL in ASCII)
I see. Thanks for pointing out.

>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 444ec06..a7841a5 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -95,6 +95,8 @@ static int chop_last_dir(char **remoteurl, int is_relative)
>>   * NEEDSWORK: This works incorrectly on the domain and protocol part.
>>   * remote_url      url              outcome          expectation
>>   * http://a.com/b  ../c             http://a.com/c   as is
>> + * http://a.com/b/ ../c             http://a.com/c   same as previous line, but
>> + *                                                   ignore trailing slash in url
>>   * http://a.com/b  ../../c          http://c         error out
>>   * http://a.com/b  ../../../c       http:/c          error out
>>   * http://a.com/b  ../../../../c    http:c           error out
>> @@ -113,8 +115,8 @@ static char *relative_url(const char *remote_url,
>>       struct strbuf sb = STRBUF_INIT;
>>       size_t len = strlen(remoteurl);
>>
>> -     if (is_dir_sep(remoteurl[len]))
>> -             remoteurl[len] = '\0';
>> +     if (is_dir_sep(remoteurl[len-1]))
>> +             remoteurl[len-1] = '\0';
>>
>>       if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
>>               is_relative = 0;
>> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
>> index bf2deee..82b98f8 100755
>> --- a/t/t0060-path-utils.sh
>> +++ b/t/t0060-path-utils.sh
>> @@ -319,6 +319,7 @@ test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/submodule"
>>  test_submodule_relative_url "../" "foo" "../submodule" "../submodule"
>>
>>  test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" "../foo/sub/a/b/c"
>> +test_submodule_relative_url "(null)" "../foo/bar/" "../sub/a/b/c" "../foo/sub/a/b/c"
>>  test_submodule_relative_url "(null)" "../foo/bar" "../submodule" "../foo/submodule"
>>  test_submodule_relative_url "(null)" "../foo/submodule" "../submodule" "../foo/submodule"
>>  test_submodule_relative_url "(null)" "../foo" "../submodule" "../submodule"
>
> I see that this already made it to `next`. I saw that because it breaks
> the build of Git for Windows (this was not noticed earlier because other
> compile failures prevented the tests from running), as now the test cases
> 173 and 177 of t0060 fail (*not* the newly introduced 163).
>
> Here is the output with -v -x:
>
> -- snip --
> [...]
> expecting success:
>                 actual=$(git submodule--helper resolve-relative-url-test '(null)' '/usr/src/git/wip/t/trash directory.t0060-path-utils/.' '../.') &&
>                 test "$actual" = 'C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/.'
>
> +++ git submodule--helper resolve-relative-url-test '(null)' '/usr/src/git/wip/t/trash directory.t0060-path-utils/.' ../.
> ++ actual=C:/git-sdk-64/usr/src/git/wip/t/.
> ++ test C:/git-sdk-64/usr/src/git/wip/t/. = 'C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/.'

So this wipes away one dir too much in a test that doesn't end with a
dir separator
(In Windows that is '/' and '\' only, no dots?)

> error: last command exited with $?=1
> not ok 172 - test_submodule_relative_url: (null) /usr/src/git/wip/t/trash directory.t0060-path-utils/. ../. => C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/.
> #
> #                       actual=$(git submodule--helper
> #                       resolve-relative-url-test '(null)'
> #                       '/usr/src/git/wip/t/trash
> #                       directory.t0060-path-utils/.' '../.') &&
> #                       test "$actual" =
> #                       'C:/git-sdk-64/usr/src/git/wip/t/trash
> #                       directory.t0060-path-utils/.'
> #
> [...]
> expecting success:
>                 actual=$(git submodule--helper resolve-relative-url-test '(null)' '/usr/src/git/wip/t/trash directory.t0060-path-utils/.' '../submodule') &&
>                 test "$actual" = 'C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/submodule'
>
> +++ git submodule--helper resolve-relative-url-test '(null)' '/usr/src/git/wip/t/trash directory.t0060-path-utils/.' ../submodule
> ++ actual=C:/git-sdk-64/usr/src/git/wip/t/submodule
> ++ test C:/git-sdk-64/usr/src/git/wip/t/submodule = 'C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/submodule'
> error: last command exited with $?=1
> not ok 176 - test_submodule_relative_url: (null) /usr/src/git/wip/t/trash directory.t0060-path-utils/. ../submodule => C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/submodule
> #
> #                       actual=$(git submodule--helper
> #                       resolve-relative-url-test '(null)'
> #                       '/usr/src/git/wip/t/trash
> #                       directory.t0060-path-utils/.' '../submodule') &&
> #                       test "$actual" =
> #                       'C:/git-sdk-64/usr/src/git/wip/t/trash
> #                       directory.t0060-path-utils/submodule'
> #
> [...]
> -- snap --
>
> For comparison, this is how it succeeds in an Ubuntu VM:
>
> -- snap --
> expecting success:
>                 actual=$(git submodule--helper resolve-relative-url-test '(null)' '/home/virtualbox/git/wip/t/trash directory.t0060-path-utils/.' '../.') &&
>                 test "$actual" = '/home/virtualbox/git/wip/t/trash directory.t0060-path-utils/.'
>
> +++ git submodule--helper resolve-relative-url-test '(null)' '/home/virtualbox/git/wip/t/trash directory.t0060-path-utils/.' ../.
> ++ actual='/home/virtualbox/git/wip/t/trash directory.t0060-path-utils/.'
> ++ test '/home/virtualbox/git/wip/t/trash directory.t0060-path-utils/.' = '/home/virtualbox/git/wip/t/trash directory.t0060-path-utils/.'
> + test_eval_ret_=0
> + want_trace
> + test t = t
> + test t = t
> + set +x
> ok 173 - test_submodule_relative_url: (null) /home/virtualbox/git/wip/t/trash directory.t0060-path-utils/. ../. => /home/virtualbox/git/wip/t/trash directory.t0060-path-utils/.
> -- snap --
>
> The reason that this fails on Windows is that the POSIX->Windows path
> mangling of the MSYS2 shell strips the trailing . from "/some/directory/."
> when converting it to "C:/git-sdk-64/some/directory", and for a good
> reason: most Windows programs do not handle the trailing "." very well.
>
> One very, very ugly workaround for this newly-introduced breakage would be
> this:
>
> -- snip --
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 82b98f8..abd82e9 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -328,11 +328,11 @@ test_submodule_relative_url "(null)" "./foo" "../submodule" "submodule"
>  test_submodule_relative_url "(null)" "//somewhere else/repo" "../subrepo" "//somewhere else/subrepo"
>  test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../subsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
>  test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subsuper_update_r" "$(pwd)/subsuper_update_r"
> -test_submodule_relative_url "(null)" "$PWD/." "../." "$(pwd)/."
> +test_submodule_relative_url "(null)" "$(pwd)/." "../." "$(pwd)/."
>  test_submodule_relative_url "(null)" "$PWD" "./." "$(pwd)/."
>  test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$(pwd)/repo"
>  test_submodule_relative_url "(null)" "$PWD" "./ " "$(pwd)/ "
> -test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$(pwd)/submodule"
> +test_submodule_relative_url "(null)" "$(pwd)/." "../submodule" "$(pwd)/submodule"
>  test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule" "$(pwd)/submodule"
>  test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bundle1" "$(pwd)/home2/../bundle1"
>  test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" "./." "$(pwd)/submodule_update_repo/."
> -- snap --
>
> The reasons this is ugly: we specifically test for *Unixy* paths when we
> use $PWD, as opposed to *Windowsy* paths when using $(pwd). We do this to
> ensure a certain level of confidence that running things such as
>
>         git clone --recurse-submodules /z/project/.
>
> work. And now that does not work anymore.

After a while of thinking how I could fix it, it occurs to me, I could
claim the removal of the dot as a defect in the Windows path handling. ;)
But that doesn't help users.

Would it be possible to mark the last dir separator special once the
trailing dot is removed? (i.e. put a \ there, and in this patch we
only check for /)
Sounds hacky to me, though.

>
> So where to go from here?

So IIUC this patch fixed a bug in Git and introduced a very similar bug
in Git for Windows?

I have no expertise on how to deal with these path issues, but it sounds like
this dot-stripping is done too early, i.e. you'd want to first let the
Git part handle
the URL concatenation and stuff and only at the end when it comes to using
the path it should get the Windows treatment?

Thanks,
Stefan

>
> Ciao,
> Dscho
