From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: push.default: current vs upstream
Date: Sun, 8 Apr 2012 15:52:52 +0300
Message-ID: <CAMP44s2p-pRq9E34M8KA009mcfv8572O87DCNw_w2At7r+OF_g@mail.gmail.com>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
	<20120329095236.GA11911@sigill.intra.peff.net>
	<7vbonfqezs.fsf@alter.siamese.dyndns.org>
	<20120329221154.GA1413@sigill.intra.peff.net>
	<7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
	<20120330071358.GB30656@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 08 14:52:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGrc3-0004aW-0E
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 14:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424Ab2DHMwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 08:52:55 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52379 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689Ab2DHMwy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 08:52:54 -0400
Received: by eekc41 with SMTP id c41so953795eek.19
        for <git@vger.kernel.org>; Sun, 08 Apr 2012 05:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0IwitaRKh6ch2z4Yf23nOPIGoBLtFHqAi+j/t01890Y=;
        b=dSNkGTqes4jZDmHXdxfwVdcrFylGmMCvqH5LrAkQJnc8/djPbkj6XpR1tXHyYM0sF3
         YptDOR+Kjed5RPkfHyL3avaH3CVULzCskFEwOz8q/268/UXQtMtQ67n8eAfPwLpPlwWT
         DddLZyJoLL6CdrprFSwBKXj8i/+Wb/QTw45u3VZpdv1HLvKF1pr8Etm6zdBAsdgWDZH7
         pFTbsyVm6IlWrcIjh2JhQi65ecsjl5cgrpsw/SksTvMMFVEVokiN7lzZ6DpW9DSSqoL6
         ggCfrLDlJgrm5Fu6fXyV7emchtCcGDmihmoQ37sQCMDoyquDQx7HYKaYi4ubD/ptuheE
         s9+g==
Received: by 10.213.35.196 with SMTP id q4mr250118ebd.29.1333889573001; Sun,
 08 Apr 2012 05:52:53 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Sun, 8 Apr 2012 05:52:52 -0700 (PDT)
In-Reply-To: <20120330071358.GB30656@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194995>

Hi,

I only now read this thread (or most of it).

First of all, personally I never do 'git push' because I'm never sure
of what it would do, and instead of trying to figure it out, I just
specify the branches/tags I want to push.

I've seen a lot of people vote for 'upstream', and while I think
that's an improvement, I saw very good arguments against it; namely;
the fact that the configured upstream might not be the right one, and
that it would be confusing to new users. Hell, I almost never know
what is the upstream branch of the branch I am currently on, so I
think 'current' makes more sense.

However, another good argument is that switching away from matching
would break the symmetry with 'git pull', while it has been argued
they are not really symmetric anyway, it would be nice if they were.
Which brings me to how I personally use 'git pull'; I never use it in
any shape or form, and the reason is similar to why I don't do 'git
push'; I don't know what it's going to do.

I think it's important to consider what people have been suggesting
new users, and one common suggestion has been to change the
'push.default' configuration right away, so it most definitely needs
to be changed, but another common suggestion is to avoid 'git pull'
completely.

Personally I think that if 'push.default' was 'current', I might use
'git push' without arguments more often, as I would know *exactly*
what's going to happen, and it's very often what I want. But also, it
would be great if 'git pull' without arguments did something
symmetrically similar; only pull a branch with the same name. In
addition to that, a lot of people end up doing merges by mistake,
because they use 'git pull' assuming it would do the same as in other
SCMs, so it would be great if 'git pull' would do --rebase by default,
and use the remote/current branch as the base for the rebase instead.
This is more or less what I always end up doing manually anyway (git
fetch origin; git rebase -i origin/master).

While the 'git pull' changes are a separate topic, I wanted to mention
them as a rationale as to why I think 'push.default' should be
'current'.

Cheers.

-- 
Felipe Contreras
