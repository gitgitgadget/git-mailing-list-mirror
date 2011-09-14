From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 08:25:15 -0700
Message-ID: <CA+55aFw08zEeWovDPRGCM2f-xCuamJogFzigka4=mfcpJbZpsA@mail.gmail.com>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org> <CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com>
 <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com> <4E7085E6.3060509@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 14 17:25:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3rLL-0008Ih-0L
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 17:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756781Ab1INPZh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 11:25:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59892 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760Ab1INPZg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 11:25:36 -0400
Received: by wwf22 with SMTP id 22so2375622wwf.1
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=z9IM6D1tXnlUYwZf9nCE4w4CdCM7jcmsXuZnCjnl+cA=;
        b=YNE+/DxBagkZBeW1EnSuJuQCXThMOt8PA4GQ3ZJxF/r8svVWaXJR5Frj3NRjXxigPv
         GVku9Zq75lhLYA5zGz111SMi6fk9xp/Wxc6v5AMIfyHkyEountNTYDJ1WD7cgaQUi6MM
         g7qPtxBl+gHxSZxsQqZxMk/tpM3SOtuor9hSI=
Received: by 10.216.220.142 with SMTP id o14mr711326wep.61.1316013935198; Wed,
 14 Sep 2011 08:25:35 -0700 (PDT)
Received: by 10.216.174.8 with HTTP; Wed, 14 Sep 2011 08:25:15 -0700 (PDT)
In-Reply-To: <4E7085E6.3060509@alum.mit.edu>
X-Google-Sender-Auth: NHkT_z39OGESwEvYF831Ss_hmeQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181362>

On Wed, Sep 14, 2011 at 3:45 AM, Michael Haggerty <mhagger@alum.mit.edu=
> wrote:
>
> Instead of "like a branch description", why not implement branch
> descriptions directly?

Mostly because of just human interface issues.

We already have a "repository description", and it's quite commonly
never even filled in. For branches, that would be doubly true, because
a lot of branches are throw-away.

So I think it would work if we made it part of of something like "git
push -s" - because that's when it starts mattering to others.

> I wish that one could annotate a branch (e.g., at creation) and have =
the
> annotation follow the branch around. =A0This would be a useful place =
to
> record *why* you created the branch, your plans for it, etc. =A0The
> annotation should be modifiable, because often a branch evolves in
> unforeseen ways during its lifetime. =A0Anybody could read the annota=
tion
> to get a quick idea of what kind of work is in progress.

I wouldn't be against that as a concept, I just think you'd be a small
small minority, and most branches would never get annotated.

But I don't really care deeply how it actually works - my main issue
is that git makes it way too easy to have bad merge messages. I think
part of that is an even simpler idiocy: we never even fire up the
editor by default for a "git merge", but we do for a "git commit".
That was a design mistake, and it means that if you want to actually
add a note to a merge, you have to do extra work. So people don't.

Now people do "git merge" in scripts etc, so we can't fix it ;-(

                    Linus
