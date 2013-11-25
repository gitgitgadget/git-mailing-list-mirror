From: Sergey Sharybin <sergey.vfx@gmail.com>
Subject: Re: Git issues with submodules
Date: Mon, 25 Nov 2013 15:02:51 +0600
Message-ID: <CAErtv2729o-xf=49xY06aVL1ZJzJpeH+cc_Pd1cAP52r32Ss_g@mail.gmail.com>
References: <20131122151120.GA32361@sigill.intra.peff.net>
	<CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
	<CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
	<CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>
	<CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
	<CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
	<528FC638.5060403@web.de>
	<20131122215454.GA4952@sandbox-ub>
	<20131122220953.GI4212@google.com>
	<52910BC4.1030800@web.de>
	<20131124005256.GA3500@sandbox-ub>
	<52922962.3090407@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 25 10:03:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vks4R-0006pz-CG
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 10:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab3KYJDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 04:03:00 -0500
Received: from mail-vc0-f177.google.com ([209.85.220.177]:52307 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab3KYJCw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 04:02:52 -0500
Received: by mail-vc0-f177.google.com with SMTP id hv10so2496250vcb.36
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 01:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xJ0tss1O0v7BNBtg4alg625UametAfXUsakWmS1D9pc=;
        b=fR+LpA3onFCYwerJFVPIP+eCchmN4tK4NqmVWiBVIm0+YMBsYMh0KqFxNTgnW+RQjB
         VedsDrYbLiGU0DtQCO8siINF/0frps77elxsdiTo5g2idCI0Tsd3HbnXQDkf99g902Zn
         RvL4bQuFz/LkmD5lCl29gIgmkwkdfWBGuMwzJdplw5j0Uh3LxIKJeaqzKrk6YZO3+PLX
         Qrmun5hrCuHB973U4J3LVpeBbwiDtJ+9CLUxtR1V41eD7NeJEEmUtZ+UDHqRfkPU4BFU
         hedvTHO7oGAD7WO3zHghmZ8IIoblg3VI1Swv/dt9mhz2R1CAQB2lzMwN+PgVM2AjqxmA
         Ax8g==
X-Received: by 10.220.174.200 with SMTP id u8mr25615367vcz.6.1385370171115;
 Mon, 25 Nov 2013 01:02:51 -0800 (PST)
Received: by 10.52.169.2 with HTTP; Mon, 25 Nov 2013 01:02:51 -0800 (PST)
In-Reply-To: <52922962.3090407@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238304>

Hey!

Sorry for the delayed reply.

Am i right the intention is to make it so `git add .` and `git commit
.` doesn't include changes to submodule hash unless -f argument is
provided?

On Sun, Nov 24, 2013 at 10:29 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 24.11.2013 01:52, schrieb Heiko Voigt:
>> Hi,
>>
>> On Sat, Nov 23, 2013 at 09:10:44PM +0100, Jens Lehmann wrote:
>>> Am 22.11.2013 23:09, schrieb Jonathan Nieder:
>>>> Heiko Voigt wrote:
>>>>
>>>>> After that we can discuss whether add should add submodules that are
>>>>> tracked but not shown. How about commit -a ? Should it also ignore the
>>>>> change? I am undecided here. There does not seem to be any good
>>>>> decision. From the users point of view we should probably not add it
>>>>> since its not visible in status. What do others think?
>>>>
>>>> I agree --- it should not add.
>>>
>>> I concur: adding a change that is hidden from the user during
>>> the process is not a good idea.
>>
>> Here is a patch achieving that. Still missing a test which I will add.
>
> Looking good to me. Please add tests for "diff.ignoreSubmodules"
> and "submodule.<name>.ignore", the latter both in .gitmodules and
> .git/config. While doing some testing for this thread I found an
> inconsistency in git show which currently honors the submodule
> specific option only from .git/config and ignores it in the
> .gitmodules file (depending on the outcome of the discussion on
> what '--ignore-submodules=all' should ignore we might have to fix
> that one afterwards).
>
> I'd suggest to also add the --ignore-submodules option in another
> patch on top, because the user should be able to override the
> configuration either way. And what about having the '-f' option
> imply '--ignore-submodules=none'?
>
>> Cheers Heiko
>>
>> ---8<----
>> Subject: [PATCH] fix 'git add' to skip submodules configured as ignored
>>
>> If submodules are configured as ignore=all they are not shown by status.
>> Lets also ignore them when adding files to the index. This avoids that
>> users accidentially add ignored submodules with: git add .
>>
>> We achieve this by reading the submodule config and thus correctly
>> initializing the infrastructure to take the ignore decision.
>>
>> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
>> ---
>>  builtin/add.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/builtin/add.c b/builtin/add.c
>> index 226f758..2d0d2ef 100644
>> --- a/builtin/add.c
>> +++ b/builtin/add.c
>> @@ -15,6 +15,7 @@
>>  #include "diffcore.h"
>>  #include "revision.h"
>>  #include "bulk-checkin.h"
>> +#include "submodule.h"
>>
>>  static const char * const builtin_add_usage[] = {
>>       N_("git add [options] [--] <pathspec>..."),
>> @@ -378,6 +379,10 @@ static int add_config(const char *var, const char *value, void *cb)
>>               ignore_add_errors = git_config_bool(var, value);
>>               return 0;
>>       }
>> +
>> +     if (!prefixcmp(var, "submodule."))
>> +             return parse_submodule_config_option(var, value);
>> +
>>       return git_default_config(var, value, cb);
>>  }
>>
>> @@ -415,6 +420,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>>       int implicit_dot = 0;
>>       struct update_callback_data update_data;
>>
>> +     gitmodules_config();
>>       git_config(add_config, NULL);
>>
>>       argc = parse_options(argc, argv, prefix, builtin_add_options,
>>
>



-- 
With best regards, Sergey Sharybin
