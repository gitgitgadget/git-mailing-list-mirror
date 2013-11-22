From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git issues with submodules
Date: Fri, 22 Nov 2013 21:42:48 +0530
Message-ID: <CALkWK0myk5fWcHdwNtjct4Ji4y4=iVT36wZxqOqZS6S7kem+OQ@mail.gmail.com>
References: <CAErtv26Q_YN+U+trjNac1aKLi9BvNHNNuaUkrr2RE0nB+yxWsw@mail.gmail.com>
 <CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com>
 <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
 <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com> <20131122151120.GA32361@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sergey Sharybin <sergey.vfx@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 22 17:13:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjtMM-0004br-Bw
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 17:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532Ab3KVQNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 11:13:30 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33900 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab3KVQN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 11:13:29 -0500
Received: by mail-ie0-f170.google.com with SMTP id qd12so2475354ieb.29
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 08:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fd85JgOWGLwbll0agi+fGI+X3lx0fpxUoER1w/thiZI=;
        b=BRMk+xdzGN0LIgnJo661E8aF7DOU7//H/cXnCWtkd8rhKGaYbTAbncJ1RYIFKQEWoN
         mMRU/RDxxKSQEAWud6qh8dh2EZOJjJJwH5Y7sVObA8J5LH2tibkbhAIvmEcX7S4iR/TE
         YNoLetQhHjq9dco9eZY6PYqB4Yk2KJWlj+jFdxMQwY4lup1J3CpAHleBMJcfS543xwk3
         00cAInY7Y8a/W1QIjW2uGIhLpp75cZpS9XvAHFQl92K2h5hqLVxFPKWSPHrM3EwImZlK
         t8tlUq0jd0G9NtLf8jtiJ+ooS7wcodk39I5pnn+5GFjKriWa2JMf+kjmjlPePKElL1Ts
         O8uA==
X-Received: by 10.43.129.130 with SMTP id hi2mr8781482icc.14.1385136808909;
 Fri, 22 Nov 2013 08:13:28 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Fri, 22 Nov 2013 08:12:48 -0800 (PST)
In-Reply-To: <20131122151120.GA32361@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238192>

Jeff King wrote:
>> I just checked it out: it uses `git ls-files -m` to get the list of
>> unstaged changes; `git diff --name-only HEAD --` will list staged
>> changes as well.
>
> That diff command compares the working tree and HEAD; if you are trying
> to match `ls-files -m`, you probably wanted just `git diff --name-only`
> to compare the working tree and the index. Although in a script you'd
> probably want to use the plumbing `git diff-files` instead.

Thanks for that. It's probably not worth fixing ls-files; I'll patch
Arcanist to use diff-files instead.
