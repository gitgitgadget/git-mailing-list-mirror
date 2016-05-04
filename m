From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv4] submodule deinit: require '--all' instead of '.' for
 all submodules
Date: Wed, 4 May 2016 16:38:38 -0700
Message-ID: <CAGZ79kbeCCcmGh57zUdQ=BzFOWUiwj8-3nM4dbK9yONbrmLaPw@mail.gmail.com>
References: <1462401603-2067-1-git-send-email-sbeller@google.com>
	<20160504232642.GC395@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 01:38:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay6NS-00067B-NL
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 01:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbcEDXik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 19:38:40 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36317 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbcEDXij (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 19:38:39 -0400
Received: by mail-io0-f182.google.com with SMTP id u185so80461223iod.3
        for <git@vger.kernel.org>; Wed, 04 May 2016 16:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=2kE3RrqdbA+DbGGhqKNfuvFmGHsXrntXCnQO01wjhP4=;
        b=KOT9r/kPuQpmfbknvEDT9K/Y0Uva+eOG15TtNcCQ1at+bBrZI2K+/8THwwCRCZVbZX
         50WdTr0RkRb5HFhCgiqNMiv5A6XD9rX9CwLgqkydTkp3oy1O+R8Jx660WD8ebftBdN97
         MYtG8xoGQDjDqV/GJruktbxBAtHGkVmjFyE+5gLH4dSxRrCbXjnw0DA+7BQpRfmIIDYD
         n657hpaGYqNKLEAH2MaEZX2KBrS+Z9SbCt1YFcs4Jz9zCRmoUMjle0Z3riFlL79z+UO9
         7UBPy+xktIgbES+J8zJvQ6FsyrbT+GjHHPXbBYc8u/MDhqIY5HzlIufSJLPRQw1/wS0i
         cmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=2kE3RrqdbA+DbGGhqKNfuvFmGHsXrntXCnQO01wjhP4=;
        b=SfAsXxYQSzaUcEPSf2FtLYYj2XvBUe3zv+mpg/jMbRzeHdY598OpgHRHqpRTbWlnxH
         IVO/elhXJv1d5k3B0pQXEh3Jv7CCh8rkBbhSmL5O+oCSGDONhJ3gNJpP2c/smYvXn54a
         1FyDwJ23JyVul9IXjgEBkFYJs8AnxHtHNpbeEOa1dnW9caI8xr8jnYnlnprw7v0rTsqb
         GEodiVBm7BI80HYPwmLwrbJDf+WJsXWYMUI4Unkuj5z5LK4KAx3GTV1KxhePs9C4I9nX
         ip7oELjAOZ5PvPylUAn7hsOgrIs1isaYherTwIdAw+nm8afyO61jkL8aXcmGqxnMN1gH
         t1SA==
X-Gm-Message-State: AOPr4FVjTyDKj//2cccO//7PwcNiwuMliTBlqXbjI2YD+jctQ6DeHB0wMZh6MskfNKrf+6DXXJzQAUqPWQVBbm2M
X-Received: by 10.107.174.205 with SMTP id n74mr13762294ioo.96.1462405118560;
 Wed, 04 May 2016 16:38:38 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 4 May 2016 16:38:38 -0700 (PDT)
In-Reply-To: <20160504232642.GC395@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293626>

On Wed, May 4, 2016 at 4:26 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Stefan Beller wrote:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> * reworded commit message slightly (realize, pathspec)
>> * reworded the documentation
>
> Yay, thanks for your work on this.
>
> [...]
>> +++ b/Documentation/git-submodule.txt
>> @@ -13,7 +13,7 @@ SYNOPSIS
>>             [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
>>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>>  'git submodule' [--quiet] init [--] [<path>...]
>> -'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
>> +'git submodule' [--quiet] deinit [-f|--force] (-a|--all|[--] <path>...)
>>  'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
>>             [-f|--force] [--rebase|--merge] [--reference <repository>]
>>             [--depth <depth>] [--recursive] [--] [<path>...]
>> @@ -140,12 +140,20 @@ deinit::
>>       tree. Further calls to `git submodule update`, `git submodule foreach`
>>       and `git submodule sync` will skip any unregistered submodules until
>>       they are initialized again, so use this command if you don't want to
>> -     have a local checkout of the submodule in your work tree anymore. If
>> +     have a local checkout of the submodule in your working tree anymore. If
>>       you really want to remove a submodule from the repository and commit
>>       that use linkgit:git-rm[1] instead.
>> ++
>> +When the command is run without pathspec, it errors out,
>> +instead of deinit-ing everything, to prevent mistakes. In
>> +version 2.8 and before the command gave a suggestion to use
>> +'.' to unregister all submodules when it was invoked without
>> +any argument, but this suggestion did not work and gave a
>> +wrong message if you followed it in pathological cases and is
>> +no longer recommended.
>
> Why tell the user what happened in 2.8 and earlier?  It's not clear what
> the reader would do with that information.

Because people may wonder what happened to '.' ?

>
> I think this paragraph could be removed.  --all is explained lower
> down and the error message points it out to users who need it.

When we want to keep supporting '.' forever, I would remove this section.

>
>>  +
>> -If `--force` is specified, the submodule's work tree will be removed even if
>> -it contains local modifications.
>> +If `--force` is specified, the submodule's working tree will
>> +be removed even if it contains local modifications.
>
> (unnecessary rewrapping)
>
> [...]
>>  update::
>>  +
>> @@ -247,6 +255,11 @@ OPTIONS
>>  --quiet::
>>       Only print error messages.
>>
>> +-a::
>> +--all::
>> +     This option is only valid for the deinit command. Unregister all
>> +     submodules in the working tree.
>
> This could use an explanation of why I'd want to use it.  E.g.
>
>         This option is only valid for the deinit command. Unregister all
>         submodules. Scripts should use this option instead of passing '.'
>         to deinit because it works even in an empty repository with no
>         submodules present.

I would not want to mention '.' in the documentation. this can read:

    As a user I am fine to use '.' and then I wonder when it breaks.


>
> Not about this patch: the organization of options is a little strange.
> A separate section with options for each subcommand would be easier to
> read.

I agree.

>
> Do we want to claim the short-and-sweet option -a?  (I don't mind but it
> doesn't seem necessary.)

We do.

>
> [...]
>> @@ -257,8 +270,8 @@ OPTIONS
>>  --force::
>>       This option is only valid for add, deinit and update commands.
>>       When running add, allow adding an otherwise ignored submodule path.
>> -     When running deinit the submodule work trees will be removed even if
>> -     they contain local changes.
>> +     When running deinit the submodule working trees will be removed even
>> +     if they contain local changes.
>
> Unrelated change?

It's close enough for deinit to squash it in here, no?


>
> [...]
>> @@ -544,9 +548,13 @@ cmd_deinit()
>>               shift
>>       done
>>
>> -     if test $# = 0
>> +     if test -n "$deinit_all" && test "$#" -ne 0
>> +     then
>> +             die "$(eval_gettext "--all and pathspec are incompatible")"
>
> This message still feels too low-level to me, but I might be swimming
> uphill here.
>
> Another option would be to call 'usage' and be done.

I had that idea as well, but I think pointing out the low level is better
than giving the high level again, so the user immediately sees what's wrong.

>
> [...]
>> --- a/t/t7400-submodule-basic.sh
>> +++ b/t/t7400-submodule-basic.sh
>
> Makes sense.
>
> In the context of the original motivation: this patch improves the
> advice printed by plain "git submodule deinit" but doesn't help with
> existing callers that might have run "git submodule deinit .".  It might
> make sense to handle '.' as a historical special case in a separate
> patch.

Once we change how '.' is handled we can do that?

>
> Thanks and sorry for all the complication,
> Jonathan
