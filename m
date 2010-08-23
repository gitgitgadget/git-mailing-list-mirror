From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] optionally disable overwriting of ignored files
Date: Mon, 23 Aug 2010 17:11:46 +0200
Message-ID: <20100823151146.GA15379@localhost>
References: <4C6A1C5B.4030304@workspacewhiz.com>
 <7viq39avay.fsf@alter.siamese.dyndns.org>
 <20100818233900.GA27531@localhost>
 <vpqd3t9656k.fsf@bauges.imag.fr>
 <4C727E17.5070707@ira.uka.de>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Aug 23 17:11:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnYgg-0004xR-QZ
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 17:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab0HWPLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 11:11:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61183 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680Ab0HWPLl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 11:11:41 -0400
Received: by fxm13 with SMTP id 13so2999823fxm.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=89eiItCROkuaEes9J79wN8303my22xLiiaetTF6kZLE=;
        b=MSHetv6cxsg80aAxsx7w/eTSyjKUlPG/qylCQFAnDm571Xjp2zW8PExR4TVIT3wiUO
         CUBMhzfZq2PYOXItNgsPC0hLzQZ6yLTvhHhjGrgA7aR0R7TNs6j+cfcbVnay+7dNvK20
         S9aYlk80qCVZFvrYsqKvIVdPTA6z+L8nDa7oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=iQgyNr5stqfjnGPn30Wj8mB/oJAF/jMKvCmsLpmNjpGknHb069jbzkdL6ZSvBHIz+a
         lYdvfmC0VovrjOXqXre3zEXOXEZwBjAwIlb2B2PiPYw2Vmyc2j17vgJOvjaWmGYZOnyJ
         zI0U01eJo3RIqPMRJ6PqhLeww1S6dCVOnEZjw=
Received: by 10.223.113.13 with SMTP id y13mr4478633fap.37.1282576299988;
        Mon, 23 Aug 2010 08:11:39 -0700 (PDT)
Received: from darc.lan (p549A60D7.dip.t-dialin.net [84.154.96.215])
        by mx.google.com with ESMTPS id f28sm2518183faa.24.2010.08.23.08.11.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 08:11:37 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OnYgc-00042Q-Ei; Mon, 23 Aug 2010 17:11:46 +0200
Content-Disposition: inline
In-Reply-To: <4C727E17.5070707@ira.uka.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154229>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 23, 2010 at 03:56:39PM +0200, Holger Hellmuth wrote:
>=20
> You've got my vote. This is the only option that combines safety with
> minimal configuration hassle.
>=20
> I didn't know about this subtle difference between .gitignore and
> .git/info/exclude. And while this makes sense I expect a sizable
> percentage of users will never even know that .git/info/exclude exists.

I don't know if this subtle difference was even intentional. But it
makes sense, and we simply need to make it explicit by documenting
it and by making it optional.

And in many cases, that behavior makes sense. Imagine a generated
file is accidentally added to git, later removed from version
control and added to .gitignore instead. A common scenario, I am
sure.

Now if you start merging, rebasing or bisecting with such a
history, you _will_ run into this problem all the time.

Renaming is certainly a possibility, but it does not really solve
the problem. We will end up with a bunch of renamed, possibly
precious files in our work tree, which means we have to clean up
manually anyways.

So I think it is better to make the decision whether or not a file
is precious at the time it is added to .gitignore. In other words,
never add precious files to .gitignore, but add them to
=2Egit/info/exclude instead.

> And in practice I guess a lot of files will get added to
> .gitignore even though they only are relevant to one user (out of
> carelessness or ignorance). I know I have added patterns without
> making a conscious decision about their relevance to others.

Then you have been using it wrong, just like I have.
Ignorant/careless users may still make that mistake, but if git
does not overwrite such files by default, at least they made a
conscious decision at some point to take that risk.

That is if we can make it the default.

Clemens

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMco+yAAoJELKdZexG8uqMxIUIAIYC5GJoJrgvS4UvdttSIDL+
DvsV1mqCQ4R4m38GZFJFUhqbQ8QPmBZUxdIwtToLI6WSXJrQ/R9WRa0LUuduDTRw
NtzQg8HpgK+vMxQH9+L7x4Xb8W81bikkq5Ba2b5Ed9BJ+Pj++zXsWf7D5twilh8x
sD+OxdsFGNspti3FRGqIXuWebTDkq298Dt3WfE2jfkqu0Ar+zhBdvevKC4sxgwCn
KgVsXI1BC1Y1cDbNmL+xLbVBIQH7LXEWEdkyTbfbDFKfy20Vo8OCQ+Ya2uHGD1lH
t5Qola+V4QEi2V9ZQoRd+rmea8rr0nEbTO6ll/y7k1I5tTFZYhbdqJVij/Cz6KM=
=nfNE
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
