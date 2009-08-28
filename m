From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Merging in Subversion 1.5 (was: Re: Using git to track my PhD 
	thesis, couple of questions)
Date: Fri, 28 Aug 2009 15:29:03 +0000
Message-ID: <32541b130908280829s6fcebbe5ja84b10e649de1eb3@mail.gmail.com>
References: <4A979690.1050601@gnu.org> <vpqk50pasek.fsf@bauges.imag.fr> 
	<9b18b3110908271521w764684cfg3b009f6960ee5dc4@mail.gmail.com> 
	<7v1vmxq6nw.fsf@alter.siamese.dyndns.org> <fabb9a1e0908271341o3a558eedq85541e68875ab77f@mail.gmail.com> 
	<20090827203402.GC7168@kisimul> <20090828133708.GA11146@kisimul> 
	<vpqpragt5bo.fsf@bauges.imag.fr> <4A97E1B1.7090107@gmx.de> 
	<m3ocq0km5m.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthias Andree <matthias.andree@gmx.de>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 17:29:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh3ON-0002ns-Jj
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 17:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbZH1P3W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2009 11:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbZH1P3W
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 11:29:22 -0400
Received: from mail-yw0-f184.google.com ([209.85.211.184]:47141 "EHLO
	mail-yw0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbZH1P3V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Aug 2009 11:29:21 -0400
Received: by ywh14 with SMTP id 14so2844936ywh.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=oMx+xxf2kH/SQLq/J8o0GBC/whIaM8jgLkV68ta7PK8=;
        b=oT0ge0HC99e617RoP3biM4GmrTMHxskbE3TcJ2q5gisROn5TAow+IVd4BNUGSUQijv
         quXCGN2TJYMTFl30vO3E1Yut/tOS0pmcd4MfagsddA8KMuqWClsPPjdeC/Dx+PdMjAjB
         3uGc+4C4bsIhatNyNOHsBs1bEmV7CS+cJKDQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JpsOmcggje+BSx3PbdjRBVsip80LK4RgsC1LEDp41DNZDu79lG/42AGlmDqlJPlvR3
         vnltW1vT3Sm9zS5FPCQf+a32siNw2r3VVX9Vj2vGQxeNNYVs+CVdzCUpSEbgNO+Kv0gD
         I93jWdElOWo6qLg0veGOFZ/qY/gl9ymQfhX6k=
Received: by 10.150.45.8 with SMTP id s8mr2350635ybs.227.1251473363078; Fri, 
	28 Aug 2009 08:29:23 -0700 (PDT)
In-Reply-To: <m3ocq0km5m.fsf_-_@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127303>

On Fri, Aug 28, 2009 at 3:12 PM, Jakub Narebski<jnareb@gmail.com> wrote=
:
> From what I understand (from what I have read, and browsed, and
> lurged, and noticed) is that Subversion 1.5+ does merge tracking, but
> in very different way that in Git:
>
> =A0* the svn:mergeinfo is client-side property; if I understand
> =A0 correctly this would help you in repeated merges, but not anyone
> =A0 other

I don't believe there is such a thing as a "client-side property" in
svn.  I see someone said this on stackoverflow
(http://stackoverflow.com/questions/1156698/are-svn-merges-idempotent)
but I'm pretty sure they were either mistaken or using a different
definition of "client-side."

I think they probably meant that it's the client's responsibility to
set the property correctly, not the server's, and if your client is
too old any you do a merge, it'll forget to set svn:mergeinfo, causing
confusion for everyone.  There's discussion in the svn book
(http://svnbook.red-bean.com/en/1.5/svn.branchmerge.advanced.html) but
nothing implies that it's a non-replicated property.  Indeed, I can
see no particular reason that anyone would want it to be, for the
reasons you specify.

> =A0* svn:mergeinfo contains _per-file_ merge info, so it is much, muc=
h
> =A0 more "chatty" than Git multiple parents. =A0This might be more
> =A0 powerfull approach, in the same sense that more advanced merge
> =A0 strategies that 3-way merge were more powerfull -- but 3-way merg=
e
> =A0 is best because it is simple (and either it is simple that 3-way
> =A0 merge is enough, or complicated so manual intervention is require=
d).

svn people really love their cherry-picks and want to keep track of
which things get cherry picked from one branch to another.  This is
nice (at least for informational purposes) although they go through
some probably-unnecessary contortions *after* doing this, including
splitting a merge from "maint" into "master" into two sequential
merges, if you've previously cherry-picked a commit from master into
maint.  The above svn book link describes this in a bit more detail.

I don't think that behaviour would be much help in any situation I've
ever experienced, so I agree with your comment that 3-way merge is
generally better.

Tracking cherry picks in git would be really nice *sometimes*, but it
creates a tradeoff where you then have to slurp in huge amounts of
history that you might not want.  In svn, this tradeoff doesn't exist,
since anything you cherry pick must have already existed on the server
anyway, and can never go away.

> =A0* You have to explicitely enable using svn:mergeinfo in log and bl=
ame

Conversely, in git you can basically disable it using --first-parent,
which is sometimes handy.  (It's handiest if your team has a policy of
always using --no-ff when merging into trunk, which makes git act a
bit more like svn's merge tracking.  I realize this is a bit heretical
to suggest on the git list, but I appreciate that the option exists
despite its heresy :))

Have fun,

Avery
