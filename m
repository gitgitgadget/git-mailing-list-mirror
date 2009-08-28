From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Merging in Subversion 1.5
Date: Fri, 28 Aug 2009 18:19:06 +0200
Message-ID: <200908281819.10135.jnareb@gmail.com>
References: <4A979690.1050601@gnu.org> <m3ocq0km5m.fsf_-_@localhost.localdomain> <32541b130908280829s6fcebbe5ja84b10e649de1eb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthias Andree <matthias.andree@gmx.de>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 18:19:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh4Ab-0001Oc-UH
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 18:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbZH1QTM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2009 12:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbZH1QTM
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 12:19:12 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50919 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbZH1QTL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 12:19:11 -0400
Received: by bwz19 with SMTP id 19so1700965bwz.37
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=C7+ZMJ4prHbXjifvtZHaz/V9G3ljc+6SsQGE5AddqAc=;
        b=FMOLyqoOviWyugYSXWO1AO6YA3lXi/VnYFlF+Zpmrt8qEg2dKab4wrwgzrUBrGL9Nn
         uZnqermaj/TNzfN4YunE08Iq7WfCbppCqwCn6+w14SRhFgiZVuUXtGDiyjoEJb5pGFDk
         Pg/OeDbbpO9sXYV7oS4vJkavnOsV1xulTx/kM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=WC+8l76Zd0nfFbByedfFUwbyumpoAtIFKW6xbCEuJ8TGuZHtho/+w9YKfcTOql913y
         sV3Gk3CX+Wo5UU6VWTG/9sfEULJYQtc0wl6nwoTFYu+PfC79RwLm1cmgTagx9bfsuHfl
         wvqX+J5POPz+8BuG6v+XxuEjRg9EaLfBkHVeY=
Received: by 10.102.226.17 with SMTP id y17mr380890mug.67.1251476351846;
        Fri, 28 Aug 2009 09:19:11 -0700 (PDT)
Received: from ?192.168.1.13? (abvl130.neoplus.adsl.tpnet.pl [83.8.209.130])
        by mx.google.com with ESMTPS id j10sm5865484muh.26.2009.08.28.09.19.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 09:19:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <32541b130908280829s6fcebbe5ja84b10e649de1eb3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127309>

On Fri, 28 Aug 2009, Avery Pennarun wrote:
> On Fri, Aug 28, 2009 at 3:12 PM, Jakub Narebski<jnareb@gmail.com> wro=
te:

> > From what I understand (from what I have read, and browsed, and
> > lurged, and noticed) is that Subversion 1.5+ does merge tracking, b=
ut
> > in very different way that in Git:
> >
> > =A0* the svn:mergeinfo is client-side property; if I understand
> > =A0 correctly this would help you in repeated merges, but not anyon=
e
> > =A0 other
>=20
> I don't believe there is such a thing as a "client-side property" in
> svn.

What about svn:ignore or svn:mimetype (IIRC) property?

> I see someone said this on stackoverflow=20
> (http://stackoverflow.com/questions/1156698/are-svn-merges-idempotent=
)
> but I'm pretty sure they were either mistaken or using a different
> definition of "client-side."

I think I got this (wrong?) impression from there.

> > =A0* svn:mergeinfo contains _per-file_ merge info, so it is much, m=
uch
> > =A0 more "chatty" than Git multiple parents. =A0This might be more
> > =A0 powerfull approach, in the same sense that more advanced merge
> > =A0 strategies that 3-way merge were more powerfull -- but 3-way me=
rge
> > =A0 is best because it is simple (and either it is simple that 3-wa=
y
> > =A0 merge is enough, or complicated so manual intervention is requi=
red).
>=20
> svn people really love their cherry-picks and want to keep track of
> which things get cherry picked from one branch to another.  This is
> nice (at least for informational purposes) although they go through
> some probably-unnecessary contortions *after* doing this, including
> splitting a merge from "maint" into "master" into two sequential
> merges, if you've previously cherry-picked a commit from master into
> maint.  The above svn book link describes this in a bit more detail.
>=20
> I don't think that behaviour would be much help in any situation I've
> ever experienced, so I agree with your comment that 3-way merge is
> generally better.

Errr... what I meant here that I have read (on some blog, but either
I didn't bookmark it, or I can't find the bookmark) that svn:mergeinfo
is not as simple as listing _revisions_ which are merged (i.e. either
all parents, or additional parent), but it lists per-file merge=20
information, and can be quite large.
=20
> > =A0* You have to explicitely enable using svn:mergeinfo in log and =
blame
>=20
> Conversely, in git you can basically disable it using --first-parent,
> which is sometimes handy. [...]

In git-log.  But in git-blame?

--=20
Jakub Narebski
Poland
