From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v16 7/7] commit: add a commit.verbose config variable
Date: Fri, 6 May 2016 10:35:46 +0530
Message-ID: <CAFZEwPMoqK0jLgvb9rm5j_0PHFO6Qg9OU1V_jxkFvL+wGGaNng@mail.gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
	<1462441802-4768-8-git-send-email-pranit.bauva@gmail.com>
	<xmqqbn4kb9m1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 07:06:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayXxn-0002MC-P0
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 07:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbcEFFFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 01:05:48 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:36410 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbcEFFFr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 01:05:47 -0400
Received: by mail-yw0-f172.google.com with SMTP id o66so183640501ywc.3
        for <git@vger.kernel.org>; Thu, 05 May 2016 22:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Io4aWGenVlQe1WNOUgTvv6Lq9LzlTaZpwZZGcRDUuJk=;
        b=jTMNTcxAC30hadc50TcsGjgpFn+FvyGTbosnYkoPrmuqPNDn9Mubk/4EhCpaPJhnFI
         5MrM2ir30XlBAlbvYuIpHjMoM7b829b/EbcJzYrBaKgYqx/hY+cp0P7wY0gpmjODZZZ4
         D5rf+m5Ra/YHelAeHd+9ZG/sn52Fv4BmIDlgm7r3nDPvYn8Bfa4QZ/oAV3ELGMn5z/0z
         YJj8jQkj70hVMkpelYd/mvlDTkbowMs55D10KRHiZth0gbk2DP1G5naItWVA5rpqobvn
         owp7NAtkM4AIOYG72qzOFgpZMiaxQZ7dKpwDmZWSEYhdELW7a60b9M7rgPKW62zWKsiG
         /XnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Io4aWGenVlQe1WNOUgTvv6Lq9LzlTaZpwZZGcRDUuJk=;
        b=HNwgkJvU6vn0jHX82/czHYsLpyBYTG++LdlqCUs/Ly8SnlufFKdVp6+vG2vlroL8Mb
         nus2kCWwqBzgk2eu6pYmHXg+fawn1A8rRei0YX2de/wuJJVYcI9MTReB5HCIk/XGdpzj
         e0HnNwDcoArKLzoB4zEaGxt9AyqQI8pQHv+AxE6x7zy/SZrWj5hvCvL6D7vCS+VycRBI
         BeHEzmM/mU/qTT553pdUGI0GSXV5ANockkVEHqCch7HUtuOnnnV1/IJUo5LxyQiRTme8
         FytV3PNSJxcbDwNk2wyMGUUlrstacZTKKl6x6kQxDxYnqjnfy9drfuDsxh/YF7kbqkRE
         xxbQ==
X-Gm-Message-State: AOPr4FVyq7UA3nbZ4G+ylM6fMuVolszUKiDoee7EXQ/BFhmD4foTAEJbhSBGxEE6Eze/ji95UUxt2CrZLQQB4A==
X-Received: by 10.13.221.212 with SMTP id g203mr11097963ywe.68.1462511146701;
 Thu, 05 May 2016 22:05:46 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Thu, 5 May 2016 22:05:46 -0700 (PDT)
In-Reply-To: <xmqqbn4kb9m1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293738>

On Fri, May 6, 2016 at 12:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 391126e..114ffc9 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -113,7 +113,9 @@ static char *edit_message, *use_message;
>>  static char *fixup_message, *squash_message;
>>  static int all, also, interactive, patch_interactive, only, amend, signoff;
>>  static int edit_flag = -1; /* unspecified */
>> -static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
>> +static int config_verbose = -1; /* unspecified */
>> +static int verbose = -1; /* unspecified */
>> +static int quiet, no_verify, allow_empty, dry_run, renew_authorship;
>
> The name does not make it clear that config_verbose is only for
> "commit" and not relevant to "status".

True.

>> @@ -1364,6 +1366,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>>                            builtin_status_usage, 0);
>>       finalize_colopts(&s.colopts, -1);
>>       finalize_deferred_config(&s);
>> +     if (verbose == -1)
>> +             verbose = 0;
>
> Mental note: cmd_status() does not use git_commit_config() but uses
> git_status_config(), hence config_verbose is not affected.  But
> because verbose is initialised to -1, the code needs to turn it off
> like this.

Yes

>> @@ -1664,6 +1673,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>       argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>>                                         builtin_commit_usage,
>>                                         prefix, current_head, &s);
>> +     if (verbose == -1)
>> +             verbose = (config_verbose < 0) ? 0 : config_verbose;
>> +
>
> cmd_commit() does use git_commit_config(), and verbose is
> initialised -1, so without command line option, we fall back to
> config_verbose if it is set from the configuration.
>
> I wonder if the attached patch squashed into this commit makes
> things easier to understand, though.  The points are:
>
>  - We rename the configuration to make it clear that it is about
>    "commit" and does not apply to "status".
>
>  - We initialize verbose to 0 as before.  The only thing "git
>    status" cares about is if "--verbose" was given.  Giving it
>    "--no-verbose" or nothing should not make any difference.
>
>  - But we do need to stuff -1 to verbose in "git commit" before
>    handling the command line options, because the distinction
>    between having "--no-verbose" and not having any matter there,
>    and we do so in cmd_commit(), i.e. only place where it matters.

Awesome work by addressing these points. I hadn't thought of these earlier.

>  builtin/commit.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 583d1e3..a486620 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -113,9 +113,8 @@ static char *edit_message, *use_message;
>  static char *fixup_message, *squash_message;
>  static int all, also, interactive, patch_interactive, only, amend, signoff;
>  static int edit_flag = -1; /* unspecified */
> -static int config_verbose = -1; /* unspecified */
> -static int verbose = -1; /* unspecified */
> -static int quiet, no_verify, allow_empty, dry_run, renew_authorship;
> +static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
> +static int config_commit_verbose = -1; /* unspecified */
>  static int no_post_rewrite, allow_empty_message;
>  static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
>  static char *sign_commit;
> @@ -1366,8 +1365,6 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>                              builtin_status_usage, 0);
>         finalize_colopts(&s.colopts, -1);
>         finalize_deferred_config(&s);
> -       if (verbose == -1)
> -               verbose = 0;
>
>         handle_untracked_files_arg(&s);
>         if (show_ignored_in_status)
> @@ -1521,7 +1518,7 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>         }
>         if (!strcmp(k, "commit.verbose")) {
>                 int is_bool;
> -               config_verbose = git_config_bool_or_int(k, v, &is_bool);
> +               config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
>                 return 0;
>         }
>
> @@ -1670,11 +1667,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>                 if (parse_commit(current_head))
>                         die(_("could not parse HEAD commit"));
>         }
> +       verbose = -1; /* unspecified */
>         argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>                                           builtin_commit_usage,
>                                           prefix, current_head, &s);
>         if (verbose == -1)
> -               verbose = (config_verbose < 0) ? 0 : config_verbose;
> +               verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
>
>         if (dry_run)
>                 return dry_run_commit(argc, argv, prefix, current_head, &s);

This makes things quite easy to understand.
Very simple speaking:
 * Rename config_verbose => config_commit_verbose
 * initialize verbose to -1 only in cmd_commit()

I checked out your branch gitster/pb/commit-verbose-config and tests
from t0040 seem to be failing. Don't worry I will handle those, I will
squash your patch in mine and re-roll it again. I am still unsure how
those tests broke. I will figure it out.

Thanks for your help! :)
