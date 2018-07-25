Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8E01F597
	for <e@80x24.org>; Wed, 25 Jul 2018 09:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbeGYKZi (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 06:25:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43311 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeGYKZi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 06:25:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id b15-v6so6643792wrv.10
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 02:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=FRTTULSnPUE99Y64mADZtWHcVUMYfuKL+syRSPslCUQ=;
        b=l9V5MDTIxGKAgEmi6eOaKgVpLIgXfQTRI+2sozN0YY/Oyka6BHZPkEFttkVVfhsReU
         ABpdgpE2StBJBtD617S2EAQLFd+9+XwhIJMz1x0WzeglF7wA0IV/5AlE6AQ1Fbt6530K
         dBcCIyZXC6t+3rxUsE6Y4lpgT7tKkHucH0iOKqjkn5XQJiABc/BShtpTESjVbraMDKy2
         MYUGzH6CISlQLX+XboykbZrRAVyZSUtmRQNccFnq1TlJKfKjxOJAIPNvTeCn7Zy3/Rvt
         vjv1DON5RsMWuhcrr1IMVITkz4Hc/80Dn5/bNVeuilt7oUvwIREl5r2Hx3eRBDhiRgZf
         yKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=FRTTULSnPUE99Y64mADZtWHcVUMYfuKL+syRSPslCUQ=;
        b=qZeZOYnLw+xgbzR22TwWnCYy9g2iMvP+AJneHoNII1pV6uWNm73MqZ19bih3YkhXp/
         AgVMi5obe18zEZAo1FC/YjCyQy7RQ1b28mEeUV2NUuE1aiorppe1B1Fo8kWIy5PF1/f7
         brh6MsaOujLiMMszMRiB9H15Du5PdHkl2e9vijR7a7yhTUHt6qLKFluWd2WTp1jxIpl3
         rdEGNR1LbCFrzXl4ov/jFnLZPGM76SVW7cG4/K5ELDFLx7Lv5OZLQJroODQHNpSFFvyw
         /siLt5Z38kajyA/QMtWXlp4ubM8vZ2/KI295oA/hkk4avS/sp0Z3vrTIvzB5ZnwhCPOj
         /9iA==
X-Gm-Message-State: AOUpUlF94cGEMk8e5SXoZeAHj03t9bVFszeLEMwOG4FWlosJKu/4VDwg
        NDhb/bKUFt+3jSYhDlOczLs=
X-Google-Smtp-Source: AAOMgpdqJKv3vSNn8gIh6CSbTm5IVwqr05kRx6qabEVNpwjkH73soc9R10AIJwACtdKVp5CQZd+fXQ==
X-Received: by 2002:a5d:4147:: with SMTP id c7-v6mr14513044wrq.61.1532510089701;
        Wed, 25 Jul 2018 02:14:49 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id i125-v6sm8002857wmd.23.2018.07.25.02.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 02:14:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Chen Bin <chenbin.sh@gmail.com>, Git ML <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] add hook pre-p4-submit
References: <20180723112736.15088-1-chenbin.sh@gmail.com> <CAE5ih79ndEbnEeV_muQyZwG+01_8Kg0J74rZtOoK1_V40E0z7g@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAE5ih79ndEbnEeV_muQyZwG+01_8Kg0J74rZtOoK1_V40E0z7g@mail.gmail.com>
Date:   Wed, 25 Jul 2018 11:14:47 +0200
Message-ID: <87tvonbrso.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 25 2018, Luke Diamand wrote:

> On 23 July 2018 at 12:27, Chen Bin <chenbin.sh@gmail.com> wrote:
>> Hook pre-p4-submit is executed before git-p4 actually submits code.
>> If the hook exits with non-zero value, submit process will abort.
>
>
> Looks good to me - could you add some documentation please
> (Documentation/git-p4.txt).
>
> Thanks!
> Luke

This looks correct (and you'd know better), but I was surprised that we
wouldn't just document this in githooks(5), but looking at git-p4 I see
that we have its config documented there, not in git-config(1) (ditto
some git-svn config stuff).

Shouldn't we at least update githooks & git-config to say that the
config / hooks documentation for these utilities can be found there?

>>
>> Signed-off-by: Chen Bin <chenbin.sh@gmail.com>
>> ---
>>  git-p4.py               |  6 ++++++
>>  t/t9800-git-p4-basic.sh | 22 ++++++++++++++++++++++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index b449db1cc..69ee9ce41 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2303,6 +2303,12 @@ def run(self, args):
>>              sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
>>                       (len(commits), num_shelves))
>>
>> +        # locate hook at `.git/hooks/pre-p4-submit`
>> +        hook_file = os.path.join(read_pipe("git rev-parse --git-dir").strip(), "hooks", "pre-p4-submit")
>> +        # Execute hook. If it exit with non-zero value, do NOT continue.
>> +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
>> +            sys.exit(1)
>> +
>>          #
>>          # Apply the commits, one at a time.  On failure, ask if should
>>          # continue to try the rest of the patches, or quit.
>> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
>> index 4849edc4e..48b768fa7 100755
>> --- a/t/t9800-git-p4-basic.sh
>> +++ b/t/t9800-git-p4-basic.sh
>> @@ -261,6 +261,28 @@ test_expect_success 'unresolvable host in P4PORT should display error' '
>>         )
>>  '
>>
>> +# Test following scenarios:
>> +#   - Without hook ".git/hooks/pre-p4-submit", submit should continue
>> +#   - With hook returning 0, submit should continue
>> +#   - With hook returning 1, submit should abort
>> +test_expect_success 'run hook pre-p4-submit before submit' '
>> +       test_when_finished cleanup_git &&
>> +       git p4 clone --dest="$git" //depot &&
>> +       (
>> +               cd "$git" &&
>> +               echo "hello world" >hello.txt &&
>> +               git add hello.txt &&
>> +               git commit -m "add hello.txt" &&
>> +               git config git-p4.skipSubmitEdit true &&
>> +               git p4 submit --dry-run | grep "Would apply" &&
>> +               mkdir -p .git/hooks &&
>> +               : >.git/hooks/pre-p4-submit && chmod +x .git/hooks/pre-p4-submit &&
>> +               git p4 submit --dry-run | grep "Would apply" &&
>> +               echo #!/bin/sh && echo exit 1 >.git/hooks/pre-p4-submit &&
>> +               git p4 submit --dry-run | grep "Would apply" || echo "Abort submit"
>> +       )
>> +'
>> +
>>  test_expect_success 'submit from detached head' '
>>         test_when_finished cleanup_git &&
>>         git p4 clone --dest="$git" //depot &&
>> --
>> 2.18.0
>>
