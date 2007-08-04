From: Robert Schiele <rschiele@gmail.com>
Subject: Re: Shell script cleanups/style changes?
Date: Sat, 4 Aug 2007 22:32:20 +0200
Message-ID: <20070804203220.GZ29424@schiele.dyndns.org>
References: <86bqdqkygp.fsf@lola.quinscape.zz> <7vlkctvfk9.fsf@assigned-by-dhcp.cox.net> <85odhpzmbo.fsf@lola.goethe.zz> <7vsl71tyyq.fsf@assigned-by-dhcp.cox.net> <86bqdqkygp.fsf@lola.quinscape.zz> <7vlkctvfk9.fsf@assigned-by-dhcp.cox.net> <85odhpzmbo.fsf@lola.goethe.zz> <20070802214103.GT29424@schiele.dyndns.org> <873ayzojw7.fsf@mid.deneb.enyo.de>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QQ0dNM4HnH4+xgqD"
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Sat Aug 04 22:32:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHQIX-0002c1-VO
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 22:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761400AbXHDUc0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 16:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761536AbXHDUc0
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 16:32:26 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:62777 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761067AbXHDUcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 16:32:25 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1017271fkz
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 13:32:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=eS1FPiIgCTDcfa7RK5bcUGlEdCctMeTK1JNCcWtwDEA66QbM4fHDQisVb+rYsnZvzACIbPyyCnvINRYKAkK/2ilZN9aRk/J776RM7lWzAqhOFETJ6UU5GmN+sVqwg4F1sAKAGDZiqISU53bR4g3u4Xad/Gg1Ge4GH+zidRkTnbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=NLK0fCrwELlznccaevdcvVXAm1CkNkuoxNmypKjGRQKIAiF5XgFRHVH3MJYx3urOb46aodJOjXyV7YIiUjIlxK1z7p8K+wnXCAgqzQrwtVUFhOn7u3ToRgUo2qnGE1fOqkrsTvunRLV9TlvPahdusRrQh6VRxpN13wsG42Uydfs=
Received: by 10.86.50.8 with SMTP id x8mr3214298fgx.1186259543161;
        Sat, 04 Aug 2007 13:32:23 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.78.209])
        by mx.google.com with ESMTPS id o11sm9157249fkf.2007.08.04.13.32.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Aug 2007 13:32:22 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id C54BBC112D4; Sat,  4 Aug 2007 22:32:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <873ayzojw7.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54904>


--QQ0dNM4HnH4+xgqD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 04, 2007 at 09:10:00AM +0200, Florian Weimer wrote:
> * Robert Schiele:
>=20
> >> Sure.  What about the git-rebase line using $(($end - $msgnum)) ?
> >
> > Bad on Solaris:
> >
> > $ uname -a
> > SunOS solaris10-x64 5.10 Generic i86pc i386 i86pc
> > $ end=3D1
> > $ msgnum=3D5
> > $ echo $(($end - $msgnum))
> > syntax error: `(' unexpected
> > $=20
>=20
> Is this with /usr/xpg4/bin/sh or /bin/sh?  The latter is not POSIX and
> should not be used by GIT, IMHO, otherwise there will be endless
> issues in less-well-tested code paths.  Is rewriting the shebang lines
> to use the POSIX shell an option for GIT?

Hi Florian,

I recommend you read the other mails in this thread.  This issue is already
completely resolved.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--QQ0dNM4HnH4+xgqD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGtOJUxcDFxyGNGNcRAkQ/AKDYk8aviAoCZOuOa31jRiUiDcEbxgCg47W7
CEbZqZwe/j6zcrw+5NthvfQ=
=YGYu
-----END PGP SIGNATURE-----

--QQ0dNM4HnH4+xgqD--
