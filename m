From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 09:53:01 +0100
Message-ID: <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 09:53:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcXxw-0003bI-Hz
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 09:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846Ab2KYIxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 03:53:04 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:41139 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab2KYIxD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 03:53:03 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so9932123oag.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 00:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xoD1g9xwFICArR5PxDUOrgSyLxVbH3voeKHl3F8dREI=;
        b=s8JupcRp9p7VfoL5JgNrhkfpzg3/29axLqQwh4tI8QRr6owst5erBzMJKrtdhhDx47
         w8KIFl2fpkQUGXjNEEwAJNlZtz3OxGQhQikShp2DvqFn7eNc0Ph4MbZnuhBgh9XzmuE7
         Ksmt5gJCXTA+iGnjf76hgRbLwSCCH6SG+S0wMfYhg8RYYlNyLkVMBTNPNrkKBE3QXt4K
         gme3Tz78wELfcuEpiiYkcFYeaIXJTmQsDrg1vxbCe5mKfsUL60yXqgfBk0z/QIonEGp1
         ftir1d7F/9DbT0aNuueSw9rABBn/pN+pLKF0R8BRSTxtls7WN21+atsUbbY4N0a+MDxv
         7iGA==
Received: by 10.182.98.19 with SMTP id ee19mr6530761obb.90.1353833582005; Sun,
 25 Nov 2012 00:53:02 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Sun, 25 Nov 2012 00:53:01 -0800 (PST)
In-Reply-To: <20121125024451.1ADD14065F@snark.thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210337>

On Sun, Nov 25, 2012 at 3:44 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> git presently contains one Python extension command, Pete Wycoff's p4
> importer.  If my git-weave code is merged it will acquire another.
> I think we can expect more submissions of Python extensions in the
> future, for two good reasons:

According to the Git User Survey 2012, 1% of the responders used the
'git p4' tool. I don't know how much widely used 'git weave' would be,
but I wouldn't want to star changing policies for issues that are
practically non-existent or irrelevant for the vast majority of git
users.

> We're behind the best-practices curve here.  The major Linux
> distributions, which have to deal with almost the same set of
> tradeoffs we do, went to Python for pretty much all glue and
> administration scripts outside /etc a decade ago, and the decision has
> served them well.

If your friends jump off a bridge, would you? Yes, using python has
served them well, but as opposed to what? Other scripting languages? I
don't think so.

> I should also point out that none of Mercurial's problems seem to
> have anything to do with the fact that it's written in Python...

I agree that the _current_ major problems with mercurial are not
related to python, but once those are solved, who says python won't be
an issue?. That's an exercise in guesswork, because we can't know.

> I think we can choose a better policy based on some simple premises.
>
> 1) In 2012, we can specify a "floor" Python version of 2.6 (shipped in
> 2008) and be pretty much guaranteed it will be anywhere we want to
> deploy except Windows.  Windows will remain a problem because Python
> isn't part of the stock install, but that's an equal or worse problem
> for shell and Perl - and at least the Python project ships a binary
> installer for Windows.

What if my extension only supports python 2.7? Or what if my extension
wants to support 2.0?

> 2) Python extension commands should test the Python version on startup
> and die loudly but gracefully in the rare case that they don't find
> what they need.

Yes, they should _if_ they know what version they need. In my
extensions I really have no idea.

> 3) We should be unconditionally be encouraging extensions to move
> from shell and Perl to Python.  This would be a clear net gain is
> portability and maintainability.

NO! It's up to the developer to choose what language to use, and I
find it very chauvinist of you to say "python is better, so let's all
use python". So far you have listed a few advantages of python, but
you haven't explained so far what is wrong with shell and perl.

In fact, while advancing python you have made clear a problem with
python; the version requirements. So far I have *never* encountered a
problem with git because of my bash version, or my perl version. And
we haven't touched to the python3 mess yet. To me, those are
advantages of shell and perl.

Actually, I don't care if 'git foo' is written in perl, or shell, or
c; as long as it *works*. And I would hate it if 'git rebase' ever
told me that I need a newer version of python, or worst; that I don't
have python in my system (Arch Linux ships 'python2', not 'python').

And what if X developer that wrote Y tool loves perl, and hates
python? Or loves ruby? Are we going to kick him out of the project
because (s)he refuses to switch to python? Are we going to threat him
like an outsider, a rogue developer?

> 4) We should be encouraging C code to move to Python, too.  There's
> little gain in portability on this path because modern C has cleaned
> up its act a lot, but the drop in expected bug loads would be well
> worth the porting effort.  Segfaults are not your friend, and the x2 to
> x5 drop in line count would do very good things for long-term
> maintainability.

Definitely NO! I really really doubt git in python would be able to
achieve the same performance as git in c, but to show me wrong, it
wouldn't be very difficult to run a few measurements with python
dulwich *if* we are even to begin considering this point.

And are segmentation faults really that different from python's
exceptions? Not to the user.

And why not ruby instead?

If you are serious about this, I think there's a lot more to work to
show that there's anything wrong with the current situation, and that
other alternatives (e.g. ruby) are not good solutions. I for one would
like to see more tools move away from perl/shell, and into C. And
other tools move to ruby, but that it's up to the developers of those
tools, unless I myself do it.

Cheers.

-- 
Felipe Contreras
