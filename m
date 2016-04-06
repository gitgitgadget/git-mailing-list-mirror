From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] merge: refuse to create too cool a merge by default
Date: Wed, 6 Apr 2016 11:55:52 -0700
Message-ID: <CA+55aFy-mb00=KGWghx5XXfkv5dChnncoLoJA07f_2Y_or0FOw@mail.gmail.com>
References: <xmqqshznpmfe.fsf@gitster.mtv.corp.google.com>
	<CA+55aFz7309BkfHjD5H7tp9WE0yf1VWncxfmB3hgimJ00fbT-Q@mail.gmail.com>
	<xmqqwpoawpmq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 20:56:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anscY-0001Oz-BZ
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 20:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbcDFSzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 14:55:54 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:34389 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbcDFSzy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 14:55:54 -0400
Received: by mail-io0-f177.google.com with SMTP id 2so67437049ioy.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Ggs3PqAl1c02ughYnFEpULDt0DsKn/zntkXqYo3b+TY=;
        b=Enhh/KBnDkmrmj2quP5xA18oVQzrYJPoyQx61Ewn+vABeURYC+q4LB2ChVY038E4i6
         zJ0LN0agD7KA8uKunAN7Sf4RsjQ7m0KsMK9SWUWqrzC1YYg6+/czghYtWXSXYCMXbWIy
         L0sYarHczXMPSDq2VPcuQ01JoKGx9l7FAbJDg5TMwhwjfyLz92BP7g9U+/9RTImjx32x
         cH1s9YyuwIA3Aqzsd8nFsO8Zw26SMpHwgqTKzCDWG09LziZl/FGxPru8SSB3h9Jfr60F
         /rRL+KeVPCdWaHxLghm7Jm4gt+MmN5ooXv8D4LV/qk10xA4MZCz5aDz3Nz0ntc0Oboka
         J3kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Ggs3PqAl1c02ughYnFEpULDt0DsKn/zntkXqYo3b+TY=;
        b=eRlrbgMEwn3dHLghoMVfj+UhfIZ+jTXs6hLOcDLgYRqFP6cmb+Q6H1rN5Xoh5IdfaV
         tAQ1KizD75G6I7yvOeaDZ9y+SkqLH+XDTBqRWL9ZD9YFNrxPPZljrZrZUfXzqWQH7Gjq
         F5NVhR0/dq8+HetIixr27tbbGn+ZHfEpk5eVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Ggs3PqAl1c02ughYnFEpULDt0DsKn/zntkXqYo3b+TY=;
        b=fPWCPoVq4nePgGPA6RpHTMMiNi337oHDP74jDxSTlkBgr4BMhtLys5WUBbKSXZ3o7x
         gNtdGGFtG4xXxLtSG/CCg5Quj5VE8KhcdnwMB5EWA1aeqcci7PmuYyoYDCLlTyvMZjWN
         BmYz2T9Y+TjZT3KtvSyvwLrZDuTuxzN6ujCX+icIflpfTau0ioWG2TKS5YH3w4l8fr6D
         iKWQruEKxUs350FSyq8NHd4jpfLb7mNiA9o1e2LrVLdLk8uTzVp/LJ6HAeb9tQ3WgaVl
         HorBz7Kl3UxKzEjYJYtyV0VQmx/6sREKts/hSgF5Is9DQzILFjxHvSCrg/MgFF7dSfoZ
         CHJg==
X-Gm-Message-State: AD7BkJJE6aNa1dVjbmfSnebNPj9KRumHdRM7XWmJG6cDS7g06ujWa8gZYW+2Bga8ItcYal6KGn7b6EhV4FGs3w==
X-Received: by 10.107.5.2 with SMTP id 2mr20382192iof.89.1459968952921; Wed,
 06 Apr 2016 11:55:52 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Wed, 6 Apr 2016 11:55:52 -0700 (PDT)
In-Reply-To: <xmqqwpoawpmq.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: jkXVjfgvIwV0KTSI1QhTkDNaLn8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290861>

On Wed, Apr 6, 2016 at 11:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I was reviewing the topics to merge to 'master', and a thought
> crossed my mind.  Both of our series only refuse to create a merge
> that does not have any common ancestor, but shouldn't the right
> solution refuse to add a new root?

So I think that's an independent thing, and I think you're right, it
would be a good feature to have. As a maintainer, it would have caught
the whole "my submaintainers did something really odd, I need to talk
to them" before-the-fact rather than after-the-fact.

That said, I'm less worried about my submaintainers doing
_intentionally_ annoying things, than people doing silly things by
mistake.

So if I had a version of git that allowed me to say "don't allow pulls
that add a new root commit unless I specify a '--new-root-allowed'
flag", then yes, I'd use that. And I guess it might not be too nasty
to add: it could be done as part of the object checking pass after
downloading the pack. Was that what you were thinking of?

But at the same time, I think the existing series you have, which
hopefully results in these things not happening by mistake in the
future is the more important piece. I'd rather get good pull requests
than get errors and have to tell people "you screwed up, now we'll
need to re-do this".

But if you cook something up that checks that there are no new roots
in the pull, I'd certainly appreciate that safety net.

               Linus
