From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/5] pathspec: record labels
Date: Mon, 16 May 2016 10:46:00 -0700
Message-ID: <CAGZ79kbN_pzAVeAa-St_KRs60SbURTfKKP0v+do_+MK7orTkTg@mail.gmail.com>
References: <20160513231326.8994-1-sbeller@google.com>
	<20160513231326.8994-6-sbeller@google.com>
	<xmqqk2iw78aq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZsVH3mE0zXu9wSWgit3QZ_CiKZqg-TQdyWnZw6D9=Cgw@mail.gmail.com>
	<xmqqlh393nuv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 19:46:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Mam-0003Eh-L3
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 19:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321AbcEPRqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 13:46:04 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35433 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255AbcEPRqC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 13:46:02 -0400
Received: by mail-io0-f179.google.com with SMTP id d62so219094043iof.2
        for <git@vger.kernel.org>; Mon, 16 May 2016 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=3SdiLJaS46rgmw2eAVYhGMnt166dbZ7anEZHuWHqGjM=;
        b=eMojyNH4Bx8c2L+cQH8y/BEodFitFLyq3spsorLV/XFev9U5Srlt4q3WVC5LoFCwvP
         cXUGzMZx8PlTqMGzDKKKf1n2sjE1qoIiMY4+//JyWV/A9NE7JUHE9+I2NgrvMXv7WB3s
         +oI8Fh+0712uOl+o5fcQh5nqEbIa/dwc3qOLxSn/ikB7hehvbtKjlfFtPXgDm0WuREnI
         c+1X+TLC6dWrAH2hUMl/JgTgV0D7Al64/b8Bi83mf+1yjybzmU2WLFeVhCK3JPY5JO3q
         /dcM1NFTdYoZa0Jz1M6VhAgSeoMFpLwjQqBSopE1W4hVr6B2BSowV54ADZP2o4EO2qZp
         MeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=3SdiLJaS46rgmw2eAVYhGMnt166dbZ7anEZHuWHqGjM=;
        b=ZYJsCQaKIq1hmjlbpEeExt9nHYO4HPoJptNwprk+VWvorjl2AuMl4N4LPIJ+kzC7nT
         cJLgy8vd78pjq7AE1gN7lQDmlIIAv3Fyj4qY4T0jJW0UaqkZ2z+tolaZ5GAt5dAxfSBx
         Fk7J16cv6Erew0hChDFQJLl8xQDJmLcPWI/crRUoYdvUuQ+FUGdg/bhy47+wvN0yOsB3
         CfLjjt42JqLbN3ZrIjphajXlqxEgHR3l+cfF8AjxL/DtMHVb5PoqblsTckFqj/A+1+Yw
         S9nGL1ppSlzNIyc9yXqR2WMfpc6fjXhDFfEg/01ROVAr68/pUpSRG4CBgel6AFDNfiqg
         jAYw==
X-Gm-Message-State: AOPr4FWgoj5HmZ6ZvOy3ob8dqej/+RR3ciTK5YPxp3IQFW9kzfM3AZRHvfTSp9oSjyx2CNRPP1iDy8HSBsPAQ9Cj
X-Received: by 10.36.253.9 with SMTP id m9mr10919154ith.52.1463420761053; Mon,
 16 May 2016 10:46:01 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 16 May 2016 10:46:00 -0700 (PDT)
In-Reply-To: <xmqqlh393nuv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294762>

On Mon, May 16, 2016 at 10:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> Let's avoid "are meant to", which is merely to give you an excuse to
>>> say "it was meant to ... but the implementation did not quite achieve
>>> that goal".
>>>
>>>     The "label" attribute can be attached to paths, and the pathspec
>>>     mechanism is extended via the new ":(label=X)pattern/to/match"
>>
>> I wasn't sure about whether we want to have '=' or ':' as the separator
>> of "label" and its values. ...
>
> Oh, sorry, the above wasn't a suggestion to change : to = at all.  I
> was merely being sloppy in the details that is irrelevant to my main
> point (which is, it is better spend the bits you spent for "meant
> to" instead for saying clearly what it does).
>
>> ... But as that is only internal, we can be inconsistent to a new
>> public feature, so '=' seems better for the labeling system.
>
> I can buy that, too.  Good that my sloppy wording helped you think
> about it further ;-).
>
>> But still we do not enforce it early enough. Some crazy upstream may
>> add some labels which do not follow the requirements and then
>> tell downstream to run a command like `git foo "(label=!@#$)".
>> and then downstream curses at upstream as well as Git.
>
> That is why it is "warn and ignore", not "die".

So "warn and ignore" for data from .gitattributes and die for
commandline arguments? That makes sense.

>
>>>> +     if (ATTR_TRUE(check.value))
>>>> +             ret = 1; /* has all the labels */
>>>
>>> So this is "pretend that I have all the labels under the sun".
>>>
>>>> +     else if (ATTR_FALSE(check.value))
>>>> +             ret = 0; /* has no labels */
>>>
>>> I do not see a value in this.  What difference does it have compared
>>> to having a "label=" that explicitly says "I do not have one"?  What
>>> is your answer to an end-user question "When should I say 'label='
>>> and when should I say '!label'?"
>>>
>>> Just forbid it for now; we may find a better use for it later.
>>
>> I don't think we want to die in that code as it is in the data already.
>
> Is it?  I think this is coming from the command line pathspec magic,
> not from .gitattributes file recorded in the tree.

The 'check.value' is coming from the .gitattributes.

The 'required_labels' string list comes from the command line.
("The command line requires these labels")

>
>> We need to allow the UNSET case, as otherwise you'd need to label
>> any path if using labels?
>
> You do need UNSET (roughly, "no label is mentioned for the path").
>
> If I want to say "Everything under Documentation/ and also things
> with label=doc", I'd say
>
>         git cmd "Documentation/" ":(label=doc)"
>
> and no path in Documentation/ need any label, i.e. for them, the
> labels are unset.  They will not be caught with ":(label=doc)"
> because they are not set, but that is OK.

right. that is what the end user should be able to do. That also means,
we need to handle files with UNSET labels (all under Documentation/)

>
> FALSE is different from UNSET.  It needs an explicit mention, i.e.
>
>         *.doc   doc
>         false.doc       -doc

and this is in the .gitattribues, so warn-and-ignore and by ignore
we mean treat it as UNSET?

>
> What's the difference between saying "-doc" and not saying anything?
> If you really want to explicitly say "doc attribute is unset for
> this path (perhaps because you may have other patterns that set the
> doc elsewhere), you would say "!doc", and you already have code for
> that.
>
>>         if (ATTR_TRUE(check.value))
>>                 ret = 1; /* has all the labels */
>>         else if (ATTR_FALSE(check.value))
>>                 die(_("Label attributes must not be unset"));
>
> The message is wrong.  You are dying because the user explicitly set
> it to false, not because the user made it unset.

Ok, so here is the warn-and-ignore code:


        if (ATTR_TRUE(check.value))
                ret = 1; /* has all the labels */
        else if (ATTR_FALSE(check.value)) {
                warning(_("Path '%s': Label must not be false. Treat
as if no label was set"), path);
                ret = 0;
        else if (ATTR_UNSET(check.value))
                ret = 0; /* has no labels */
        else {

Thanks,
Stefan
