From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH 2/2] pull --rebase: add --[no-]autostash flag
Date: Wed, 16 Mar 2016 10:30:38 +0530
Message-ID: <CA+DCAeRWRiY+qCZ440NbU+DMg0OQ6C1bSpYfsHEqjiOvhX69Eg@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1458061904-26516-1-git-send-email-mehul.jain2029@gmail.com>
	<1458061904-26516-2-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cSnp+NsBAMib4pExKCLB5ocGsHWyO7qMU0E91WqE6a5_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 06:00:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag3Zc-0002lW-Cn
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 06:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbcCPFAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 01:00:41 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36344 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbcCPFAj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 01:00:39 -0400
Received: by mail-qk0-f176.google.com with SMTP id s68so16565905qkh.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 22:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=dDZ/uuCV/rX0omWWn6LfXDbVK3v1rPVR7lLRISMSwaI=;
        b=x3IYIqQ8r8b1mQ2j+bympAmDwXu6EAC1x8uQWIM1iFITwpjCXvBNCcIfRtFGJo3oLC
         cKqjMPuc2wique2edMwJ1zegIpmoA37ip//JDmVpJxShhZlXR9vo1880zz9J6iuOi2GO
         ncmyeCSDW4EkryQP+rHvCg3p+jB1JML+K+4Tmb6Zwb6dPaLjaBe5mbIy5MweYJEdcuvr
         C8v1xOxUa/gEYX4BXKC4NQPI4pHNMPADtCKedm/pFI9aKkAf/Vn15cJBdHVLfLu3yCDw
         4USmAtAkhC/YZH0NMINcQmW7OYEtAM/pQfMIGSmR18hE1bwTrFRG+rYeON3tzsIwO2XQ
         2AHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=dDZ/uuCV/rX0omWWn6LfXDbVK3v1rPVR7lLRISMSwaI=;
        b=FHJAuXVf3AyFoQqMljfvRbNjVwd39569C/djRQRMXmme0HeTc72Y7C+wWCTzMu6Neh
         HN/TE4AqTgwZEdCYbH1I/i6TmXXlV2sq454PlX9i0S3BMdtfSshBWJuCLYS+rZdjnaax
         T9a64UDF0TNSNOKQ3cpoONSUvutMhdJFPMCH/E0z7MdvSBQhicTK9/18ia65q05qfiBY
         RaHSZM5ENF0av+breMffgv+4lOXU1ohF/+MRWeRHLmSt/3khIGvUYas5vOhrShxWjL2y
         NgAnWaOjglqU9RWGzMUjl2pWkPCUOQxMjqBEbmSs6g/Ttmj0Ir8f7bBNEYm1xSonSMHd
         LWfQ==
X-Gm-Message-State: AD7BkJLm3Gs4KnAMqngFY7mqL1llrNK8LWG319rwC0gIOkfA/WsHlDLdNstJbN8c8C1BHlT8NA4d0GJ0SYH0nA==
X-Received: by 10.55.209.148 with SMTP id o20mr2392151qkl.5.1458104438750;
 Tue, 15 Mar 2016 22:00:38 -0700 (PDT)
Received: by 10.55.188.7 with HTTP; Tue, 15 Mar 2016 22:00:38 -0700 (PDT)
In-Reply-To: <CAPig+cSnp+NsBAMib4pExKCLB5ocGsHWyO7qMU0E91WqE6a5_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288947>

On Wed, Mar 16, 2016 at 3:13 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
>> @@ -128,6 +128,15 @@ unless you have read linkgit:git-rebase[1] carefully.
>> +--autostash::
>> +--no-autostash::
>> +       Before starting rebase, stash local modifications away (see
>> +       linkgit:git-stash.txt[1]) if needed, and apply the stash when
>> +       done (this option is only valid when "--rebase" is used).
>> ++
>> +`--no-autostash` is useful to override the `rebase.autoStash`
>> +configuration variable (see linkgit:git-config[1]).
>
> The last couple sentences seem reversed. It feels odd to have the bit
> about --rebase dropped dead in the middle of the description of
> --autostash and --no-autostash. I'd have expected to see --autostash
> and --no-autostash discussed together, and then, as a follow-on,
> mention them being valid only with --rebase.

So you are suggesting something like this:

--autostash::
--no-autostash::
    Before starting rebase, stash local modifications away (see
    linkgit:git-stash.txt[1]) if needed, and apply the stash when
    done. `--no-autostash` is useful to override the `rebase.autoStash`
    configuration variable (see linkgit:git-config[1]).
+
This option is only valid when "--rebase" is used.

Can be done and it make more sense to talk about the validity of the
option in a seperate line.

>> diff --git a/builtin/pull.c b/builtin/pull.c
>> @@ -851,12 +855,17 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>>                 if (is_null_sha1(orig_head) && !is_cache_unborn())
>>                         die(_("Updating an unborn branch with changes added to the index."));
>>
>> -               if (config_autostash)
>> +               if (opt_autostash == -1)
>
> In patch 1/2, this changed from 'if (autostash)' to 'if
> (config_autostash)'; it's a bit sad that patch 2/2 then has to touch
> the same code to change it yet again, this time to 'if
> (opt_autostash)'. Have you tried just keeping the original 'autostash'
> variable and modifying its value based upon config_autostash and
> opt_autostash instead? (Not saying that this would be better, but
> interested in knowing if the result is as clean or cleaner or worse.)

Yes, I tried that. Things looked something like this:

In patch 1/2
...

-    int autostash = 0;
+    int autostash = config_autoshash;

    if (is_null_sha1(orig_head) && !is_cache_unborn())
            die(_("Updating ..."));

-    git_config_get_bool("rebase.autostash", &autostash);
    if (!autostash)
            die_on_unclean_work_tree(prefix);

...

In patch 2/2
...
    int autostash = config_autoshash;

    if (is_null_sha1(orig_head) && !is_cache_unborn())
            die(_("Updating ..."));

+    if (opt_autostash != -1)
+        autostash = opt_autostash;

    if (!autostash)
        die_on_unclean_work_tree(prefix);
...

This implementation looks much more cleaner but we are using some
extra space (autostash) to do the task. If everyone is fine with this
trade off then I can re-roll a new patch with this method. Comments please.

>> +                       opt_autostash = config_autostash;
>> +
>> +               if (!opt_autostash)
>>                         die_on_unclean_work_tree(prefix);
>>
>>                 if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
>>                         hashclr(rebase_fork_point);
>> -       }
>> +       } else
>> +               if (opt_autostash != -1)
>> +                        die(_("--[no-]autostash option is only valid with --rebase."));
>
> How about formatting this as a normal 'else if'?
>
>     } else if (opt_autostash != -1)

I thought of it earlier but voted against it as it may reduce the readability of
the code.

> On the other hand, this error case hanging off the 'rebase'
> conditional is somewhat more difficult to reason about than perhaps it
> ought to be. It might be easier to see what's going on if you get the
> error case out of the way early, and then handle the normal case. That
> is, something like this:
>
>     if (!opt_rebase && opt_autostash != -1)
>         die(_("... is only valid with --rebase"));
>
>     if (opt_rebase) {
>         ...
>     }

This is good. I'll make the changes accordingly.

Thanks for the comments.

Mehul
