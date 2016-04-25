From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] clone: add `--shallow-submodules` flag
Date: Mon, 25 Apr 2016 10:26:11 -0700
Message-ID: <CAGZ79kYJipjCVGFXQkHyLNr4GTZA+vJFv+-8bWDXTrN3VUORuA@mail.gmail.com>
References: <1458090737-14030-1-git-send-email-sbeller@google.com>
	<1458090737-14030-2-git-send-email-sbeller@google.com>
	<DC38BBF1-9837-45C6-B744-F95FAA645FE3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:26:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aukH6-0007Lm-Ju
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 19:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbcDYR0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 13:26:14 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34804 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526AbcDYR0M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 13:26:12 -0400
Received: by mail-io0-f181.google.com with SMTP id 2so191051114ioy.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=L2iDU4IrjiVIYYofScMFT/JN1ABneLkUZOvXPE8OuMA=;
        b=W7QeN5mv1b2V/74RpZPZjJYobLv1QEMqUZMkdlJmiZi1W+l083/RZba0ZV8KnQpquc
         GVsKsppMCwFcfdNki+NBDn9dW95+Y1l6d0+5sR/nzFANoOn0ae5ytxVeNaHWOtBZ2f/f
         R4e1wY/RyjE2GjQea+ByoEiku+FC2rrXRHNFVdyPP2HwBZFZZliDM7SdDoo16hxFEZ93
         1BSS91bZmL/sxRwPIsVvzsjCjaNAuwbBteKEsAg/DSLG9RLoxil3gIfaJkxdYhNo2dtP
         xBCMYk6AvbGSa/MUf8uitWYg8tz3X00LvUt/X1XEn5k37kj8zAhsPkREIhta++3DaaGI
         +ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=L2iDU4IrjiVIYYofScMFT/JN1ABneLkUZOvXPE8OuMA=;
        b=lm6vYCPWAMAebR3RJi6n9UX0yWAi4p1i2UN4WaYV2XwdKvXK0T+oPSd9scDj7vRQF3
         oCivyiw9SpiuxajX9Fiia7yMlzA983J5B2JsseBC2dTmZkKRazE5S99QqOX8Zmop9uZK
         DfM9zC9mdv8t1/H4b56RPYgF7Co0jwcXqSor1aUn5IV/1hEZVeTyb5qx1NEp+mIqJQ3Q
         cp4Ck3orOtLYltxIhkJhaFUaDPYT+Y4uyPa0/AkhIowAcxdXIl+PRgkNV37B892dJTsx
         5i7BXqd7Nt2PQ4fcGj8Hw/W2bxGp6xnNIe0tumXCRCGkQ8OX4z9BgcXCYS81vPSRrH3u
         DN/Q==
X-Gm-Message-State: AOPr4FUDVh7srJtV1ESBEOfL/Vx4HfKduuYys3zzM0lj3bUQ4Bzo9HAKBgo2B21Z6Avm6aN7teSWPNgarkzNUjZK
X-Received: by 10.107.161.68 with SMTP id k65mr45249048ioe.110.1461605171755;
 Mon, 25 Apr 2016 10:26:11 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 25 Apr 2016 10:26:11 -0700 (PDT)
In-Reply-To: <DC38BBF1-9837-45C6-B744-F95FAA645FE3@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292529>

On Mon, Apr 25, 2016 at 4:50 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>> first case (as we wouldd have already transmitted the non shallow over
> s/wouldd/would/

will be fixed in a reroll

>> --depth <depth>::
>>       Create a 'shallow' clone with a history truncated to the
>> -     specified number of revisions.
>> +     specified number of revisions. Implies `--single-branch` unless
>> +     `--no-single-branch` is given to fetch the histories near the
>> +     tips of all branches. This implies `--shallow-submodules`. If
>> +     you want to have a shallow clone, but full submodules, also pass
> Can we make this more explicit. Attention, bikeshedding:
> If you want to have a shallow parent clone, but full submodules...

Good point, but with s/parent/superproject/ ? (What is a "parent clone"?
It is not defined in the glossary, so let's not make up more confusing words
for Git here :)

>
>
>> +     `--no-shallow-submodules`.
>>
>> --[no-]single-branch::
>>       Clone only the history leading to the tip of a single branch,
>> @@ -214,6 +218,9 @@ objects from the source repository into a pack in the cloned repository.
>>       repository does not have a worktree/checkout (i.e. if any of
>>       `--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
>>
>> +--shallow-submodules::
> Should that be "--[no-]shallow-submodules" ?

will be fixed in a reroll

>
>
>> +     All submodules which are cloned, will be shallow.
> Maybe you could extend it with "... will be shallow with a depth of 1." ?

done

>
>
>> +
>> --separate-git-dir=<git dir>::
>>       Instead of placing the cloned repository where it is supposed
>>       to be, place the cloned repository at the specified directory,
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index b004fb4..ecdf308 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -40,6 +40,7 @@ static const char * const builtin_clone_usage[] = {
>>
>> static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
>> static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
>> +static int option_shallow_submodules = -1;
>> static char *option_template, *option_depth;
>> static char *option_origin = NULL;
>> static char *option_branch = NULL;
>> @@ -91,6 +92,8 @@ static struct option builtin_clone_options[] = {
>>                   N_("create a shallow clone of that depth")),
>>       OPT_BOOL(0, "single-branch", &option_single_branch,
>>                   N_("clone only one branch, HEAD or --branch")),
>> +     OPT_BOOL(0, "shallow-submodules", &option_shallow_submodules,
>> +                 N_("any cloned submodules will be shallow")),
> I am not familiar with this code but I assume the "no-" prefix flips the bool?

Giving the --no-option stores an explicit 0 (it is initialized as -1),
and passing --option stores a 1.

>> @@ -727,6 +730,10 @@ static int checkout(void)
>>               struct argv_array args = ARGV_ARRAY_INIT;
>>               argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
>>
>> +             if (option_shallow_submodules == 1
>> +                 || (option_shallow_submodules == -1 && option_depth))
>> +                     argv_array_push(&args, "--depth=1");
>> +

which explains this here as:

        If  --shallow-submodules was given
          || (neither --[no-]shallow-submodules was given, but --depth
was given,
            i.e. depth implies --shallow-submodule only if no explicit
choice was made
            by the user.

>>               if (max_jobs != -1)
>>                       argv_array_pushf(&args, "--jobs=%d", max_jobs);
>>
>> --
>> 2.7.0.rc0.42.g8e9204f.dirty
>>
>
