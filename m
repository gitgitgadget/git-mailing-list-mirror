From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv4] submodule deinit: require '--all' instead of '.' for
 all submodules
Date: Thu, 5 May 2016 11:11:17 -0700
Message-ID: <CAGZ79kah7Ry5j6+2n4ndcw5=RqT7wDOsRL7zPE7UphtSE5ib1Q@mail.gmail.com>
References: <1462401603-2067-1-git-send-email-sbeller@google.com>
	<20160504232642.GC395@google.com>
	<CAGZ79kbeCCcmGh57zUdQ=BzFOWUiwj8-3nM4dbK9yONbrmLaPw@mail.gmail.com>
	<xmqqr3dgbd3k.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 20:11:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayNkB-0001hP-Tv
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 20:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbcEESLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 14:11:19 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34039 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbcEESLS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 14:11:18 -0400
Received: by mail-ig0-f175.google.com with SMTP id u5so3713665igk.1
        for <git@vger.kernel.org>; Thu, 05 May 2016 11:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=PNKuIMfSRZRqN9MlW5ht/vXrvaj8rETrt2eFL9/ZG1U=;
        b=dOKmJB0aWFXvRU2CcvFVNuhO3a2GYJi008dL0QiZ2Kp+ur2fv4236nkS2bqNEo9LGy
         86ZPM07TbCen6AJq0pEJJXwiweUMIo1+68SQ1IBRFr66KhuKSTMOUei8Qg3FZmI1Otg1
         tRgTwK1S1+IBnaDPqfTslV9zUYAxAEweJS/ieMDh4YEkYyeKCMn27K4U3JFNrTO5/jAD
         p82bmUXEYafNDmlpSR/yajv1XhRX5euZAKNglC7vy85/SDD8xCA9DBU6tRbUzGX9PFWn
         ffcxCc6vmodncEGVhY5f5eDxbpx35wa5pkXMWnKvRZ6yEHrPTcXNxe5BuXXAcKy6QLYk
         +Wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=PNKuIMfSRZRqN9MlW5ht/vXrvaj8rETrt2eFL9/ZG1U=;
        b=IOPSAC5C3NnJPCKBQLGDr7V0cwJ1WZ3ZsIKKZhHlGAmlx3fksBLQ61w+cAntMBXdji
         O8pjVlF2ci9uXn0vfOSo44DiMpX9rTgeHvPQMAqmW8AX0sR2yroBntnCHpd+rSVx9blP
         ZhWDVHZJ5fg+3elG4RZqRbF47hUSfmqQQnNqQx2gd6CiiZ0Hj+5nwiFkivLoizgW3LR/
         llYCtrU9s91v4hYnOx+djS0pdGy8AVk2gt9La5AHcgPs3f22NIwPYt2iDvISwhn2Eol5
         prQpcIFTxZ14o+5DFm4a633N/+nNDGhE7Qk8+gvHgqRrXDk88YH86jt6140WWkuEHJPo
         57Lw==
X-Gm-Message-State: AOPr4FWqo7zmCpC/FP9HtNZSnPqMqsEW4IHBa7gvRzcWn8YwdvE7z37jexJ9NtyVb4IY1W6jpvC/gYfE7GXto/c/
X-Received: by 10.50.170.68 with SMTP id ak4mr5445798igc.93.1462471877668;
 Thu, 05 May 2016 11:11:17 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 5 May 2016 11:11:17 -0700 (PDT)
In-Reply-To: <xmqqr3dgbd3k.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293660>

On Thu, May 5, 2016 at 10:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>>> +When the command is run without pathspec, it errors out,
>>>> +instead of deinit-ing everything, to prevent mistakes. In
>>>> +version 2.8 and before the command gave a suggestion to use
>>>> +'.' to unregister all submodules when it was invoked without
>>>> +any argument, but this suggestion did not work and gave a
>>>> +wrong message if you followed it in pathological cases and is
>>>> +no longer recommended.
>>>
>>> Why tell the user what happened in 2.8 and earlier?  It's not clear what
>>> the reader would do with that information.
>>
>> Because people may wonder what happened to '.' ?
>
> I am to blame on that final text, but I think Jonathan is right.
> "In version 2.8 and earlier..." can just go.  Users may need to
> understand why no-arg form is not a silent no-op but an error,
> and they need to know how to de-init everything with the version
> of Git they have (i.e. with "--all").  Compared to these two,
> "Your fingers may have been trained to say '.', but it was found
> not to work in pathological cases" is of much lessor importance,
> especially because with or without this patch, the definition of
> "pathological" cases does not change.

