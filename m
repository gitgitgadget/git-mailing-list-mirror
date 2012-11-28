From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 28 Nov 2012 02:22:09 +0100
Message-ID: <CAMP44s0FiNRbFHbTtZJiWLDRQmy0VZ_FNGxE40eZrXwCFJ5P7A@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
	<20121127143510.GA15831@google.com>
	<CAMP44s10krOPD73dL0Ancie=kussk89jK7V5adR3hw=a73CVWw@mail.gmail.com>
	<20121128005128.GB23224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?TWFnbnVzIELDpGNr?= <baeck@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 02:22:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdWM6-0002gu-Gd
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906Ab2K1BWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:22:11 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:54775 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab2K1BWK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:22:10 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so13065268oag.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 17:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N+ViGMx7aQz6/SYn3RrV+J1tA70VEz/v0EoL8aw1lGY=;
        b=j8clZEs/g5cZpj8WxZVQaWXCC+1aYaWVCQfOinH68Oww/uKhpvn8tkWO6Fsv1bIM7l
         p0zxMWYQSyuMIMJO5xGyxRTHs1KjelpfAaRBPGVsQJM1FbWiP89ZCua1UpoV36djFhui
         l5qDIwdxBbcOXUZPcNnZFeM43HuKeG5Htm9mqCBJpS/9mNFWlHIx4h0VZTVPg4A1quPl
         08F9Jf8RJ3+Acto8LZgi6ZIdUttgWx0qsmtftzKkawkdccBGbgzyD4m37g3M/mAX9/4/
         WOQMGOupo5qluKWrRaklnqMW8OiAKyoepVHMdFGomiE62Z4M58atPD1vpbXhx9hCmKut
         ilWw==
Received: by 10.182.21.135 with SMTP id v7mr1504820obe.101.1354065729616; Tue,
 27 Nov 2012 17:22:09 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 17:22:09 -0800 (PST)
In-Reply-To: <20121128005128.GB23224@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210655>

On Wed, Nov 28, 2012 at 1:51 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 28, 2012 at 01:10:34AM +0100, Felipe Contreras wrote:
>
>> > While "constant traffic" probably overstates the issue, these are not
>> > theoretical problems. I recall at least three cases in the last year
>> > or so where Git has seen breakage with Solaris or Mac OS X because
>> > of sed or tr incompatibilities, and I don't even read this list that
>> > thoroughly.
>>
>> Most of the *constant* traffic is about *theoretical*
>> incompatibilities, how much of that are real incompatibilities, it's
>> not known. _Some_ of the traffic is about real incompatibilities,
>> sure, but you could count only three cases *in a year*. It's not a
>> huge amount. And then, how man this year?
>>
>> Also, I would like references to those incompatibilities.
>
> Try:
>
>   git log --grep='portab' -- '*.sh'

% git log --oneline --grep='portab' --since='2 years ago' --no-merges -- '*.sh'
6eafa6d submodules: don't stumble over symbolic links when cloning recursively

Somebody mentioned 'portable', but no problem was hit.

2718781 t9400: fix gnuism in grep

It's a test, and nobody was hit by any problem.

0dbe659 t5704: fix nonportable sed/grep usages

Apparently there was an issue, but this is a test.

93d5e0c t7810: avoid unportable use of "echo"

A problem, but in tests.

482ce70 tests: avoid nonportable {foo,bar} glob

Again, tests.

77e5726 t0050: fix printf format strings for portability

Tests.


So, this search didn't throw a single issue that affected users in two
years. Moving git sub-commands to python wouldn't change a thing.
Maybe shell wasn't the right language for the test system, but I don't
see anybody proposing it to be changed.

> Not all of the hits are shell portability fixes, but most of them are,
> and they are all in response to real, reported issues. The usual
> culprits are Solaris, BSD (including OS X), and the occasional GNUism.
> And that is only the ones that we fixed in response to bug reports for
> commits in the wild. Many more have been caught in review before needing
> a separate patch (grepping the list archive for 'portable' and '\.sh'
> yields 1800 messages).
>
> So dealing with shell portability is definitely something we do, and it
> is a minor pain.

First you have to separate the issues with the test system, because
that's not going to be changed. And then you have to separate the
*potential* issues and the *real* ones. You can spend all your time
doing "shell portability", but does that mean that you actually have a
problem? Maybe if you hadn't done anything, nobody would have noticed
there was a problem.

Sure, you will argue that we don't see the *real* issues, because they
were fixed preemptively, but the fact of the matter is that we will
never know. All we know is the reality we can observe, and the reality
is that we hit very few *real* issues outside the test system (feel
free to provide evidence to the contrary).

> But like you, I think we have been getting along reasonably well with
> shell scripts (and where it is not powerful enough, writing C). No
> solution is going to be free of portability issues (whether because of
> differing versions, because the tool is uncommon on certain platforms,
> or whatever). And because git-core's official API is shell-executable
> commands, any other language you write ends up looking a lot like shell
> anyway.

Agreed.

Cheers.

-- 
Felipe Contreras
