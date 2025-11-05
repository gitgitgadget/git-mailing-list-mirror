Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA55E321422
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369858; cv=none; b=Rul0Y5ZJYlKjHfjfth5YWJ4soc7TWfGWf326kXX84eaOSSsiGSitzU5Y3SDG72pB14TtPcq4kY9gVe8Lsc0V3SNltPqg68kyIk7nYEKegLckWhGo7dyx8IULGrLCAYR8f2XwvyaPKJ8IT/K+alrTiKnBCG2wnRbq34+IF7VjISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369858; c=relaxed/simple;
	bh=qt0dP7xBxQHbGP/qBd9yb7Pagr9D/DncMLSQ7Isd1kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WN+ZEwQU9vnQ/WUy5YThX19tAwVCQMdnexPLLkEA4ds6RGNkNI26pU09hEpz5fjGgzYevF7Lfs4tzfgj2gO/CP59BufhSrOGKSGTPYCg7FKmMcWRLL4bEIqLDnl4tDASjsIAVi52Vv3StlP4/wRhR3+X33bjqZTiahiA3RBmg6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPyLFkuR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPyLFkuR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29524c38f4fso2533475ad.2
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 11:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762369856; x=1762974656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VJQvNCJjF3p2J67ekaFlg1csuwxba8txGM8DZh1/z+E=;
        b=nPyLFkuRtYMDTYj1lZ3rdRGGHV1t3ZzoAld7TjSo5gQmMam2izUzk8gAAzjymQ4osz
         cLqN5sct7iWD97JdvAs0P3mDr4uqxbfQ67eytHYPmd4upKVFZzOYRqNqR6so0E42mlJe
         xP9i7g3UgqDmp51RIHXs3VVbX84YZ2RYkii6sjB0xxDKi0jeY3SkAx5QKETlFlwAF9J6
         YLE20uDh39rPs/aq1ZeetSzp5NjCrT3IjygURK5JzF1h4823QKKkF/n2LOVIEoG5e/73
         4scR69iCYXcECEiPCrLFL19BsObXRzCm4nQU2HEiOvmXVp3L7LhCaHL+ZfkAhaQJLUYv
         0Ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369856; x=1762974656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJQvNCJjF3p2J67ekaFlg1csuwxba8txGM8DZh1/z+E=;
        b=quDTzYcjJkVHiyTbyMZK6YZMRvn8bwLb7n+EyEXg9yPt9abNsQFPD+OCdLK3DI3V4D
         PKL17MBZMh0E0A9hpZMVETwhpnoxsNv1unV+EyijiG868jZ0QuQdyh41iTOA4myOXdJO
         8BQF4KS7MWcKFnzpI5cn54yT+/UeSU+ghdmn4a/siXV6Hcnfu1vNAdRJQwEs25lq04tE
         Npl20ORy25SIhwQdDfxeZWiCNgVLW7gic4W/ynNUY0ZOAiJAWrE5vq/M2xdIxTnaX9DR
         fNdTmACHUyKVT8ubUoPr0p/Jmv3d3ld4Rz/JgrUTFSeyPYPYXiJifkiQcD1IlgiWCYT2
         erAw==
X-Gm-Message-State: AOJu0YxQHqu+6WkVqvs2sBNujuZvXg7qxoWFpKl0BIM5TiGhWRxNL/zz
	fM5HL5rfYqF1aE18r9/hnxNUumPeuNCmQnhkRqWTG4NxmXserstPR7E/
X-Gm-Gg: ASbGncujcijhlNug48vUo68U8Tde/euLRpRxdaztqyTI1Q0vaee1f3iUVrVAAdduVu4
	cf/OzzkSykW7AibDiE1nhaJ91E5dp5RTs/ktFMs/ehZEOuH9hWJWIR5gxqRkdUpfhLn3NgocXvc
	s9j0mS/2DkTEmer1ekW9AegA54j6IpR1mtuIqJryRDqmkp+y6Mq98ASPhwMW60+CAIL+hrj5kRr
	lB/x3Eiirqx0/QRYSevowl+bPz0z4Qb8ho0lFUpj/paTuLHf9dXGB+FSlLrnja0oQY2SDzyHiTz
	s/8K96i2t2YQLNWLopfKdPraZCKNGich8hTwIwuULLrY/QHPC4KT03pYrv6mNsey0xLhGh1WctZ
	D0SJZ7t82CjRwjwZpkM5474JCeQYnqKHH7NOBJjo1dUhTbFKqOe1xl5969j1+ajwEGR+VTA/mZG
	oPX+hIgi78DxYIv+ezO87tPM5L4v6wF8gr/iYPCsLT5TProlde5c98vGn8NM5lsuI+mPHcIXvHd
	3T/4i5GUzpyHTj52n2CAJZ6S/GJHKkPP8oGAc4GRZ6k+V5RR4KXaO6vzEGoKOdQMg==
