From: Uri Okrent <uokrent@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 08:27:03 -0800
Message-ID: <6839293b0911270827x54947c64q5f93e37664bc20f3@mail.gmail.com>
References: <20091125203922.GA18487@coredump.intra.peff.net>
	 <7vmy2as319.fsf@alter.siamese.dyndns.org>
	 <20091125214949.GA31473@coredump.intra.peff.net>
	 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
	 <20091125222037.GA2861@coredump.intra.peff.net>
	 <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
	 <20091127062013.GA20844@coredump.intra.peff.net>
	 <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302>
	 <20091127095914.GA4865@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0911271144230.4521@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, James Pickens <jepicken@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 27 17:27:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE3f4-0003QA-0H
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 17:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbZK0Q06 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 11:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbZK0Q06
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 11:26:58 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:44701 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbZK0Q05 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 11:26:57 -0500
Received: by pwi3 with SMTP id 3so1063062pwi.21
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 08:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IWyUxScP1tsTOqYsI+XS9PJYemWz+tXT8Ud642xHe0s=;
        b=sDtZFZsf9T2KFpju+uKihl+h2mRgbgE2oLPwr2drs9U7HT8eFfhqvx90nQB0jXKpBc
         z4Ka/pZOxVis6cgLZkpnLkBQp2AbEBDvOdOq1Wea/rFIwClP9wnB18mZg9Gn5t/rzdiJ
         v29C/8UMQLnfVaSOz0Nkt9LYpqpIRuttrp2D0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VgGhvGh1FVOlPv+Bgyg34z+n+hCaWlet4EXplXFz41X/tzuSuNDMKwjIHns+pciVan
         YpYTAdERwpP5cAlwOnetjdT9iklLMkMi6lDM/QR4GRp+MJV9rlf5XqzlYPCNSaSGh3VM
         hlPbM9w82v7JJXJYhnR7miAqu86DYIlSPXglk=
Received: by 10.141.106.13 with SMTP id i13mr76422rvm.0.1259339223848; Fri, 27 
	Nov 2009 08:27:03 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0911271144230.4521@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133908>

I've been following this thread for a long time and now I feel the
need to chime in...

On Fri, Nov 27, 2009 at 2:53 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> And it makes things inconsistent. =C2=A0That is why I do not use it.

The number one problem my users have with git is inconsistent
behavior, both internally to git, and externally with respect to the
rest of the OS. But really, the issue is one of managing expectations,
which is where we here tend to fall down.

When you name the command grep, whether you like it of not,
you've bought into a certain set of expectations from the user
who has been using unix's grep since she was a baby. Saying,
"well, in git it works this way", (or saying "well in git those path
looking things you've been providing to commands are not really
paths, so don't expect them to act as such"), would make my
users want to vomit all over me, and then, not use git (a shame
since it's the best scm system around IMHO).

If we intend the behavior of the command to be materially different
from the good old unix standby, then we shouldn't use the same
name, and create the expectation that they are getting essentially
the same thing (git search, git pickaxe, or something carries no
semantic baggage---and no, I'm not suggesting we change the
name).

> I, for one, do not like Git's reputation...

There's the rub. How do we achieve consistency without breaking the
world? The short answer is, you really can't. As programmers we tend
to be a very timid bunch, but sometimes (and David A. can attest to
this, at least at dayjob) it's better to just make a change for the bet=
ter,
and just deal with the breakages. It is possible to change behavior (an=
d
even break some scripts! I firmly believe it is worthwhile sacrificing
some scripts on the altar of consistency).

The key once again, is managing expectations. We can't go around
changing everything willy-nilly, and we can't be continually changing
things. Here is where we could take a lesson from the python
community.

When they decided they needed to change things, they bundled a
bunch of backwards incompatible changes together and went for it.
Yes, Python 3 will break your scripts, but the most important thing is,
everybody knows it.

A similar thing was done here with the huge warning that push spits
out, but in the general case I would argue, that the wisest course is t=
o
save backwards incompatible changes for a git 2 or something, where
we know we're breaking the world, and then scratch all our (well though=
t
out) backwards incompatible itches at once.

Whew. A bit of a rant, but there you go...
--=20
   Uri

Please consider the environment before printing this message.
http://www.panda.org/how_you_can_help/
