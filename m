From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Mon, 9 Sep 2013 17:49:36 -0500
Message-ID: <CAMP44s1OyST3S1HEdS38WPsjq6w9SekuwT4DRUgVvduATox9tw@mail.gmail.com>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
	<1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>
	<522E3C6A.3070409@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 00:49:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJAHH-0004W0-6u
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 00:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879Ab3IIWtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 18:49:41 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:53983 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807Ab3IIWtk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 18:49:40 -0400
Received: by mail-la0-f48.google.com with SMTP id er20so5412978lab.7
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 15:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4syL24o7LAQpvGH/rrDALWMLISzGNKp1ATTY0RF8tZY=;
        b=AmR/wvK+KhOmdyFYwPRngYJucxoH+OqAE+VEHX1Xfn3IQaSLkUBuoacSJgqs/4xUsX
         QWVPZZyNUYk0Fea1dprlulIy5YaMVuR6ZS2t7GGkbolQM0cOVp/zdFSWPCJXW6bXBTIZ
         wwRA3sOwjUilrnoWlXskkWNTvAqqJHOrM8SF2+5jZXkWe6Q5X+AF//NOkTizHnh5YMr1
         e7MICFdYAGVivdRwJ1n2f9wlSuHDBnwTeL6+xh+OsJtCxk72doeuk02Ty0ps6FIvGRBk
         aVZdaPOfaIvPYe/H6gTR7D0Z9jAZN8bzpEYWSHbiawvVO5cVw5Kic8bqKGvmEtkw0OYO
         Q7sA==
X-Received: by 10.152.37.41 with SMTP id v9mr18614434laj.9.1378766976445; Mon,
 09 Sep 2013 15:49:36 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Mon, 9 Sep 2013 15:49:36 -0700 (PDT)
In-Reply-To: <522E3C6A.3070409@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234388>

On Mon, Sep 9, 2013 at 4:23 PM, Richard Hansen <rhansen@bbn.com> wrote:
> On 2013-09-08 21:23, Felipe Contreras wrote:
>> The old configurations still work, but get deprecated.
>
> Should some tests for the deprecated configs be added?  We wouldn't want
> to accidentally break those.

Probably, but Junio is not picking this patch anyway.

>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index ec57a15..9489a59 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -760,11 +760,11 @@ branch.<name>.mergeoptions::
>>       option values containing whitespace characters are currently not
>>       supported.
>>
>> -branch.<name>.rebase::
>> -     When true, rebase the branch <name> on top of the fetched branch,
>> -     instead of merging the default branch from the default remote when
>> -     "git pull" is run. See "pull.rebase" for doing this in a non
>> -     branch-specific manner.
>> +branch.<name>.pullmode::
>> +     When "git pull" is run, this determines if it would either merge or
>> +     rebase the fetched branch. The possible values are 'merge' and
>> +     'rebase'. See "pull.mode" for doing this in a non branch-specific
>> +     manner.
>>  +
>>  *NOTE*: this is a possibly dangerous operation; do *not* use
>>  it unless you understand the implications (see linkgit:git-rebase[1]
>> @@ -1820,11 +1820,11 @@ pretty.<name>::
>>       Note that an alias with the same name as a built-in format
>>       will be silently ignored.
>>
>> -pull.rebase::
>> -     When true, rebase branches on top of the fetched branch, instead
>> -     of merging the default branch from the default remote when "git
>> -     pull" is run. See "branch.<name>.rebase" for setting this on a
>> -     per-branch basis.
>> +pull.mode::
>> +     When "git pull" is run, this determines if it would either merge or
>> +     rebase the fetched branch. The possible values are 'merge' and
>> +     'rebase'. See "branch.<name>.pullmode" for doing this in a non
>> +     branch-specific manner.
>>  +
>>  *NOTE*: this is a possibly dangerous operation; do *not* use
>>  it unless you understand the implications (see linkgit:git-rebase[1]
>
> Somewhere something should mention what the default values are
> (branch.<name>.pullmode defaults to pull.mode and pull.mode defaults to
> merge).
>
>> diff --git a/git-pull.sh b/git-pull.sh
>> index f0df41c..de57c1d 100755
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -43,10 +43,24 @@ log_arg= verbosity= progress= recurse_submodules= verify_signatures=
>>  merge_args= edit=
>>  curr_branch=$(git symbolic-ref -q HEAD)
>>  curr_branch_short="${curr_branch#refs/heads/}"
>> -rebase=$(git config --bool branch.$curr_branch_short.rebase)
>> +mode=$(git config branch.${curr_branch_short}.pullmode)
>> +if test -z "$mode"
>> +then
>> +     mode=$(git config pull.mode)
>> +fi
>> +test "$mode" == 'rebase' && rebase="true"
>>  if test -z "$rebase"
>>  then
>> -     rebase=$(git config --bool pull.rebase)
>> +     rebase=$(git config --bool branch.$curr_branch_short.rebase)
>> +     if test -z "$rebase"
>> +     then
>> +             rebase=$(git config --bool pull.rebase)
>> +     fi
>> +     if test "$rebase" = 'true'
>> +     then
>> +             echo "The configurations pull.rebase and branch.<name>.rebase are deprecated."
>> +             echo "Please use pull.mode and branch.<name>.pullmode instead."
>> +     fi
>>  fi
>>  dry_run=
>>  while :
>
> These deprecation warning messages should be written to stderr, and
> should probably be prefixed with "WARNING: ".

Is there any deprecation warning that works this way?

-- 
Felipe Contreras
