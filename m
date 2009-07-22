From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to prevent Git from compressing certain files?
Date: Wed, 22 Jul 2009 13:44:39 -0700 (PDT)
Message-ID: <m3vdlkbg8x.fsf@localhost.localdomain>
References: <4A676D4B.7040004@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junio@pobox.com>
To: =?iso-8859-14?q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Wed Jul 22 22:45:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTigH-0002dL-4t
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 22:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbZGVUoo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 16:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbZGVUon
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 16:44:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:40705 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbZGVUom convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 16:44:42 -0400
Received: by fg-out-1718.google.com with SMTP id e12so984793fga.17
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 13:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=OntIwIyCHWypvKmZlz1s+Tgnq5ta+4zsO1SL4Ewu+Fo=;
        b=o94OJ+nJclL6EbHmGEUydAzrBtlKPQVXHFB9yRhLssD1fPn+p7u7q53nTPdF0x8QG1
         7Nvx4aOq8V36rADfQxky6w9o2WYy98Ph812bl3Weq9kaqOV7QIaKUiXIPJJeVJ+FZZar
         HXoDnqDXsCLdE1hIURM/0w5yNMUsdXDoG79nk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=tOwwcdQ+khPWJxWvdUi9WSTcwmbBp65E83EHFWwebQ1pCkDs6fplagf7AL7kKrm1xn
         X+MqqKdiKr/YXutYX2wn7N4Am+NZ43/5MjLJ1QbGxd8SHhfzRlsGI72a5/7PqFdHvwOO
         ZBc2my+NnS5BfUf90Pmkcg7Q5fFxfOsu1z8iQ=
Received: by 10.86.86.8 with SMTP id j8mr1143231fgb.70.1248295481031;
        Wed, 22 Jul 2009 13:44:41 -0700 (PDT)
Received: from localhost.localdomain (abvd136.neoplus.adsl.tpnet.pl [83.8.201.136])
        by mx.google.com with ESMTPS id d4sm12141218fga.27.2009.07.22.13.44.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 13:44:39 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6MKi5cr001945;
	Wed, 22 Jul 2009 22:44:15 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6MKhhWw001938;
	Wed, 22 Jul 2009 22:43:43 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A676D4B.7040004@dirk.my1.cc>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123770>

Dirk S=FCsserott <newsletter@dirk.my1.cc> writes:

> I'm (ab)using Git to store my media files, i.e. digicam pictures (*.j=
pg)
> and the like. This way I can e.g. comment a series of pictures withou=
t
> installing and learning a special purpose "Photo Archiving" tool. Git=
k
> shows the roadmap!
>=20
> Somewhere I read that Git isn't supposed to efficiently handle binary
> files. Of course, I don't want to merge my files, just store them wit=
h
> their history and git-push them to some "safe place".
>=20
> I figured that pushing and git gc'ing both try to compress those file=
s
> (or differences) really hard. Works great for "regular" files, but is
> pointless with jpegs.
>=20
> Question: Is there a way to prevent Git from trying to compress certa=
in
> files based on their extension?

There is _undocumented_ "delta" gitattribute, introduced in a74db82
(Teach "delta" attribute to pack-objects., 2007-05-19), which you have
to unset. =20

Like this:

   =3D=3D .gitattributes =3D=3D
   *.jpg   -delta

--=20
Jakub Narebski
Poland
ShadeHawk on #git