So we'll only give

    When the command is run without pathspec, it errors out,
    instead of deinit-ing everything, to prevent mistakes.

>
>>> I think this paragraph could be removed.  --all is explained lower
>>> down and the error message points it out to users who need it.
>>
>> When we want to keep supporting '.' forever, I would remove this section.
>
> I am not sure what you mean by "keep supporting '.'".  If your
> repository has any tracked path, "deinit ." would deinit all
> submodules, with or without this change.
>
> Are you worried about the future change you are planning to that
> involves reverting 84ba959b (submodule: fix regression for deinit
> without submodules, 2016-03-22), after which a pathspec that does
> not match any submodule would become a "possible typo" error?

When redoing the groups series, I may or may not go that route.
It sounds compelling to me.

>
> It is true that '.' would error out if there is no submodule in the
> repository, as opposed to erroring out only when there is no tracked
> path, which is what you get with today's version (and the version
> with this fix in the patch under discussion).  But '.' is not
> special with respect to that change.  'README' would also error out
> if there is no submodule whose path matches that pathspec in that
> future version, as opposed to erroring out only if 'README' is not
> tracked at all in today's version.
>
> Or are you thinking that it may be better to give '.' a special
> meaning, iow, not treating it as just a regular pathspec?  Perhaps
> make '.' to mean "everything but it is not an error if there is none
> to begin with"?  I fear that going in that direction would deform
> the mental model the users would form from seeing how commands
> behave when given a pathspec.  The "." would still look like any
> other pathspec elements, and I am sure you will not special case "."
> in the usage string but will claim that it is covered by the mention
> of <pathspec> at the end of the command line in the usage string,
> so you are making them expect that "." used as a pathspec would
> behave like that for all other places that we take pathspec, when
> in reality, only "submodule deinit" make it behave differently.
>
> Which I do not think is particularly a good idea.

I did not think special casing '.'. (I did in the very first patch, but I
understand that it's a bad idea now, so I do not think of it again)

>
>>> Not about this patch: the organization of options is a little strange.
>>> A separate section with options for each subcommand would be easier to
>>> read.
>>
>> I agree.
>
> I agree.
>
>>> Do we want to claim the short-and-sweet option -a?  (I don't mind but it
>>> doesn't seem necessary.)
>>
>> We do.
>
> I don't, but I do not care too deeaply.

Me neither, so I'll remove the short option.

>
>
>>>> @@ -257,8 +270,8 @@ OPTIONS
>>>>  --force::
>>>>       This option is only valid for add, deinit and update commands.
>>>>       When running add, allow adding an otherwise ignored submodule path.
>>>> -     When running deinit the submodule work trees will be removed even if
>>>> -     they contain local changes.
>>>> +     When running deinit the submodule working trees will be removed even
>>>> +     if they contain local changes.
>>>
>>> Unrelated change?
>>
>> It's close enough for deinit to squash it in here, no?
>
> More importantly, the patch adds a new instance of "working tree" to
> the documentation elsewhere; fixing this existing instance of "work
> tree" is relevant from consistency's point of view.
>
>>>> @@ -544,9 +548,13 @@ cmd_deinit()
>>>>               shift
>>>>       done
>>>>
>>>> -     if test $# = 0
>>>> +     if test -n "$deinit_all" && test "$#" -ne 0
>>>> +     then
>>>> +             die "$(eval_gettext "--all and pathspec are incompatible")"
>>>
>>> This message still feels too low-level to me, but I might be swimming
>>> uphill here.
>>>
>>> Another option would be to call 'usage' and be done.
>>
>> I had that idea as well, but I think pointing out the low level is better
>> than giving the high level again, so the user immediately sees what's wrong.
>
> I do not particularly see the message low-level.  Jonathan, what do
> you have against pointing out the exact problem?  After seeing the
> usage string that also talks about --quite, --force, etc., I have to
> somehow realize that these are irrelevant noises that have nothing
> to do with the error, and puzzle out that the (choose|from|here) is
> telling me that I cannot give pathspec when I am giving --all
> myself.
>
>> Once we change how '.' is handled we can do that?
>
> Again, I am worried about "Once we change how ...".

By that I mainly mean reverting 84ba959b (submodule: fix
regression for deinit without submodules, 2016-03-22),
but I am aware that this is a major change as it breaks
existing users.

Thanks,
Stefan
