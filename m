From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Feature request: git bisect merge to usable base
Date: Wed, 30 Dec 2015 19:54:45 +0100
Message-ID: <CAP8UFD3vc+gZtPpWKgFug1NUXc3WzPFwtoNaZLiNiW5oW-WAqA@mail.gmail.com>
References: <CALCETrUgsawpwkkjO_BpPHyOaH7NsJNU-4mF97a6NAxCMB5aUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 30 19:54:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aELtb-0001sS-IF
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 19:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbbL3Sys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 13:54:48 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35047 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbbL3Syq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 13:54:46 -0500
Received: by mail-lf0-f46.google.com with SMTP id c192so54032500lfe.2
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 10:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4GDraspnqtP8vSxMAPFO1grzzInsLS5nCbqb83W6yOc=;
        b=fA1fnmeWoD180ruOVlJrHqTEPCjIjp6RmM5t9SQJWeGbXhh2yj9HopIzAEMCtMXd2h
         4xJNhPqTpF6YrFBrfr+95JPHgK206/HiCS7IoOCHhkHu0LGO4AGd4LtTdWXVKZx762sE
         LVQZjrGU2Q3OGH/O+rC8c7YQ/jCApqY8h/1lmKZBo7g1JN8aF4Ykll96M3+/j51PZQJO
         UAmayO7uVYNA6lCTWtCcspUAsyRrgdzI0oniW0PSIKOaY236+OrJeVIPpEI4BAuDnPEK
         m8Vs3lbC2A+BlVtOXjNNuZrroKiDI91Z7CoaIuVB7lE3wNGrO2B0xaaeROjOlWZNqUcm
         CRdQ==
X-Received: by 10.25.15.21 with SMTP id e21mr2005173lfi.124.1451501685099;
 Wed, 30 Dec 2015 10:54:45 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Wed, 30 Dec 2015 10:54:45 -0800 (PST)
In-Reply-To: <CALCETrUgsawpwkkjO_BpPHyOaH7NsJNU-4mF97a6NAxCMB5aUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283190>

Hi,

On Wed, Dec 30, 2015 at 11:40 AM, Andy Lutomirski <luto@kernel.org> wrote:
> Hi-
>
> I'm currently bisecting a Linux bug on my laptop.  The starting good
> commit is v4.4-rc3 and the starting bad commit is v4.4-rc7.
> Unfortunately, anything much older than v4.4-rc3 doesn't boot at all.
>
> I'd like to say:
>
> $ git bisect merge-to v4.4-rc3
>
> or similar.  The effect would be that, rather than testing commits in
> between the good and bad commits, it would test the result of merging
> those commits with v4.4-rc3.
>
> Obviously the syntax could be tweaked a lot, but I think the concept
> could be quite handy.

There have been talks about bisecting on the first parents and I think
it would be useful in your case.
After bisecting on the first parents you would know which merged
branch is responsible for the bug and you could for example rebase it
on top of v4.4-rc3 and then bisect on it.

You may find some scripts that might help you by searching for "bisect
first parent", like maybe there:

http://stackoverflow.com/questions/20240526/how-to-git-bisect-only-on-one-branchs-commits

Or maybe some old patchs on this list.

Best,
Christian.
