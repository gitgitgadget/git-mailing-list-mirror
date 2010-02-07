From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Sun, 7 Feb 2010 22:08:05 +0100
Message-ID: <201002072208.06627.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <7vock0evs8.fsf@alter.siamese.dyndns.org> <cb7bb73a1002071211n23a410f9icc3d4d29179c44ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 22:08:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeEMf-00060j-JU
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 22:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826Ab0BGVIQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 16:08:16 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:55083 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab0BGVIP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 16:08:15 -0500
Received: by fxm3 with SMTP id 3so6743171fxm.39
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 13:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bzOt7wa1sIencDrt6izxuybWtBisI/Id36ggZP4vNWY=;
        b=SgeSUKhp286dFQoA6zsDl4FGVrlfAqAGqR2/jr2lgoCCk7RPfaaHvyZLtpwfHf0v/L
         MLTUjOV45b7gKB09ukZgEsWseGdi4mK3Gb5PRveSAe5HVC0DLXyGs0NqcNfJGdzdDw0t
         iqfnJD+rrYA6jEaQQ/B0ybh+YPTkIx93KPEWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Otbf9dvRD9RUUAEP82+dZiGF8VbM4dKL5poxwUs7K0cGZoIihKx6LqS+vdP6QmKwEm
         Sa0fKc76YY1PDqG+ymuqcAqjdxwqZSDRT9mONzOhZ6cbjwBUCJeV2xyXXQI3Oc8L62qP
         JCbCwSE0zRaqWbIZjiXPRjDYuILhIImUpon0c=
Received: by 10.223.4.130 with SMTP id 2mr911957far.100.1265576894170;
        Sun, 07 Feb 2010 13:08:14 -0800 (PST)
Received: from ?192.168.1.13? (abvv164.neoplus.adsl.tpnet.pl [83.8.219.164])
        by mx.google.com with ESMTPS id 13sm5589430fks.45.2010.02.07.13.08.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 13:08:11 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a1002071211n23a410f9icc3d4d29179c44ca@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139256>

On Sun, 7 Feb 2010, Giuseppe Bilotta wrote:
> On Sun, Feb 7, 2010 at 7:38 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> >
> > Notes are fundamenally metainformation about an _object_ [*1*] and =
are not
> > metainformation about refs. =A0Since whatever magic notation to den=
ote notes
> > we choose wants to be applied to an arbitrary commit, it shouldn't =
be the
> > at-brace syntax.
>=20
> Makes sense. ^{note[:namespace]} is ok for me too btw, although maybe
> it looks a little off-base when compared with the tag indicator ^{}
> which works, in a sense, in the opposite direction.

Well, notes refer to objects (commits), but the whole idea of notes
was to have easy mapping in the reverse direction, from object to
its annotations.

We could invent yet another syntax, e.g. ^@{} or ^@{<namespace>}
(following ^@ notation for parents, which can also return multiple SHA1=
s).

> > [Footnote]
> >
> > *1* Yes, I am aware of movements to misuse notes to annotate anythi=
ng
> > after mapping it to a random SHA-1 value, but I think that is outsi=
de the
> > scope of notes. =A0Our design decision should be based on supportin=
g the
> > primary use of annotating an object, and that might still keep such=
 a use
> > working, in which case that would be an added bonus. =A0But our des=
ign
> > shouldn't be constrained by such a secondary use.
>=20
> BTW, I still think that notes should be attachable to named refs (not
> SHA-1, thus) too.

I have just realized that it is totally no-go.  Why?  Because names of
refs are local to repository: what is one 'master' might be other 'orig=
in';
what is one 'for-linus' might be other 'from-alan', what's one=20
'refs/heads/next' might be other 'refs/remotes/origin/next'.

Also I think that there would be problem with renaming and deleting ref=
s.

--=20
Jakub Narebski
Poland
