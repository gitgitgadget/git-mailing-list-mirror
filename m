Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765FD2027C
	for <e@80x24.org>; Tue, 30 May 2017 21:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751056AbdE3VWA (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 17:22:00 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36675 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdE3VWA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 17:22:00 -0400
Received: by mail-qk0-f195.google.com with SMTP id y128so13597446qka.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qxcNwLPx91EWpz2fWbbkkfd/FdIPw1KhJWlidwkBcKU=;
        b=M4MwjZd632H8ePFcSbhoUe0ZAKQFFAfJ2PbMZNDjVQ7Maj1/tuurPPnAXodQ8MrjMD
         8mIxDuzyYbGp4/bhPwuVs3MZ9npalYGRlBLtktZY40ezo4ZPPnIE2+Zl17lILLWJxwe4
         VgBHwWHhGJWaj7woghKth0LUIwi1Dy0jwCpKPDVdhgz2Gl9unaPAiYqA2Vlx63s6N/ku
         NfUpNj7y43k6tqRyGIApUjc7fPu1PcnLAD7yrRXekpSh3b+T2v6Br0f+KUQvZ0iPWv6c
         E5ys+oNzTX3TgR7m0d3uGF3aC2XiQ7QBqPN2ogKupWe2LZF9IZR00TpRgWh9sOaNnGAQ
         KOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qxcNwLPx91EWpz2fWbbkkfd/FdIPw1KhJWlidwkBcKU=;
        b=tgju2JuzTDZqAJ6Dt+0LBW5AnAuUH348hiyB11vdZ4A0WdQebjb+m+HKzcpvKsG5Zy
         PakJrEuq2zaf9YUIpmQTxje1ammHlBC2lbVqDYF2Sv5s4y36humZQnlMDRmGw/xznqK7
         PL93kQkP058Cia3OzHKMe4LwDYPMPBUerH0Ato2qw1RcVOSTvS9bFReqHjwQ9t9w1yfb
         +5sKyUnkqtgS2hYQ+iN0cfAfJEm2Avgu/dB/MUkqTRrky4pg8EbbpFHEgHthAB1YnXLt
         dHsgXIqAKQ+BowiCr75ZKPuTgEEDi4izwrYWYujlVhMM9OR8/Hj/r98CDY22kjvN2jPT
         XHRg==
X-Gm-Message-State: AODbwcBhaKtrq3T+KejHtm7gcvTXNNtw+fQq2odLwgYWyJSadozULlgI
        VGOtPDsHuQg/bA==
X-Received: by 10.55.69.72 with SMTP id s69mr24622236qka.175.1496179313842;
        Tue, 30 May 2017 14:21:53 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id r10sm9145936qtb.15.2017.05.30.14.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 May 2017 14:21:53 -0700 (PDT)
Subject: Re: [PATCH v3 4/6] fsmonitor: add test cases for fsmonitor extension
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
References: <20170525183612.3128-1-benpeart@microsoft.com>
 <20170525183612.3128-5-benpeart@microsoft.com>
 <CAP8UFD0OEUogQYL5Eo1kBy_1B=dBcdEJyc4B_qAUOU=2XnrxxA@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <bfab707a-7f3a-ca7d-1f67-66dcb6ab2ea6@gmail.com>
Date:   Tue, 30 May 2017 17:21:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD0OEUogQYL5Eo1kBy_1B=dBcdEJyc4B_qAUOU=2XnrxxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/30/2017 9:18 AM, Christian Couder wrote:
> On Thu, May 25, 2017 at 8:36 PM, Ben Peart <peartben@gmail.com> wrote:
> 
> [...]
> 
>> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
>> new file mode 100755
>> index 0000000000..395db46d55
>> --- /dev/null
>> +++ b/t/t7519-status-fsmonitor.sh
>> @@ -0,0 +1,158 @@
>> +#!/bin/sh
>> +
>> +test_description='git status with file system watcher'
>> +
>> +. ./test-lib.sh
>> +
>> +clean_repo () {
>> +       git reset --hard HEAD
>> +       git clean -fd
>> +       rm -f marker
>> +}
> 
> Maybe link all the commands in the function with "&&".
> 
>> +dirty_repo () {
>> +       : >untracked
>> +       : >dir1/untracked
>> +       : >dir2/untracked
>> +       echo 1 >modified
>> +       echo 2 >dir1/modified
>> +       echo 3 >dir2/modified
>> +       echo 4 >new
>> +       echo 5 >dir1/new
>> +       echo 6 >dir2/new
>> +       git add new
>> +       git add dir1/new
>> +       git add dir2/new
>> +}
> 
> Idem.
> 

I did a quick search through the existing test scripts and the majority 
do not link commands together with && when they are in a sub function 
like this.  I find not having them linked together is easier to write, 
maintain and is more readable.

>> +# The test query-fsmonitor hook proc will output a marker file we can use to
>> +# ensure the hook was actually used to generate the correct results.
>> +
>> +test_expect_success 'setup' '
>> +       mkdir -p .git/hooks &&
>> +       write_script .git/hooks/query-fsmonitor<<-\EOF &&
>> +       if [ $1 -ne 1 ]
>> +       then
>> +               echo -e "Unsupported query-fsmonitor hook version.\n" >&2
>> +               exit 1;
>> +       fi
>> +       : >marker
>> +       printf "untracked\0"
>> +       printf "dir1/untracked\0"
>> +       printf "dir2/untracked\0"
>> +       printf "modified\0"
>> +       printf "dir1/modified\0"
>> +       printf "dir2/modified\0"
>> +       printf "new\0""
>> +       printf "dir1/new\0"
>> +       printf "dir2/new\0"
> 
> Maybe something like the following to save a few lines and remove some
> redundancies:
> 
>         printf "%s\0" untracked dir1/untracked dir2/untracked \
>                               modified dir1/modified dir2/modified \
>                               new dir1/new dir2/new
> 
> or perhaps:
> 
>         for f in untracked modified new
>         do
>                printf "%s\0" "$f" "dir1/$f" "dir2/$f"
>         done
> 

That is a clever solution that certainly is fewer lines of code. 
However, I have to read the loop and think through the logic to figure 
out what it is doing vs the existing implementation where what it is 
doing is apparent from just glancing at the code.  I was also trying to 
maintain consistency with the other status test code in t7508-status.sh

>> +       EOF
>> +       : >tracked &&
>> +       : >modified &&
>> +       mkdir dir1 &&
>> +       : >dir1/tracked &&
>> +       : >dir1/modified &&
>> +       mkdir dir2 &&
>> +       : >dir2/tracked &&
>> +       : >dir2/modified &&
>> +       git add . &&
>> +       test_tick &&
>> +       git commit -m initial &&
>> +       dirty_repo
>> +'
>> +
>> +cat >.gitignore <<\EOF
>> +.gitignore
>> +expect*
>> +output*
>> +marker*
>> +EOF
> 
> This could be part of the previous setup test.
> 

I had followed the pattern in t7508-status.sh with this but I can move 
it in if that is the preferred model.

>> +# Status is well tested elsewhere so we'll just ensure that the results are
>> +# the same when using core.fsmonitor. First call after turning on the option
>> +# does a complete scan so need to do two calls to ensure we test the new
>> +# codepath.
>> +
>> +test_expect_success 'status with core.untrackedcache true' '
> 
> If this test is using untracked cache, it should perhaps first check
> that untracked cache can be used on the current file system.
> t7063-status-untracked-cache.sh does that with the following:
> 
> test_lazy_prereq UNTRACKED_CACHE '
>      { git update-index --test-untracked-cache; ret=$?; } &&
>      test $ret -ne 1
> '
> 
> if ! test_have_prereq UNTRACKED_CACHE; then
>      skip_all='This system does not support untracked cache'
>      test_done
> fi
> 

Good point. I'll change it so that untracked cache is only turned on if 
it is available and that the one test that requires it is skipped if it 
isn't available.

>> +       git config core.fsmonitor true  &&
>> +       git config core.untrackedcache true &&
>> +       git -c core.fsmonitor=false -c core.untrackedcache=true status >expect &&
> 
> I don't understand why there is " -c core.untrackedcache=true" in the
> above command as you already set core.untrackedcache to true on the
> previous line.
> 

Defensive programming. :) The global setting was to ensure it was set 
when the test sub-functions clean and dirty were called and the command 
line settings were used to make it explicit what was being tested.  I 
can remove them if it is causing confusion.

