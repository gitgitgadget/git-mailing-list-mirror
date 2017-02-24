Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17647201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 19:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbdBXTJp (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 14:09:45 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:37560 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbdBXTJo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 14:09:44 -0500
Received: by mail-it0-f48.google.com with SMTP id 203so33215546ith.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 11:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E9fLZZRxgMyNmNk0U9ePi8hPtLmfCFxJvikVwA91BKk=;
        b=lij4f/Vy5lTf0B6WnVRRFBLu6zNYCa4+9nqX1jUkbcETxnLJmdIk5qi1CARrfAEWg4
         AKlii/+84Wota/rZXdWv0n5zeskuuIeBCzinjTNTBRaouvhJFhiPXTYv4xmCBww5hGmI
         DtLnUFLiIp/9ygutbvSyhjpya6K5ITuz2CO4MamBSk0RF9qMF4SQrF/oLP5OfjR4mrq3
         ukVWd0JV9R3XJBHOCWDKDDn8VbNEFB1gCqxMd636fRaMvKBpiODP6rPM1csqyJ+dDL2h
         44ARD47mA1DbaRrF+R1BXV6MglZu1L05FAEgNtomUSrifjkBmGJ8hucfWMTdNifs+0gm
         ICBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E9fLZZRxgMyNmNk0U9ePi8hPtLmfCFxJvikVwA91BKk=;
        b=Q925IA8Nk4PQPg8QFzzQX8Ivd+I8G+6e1qplDuJMcz00MqEi5J62H9L44dZtZuDFke
         6wJg6mPL5IbqCYm4g6YwvhFV2lAVGr81nYXthIjw99MktJqMAYsYfw4HTre0sdAMoyTE
         w5MyTfzb+YRChJQcZcYWw6P5jxbxktx5OPPZlNFzabJu42TembBoJJ42QzD4UtZa+jpG
         7z7gH2AOGr6Uky/jhC+6KYTW0NoDksgev4tOplZfowsJZV7QEEm7cAHKyeVzxvtvD+hJ
         g4bwvtVrfQ/ftbGwAR2L735q77RnrcwG5dn0uTK3111QVf64Pok/bdroXoWeNGREL11V
         VLiQ==
X-Gm-Message-State: AMke39mNvqfD6QtUOBdOqBoD75yh4JeSzEOqL1yhZBr+RqKrAdpw+Xlvx212/qsTMyYpKhsSboXRbDD66C//0Wl+
X-Received: by 10.107.16.14 with SMTP id y14mr3722521ioi.164.1487963293012;
 Fri, 24 Feb 2017 11:08:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Fri, 24 Feb 2017 11:08:12 -0800 (PST)
In-Reply-To: <7e920dd5-3638-57d9-0ca1-3f8aed4d700b@ramsayjones.plus.com>
References: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com> <20170223225735.10994-1-sbeller@google.com>
 <20170223225735.10994-11-sbeller@google.com> <7e920dd5-3638-57d9-0ca1-3f8aed4d700b@ramsayjones.plus.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 24 Feb 2017 11:08:12 -0800
Message-ID: <CAGZ79kZX=ZmHDbBhgApHTKhyXz489V5XQXPvUhfLyRjYhTfVJA@mail.gmail.com>
Subject: Re: [PATCH 10/15] update submodules: add submodule_move_head
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 5:21 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 23/02/17 22:57, Stefan Beller wrote:
>> In later patches we introduce the options and flag for commands
>> that modify the working directory, e.g. git-checkout.
>>
>> This piece of code will be used universally for
>> all these working tree modifications as it
>> * supports dry run to answer the question:
>>   "Is it safe to change the submodule to this new state?"
>>   e.g. is it overwriting untracked files or are there local
>>   changes that would be overwritten?
>> * supports a force flag that can be used for resetting
>>   the tree.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  submodule.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  submodule.h |   7 ++++
>>  2 files changed, 142 insertions(+)
>>
>> diff --git a/submodule.c b/submodule.c
>> index 0b2596e88a..a2cf8c9376 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1239,6 +1239,141 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
>>       return ret;
>>  }
>>
>> +static int submodule_has_dirty_index(const struct submodule *sub)
>> +{
>> +     struct child_process cp = CHILD_PROCESS_INIT;
>> +
>> +     prepare_submodule_repo_env_no_git_dir(&cp.env_array);
>> +
>> +     cp.git_cmd = 1;
>> +     argv_array_pushl(&cp.args, "diff-index", "--quiet", \
>> +                                     "--cached", "HEAD", NULL);
>> +     cp.no_stdin = 1;
>> +     cp.no_stdout = 1;
>> +     cp.dir = sub->path;
>> +     if (start_command(&cp))
>> +             die("could not recurse into submodule '%s'", sub->path);
>> +
>> +     return finish_command(&cp);
>> +}
>> +
>> +void submodule_reset_index(const char *path)
>
> I was just about to send a patch against the previous series
> (in pu branch last night), but since you have sent another
> version ...
>
> In the last series this was called 'submodule_clean_index()'
> and, since it is a file-local symbol, should be marked with
> static. I haven't applied these patches to check, but the
> interdiff in the cover letter leads me to believe that this
> will also apply to the renamed function.
>
> [The patch subject was also slightly different.]
>

good catch. Yes submodule_reset_index
ought to be static.

fixed in a reroll.
