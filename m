From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] t: mailmap: add simple name translation test
Date: Mon, 6 Feb 2012 23:32:56 +0200
Message-ID: <CAMP44s356usz+Zxf1ooV=FEVxrFa2jRG0dWX5beLCvBTs-OMug@mail.gmail.com>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
	<1328385024-6955-4-git-send-email-felipe.contreras@gmail.com>
	<20120204201218.GF22928@burratino>
	<CAMP44s1ZPQJzHzYj7e4Kj3Cu+qq0Q3uKrwsE=xS7BmmSqd3gSw@mail.gmail.com>
	<20120204211544.GC3278@burratino>
	<CAMP44s0Z=k6VBfv0HOGHyMBLRcPauK7K5RNvuRDbfq5=5aKVpg@mail.gmail.com>
	<20120204234237.GB1366@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Jim Meyering <jim@meyering.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 22:33:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuWBK-0007bE-EN
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 22:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755435Ab2BFVc6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 16:32:58 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:50521 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754692Ab2BFVc5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 16:32:57 -0500
Received: by lbom4 with SMTP id m4so1253292lbo.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 13:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=61L+DQWZkTUDfz+R+sX3CZnPC4FUGiYZf5Z2wMc8UDM=;
        b=Mw+lN1FbJQJ1lubjmqMufnch9F0WRLgcZ05WcvzJeH8OcC5sHuGSQBSHsU86MssAov
         IUmuV+Hkmd1YNmPke+vhy9m2Ds+gj5PYjBi52mmbTaRR+EvVj0HMDhM6oc+Fsw8eGEhX
         K5+tbZ6mr4OwaYUEgEm7mzk7e2hndiV0Q40Q4=
Received: by 10.112.86.67 with SMTP id n3mr5346592lbz.29.1328563976249; Mon,
 06 Feb 2012 13:32:56 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Mon, 6 Feb 2012 13:32:56 -0800 (PST)
In-Reply-To: <20120204234237.GB1366@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190109>

On Sun, Feb 5, 2012 at 1:42 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Feb 05, 2012 at 12:19:53AM +0200, Felipe Contreras wrote:
>
>> > Thanks. =C2=A0I guess you think I'm stupid. =C2=A0I have no idea h=
ow I can
>> > correct that assumption and help you to actually work with me to m=
ake
>> > the code better. :/
>>
>> You mean the commit message, you haven't made any comment about the =
code.
>>
>> If you want to know why I had to modify those test assertions, you
>> really need to look at the code. In essence; all of them use the sam=
e
>> repo, and obviously adding a new commit message changes the output o=
f
>> the commands.
>
> Then say that in the commit message.

I believe that's overkill. If somebody needs an explanation, it's
because they are not familiar with the code being modified, and
introducing people to some code in each and every patch that modifies
it definitely seems like overkill to me. There is not even such
introduction in the code itself for this test, and in most of git's
code, presumably because we are following the principle of having
self-documented code.

If you look at the code, it would become obvious why so many hunks are
introduced, in fact, if you look closely at the patch you can see it
as well: look for strings related to CTO <cto@company.xx>.

> Looking at this series, I wonder if the tests should simply be squash=
ed
> into the bugfix patch, which might make what is going on more obvious=
=2E

Because it's a logically independent change?

There's _nothing_ that prevents this patch from being applied to
master *right now*. Of course, it would conflict, because it depends
on the 'git blame -e' tests, but if you solve that conflict by just
removing that hunk, it would apply and run just fine, and it would
detect regressions orthogonal from my other proposed patches.

> Keep in mind that as reviewers now, we read the whole series. But in =
a
> year, as "git log" users, we may see the commits in isolation.

Sure, and this patch by itself is good; it's adding a missing test
(even if you ignore the 'git blame -e' part).

Cheers.

--=20
=46elipe Contreras
