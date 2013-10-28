From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Mon, 28 Oct 2013 03:46:15 +0100
Message-ID: <CALKQrgcgfimZRJL7WyS-brqEZnHJkJjK_0cqe6-7HWkuCW6Dzw@mail.gmail.com>
References: <20131024122255.GI9378@mwanda>
	<20131024122512.GB9534@mwanda>
	<20131026181709.GB10488@kroah.com>
	<20131027013402.GA7146@leaf>
	<526CA7D4.1070904@alum.mit.edu>
	<20131027071407.GA11683@leaf>
	<874n83m8xv.fsf@linux-k42r.v.cablecom.net>
	<20131027092019.GB13149@leaf>
	<CALKQrgc7a+p5eebJErcGdA3QDyvdHEaef36RhZocQp9LjDUeeg@mail.gmail.com>
	<CAP8UFD3MZJKWUbdZqrSwoatpnx73MTpiwSkxPHYDagGjMSqJNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git mailing list <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	Linux Kernel mailing list <linux-kernel@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Oct 28 03:46:34 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Vacqf-0005bC-KP
	for glk-linux-kernel-3@plane.gmane.org; Mon, 28 Oct 2013 03:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529Ab3J1Cq1 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 27 Oct 2013 22:46:27 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:56717 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754833Ab3J1CqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Oct 2013 22:46:25 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VacqT-0004oI-1V; Mon, 28 Oct 2013 03:46:21 +0100
Received: from mail-pd0-f177.google.com ([209.85.192.177])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VacqR-000Leu-PL; Mon, 28 Oct 2013 03:46:20 +0100
Received: by mail-pd0-f177.google.com with SMTP id p10so6378241pdj.36
        for <multiple recipients>; Sun, 27 Oct 2013 19:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ARY3M5r+IV6i817Bb6qoQHP+p0EU37cI5TqxTMpqEGM=;
        b=JDbpNR7pSXPKdQldHkxj9mIB+I0UtkziHQuBVu5MdpFrPCkgHSn6yrVB2cTzuTA4SP
         N+fMg27aThkHeIn3nUnw62CkV3XJnAbozH7DYB35dhB4YakOelSGvluRVM/AP9uqjwh9
         MtC09sC/Tj8hIoIlhFArOII0efq8BEX79ZOZy11olGGdvkfjVMpfO2ST3p8HHmSvewno
         e5yHz6DtsNBAdqRKQFuvbQFE0R7LagM1SCZ8MAEend2RE61Vs4+xPRtl38TukEAiCdkU
         cpd/q0QVc8EodtAjOqjo3lnNc1s15KTSTZvPB8af8i+oSe0bokk0JgOygAr1T/0EOJ2/
         5ITA==
X-Received: by 10.66.146.170 with SMTP id td10mr333235pab.161.1382928375460;
 Sun, 27 Oct 2013 19:46:15 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Sun, 27 Oct 2013 19:46:15 -0700 (PDT)
In-Reply-To: <CAP8UFD3MZJKWUbdZqrSwoatpnx73MTpiwSkxPHYDagGjMSqJNw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236817>

On Sun, Oct 27, 2013 at 8:04 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, Oct 27, 2013 at 2:30 PM, Johan Herland <johan@herland.net> wrote:
>> On Sun, Oct 27, 2013 at 1:30 PM, Christian Couder <christian.couder@gmail.com> wrote:
>>>
>>> Your suggestion is very good, and it is not incompatible with command
>>> line options.
>>> So both could be implemented and even work together.
>>>
>>> For example if "-f ack:Peff" was passed to the command line, "git commit" could
>>> lookup in the commit message template and see if there is one
>>> RFC822-style header
>>> that starts with or contains "ack" (discarding case) and it could look
>>> in some previous commits if
>>> there is an author whose name contains "Peff" (discarding case)
>>
>> ...may be cheaper to (first) look at the .mailmap?
>
> Ok. I haven't really had a look at how it could best be done.
>
>>> and if it is the case
>>> it could append the following to the bottom of the commit message:
>>>
>>> Fixes:
>>> Reported-by:
>>> Suggested-by:
>>> Improved-by:
>>> Acked-by: Jeff King <peff@peff.net>
>>> Reviewed-by:
>>> Tested-by:
>>> Signed-off-by: Myself <myself@example.com>
>>>
>>> (I suppose that the sob is automatically added.)
>>>
>>> It would work also with "-f fix:security-bug" and would put something
>>> like what you suggested:
>>>
>>> Fixes: 1234beef56 (Commit message summmary)
>>
>> Even better: Imagine "-f" (or whatever is decided) as a general
>> mechanism for forwarding parameters to the prepare-commit-msg hook.
>> When you run "git commit -f ack:Peff -f fix:security-bug", the -f
>> arguments will be forwarded to prepare-commit-msg (as additional
>> command-line args, or on stdin), and then the prepare-commit-msg hook
>> can do whatever it wants with them (e.g. the things you describe
>> above).
>
> If "git commit" processes these arguments and puts the result in the
> commit message file that is passed to the
> prepare-commit-msg hook, then this hook can still get them from the
> file and process them however it wants.
>
> And in most cases the processing could be the same as what is done by
> the commit-msg hook when the user changes the "Fixes: xxx" and
> "Stuffed-by: yyy" lines in the editor.
>
> So it would probably be easier for people customizing the
> prepare-commit-msg and commit-msg if "git commit" processes the
> arguments instead of just passing them to the prepare-commit-msg hook.
>
> And it will be better for people who don't set up any *commit-msg hook.
> Even if there is no commit template, "-f Acked-by:Peff" and "-f
> Fixes:security-bug" could still work.
> I suspect most users don't setup any hook or commit template.