>> +       clean_repo &&
>> +       git status &&
>> +       test_path_is_missing marker &&
>> +       dirty_repo &&
>> +       git status >output &&
>> +       test_path_is_file marker &&
>> +       test_i18ncmp expect output
>> +'
>> +
>> +
> 
> Spurious new line.
> 

Fixed

>> +test_expect_success 'status with core.untrackedcache false' '
>> +       git config core.fsmonitor true &&
>> +       git config core.untrackedcache false &&
>> +       git -c core.fsmonitor=false -c core.untrackedcache=false status >expect &&
> 
> Again core.untrackedcache is already set to false on the previous line.
> 
>> +       clean_repo &&
>> +       git status &&
>> +       test_path_is_missing marker &&
>> +       dirty_repo &&
>> +       git status >output &&
>> +       test_path_is_file marker &&
>> +       test_i18ncmp expect output
>> +'
>> +
>> +# Ensure commands that call refresh_index() to move the index back in time
>> +# properly invalidate the fsmonitor cache
>> +
>> +test_expect_success 'refresh_index() invalidates fsmonitor cache' '
>> +       git config core.fsmonitor true &&
>> +       git config core.untrackedcache true &&
>> +       clean_repo &&
>> +       git status &&
>> +       test_path_is_missing marker &&
>> +       dirty_repo &&
>> +       write_script .git/hooks/query-fsmonitor<<-\EOF &&
>> +       :>marker
>> +       EOF
>> +       git add . &&
>> +       git commit -m "to reset" &&
>> +       git status &&
>> +       test_path_is_file marker &&
>> +       git reset HEAD~1 &&
>> +       git status >output &&
>> +       test_path_is_file marker &&
> 
> You already checked that "marker" exists 3 lines above, and as far as
> I can see nothing could remove this file since the previous test, as
> the hook can only create it.
> So I wonder if something is missing or if this test is redundant.
> 

