From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 15:28:48 +0530
Message-ID: <CALkWK0kkGO8zoLSpZkaYgVr5eBX6AovYFxQZkgJKugSw0CmdXQ@mail.gmail.com>
References: <CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
 <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
 <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
 <CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
 <CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
 <CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
 <CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
 <CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
 <CACsJy8AtH6PQ06_-UgumV0dRdq28qKn-Oj7EAy3g+eOTGhOyYw@mail.gmail.com>
 <CAMP44s2uV6CwdyadnJXSd+3mhOdApDxqdtjNyOPj3CbdsEyG0Q@mail.gmail.com> <20130609043444.GA561@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 11:59:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlcPb-000600-H3
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 11:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614Ab3FIJ7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 05:59:30 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:49959 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab3FIJ73 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 05:59:29 -0400
Received: by mail-ie0-f171.google.com with SMTP id s9so14258343iec.30
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 02:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MYrCbRz9UTH4jv5FRFH14fxzLOswfGN+tmzPYJZiMEA=;
        b=I5UPEtHTZ+0HbU1CtACO71xhWkEJGdbXNgxsg4/askvWoIfuhzDvmNRCRQ084Ej9Vn
         uH6D7y07++JzRSaWnM4ebWIuu++3JiTxFiq43GLL+fSfoXE/K8cp9WhWmKWpKoh0B1MR
         91n6lX5LBpBv16/qj0AMB2BpwRLfejxnvY1mhprkT9Kx6nouUOunS9yqsbECoegyxVYF
         ZBF3XOf++03/Gj9sTggjRifDQlL8QlR0X0IdMcd7pXdEN01l6O7q8AV8w6Sf/qeXOUai
         0107digvZxOLQnVQY4LtXzhuGDiS+zsuLsFKlw6cMxrF2hXU6tT47CF9rOzUt4du0TPe
         lujg==
X-Received: by 10.43.88.70 with SMTP id az6mr2176838icc.10.1370771968645; Sun,
 09 Jun 2013 02:59:28 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 9 Jun 2013 02:58:48 -0700 (PDT)
In-Reply-To: <20130609043444.GA561@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226949>

Jeff King wrote:
> Sorry that I cannot show you the source code, but you may interested to
> know that libgit2 powers:

Yes, I'm well aware of these: libgit2 is LGPL, because of which these
three proprietary applications have been made possible.  Isn't it
completely orthogonal to the discussion about how best to lib'ify
git.git though?  From what I understand, fc is not interested in
building another application leveraging libgit.a or libgit2; he's
interested in improving libgit.a and getting more users.

> It is definitely not feature-complete when compared with git.git. But I
> do think it is in a state that is usable for quite a few tasks.

What is this task you are discussing?  fc is talking about improving
libgit.a and getting an official git library with many users.  Answer
the question: what should we do now?

1. Start moving irrelevant code out of libgit.a, and use inspiration
from libgit2 to improve it (this might or might not involve taking
code from libgit2).  Get _users_ of libgit.a via ruby bindings (or
something) asap, so it puts pressure on fixing it.

2. Wait indefinitely until libgit2.git magically becomes ready to be
usable by git.git as-is.  Then throw libgit.a out the window, and
rewrite git.git to call into libgit2.a instead [*1*].

What you seem to be saying is "3. Work on libgit2 (and abandon
git.git?)" [*2*], or worse: 2.  fc is in favor of 1.  Unless you are
in favor of _not_ improving libgit.a, don't stand in his way: you
might personally think that it is a difficult (or impossible) task,
but that's no reason to stop fc from trying.  I personally think his
goal is admirable, and I'm nobody to say that it cannot be done:
therefore, I will review his patches and help him in whatever little
way I can.

[Footnote]

*1* You have dismissed 1 as being unworkable, but do you realize how
unrealistic this sounds?

*2* git.git has _far_ more users and a _lot_ more contributors.  Don't
be unwelcoming to contributors by asking them to go away and work on
something else.  The three proprietary applications you have given as
counter-examples (?) is not helping anyone.