Hmm. I'm not sure what you argue about which part of the system should
perform which function. Let's examine the above options in more
detail. Roughly, the flow of events look like this

  git commit -f ack:Peff -f fix:security-bug
    |
    v
  builtin/commit.c (i.e. inside "git commit")
    |
    v
  prepare-commit-msg hook
    |
    v
  commit message template:
    Fixes: security-bug
    Acked-by: Peff
    |
    v
  user edits commit message (may or may not change Fixes/Acked-by lines)
    |
    v
  commit-msg hook
    |
    v
  commit message:
    Fixes: 1234beef56 (Commit message summmary)
    Acked-by: Jeff King <peff@peff.net>

(The above is even a bit simplified, but I believe it's sufficient for
the current discussion.) So, there are several expansions happening
between the initial "git commit" and the final commit message. They
are:

 1. "fix" -> "Fixes: "
 2. "security-bug" -> "1234beef56 (Commit message summmary)"
 3. "ack" -> "Acked-by: "
 4. "Peff" -> "Jeff King <peff@peff.net>"

First, I think we both agree that expansions #2 and #4 MUST be done by
the commit-msg hook. The reason for this is two-fold: (a) the
expansion must be done (at least) after the user has edited the commit
message (since the values entered by the user might require the same
expansion), and (b) how (and whether) to perform the expansion is a
project-specific policy question, and not something that Git can
dictate. Obviously, common functionality can be made available in the
default hook shipped by Git, but it's up to each project to enable
and/or customize this.

Second, there is #1 and #3, the expansion of "ack" -> "Acked-by:" and
"fix" -> "Fixes:". Is this expansion performed by the
prepare-commit-msg hook, or directly inside builtin/commit.c?

If you are arguing for the latter (and I'm not sure that you are), we
would need to add a dictionary to "git commit" that maps shorthand
field names ("ack") to the RFC822 -style equivalent ("Acked-by: ").

I would instead argue for the former, i.e. simply forwarding "ack" and
"fix" as-is to the prepare-commit-msg hook, and let it deal with the
appropriate expansion. The main reason for this is that if a project
wants to add another shorthand expansion (e.g. "bug" ->
"Related-Bugzilla-Id: "), they can do so without hacking
builtin/commit.c.

Certainly, we could ship a default prepare-commit-msg hook that knows
how to expand the usual suspects (like "ack" and "fix"), but
hardcoding this inside "git commit" is not optimal, IMHO.

>> The reason I like this, is that we can now support project-specific
>> conventions/rules without having to encode those directly in "git
>> commit" itself. The only thing "git commit" needs to know, is how to
>> forward the appropriate information to the project-specific hook.
>
> Supporting project specific conventions/rules would still be possible
> by processing lines in the commit message file without changing "git
> commit".
>
> If "git commit" is already able to do some processing, it only adds
> power to what can be done by people writing hooks.
>
> We could even have git plumbing commands used by git commit to process
> the -f (or whatever option) arguments and they could be reused by the
> *commit-msg hooks if they find them useful.

Can you walk through an example of such reusable functionality? ISTM
that you want to add quite a lot of infrastructure to git for very
small gains (preparing and cleaning up commit messages), when that
infrastructure could instead be added by those (few?) projects that
need it without complicating Git itself (it is e.g. trivially easy to
share code between the prepare-commit-msg and commit-msg hooks...)

>> One such project-specific convention/rule is the Signed-off-by line
>> (although it has certainly spread to quite a lot of projects). I am
>> not 100% comfortable with encoding this convention directly into "git
>> commit", because it serves as a "slippery slope" to encode even more
>> project-specific conventions/rules directly into "git commit" (the
>> proposals to add command-line options for the "Change-Id" and "Fixes"
>> headers are the two most recent examples), and the more we add, the
>> more we bloat the "git commit" command-line interface.
>
> I don't think we would bloat the "git commit" command line interface.
> We just add one option that could help a lot of people, even those who
> want something very special.
>
>>>>  2. No need to add any command-line options to Git.
>>>
>>> This is not a good reason. If many users prefer a command line option,
>>> why not let them use that?
>>
>> True. As explained above, what I don't want is to add another
>> command-line option _every_time_ there is a useful project-specific
>> convention. Adding _one_ option to rule them all is much more
>> acceptable to me. :)
>
> Great!
>
>>>>  3. The whole mechanism is controlled by the project. The kernel folks
>>>> can do whatever they want in their templates/hooks without needing
>>>> changes to the Git project.
>>>
>>> The Git project already manages sob lines. It would be a good thing if
>>> it could manage
>>> more of this stuff to help users in a generic way while taking care of
>>> user preferences.
>>
>> Yes, but the key word here is _generic_. It's impossible to make "git
>> commit" able to solve all problems for all projects, but we can make a
>> generic mechanism that helps projects solve their own problems more
>> easily.
>
> Yeah, but as you said in your initial message, the generic mechanism
> already exists with commit templates and *commit-msg hooks. The only
> question left is how an additional command line option can best help.
> And if this option does nearly nothing, it will not help much.

But I still don't see exactly what this option should do (inside "git
commit") that would end up being useful across most/all projects, and
not just something that could more easily be implemented in the
*commit-msg hooks for relevant projects.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