Testing it each time ensures it is being created when it is supposed to 
be (ie when the test believes it is using the query-fsmonitor hook) and 
that it isn't when it isn't supposed to be (ie when the hook should not 
be called).

>> +       git -c core.fsmonitor=false status >expect &&
>> +       test_i18ncmp expect output
>> +'
>> +
>> +# Now make sure it's actually skipping the check for modified and untracked
>> +# files unless it is told about them.  Note, after "git reset --hard HEAD" no
>> +# extensions exist other than 'TREE' so do a "git status" to get the extension
>> +# written before testing the results.
>> +
>> +test_expect_success 'status doesnt detect unreported modifications' '
> 
> Maybe:
> 
> test_expect_success "status doesn't detect unreported modifications" '

Fixed

> 
>> +       git config core.fsmonitor true &&
>> +       git config core.untrackedcache true &&
>> +       write_script .git/hooks/query-fsmonitor<<-\EOF &&
>> +       :>marker
>> +       EOF
>> +       clean_repo &&
>> +       git status &&
>> +       test_path_is_missing marker &&
>> +       : >untracked &&
>> +       echo 2 >dir1/modified &&
>> +       git status >output &&
>> +       test_path_is_file marker &&
>> +       test_i18ngrep ! "Changes not staged for commit:" output &&
>> +       test_i18ngrep ! "Untracked files:" output &&
>> +       write_script .git/hooks/query-fsmonitor<<-\EOF &&
>> +       :>marker
>> +       printf "untracked%s\0"
> 
> Why is there a %s in the above?

Fixed

> 
>> +       printf "dir1/modified\0"
>> +       EOF
>> +       git status >output &&
>> +       test_path_is_file marker &&
>> +       test_i18ngrep "Changes not staged for commit:" output &&
>> +       test_i18ngrep "Untracked files:" output
>> +'
>> +
>> +test_done
>> --
>> 2.13.0.windows.1.9.gc201c67b71
>>
