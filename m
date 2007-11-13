From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Tue, 13 Nov 2007 14:27:04 -0500
Message-ID: <9e4733910711131127i15fb1e41g54752bc10bb28239@mail.gmail.com>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com>
	 <9e4733910711120736g31e3e84cx5a213afc4b889de7@mail.gmail.com>
	 <Pine.LNX.4.64.0711121613570.4362@racer.site>
	 <9e4733910711120822x18019fe6v40eb8ee0e48282dd@mail.gmail.com>
	 <Pine.LNX.4.64.0711121635130.4362@racer.site>
	 <9e4733910711120921q651208cby1276426ccd4b5fa4@mail.gmail.com>
	 <20071113042017.GB9745@sigill.intra.peff.net>
	 <9e4733910711122030q7bbf6057ubb6b5b27e1885500@mail.gmail.com>
	 <vpq3avah3r0.fsf@bauges.imag.fr>
	 <7vy7d2rmb8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>, "Jeff King" <peff@peff.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 20:27:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is1QO-0003KO-UQ
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 20:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbXKMT1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 14:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757400AbXKMT1G
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 14:27:06 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:14186 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756635AbXKMT1F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 14:27:05 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2060208wah
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 11:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=y9cTtY8CcBJ0LM5oT4pWHYfa8AAmt5SBIQ+hYf8dEPo=;
        b=LhxJauhwGlWgFubh62Ujj17ckToC40J9IG28lSzV1LU9UwKz05Zw6FzyX2OxlB+qg4knoH0nCPzaokAKyK7I/nu4rbVwd/nEmE+/XrVxd5J55nPlKBd4pU0p/yhfORZckV6G1cDyir/LuE/5nJgyEmV370ZMPbUh7kyFkvLFVbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fQ/keLNoVAw3CzIMIn8W/wfZlglQid1yQN3bkMdXR5Lpr/HUKIWOmykZadLLKNMbB8qa82oAhUwwFG8WJlbSCWoaUHJto+OJbqnIIAz8DT6OVz7svXJLQuf35bHUiQM3VTFmtaalG56uWPy23448+vvOYCO6n8hP/2aL7LPD++o=
Received: by 10.114.175.16 with SMTP id x16mr343720wae.1194982024490;
        Tue, 13 Nov 2007 11:27:04 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Tue, 13 Nov 2007 11:27:04 -0800 (PST)
In-Reply-To: <7vy7d2rmb8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64837>

On 11/13/07, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
> > "Jon Smirl" <jonsmirl@gmail.com> writes:
> >
> >> Execute bit was not set. I just set it for all the scripts. +x is not
> >> getting turned on with a default git init-db. I just made a new repo
> >> to check, no +x on the scripts.
> >
> > That's by design: "git init" gives you _example_ hooks, but they won't
> > run until you activate them explicitely with the appropriate chmod.
> >
> > That said, I'm not sure there's a really good reason not to run
> > update-server-info by default on push. It doesn't cost much and saves
> > a lot of troubles for beginners. Perhaps there are cases where the
> > performance cost is non-negligible.
>
> One incarnation of u-s-i we had in the past was quite a lot more
> expensive, but we discarded the complexity, so I'd agree it
> won't cost much in the current shape now.
>
> The expensive one tried to record information to help dumb
> transports better, such as "if you have this revision then you
> do not have to fetch that pack but instead fetch this", as we
> were discussing packs that have objects from duplicated,
> staggered ranges.  The idea did not quite pan out.

Could we add an alternates entry on the server that would cause the
client to first go fetch all objects the alternate has, then come back
and fetch from the initial server with a normal fetch? It's like a URL
redirect. You wouldn't fetch heads or tags from the alternate, just
all of the objects.

-- 
Jon Smirl
jonsmirl@gmail.com
