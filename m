From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Sat, 3 Oct 2015 23:23:52 +0100
Message-ID: <CAFY1edZSNKepx_+2U=C-raOBiVK3Zh2r_Y_NO2-RtbhH_n-tdg@mail.gmail.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	<xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	<1443150875.3042.3.camel@kaarsemaker.net>
	<699c08632232180166145f70c7f16645@dscho.org>
	<CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
	<vpq7fnc83ki.fsf@grenoble-inp.fr>
	<vpq4mie1m3n.fsf@grenoble-inp.fr>
	<xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Luke Diamand <luke@diamand.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 04 00:24:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiVEC-0003Vz-Je
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 00:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbbJCWXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 18:23:54 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35746 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbbJCWXx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 18:23:53 -0400
Received: by igbkq10 with SMTP id kq10so38951566igb.0
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 15:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=l5vYwlx8gblkhzcka1aY7rE5clTJnfGcY7xsQjJINpI=;
        b=faDRMYZ1Qe1uh6CLnDCrDnJzLPhJw3pns7yxus2WniTs7vRh0PWw/NV2a2qMrXLZUu
         b2N+TokZO/xP6nYqMW4eoFdNFZUg/gyC3Plh99D7Vhn5VxrFsEVa4rSKfmHO06iReXQ5
         m1VSMdHhAAIuHP0/fmNKp7mNz4RQoiHA03RT7pnmO2WqNbaDT7qXHE9bZT5FOTGyEZPd
         bnOsPQJSL8E+VQz/J0Wgu8PwbOXeQVjgR1hpu1HtuSJTmzncXcJwe9q6ILlumfeRl0bK
         LAbtwAf5TXbNwfJH/ggZib34L1WNChzp9QQuI8pQn+XYQSYfvn6eCXrYS7ioAX7i+1o0
         pqwg==
X-Received: by 10.50.73.138 with SMTP id l10mr3900785igv.53.1443911032548;
 Sat, 03 Oct 2015 15:23:52 -0700 (PDT)
Received: by 10.79.12.215 with HTTP; Sat, 3 Oct 2015 15:23:52 -0700 (PDT)
In-Reply-To: <xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278987>

On 28 September 2015 at 19:47, Junio C Hamano <gitster@pobox.com> wrote:
> I won't enable it on github.com:gitster/git anyway, so I do not
> think that is a concern.  I thought what people are talking about
> was to add it on github.com:git/git, but have I been misreading the
> thread?  I do not even own the latter repository (I only can push
> into it).

I was momentarily surprised to hear that Junio doesn't own github.com/git/git
but I had a quick look at the github.com/git organisation, and it turns
out that Peff and Scott Chacon are the current owners - so at the
moment I think they're the only ones who could switch on the GitHub
webhook to hit Travis.

For what it's worth, I'd love to see Travis CI - or any form of CI -
running for the core Git project. It doesn't require giving write
access to Travis, and beyond the good reasons given by Lars,
I'm also personally interested because it opens up the possibility
of some useful enhancements to the submitGit flow - so that you
can't send email to the list without knowing you've broken tests
first.

Regarding Luke's concerns about excess emails coming from CI,
default Travis behaviour is for emails to be sent to the committer and
author, but only if they have write access to the repository the commit
was pushed to:

http://docs.travis-ci.com/user/notifications/#How-is-the-build-email-receiver-determined%3F

If Travis emails do become problematic, you can disable them
completely by adding 2 lines of config to the .travis.yml:

http://docs.travis-ci.com/user/notifications/#Email-notifications

Given this, enabling Travis CI for git/git seems pretty low risk,
are there any strong objections to it happening?
