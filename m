From: Thomas Badie <thomas.badie@gmail.com>
Subject: Re: A new way to get a sha1?
Date: Mon, 30 Jul 2012 19:33:01 +0200
Message-ID: <CAFjFENrBskVHYZT1rLnAYXDjUJ_2HrFR7+L1=HrEV5iOWXZt8g@mail.gmail.com>
References: <jv5tln$96e$1@dough.gmane.org>
	<alpine.LNX.2.01.1207301426090.25013@frira.zrqbmnf.qr>
	<CAFjFENqGTumBRkDX4vJjQhGz0CrEC1VU1cDHWCERywa8vjVbRw@mail.gmail.com>
	<20120730165147.GD16701@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jan Engelhardt <jengelh@inai.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:39:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvtwV-0006Ym-RR
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 19:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970Ab2G3Rjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 13:39:31 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:40146 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933Ab2G3RdC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 13:33:02 -0400
Received: by qaas11 with SMTP id s11so1120736qaa.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pwzl9TJWCjesr1Ff82a6rHRC2tDZXJKjnNyoq9xrZGw=;
        b=UP17sJAAZKjhfWpAL2a8+oCWlNCMa5KwlOFNyh1gVpulMz/IspRO9C/rsiofFYx5B/
         9qfAvUQkWPpNJdLA6u+WJ/aT5qaUuvlX714EzYjWJJQeafFCwh39EbYKJRNF71h14j/Y
         7vwjlaPGp5RTdogDKDIDRR+N2/3yI5zuxcoeV5LHA5jEjIz3HhH1PLyVE0HO4u+h/vX3
         hS4S+SIpaACPhflQ/8Win4a7JXYNIHpUYSAUOsAKIQoR/mM9VIxQYf4t4kBfiCagZvQ2
         SFLiaSrF+3ZRpqRrNWOj9OjqSfuxVvletOpWmY+qQFXToyZGawdD8a/LosEiPfOtpu4T
         3mBg==
Received: by 10.229.136.3 with SMTP id p3mr5896862qct.55.1343669581305; Mon,
 30 Jul 2012 10:33:01 -0700 (PDT)
Received: by 10.224.128.211 with HTTP; Mon, 30 Jul 2012 10:33:01 -0700 (PDT)
In-Reply-To: <20120730165147.GD16701@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202591>

2012/7/30 Jeff King <peff@peff.net>:
> On Mon, Jul 30, 2012 at 06:40:12PM +0200, Thomas Badie wrote:
>
>> I understand your opinion. My solution was a easier way to make your
>> proposition about `git log --oneline`, because I don't want to copy these
>> 6 numbers by hand. I'd prefer select the right line simply.
>>
>> My solution is intended for people who just use git, and whatever their
>> environment (Unix, Windows...) because all is contained in git.
>>
>> But I clearly agree that there is a lot of other solutions by using external
>> tools.  But IMHO, it is preferable that I just have to add a `-i' to a command
>> to make this choice simply, and not having to use my WM for this kind of task.
>
> I am pretty mouse-averse, and I find a nice solution to these sorts of
> interactive-selection problems is to use your editor. In its most basic
> form, something like:
>
>   git log --oneline >tmp
>   $EDITOR tmp ;# and delete everything you don't want
>   git cherry-pick `cat tmp`
>
> assuming you are proficient with your editor, finding the entry you want
> and deleting all of the unwanted lines should be just a few keystrokes.
> And you can simplify it with a script like this:
>
>   $ cat `which vpipe`
>   #!/bin/sh
>   trap 'rm -f $tmp' 0
>   tmp=`mktemp vpipe-XXXXXX` &&
>   cat >$tmp &&
>   ${EDITOR:-vi} $tmp </dev/tty >/dev/tty &&
>   cat $tmp
>
> which you can then use like:
>
>   git cherry-pick `git log | vpipe`
>
> I know that sort of thing is not for everyone (you have to really like
> your editor), but I thought I'd share in case it is useful.

For this case, I don't think I'll use it, but it shows how to use the editor
in a replacement of an interactive tool, and it is interesting. I'd change
vi for emacs but this is religious. I never though using my editor this way,
and maybe one day it will be useful.

Thanks for your answer.

-- 
Thomas Badie
