From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Thu, 18 Oct 2012 11:03:56 +0200
Message-ID: <CAMP44s2wOX0-UrTM5t5ewZ4yhOJJU=+SfB9PoTQKdsP4Pzsnpg@mail.gmail.com>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
	<alpine.DEB.1.00.1210171759230.3049@bonsai2>
	<CAMP44s1WY+Q7jyy4PQvwff7JSxHsnkhrPWozOLnNuNOrn7FGBA@mail.gmail.com>
	<alpine.DEB.1.00.1210171936170.3049@bonsai2>
	<CAMP44s2=hhMz35SpYXMBLcQPfVaPxY4pBWZDF7zbqVwz=tbedA@mail.gmail.com>
	<CAGdFq_i4c=ei4ni5bv9nNEbCfNG4sbRkqyip2voW17GhkRAKPQ@mail.gmail.com>
	<CAMP44s2-BCuA5v7jE8S3d-Gg+DxKf6Yte9MvTDBDr4jEkLKZ9g@mail.gmail.com>
	<alpine.DEB.1.00.1210181031320.3049@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 11:04:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOm1Q-0008LT-Kd
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 11:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643Ab2JRJD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 05:03:58 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:40318 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631Ab2JRJD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 05:03:56 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so8361212oag.19
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 02:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UE6wEue//2bdL/+4YbBbHLEUKP5WHOkS+ilOFs4WpFM=;
        b=DeBWR2ijo+4Cd1gqDWnaHsszKG07ZnDaQGQ+Rk44eFly25sQcTNYXcgyodA+QF3Jh8
         9Xx4RBG2s0NixD4zAIa3EGVQ9qnq4tEgR3wZwzi9VAFk2OP+MNNThI/6RzRD03xv5MjJ
         /hbAxrJrDfkwCjiXSHXaaS1wD+xXu/7BFuBovfTyymf+TxckEMiOPtEfFns/Gev8KAmn
         Kn9lShPRXk4w9sADpbSqYyG5kDyk/kcGlQPnK6iuSo8ybW+UblKocAHYmANQ0zYwR8Z7
         ePWpCdivRplKs4B5PH3Ka+ZV75edTXVNysBA2wuCEuI3982E3oYGjNzr7ajN4jxQ6uod
         C+WA==
Received: by 10.60.31.241 with SMTP id d17mr9036425oei.107.1350551036114; Thu,
 18 Oct 2012 02:03:56 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Thu, 18 Oct 2012 02:03:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1210181031320.3049@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207980>

On Thu, Oct 18, 2012 at 10:47 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Felipe,
>
> On Wed, 17 Oct 2012, Felipe Contreras wrote:
>
>> On Wed, Oct 17, 2012 at 8:18 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> > On Wed, Oct 17, 2012 at 11:12 AM, Felipe Contreras
>> > <felipe.contreras@gmail.com> wrote:
>> >> But fine, lets remove the tests out of the equation (150 lines), the
>> >> number of lines of code still exceeds 3000.
>> >
>> > I don't think it's fair to just look at LOC, git-remote-hg when it was
>> > just parsing was fairly simple. Most of the current code is our copy
>> > of the python fast-import library which is only used to support
>> > pushing to mercurial.
>>
>> Well, as a rule of thumb more code means more places for bugs to hide.
>
> Everybody on this list knows that. But it is equally true that more
> functionality requires more code.

Not necessarily. There's projects with more code and less
functionality than their alternatives.

>> It is also quite frankly rather difficult to navigate; very
>> spaghetti-like. I have the feeling [...]
>
> Yours truly always welcomes constructive criticism. Other types of
> criticism, not so much.
>
> As to the functionality you seek: git-remote-hg found in
> git://github.com/msysgit/git works. It has the following advantages over
> every other solution, including the one proposed in this thread:
>
> - it works
>
> - no really, it works

Not for me.

> - it supports pushes, too

I don't care. When I need that I'll implement that with probably much less code.

> - it matured over a long time

So has CVS.

> - there are tests

Only a dozen of them. If I write the same tests for my solution would
you be happier? I didn't think so.

> - whenever we fixed bugs, we also added tests for the bug fixes

Like this one?
https://github.com/msysgit/git/commit/9f934c9987981cbecf4ebaf8eb4a8e9f1d002caf

I don't see any tests for that.

> - it is in constant use

So you say, my impression is different.

> Without push support, remote-hg is useless to me.

Different people have different needs.

Without an easy way to setup, remote-hg is useless to me.

> If there are concerns about code style or unnecessary code (insofar it is
> really unnecessary, testgit for example is not, unless you want to avoid
> robust regression tests), I will discuss issues and collaborate. If the
> idea was not to collaborate, but to show off how much shorter code can be
> when it lacks functionality and proof of robustness I require for my
> everyday use of the program, dismissing existing code and concepts, less
> so.

So your idea of collaboration is accept that your code is awesome, and
my code sucks, and that I should fix your code, and throw my code to
the trash, while you do absolutely nothing but complain about the
whole situation. I have at least looked at your code. Have you even
looked at mine?

I've done my part in making my code easily available and ready for
review. I will not reply to you anymore until you show your
willingness to collaborate that you seem to demand for me, and:

1) Point to a remote-hg branch that is independent of msysgit stuff,
or any other irrelevant stuff
2) Is based on top of a recent version of git

Cheers.

-- 
Felipe Contreras