X-Google-Smtp-Source: AGHT+IGKvEx91sKz/oEzzk0aqf3cBSIE0tx4oXNA3wRMycFsLO5/7r8l9FixKKQorW9FOM00U9ROAA==
X-Received: by 2002:a17:903:138a:b0:295:21ac:352b with SMTP id d9443c01a7336-2962ad1efcamr69545725ad.15.1762369856010;
        Wed, 05 Nov 2025 11:10:56 -0800 (PST)
Received: from ?IPV6:2409:40e3:177:42ef:11ba:85fd:f5fe:a9a5? ([2409:40e3:177:42ef:11ba:85fd:f5fe:a9a5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968602sm3063485ad.9.2025.11.05.11.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:10:55 -0800 (PST)
Message-ID: <3d1dcfe2-3d41-4c96-b44f-0611b11ce853@gmail.com>
Date: Thu, 6 Nov 2025 00:40:48 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] replay: add replay.refAction config option
Content-Language: en-GB
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
 phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk, gitster@pobox.com,
 ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251028214609.10041-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-4-siddharthasthana31@gmail.com>
 <CABPp-BE_pAQ8f-jjv16Ts-KRTEr3Qc402qRuJKFFW6G3J9shtA@mail.gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CABPp-BE_pAQ8f-jjv16Ts-KRTEr3Qc402qRuJKFFW6G3J9shtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 01/11/25 00:19, Elijah Newren wrote:
> On Thu, Oct 30, 2025 at 12:20 PM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>> Add a configuration option to control the default behavior of git replay
>> for updating references. This allows users who prefer the traditional
>> pipeline output to set it once in their config instead of passing
>> --ref-action=print with every command.
>>
>> The config option uses string values that mirror the behavior modes:
>>    * replay.refAction = update (default): atomic ref updates
>>    * replay.refAction = print: output commands for pipeline
>>
>> The command-line --ref-action option always overrides the config setting,
>> allowing users to temporarily change behavior for a single invocation.
> The above paragraph merely states that we follow git practices with
> this config options and its corresponding command line; I think we'd
> need to call it out if we didn't do that, but calling out that we do
> follow git conventions seems unnecessary.


Fair point. Will remove the paragraph about command-line precedence.


>
>> Implementation details:
>>
>> In cmd_replay(), after parsing command-line options, we check if
>> --ref-action was provided. If not, we read the configuration using
>> repo_config_get_string_tmp(). If the config variable is set, we validate
>> the value and use it to set the ref_action_str:
>>
>>    Config value      Internal mode    Behavior
>>    ──────────────────────────────────────────────────────────────
>>    "update"          "update"         Atomic ref updates (default)
>>    "print"           "print"          Pipeline output
>>    (not set)         "update"         Atomic ref updates (default)
>>    (invalid)         error            Die with helpful message
>>
>> If an invalid value is provided, we die() immediately with an error
>> message explaining the valid options. This catches configuration errors
>> early and provides clear guidance to users.
>>
>> The command-line --ref-action option, when provided, overrides the
>> config value. This precedence allows users to set their preferred default
>> while still having per-invocation control:
>>
>>    git config replay.refAction print         # Set default
>>    git replay --ref-action=update --onto main topic  # Override once
>>
>> The config and command-line option use the same value names ('update'
>> and 'print') for consistency and clarity. This makes it immediately
>> obvious how the config maps to the command-line option, addressing
>> feedback about the relationship between configuration and command-line
>> options being clear to users.
> An implementation details section may make sense if it answers a
> "why?" question, or it explains something counter-intuitive, or it
> provides high enough level details that it makes the patch easier to
> read/follow, or it otherwise does something more than just repackage
> the patch in an alternate format.  I appreciate the attempt to provide
> these, but I think they simply make the commit message longer without
> adding value.


Understood. Will remove the implementation details and configuration 
precedence table—they're just restating what's in the code.


>
>> Examples:
>>
>> $ git config --global replay.refAction print
>> $ git replay --onto main topic1..topic2 | git update-ref --stdin
>>
>> $ git replay --ref-action=update --onto main topic1..topic2
>>
>> $ git config replay.refAction update
>> $ git replay --onto main topic1..topic2  # Updates refs directly
>>
>> The implementation follows Git's standard configuration precedence:
>> command-line options override config values, which matches user
>> expectations across all Git commands.
> I don't find the Examples section helpful either; it's yet another
> re-iteration that we're following conventions.


Will remove the Examples section too.


>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Helped-by: Elijah Newren <newren@gmail.com>
>> Helped-by: Christian Couder <christian.couder@gmail.com>
>> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
>> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
>> ---
>>   Documentation/config/replay.adoc | 11 ++++++++
>>   builtin/replay.c                 | 39 ++++++++++++++++++--------
>>   t/t3650-replay-basics.sh         | 48 +++++++++++++++++++++++++++++++-
>>   3 files changed, 86 insertions(+), 12 deletions(-)
>>   create mode 100644 Documentation/config/replay.adoc
>>
>> diff --git a/Documentation/config/replay.adoc b/Documentation/config/replay.adoc
>> new file mode 100644
>> index 0000000000..7d549d2f0e
>> --- /dev/null
>> +++ b/Documentation/config/replay.adoc
>> @@ -0,0 +1,11 @@
>> +replay.refAction::
>> +       Specifies the default mode for handling reference updates in
>> +       `git replay`. The value can be:
>> ++
>> +--
>> +       * `update`: Update refs directly using an atomic transaction (default behavior).
>> +       * `print`: Output update-ref commands for pipeline use.
>> +--
>> ++
>> +This setting can be overridden with the `--ref-action` command-line option.
>> +When not configured, `git replay` defaults to `update` mode.
>> diff --git a/builtin/replay.c b/builtin/replay.c
>> index 0564d4d2e7..810068f8ef 100644
>> --- a/builtin/replay.c
>> +++ b/builtin/replay.c
>> @@ -8,6 +8,7 @@
>>   #include "git-compat-util.h"
>>
>>   #include "builtin.h"
>> +#include "config.h"
>>   #include "environment.h"
>>   #include "hex.h"
>>   #include "lockfile.h"
>> @@ -289,6 +290,31 @@ static struct commit *pick_regular_commit(struct repository *repo,
>>          return create_commit(repo, result->tree, pickme, replayed_base);
>>   }
>>
>> +static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const char *source)
>> +{
>> +       if (!ref_action || !strcmp(ref_action, "update"))
>> +               return REF_ACTION_UPDATE;
>> +       if (!strcmp(ref_action, "print"))
>> +               return REF_ACTION_PRINT;
>> +       die(_("invalid %s value: '%s'"), source, ref_action);
>> +}
>> +
>> +static enum ref_action_mode get_ref_action_mode(struct repository *repo, const char *ref_action_str)
>> +{
>> +       const char *config_value = NULL;
>> +
>> +       /* Command line option takes precedence */
>> +       if (ref_action_str)
>> +               return parse_ref_action_mode(ref_action_str, "--ref-action");
>> +
>> +       /* Check config value */
>> +       if (!repo_config_get_string_tmp(repo, "replay.refAction", &config_value))
>> +               return parse_ref_action_mode(config_value, "replay.refAction");
>> +
>> +       /* Default to update mode */
>> +       return REF_ACTION_UPDATE;
>> +}
>> +
>>   static int handle_ref_update(enum ref_action_mode mode,
>>                               struct ref_transaction *transaction,
>>                               const char *refname,
>> @@ -367,17 +393,8 @@ int cmd_replay(int argc,
>>          die_for_incompatible_opt2(!!advance_name_opt, "--advance",
>>                                    contained, "--contained");
>>
>> -       /* Default to update mode if not specified */
>> -       if (!ref_action_str)
>> -               ref_action_str = "update";
>> -
>> -       /* Parse ref action mode */
>> -       if (!strcmp(ref_action_str, "update"))
>> -               ref_action = REF_ACTION_UPDATE;
>> -       else if (!strcmp(ref_action_str, "print"))
>> -               ref_action = REF_ACTION_PRINT;
>> -       else
>> -               die(_("unknown --ref-action mode '%s'"), ref_action_str);
>> +       /* Parse ref action mode from command line or config */
>> +       ref_action = get_ref_action_mode(repo, ref_action_str);
>>
>>          advance_name = xstrdup_or_null(advance_name_opt);
>>
>> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
>> index 123734b49f..2e90227c2f 100755
>> --- a/t/t3650-replay-basics.sh
>> +++ b/t/t3650-replay-basics.sh
>> @@ -219,7 +219,8 @@ test_expect_success 'merge.directoryRenames=false' '
>>
>>   test_expect_success 'default atomic behavior updates refs directly' '
>>          # Store original state for cleanup
>> -       test_when_finished "git branch -f topic2 topic1" &&
>> +       START=$(git rev-parse topic2) &&
>> +       test_when_finished "git branch -f topic2 $START" &&
> Yes, these three lines are a good fix, but they belong in the previous patch.


Right—the START/test_when_finished cleanup fixes should go in commit 2.


>
>>          # Test default atomic behavior (no output, refs updated)
>>          git replay --onto main topic1..topic2 >output &&
>> @@ -232,6 +233,10 @@ test_expect_success 'default atomic behavior updates refs directly' '
>>   '
>>
>>   test_expect_success 'atomic behavior in bare repository' '
>> +       # Store original state for cleanup
>> +       START=$(git rev-parse topic2) &&
>> +       test_when_finished "git branch -f topic2 $START" &&
> Yes, these three lines are good but they belong in a separate patch.


The bare repo cleanup fix should also go in commit 2.


>> +
>>          # Test atomic updates work in bare repo
>>          git -C bare replay --onto main topic1..topic2 >output &&
>>          test_must_be_empty output &&
>> @@ -245,4 +250,45 @@ test_expect_success 'atomic behavior in bare repository' '
>>          git -C bare update-ref refs/heads/topic2 $(git -C bare rev-parse topic1)
> And this line should be removed in the previous patch.


Will remove the manual reset line from commit 2.

Thanks for pointing out which fixes belong where!


>
>>   '
>>
>> +test_expect_success 'replay.refAction config option' '
>> +       # Store original state
>> +       START=$(git rev-parse topic2) &&
>> +       test_when_finished "git branch -f topic2 $START" &&
>> +
>> +       # Set config to print
>> +       test_config replay.refAction print &&
>> +       git replay --onto main topic1..topic2 >output &&
>> +       test_line_count = 1 output &&
>> +       test_grep "^update refs/heads/topic2 " output &&
>> +
>> +       # Reset and test update mode
>> +       git branch -f topic2 $START &&
>> +       test_config replay.refAction update &&
>> +       git replay --onto main topic1..topic2 >output &&
>> +       test_must_be_empty output &&
>> +
>> +       # Verify ref was updated
>> +       git log --format=%s topic2 >actual &&
>> +       test_write_lines E D M L B A >expect &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'command-line --ref-action overrides config' '
>> +       # Store original state
>> +       START=$(git rev-parse topic2) &&
>> +       test_when_finished "git branch -f topic2 $START" &&
>> +
>> +       # Set config to update but use --ref-action=print
>> +       test_config replay.refAction update &&
>> +       git replay --ref-action=print --onto main topic1..topic2 >output &&
>> +       test_line_count = 1 output &&
>> +       test_grep "^update refs/heads/topic2 " output
>> +'
>> +
>> +test_expect_success 'invalid replay.refAction value' '
>> +       test_config replay.refAction invalid &&
>> +       test_must_fail git replay --onto main topic1..topic2 2>error &&
>> +       test_grep "invalid.*replay.refAction.*value" error
>> +'
>> +
>>   test_done
>> --
>> 2.51.0
> Looks good otherwise.


Thanks for careful review!

