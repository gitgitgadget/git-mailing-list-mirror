From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] pull --rebase: add --[no-]autostash flag
Date: Thu, 17 Mar 2016 23:32:23 -0400
Message-ID: <CAPig+cQyAJhaxhQvbtRyNrCq083q58K4yJ20BRoVw2WPkrK8VQ@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1458061904-26516-1-git-send-email-mehul.jain2029@gmail.com>
	<1458061904-26516-2-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cSnp+NsBAMib4pExKCLB5ocGsHWyO7qMU0E91WqE6a5_g@mail.gmail.com>
	<CA+DCAeRWRiY+qCZ440NbU+DMg0OQ6C1bSpYfsHEqjiOvhX69Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 04:32:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agl9J-0006Z5-Im
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 04:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbcCRDcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 23:32:25 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36483 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbcCRDcY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 23:32:24 -0400
Received: by mail-vk0-f67.google.com with SMTP id j65so8492848vkg.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 20:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=UqBDlsUXcPSZg2Ji+LZPq9+VVI8HBRVNls2gDwvGtPs=;
        b=CfFURoAWe/2xCtUX9To8dD/uGFzV5lBjyuULMhBUwUVrRXwsvXqKXBOJ088/r2LmKv
         RxqgsjVKuL0EZ/dh9kwQXH0VTB11+0U2FBykzdwOVVyq52vG4UgJ83xFQZeFCuoFPm7X
         lxV5FfvXa1qrtmySn7jJdSgE6qbhZ+uuZVfGzM7m/N3pYQENLpxLNKupTq5+3/of4uBQ
         vFY7P3CRdUElsds2xGJywlOMhy7KZm79A0uUXw8MtDVne1BONAucQAdxdihHhgJ8tRuh
         vi/72+cEoLQy8zGTkKaDuy6ouROvjdVT5jmAig6pADPY3JMS23AC1p4vYqKznpzC91rK
         mUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=UqBDlsUXcPSZg2Ji+LZPq9+VVI8HBRVNls2gDwvGtPs=;
        b=Pria3Slxbyx241CzzrZgjrE85R9ursLYjnH1UjdSo2VCKqKl0Suxe5unNNworA+dx0
         OnI/GiSZo8tSn4kfSJU2UAlP1QY4GrY2QEyrnhxF8BAG9+a3xxDnwIwIhgeMh4zV/B+t
         OZeslu1j/7YeYm/IRSfR/c2HeND38aIziSQgInGH86/hODjMBKLd9UFuL+BlKzxoofzY
         fV7TDW5NiL36xt9wis8fk7/MFO5YH8cUVotVNiq9oe1vC+1YwapDvHnpH7c3C+qjlN7a
         1rhoZ0f+xdsPEzbVPjrGcMiFSsS4mMH76XShfMZ4M7NmwqeCKG1sh2jYAwYLYWard0AG
         6mJw==
X-Gm-Message-State: AD7BkJJdGIp4BFWM3iem1GMbtHuBCsLFmiz5jRkHwo7b8NSu9PGqy2/oCg0/C3R1cgWjwu3DqWg3EiJTQgSvXg==
X-Received: by 10.31.8.142 with SMTP id 136mr15411442vki.14.1458271943737;
 Thu, 17 Mar 2016 20:32:23 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 17 Mar 2016 20:32:23 -0700 (PDT)
In-Reply-To: <CA+DCAeRWRiY+qCZ440NbU+DMg0OQ6C1bSpYfsHEqjiOvhX69Eg@mail.gmail.com>
X-Google-Sender-Auth: Nj52_PC0OZAAm30o5Dx5yLHMWPQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289179>

On Wed, Mar 16, 2016 at 1:00 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> On Wed, Mar 16, 2016 at 3:13 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> +--autostash::
>>> +--no-autostash::
>>> +       Before starting rebase, stash local modifications away (see
>>> +       linkgit:git-stash.txt[1]) if needed, and apply the stash when
>>> +       done (this option is only valid when "--rebase" is used).
>>> ++
>>> +`--no-autostash` is useful to override the `rebase.autoStash`
>>> +configuration variable (see linkgit:git-config[1]).
>>
>> The last couple sentences seem reversed. It feels odd to have the bit
>> about --rebase dropped dead in the middle of the description of
>> --autostash and --no-autostash. I'd have expected to see --autostash
>> and --no-autostash discussed together, and then, as a follow-on,
>> mention them being valid only with --rebase.
>
> So you are suggesting something like this:
>
> --autostash::
> --no-autostash::
>     Before starting rebase, stash local modifications away (see
>     linkgit:git-stash.txt[1]) if needed, and apply the stash when
>     done. `--no-autostash` is useful to override the `rebase.autoStash`
>     configuration variable (see linkgit:git-config[1]).
> +
> This option is only valid when "--rebase" is used.
>
> Can be done and it make more sense to talk about the validity of the
> option in a seperate line.

Yes, like that.

>>> diff --git a/builtin/pull.c b/builtin/pull.c
>>> @@ -851,12 +855,17 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>>>                 if (is_null_sha1(orig_head) && !is_cache_unborn())
>>>                         die(_("Updating an unborn branch with changes added to the index."));
>>>
>>> -               if (config_autostash)
>>> +               if (opt_autostash == -1)
>>
>> In patch 1/2, this changed from 'if (autostash)' to 'if
>> (config_autostash)'; it's a bit sad that patch 2/2 then has to touch
>> the same code to change it yet again, this time to 'if
>> (opt_autostash)'. Have you tried just keeping the original 'autostash'
>> variable and modifying its value based upon config_autostash and
>> opt_autostash instead? (Not saying that this would be better, but
>> interested in knowing if the result is as clean or cleaner or worse.)
>
> Yes, I tried that. Things looked something like this:
>
> In patch 1/2
> ...
>
> -    int autostash = 0;
> +    int autostash = config_autoshash;
>
>     if (is_null_sha1(orig_head) && !is_cache_unborn())
>             die(_("Updating ..."));
>
> -    git_config_get_bool("rebase.autostash", &autostash);
>     if (!autostash)
>             die_on_unclean_work_tree(prefix);

The individual diffs look nicer and are less noisy, thus a bit easier to review.

> In patch 2/2
> ...
>     int autostash = config_autoshash;
>
>     if (is_null_sha1(orig_head) && !is_cache_unborn())
>             die(_("Updating ..."));
>
> +    if (opt_autostash != -1)
> +        autostash = opt_autostash;

I'd probably have placed this conditional just below the line where
'autostash' is declared so that the logic for computing the value of
'autostash' is all in one place.

>     if (!autostash)
>         die_on_unclean_work_tree(prefix);
> ...
>
> This implementation looks much more cleaner but we are using some
> extra space (autostash) to do the task. If everyone is fine with this
> trade off then I can re-roll a new patch with this method. Comments please.

Using an extra variable isn't a big deal and would be a good idea if
it helped clarify the logic. In this case, the logic isn't
particularly difficult, so I don't feel too strongly about it one way
or the other.
