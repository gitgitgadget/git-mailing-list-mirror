From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Do not install shell libraries executable
Date: Sun, 31 Jan 2010 14:00:28 -0600
Message-ID: <20100131200028.GA4045@progeny.tock>
References: <20100129102518.GA5875@coredump.intra.peff.net>
 <20100129103723.GC6025@coredump.intra.peff.net>
 <20100129145025.GA22703@progeny.tock>
 <7vhbq2g3a9.fsf@alter.siamese.dyndns.org>
 <20100131083459.GA18561@progeny.tock>
 <7vy6jecb0y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 21:00:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbfyJ-0001xN-KF
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 21:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab0AaUAe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 15:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753324Ab0AaUAd
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 15:00:33 -0500
Received: from mail-iw0-f173.google.com ([209.85.223.173]:53105 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab0AaUAc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 15:00:32 -0500
Received: by iwn3 with SMTP id 3so3691237iwn.23
        for <git@vger.kernel.org>; Sun, 31 Jan 2010 12:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8sFx7+ZrCRyV3sj1sNPVUqiSgJHH2hXTuWc9ICemTJE=;
        b=d7mOzw5YcXQ+Zor+qpTSFYzKKtIUH6cY/ZuFbamVBC3hacTzXksLN08J+VE6qw5KnL
         yb0qSq5wXkPAWYgOm3zFUwkK6k01g+dCHgJ+IvDVqOAl0RKcnZvyoTKhu/1lz+/N2bZT
         qiNqTZ+cXBpBR8Wu3gifIkjxbe5g8GsEXnsq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EGJFJXpVEiLgwdWir4fYIj5W84JoYTkhNEuOVKZGNpUWD24jDq/67IK5k3M/2L6VI2
         tBZipWxigSTnEcKftJQ2Fl5crDLUQZLqFOiK7kyxYJKetplimvtl1bXperTN/6toCZFN
         FEGQSvNXRZNsld6ebOybw6VdO/LyR+jS+5u5s=
Received: by 10.231.161.143 with SMTP id r15mr3405704ibx.62.1264968032043;
        Sun, 31 Jan 2010 12:00:32 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm4646993iwn.11.2010.01.31.12.00.31
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 12:00:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vy6jecb0y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138557>

Junio C Hamano wrote:

> How much would it hurt the distro packagers, if we don't take this pa=
tch
> before 1.7.0?  If this would help a lot, let's give it a bit higher
> priority and make sure 1.7.0 ships with (a corrected version of) it;
> otherwise I'd say we should not merge this before 1.7.0.

Given that Peff=E2=80=99s fix is in, I don=E2=80=99t think it is needed=
 at all.  So I
would say, better to let it wait.

> > +SCRIPT_LIB_SH +=3D git-mergetool--lib.sh
> > +SCRIPT_LIB_SH +=3D git-parse-remote.sh
> > +SCRIPT_LIB_SH +=3D git-sh-setup.sh
> > + ...
> > @@ -1792,6 +1802,7 @@ install: all
> >  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
> >  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> >  	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> > +	$(INSTALL) -m 644 $(SCRIPT_LIB_SH) '$(DESTDIR_SQ)$(gitexec_instdi=
r_SQ)'
>=20
> I can understand that you didn't want to include the "included script=
lets"
> as part of ALL_PROGRAMS because $(INSTALL) may flip 'x' bit on.
>=20
> But you should then be installing %(patsubst %.sh,%,$(SCRIPT_LIB_SH))=
;
> otherwise, you are installing git-sh-setup.sh and
>=20
>     . git-sh-setup
>=20
> would not work.  Have you ever tested this?

Good catches, sorry. :(  I did test but clearly I was not thinking very
well when I looked at the result...

> Wouldn't it make a bit more sense to do it like this instead?

Yes, that looks right.  Thanks for cleaning up my mess!

Sorry for the trouble,
Jonathan
