From: Robert Schiele <rschiele@gmail.com>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 3 Aug 2007 01:45:15 +0200
Message-ID: <20070802234515.GW29424@schiele.dyndns.org>
References: <85odhpzmbo.fsf@lola.goethe.zz> <7vsl71tyyq.fsf@assigned-by-dhcp.cox.net> <86bqdqkygp.fsf@lola.quinscape.zz> <7vlkctvfk9.fsf@assigned-by-dhcp.cox.net> <85odhpzmbo.fsf@lola.goethe.zz> <20070802214103.GT29424@schiele.dyndns.org> <85vebxy47e.fsf@lola.goethe.zz> <7vwswdsfjp.fsf@assigned-by-dhcp.cox.net> <20070802232126.GU29424@schiele.dyndns.org> <85k5sdy0lk.fsf@lola.goethe.zz>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4WCFFtl4AQpQKunj"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 01:45:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGkM8-00038c-Rh
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 01:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758478AbXHBXpV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 19:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758241AbXHBXpV
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 19:45:21 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:19940 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757780AbXHBXpT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 19:45:19 -0400
Received: by fk-out-0910.google.com with SMTP id z23so547346fkz
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 16:45:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=DHPueOpkZi7wcGnEyVH0hkDN/WV703zAADXZTq5E2dpK9z2773DeKYy9HPjEFpRnwRwJx7snx+P8fC1pRFFCH8VJLbZMbP1Zfm+AsaSsWhCKf/+iWrdVUcpgX8rc/4KW2hZVsH4OyfV786AzKBNIytT97bGge/A46eJL23Mg1Gc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=SwUZAPbumLI1UMCppj7MqPkyoKchUj7wykqL2GVy5lDMOkHOAJh6HfSn6KdCWTMPmIzUOKlVdYWL4gCTPZwKUaItf6JY82Klp41v1hKcvhJQFmSkRU7jzh6I1JxiGdvN48Ew/JpnVMMa0wv8vMxX3j+EBZEw7r5/C0Uz3tD4gSM=
Received: by 10.86.93.17 with SMTP id q17mr1791018fgb.1186098318101;
        Thu, 02 Aug 2007 16:45:18 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.91.135])
        by mx.google.com with ESMTPS id y2sm7827022mug.2007.08.02.16.45.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 16:45:16 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 5856FC112CE; Fri,  3 Aug 2007 01:45:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <85k5sdy0lk.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54646>


--4WCFFtl4AQpQKunj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 03, 2007 at 01:32:07AM +0200, David Kastrup wrote:
> Robert Schiele <rschiele@gmail.com> writes:
> > Well, I have now a patch ready for submission that would replace all
> > occurences of ${PARAMETER#WORD}, ${PARAMETER%WORD}, and $((
> > EXPRESSION )).  But if you say that you won't accept replacement of
> > $( ... ) then this is not worth the effort since this one isn't
> > accepted as well.
>=20
> I absolutely can't understand your claim that most things work for
> you, then.  Are you _really_, _really_ sure you are talking about
> /bin/sh here?

I started wondering myself and it turned out that we just didn't look in the
right place.  Actually we _have_ an infrastructure in place to replace the
shell.  (SHELL_PATH in the Makefile)  In that case I would not consider this
an issue and you might go on with the cleanup from my point of view.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--4WCFFtl4AQpQKunj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGsmyLxcDFxyGNGNcRAn2jAJ9W9JjwacUwQ87hl6dcpv5MLu9QYgCfThlQ
3o45V+xldVhkTMpZVPIODdI=
=aV3A
-----END PGP SIGNATURE-----

--4WCFFtl4AQpQKunj--
