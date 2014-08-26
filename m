From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Re: Re: Relative submodule URLs
Date: Tue, 26 Aug 2014 10:18:48 -0500
Message-ID: <CAHd499CC3XxE5X3OPobK9yNKqypCLP5pe1Q7cFyW_wWne6pnnQ@mail.gmail.com>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
	<20140818205505.GA20185@google.com>
	<CAHd499DVf4N3Y6m5qoiy-WQGX4K54umefRzehZMsrxiWbaiZ=g@mail.gmail.com>
	<53F76907.1090904@xiplink.com>
	<20140824133428.GA2839@book.hvoigt.net>
	<CAHd499Bat5AFc1E4Sfezx9Qi8LPsxkyKKkBb2eg8JQb9kdPzgg@mail.gmail.com>
	<20140826062847.GA12216@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 17:18:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMIWM-0007KM-CO
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 17:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758536AbaHZPSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 11:18:50 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:59779 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758529AbaHZPSt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 11:18:49 -0400
Received: by mail-yk0-f182.google.com with SMTP id q9so11344619ykb.41
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kSj+77CrICZIW1BXd8bU26EQ4tQ01nPoQMAT8WIlXPY=;
        b=f0cCmD8Zpz3SVqkeZJeAk5L0712S90w6KAddD2ufe6wbr3DJD212/guw/8t33Kl/8Y
         K+hHqUOSlbSSitFdnBr6bs+gg7qmB/7lmJ40Jn8lYlRpqTajHl4YmxXPY9QqifpO17sy
         nTti8j8FKvtbOw1zI9GmQA2BOQme6pHdAHyxGb7wVXmdArOa9Zb53JCklxSONmdCVM2v
         FEaC4+vWiMiGkxIhANbdFVdOqE0S4SKPFP8w/nUni9yFLasi2tIen6lfjwPM8yICfKTw
         rAUSRr9Qp7d1bxskX9cRGIAs509JRK7j588kEzbLrMEwECKWPiX59vtKOWDydHW1+ZzX
         ZtCA==
X-Received: by 10.220.17.145 with SMTP id s17mr83953vca.77.1409066328212; Tue,
 26 Aug 2014 08:18:48 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.201 with HTTP; Tue, 26 Aug 2014 08:18:48 -0700 (PDT)
In-Reply-To: <20140826062847.GA12216@book.hvoigt.net>
X-Google-Sender-Auth: TvvRF8oGCyCyO7tB02XYBGfW8K8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255907>

On Tue, Aug 26, 2014 at 1:28 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>> Hi Heiko,
>>
>> My last email response was in violation of your request to keep the
>> two topics separate, sorry about that. I started typing it this
>> weekend and completed the draft this morning, without having read this
>> response from you first.
>
> Thats fine, no problem.
>
>> Here is what I think would make the feature most usable. I think you
>> went over some of these ideas but I just want to clarify, to make sure
>> we're on the same page. Please correct me as needed.
>>
>> 1. Running `git submodule update --with-remote <name>` shall fail the
>> command unconditionally.
>
> I am not sure but I think you mean
>
>         git submodule update --with-remote=<name>
>
> With the equals sign, without it you would name the submodule paths to
> update. No I think that should just add the remote <name> to all
> submodules that would be updated and do the normal update operation on
> them (with the new remote of course).

I'm not sure about Linux but at least with msysgit on Windows, typing
a two-dash option (such as --with-remote) forces command line
evaluation to use the next placement parameter as the parameter for
it. I've seen this work the same way with argparse in python too. In
my experience, command line has worked that way, I'm not sure if that
is by design or not though. I never use equal signs with git commands,
never had a problem for some reason.

For example:

git rebase --onto release/1.0 head~3 head

The `--onto` option knows to use `release/1.0` as its parameter.

>> 2. Using the `--with-remote` option on submodule `update` or `sync`
>> will fail if it detects absolute submodule URLs in .gitmodule
>
> Yes, almost. Since you can have a mixture I suggest to only fail if the
> submodules that would be processed have an absolute url in them. If
> processed submodules are all relative it can go ahead.

For example if it processes 3 submodules in the following order:

1. relative
2. absolute
3. relative

Should it fail before or after processing the 3rd relative submodule?
I was thinking it would fail while trying to sync/update the 2nd one
(which is absolute) and stop before processing the 3rd.

>> 3. Running `git submodule update --init --with-remote <name>` shall
>> fail the command ONLY if a submodule is being processed that is NOT
>> also being initialized.
>
> No since the --init flag just tells update to initialize submodules
> on-demand. It should just go ahead the same way as without
> --with-remote.

But doesn't the on-demand initialization need to evaluate relative
URLs and convert them to absolute based on the .gitmodules
configuration? I thought the idea was to make `--with-remote` invalid
for initialization/sync of absolute URLs.

In other words if I did:

git submodule init --with-remote fork my-submodule-dir

and if my-submodule-dir was not relative in .gitmodules, then the
`--with-remote` flag becomes useless. We could fail silently but for
educational purposes to the user I thought we were failing in these
scenarios. Maybe I misunderstood your original intent with the
failures? Is init not doing the relative to absolute evaluation like
I'm thinking? Please correct me where I'm wrong.

>> 4. The behavior of git submodule's `update` or `sync` commands
>> combined with `--with-remote` will REPLACE or CREATE the 'origin'
>> remote in each submodule it is run in. We will not allow the user to
>> configure what the submodule remote name will end up being (I think
>> this is current behavior and forces good practice; I consider `origin`
>> an adopted standard for git, and actually wish it was more enforced
>> for super projects as well!)
>
> No please carefully read my email again. I specifically was describing
> the opposite. --with-remote=<name> creates/replaces the remote <name> in
> the submodule. I do not see a benefit in restricting the user from
> creating different remote names in the submodule. I think it would be
> more confusing if the remote 'origin' in the superproject does not point
> to the same location as 'origin' in the submodule.

Well the reason why I said it would be 'origin' is so that the
submodule knows which remote to use internally during an update. I'm
assuming 'update' uses 'origin' internally in the submodule to know
which remote to pull from. My understanding of how `git submodule
update` knows which URL to pull from is probably incorrect. I'm not
familiar on the internal mechanics of how this works. Perhaps you
could explain or send me to some reading material on it?
